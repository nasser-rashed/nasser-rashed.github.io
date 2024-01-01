#for stock in $(cut -d "," -f1  stocks_ID.csv)
#do
#    echo $stock.SR | ./pull.py  
#
#done
#echo "sleep 20 second to give time for all files to be downloaded"
#sleep 20
#echo "number of files downloaded *.SR* "
#ls -l *SR*|wc -l 
#for stock in $(cut -d "," -f1  stocks_ID.csv)
#do
#tail -3 $stock.SR > $stock.SR-3days.csv
#done

for stock in $(cut -d "," -f1  stocks_ID.csv)
do
	echo $stock.SR-3days.csv | ./process2.py
done

