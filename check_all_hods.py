
import mysql.connector

try:
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="triveni9100@",
        database="placement_cell"
    )
    cursor = conn.cursor()
    cursor.execute("SELECT email, role, fullName, branch FROM users WHERE role='HOD'")
    print("ALL HOD users in DB:")
    for row in cursor.fetchall():
        print(row)
    conn.close()
except Exception as e:
    print(f"Error: {e}")
