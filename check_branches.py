
import mysql.connector

try:
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="triveni9100@",
        database="placement_cell"
    )
    cursor = conn.cursor()
    cursor.execute("SELECT DISTINCT branch FROM students")
    print("Branches in 'students' table:")
    for row in cursor.fetchall():
        print(f"[{row[0]}]")
    
    cursor.execute("SELECT email, branch FROM users WHERE role='HOD'")
    print("\nBranches assigned to HODs in 'users' table:")
    for row in cursor.fetchall():
        print(f"Email: {row[0]}, Branch: [{row[1]}]")
        
    conn.close()
except Exception as e:
    print(f"Error: {e}")
