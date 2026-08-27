import sqlite3
from pathlib import Path

project_folder = Path(__file__).resolve().parent.parent

database_file = project_folder / "sales.db"
sql_file = project_folder / "sql" / "analysis.sql"

connection = sqlite3.connect(database_file)

query = sql_file.read_text()

print("SQL query being executed:")
print(query)

result = connection.execute(query)

print("\nResult:")

for row in result:
    print(row)

connection.close()