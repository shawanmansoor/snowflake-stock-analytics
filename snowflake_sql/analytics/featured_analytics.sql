USE DATABASE STOCK_ANALYSIS;
USE SCHEMA ANALYTICS;

CREATE OR REPLACE TABLE LATEST_FEATURES AS
WITH latest_price AS (
  SELECT
    ticker,
    trade_date,
    close_price
  FROM MODEL.PRICES_DAILY
  QUALIFY ROW_NUMBER() OVER (
    PARTITION BY ticker
    ORDER BY trade_date DESC
  ) = 1
)
SELECT
  lp.trade_date,
  lp.ticker,
  lp.close_price,

  -- Moving averages / trend
  tr.ma20,
  tr.ma50,
  tr.trend AS trend_signal,

  -- RSI / momentum
  rs.rsi_14,
  rs.rsi_status AS rsi_signal,

  -- Volatility / risk
  v.volatility_30d,

  -- Fundamentals
  f.market_cap,
  f.trailing_eps,
  f.trailing_pe,
  f.beta,
  f.dividend_yield,
  f.sector,
  f.industry

FROM latest_price lp

LEFT JOIN ANALYTICS.TREND_SIGNAL tr
  ON tr.ticker = lp.ticker
 AND tr.trade_date = lp.trade_date

LEFT JOIN ANALYTICS.RSI_SIGNAL rs
  ON rs.ticker = lp.ticker
 AND rs.trade_date = lp.trade_date

LEFT JOIN ANALYTICS.VOLATILITY v
  ON v.ticker = lp.ticker
 AND v.trade_date = lp.trade_date

LEFT JOIN MODEL.FUNDAMENTALS f
  ON f.ticker = lp.ticker;

--quick validation 
SELECT *
FROM LATEST_FEATURES
ORDER BY ticker;