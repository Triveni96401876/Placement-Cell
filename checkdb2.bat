@echo off
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -ptriveni9100@ placement_cell --silent --raw -e "SELECT student_name, branch FROM job_applications" > d:\Inter\placementcell\app_branches.txt 2>&1
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -ptriveni9100@ placement_cell --silent --raw -e "SELECT email, branch FROM users WHERE role='HOD'" >> d:\Inter\placementcell\app_branches.txt 2>&1
