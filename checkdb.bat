@echo off
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -ptriveni9100@ placement_cell --silent --raw -e "SELECT CONCAT('APP|',student_name,'|BRANCH=',IFNULL(branch,'NULL_BRANCH')) FROM job_applications;">db_out2.txt 2>&1
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -ptriveni9100@ placement_cell --silent --raw -e "SELECT CONCAT('HOD|',email,'|BRANCH=',IFNULL(branch,'NULL_BRANCH')) FROM users WHERE role='HOD';">>db_out2.txt 2>&1
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -ptriveni9100@ placement_cell --silent --raw -e "SELECT CONCAT('CSE_HOD|',email,'|BRANCH=',IFNULL(branch,'NULL')) FROM users WHERE role='HOD' AND branch='CSE';">>db_out2.txt 2>&1
type db_out2.txt
