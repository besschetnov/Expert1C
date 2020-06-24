SELECT 

	 qs.session_id
	,blocking_session_id 
	,status
	,[IO] = (reads + logical_reads + writes)
	,cpu_time
	,wait_resource,wait_time,wait_type
	,[Query] = qt.text
	,DatabaseName = DB_NAME(qs.database_id)
	,qp.query_plan

FROM sys.dm_exec_requests qs

OUTER APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt
OUTER APPLY sys.dm_exec_query_plan(qs.plan_handle) as qp

where qs.status in ('running', 'suspended', 'runnable')

ORDER BY [IO] DESC;

--kill 62
