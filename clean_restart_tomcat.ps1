$env:JAVA_HOME = "C:\Program Files\Java\jdk-17"
$env:CATALINA_HOME = "C:\intern\apache-tomcat-9.0.115"
$env:CATALINA_BASE = "C:\intern\apache-tomcat-9.0.115"

# Kill any existing Java
Get-Process -Name java -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 3

# Clear ALL work directories
$workDir = "C:\intern\apache-tomcat-9.0.115\work"
if (Test-Path $workDir) {
    Remove-Item -Path "$workDir\*" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Cleared all Tomcat work directories"
}

# Start Tomcat
Start-Process -FilePath "C:\intern\apache-tomcat-9.0.115\bin\startup.bat" -NoNewWindow
Write-Host "Tomcat started. Wait ~15 seconds then visit http://localhost:8080"
Start-Sleep -Seconds 15

# Verify port 8080 is up
$result = netstat -ano | Select-String ":8080"
if ($result) {
    Write-Host "SUCCESS: Port 8080 is listening!"
} else {
    Write-Host "WARNING: Port 8080 not yet ready"
}
