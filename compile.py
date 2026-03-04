import os, subprocess, sys

SKIP_KEYWORDS = [
    'repository', 'service', 'security', 'config', 'dto',
    'AcademicDetails.java', 'Announcement.java',
    'EligibilityCriteria.java', 'EligibleStudent.java',
    'Admin.java', 'TestEEEQuery.java', 'TestHODQuery.java',
    '\\test\\'
]

BACKEND_DIR = r'c:\placementcell\backend'
TOMCAT_LIB  = r'C:\intern\apache-tomcat-9.0.115\lib\*'
PROJECT_LIB = r'c:\placementcell\config\lib\*'
DEPLOY_DIR  = r'C:\intern\apache-tomcat-9.0.115\webapps\ROOT\WEB-INF\classes'

java_files = []
for root, dirs, files in os.walk(BACKEND_DIR):
    for f in files:
        if not f.endswith('.java'):
            continue
        full = os.path.join(root, f)
        skip = False
        for kw in SKIP_KEYWORDS:
            if kw.lower() in full.lower():
                skip = True
                break
        if not skip:
            java_files.append(full)

print(f"Found {len(java_files)} java files to compile:")
for jf in java_files:
    print(" ", jf)

# Write to temp file (no quotes needed for @-file)
list_file = r'C:\Windows\Temp\compile_list.txt'
with open(list_file, 'w') as lf:
    lf.write('\n'.join(java_files))

classpath = f'{TOMCAT_LIB};{PROJECT_LIB};{DEPLOY_DIR}'
cmd = ['javac', '-encoding', 'UTF-8', '-cp', classpath, '-d', DEPLOY_DIR, f'@{list_file}']
print("\nRunning:", ' '.join(cmd))
result = subprocess.run(cmd, capture_output=True, text=True)
if result.returncode == 0:
    print("COMPILATION SUCCESSFUL!")
else:
    print("COMPILATION FAILED!")
    print("STDOUT:", result.stdout[:3000])
    print("STDERR:", result.stderr[:3000])
    sys.exit(1)
