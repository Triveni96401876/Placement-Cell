@echo off
set "CATALINA_HOME=C:\intern\apache-tomcat-9.0.115"
echo Using CATALINA_HOME: %CATALINA_HOME%
cd /d "%CATALINA_HOME%\bin"
echo Stopping Tomcat...
call shutdown.bat
timeout /t 5 /nobreak
echo Starting Tomcat...
call startup.bat
echo Tomcat is starting. Please wait 10 seconds.
timeout /t 10 /nobreak
