$path = "c:\placementcell\admin\admin-view-registrations.jsp"
$content = Get-Content $path -Raw

# 1. Fix line 486-487: <div class="<%= (bCount > 0) ? " backlog-warning" : "backlog-none" %>">
$old1 = '<div class="<%= (bCount > 0) ? " backlog-warning"' + "`r`n" + '                                                            : "backlog-none" %>">'
$new1 = '<div class="<%= (bCount > 0) ? \"backlog-warning\" : \"backlog-none\" %>">'
$content = $content.Replace($old1, $new1)

# 2. Fix line 490-491: <%= (bCount> 0) ? bCount + " Active Backlogs" : "Clear History" %>
$old2 = '<%= (bCount> 0) ? bCount + " Active Backlogs" : "Clear' + "`r`n" + '                                                                History" %>'
$new2 = '<%= (bCount > 0) ? bCount + \" Active Backlogs\" : \"Clear History\" %>'
$content = $content.Replace($old2, $new2)

# 3. Fix line 410-411: <%= (jTitle !=null) ? "Applicants for " + jTitle : "Registered Candidates" %>
$old3 = '<%= (jTitle !=null) ? "Applicants for " + jTitle : "Registered Candidates"' + "`r`n" + '                                                %>'
$new3 = '<%= (jTitle != null) ? \"Applicants for \" + jTitle : \"Registered Candidates\" %>'
$content = $content.Replace($old3, $new3)

$content | Set-Content $path -NoNewline -Force
