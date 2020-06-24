
use Traces

go 

begin try exec('alter table MyTrace add HashSQL nvarchar(max) null') end try begin catch end catch

go

-- версия для Extended Events
update MyTrace set HashSQL = dbo.fn_GetSQLNormalized(case when statement is not null then statement when batch_text is not null then batch_text  else sql_text end)

--go 
-- версия для Profiler
--update MyTrace set HashSQL = dbo.fn_GetSQLNormalized(TextData)


