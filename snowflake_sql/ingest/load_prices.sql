USE WAREHOUSE COMPUTE_WH;
USE DATABASE STOCK_ANALYSIS;
USE SCHEMA INGEST;
CREATE
OR REPLACE TABLE DAILY_PRICES_INGEST (
    trade_date DATE,
    ticker STRING,
    open_price NUMBER(18, 4),
    high_price NUMBER(18, 4),
    low_price NUMBER(18, 4),
    close_price NUMBER(18, 4),
    adj_close NUMBER(18, 4),
    volume NUMBER(20, 0),
    source_file STRING,
    loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);
COPY INTO DAILY_PRICES_INGEST (
    trade_date,
    ticker,
    open_price,
    high_price,
    low_price,
    close_price,
    adj_close,
    volume,
    source_file
)
FROM
    (
        SELECT
            $1::DATE,
            $2::STRING,
            $3::NUMBER(18, 4),
            $4::NUMBER(18, 4),
            $5::NUMBER(18, 4),
            $6::NUMBER(18, 4),
            $7::NUMBER(18, 4),
            $8::NUMBER(20, 0),
            METADATA$FILENAME
        FROM
            @STOCK_STAGE
    ) FILE_FORMAT = (FORMAT_NAME = FF_CSV) PATTERN = '.*daily_metrics.*\csv' ON_ERROR = 'ABORT_STATEMENT';


-- 3) Validate
SELECT
    COUNT(*) AS rows_loaded,
    COUNT(DISTINCT ticker) AS tickers_loaded
FROM
    DAILY_PRICES_INGEST;
SELECT
    *
FROM
    DAILY_PRICES_INGEST
ORDER BY
    trade_date DESC
LIMIT
    12;