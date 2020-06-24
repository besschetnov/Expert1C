
SELECT
 	db.name,
	a.session_id,
	a.blocking_session_id,
	a.transaction_id,
    a.cpu_time,
    a.reads,
    a.writes,
    a.logical_reads,
	a.row_count,
    a.start_time,
    a.[status],
	--case a.transaction_isolation_level
	--	when 1 then 'ReadUncomitted'
	--	when 2 then 'ReadCommitted'
	--	when 3 then 'Repeatable'
	--	when 4 then 'Serializable'
	--	when 5 then 'Snapshot'
	--end УровеньИзоляции,
    a.wait_time,
    a.wait_type,
    a.last_wait_type,
    a.wait_resource,
    a.total_elapsed_time,
    st.text,
    qp.query_plan,
	p.loginame [loginame сессии вызвавшей блокировку],
	p.program_name [Приложение сессии вызвавшей блокировку],
	p.login_time [Время входа сессии вызвавшей блокировку],
	p.last_batch [Время последнего запроса сессии вызвавшей блокировку],
	p.hostname [Host Name сессии вызвавшей блокировку],
	stblock.text [Текущий(!) запрос сессии вызвавшей блокировку]

FROM sys.dm_exec_requests a
    OUTER APPLY sys.dm_exec_sql_text(a.sql_handle) AS st
	OUTER APPLY sys.dm_exec_query_plan(a.plan_handle) AS qp
	LEFT JOIN sys.sysprocesses p
		OUTER APPLY sys.dm_exec_sql_text(p.sql_handle) AS stblock
	on a.blocking_session_id > 0 and a.blocking_session_id = p.spid
	LEFT JOIN sys.databases db
	ON a.database_id = db.database_id

WHERE	not a.status in ('background', 'sleeping')
	--blocking_session_id <> 0

ORDER BY
       a.cpu_time DESC