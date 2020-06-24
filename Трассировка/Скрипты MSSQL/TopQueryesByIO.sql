select iq.*,qp.query_plan  from (

SELECT TOP 20  
 [Average IO] = (total_logical_reads + total_logical_writes) / qs.execution_count
,[Total IO] = (total_logical_reads + total_logical_writes)
,[Execution count] = qs.execution_count
,[Individual Query] = SUBSTRING (qt.text,qs.statement_start_offset/2, 
         (CASE WHEN qs.statement_end_offset = -1 
            THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2 
          ELSE qs.statement_end_offset END - qs.statement_start_offset)/2) 
        ,[Parent Query] = qt.text
,DatabaseName = DB_NAME(qt.dbid)
,qs.plan_handle
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt

ORDER BY [Average IO] DESC ) iq
CROSS APPLY sys.dm_exec_query_plan(iq.plan_handle) as qp
