# 📈 Stock Price Analytics Platform  
**Snowflake · SQL · Cortex Analyst · Power BI**

## Overview
This project is an **end-to-end stock analytics and decision-support platform** built on Snowflake.  
It combines **market data ingestion, technical analysis, risk management, AI-powered querying, and business intelligence dashboards** to deliver decision-ready insights for portfolio monitoring.

The system is designed to answer both **quantitative questions** (via SQL & BI dashboards) and **natural language questions** (via Snowflake Cortex Analyst).

---

## 🧠 Key Questions This Project Answers
- What is the current **trend, momentum, and risk** of each stock?
- Which stocks are **overbought or oversold** based on RSI?
- Which positions have **triggered or are approaching stop-loss levels**?
- How should portfolio weights change when **volatility shifts**?
- Can users ask **plain-English questions** and receive accurate analytical results?

---

## 🏗️ High-Level Architecture

```
Market Data (yfinance Python library)
↓
Ingest Layer (SQL)
↓
Model Layer (Clean Tables)
↓
Analytics Layer (Indicators & Signals)
↓
Serve Layer (Decision Views)
↓
Cortex Analyst (AI Q&A) + Power BI (Dashboards)
```
---

## 📂 Repository Structure

```
├── assets
│   ├── powerbi
│   │   ├── powerbi_deep_dive_googl.png
│   │   ├── powerbi_deep_dive_nvda.png
│   │   ├── powerbi_deep_dive_tsla.png
│   │   ├── powerbi_overview_01.png
│   │   └── powerbi_overview_02.png
│   └── snowflake
│       ├── cortex_analyst_query.png
│       └── snowflake_layers.png
├── config.py
├── data
│   └── raw
│       ├── daily_metrics.csv
│       └── fundamentals.csv
├── docs
│   ├── architecture.md
│   └── data_dictionary.md
├── LICENSE
├── scripts
│   ├── download_metrics.py
│   └── fundamentals.py
├── semantic_models
│   └── semantic_model.yaml
└── snowflake_sql
    ├── analytics
    │   ├── daily_returns.sql
    │   ├── featured_analytics.sql
    │   ├── moving_avg.sql
    │   ├── portfolio_weights.sql
    │   ├── rsi.sql
    │   ├── stop_loss.sql
    │   └── volatility.sql
    ├── ingest
    │   ├── load_fundamentals.sql
    │   └── load_prices.sql
    ├── model
    │   ├── model_fundamentals.sql
    │   └── model_prices.sql
    ├── semantic.sql
    ├── serve
    │   ├── fundamental_ticker.sql
    │   ├── metrics_daily.sql
    │   └── recommendation.sql
    └── setup.sql
```

---

## 🔄 Data Pipeline Breakdown

### 1️⃣ Ingest Layer
Loads raw market data into Snowflake:
- Daily stock prices
- Company fundamentals (market cap, EPS, beta, sector, industry, dividends)

---

### 2️⃣ Model Layer
Standardizes and cleans raw data:
- Normalized schemas
- Typed numeric fields
- Time-series alignment by ticker and trade date

---

### 3️⃣ Analytics Layer
Computes technical indicators and risk signals:
- **Moving averages (20 / 50 day)**
- **RSI (14-day) with momentum classification**
- **30-day rolling volatility**
- **Trailing stop-loss and drawdown calculations**
- **Volatility-adjusted portfolio weights**

---

### 4️⃣ Serve Layer (Decision Views)
Final views optimized for BI tools and AI querying:
- `METRICS_DAILY` – unified daily technical & risk metrics
- `FUNDAMENTALS_TICKER` – company fundamentals by ticker
- `LATEST_RECOMMENDATIONS` – latest portfolio signals and weights

These views power both **Power BI dashboards** and **Cortex Analyst**.

---

## 🤖 Snowflake Cortex Analyst
Snowflake Cortex Analyst enables **natural-language analytics** using a semantic model built on top of Snowflake views.

### Example Question
> *“Which stock had the lowest RSI in the past 90 days and when did it occur?”*

Cortex Analyst:
1. Interprets user intent
2. Generates SQL automatically
3. Executes the query in Snowflake
4. Returns results with full query transparency

Example screenshots are available in: [assets/snowflake](assets/snowflake)

---

## 📊 Power BI Dashboards

### Portfolio Overview
- Portfolio allocation
- Average drawdown
- Stops triggered
- Oversold / overbought counts
- Top-performing stock

### Deep Dive (Per Ticker)
- Price with moving averages
- RSI and volatility trends
- Risk and stop-loss status
- Company fundamentals

Dashboard screenshots are available in: [assets/powerbi](assets/powerbi)


---

## 🧪 Tools & Technologies
- **Snowflake** (Warehouses, Views, Cortex Analyst)
- **SQL**
- **Power BI**
- **Git & GitHub**
- **Semantic Modeling (YAML)**

---

## 🚀 Why This Project Matters
This project demonstrates:
- End-to-end **data modeling and analytics engineering**
- Practical **risk management logic** applied to market data
- Integration of **AI-powered analytics** with traditional BI reporting tools
- Clear separation of ingest, model, analytics, and serve layers
- Real-world portfolio monitoring use cases

It reflects how modern analytics platforms combine **data engineering, analytics, AI, and visualization** into a single decision system.

---

## 🔮 Future Enhancements
- Automated data refresh scheduling
- Multiple portfolio strategies (risk-on / defensive )
- Performance attribution and return metrics
- Web-based dashboard deployment
- Expanded AI agent workflows for portfolio rebalancing

---

## 📜 License
This project is licensed under the MIT License.



















