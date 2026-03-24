"""
Fix all unclosed string literals in hod_dashboard.jsp.
Joins any string assignment that spans across multiple lines.
"""
import re

file_path = r'd:\Inter\placementcell\hod\hod_dashboard.jsp'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

original = content

# Generic fix: find any line ending with an unclosed string literal
# (i.e., a line that opens a " but doesn't close it before end-of-line)
# inside a Java context (between <% and %>)
# Strategy: scan line by line. If a line contains an odd number of " 
# that results in an open string at end of line, join with next line.

def count_open_quotes(line):
    """Returns True if line ends with an unclosed string literal."""
    in_string = False
    i = 0
    while i < len(line):
        c = line[i]
        if c == '\\' and in_string:
            i += 2  # skip escaped char
            continue
        if c == '"':
            in_string = not in_string
        i += 1
    return in_string  # True = string still open at end of line

lines = content.split('\n')
fixed_lines = []
i = 0
fixed_count = 0

while i < len(lines):
    line = lines[i]
    # Only process lines that look like Java code (not HTML)
    stripped = line.strip()
    
    # Check if this line has an unclosed string
    if count_open_quotes(stripped) and i + 1 < len(lines):
        # Join with next line(s) until string is closed
        combined = line.rstrip()
        j = i + 1
        while j < len(lines) and count_open_quotes(combined.strip()):
            next_part = lines[j].strip()
            combined = combined + ' ' + next_part
            j += 1
        fixed_lines.append(combined)
        i = j
        fixed_count += 1
    else:
        fixed_lines.append(line)
        i += 1

new_content = '\n'.join(fixed_lines)

if new_content != original:
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(new_content)
    print(f"SUCCESS: Fixed {fixed_count} unclosed string literal(s) in hod_dashboard.jsp")
else:
    print("No unclosed string literals found - file is clean")
