-- удалить планы по определенной таблице или запросу
SELECT distinct
	'DBCC FREEPROCCACHE(',
	cp.plan_handle,
	')'
FROM
	sys.dm_exec_cached_plans cp
		CROSS APPLY sys.dm_exec_sql_text(cp.plan_handle) t
		CROSS APPLY sys.dm_exec_query_plan(cp.plan_handle) AS qp
WHERE
	t.text LIKE '%select p1, p2 from t1%'
	AND t.dbid = DB_ID('testDB')
