$src = "c:\placementcell\admin\admin-dashboard.jsp"
$dst = "c:\intern\apache-tomcat-9.0.115\webapps\ROOT\admin-dashboard.jsp"

# Read raw bytes as UTF-8 string
$content = [System.IO.File]::ReadAllText($src, [System.Text.Encoding]::UTF8)

# Check if the broken pattern exists
if ($content -notmatch "bCount=s\.getBacklogCount") {
    Write-Host "Broken pattern NOT found in source. File may already be fixed."
    Write-Host "Checking deployed file..."
    $deployed = [System.IO.File]::ReadAllText($dst, [System.Text.Encoding]::UTF8)
    if ($deployed -match "bCount=s\.getBacklogCount") {
        Write-Host "Found in deployed file! Fixing deployed file only."
        # Fix deployed
        $fixed = $deployed -replace '(?s)<% int bCount=s\.getBacklogCount\(\) !=null \?[\r\n\s]*s\.getBacklogCount\(\) : 0; %>[\r\n\s]*<span class="backlog-count <%= bCount > 0 \? "[\r\n\s]*has-backlogs" : "no-backlogs" %>">[\r\n\s]*<%= bCount %>[\r\n\s]*</span>', '<% int bCount = s.getBacklogCount() != null ? s.getBacklogCount() : 0; %>' + "`r`n" + '                                                            <span class="backlog-count <%= bCount > 0 ? "has-backlogs" : "no-backlogs" %>">' + "`r`n" + '                                                                <%= bCount %>' + "`r`n" + '                                                            </span>'
        [System.IO.File]::WriteAllText($dst, $fixed, [System.Text.Encoding]::UTF8)
        Write-Host "Deployed file patched!"
    } else {
        Write-Host "Both files look OK."
    }
} else {
    Write-Host "Broken pattern found in source! Fixing..."
    $fixed = $content -replace '(?s)<% int bCount=s\.getBacklogCount\(\) !=null \?[\r\n\s]*s\.getBacklogCount\(\) : 0; %>[\r\n\s]*<span class="backlog-count <%= bCount > 0 \? "[\r\n\s]*has-backlogs" : "no-backlogs" %>">[\r\n\s]*<%= bCount %>[\r\n\s]*</span>', '<% int bCount = s.getBacklogCount() != null ? s.getBacklogCount() : 0; %>' + "`r`n" + '                                                            <span class="backlog-count <%= bCount > 0 ? "has-backlogs" : "no-backlogs" %>">' + "`r`n" + '                                                                <%= bCount %>' + "`r`n" + '                                                            </span>'
    [System.IO.File]::WriteAllText($src, $fixed, [System.Text.Encoding]::UTF8)
    [System.IO.File]::WriteAllText($dst, $fixed, [System.Text.Encoding]::UTF8)
    Write-Host "BOTH files patched!"
}

# Clear work cache
$workDir = "C:\intern\apache-tomcat-9.0.115\work\Catalina\localhost\ROOT"
if (Test-Path $workDir) {
    Remove-Item -Path $workDir -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Cleared Tomcat work cache"
}
Write-Host "Done."
