
import mysql.connector

try:
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="triveni9100@",
        database="placement_cell"
    )
    cursor = conn.cursor()
    cursor.execute("SELECT branch, COUNT(*) FROM students GROUP BY branch")
    print("BRANCHES FOUND:")
    for row in cursor.fetchall():
        print(f"[{row[0]}] : {row[1]}")
    conn.close()
except Exception as e:
    print(f"Error: {e}")
