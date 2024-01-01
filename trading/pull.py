#! /usr/bin/env python3
import yfinance as yf
import pandas as pd

# Replace 'AAPL' with the desired stock symbol
#stock_symbol = '6015.SR'
user_input = input()
stock_symbol = user_input

# Fetch stock data for the specified stock symbol
stock_data = yf.download(stock_symbol)

# Save the stock data to a CSV file
#stock_data.to_csv('stock_data.csv')
stock_data.to_csv(stock_symbol)

# Close the stock data object
#stock_data.close()
