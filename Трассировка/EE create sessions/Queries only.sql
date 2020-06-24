CREATE EVENT SESSION [QueriesOnly] ON SERVER 
ADD EVENT sqlserver.rpc_completed(
    ACTION(sqlserver.database_id,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([package0].[greater_than_equal_uint64]([duration],(100)) AND [sqlserver].[database_id]=(12))),
ADD EVENT sqlserver.sql_batch_completed(
    ACTION(sqlserver.database_id,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([package0].[greater_than_equal_uint64]([duration],(100)) AND [sqlserver].[database_id]=(12)))
ADD TARGET package0.event_file(SET filename=N'E:\QueriesOnly.xel')
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=4 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO

