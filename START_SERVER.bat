@echo off
set "CATALINA_HOME=C:\intern\apache-tomcat-9.0.115"
set "JAVA_HOME=C:\Program Files\Java\jdk-17"
echo Starting Tomcat...
cd /d "%CATALINA_HOME%\bin"
start "Tomcat Server" /b catalina.bat run
exit
