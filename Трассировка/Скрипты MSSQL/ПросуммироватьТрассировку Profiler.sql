select top 100 

    --cast(TextData as nvarchar(max)) as sql_text
    HashSQL as sql_text
    ,sum(CPU) as cpu_time
    ,sum(Reads) as reads
    ,sum(Writes) as writes
    ,sum(Duration) as duration 
    ,sum(RowCounts) as row_count
	,count(*) as executes

from Traces..MyTrace
  
--where sql_text like '%INSERT INTO #tt%'

--group by cast(TextData as nvarchar(max))
group by HashSQL

order by duration desc
--order by cpu_time desc
--order by physical_reads desc