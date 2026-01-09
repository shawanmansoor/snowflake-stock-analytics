USE DATABASE STOCK_ANALYSIS;
USE SCHEMA SERVE;

CREATE OR REPLACE VIEW METRICS_DAILY AS
SELECT
  p.trade_date,
  p.ticker,
  p.close_price,

  -- trend of stock
  ma.ma20,
  ma.ma50,
  ts.trend AS trend_signal,

  -- momentum of stock
  r.rsi_14,
  rs.rsi_status AS rsi_signal,

  -- risk of stock
  v.volatility_30d,

  -- exit signal
  sl.peak_close,
  sl.stop_price_15pct,
  sl.drawdown_from_peak,
  sl.stop_triggered

FROM MODEL.PRICES_DAILY p
LEFT JOIN ANALYTICS.MOVING_AVERAGES ma
  ON ma.ticker = p.ticker AND ma.trade_date = p.trade_date
LEFT JOIN ANALYTICS.TREND_SIGNAL ts
  ON ts.ticker = p.ticker AND ts.trade_date = p.trade_date
LEFT JOIN ANALYTICS.RSI_14 r
  ON r.ticker = p.ticker AND r.trade_date = p.trade_date
LEFT JOIN ANALYTICS.RSI_SIGNAL rs
  ON rs.ticker = p.ticker AND rs.trade_date = p.trade_date
LEFT JOIN ANALYTICS.VOLATILITY v
  ON v.ticker = p.ticker AND v.trade_date = p.trade_date
LEFT JOIN ANALYTICS.TRAILING_STOP_15PCT sl
  ON sl.ticker = p.ticker AND sl.trade_date = p.trade_date;

SELECT *
FROM METRICS_DAILY
ORDER BY trade_date DESC
LIMIT 30;