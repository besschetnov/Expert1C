select sqlserver_start_time from sys.dm_os_sys_info

go

use ooo

select OBJECT_NAME(s.object_id) TabName, i.name IndName, s.last_user_seek, s.user_seeks, s.user_scans, s.user_lookups, s.user_updates ,

( s.user_seeks + s.user_scans + s.user_lookups) as usage 

from sys.dm_db_index_usage_stats as s

join 

sys.indexes as i

on i.object_id = s.object_id
and i.index_id = s.index_id
where

s.user_updates > 0    

 and ( s.user_seeks + s.user_scans + s.user_lookups) = 0

 and db_name(s.database_id) = DB_NAME()

 order by TabName, IndName , usage desc