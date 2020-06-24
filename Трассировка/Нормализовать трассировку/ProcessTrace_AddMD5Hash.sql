use Traces

go

begin try exec('alter table MyTrace add HashSQLMD5 varbinary(32) null') end try begin catch end catch

go

update  MyTrace set HashSQLMD5 = HashBytes('MD5', HashSQL);
