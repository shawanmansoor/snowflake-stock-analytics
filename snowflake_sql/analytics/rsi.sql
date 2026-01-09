USE DATABASE STOCK_ANALYSIS;
USE SCHEMA ANALYTICS;

CREATE OR REPLACE TABLE RSI_14 AS 
WITH base AS (
   SELECT
   trade_date,
   ticker,
   close_price,
   close_price - LAG(close_price) OVER (
   PARTITION BY ticker
   ORDER BY trade_date
   ) AS price_change
FROM MODEL.PRICES_DAILY
),
gains_losses AS (
    SELECT
    trade_date,
    ticker,
    close_price,
    IFF(price_change > 0, price_change, 0) AS gain,
    IFF(price_change < 0, ABS(price_change), 0) AS loss
  FROM base
 ),
 roll AS (
 SELECT 
 trade_date,
 ticker,
 close_price,
 AVG(gain) OVER (
     PARTITION BY ticker
     ORDER BY trade_date
     ROWS BETWEEN 13 PRECEDING AND CURRENT ROW
 ) AS avg_gain,
 AVG(loss) OVER (
     PARTITION BY ticker
     ORDER BY trade_date
     ROWS BETWEEN 13 PRECEDING AND CURRENT ROW
 ) AS avg_loss
FROM gains_losses
)
SELECT
  trade_date,
  ticker,
  close_price,
  avg_gain,
  avg_loss,
  IFF(
    avg_loss = 0,
    100,
    100 - (100 / (1 + (avg_gain / NULLIF(avg_loss, 0))))
  ) AS rsi_14
FROM roll;

SELECT * 
FROM RSI_14
WHERE ticker = 'ORCL'
ORDER BY trade_date DESC
LIMIT 15;

--view to see if overbought or oversold
CREATE OR REPLACE VIEW RSI_SIGNAL AS
SELECT
   trade_date,
   ticker,
   rsi_14,
   CASE 
     WHEN rsi_14 IS NULL THEN NULL
     WHEN rsi_14 >= 70 THEN 'OVERBOUGHT'
     WHEN rsi_14 <= 30 THEN 'OVERSOLD'
        ELSE 'NEUTRAL'
    END AS rsi_status
FROM RSI_14;

SELECT *
FROM RSI_SIGNAL 
WHERE ticker = 'TSLA'
ORDER BY trade_date DESC
LIMIT 15;

