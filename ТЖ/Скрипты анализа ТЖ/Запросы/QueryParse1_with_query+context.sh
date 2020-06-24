cat rphost*/*.log | 
sed -r '/^p_[0-9]+: /d' | 
sed -r 's/\xef\xbb\xbf//g; s/^[0-9]+:[0-9]+\.[0-9]+-[0-9]+,Context,.,Context=/,Context=/; s/#tt[0-9]+/#tt/g; s/DBMSSQL,.,/DBMSSQL/; s/^[0-9]+:[0-9]+.[0-9]+-/<LineBreak>/' | 
gawk -F'DBMSSQL' -vRS='<LineBreak>' '{if ($2 !~ /^$/) {Dur[$2]+=$1; Execs[$2]+=1}} END {for (i in Dur) print "<NewLine>" Dur[i] "=Duration," Execs[i] "=NumOfExec," i }' | 
sed -r 's/\s/ /g' | 
sed -r /^$/d | 
tr '\n' '@' | 
sed -r 's/<NewLine>/\n/g' | 
sort -rnb | 
head -n 1000 | 
sed -r 's/@/\n/g' > top_1000_queries.txt