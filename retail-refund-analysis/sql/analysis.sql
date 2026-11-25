/*
Retail Refund Analysis - SQL Server (T-SQL)
Expected source: dbo.RetailRefunds
This script assumes Refund_DateTime is stored in the retailer's local time.
Adjust store hours and column names to match the authorized source data.
*/

-- 1. Rule-level exception flags
WITH RefundChecks AS
(
    SELECT
        Refund_ID,
        Emp_ID,
        Invoice_Date,
        Refund_DateTime,
        Refund_Amount,
        Payment_Mode,
        Refund_Payment_Mode,
        Item_Returned,
        DATEDIFF(DAY, Invoice_Date, CAST(Refund_DateTime AS DATE))
            AS Days_To_Refund,
        CASE
            WHEN DATEDIFF(DAY, Invoice_Date, CAST(Refund_DateTime AS DATE)) > 10
            THEN 1 ELSE 0
        END AS Late_Refund_Flag,
        CASE
            WHEN ISNULL(Payment_Mode, '') <> ISNULL(Refund_Payment_Mode, '')
            THEN 1 ELSE 0
        END AS Payment_Mode_Mismatch_Flag,
        CASE
            WHEN CAST(Refund_DateTime AS TIME) < '09:00:00'
              OR CAST(Refund_DateTime AS TIME) >= '21:00:00'
            THEN 1 ELSE 0
        END AS Outside_Store_Hours_Flag,
        CASE
            WHEN ISNULL(Item_Returned, '') <> 'Yes'
            THEN 1 ELSE 0
        END AS Item_Not_Returned_Flag
    FROM dbo.RetailRefunds
)
SELECT
    *,
    Late_Refund_Flag
      + Payment_Mode_Mismatch_Flag
      + Outside_Store_Hours_Flag
      + Item_Not_Returned_Flag AS Total_Exception_Count
FROM RefundChecks
WHERE Late_Refund_Flag = 1
   OR Payment_Mode_Mismatch_Flag = 1
   OR Outside_Store_Hours_Flag = 1
   OR Item_Not_Returned_Flag = 1
ORDER BY Total_Exception_Count DESC, Refund_DateTime DESC;


-- 2. Employee-level summary for prioritizing manual review
SELECT
    Emp_ID,
    COUNT(*) AS Refund_Count,
    SUM(Refund_Amount) AS Total_Refund_Amount,
    SUM(CASE
        WHEN DATEDIFF(DAY, Invoice_Date, CAST(Refund_DateTime AS DATE)) > 10
        THEN 1 ELSE 0 END) AS Late_Refund_Count,
    SUM(CASE
        WHEN ISNULL(Payment_Mode, '') <> ISNULL(Refund_Payment_Mode, '')
        THEN 1 ELSE 0 END) AS Payment_Mode_Mismatch_Count,
    SUM(CASE
        WHEN CAST(Refund_DateTime AS TIME) < '09:00:00'
          OR CAST(Refund_DateTime AS TIME) >= '21:00:00'
        THEN 1 ELSE 0 END) AS Outside_Hours_Count,
    SUM(CASE
        WHEN ISNULL(Item_Returned, '') <> 'Yes'
        THEN 1 ELSE 0 END) AS Item_Not_Returned_Count
FROM dbo.RetailRefunds
GROUP BY Emp_ID
ORDER BY Total_Refund_Amount DESC;


-- 3. Data-quality checks
SELECT
    COUNT(*) AS Total_Records,
    SUM(CASE WHEN Refund_ID IS NULL THEN 1 ELSE 0 END) AS Missing_Refund_ID,
    SUM(CASE WHEN Emp_ID IS NULL THEN 1 ELSE 0 END) AS Missing_Employee_ID,
    SUM(CASE WHEN Refund_DateTime < Invoice_Date THEN 1 ELSE 0 END)
        AS Refund_Before_Invoice,
    SUM(CASE WHEN Refund_Amount < 0 THEN 1 ELSE 0 END) AS Negative_Refund_Amount
FROM dbo.RetailRefunds;
