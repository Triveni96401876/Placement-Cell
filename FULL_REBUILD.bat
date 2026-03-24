@echo off
set "JAVA_HOME=C:\Program Files\Java\jdk-17"
set "CATALINA_HOME=C:\intern\apache-tomcat-9.0.115"
set "PROJECT_ROOT=d:\Inter\placementcell"
set "WEBAPP_NAME=sgpians"
set "DEPLOY_DIR=%CATALINA_HOME%\webapps\%WEBAPP_NAME%"
set "ROOT_DIR=%CATALINA_HOME%\webapps\ROOT"

echo Stopping Tomcat (just in case)...
taskkill /F /IM java.exe /T 2>nul
timeout /t 2 /nobreak >nul

echo Cleaning deployment directories...
if exist "%DEPLOY_DIR%" rmdir /s /q "%DEPLOY_DIR%"
mkdir "%DEPLOY_DIR%\WEB-INF\classes"
mkdir "%DEPLOY_DIR%\WEB-INF\lib"

echo Copying dependencies...
copy /y "%PROJECT_ROOT%\config\lib\*.jar" "%DEPLOY_DIR%\WEB-INF\lib\" >nul
copy /y "%PROJECT_ROOT%\config\web.xml" "%DEPLOY_DIR%\WEB-INF\" >nul

echo Collecting and filtering Java files...
dir /s /b "%PROJECT_ROOT%\backend\*.java" > "%TEMP%\java_files.txt"
:: Exclude directories and specific Spring models, but don't exclude AdminDashboardServlet
findstr /v /i "dto repository service security config AcademicDetails.java Announcement.java EligibilityCriteria.java EligibleStudent.java com\placementcell\test" "%TEMP%\java_files.txt" | findstr /v /i /c:"model\Admin.java" > "%TEMP%\filtered_java_files.txt"

echo Compiling Java source...
set "CP=%CATALINA_HOME%\lib\*;%DEPLOY_DIR%\WEB-INF\lib\*;%DEPLOY_DIR%\WEB-INF\classes"
"%JAVA_HOME%\bin\javac" -encoding UTF-8 -cp "%CP%" -d "%DEPLOY_DIR%\WEB-INF\classes" @"%TEMP%\filtered_java_files.txt"

if %ERRORLEVEL% neq 0 (
    echo Compilation failed!
    pause
    exit /b %ERRORLEVEL%
)

echo Syncing web assets...
xcopy /y /q /e "%PROJECT_ROOT%\assets\*" "%DEPLOY_DIR%\assets\" >nul
xcopy /y /q /e "%PROJECT_ROOT%\images\*" "%DEPLOY_DIR%\images\" >nul
xcopy /y /q /e "%PROJECT_ROOT%\student\*" "%DEPLOY_DIR%\student\" >nul
xcopy /y /q /e "%PROJECT_ROOT%\admin\*" "%DEPLOY_DIR%\admin\" >nul
xcopy /y /q /e "%PROJECT_ROOT%\hod\*" "%DEPLOY_DIR%\hod\" >nul
xcopy /y /q /e "%PROJECT_ROOT%\frontend-vanilla\*" "%DEPLOY_DIR%\frontend-vanilla\" >nul
copy /y "%PROJECT_ROOT%\index.jsp" "%DEPLOY_DIR%\" >nul

echo Syncing to ROOT context...
if exist "%ROOT_DIR%" rmdir /s /q "%ROOT_DIR%"
mkdir "%ROOT_DIR%"
xcopy /y /q /e "%DEPLOY_DIR%\*" "%ROOT_DIR%\" >nul

echo Clearing work directory...
rmdir /s /q "%CATALINA_HOME%\work\Catalina\localhost\%WEBAPP_NAME%" 2>nul
rmdir /s /q "%CATALINA_HOME%\work\Catalina\localhost\ROOT" 2>nul

echo Starting Tomcat...
cd /d "%CATALINA_HOME%\bin"
start startup.bat

echo Done! Success!
timeout /t 5
