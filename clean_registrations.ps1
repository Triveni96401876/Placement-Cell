$path = "c:\placementcell\admin\admin-view-registrations.jsp"
$content = Get-Content $path -Raw
$content = $content.Replace('\"backlog-warning\"', '"backlog-warning"')
$content = $content.Replace('\"backlog-none\"', '"backlog-none"')
$content = $content.Replace('\" Active Backlogs\"', '" Active Backlogs"')
$content = $content.Replace('\"Clear History\"', '"Clear History"')
$content = $content.Replace('\"Applicants for \"', '"Applicants for "')
$content = $content.Replace('\"Registered Candidates\"', '"Registered Candidates"')
$content | Set-Content $path -NoNewline -Force
