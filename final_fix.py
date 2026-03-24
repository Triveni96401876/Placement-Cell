
import os

path = r'd:\Inter\placementcell\hod\hod_dashboard.jsp'
if not os.path.exists(path):
    print(f"File not found: {path}")
    exit(1)

with open(path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

new_lines = []
changed = False
i = 0
while i < len(lines):
    line = lines[i]
    if 'else if ("EEE".equals(currentBranch)) displayBranch = "Electrical and Electronics Engineering' in line:
        # Check if next line has the rest
        if i + 1 < len(lines) and '(EEE)";' in lines[i+1]:
            # Merge
            indent = line[:line.find('else')]
            new_line = indent + 'else if ("EEE".equals(currentBranch)) displayBranch = "Electrical and Electronics Engineering (EEE)";\n'
            new_lines.append(new_line)
            i += 2
            changed = True
            print(f"Fixed EEE at line {i-1}")
            continue
    new_lines.append(line)
    i += 1

if changed:
    with open(path, 'w', encoding='utf-8') as f:
        f.writelines(new_lines)
    print("File saved successfully")
else:
    print("No matching block found to fix")
