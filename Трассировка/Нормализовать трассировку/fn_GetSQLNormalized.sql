use Traces

go

begin try drop function fn_GetSQLNormalized end try begin catch end catch

go

create function fn_GetSQLNormalized(@TSQL nvarchar(max)) returns nvarchar(max) as  

begin 
 
	declare @TmpTableName nvarchar(max) = ''  
	declare @pos int = 0 
 
	set @TSQL = REPLACE ( @TSQL , 'exec sp_executesql N''' , '')  
 
	set @pos = CHARINDEX(''',N''', @TSQL)
	if @pos > 0 set @TSQL = SUBSTRING(@TSQL, 1, @pos - 1)  
     
	while 1=1 

		begin

			set @pos = PATINDEX('%#tt[0-9]%', @TSQL) 

			if @pos > 0 

				begin 
						
					set @TmpTableName = SUBSTRING(@TSQL, @pos, LEN(@TSQL))  
					set @pos = CHARINDEX(' ', @TmpTableName)

					if @pos > 0 set @TmpTableName = SUBSTRING(@TmpTableName, 1, @pos - 1) 

					set @TSQL = REPLACE ( @TSQL , @TmpTableName , '#tt')  

				end  

			else
				break
		end  
      
	return @TSQL;  
      
end  
