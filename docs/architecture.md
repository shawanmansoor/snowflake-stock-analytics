# Architecture Overview

## Project Purpose
This project implements an end-to-end stock analytics system using Snowflake.  
It is designed to transform raw market and fundamentals data into analytics-ready views that can be consumed by BI tools and AI-powered natural language queries (Cortex Analyst).

The architecture follows a layered analytics engineering approach to ensure clarity, scalability, and reuse.

---

## High-Level Flow

INGEST → MODEL → ANALYTICS → SERVE → BI (Power BI) / AI (Cortex Analyst)

---

## Layer Descriptions

### INGEST
The ingest layer is responsible for loading raw stock price and fundamentals data from yfinance library into Snowflake.
These tables closely reflect the source data structure and perform minimal transformations.

**Purpose:**
- Capture raw market and fundamentals data
- Serve as the foundation for downstream modeling

---

### MODEL
The model layer cleans and standardizes ingested data into consistent, well-typed tables.  
This includes enforcing primary identifiers (ticker, date), handling missing values, and aligning schemas.

**Purpose:**
- Normalize raw data
- Create reliable base tables for analytics

---

### ANALYTICS
The analytics layer derives financial metrics and indicators used for analysis and decision-making.  
Examples include returns, technical indicators (RSI), volatility, and portfolio-level calculations.

**Purpose:**
- Perform business logic and calculations
- Encode financial concepts in SQL
- Keep complex logic isolated from reporting

---

### SERVE
The serve layer exposes finalized, analytics-ready views for consumption by downstream tools.  
These views are optimized for ease of use and are the primary inputs for Power BI dashboards and Cortex Analyst.

**Purpose:**
- Provide stable, user-facing datasets
- Enable BI reporting and AI-driven Q&A
- Abstract away implementation details

---

## Consumption

The SERVE views are consumed by:
- Power BI dashboards for visualization and reporting
- Snowflake Cortex Analyst for natural-language analytics

This separation ensures consistent results across tools and simplifies future extensions.
