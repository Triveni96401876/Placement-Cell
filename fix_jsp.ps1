$path = "c:\placementcell\admin\admin-dashboard.jsp"
$lines = Get-Content $path
$newLines = New-Object System.Collections.Generic.List[string]

$inBlock = $false
foreach ($line in $lines) {
    if ($line -match "bCount=s\.getBacklogCount" -or $line -match "backlog-count") {
        if (-not $inBlock) {
            # Insert the correct block
            $newLines.Add("                                                        <td>")
            $newLines.Add("                                                            <% int bCount = s.getBacklogCount() != null ? s.getBacklogCount() : 0; %>")
            $newLines.Add("                                                            <span class=""backlog-count <%= bCount > 0 ? ""has-backlogs"" : ""no-backlogs"" %>"">")
            $newLines.Add("                                                                <%= bCount %>")
            $newLines.Add("                                                            </span>")
            $newLines.Add("                                                        </td>")
            $inBlock = $true
        }
        # Skip the original broken lines
        continue
    }
    
    # Check if we were skipping lines and now we should stop
    if ($inBlock -and ($line -match "</td>" -or $line -match "Mobile")) {
        $inBlock = $false
        # If it was just </td>, we skip it since we already added it. But we must be careful with the next lines.
        if ($line -match "</td>" -and -not ($line -match "Mobile")) { continue }
    }
    
    if (-not $inBlock) {
        $newLines.Add($line)
    }
}

Set-Content -Path $path -Value $newLines -Encoding UTF8
Write-Host "JSP file regenerated."
