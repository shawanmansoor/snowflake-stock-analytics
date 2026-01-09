USE DATABASE STOCK_ANALYSIS;
USE SCHEMA MODEL;


-- create table for daily prices, the backbone for analytics layer
CREATE OR REPLACE TABLE PRICES_DAILY AS
SELECT
  trade_date,
  UPPER(ticker) AS ticker,
  open_price,
  high_price,
  low_price,
  close_price,
  adj_close,
  volume
FROM INGEST.DAILY_PRICES_INGEST
WHERE trade_date IS NOT NULL
  AND ticker IS NOT NULL
  AND close_price IS NOT NULL
  AND trade_date <> '2025-12-23'; --taking out this date bc some companies didn't have their prices up on the market yet.

-- quick validation
SELECT COUNT(*) AS row_count, COUNT(DISTINCT ticker) AS tickers, 
FROM PRICES_DAILY;

-- specifics to check
SELECT *
FROM PRICES_DAILY
ORDER BY trade_date DESC
LIMIT 20;
