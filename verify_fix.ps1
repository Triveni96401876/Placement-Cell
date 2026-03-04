Write-Host "=== Checking admin-dashboard.jsp in ROOT ==="
$lines = [System.IO.File]::ReadAllLines("c:\intern\apache-tomcat-9.0.115\webapps\ROOT\admin-dashboard.jsp")
Write-Host "Total lines: $($lines.Length)"
Write-Host "LINE 729: $($lines[728])"
Write-Host "LINE 730: $($lines[729])"
Write-Host "LINE 731: $($lines[730])"
Write-Host "LINE 732: $($lines[731])"
Write-Host "LINE 733: $($lines[732])"

# Check if still broken
$broken = $false
for ($i = 0; $i -lt $lines.Length; $i++) {
    if ($lines[$i] -match "bCount=s\.getBacklogCount.*!=null") {
        Write-Host "`nSTILL BROKEN at line $($i+1)!"
        Write-Host $lines[$i]
        $broken = $true
    }
}
if (-not $broken) {
    Write-Host "`nFILE IS CLEAN - no broken pattern found!"
}
