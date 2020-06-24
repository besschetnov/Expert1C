USE DbName  -- устанавливаем текущую базу
SET NOCOUNT ON; -- отключаем вывод количества возвращаемых строк, это несколько ускорит обработку

SET LOCK_TIMEOUT 20000 -- чтобы скрипт не висел бесконечно, если один из индексов заблокирован

DECLARE @FragLimit float = 3.0; -- начиная с какого порога начинаем обрабатывать индексы
--DECLARE @Mode nvarchar(130) = 'REORGANIZE'; -- для ежедневного обслуживания
DECLARE @Mode nvarchar(130) = 'REBUILD '; -- для еженедельного обслуживания

DECLARE @objectid int; -- ID объекта
DECLARE @indexid int; -- ID индекса
DECLARE @partitioncount bigint; -- количество секций если индекс секционирован
DECLARE @schemaname nvarchar(130); -- имя схемы в которой находится таблица
DECLARE @objectname nvarchar(130); -- имя таблицы 
DECLARE @indexname nvarchar(130); -- имя индекса
DECLARE @partitionnum bigint; -- номер секции
DECLARE @frag float; -- процент фрагментации индекса
DECLARE @command nvarchar(4000); -- инструкция T-SQL для дефрагментации либо ренидексации

-- Отбор таблиц и индексов с помощью системного представления sys.dm_db_index_physical_stats
-- Отбор только тех объектов которые являются индексами (index_id > 0), 
-- фрагментация которых более @FragLimit и количество страниц в индексе более 128
SELECT
    object_id AS objectid,
    index_id AS indexid,
    partition_number AS partitionnum,
    avg_fragmentation_in_percent AS frag
INTO #work_to_do
FROM sys.dm_db_index_physical_stats (DB_ID(), null, null, null, 'DETAILED')
WHERE avg_fragmentation_in_percent >= @FragLimit AND index_id > 0 AND page_count > 128;

-- Объявление курсора для чтения секций
DECLARE partitions CURSOR FOR SELECT * FROM #work_to_do;

-- Открытие курсора
OPEN partitions;

-- Цикл по секциям
WHILE (1=1)
    BEGIN;
        FETCH NEXT
           FROM partitions
           INTO @objectid, @indexid, @partitionnum, @frag;
        IF @@FETCH_STATUS < 0 BREAK;
		
-- Собираем имена объектов по ID		
        SELECT @objectname = QUOTENAME(o.name), @schemaname = QUOTENAME(s.name)
        FROM sys.objects AS o
        JOIN sys.schemas as s ON s.schema_id = o.schema_id
        WHERE o.object_id = @objectid;
        SELECT @indexname = QUOTENAME(name)
        FROM sys.indexes
        WHERE  object_id = @objectid AND index_id = @indexid;
        SELECT @partitioncount = count (*)
        FROM sys.partitions
        WHERE object_id = @objectid AND index_id = @indexid;

        SET @command = N'ALTER INDEX ' + @indexname + N' ON ' + @schemaname + N'.' + @objectname + N' ' + @Mode;

        IF @partitioncount > 1
            SET @command = @command + N' PARTITION=' + CAST(@partitionnum AS nvarchar(10));
		
IF @Mode = 'REORGANIZE'
	SET @command = @command + N' WITH (MAXDOP = 0)';
				
IF @Mode = 'REBUILD'
	SET @command = @command + N' WITH (MAXDOP = 0, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = ON)';	

        BEGIN TRY EXEC (@command); END TRY BEGIN CATCH END CATCH
        PRINT N'Executed: ' + @command;
    END;

-- Закрытие курсора
CLOSE partitions;
DEALLOCATE partitions;

-- Удаление временной таблицы
DROP TABLE #work_to_do;
GO
