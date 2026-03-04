# Also fix the deployed version and clear cache
$srcFile = "c:\placementcell\admin\admin-dashboard.jsp"
$dstFile = "c:\intern\apache-tomcat-9.0.115\webapps\ROOT\admin-dashboard.jsp"

# Copy fixed file to deployed location
Copy-Item -Path $srcFile -Destination $dstFile -Force
Write-Host "Deployed fixed admin-dashboard.jsp to ROOT"

# Clear Tomcat's compiled JSP cache
$workDir = "c:\intern\apache-tomcat-9.0.115\work\Catalina\localhost\ROOT"
if (Test-Path $workDir) {
    Remove-Item -Path $workDir -Recurse -Force
    Write-Host "Cleared Tomcat work cache"
}

Write-Host "Done. Admin dashboard should now load correctly."
