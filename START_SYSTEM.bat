@echo off
set "CATALINA_HOME=C:\intern\apache-tomcat-9.0.115"
set "PROJECT_ROOT=%~dp0"
if "%PROJECT_ROOT:~-1%"=="\" set "PROJECT_ROOT=%PROJECT_ROOT:~0,-1%"
set "DEPLOY_DIR=%CATALINA_HOME%\webapps\ROOT"

echo [1/5] Stopping Tomcat...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :8080') do taskkill /F /PID %%a 2>nul
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :8005') do taskkill /F /PID %%a 2>nul
taskkill /F /IM java.exe 2>nul
timeout /t 3 /nobreak >nul

echo [2/5] Cleaning and Preparing Deployment...
if exist "%DEPLOY_DIR%" rmdir /s /q "%DEPLOY_DIR%"
if exist "%CATALINA_HOME%\webapps\placement-cell" rmdir /s /q "%CATALINA_HOME%\webapps\placement-cell"
mkdir "%DEPLOY_DIR%"
mkdir "%DEPLOY_DIR%\WEB-INF"
mkdir "%DEPLOY_DIR%\WEB-INF\classes"
mkdir "%DEPLOY_DIR%\WEB-INF\lib"

echo [3/5] Syncing Project Files To Deployment Root...
copy /y "%PROJECT_ROOT%\index.jsp" "%DEPLOY_DIR%\" >nul 2>nul
copy /y "%PROJECT_ROOT%\config\web.xml" "%DEPLOY_DIR%\WEB-INF\" >nul
copy /y "%PROJECT_ROOT%\config\lib\*.jar" "%DEPLOY_DIR%\WEB-INF\lib\" >nul

:: Sync web folders (preserving directory structure)
xcopy /y /s /e /q "%PROJECT_ROOT%\admin\*" "%DEPLOY_DIR%\admin\" >nul
xcopy /y /s /e /q "%PROJECT_ROOT%\student\*" "%DEPLOY_DIR%\student\" >nul
xcopy /y /s /e /q "%PROJECT_ROOT%\hod\*" "%DEPLOY_DIR%\hod\" >nul
xcopy /y /s /e /q "%PROJECT_ROOT%\assets\*" "%DEPLOY_DIR%\assets\" >nul
xcopy /y /s /e /q "%PROJECT_ROOT%\images\*" "%DEPLOY_DIR%\images\" >nul
xcopy /y /s /e /q "%PROJECT_ROOT%\frontend-vanilla\*" "%DEPLOY_DIR%\frontend-vanilla\" >nul

echo [4/5] Compiling Java via Python...
python "%PROJECT_ROOT%\compile.py"
if %ERRORLEVEL% neq 0 (
    echo Compilation FAILED!
    pause
    exit /b 1
)

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
echo  Wait 10s then visit: http://localhost:8080/
echo ==============================================
timeout /t 8 /nobreak >nul
start http://localhost:8080/
