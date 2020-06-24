CREATE EVENT SESSION [Queries_and_plans] ON SERVER 
ADD EVENT sqlserver.adaptive_join_skipped(
    ACTION(sqlserver.database_id,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([sqlserver].[database_id]=(12))),
ADD EVENT sqlserver.additional_memory_grant(
    ACTION(sqlserver.database_id,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([sqlserver].[database_id]=(12))),
ADD EVENT sqlserver.execution_warning(
    ACTION(sqlserver.database_id,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([sqlserver].[database_id]=(12))),
ADD EVENT sqlserver.hash_warning(
    ACTION(sqlserver.database_id,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([sqlserver].[database_id]=(12))),
ADD EVENT sqlserver.missing_join_predicate(
    ACTION(sqlserver.database_id,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([sqlserver].[database_id]=(12))),
ADD EVENT sqlserver.optimizer_timeout(
    ACTION(sqlserver.database_id,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([sqlserver].[database_id]=(12))),
ADD EVENT sqlserver.query_post_execution_showplan(
    ACTION(sqlserver.database_id,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([package0].[greater_than_equal_uint64]([duration],(10)) AND [package0].[equal_uint64]([sqlserver].[database_id],(12)) AND [sqlserver].[session_id]>=(50))),
ADD EVENT sqlserver.rpc_completed(
    ACTION(sqlserver.database_id,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([package0].[greater_than_equal_uint64]([duration],(10)) AND [package0].[equal_uint64]([sqlserver].[database_id],(12)) AND [sqlserver].[session_id]>=(50))),
ADD EVENT sqlserver.sort_warning(
    ACTION(sqlserver.database_id,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([sqlserver].[database_id]=(12))),
ADD EVENT sqlserver.sql_batch_completed(
    ACTION(sqlserver.database_id,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([package0].[greater_than_equal_uint64]([duration],(10)) AND [package0].[equal_uint64]([sqlserver].[database_id],(12)) AND [sqlserver].[session_id]>=(50)))
ADD TARGET package0.event_file(SET filename=N'E:\Queries_and_plans.xel')
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=4 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO

