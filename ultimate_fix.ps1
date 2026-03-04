# 1. Kill java/Tomcat
echo "Stopping any running Tomcat processes..."
taskkill /F /IM java.exe

# 2. Define files to fix
$filesToFix = @(
    "c:\placementcell\admin\admin-dashboard.jsp",
    "c:\intern\apache-tomcat-9.0.115\webapps\ROOT\admin-dashboard.jsp"
)

# 3. Apply the fix
$brokenFragment = '<span class="backlog-count <%= bCount > 0 ? "'
$fixedLine = '                                                                <span class="backlog-count <%= bCount > 0 ? \"has-backlogs\" : \"no-backlogs\" %>">'

foreach ($file in $filesToFix) {
    if (Test-Path $file) {
        echo "Fixing $file..."
        $content = Get-Content $file -Raw
        
        # We need a robust replacement for the multi-line broken part
        # The broken part is precisely:
        # <span class="backlog-count <%= bCount > 0 ? "
        #                                                                     has-backlogs" : "no-backlogs" %>">
        
        $pattern = '(?s)<span class="backlog-count <%= bCount > 0 \? ".*?\s+has-backlogs" : "no-backlogs" %>">'
        $replacement = '<span class="backlog-count <%= bCount > 0 ? "has-backlogs" : "no-backlogs" %>">'
        
        $newContent = $content -replace $pattern, $replacement
        Set-Content $file $newContent
    }
}

# 4. Wipe Tomcat work directory (FORCE recompile)
echo "Wiping Tomcat work cache..."
if (Test-Path "c:\intern\apache-tomcat-9.0.115\work\Catalina\localhost\ROOT") {
    Remove-Item -Recurse -Force "c:\intern\apache-tomcat-9.0.115\work\Catalina\localhost\ROOT"
}

echo "Done! Please start Tomcat again using startup.bat or RESTART_TOMCAT_CLEAN.bat."
