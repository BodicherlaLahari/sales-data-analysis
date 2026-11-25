# Retail Refund Analysis | SQL Server

## Objective
Analyze retail refund records and flag transactions that may need manual review. This is a SQL portfolio case study using a clearly labelled illustrative dataset structure; replace the sample table/data with the actual authorized dataset before presenting numerical findings.

## Tools
- Microsoft SQL Server / T-SQL
- SQL filtering, CASE expressions, date calculations, aggregations and data-quality checks

## Review rules
1. Refund issued more than 10 days after invoice date.
2. Refund payment mode differs from original payment mode.
3. Refund timestamp falls outside store operating hours (09:00–21:00; adjust to the retailer's policy).
4. Item_Returned is not 'Yes'.

## Data required
A table named dbo.RetailRefunds with:
Refund_ID, Emp_ID, Invoice_Date, Refund_DateTime, Refund_Amount, Payment_Mode, Refund_Payment_Mode, Item_Returned.

## Queries
See sql/analysis.sql for the reusable T-SQL checks. The script returns rule-level flags and a consolidated review queue.

## Important
A flagged transaction is an exception for investigation, not proof of fraud or misconduct. Confirm source records, policy, timezone, and business context before drawing conclusions. Do not publish customer-identifiable or confidential company data.
