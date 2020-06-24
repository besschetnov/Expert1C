SELECT OBJECT_NAME(p.[object_id]) AS [Object Name], p.index_id, DB_NAME(b.database_id),i.name,
CAST(COUNT(*)/128.0 AS DECIMAL(10, 2)) AS [Buffer size(MB)],  
COUNT(*) AS [BufferCount], p.Rows AS [Row Count],
p.data_compression_desc AS [Compression Type]
FROM sys.allocation_units AS a WITH (NOLOCK)
INNER JOIN sys.dm_os_buffer_descriptors AS b WITH (NOLOCK)
ON a.allocation_unit_id = b.allocation_unit_id
INNER JOIN sys.partitions AS p WITH (NOLOCK)
INNER JOIN sys.indexes AS i ON p.object_id = i.object_id AND p.index_id = i.index_id
ON a.container_id = p.hobt_id
WHERE b.database_id = CONVERT(int,DB_ID())
AND p.[object_id] > 10
GROUP BY p.[object_id], p.index_id, p.data_compression_desc, p.[Rows],DB_NAME(b.database_id),i.name
ORDER BY [BufferCount] DESC OPTION (RECOMPILE);
