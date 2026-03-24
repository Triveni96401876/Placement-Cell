@echo off
setlocal enabledelayedexpansion

:: Configuration
set "CATALINA_HOME=C:\intern\apache-tomcat-9.0.115"
set "PROJECT_ROOT=%~dp0"
if "%PROJECT_ROOT:~-1%"=="\" set "PROJECT_ROOT=%PROJECT_ROOT:~0,-1%"
set "DEPLOY_DIR=%CATALINA_HOME%\webapps\sgpians"

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

:: 4. Sync Web Assets (Preserving directory structure)
echo [4/4] Syncing web assets...
for %%d in (admin student hod assets images frontend-vanilla) do (
    if exist "%PROJECT_ROOT%\%%d" (
        if not exist "%DEPLOY_DIR%\%%d" mkdir "%DEPLOY_DIR%\%%d"
        xcopy /y /q /e "%PROJECT_ROOT%\%%d\*" "%DEPLOY_DIR%\%%d\" >nul
    )
)

if exist "%PROJECT_ROOT%\index.jsp" (
    copy /y "%PROJECT_ROOT%\index.jsp" "%DEPLOY_DIR%\" >nul
)

:: 5. Secondary Deployment to ROOT (for universal access)
echo [5/5] Syncing to ROOT context (for http://localhost:8080/ access)...
set "ROOT_DIR=%CATALINA_HOME%\webapps\ROOT"

:: Force folder creation if ROOT exist but folders dont
for %%d in (admin student hod assets images frontend-vanilla) do (
    if exist "%DEPLOY_DIR%\%%d" (
        if not exist "%ROOT_DIR%\%%d" mkdir "%ROOT_DIR%\%%d"
        xcopy /y /q /e "%DEPLOY_DIR%\%%d\*" "%ROOT_DIR%\%%d\" >nul
    )
)
copy /y "%DEPLOY_DIR%\index.jsp" "%ROOT_DIR%\" >nul

:: Clear Tomcat work cache
if exist "%CATALINA_HOME%\work\Catalina\localhost\sgpians" (
    rmdir /s /q "%CATALINA_HOME%\work\Catalina\localhost\sgpians"
)
if exist "%CATALINA_HOME%\work\Catalina\localhost\ROOT" (
    rmdir /s /q "%CATALINA_HOME%\work\Catalina\localhost\ROOT"
)

echo ==========================================
echo BUILD SUCCESSFUL
echo ==========================================
echo deployment 1 (Context): http://localhost:8080/sgpians/
echo deployment 2 (ROOT):    http://localhost:8080/
echo ==========================================
