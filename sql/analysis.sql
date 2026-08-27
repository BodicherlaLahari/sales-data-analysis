-- ==========================================
-- SALES DATA ANALYSIS
-- ==========================================


-- 1. View all sales

SELECT *
FROM sales;


-- 2. Total Revenue

SELECT
    SUM(revenue) AS total_revenue
FROM sales;


-- 3. Revenue by Product

SELECT
    product,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY product
ORDER BY total_revenue DESC;


-- 4. Top Product

SELECT
    product,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY product
ORDER BY total_revenue DESC
LIMIT 1;


-- 5. Revenue by Region

SELECT
    region,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY region
ORDER BY total_revenue DESC;


-- 6. Revenue by Customer

SELECT
    customer,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY customer
ORDER BY total_revenue DESC;


-- 7. Quantity Sold by Product

SELECT
    product,
    SUM(quantity) AS total_quantity
FROM sales
GROUP BY product
ORDER BY total_quantity DESC;


-- 8. Revenue by Category

SELECT
    category,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY category
ORDER BY total_revenue DESC;


-- 9. Average Order Value

SELECT
    AVG(revenue) AS average_order_value
FROM sales;


-- 10. Orders from South

SELECT *
FROM sales
WHERE region = 'South';


-- 11. Orders with revenue greater than 10000

SELECT
    order_id,
    product,
    revenue
FROM sales
WHERE revenue > 10000
ORDER BY revenue DESC;


-- 12. Categories with revenue greater than 50000

SELECT
    category,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY category
HAVING SUM(revenue) > 50000
ORDER BY total_revenue DESC;


-- 13. Customer revenue greater than 20000

SELECT
    customer,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY customer
HAVING SUM(revenue) > 20000
ORDER BY total_revenue DESC;


-- 14. Revenue classification using CASE

SELECT
    order_id,
    product,
    revenue,
    CASE
        WHEN revenue >= 50000 THEN 'High'
        WHEN revenue >= 10000 THEN 'Medium'
        ELSE 'Low'
    END AS revenue_category
FROM sales;


-- 15. Monthly revenue

SELECT
    strftime('%Y-%m', order_date) AS month,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY month
ORDER BY month;


-- 16. Second-highest product revenue

SELECT
    product,
    total_revenue
FROM (
    SELECT
        product,
        SUM(revenue) AS total_revenue
    FROM sales
    GROUP BY product
)
ORDER BY total_revenue DESC
LIMIT 1 OFFSET 1;


-- 17. CTE example

WITH product_sales AS (
    SELECT
        product,
        SUM(revenue) AS total_revenue
    FROM sales
    GROUP BY product
)
SELECT *
FROM product_sales
ORDER BY total_revenue DESC;


-- 18. CTE to find products above average revenue

WITH product_sales AS (
    SELECT
        product,
        SUM(revenue) AS total_revenue
    FROM sales
    GROUP BY product
)
SELECT
    product,
    total_revenue
FROM product_sales
WHERE total_revenue >
      (SELECT AVG(total_revenue)
       FROM product_sales);


-- 19. Rank products by revenue

SELECT
    product,
    SUM(revenue) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(revenue) DESC
    ) AS revenue_rank
FROM sales
GROUP BY product;