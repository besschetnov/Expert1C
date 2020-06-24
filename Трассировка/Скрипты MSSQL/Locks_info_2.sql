use Traces

go

select 
	case t1.resource_type
		when 'OBJECT'
		then OBJECT_NAME(t2.object_id)
	end as objectname,
	t3.name as indexname,
	*
from sys.dm_tran_locks as t1
	left join sys.partitions as t2
		on t1.resource_associated_entity_id = t2.hobt_id
	left join sys.indexes as t3
		on t2.object_id = t3.object_id
		and t2.index_id = t3.index_id

go 

select 
	%%lockres%% as res,
	*
from 
	_123 with (index(PK___123__AAAC09D87EC4F8B2) nolock)
where 
	%%lockres%% like '%40fd182c0dd9%' -- взять из скрипта выше, resourse_description
--(ad3225e45be9)                                                                                                                                                                                                                                                  
-- (24342061670f)                                                                                                                                                                                                                                                  
-- (40fd182c0dd9)                                                                                                                                                                                                                                                  