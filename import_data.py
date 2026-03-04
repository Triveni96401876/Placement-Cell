import sys
import re
import os

def clean_per(s):
    if not s or s.strip().upper() in ['NA', 'NO', 'FAIL', '-']:
        return 0.0
    s = s.replace('%', '').replace(' ', '').strip()
    try:
        return float(s)
    except:
        match = re.search(r'(\d+\.?\d*)', s)
        if match:
            return float(match.group(1))
        return 0.0

def clean_year(s):
    if not s or s.strip().upper() in ['NA', 'NO', '-']:
        return ''
    return s.strip().replace("'", "''")

def clean_dob(s):
    s = s.strip()
    if not s or s.upper() in ['NA', '-']:
        return '2000-01-01'
    formats = [r'(\d{2})-(\d{2})-(\d{4})', r'(\d{2})/(\d{2})/(\d{4})']
    for fmt in formats:
        match = re.search(fmt, s)
        if match:
            # Reorder to YYYY-MM-DD
            return f"{match.group(3)}-{match.group(2)}-{match.group(1)}"
    return '2000-01-01'

def clean_backlogs(s):
    try:
        return int(s.strip())
    except:
        return 0

input_file = 'C:/placementcell/students_data.txt'
output_file = 'C:/placementcell/import.sql'

with open(output_file, 'w', encoding='utf-8') as sql_file:
    sql_file.write("SET FOREIGN_KEY_CHECKS=0;\n")
    sql_file.write("USE placement_cell;\n")

    if not os.path.exists(input_file):
        print(f"Error: {input_file} not found")
        sys.exit(1)

    with open(input_file, 'r', encoding='utf-8') as f:
        for i, line in enumerate(f):
            if not line.strip(): continue
            cols = line.split('\t')
            # Pad cols to at least 25
            while len(cols) < 25:
                cols.append('')

            reg_no = cols[1].strip()
            if not reg_no or reg_no == 'Register No' or reg_no == 'Register No ': continue
            
            name = cols[2].strip().replace("'", "''")
            company = cols[3].strip().replace("'", "''")
            gender = cols[4].strip()
            branch = cols[5].strip()
            pref = cols[6].strip()
            dob = clean_dob(cols[7])
            sslc_per = clean_per(cols[8])
            sslc_year = clean_year(cols[9])
            puc_per = clean_per(cols[10])
            puc_year = clean_year(cols[11])
            iti_per = clean_per(cols[12])
            iti_year = clean_year(cols[13])
            s1 = clean_per(cols[14])
            s2 = clean_per(cols[15])
            s3 = clean_per(cols[16])
            s4 = clean_per(cols[17])
            total = clean_per(cols[18])
            backlog_count = clean_backlogs(cols[19])
            history = cols[20].strip()
            mobile = cols[21].strip()
            alt = cols[22].strip()
            email = cols[23].strip()
            address = cols[24].strip().replace("'", "''")
            
            pstatus = 'PLACED' if company else 'UNPLACED'

            # User insertion - only existing columns
            sql_file.write(f"INSERT IGNORE INTO users (email, password, role) VALUES ('{email}', '{reg_no}', 'STUDENT');\n")
            sql_file.write(f"SET @uid = (SELECT id FROM users WHERE email = '{email}');\n")
            
            # Student insertion - includes full_name and branch
            sql_file.write(f"INSERT IGNORE INTO students (user_id, register_number, full_name, date_of_birth, gender, branch, mobile_number, alternate_number, address, approval_status, placement_status, placed_company) VALUES (@uid, '{reg_no}', '{name}', '{dob}', '{gender}', '{branch}', '{mobile}', '{alt}', '{address}', 'APPROVED', '{pstatus}', '{company}');\n")
            
            # Academic insertion
            sql_file.write(f"SET @sid = (SELECT id FROM students WHERE user_id = @uid);\n")
            sql_file.write(f"INSERT IGNORE INTO academic_details (student_id, sslc_percentage, sslc_year, puc_percentage, puc_year, iti_percentage, iti_year, sem1, sem2, sem3, sem4, diploma_percentage, current_backlog_count, history_of_backlogs, preference) VALUES (@sid, {sslc_per}, '{sslc_year}', {puc_per}, '{puc_year}', {iti_per}, '{iti_year}', {s1}, {s2}, {s3}, {s4}, {total}, {backlog_count}, '{history}', '{pref}');\n")

    sql_file.write("SET FOREIGN_KEY_CHECKS=1;\n")
    print("SQL generation complete")
