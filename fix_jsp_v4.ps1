$files = @('c:\intern\apache-tomcat-9.0.115\webapps\ROOT\admin-dashboard.jsp', 'c:\placementcell\admin\admin-dashboard.jsp')
# This time we match the potentially broken line, or the one with escapes.
$pattern = '(?s)<span class="backlog-count <%= bCount > 0 \?.*?"has-backlogs"\s*:\s*"no-backlogs" %>">'
$fixed = '<span class="backlog-count <%= bCount > 0 ? "has-backlogs" : "no-backlogs" %>">'

foreach ($filePath in $files) {
    if (Test-Path $filePath) {
        $content = [System.IO.File]::ReadAllText($filePath)
        # Using [regex]::Replace to be super sure about the (?s) flag correctly matching newlines.
        $newContent = [regex]::Replace($content, $pattern, $fixed)
        [System.IO.File]::WriteAllText($filePath, $newContent)
        Write-Host "Fixed: $filePath"
    } else {
        Write-Host "File NOT found: $filePath"
    }
}
