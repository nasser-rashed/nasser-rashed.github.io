# echo 6015.SR|./pull.py  > 6015.SR-3days.csv
# echo 6015.SR-3days.csv | ./process2.py
for stock in $(cut -d "," -f1  stocks_ID.csv); 
do 
    echo "echo $stock.SR | ./pull.py "
done
