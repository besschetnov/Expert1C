cat *.log | 
sed -r '/^p_[0-9]+: /d' | 
sed -r 's/#tt[0-9]+/#tt/g' |
sed -r 's/\xef\xbb\xbf//g' |
sed -r 's/^[0-9]+:[0-9]+\.[0-9]+-[0-9]+,Context,.,Context=/Context=/' |
perl -pe 's/\n/@/g; s/\s/ /; s/^[0-9]+:[0-9]+\.[0-9]+-[0-9]+/\n/' | 
grep -P 'T1._IDRRef' |
uniq -c |
perl -pe 's/@/\n/g; s/DBMSSQL,.,Sql=/Sql=/; s/^\s//' > Query_by_fragments.txt 
