USE DATABASE STOCK_ANALYSIS;
USE SCHEMA SERVE;

CREATE OR REPLACE VIEW LATEST_RECOMMENDATIONS AS 
WITH latest AS (
    SELECT 
      ticker,
      trade_date,
      stop_price_15pct,
      drawdown_from_peak,
      stop_triggered
    FROM ANALYTICS.TRAILING_STOP_15PCT
    QUALIFY ROW_NUMBER() OVER (PARTITION BY ticker ORDER BY trade_date DESC) = 1
)
SELECT
  f.trade_date,
  f.ticker,
  f.close_price,
  f.trend_signal,
  f.rsi_signal,
  f.rsi_14,
  f.volatility_30d,

  w.weight_equal,
  -- w.weight_inv_vol_raw,
  w.weight_inv_vol_capped,

  ls.stop_price_15pct,
  ls.drawdown_from_peak,
  ls.stop_triggered

FROM ANALYTICS.LATEST_FEATURES f
LEFT JOIN ANALYTICS.PORTFOLIO_WEIGHTS w
  ON w.ticker = f.ticker
LEFT JOIN latest ls
  ON ls.ticker = f.ticker
ORDER BY weight_inv_vol_capped DESC;

SELECT * 
FROM LATEST_RECOMMENDATIONS;




    -- Creating second view since I forgot to add the 52 week drawdown
    
CREATE OR REPLACE VIEW LATEST_RECOMMENDATIONS_V2 AS 
WITH latest AS (
    SELECT 
      ticker,
      trade_date,
      stop_price_15pct,
      drawdown_from_peak,
      stop_triggered,
      -- 52 week 
      peak_close_52w,
      drawdown_52w,
      stop_price_15pct_52w,
      stop_triggered_52w
    FROM ANALYTICS.TRAILING_STOP_15PCT
    QUALIFY ROW_NUMBER() OVER (PARTITION BY ticker ORDER BY trade_date DESC) = 1
)
SELECT
  f.trade_date,
  f.ticker,
  f.close_price,
  f.trend_signal,
  f.rsi_signal,
  f.rsi_14,
  f.volatility_30d,

  w.weight_equal,
  -- w.weight_inv_vol_raw,
  w.weight_inv_vol_capped,

  ls.stop_price_15pct,
  ls.drawdown_from_peak,
  ls.stop_triggered,

  --52 week fields
  ls.peak_close_52w,
  ls.drawdown_52w,
  ls.stop_price_15pct_52w,
  ls.stop_triggered_52w

FROM ANALYTICS.LATEST_FEATURES f
LEFT JOIN ANALYTICS.PORTFOLIO_WEIGHTS w
  ON w.ticker = f.ticker
LEFT JOIN latest ls
  ON ls.ticker = f.ticker
ORDER BY weight_inv_vol_capped DESC;

SELECT * 
FROM LATEST_RECOMMENDATIONS;

--validate 2nd view
SELECT *
FROM LATEST_RECOMMENDATIONS_V2