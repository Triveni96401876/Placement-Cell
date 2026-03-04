@echo off
set "CATALINA_HOME=C:\intern\apache-tomcat-9.0.115"
set "PROJECT_ROOT=c:\placementcell"
set "DEPLOY_DIR=%CATALINA_HOME%\webapps\placement-cell"

echo [1/5] Stopping Tomcat...
taskkill /F /IM java.exe /FI "WINDOWTITLE eq Tomcat Server" 2>nul
taskkill /F /IM java.exe /FI "COMMANDLINE eq *catalina*" 2>nul

echo [2/5] Cleaning and Preparing Deployment...
if exist "%DEPLOY_DIR%" rmdir /s /q "%DEPLOY_DIR%"
mkdir "%DEPLOY_DIR%"
mkdir "%DEPLOY_DIR%\WEB-INF"
mkdir "%DEPLOY_DIR%\WEB-INF\classes"
mkdir "%DEPLOY_DIR%\WEB-INF\lib"

echo [3/5] Syncing Project Files To Deployment Root...
:: Explicitly copy index and portal files (making sure no trailing space)
copy /y "%PROJECT_ROOT%\index.jsp" "%DEPLOY_DIR%\" >nul 2>nul
copy /y "%PROJECT_ROOT%\config\web.xml" "%DEPLOY_DIR%\WEB-INF\" >nul

:: Copy from portal folders directly into the deployment root
xcopy /y /s /q "%PROJECT_ROOT%\admin\*" "%DEPLOY_DIR%\" >nul
xcopy /y /s /q "%PROJECT_ROOT%\student\*" "%DEPLOY_DIR%\" >nul
xcopy /y /s /q "%PROJECT_ROOT%\hod\*" "%DEPLOY_DIR%\" >nul
xcopy /y /s /e /q "%PROJECT_ROOT%\assets\*" "%DEPLOY_DIR%\" >nul

echo [4/5] Compiling Java...
set "CLASSPATH=%CATALINA_HOME%\lib\*;%PROJECT_ROOT%\config\lib\*;%DEPLOY_DIR%\WEB-INF\classes"
dir /s /b "%PROJECT_ROOT%\backend\*.java" > "%TEMP%\java_files.txt"
findstr /v /i "dto repository service security config AcademicDetails.java Announcement.java EligibilityCriteria.java EligibleStudent.java Admin.java" "%TEMP%\java_files.txt" > "%TEMP%\filtered_java_files.txt"
javac -encoding UTF-8 -cp "%CLASSPATH%" -d "%DEPLOY_DIR%\WEB-INF\classes" @"%TEMP%\filtered_java_files.txt"
if %ERRORLEVEL% neq 0 (
    echo Compilation FAILED!
    del "%TEMP%\java_files.txt" "%TEMP%\filtered_java_files.txt"
    pause
    exit /b 1
)
del "%TEMP%\java_files.txt" "%TEMP%\filtered_java_files.txt"

echo [5/5] Re-Starting Server...
set "JAVA_HOME=C:\Program Files\Java\jdk-17"
set "CATALINA_HOME=%CATALINA_HOME%"
set "CATALINA_BASE=%CATALINA_HOME%"
cd /d "%CATALINA_HOME%\bin"
call startup.bat
timeout /t 5 /nobreak >nul

echo.
echo ==============================================
echo  BUILD SUCCESSFUL AND SERVER STARTING
echo  Wait 10s then visit: http://localhost:8080/placement-cell/
echo ==============================================
