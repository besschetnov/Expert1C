cat rphost*/*.log | 
grep -P ',CALL,.+,Context=' | 
sed -r 's/\xef\xbb\xbf//g; s/^[0-9]+:[0-9]+.[0-9]+-//; s/CALL,.+,Context=/CALL,Context=/; s/,Memory=.+$//' | 
gawk -F',CALL,' '{{Dur[$2]+=$1; Execs[$2]+=1}} END {for (i in Dur) print Dur[i] "=Duration," Execs[i] "=NumOfExec," i }' | 
sort -rnb | 
head -n 1000  > top_1000_call.txt