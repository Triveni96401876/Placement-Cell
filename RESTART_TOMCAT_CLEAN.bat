@echo off
echo ======================================
echo  Stopping all Java processes...
echo ======================================
taskkill /F /IM java.exe 2>nul
timeout /t 3 /nobreak >nul

echo ======================================
echo  Starting Tomcat fresh...
echo ======================================
set "JAVA_HOME=C:\Program Files\Java\jdk-17"
set "CATALINA_HOME=C:\intern\apache-tomcat-9.0.115"
set "CATALINA_BASE=C:\intern\apache-tomcat-9.0.115"

cd /d "%CATALINA_HOME%\bin"
call startup.bat

echo.
echo ======================================
echo  Tomcat is starting!
echo  Wait 15 seconds, then visit:
echo  http://localhost:8080/placement-cell/
echo ======================================
timeout /t 15 /nobreak
echo.
echo  Checking if port 8080 is listening...
netstat -ano | findstr :8080
echo.
echo  Done. Open your browser now.
pause
