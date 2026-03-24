
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
    s_branches = sorted([row[0] for row in cursor.fetchall()])
    print("Branches in 'students' table:")
    for b in s_branches:
        print(f"  - [{b}]")
    
    cursor.execute("SELECT email, fullName, role, branch FROM users WHERE role='HOD'")
    print("\nAll HODs in 'users' table:")
    for row in cursor.fetchall():
        print(f"  Email: {row[0]}, Name: {row[1]}, Role: {row[2]}, Branch: [{row[3]}]")
        
    conn.close()
except Exception as e:
    print(f"Error: {e}")
