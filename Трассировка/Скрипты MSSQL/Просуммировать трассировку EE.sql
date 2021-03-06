select top 100

      --sql_text as sql_text
      HashSQL as sql_text
     ,sum(duration) as duration
     ,sum(cpu_time) as cpu_time
     ,sum(physical_reads) as physical_reads
     ,sum(logical_reads) as logical_reads
     ,sum(writes) as writes
     ,sum(row_count) as row_count
     ,count(*) as executes

from  Traces..MyTrace 

--where sql_text like '%INSERT INTO #tt%'

group by HashSQL
--group by sql_text

order by duration desc
--order by cpu_time desc
--order by physical_reads desc