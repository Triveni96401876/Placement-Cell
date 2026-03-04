@echo off
set "CATALINA_HOME=C:\intern\apache-tomcat-9.0.115"
set "PROJECT_ROOT=c:\placementcell"
set "DEPLOY_DIR=%CATALINA_HOME%\webapps\placement-cell"

echo [1/2] Preparing classes dir...
if not exist "%DEPLOY_DIR%\WEB-INF\classes" mkdir "%DEPLOY_DIR%\WEB-INF\classes"

echo [2/2] Compiling all Java files in backend...
set "CP=%CATALINA_HOME%\lib\*;%PROJECT_ROOT%\config\lib\*"
dir /s /b "%PROJECT_ROOT%\backend\*.java" > java_list.txt
javac -encoding UTF-8 -cp "%CP%" -d "%DEPLOY_DIR%\WEB-INF\classes" @java_list.txt
if %ERRORLEVEL% neq 0 (
    echo.
    echo COMPILATION FAILED! See errors above.
) else (
    echo COMPILATION SUCCESSFUL. Classes created.
    dir /s /b "%DEPLOY_DIR%\WEB-INF\classes\*.class" | findstr /v "AcademicDetails"
)
del java_list.txt
