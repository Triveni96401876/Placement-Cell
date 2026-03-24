
import sys

filepath = r"d:\Inter\placementcell\hod\hod_dashboard.jsp"

with open(filepath, 'r', encoding='utf-8') as f:
    lines = f.readlines()

new_lines = []
skip = False
for i in range(len(lines)):
    if skip:
        skip = False
        continue
    
    line = lines[i]
    if 'else if ("EEE".equals(currentBranch)) displayBranch = "Electrical and Electronics Engineering' in line and i + 1 < len(lines) and '(EEE)";' in lines[i+1]:
        # Merge lines
        indent = line[:line.find('else')]
        new_line = indent + 'else if ("EEE".equals(currentBranch)) displayBranch = "Electrical and Electronics Engineering (EEE)";\n'
        new_lines.append(new_line)
        skip = True
        print(f"Fixed line {i+1}")
    else:
        new_lines.append(line)

with open(filepath, 'w', encoding='utf-8') as f:
    f.writelines(new_lines)
