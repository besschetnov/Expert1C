cat err/rphost_*/*.log | 
sed -r '/^HRESULT=/d; /descr=recv returns zero/d' | 
sed -r 's/[0-9]+:[0-9]+.[0-9]+-[0-9]+,Context,/,Context,/;  s/,Context,.+,Context=/,Context=/; s/Transaction.+was deadlocked/Transaction was deadlocked/; s/[0-9]+:[0-9]+.[0-9]+-/<NL>/; s/\(идентификатор процесса [0-9]+\) //; s/Повторяющееся значение ключа: \(.+\)/Повторяющееся значение ключа:/; s/.{8,8}-.{4,4}-.{4,4}-.{4,4}-.{12,12}//' | 
gawk -F'Descr=' -vRS='<NL>' '{if ($2~"Cеанс отсутствует или удален") $2="Сеанс отсутствует или удален"; if ($2~"Сеанс работы завершен администратором") $2="Сеанс работы завершен администратором"; if ($2!~"Файл не обнаружен" && $2!~"Ошибка совместного доступа к файлу" && $2!~"Активны сеансы" && $2!~/^$/) errs[$2]+=1}END{for (i in errs) print "<NL>" errs[i] " " i}' | 
sed -r 's/\s/ /g' | 
sed -r /^$/d | 
tr '\n' '@' | 
sed -r 's/<NL>/\n/g' | 
sort -rnb | 
head -n 1000 | 
sed -r 's/@/\n/g' > errs_detailed.txt