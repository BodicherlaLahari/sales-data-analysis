# sales-data-analysis

# Sales Data Analysis using Python and SQL

## Project Overview

This project analyzes sales data using Python, Pandas, SQLite, and SQL.

The objective is to identify important business insights such as total revenue, top-performing products, customer spending, regional performance, and category performance.

## Technologies Used

- Python
- Pandas
- SQL
- SQLite
- Git
- GitHub

## Dataset

The dataset contains:

- Order ID
- Order Date
- Customer
- Product
- Category
- Quantity
- Price
- Region

## Analysis Performed

### Python Analysis

Using Pandas, the project performs:

- Data loading
- Missing-value checking
- Revenue calculation
- Product analysis
- Customer analysis
- Region analysis
- Category analysis
- Quantity analysis
- Average order value

### SQL Analysis

SQL queries include:

- SELECT
- SUM
- AVG
- WHERE
- GROUP BY
- HAVING
- ORDER BY
- LIMIT
- CASE
- Subqueries
- CTEs
- Window functions

## Key Results

- Total Revenue: ₹178,350
- Highest Revenue Product: Laptop
- Laptop Revenue: ₹115,000
- Highest Revenue Region: South
- South Region Revenue: ₹68,600
- Highest Revenue Customer: Kiran
- Kiran Revenue: ₹62,250

## Project Structure

basic_project/

├── data/

│   └── sales.csv

├── python/

│   ├── analysis.py

│   ├── create_database.py

│   └── run_sql.py

├── sql/

│   └── analysis.sql

├── sales.db

└── README.md

## How to Run

### Install Pandas

```bash
pip install pandas


## Additional Analytics Case Study

### Retail Refund Analysis (SQL Server)
A reusable T-SQL case study that flags delayed refunds, payment-mode mismatches, refunds outside store hours, and missing return confirmation. Includes an exception review query, employee-level summary, and data-quality checks.

- [Case study documentation](retail-refund-analysis/README.md)
- [SQL analysis queries](retail-refund-analysis/sql/analysis.sql)

Note: this case study provides reusable queries and a required source-table schema. It does not include confidential transaction data or claim that flagged records prove fraud.
