import re

file_path = r"d:\Inter\placementcell\hod\hod_dashboard.jsp"

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Fix multiline branch names
content = re.sub(
    r'else if \("ECE"\.equals\(currentBranch\)\) displayBranch = ".*?"',
    'else if ("ECE".equals(currentBranch)) displayBranch = "Metallurgy"',
    content
)

# Ensure EEE is on one line too
content = re.sub(
    r'else if \("EEE"\.equals\(currentBranch\)\) displayBranch = .*?\n\s+\(EEE\)";',
    'else if ("EEE".equals(currentBranch)) displayBranch = "Electrical and Electronics Engineering (EEE)";',
    content
)

# Correct any other multiline strings if they exist
content = content.replace('displayBranch = "Electronics and Communication Engineering\n                        (ECE)";', 'displayBranch = "Metallurgy";')
content = content.replace('displayBranch = "Electrical and Electronics Engineering\n                        (EEE)";', 'displayBranch = "Electrical and Electronics Engineering (EEE)";')

# Handle the branchLabel in the <h2>Students List - ...</h2>
# Old: 
# <%= (currentBranch !=null && !currentBranch.isEmpty() ? currentBranch
#      : "All" ) %>
# New: Handle ECE -> Metallurgy

old_label_pattern = r'<%= \(currentBranch !=null && !currentBranch\.isEmpty\(\) \? currentBranch\s+: "All" \) %>'
new_label = r'<%= (currentBranch != null && "ECE".equals(currentBranch) ? "Metallurgy" : (currentBranch != null && !currentBranch.isEmpty() ? currentBranch : "All")) %>'

content = re.sub(old_label_pattern, new_label, content)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print("JSP fixed. ECE -> Metallurgy, EEE on one line, and branchLabel updated.")
