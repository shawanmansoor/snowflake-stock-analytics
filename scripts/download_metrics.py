import yfinance as yf
import pandas as pd
from config import TICKERS, START_DATE

# establish where the output will be
OUTPUT_CSV = "data/raw/daily_metrics.csv"

# pull metrics from yfinance into dataframe
df = yf.download(
    tickers = TICKERS,
    start = START_DATE,
    group_by="ticker",
    auto_adjust=False,
    actions=False,
    threads=True
)

# establish readable table
rows = []
for t in TICKERS:
    tdf = df[t].reset_index()
    tdf["ticker"] = t 
    tdf = tdf.rename(columns={
        "Date": "trade_date", 
        "Open": "open_price", 
        "High": "high_price", 
        "Low": "low_price", 
        "Close": "close_price", 
        "Adj Close": "adj_close", 
        "Volume": "volume" })
    
    rows.append(tdf[[ "trade_date","ticker","open_price","high_price",
                     "low_price", "close_price","adj_close","volume" ]])
    
    
prices = pd.concat(rows, ignore_index=True) 
prices["ticker"] = prices["ticker"].str.upper()  

prices.to_csv(OUTPUT_CSV, index=False)