USE DATABASE STOCK_ANALYSIS;
USE SCHEMA ANALYTICS;

--to determine the ROLLING volatility to pair w/ the beta
CREATE OR REPLACE TABLE VOLATILITY AS 
SELECT
  trade_date,
  ticker,
  STDDEV_SAMP(daily_return) OVER (
    PARTITION BY ticker
    ORDER BY trade_date
    ROWS BETWEEN 29 PRECEDING AND CURRENT ROW --to get 30d volatility
  ) AS volatility_30d
FROM ANALYTICS.DAILY_RETURNS
WHERE daily_return IS NOT NULL;

--vailidation
SELECT * FROM VOLATILITY
WHERE ticker = 'ADBE'
ORDER BY trade_date DESC
LIMIT 10;

