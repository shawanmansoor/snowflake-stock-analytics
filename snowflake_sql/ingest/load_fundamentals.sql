USE DATABASE STOCK_ANALYSIS;
USE SCHEMA INGEST;
CREATE
OR REPLACE TABLE FUNDAMENTAL_INGEST (
    ticker STRING,
    market_cap NUMBER(38, 0),
    shares_outstanding NUMBER(38, 0),
    float_shares NUMBER(38, 0),
    trailing_eps NUMBER(18, 6),
    trailing_pe NUMBER(18, 6),
    beta NUMBER(18, 6),
    dividend_yield NUMBER(18, 6),
    sector STRING,
    industry STRING,
    source_file STRING,
    loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);
COPY INTO FUNDAMENTAL_INGEST (
    ticker,
    market_cap,
    shares_outstanding,
    float_shares,
    trailing_eps,
    trailing_pe,
    beta,
    dividend_yield,
    sector,
    industry,
    source_file
)
FROM
    (
        SELECT
            $1::STRING,
            -- ticker
            $2::NUMBER(38, 0),
            -- market_cap
            $3::NUMBER(38, 0),
            -- shares_outstanding
            $4::NUMBER(38, 0),
            -- float_shares
            $5::NUMBER(18, 6),
            -- trailing_eps
            $6::NUMBER(18, 6),
            -- trailing_pe
            $7::NUMBER(18, 6),
            -- beta
            $8::NUMBER(18, 6),
            -- dividend_yield
            $9::STRING,
            -- sector
            $10::STRING,
            -- industry
            METADATA$FILENAME
        FROM
            @STOCK_STAGE
    ) 

FILE_FORMAT = (FORMAT_NAME = FF_CSV) PATTERN = '.*fundamentals.*\csv' ON_ERROR = 'ABORT_STATEMENT';

SELECT
    COUNT(*) AS rows_loaded,
    COUNT(DISTINCT ticker) AS tickers_loaded
FROM
    FUNDAMENTAL_INGEST;
SELECT
    *
FROM
    FUNDAMENTAL_INGEST
ORDER BY
    ticker
LIMIT
    20;