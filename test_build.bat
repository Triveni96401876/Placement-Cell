@echo off
set TOMCAT=C:\intern\apache-tomcat-9.0.115
set PROJECT=c:\placementcell
set OUTDIR=%TEMP%\testclasses
mkdir %OUTDIR% 2>nul

dir /s /b "%PROJECT%\backend\*.java" > "%TEMP%\jf.txt"
findstr /v /i "Admin.java AcademicDetails.java Announcement.java EligibilityCriteria.java EligibleStudent.java" "%TEMP%\jf.txt" > "%TEMP%\ff.txt"
echo Compiling...
javac -encoding UTF-8 -cp "%TOMCAT%\lib\*;%PROJECT%\config\lib\*" -d "%OUTDIR%" @"%TEMP%\ff.txt" > "%TEMP%\build_err.txt" 2>&1
if %ERRORLEVEL% neq 0 (
    echo COMPILATION FAILED - errors:
    type "%TEMP%\build_err.txt"
) else (
    echo COMPILATION SUCCEEDED!
)
pause
