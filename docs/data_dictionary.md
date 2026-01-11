# Data Dictionary

This document describes the analytics-ready views exposed in the SERVE layer.  
These views are intended for BI tools and AI-driven analysis.

---

## View: metrics_daily

Daily, analytics-ready metrics for each stock ticker, combining price data, trend, momentum, risk, and exit signals.  
This view is designed for downstream BI dashboards and AI-driven analysis.

| Column Name | Description |
|------------|------------|
| `trade_date` | Trading date for the observation |
| `ticker` | Stock ticker symbol |
| `close_price` | Closing price of the stock on the given trading date |
| `ma20` | 20-day moving average of the closing price |
| `ma50` | 50-day moving average of the closing price |
| `trend_signal` | Trend classification based on moving average behavior (e.g., bullish, bearish) |
| `rsi_14` | 14-day Relative Strength Index (RSI) |
| `rsi_signal` | RSI-based momentum signal (e.g., oversold, neutral, overbought) |
| `volatility_30d` | Rolling 30-day volatility measure |
| `peak_close` | Highest closing price observed in the trailing period |
| `stop_price_15pct` | Stop-loss price calculated at 15% below the peak close |
| `drawdown_from_peak` | Percentage drawdown from the peak closing price |
| `stop_triggered` | Boolean flag indicating whether the stop-loss condition has been triggered |

---

## View: fundamental_ticker

Latest available fundamental metrics for each stock ticker.  
This view provides a snapshot of valuation, risk, and company classification attributes and is intended for portfolio analysis, BI reporting, and AI-driven queries.

| Column Name | Description |
|------------|------------|
| `ticker` | Stock ticker symbol |
| `market_cap` | Total market capitalization of the company |
| `shares_outstanding` | Total number of shares outstanding |
| `float_shares` | Number of shares available for public trading |
| `trailing_eps` | Earnings per share based on the trailing twelve months |
| `trailing_pe` | Price-to-earnings ratio based on trailing earnings |
| `beta` | Measure of the stock’s volatility relative to the overall market |
| `dividend_yield` | Annual dividend yield; set to 0 for companies that do not pay dividends |
| `sector` | Market sector classification |
| `industry` | Industry classification within the sector |


---

## View: latest_recommendations_v2`

Latest portfolio-level signals and risk indicators for each stock ticker.  
This view consolidates trend, momentum, volatility, portfolio weights, and stop-loss logic into a single, decision-ready dataset.  
It is intended to support portfolio monitoring, ranking, and AI-driven investment insights.

| Column Name | Description |
|------------|------------|
| `trade_date` | Most recent trading date used for the recommendation snapshot |
| `ticker` | Stock ticker symbol |
| `close_price` | Latest closing price of the stock |
| `trend_signal` | Trend classification derived from technical indicators (e.g., bullish, bearish) |
| `rsi_signal` | Momentum signal derived from RSI (e.g., oversold, neutral, overbought) |
| `rsi_14` | 14-day Relative Strength Index value |
| `volatility_30d` | Rolling 30-day volatility measure |
| `weight_equal` | Equal-weight allocation for the portfolio |
| `weight_inv_vol_capped` | Inverse-volatility portfolio weight with caps applied |
| `stop_price_15pct` | Stop-loss price set at 15% below the recent peak |
| `drawdown_from_peak` | Percentage drawdown from the recent peak close |
| `stop_triggered` | Indicates whether the 15% trailing stop has been triggered |
| `peak_close_52w` | Highest closing price over the past 52 weeks |
| `drawdown_52w` | Percentage drawdown from the 52-week peak |
| `stop_price_15pct_52w` | 15% stop-loss price based on the 52-week peak |
| `stop_triggered_52w` | Indicates whether the 52-week stop-loss has been triggered |
