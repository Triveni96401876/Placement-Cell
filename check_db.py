
import mysql.connector

try:
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="placement_cell"
    )
    cursor = conn.cursor()
    cursor.execute("DESCRIBE users")
    for row in cursor.fetchall():
        print(row)
    conn.close()
except Exception as e:
    print(e)
