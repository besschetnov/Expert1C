cat err/rphost_*/*.log | 
gawk -F'Descr=' '{if ($2!~/^$/) errs[$2]+=1}END{for (i in errs) print errs[i] " " i}' |
sort -rnb > errs_total.txt
