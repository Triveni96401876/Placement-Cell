<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.placementcell.model.Student" %>
        <%@ page import="com.placementcell.util.DBConnection" %>
            <%@ page import="java.sql.*" %>
                <%
    // Security check
    Object userObj = session.getAttribute("user");
    if (userObj == null) {
        response.sendRedirect(request.getContextPath() + "/student/login.jsp");
        return;
    }
    com.placementcell.model.User user = (com.placementcell.model.User) userObj;
    if (!"ADMIN".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/admin/AdminDashboardServlet");
        return;
    }
    String idParam = request.getParameter("id");
    if (idParam == null || idParam.isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/admin/AdminDashboardServlet");
        return;
    }
    long studentId = Long.parseLong(idParam);
    // Load student data
    String regNo = "", fullName = "", gender = "", dob = "", mobile = "", altMobile = "", emailVal = "", address = "", placedCompany = "", preference = "", backlogHistory = "NO";
    double sslcPct = 0, pucPct = 0, itiPct = 0, diplomaPct = 0, sem1 = 0, sem2 = 0, sem3 = 0, sem4 = 0;
    int sslcYear = 0, pucYear = 0, itiYear = 0, backlogs = 0;
    String branch = "Civil Engg";
    try (Connection conn = DBConnection.getConnection()) {
        String sql = "SELECT s.id, s.register_number, s.full_name, s.date_of_birth, s.gender, s.branch, "
                   + "s.mobile_number, s.alternate_number, s.address, s.placed_company, "
                   + "ad.sslc_percentage, ad.sslc_year, ad.puc_percentage, ad.puc_year, "
                   + "ad.iti_percentage, ad.iti_year, ad.diploma_percentage, "
                   + "ad.sem1, ad.sem2, ad.sem3, ad.sem4, ad.current_backlog_count, "
                   + "ad.history_of_backlogs, ad.preference, u.email " + "FROM students s "
                   + "LEFT JOIN academic_details ad ON s.id = ad.student_id " + "JOIN users u ON s.user_id = u.id "
                   + "WHERE s.id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, studentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                regNo = rs.getString("register_number") != null ? rs.getString("register_number") : "";
                fullName = rs.getString("full_name") != null ? rs.getString("full_name") : "";
                gender = rs.getString("gender") != null ? rs.getString("gender") : "";
                dob = rs.getDate("date_of_birth") != null ? rs.getDate("date_of_birth").toString() : "";
                mobile = rs.getString("mobile_number") != null ? rs.getString("mobile_number") : "";
                altMobile = rs.getString("alternate_number") != null ? rs.getString("alternate_number") : "";
                emailVal = rs.getString("email") != null ? rs.getString("email") : "";
                address = rs.getString("address") != null ? rs.getString("address") : "";
                placedCompany = rs.getString("placed_company") != null ? rs.getString("placed_company") : "";
                preference = rs.getString("preference") != null ? rs.getString("preference") : "";
                backlogHistory = rs.getString("history_of_backlogs") != null ? rs.getString("history_of_backlogs") : "NO";
                sslcPct = rs.getDouble("sslc_percentage");
                sslcYear = rs.getInt("sslc_year");
                pucPct = rs.getDouble("puc_percentage");
                pucYear = rs.getInt("puc_year");
                itiPct = rs.getDouble("iti_percentage");
                itiYear = rs.getInt("iti_year");
                diplomaPct = rs.getDouble("diploma_percentage");
                sem1 = rs.getDouble("sem1");
                sem2 = rs.getDouble("sem2");
                sem3 = rs.getDouble("sem3");
                sem4 = rs.getDouble("sem4");
                backlogs = rs.getInt("current_backlog_count");
                branch = rs.getString("branch") != null ? rs.getString("branch") : "Civil Engg";
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/AdminDashboardServlet?error=notfound");
                return;
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect(request.getContextPath() + "/admin/AdminDashboardServlet?error=db");
        return;
    }
%>
                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Edit Student | SGP PlacementCell – SGP Ballari</title>
                        <link
                            href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
                            rel="stylesheet">
                        <link rel="stylesheet"
                            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                        <style>
                            :root {
                                --primary: #1565c0;
                                --primary-light: #1976d2;
                                --primary-dark: #0d47a1;
                                --accent: #00b0ff;
                                --success: #00c853;
                                --warning: #ff6d00;
                                --danger: #d32f2f;
                                --bg: #eef2f7;
                                --card-bg: #ffffff;
                                --text-dark: #1a2338;
                                --text-muted: #546e7a;
                                --border: #dce3ed;
                            }

                            * {
                                margin: 0;
                                padding: 0;
                                box-sizing: border-box;
                                font-family: 'Outfit', sans-serif;
                            }

                            body {
                                background: var(--bg);
                                color: var(--text-dark);
                                min-height: 100vh;
                            }

                            .page-header {
                                background: linear-gradient(135deg, #0d47a1 0%, #1976d2 60%, #00b0ff 100%);
                                padding: 20px 40px;
                                display: flex;
                                align-items: center;
                                gap: 20px;
                                box-shadow: 0 4px 20px rgba(21, 101, 192, 0.3);
                            }

                            .page-header .logo-box {
                                width: 50px;
                                height: 50px;
                                background: white;
                                border-radius: 12px;
                                padding: 3px;
                                display: flex;
                                align-items: center;
                                justify-content: center;
                            }

                            .page-header .logo-box img {
                                width: 100%;
                                object-fit: contain;
                            }

                            .page-header h1 {
                                font-size: 1.4rem;
                                font-weight: 800;
                                color: white;
                            }

                            .page-header p {
                                font-size: 0.85rem;
                                color: rgba(255, 255, 255, 0.8);
                            }

                            .back-btn {
                                margin-left: auto;
                                background: rgba(255, 255, 255, 0.15);
                                border: 1px solid rgba(255, 255, 255, 0.3);
                                color: white;
                                padding: 10px 20px;
                                border-radius: 12px;
                                text-decoration: none;
                                font-weight: 700;
                                display: flex;
                                align-items: center;
                                gap: 8px;
                                transition: 0.3s;
                            }

                            .back-btn:hover {
                                background: rgba(255, 255, 255, 0.25);
                            }

                            .container {
                                max-width: 1100px;
                                margin: 35px auto;
                                padding: 0 20px 60px;
                            }

                            .edit-badge {
                                display: inline-flex;
                                align-items: center;
                                gap: 8px;
                                background: linear-gradient(135deg, #ff6d00, #e65100);
                                color: white;
                                padding: 6px 16px;
                                border-radius: 20px;
                                font-size: 0.8rem;
                                font-weight: 800;
                                margin-bottom: 20px;
                                letter-spacing: 0.5px;
                            }

                            .form-card {
                                background: var(--card-bg);
                                padding: 40px;
                                border-radius: 24px;
                                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.06);
                                border: 1px solid var(--border);
                            }

                            .section-header {
                                display: flex;
                                align-items: center;
                                gap: 12px;
                                margin: 30px 0 20px;
                                padding-bottom: 14px;
                                border-bottom: 2px solid var(--bg);
                            }

                            .section-header:first-child {
                                margin-top: 0;
                            }

                            .section-icon {
                                width: 42px;
                                height: 42px;
                                border-radius: 12px;
                                display: flex;
                                align-items: center;
                                justify-content: center;
                                font-size: 1.1rem;
                                color: white;
                            }

                            .section-header h2 {
                                font-size: 1.1rem;
                                font-weight: 800;
                                color: var(--text-dark);
                            }

                            .form-grid {
                                display: grid;
                                grid-template-columns: 1fr 1fr;
                                gap: 18px;
                            }

                            .form-group {
                                margin-bottom: 4px;
                            }

                            .form-group.full {
                                grid-column: span 2;
                            }

                            .form-group label {
                                display: block;
                                font-weight: 600;
                                font-size: 0.82rem;
                                margin-bottom: 7px;
                                color: var(--text-muted);
                                text-transform: uppercase;
                                letter-spacing: 0.5px;
                            }

                            .form-group label .req {
                                color: var(--danger);
                                margin-left: 3px;
                            }

                            .form-group input,
                            .form-group select,
                            .form-group textarea {
                                width: 100%;
                                padding: 12px 16px;
                                border: 2px solid var(--border);
                                border-radius: 12px;
                                font-size: 0.95rem;
                                font-family: 'Outfit', sans-serif;
                                color: var(--text-dark);
                                background: #fafbfe;
                                outline: none;
                                transition: 0.25s;
                            }

                            .form-group input:focus,
                            .form-group select:focus,
                            .form-group textarea:focus {
                                border-color: var(--primary-light);
                                background: white;
                                box-shadow: 0 0 0 4px rgba(21, 101, 192, 0.08);
                            }

                            .form-group input.auto-calc {
                                background: linear-gradient(135deg, #e3f2fd 0%, #f3e5f5 100%);
                                font-weight: 700;
                                color: var(--primary-dark);
                                cursor: not-allowed;
                            }

                            .agg-display {
                                display: flex;
                                align-items: center;
                                gap: 12px;
                            }

                            .agg-display input {
                                flex: 1;
                            }

                            .agg-badge {
                                background: linear-gradient(135deg, var(--primary), var(--accent));
                                color: white;
                                padding: 6px 14px;
                                border-radius: 20px;
                                font-size: 0.8rem;
                                font-weight: 800;
                                white-space: nowrap;
                            }

                            .info-tip {
                                font-size: 0.75rem;
                                color: var(--text-muted);
                                margin-top: 5px;
                            }

                            .form-actions {
                                display: flex;
                                gap: 15px;
                                margin-top: 30px;
                            }

                            .btn-save {
                                background: linear-gradient(135deg, #e65100, #ff6d00);
                                color: white;
                                border: none;
                                padding: 15px 40px;
                                border-radius: 14px;
                                font-weight: 800;
                                font-size: 1rem;
                                cursor: pointer;
                                flex: 1;
                                display: flex;
                                align-items: center;
                                justify-content: center;
                                gap: 10px;
                                transition: 0.3s;
                                box-shadow: 0 6px 20px rgba(230, 81, 0, 0.3);
                            }

                            .btn-save:hover {
                                transform: translateY(-2px);
                                box-shadow: 0 10px 30px rgba(230, 81, 0, 0.4);
                            }

                            .btn-cancel {
                                background: #f1f5f9;
                                color: var(--text-muted);
                                border: 2px solid var(--border);
                                padding: 15px 30px;
                                border-radius: 14px;
                                font-weight: 700;
                                font-size: 1rem;
                                cursor: pointer;
                                transition: 0.3s;
                                text-decoration: none;
                                display: flex;
                                align-items: center;
                                gap: 8px;
                            }

                            .btn-cancel:hover {
                                background: #e2e8f0;
                            }

                            .three-col {
                                grid-template-columns: 1fr 1fr 1fr;
                            }
                        </style>
                    </head>

                    <body>

                        <div class="page-header">
                            <div class="logo-box">
                                <img src="images/sgp1.jpeg?v=6.0" alt="SGP"
                                    onerror="this.style.display='none';this.parentElement.innerHTML='<i class=\'fas fa-university\' style=\'color:var(--primary);font-size:1.5rem\'></i>'">
                            </div>
                            <div>
                                <h1>Edit Student Record</h1>
                                <p>ID: <%= studentId %> &nbsp;|&nbsp; <%= fullName %>
                                </p>
                            </div>
                            <a href="AdminDashboardServlet" class="back-btn">
                                <i class="fas fa-arrow-left"></i> Back to Dashboard
                            </a>
                        </div>

                        <div class="container">
                            <div class="edit-badge">
                                <i class="fas fa-pencil-alt"></i> EDITING RECORD
                            </div>

                            <div class="form-card">
                                <form action="AdminEditStudentServlet" method="POST" id="editForm" novalidate>
                                    <input type="hidden" name="studentId" value="<%= studentId %>">

                                    <!-- SECTION 1: PERSONAL INFORMATION -->
                                    <div class="section-header">
                                        <div class="section-icon"
                                            style="background:linear-gradient(135deg,#1565c0,#00b0ff);">
                                            <i class="fas fa-user"></i>
                                        </div>
                                        <h2>Personal Information</h2>
                                    </div>

                                    <div class="form-grid">
                                        <div class="form-group">
                                            <label>Register Number <span class="req">*</span></label>
                                            <input type="text" name="regNo" value="<%= regNo %>" required>
                                        </div>
                                        <div class="form-group">
                                            <label>Full Name <span class="req">*</span></label>
                                            <input type="text" name="fullName" value="<%= fullName %>" required>
                                        </div>
                                        <div class="form-group">
                                            <label>Gender <span class="req">*</span></label>
                                            <select name="gender" required>
                                                <option value="">— Select —</option>
                                                <option value="Male" <%="Male" .equals(gender) ? "selected" : "" %>>Male
                                                </option>
                                                <option value="Female" <%="Female" .equals(gender) ? "selected" : "" %>
                                                    >Female</option>
                                                <option value="Other" <%="Other" .equals(gender) ? "selected" : "" %>
                                                    >Other</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>Date of Birth</label>
                                            <input type="date" name="dob" value="<%= dob %>">
                                        </div>
                                        <div class="form-group">
                                            <label>Mobile Number <span class="req">*</span></label>
                                            <input type="tel" name="mobile" id="mobile" value="<%= mobile %>"
                                                maxlength="10" pattern="[6-9][0-9]{9}" required>
                                        </div>
                                        <div class="form-group">
                                            <label>Alternative Contact Number</label>
                                            <input type="tel" name="altMobile" id="altMobile" value="<%= altMobile %>"
                                                maxlength="10" pattern="[6-9][0-9]{9}">
                                        </div>
                                        <div class="form-group">
                                            <label>Email ID <span class="req">*</span></label>
                                            <input type="email" name="email" id="emailField" value="<%= emailVal %>"
                                                required>
                                        </div>
                                        <div class="form-group">
                                            <label>Preference After Diploma</label>
                                            <select name="preference">
                                                <option value="">— Select —</option>
                                                <option value="JOB" <%="JOB" .equals(preference) ? "selected" : "" %>
                                                    >Job</option>
                                                <option value="HIGHER_EDUCATION" <%="HIGHER_EDUCATION"
                                                    .equals(preference) ? "selected" : "" %>>Higher Education</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>Branch <span class="req">*</span></label>
                                            <select name="branch" required>
                                                <option value="">— Select Branch —</option>
                                                <option value="Computer Science" <%="Computer Science" .equals(branch)
                                                    ? "selected" : "" %>>Computer Science</option>
                                                <option value="Mechanical Engineering" <%="Mechanical Engineering"
                                                    .equals(branch) ? "selected" : "" %>>Mechanical Engineering</option>
                                                <option value="Civil Engineering" <%="Civil Engineering" .equals(branch)
                                                    ? "selected" : "" %>>Civil Engineering</option>
                                                <option value="Electrical & Electronics" <%="Electrical & Electronics"
                                                    .equals(branch) ? "selected" : "" %>>Electrical & Electronics
                                                </option>
                                                <option value="Metallurgy" <%="Metallurgy" .equals(branch) ? "selected"
                                                    : "" %>>Metallurgy</option>
                                                <option value="Electronics & Communication"
                                                    <%="Electronics & Communication" .equals(branch) ? "selected" : ""
                                                    %>>Electronics & Communication</option>
                                                <option value="Information Science" <%="Information Science"
                                                    .equals(branch) ? "selected" : "" %>>Information Science</option>
                                            </select>
                                        </div>
                                        <div class="form-group full">
                                            <label>Address</label>
                                            <textarea name="address" rows="2"><%= address %></textarea>
                                        </div>
                                    </div>

                                    <!-- SECTION 2: ACADEMIC DETAILS -->
                                    <div class="section-header">
                                        <div class="section-icon"
                                            style="background:linear-gradient(135deg,#6a1b9a,#ab47bc);">
                                            <i class="fas fa-graduation-cap"></i>
                                        </div>
                                        <h2>Academic Details</h2>
                                    </div>

                                    <div class="form-grid">
                                        <div class="form-group">
                                            <label>SSLC %</label>
                                            <input type="number" step="0.01" min="0" max="100" name="sslc"
                                                value="<%= sslcPct > 0 ? sslcPct : "" %>">
                                        </div>
                                        <div class="form-group">
                                            <label>SSLC Passing Year</label>
                                            <input type="number" name="sslcYear"
                                                value="<%= sslcYear > 0 ? sslcYear : "" %>">
                                        </div>
                                        <div class="form-group">
                                            <label>PUC %</label>
                                            <input type="number" step="0.01" min="0" max="100" name="puc"
                                                value="<%= pucPct > 0 ? pucPct : "" %>">
                                        </div>
                                        <div class="form-group">
                                            <label>PUC Passing Year</label>
                                            <input type="number" name="pucYear"
                                                value="<%= pucYear > 0 ? pucYear : "" %>">
                                        </div>
                                        <div class="form-group">
                                            <label>ITI %</label>
                                            <input type="number" step="0.01" min="0" max="100" name="iti"
                                                value="<%= itiPct > 0 ? itiPct : "" %>">
                                        </div>
                                        <div class="form-group">
                                            <label>ITI Passing Year</label>
                                            <input type="number" name="itiYear"
                                                value="<%= itiYear > 0 ? itiYear : "" %>">
                                        </div>
                                    </div>

                                    <!-- Semester section -->
                                    <div class="section-header" style="margin-top:25px;">
                                        <div class="section-icon"
                                            style="background:linear-gradient(135deg,#00695c,#26a69a);">
                                            <i class="fas fa-book-open"></i>
                                        </div>
                                        <h2>Diploma Semester Marks</h2>
                                    </div>

                                    <div class="form-grid three-col">
                                        <div class="form-group">
                                            <label>1st Semester %</label>
                                            <input type="number" step="0.01" min="0" max="100" name="sem1" id="sem1"
                                                value="<%= sem1 > 0 ? sem1 : "" %>" oninput="calcAggregate()">
                                        </div>
                                        <div class="form-group">
                                            <label>2nd Semester %</label>
                                            <input type="number" step="0.01" min="0" max="100" name="sem2" id="sem2"
                                                value="<%= sem2 > 0 ? sem2 : "" %>" oninput="calcAggregate()">
                                        </div>
                                        <div class="form-group">
                                            <label>3rd Semester %</label>
                                            <input type="number" step="0.01" min="0" max="100" name="sem3" id="sem3"
                                                value="<%= sem3 > 0 ? sem3 : "" %>" oninput="calcAggregate()">
                                        </div>
                                        <div class="form-group">
                                            <label>4th Semester %</label>
                                            <input type="number" step="0.01" min="0" max="100" name="sem4" id="sem4"
                                                value="<%= sem4 > 0 ? sem4 : "" %>" oninput="calcAggregate()">
                                        </div>
                                        <div class="form-group" style="grid-column:span 2;">
                                            <label>Diploma Aggregate % <span
                                                    style="color:var(--accent);">(Auto-calculated)</span></label>
                                            <div class="agg-display">
                                                <input type="number" step="0.01" name="diploma" id="diplomaAgg"
                                                    class="auto-calc" value="<%= diplomaPct > 0 ? diplomaPct : "" %>"
                                                    readonly>
                                                <span class="agg-badge" id="aggBadge">
                                                    <%= diplomaPct> 0 ? diplomaPct + "%" : "–.–%" %>
                                                </span>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Backlogs -->
                                    <div class="section-header" style="margin-top:25px;">
                                        <div class="section-icon"
                                            style="background:linear-gradient(135deg,#b71c1c,#e53935);">
                                            <i class="fas fa-exclamation-triangle"></i>
                                        </div>
                                        <h2>Backlog Information</h2>
                                    </div>

                                    <div class="form-grid">
                                        <div class="form-group">
                                            <label>Number of Current Backlogs</label>
                                            <input type="number" name="backlogs" id="backlogs" value="<%= backlogs %>"
                                                min="0">
                                        </div>
                                        <div class="form-group">
                                            <label>History of Backlogs</label>
                                            <select name="backlogHistory">
                                                <option value="NO" <%="NO" .equals(backlogHistory) ? "selected" : "" %>
                                                    >No – Clean Academic Record</option>
                                                <option value="YES" <%="YES" .equals(backlogHistory) ? "selected" : ""
                                                    %>>Yes – Has/Had Backlogs</option>
                                            </select>
                                        </div>
                                    </div>

                                    <!-- Placement -->
                                    <div class="section-header">
                                        <div class="section-icon"
                                            style="background:linear-gradient(135deg,#e65100,#ff6d00);">
                                            <i class="fas fa-briefcase"></i>
                                        </div>
                                        <h2>Placement Information</h2>
                                    </div>

                                    <div class="form-grid">
                                        <div class="form-group">
                                            <label>Placed Company</label>
                                            <input type="text" name="placedCompany" value="<%= placedCompany %>"
                                                placeholder="Leave blank if not placed">
                                        </div>
                                    </div>

                                    <div class="form-actions">
                                        <a href="AdminDashboardServlet" class="btn-cancel">
                                            <i class="fas fa-times"></i> Cancel
                                        </a>
                                        <button type="submit" class="btn-save" onclick="return validateForm()">
                                            <i class="fas fa-save"></i> Update Student Record
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <script>
                            // Initialize aggregate on page load
                            window.onload = () => calcAggregate(true);

                            function calcAggregate(initial = false) {
                                const s1 = parseFloat(document.getElementById('sem1').value) || 0;
                                const s2 = parseFloat(document.getElementById('sem2').value) || 0;
                                const s3 = parseFloat(document.getElementById('sem3').value) || 0;
                                const s4 = parseFloat(document.getElementById('sem4').value) || 0;
                                let count = 0, total = 0;
                                if (s1 > 0) { count++; total += s1; }
                                if (s2 > 0) { count++; total += s2; }
                                if (s3 > 0) { count++; total += s3; }
                                if (s4 > 0) { count++; total += s4; }
                                const aggField = document.getElementById('diplomaAgg');
                                const badge = document.getElementById('aggBadge');
                                if (count > 0) {
                                    const avg = (total / count).toFixed(2);
                                    aggField.value = avg;
                                    badge.textContent = avg + '%';
                                    badge.style.background = avg >= 60
                                        ? 'linear-gradient(135deg,#00695c,#26a69a)'
                                        : avg >= 45
                                            ? 'linear-gradient(135deg,#e65100,#ff6d00)'
                                            : 'linear-gradient(135deg,#b71c1c,#e53935)';
                                } else if (!initial) {
                                    aggField.value = '';
                                    badge.textContent = '–.–%';
                                }
                            }

                            function validateForm() {
                                const email = document.getElementById('emailField').value.trim();
                                const mobile = document.getElementById('mobile').value.trim();
                                const altMobile = document.getElementById('altMobile').value.trim();
                                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                                const mobileRegex = /^[6-9][0-9]{9}$/;
                                if (email && !emailRegex.test(email)) {
                                    alert('Please enter a valid Email ID.');
                                    return false;
                                }
                                if (mobile && !mobileRegex.test(mobile)) {
                                    alert('Mobile must be 10 digits starting with 6-9.');
                                    return false;
                                }
                                if (altMobile && !mobileRegex.test(altMobile)) {
                                    alert('Alt. mobile must be 10 digits starting with 6-9.');
                                    return false;
                                }
                                return true;
                            }
                        </script>
                    </body>

                    </html>