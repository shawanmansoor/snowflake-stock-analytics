USE DATABASE STOCK_ANALYSIS;
USE SCHEMA ANALYTICS;

--to see daily returns on a stock
CREATE OR REPLACE TABLE DAILY_RETURNS AS 
SELECT
   trade_date,
   ticker,
   close_price,
   LAG(close_price) OVER (
    PARTITION BY ticker
    ORDER BY trade_date
   ) AS prev_close,
   (close_price - LAG(close_price) OVER (
      PARTITION BY ticker
      ORDER BY trade_date
   )) 
   / LAG(close_price) OVER (
      PARTITION BY ticker
      ORDER BY trade_date
   ) AS daily_return -- this calculates (today close - yesterday close)/ yesterday close
FROM MODEL.PRICES_DAILY

--validate the contents of the table.
SELECT *
FROM DAILY_RETURNS
WHERE ticker = 'ADBE'
ORDER BY trade_date DESC
LIMIT 10;


