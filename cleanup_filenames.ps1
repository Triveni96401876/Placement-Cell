Get-ChildItem -Path "C:\placementcell" -Recurse | ForEach-Object {
    if ($_.Name.EndsWith(" ")) {
        $cleanName = $_.Name.Trim()
        Write-Host "Found: '$($_.Name)' in $($_.DirectoryName)"
        Rename-Item -LiteralPath $_.FullName -NewName $cleanName -Force
    }
}
