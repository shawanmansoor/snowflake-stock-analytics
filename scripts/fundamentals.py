import yfinance as yf
import pandas as pd
from config import TICKERS, START_DATE

rows = []

for t in TICKERS:
    ticker = yf.Ticker(t)
    info = ticker.info

    rows.append({
        "ticker": t,
        "market_cap": info.get("marketCap"),
        "shares_outstanding": info.get("sharesOutstanding"),
        "float_shares": info.get("floatShares"),
        "trailing_eps": info.get("trailingEps"),
        "trailing_pe": info.get("trailingPE"),
        "beta": info.get("beta"),
        "dividend_yield": info.get("dividendYield"),
        "sector": info.get("sector"),
        "industry": info.get("industry")
    })
        

fundamentals = pd.DataFrame(rows)
fundamentals["ticker"] = fundamentals["ticker"].str.upper()

fundamentals.to_csv("data/raw/fundamentals.csv", index=False)



