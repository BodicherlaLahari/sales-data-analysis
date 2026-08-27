import pandas as pd
from pathlib import Path

# Find project folder
project_folder = Path(__file__).resolve().parent.parent

# CSV file path
file_path = project_folder / "data" / "sales.csv"

# Read data
df = pd.read_csv(file_path)

print("=" * 50)
print("SALES DATA ANALYSIS")
print("=" * 50)

# -----------------------------
# 1. Basic information
# -----------------------------

print("\nFirst 5 rows:")
print(df.head())

print("\nDataset shape:")
print(df.shape)

print("\nColumn information:")
print(df.info())

# -----------------------------
# 2. Check missing values
# -----------------------------

print("\nMissing values:")
print(df.isnull().sum())

# -----------------------------
# 3. Calculate revenue
# -----------------------------

df["revenue"] = df["quantity"] * df["price"]

print("\nData with revenue:")
print(df.head())

# -----------------------------
# 4. Total revenue
# -----------------------------

total_revenue = df["revenue"].sum()

print("\nTotal Revenue:", total_revenue)

# -----------------------------
# 5. Revenue by product
# -----------------------------

product_revenue = (
    df.groupby("product")["revenue"]
    .sum()
    .sort_values(ascending=False)
)

print("\nRevenue by Product:")
print(product_revenue)

# -----------------------------
# 6. Top product
# -----------------------------

top_product = product_revenue.idxmax()
top_product_revenue = product_revenue.max()

print("\nTop Product:", top_product)
print("Top Product Revenue:", top_product_revenue)

# -----------------------------
# 7. Revenue by region
# -----------------------------

region_revenue = (
    df.groupby("region")["revenue"]
    .sum()
    .sort_values(ascending=False)
)

print("\nRevenue by Region:")
print(region_revenue)

# -----------------------------
# 8. Top region
# -----------------------------

top_region = region_revenue.idxmax()
top_region_revenue = region_revenue.max()

print("\nTop Region:", top_region)
print("Top Region Revenue:", top_region_revenue)

# -----------------------------
# 9. Revenue by customer
# -----------------------------

customer_revenue = (
    df.groupby("customer")["revenue"]
    .sum()
    .sort_values(ascending=False)
)

print("\nRevenue by Customer:")
print(customer_revenue)

# -----------------------------
# 10. Top customer
# -----------------------------

top_customer = customer_revenue.idxmax()
top_customer_revenue = customer_revenue.max()

print("\nTop Customer:", top_customer)
print("Top Customer Revenue:", top_customer_revenue)

# -----------------------------
# 11. Quantity sold by product
# -----------------------------

product_quantity = (
    df.groupby("product")["quantity"]
    .sum()
    .sort_values(ascending=False)
)

print("\nQuantity Sold by Product:")
print(product_quantity)

# -----------------------------
# 12. Best-selling product
# -----------------------------

best_selling_product = product_quantity.idxmax()
highest_quantity = product_quantity.max()

print("\nBest-Selling Product:", best_selling_product)
print("Quantity Sold:", highest_quantity)

# -----------------------------
# 13. Revenue by category
# -----------------------------

category_revenue = (
    df.groupby("category")["revenue"]
    .sum()
    .sort_values(ascending=False)
)

print("\nRevenue by Category:")
print(category_revenue)

# -----------------------------
# 14. Average order value
# -----------------------------

average_order_value = df["revenue"].mean()

print("\nAverage Order Value:", round(average_order_value, 2))

print("\n" + "=" * 50)
print("ANALYSIS COMPLETED")
print("=" * 50)