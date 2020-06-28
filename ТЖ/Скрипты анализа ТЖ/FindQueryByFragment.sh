cat rphost*/*.log | 
perl -pe '/^p_[0-9]+: /d' | 
perl -pe 's/#tt[0-9]+/#tt/g' |
perl -pe 's/\xef\xbb\xbf//g' |
perl -pe 's/^[0-9]+:[0-9]+\.[0-9]+-[0-9]+,Context,.,Context=/Context=/' |
perl -pe 's/\n/@/g; s/\s/ /; s/^[0-9]+:[0-9]+\.[0-9]+-[0-9]+/\n/' | 
grep -P 'T1._IDRRef' |
uniq -c |
perl -pe 's/@/\n/g; s/DBMSSQL,.,Sql=/Sql=/; s/^\s//' > Query_by_fragments.txt 
