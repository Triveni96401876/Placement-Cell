
import os

jsp_path = r"d:\Inter\placementcell\hod\hod_dashboard.jsp"

with open(jsp_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Fix the ECE multiline string
old_ece = 'displayBranch = "Electronics and Communication Engineering\n                        (ECE)";'
new_ece = 'displayBranch = "Electronics and Communication Engineering (ECE)";'

# Fix the EEE multiline string
old_eee = 'displayBranch = "Electrical and Electronics Engineering\n                        (EEE)";'
new_eee = 'displayBranch = "Electrical and Electronics Engineering (EEE)";'

# Just in case of different line endings
content = content.replace('displayBranch = "Electronics and Communication Engineering\r\n                        (ECE)";', new_ece)
content = content.replace('displayBranch = "Electronics and Communication Engineering\n                        (ECE)";', new_ece)
content = content.replace('displayBranch = "Electrical and Electronics Engineering\r\n                        (EEE)";', new_eee)
content = content.replace('displayBranch = "Electrical and Electronics Engineering\n                        (EEE)";', new_eee)

# Also try a more generic replace if spaces differ
import re
content = re.sub(r'displayBranch\s*=\s*"Electronics and Communication Engineering\s*\(ECE\)";', new_ece, content)
content = re.sub(r'displayBranch\s*=\s*"Electrical and Electronics Engineering\s*\(EEE\)";', new_eee, content)

# But wait, the newline might be the problem.
content = re.sub(r'displayBranch\s*=\s*"Electronics and Communication Engineering\s+\(ECE\)";', new_ece, content)
content = re.sub(r'displayBranch\s*=\s*"Electrical and Electronics Engineering\s+\(EEE\)";', new_eee, content)

# Actually, the error message shows:
# 29:                         else if ("ECE".equals(currentBranch)) displayBranch = "Electronics and Communication Engineering
# 30:                         (ECE)";
# So there is a newline after "Engineering".

content = content.replace('displayBranch = "Electronics and Communication Engineering\r\n                        (ECE)";', 'displayBranch = "Electronics and Communication Engineering (ECE)";')
content = content.replace('displayBranch = "Electronics and Communication Engineering\n                        (ECE)";', 'displayBranch = "Electronics and Communication Engineering (ECE)";')
content = content.replace('displayBranch = "Electrical and Electronics Engineering\r\n                        (EEE)";', 'displayBranch = "Electrical and Electronics Engineering (EEE)";')
content = content.replace('displayBranch = "Electrical and Electronics Engineering\n                        (EEE)";', 'displayBranch = "Electrical and Electronics Engineering (EEE)";')

with open(jsp_path, 'w', encoding='utf-8') as f:
    f.write(content)

print("Fixed JSP multiline strings.")
