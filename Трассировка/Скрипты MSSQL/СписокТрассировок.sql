SELECT * FROM sys.fn_trace_getinfo(0) -- получить все трассы

SELECT * FROM sys.fn_trace_getinfo(3) -- получить трассу с ID = 3

exec sp_trace_setstatus 3, 1 -- включить трассу с ID = 3
exec sp_trace_setstatus 3, 0 -- выключить трассу с ID = 3



select * from sys.dm_xe_sessions -- посмотреть трассировки Extended events

ALTER EVENT SESSION [session_name] ON SERVER  STATE = START -- запустить трассу Extended events 
ALTER EVENT SESSION [session_name] ON SERVER  STATE = STOP -- остановить трассу Extended events