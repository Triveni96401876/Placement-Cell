
import mysql.connector

try:
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="triveni9100@",
        database="placement_cell"
    )
    cursor = conn.cursor()
    
    print("--- HOD Branches ---")
    cursor.execute("SELECT email, fullName, branch FROM users WHERE role='HOD'")
    rows = cursor.fetchall()
    for row in rows:
        print(f"Email: {row[0]}")
        print(f"Name:  {row[1]}")
        print(f"Branch: [{row[2]}]")
        print("-" * 20)
        
    print("\n--- Student Branch Counts ---")
    cursor.execute("SELECT branch, COUNT(*) FROM students GROUP BY branch")
    for row in cursor.fetchall():
        print(f"Branch: [{row[0]}], Count: {row[1]}")
        
    conn.close()
except Exception as e:
    print(f"Error: {e}")
