@echo off
setlocal enabledelayedexpansion

:: Configuration
set "CATALINA_HOME=C:\intern\apache-tomcat-9.0.115"
set "PROJECT_ROOT=c:\placementcell"
set "DEPLOY_DIR=%CATALINA_HOME%\webapps\ROOT"

echo ==========================================
echo    PLACEMENTS CELL - STABLE BUILD
echo ==========================================

:: 1. Prepare Deployment
echo [1/4] Preparing deployment directory (Wiping clean!)...
if exist "%DEPLOY_DIR%" rmdir /s /q "%DEPLOY_DIR%"
mkdir "%DEPLOY_DIR%"
mkdir "%DEPLOY_DIR%\WEB-INF"
mkdir "%DEPLOY_DIR%\WEB-INF\classes"
mkdir "%DEPLOY_DIR%\WEB-INF\lib"

:: 2. Copy JARs and Config (Excluding the old project jar if it exists)
echo [2/4] Copying dependencies and config...
if exist "%PROJECT_ROOT%\config\lib" (
    for %%f in ("%PROJECT_ROOT%\config\lib\*.jar") do (
        if /i not "%%~nxf"=="placed-cell.jar" (
            copy /y "%%f" "%DEPLOY_DIR%\WEB-INF\lib\" >nul
        )
    )
)
copy /y "%PROJECT_ROOT%\config\web.xml" "%DEPLOY_DIR%\WEB-INF\" >nul

:: 3. Compile Java Source
echo [3/4] Compiling Java classes...
set "CLASSPATH=%CATALINA_HOME%\lib\*;%PROJECT_ROOT%\config\lib\*;%DEPLOY_DIR%\WEB-INF\lib\*;%DEPLOY_DIR%\WEB-INF\classes"

dir /s /b "%PROJECT_ROOT%\backend\*.java" > "%TEMP%\java_files.txt"
findstr /v /i "dto repository service security config AcademicDetails.java Announcement.java EligibilityCriteria.java EligibleStudent.java Admin.java" "%TEMP%\java_files.txt" > "%TEMP%\filtered_java_files.txt"

javac -encoding UTF-8 -cp "%CLASSPATH%" -d "%DEPLOY_DIR%\WEB-INF\classes" @"%TEMP%\filtered_java_files.txt"
if %ERRORLEVEL% neq 0 (echo ERROR: Compilation failed! && del "%TEMP%\java_files.txt" "%TEMP%\filtered_java_files.txt" && exit /b %ERRORLEVEL%)
del "%TEMP%\java_files.txt" "%TEMP%\filtered_java_files.txt"

:: 4. Sync Web Assets (Brute force copy to root)
echo [4/4] Syncing web assets directly to root...
xcopy /y /q "%PROJECT_ROOT%\admin\*.jsp" "%DEPLOY_DIR%\" >nul
xcopy /y /q "%PROJECT_ROOT%\admin\*.html" "%DEPLOY_DIR%\" >nul
xcopy /y /q "%PROJECT_ROOT%\student\*.jsp" "%DEPLOY_DIR%\" >nul
xcopy /y /q "%PROJECT_ROOT%\student\*.html" "%DEPLOY_DIR%\" >nul
xcopy /y /q "%PROJECT_ROOT%\hod\*.jsp" "%DEPLOY_DIR%\" >nul
xcopy /y /q "%PROJECT_ROOT%\hod\*.html" "%DEPLOY_DIR%\" >nul
xcopy /e /y /q "%PROJECT_ROOT%\assets\*" "%DEPLOY_DIR%\" >nul

if exist "%PROJECT_ROOT%\index.jsp" (
    copy /y "%PROJECT_ROOT%\index.jsp" "%DEPLOY_DIR%\" >nul
)

:: Clear Tomcat work cache
if exist "%CATALINA_HOME%\work\Catalina\localhost\ROOT" (
    rmdir /s /q "%CATALINA_HOME%\work\Catalina\localhost\ROOT"
)

echo ==========================================
echo BUILD SUCCESSFUL
echo ==========================================
echo deployment: %DEPLOY_DIR%

echo ==========================================
echo BUILD SUCCESSFUL
echo ==========================================
echo deployment: %DEPLOY_DIR%
