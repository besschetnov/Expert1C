select
	partitions.object_id as [Object ID],
	object_name(partitions.object_id) as [Object name],
	partitions.index_id as [Index],
	indexes.name as [Index name]
from
	sys.partitions as partitions
	left join sys.indexes as indexes on partitions.object_id = indexes.object_id
	
where
	partition_id = 72057594167623680


--Lock:Timeout (timeout > 0)	(39eb8c251e6e)				20031000	56	0XBB070000000139EB8C251E6E170007		1378926	7 - KEY	14 - RangeS-U	0	72057594167623680		
