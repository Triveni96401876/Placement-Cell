$file = "c:\placementcell\admin\admin-dashboard.jsp"
$content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

# Reduce large spacings
$content = $content.Replace(
    "margin-bottom: 3rem;`r`n                                    padding: 0 0.5rem;",
    "margin-bottom: 1.5rem;`r`n                                    padding: 0 0.5rem;"
)
$content = $content.Replace(
    "margin-bottom: 2rem;`r`n                                    color: #1a1c2d;",
    "margin-bottom: 1rem;`r`n                                    color: #1a1c2d;"
)
$content = $content.Replace(
    "margin-top: 2rem;`r`n                                    overflow-x: auto;",
    "margin-top: 1rem;`r`n                                    overflow-x: auto;"
)
$content = $content.Replace(
    "margin-top: 1rem;`r`n                                }",
    "margin-top: 0.5rem;`r`n                                }"
)

[System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
Write-Host "Spacing reduced in admin-dashboard.jsp"

# Deploy to ROOT
Copy-Item -Path $file -Destination "c:\intern\apache-tomcat-9.0.115\webapps\ROOT\admin-dashboard.jsp" -Force

# Clear work cache
$workDir = "c:\intern\apache-tomcat-9.0.115\work\Catalina\localhost\ROOT"
if (Test-Path $workDir) {
    Remove-Item -Path $workDir -Recurse -Force
    Write-Host "Cleared Tomcat work cache"
}

Write-Host "Done. Refresh admin dashboard."
