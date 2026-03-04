$files = @('c:\intern\apache-tomcat-9.0.115\webapps\ROOT\admin-dashboard.jsp', 'c:\placementcell\admin\admin-dashboard.jsp')
# Match the start of the tag and grab everything up to the first space after the broken quote.
$pattern = '(?s)<span class="backlog-count <%= bCount > 0 \?.*?"has-backlogs"\s*:\s*"no-backlogs" %>">'
$fixed = '<span class="backlog-count <%= bCount > 0 ? "has-backlogs" : "no-backlogs" %>">'

foreach ($filePath in $files) {
    if (Test-Path $filePath) {
        $content = [System.IO.File]::ReadAllText($filePath)
        if ($content -match $pattern) {
            $newContent = $content -replace $pattern, $fixed
            [System.IO.File]::WriteAllText($filePath, $newContent)
            Write-Host "Fixed: $filePath"
        } else {
            Write-Host "Pattern NOT found in $filePath"
        }
    } else {
        Write-Host "File NOT found: $filePath"
    }
}
