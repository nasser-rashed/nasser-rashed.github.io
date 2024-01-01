#! /usr/bin/env python3
import csv

user_input = input()
stock = user_input.split('.')[0]

#with open('stock_data-last3days.csv', newline='') as csvfile:
with open(user_input, newline='') as csvfile:
    reader = csv.reader(csvfile)
    data = []
    for row in reader:
#        print(row)
        data.append(row)


#print(data)
#print ("sublisting ########")

# Sample nested list
nested_list =   [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
nested_list =  data

# Extracting the second and third elements of each nested list
result = [[sublist[1], sublist[2]] for sublist in nested_list]

# Saving the extracted elements in variables
second_elements = [sublist[1] for sublist in nested_list]
third_elements = [sublist[2] for sublist in nested_list]

#print(result)
#print(second_elements)
#print(third_elements)
dayby = result[0]
yesterday = result[1]
today = result[2]
max_dayby = round(float(max(dayby)),2)
max_yesterday = round(float(max(yesterday)),2)
max_today = round(float(max(today)),2)
print (max_dayby,max_yesterday,max_today)
#print (max_yesterday)
#print (max_today)
stat = ""
if max_yesterday < max_dayby and max_today < max_yesterday:
    stat = 'DOWN trend'
    #print('check daily of ', stock)
if max_yesterday < max_dayby and max_today >= max_yesterday:
    stat = 'reversal to Up Side'

if max_yesterday > max_dayby and max_today <= max_yesterday:
    stat = 'reversal to Down Side'
if max_yesterday > max_dayby and max_today > max_yesterday:
    stat = 'UP trend'

#else:
#    stat = 'not good'
print (stock, ' : ', stat)
