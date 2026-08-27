import pandas as pd
import sqlite3
from pathlib import Path

# Find the project folder
project_folder = Path(__file__).resolve().parent.parent

# CSV file location
csv_file = project_folder / "data" / "sales.csv"

# Database location
database_file = project_folder / "sales.db"

# Read CSV
df = pd.read_csv(csv_file)

# Calculate revenue
df["revenue"] = df["quantity"] * df["price"]

# Create SQLite database
connection = sqlite3.connect(database_file)

# Store data as a SQL table
df.to_sql("sales", connection, if_exists="replace", index=False)

connection.close()

print("Database created successfully!")