
import mysql.connector

try:
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="triveni9100@",
        database="placement_cell"
    )
    cursor = conn.cursor()
    
    # 1. Normalize user branches
    mapping = {
        'Computer Science': 'CSE',
        'Electronics': 'ECE',
        'Mechanical': 'MECH',
        'Civil': 'CIVIL',
        'Electrical & Electronics': 'EEE',
        'Metallurgy': 'ECE'
    }
    
    for old, new in mapping.items():
        cursor.execute("UPDATE users SET branch = %s WHERE branch = %s", (new, old))
        print(f"Updated {cursor.rowcount} users from {old} to {new}")

    # 2. Specifically ensure the requested HODs are there with correct names
    # As provided in the previous turn
    hods = [
        ('csehod@sgp.com', 'hod123', 'HOD', 'MD Jaffar', 'CSE'),
        ('ecehod@sgp.com', 'hod123', 'HOD', 'Mr. Nagraj Hugar', 'ECE'),
        ('mechhod@sgp.com', 'hod123', 'HOD', 'Mr. Sayed Assad Basha', 'MECH'),
        ('civilhod@sgp.com', 'hod123', 'HOD', 'Mrs. Tanusha S.M', 'CIVIL'),
        ('eeehod@sgp.com', 'hod123', 'HOD', 'Mr. Irfan Basha', 'EEE')
    ]
    
    for email, password, role, fullName, branch in hods:
        cursor.execute("SELECT id FROM users WHERE email = %s", (email,))
        row = cursor.fetchone()
        if row:
            cursor.execute("UPDATE users SET password=%s, role=%s, fullName=%s, branch=%s WHERE email=%s",
                          (password, role, fullName, branch, email))
            print(f"Updated HOD: {email}")
        else:
            cursor.execute("INSERT INTO users (email, password, role, fullName, branch) VALUES (%s, %s, %s, %s, %s)",
                          (email, password, role, fullName, branch))
            print(f"Inserted HOD: {email}")

    conn.commit()
    conn.close()
    print("\nNormalization complete.")
except Exception as e:
    print(f"Error: {e}")
