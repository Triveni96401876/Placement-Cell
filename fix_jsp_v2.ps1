$files = @('c:\intern\apache-tomcat-9.0.115\webapps\ROOT\admin-dashboard.jsp', 'c:\placementcell\admin\admin-dashboard.jsp')
$pattern = '(?s)<span class="backlog-count <%= bCount > 0 \?\s*".*?has-backlogs"\s*:\s*"no-backlogs" %>">'
$fixed = '<span class="backlog-count <%= bCount > 0 ? \"has-backlogs\" : \"no-backlogs\" %>">'

foreach ($filePath in $files) {
    if (Test-Path $filePath) {
        $content = Get-Content $filePath -Raw
        if ($content -match $pattern) {
            $newContent = $content -replace $pattern, $fixed
            Set-Content $filePath $newContent -Encoding UTF8
            Write-Host "Fixed: $filePath"
        } else {
            Write-Host "Pattern NOT found in $filePath"
        }
    } else {
        Write-Host "File NOT found: $filePath"
    }
}
