@echo off
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -ptriveni9100@ placement_cell -e "SHOW COLUMNS FROM users;" > d:\Inter\placementcell\col_out.txt 2>&1
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -ptriveni9100@ placement_cell -e "SELECT id, email, role, branch FROM users WHERE role='HOD';" >> d:\Inter\placementcell\col_out.txt 2>&1
