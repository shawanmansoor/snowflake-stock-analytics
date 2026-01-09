USE DATABASE STOCK_ANALYSIS;
USE SCHEMA SERVE;

CREATE OR REPLACE VIEW FUNDAMENTALS_TICKER AS
    SELECT
      ticker,
      market_cap,
      shares_outstanding,
      float_shares,
      trailing_eps,
      trailing_pe,
      beta,
      COALESCE(dividend_yield,0) AS dividend_yield, -- because NULL doesn't mean missing, means company doesn't pay dividends
      sector,
      industry
    FROM MODEL.FUNDAMENTALS;

SELECT * 
FROM FUNDAMENTALS_TICKER
ORDER BY ticker;