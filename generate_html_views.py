import re
import os

def jsp_to_html(input_file, output_file):
    if not os.path.exists(input_file):
        return
    with open(input_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Remove JSP directives <%@ ... %>
    content = re.sub(r'<%@\s*page.*?%>', '', content, flags=re.DOTALL)
    
    # Replace <%= ... %> with some static placeholder
    # For numbers we can try to guess based on variable name
    def repl_expr(match):
        expr = match.group(1).lower()
        if 'count' in expr or 'total' in expr or 'students' in expr or 'drives' in expr or 'slno' in expr:
            return '42'
        if 'percentage' in expr:
            return '85.00%'
        if 'name' in expr:
            return 'Demo Name'
        if 'email' in expr:
            return 'demo@example.com'
        if 'mobile' in expr or 'phone' in expr:
            return '9876543210'
        return 'Demo Data'
    
    content = re.sub(r'<%=(.*?)%>', repl_expr, content, flags=re.DOTALL)
    
    # Remove Java block scriptlets <% ... %>
    content = re.sub(r'<%(?![=@]).*?%>', '', content, flags=re.DOTALL)
    
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(content)

jsp_to_html(r'd:\Inter\placementcell\student\dashboard.jsp', r'd:\Inter\placementcell\student\dashboard.html')
jsp_to_html(r'd:\Inter\placementcell\admin\admin-dashboard.jsp', r'd:\Inter\placementcell\admin\admin-dashboard.html')
jsp_to_html(r'd:\Inter\placementcell\hod\hod_dashboard.jsp', r'd:\Inter\placementcell\hod\hod_dashboard.html')

print('Generated HTML views!')
