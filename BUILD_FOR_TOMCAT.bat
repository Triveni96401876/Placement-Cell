@echo off
set "CATALINA_HOME=C:\intern\apache-tomcat-9.0.115"
set "PROJECT_ROOT=d:\Inter\placementcell"
set "DEPLOY_DIR=%CATALINA_HOME%\webapps\sgpians"

echo.
echo [1/4] Cleaning deployment and work directories...
if exist "%DEPLOY_DIR%" rmdir /s /q "%DEPLOY_DIR%"
mkdir "%DEPLOY_DIR%\WEB-INF\classes"
mkdir "%DEPLOY_DIR%\WEB-INF\lib"
rmdir /s /q "%CATALINA_HOME%\work\Catalina\localhost\sgpians" 2>nul
rmdir /s /q "%CATALINA_HOME%\work\Catalina\localhost\ROOT" 2>nul

echo [2/4] Copying dependencies and config...
copy /y "%PROJECT_ROOT%\config\lib\*.jar" "%DEPLOY_DIR%\WEB-INF\lib\" >nul
copy /y "%PROJECT_ROOT%\config\web.xml" "%DEPLOY_DIR%\WEB-INF\" >nul

echo [3/4] Compiling Java source (Servlet-based)...
set "CP=%CATALINA_HOME%\lib\*;%DEPLOY_DIR%\WEB-INF\lib\*;%DEPLOY_DIR%\WEB-INF\classes"

:: Create lists of files to compile
dir /s /b "%PROJECT_ROOT%\backend\*.java" > all_files.txt
:: Exclude Spring components that cause compilation errors without Spring JARs
findstr /v /i "dto repository service security config AcademicDetails.java Announcement.java EligibilityCriteria.java EligibleStudent.java com\placementcell\test" all_files.txt | findstr /v /i /c:"model\Admin.java" > compile_list.txt

javac -encoding UTF-8 -cp "%CP%" -d "%DEPLOY_DIR%\WEB-INF\classes" @compile_list.txt
if %ERRORLEVEL% neq 0 (
    echo.
    echo ERROR: Backend compilation failed!
    del all_files.txt compile_list.txt
    exit /b 1
)
del all_files.txt compile_list.txt

echo [4/4] Syncing web assets and JSPs...
xcopy /y /q /e "%PROJECT_ROOT%\assets\*" "%DEPLOY_DIR%\assets\" >nul
xcopy /y /q /e "%PROJECT_ROOT%\images\*" "%DEPLOY_DIR%\images\" >nul
xcopy /y /q /e "%PROJECT_ROOT%\student\*" "%DEPLOY_DIR%\student\" >nul
xcopy /y /q /e "%PROJECT_ROOT%\admin\*" "%DEPLOY_DIR%\admin\" >nul
xcopy /y /q /e "%PROJECT_ROOT%\hod\*" "%DEPLOY_DIR%\hod\" >nul
xcopy /y /q /e "%PROJECT_ROOT%\frontend-vanilla\*" "%DEPLOY_DIR%\frontend-vanilla\" >nul
copy /y "%PROJECT_ROOT%\index.jsp" "%DEPLOY_DIR%\" >nul

echo.
echo [BONUS] Syncing to ROOT context for convenience...
set "ROOT_DIR=%CATALINA_HOME%\webapps\ROOT"
if exist "%ROOT_DIR%" rmdir /s /q "%ROOT_DIR%"
mkdir "%ROOT_DIR%"
xcopy /y /q /e "%DEPLOY_DIR%\*" "%ROOT_DIR%\" >nul

echo.
echo BUILD SUCCESSFUL!
echo Now restart Tomcat using RESTART_TOMCAT_CLEAN.bat
