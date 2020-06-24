SELECT TOP 100
	p.dbid,
	db_name(p.dbid),

    t.text
	,p.query_plan
	,s.*

FROM sys.dm_exec_query_stats s

OUTER APPLY sys.dm_exec_sql_text(s.sql_handle)  t
OUTER APPLY sys.dm_exec_query_plan(s.plan_handle)  p

where p.dbid = 6

--where last_execution_time >= '2017-04-19 14:00:00.000'

order by total_worker_time desc

