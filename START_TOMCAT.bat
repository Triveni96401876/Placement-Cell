@echo off
set "CATALINA_HOME=C:\intern\apache-tomcat-9.0.115"
set "JAVA_HOME=C:\Program Files\Java\jdk-17"
echo Starting Tomcat for Placement Cell...
call "%CATALINA_HOME%\bin\startup.bat"
echo.
echo If a window appeared, Tomcat is starting.
echo Wait 10 seconds, then visit: http://localhost:8080/placement-cell/
pause
