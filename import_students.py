import re

def clean_val(val):
    if not val: return None
    val = val.strip()
    if val.upper() in ['NA', 'NO', 'N/A', '-', '', 'FAIL']:
        return None
    return val

def clean_decimal(val):
    if not val: return 0.0
    val = val.replace('%', '').strip()
    try:
        # Try to find digits
        nums = re.findall(r'\d+\.?\d*', val)
        if not nums: return 0.0
        val_float = float(nums[0])
        # Heuristic for marks out of 625/600 etc.
        if val_float > 100 and val_float <= 625:
            return round((val_float / 625) * 100, 2)
        return min(val_float, 100.0)
    except:
        return 0.0

def clean_int(val):
    if not val: return 0
    try:
        nums = re.findall(r'\d+', val)
        return int(nums[0]) if nums else 0
    except:
        return 0

def format_date(val):
    if not val: return '2000-01-01'
    try:
        val = val.strip()
        # Handle dd-mm-yyyy or dd/mm/yyyy
        parts = re.split(r'[-/.]', val)
        if len(parts) == 3:
            d, m, y = parts
            if len(y) == 2: y = "20" + y
            # Sometimes years are 4 digits, but in wrong order? 
            # We assume d-m-y as per data "06-06-2004"
            return f"{y}-{m.zfill(2)}-{d.zfill(2)}"
        return '2000-01-01'
    except:
        return '2000-01-01'

def escape(val):
    if val is None: return "NULL"
    return "'" + str(val).replace("'", "''") + "'"

def clean_phone(val):
    if not val: return None
    nums = "".join(re.findall(r'\d', val.strip()))
    if len(nums) >= 10: return nums[:10]
    return None

with open('student_data.txt', 'r', encoding='utf-8') as f:
    lines = f.readlines()

sql_statements = []
count = 0

for line in lines:
    line = line.strip()
    if not line or "Register No" in line or "Sl no" in line or "SANJAY GANDHI" in line:
        continue
    
    parts = line.split('\t')
    if len(parts) < 20: continue
    
    # Correct indexing for Metallurgy format
    # 0: Sl no, 1: Reg No, 2: Name, 3: Placed Company, 4: Internship, 5: Gender, 6: Branch, 7: Preference...
    reg_no = parts[1].strip()
    name = parts[2].strip()
    placed_company = clean_val(parts[3])
    internship = clean_val(parts[4])
    gender = parts[5].strip()
    branch = parts[6].strip()
    preference = parts[7].strip()
    dob = format_date(parts[8])
    sslc_perc = clean_decimal(parts[9])
    sslc_year = clean_int(parts[10])
    puc_perc = clean_decimal(parts[11])
    puc_year = clean_int(parts[12])
    iti_perc = clean_decimal(parts[13])
    iti_year = clean_int(parts[14])
    sem1 = clean_decimal(parts[15])
    sem2 = clean_decimal(parts[16])
    sem3 = clean_decimal(parts[17])
    sem4 = clean_decimal(parts[18])
    agg_perc = clean_decimal(parts[19])
    backlogs = clean_int(parts[20])
    history = parts[21].strip() if len(parts) > 21 else "No"
    mobile = clean_phone(parts[22]) if len(parts) > 22 else "0000000000"
    alt_mobile = clean_phone(parts[23]) if len(parts) > 23 else None
    email = parts[24].strip() if len(parts) > 24 else f"{reg_no.lower()}@student.com"
    email = email.replace(' ', '') # Fix "gmail. Com"
    address = parts[25].strip() if len(parts) > 25 else ""

    placement_status = 'PLACED' if placed_company else 'UNPLACED'
    cgpa = agg_perc / 10.0 if agg_perc > 0 else 0.0
    if cgpa > 10: cgpa = 10.0

    sql_statements.append(f"INSERT INTO users (email, password, role) VALUES ({escape(email)}, 'password123', 'STUDENT') ON DUPLICATE KEY UPDATE email=VALUES(email);")
    
    cols = "user_id, register_number, full_name, date_of_birth, gender, branch, mobile_number, alternate_number, address, placement_status, placed_company, internship, preference"
    vals = f"(SELECT id FROM users WHERE email={escape(email)}), {escape(reg_no)}, {escape(name)}, {escape(dob)}, {escape(gender)}, {escape(branch)}, {escape(mobile)}, {escape(alt_mobile)}, {escape(address)}, {escape(placement_status)}, {escape(placed_company)}, {escape(internship)}, {escape(preference)}"
    sql_statements.append(f"INSERT INTO students ({cols}) VALUES ({vals}) ON DUPLICATE KEY UPDATE full_name=VALUES(full_name), placement_status=VALUES(placement_status), register_number=VALUES(register_number), mobile_number=VALUES(mobile_number), branch=VALUES(branch), preference=VALUES(preference);")
    
    ac_cols = "student_id, sslc_percentage, sslc_year, puc_percentage, puc_year, iti_percentage, iti_year, sem1, sem2, sem3, sem4, current_backlog_count, history_of_backlogs, cgpa"
    ac_vals = f"(SELECT id FROM students WHERE register_number={escape(reg_no)}), {sslc_perc}, {sslc_year}, {puc_perc}, {puc_year}, {iti_perc}, {iti_year}, {sem1}, {sem2}, {sem3}, {sem4}, {backlogs}, {escape(history)}, {cgpa}"
    sql_statements.append(f"INSERT INTO academic_details ({ac_cols}) VALUES ({ac_vals}) ON DUPLICATE KEY UPDATE cgpa=VALUES(cgpa), current_backlog_count=VALUES(current_backlog_count), history_of_backlogs=VALUES(history_of_backlogs);")
    count += 1

with open('import_students.sql', 'w', encoding='utf-8') as f:
    f.write("USE placement_cell;\n")
    f.write("SET FOREIGN_KEY_CHECKS = 0;\n")
    for stmt in sql_statements:
        f.write(stmt + "\n")
    f.write("SET FOREIGN_KEY_CHECKS = 1;\n")

print(f"DONE. Generated SQL for {count} Metallurgy students.")
