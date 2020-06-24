cat rphost*/*.log | 
sed -r '/^p_[0-9]+: /d' | 
perl -pe 's/\xef\xbb\xbf//g; s/\n/@/g; s/\s/ /g; s/^[0-9]+:[0-9]+\.[0-9]+-[0-9]+,Context,.,Context=/,Context=/; s/#tt[0-9]+/#tt/g; s/DBMSSQL,.,.+?,Sql=/DBMSSQLSql=/; s/^[0-9]+:[0-9]+.[0-9]+-/<NL>/' | 
gawk -F'DBMSSQL' -vRS='<NL>' '{if ($2 !~ /^$/) {Dur[$2]+=$1; Execs[$2]+=1}} END {for (i in Dur) printf "%.3f=TotalDurationSec,%.3f=AvgDurationSec,%d=Execs,%s\n", Dur[i]/1000000,(Dur[i]/Execs[i])/1000000,Execs[i],i}' | 
sort -rnb | 
head -n 1000 | 
perl -pe 's/@/\n/g' > top_1000_queries.txt

