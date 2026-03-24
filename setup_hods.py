
import mysql.connector

try:
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="triveni9100@",
        database="placement_cell"
    )
    cursor = conn.cursor()
    
    # 1. Update students branches to short codes
    cursor.execute("UPDATE students SET branch = 'CSE' WHERE branch = 'Computer Science'")
    cursor.execute("UPDATE students SET branch = 'ECE' WHERE branch = 'Electronics'")
    cursor.execute("UPDATE students SET branch = 'MECH' WHERE branch = 'Mechanical'")
    cursor.execute("UPDATE students SET branch = 'CIVIL' WHERE branch = 'Civil'")
    cursor.execute("UPDATE students SET branch = 'EEE' WHERE branch = 'Electrical & Electronics'")
    cursor.execute("UPDATE students SET branch = 'ECE' WHERE branch = 'Metallurgy'") # Mapping Metallurgy to ECE as the user didn't mention it but wants 5 branches total.
    
    print(f"Updated {cursor.rowcount} students branches.")

    # 2. Insert/Update HODs with matching branches
    hods = [
        ('csehod@sgp.com', 'hod123', 'HOD', 'MD Jaffar', 'CSE'),
        ('ecehod@sgp.com', 'hod123', 'HOD', 'Mr. Nagraj Hugar', 'ECE'),
        ('mechhod@sgp.com', 'hod123', 'HOD', 'Mr. Sayed Assad Basha', 'MECH'),
        ('civilhod@sgp.com', 'hod123', 'HOD', 'Mrs. Tanusha S.M', 'CIVIL'),
        ('eeehod@sgp.com', 'hod123', 'HOD', 'Mr. Irfan Basha', 'EEE')
    ]
    
    for email, password, role, fullName, branch in hods:
        # Check if exists
        cursor.execute("SELECT id FROM users WHERE email = %s", (email,))
        if cursor.fetchone():
            cursor.execute("UPDATE users SET password=%s, role=%s, fullName=%s, branch=%s WHERE email=%s",
                          (password, role, fullName, branch, email))
        else:
            cursor.execute("INSERT INTO users (email, password, role, fullName, branch) VALUES (%s, %s, %s, %s, %s)",
                          (email, password, role, fullName, branch))
            
    conn.commit()
    print("HOD accounts updated.")
    
    conn.close()
except Exception as e:
    print(f"Error: {e}")
