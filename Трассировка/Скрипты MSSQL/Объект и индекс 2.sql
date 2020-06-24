Use Traces
go
select 
	OBJECT_NAME(t2.object_id),
	t3.name
from
	sys.partitions as t2
	inner join sys.indexes as t3
	on t2.object_id = t3.object_id
	and t2.index_id = t3.index_id

	where hobt_id = 72057594041204736

	--KEY: 16:72057594041204736 (24342061670f)