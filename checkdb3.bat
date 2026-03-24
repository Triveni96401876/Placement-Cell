@echo off
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -ptriveni9100@ placement_cell -e "SELECT student_name, branch FROM job_applications; SELECT email, branch FROM users WHERE role='HOD';" 2>&1
