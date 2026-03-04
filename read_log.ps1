$log = "C:\intern\apache-tomcat-9.0.115\logs\localhost.2026-03-02.log"
$lines = Get-Content $log
# Get last 50 lines
$lines | Select-Object -Last 50
