USE DATABASE STOCK_ANALYSIS;
USE SCHEMA MODEL;

-- create common fundamental table 

CREATE OR REPLACE TABLE FUNDAMENTALS AS 
SELECT
  UPPER(ticker) AS ticker,
  market_cap,
  shares_outstanding,
  float_shares,
  trailing_eps,
  trailing_pe,
  beta,
  dividend_yield,
  sector,
  industry
FROM INGEST.FUNDAMENTAL_INGEST
WHERE ticker IS NOT NULL;

SELECT COUNT(*) AS row_count, COUNT(DISTINCT ticker) AS tickers
FROM MODEL.FUNDAMENTALS;

SELECT *
FROM FUNDAMENTALS
ORDER BY ticker DESC;
