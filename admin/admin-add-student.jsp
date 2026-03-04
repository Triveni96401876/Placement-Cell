<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Student | SGP PlacementCell – SGP Ballari</title>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
            rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary-light) 60%, var(--accent) 100%);
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
                letter-spacing: 0.5px;
            }

            .page-header p {
                font-size: 0.85rem;
                color: rgba(255, 255, 255, 0.8);
            }

            .page-header .back-btn {
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

            .page-header .back-btn:hover {
                background: rgba(255, 255, 255, 0.25);
            }

            .container {
                max-width: 1100px;
                margin: 35px auto;
                padding: 0 20px 60px;
            }

            .msg-success {
                background: #e8f5e9;
                border-left: 5px solid var(--success);
                color: #1b5e20;
                padding: 15px 25px;
                border-radius: 10px;
                margin-bottom: 25px;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .msg-error {
                background: #ffebee;
                border-left: 5px solid var(--danger);
                color: #b71c1c;
                padding: 15px 25px;
                border-radius: 10px;
                margin-bottom: 25px;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 10px;
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

            .form-group.third {
                grid-column: span 1;
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

            .form-actions {
                display: flex;
                gap: 15px;
                margin-top: 30px;
            }

            .btn-submit {
                background: linear-gradient(135deg, var(--primary-dark), var(--primary-light));
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
                box-shadow: 0 6px 20px rgba(21, 101, 192, 0.3);
            }

            .btn-submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 30px rgba(21, 101, 192, 0.4);
            }

            .btn-reset {
                background: #f1f5f9;
                color: var(--text-muted);
                border: 2px solid var(--border);
                padding: 15px 30px;
                border-radius: 14px;
                font-weight: 700;
                font-size: 1rem;
                cursor: pointer;
                transition: 0.3s;
            }

            .btn-reset:hover {
                background: #e2e8f0;
            }

            .three-col {
                grid-template-columns: 1fr 1fr 1fr;
            }

            .info-tip {
                font-size: 0.75rem;
                color: var(--text-muted);
                margin-top: 5px;
            }

            @media (max-width: 768px) {
                .form-grid {
                    grid-template-columns: 1fr;
                }

                .form-group.full,
                .form-group.third {
                    grid-column: span 1;
                }

                .container {
                    padding: 0 15px 40px;
                }

                .page-header {
                    padding: 15px 20px;
                }
            }
        </style>
    </head>

    <body>

        <div class="page-header">
            <div class="logo-box">
                <img src="images/sgp1.jpeg?v=6.0" alt="SGP Logo"
                    onerror="this.style.display='none';this.parentElement.innerHTML='<i class=\'fas fa-university\' style=\'color:var(--primary);font-size:1.5rem\'></i>'">
            </div>
            <div>
                <h1>Add New Student Record</h1>
                <p>Sanjay Gandhi Polytechnic, Ballari – Civil Department</p>
            </div>
            <a href="AdminDashboardServlet" class="back-btn">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>

        <div class="container">

            <% String err=request.getParameter("error"); String msg=request.getParameter("msg"); if ("1".equals(err)
                || "db" .equals(err)) { %>
                <div class="msg-error">
                    <i class="fas fa-exclamation-circle"></i>
                    <span>Failed to save student record. Please check all fields and try again.</span>
                </div>
                <% } %>
                    <% if ("added".equals(msg)) { %>
                        <div class="msg-success">
                            <i class="fas fa-check-circle"></i>
                            <span>Student record saved successfully!</span>
                        </div>
                        <% } %>

                            <div class="form-card">
                                <form action="AdminAddStudentServlet" method="POST" id="addStudentForm" novalidate>

                                    <!-- ========== SECTION 1: PERSONAL INFORMATION ========== -->
                                    <div class="section-header">
                                        <div class="section-icon"
                                            style="background: linear-gradient(135deg,#1565c0,#00b0ff);">
                                            <i class="fas fa-user"></i>
                                        </div>
                                        <div>
                                            <h2>Personal Information</h2>
                                        </div>
                                    </div>

                                    <div class="form-grid">
                                        <div class="form-group">
                                            <label>Register Number <span class="req">*</span></label>
                                            <input type="text" name="regNo" id="regNo" placeholder="e.g. 459CE21001"
                                                required pattern="[A-Za-z0-9]+" title="Alphanumeric only">
                                        </div>
                                        <div class="form-group">
                                            <label>Full Name <span class="req">*</span></label>
                                            <input type="text" name="fullName" placeholder="Student's Full Name"
                                                required>
                                        </div>
                                        <div class="form-group">
                                            <label>Gender <span class="req">*</span></label>
                                            <select name="gender" required>
                                                <option value="">— Select Gender —</option>
                                                <option value="Male">Male</option>
                                                <option value="Female">Female</option>
                                                <option value="Other">Other</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>Date of Birth <span class="req">*</span></label>
                                            <input type="date" name="dob" required>
                                        </div>
                                        <div class="form-group">
                                            <label>Mobile Number <span class="req">*</span></label>
                                            <input type="tel" name="mobile" id="mobile"
                                                placeholder="10-digit mobile number" maxlength="10"
                                                pattern="[6-9][0-9]{9}" required
                                                title="Must be a valid 10-digit Indian mobile number">
                                            <p class="info-tip">10 digits only, starting with 6–9</p>
                                        </div>
                                        <div class="form-group">
                                            <label>Alternative Contact Number</label>
                                            <input type="tel" name="altMobile" id="altMobile"
                                                placeholder="Alternative 10-digit number" maxlength="10"
                                                pattern="[6-9][0-9]{9}"
                                                title="Must be a valid 10-digit Indian mobile number">
                                        </div>
                                        <div class="form-group">
                                            <label>Email ID <span class="req">*</span></label>
                                            <input type="email" name="email" id="email"
                                                placeholder="student@example.com" required>
                                        </div>
                                        <div class="form-group">
                                            <label>Preference After Diploma <span class="req">*</span></label>
                                            <select name="preference" required>
                                                <option value="">— Select Preference —</option>
                                                <option value="JOB">Job</option>
                                                <option value="HIGHER_EDUCATION">Higher Education</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>Branch <span class="req">*</span></label>
                                            <select name="branch" required>
                                                <option value="">— Select Branch —</option>
                                                <option value="Computer Science">Computer Science</option>
                                                <option value="Mechanical Engineering">Mechanical Engineering</option>
                                                <option value="Civil Engineering">Civil Engineering</option>
                                                <option value="Electrical & Electronics">Electrical & Electronics
                                                </option>
                                                <option value="Metallurgy">Metallurgy</option>
                                                <option value="Electronics & Communication">Electronics & Communication
                                                </option>
                                                <option value="Information Science">Information Science</option>
                                            </select>
                                        </div>
                                        <div class="form-group full">
                                            <label>Address</label>
                                            <textarea name="address" rows="2"
                                                placeholder="Full residential address..."></textarea>
                                        </div>
                                    </div>

                                    <!-- ========== SECTION 2: ACADEMIC DETAILS ========== -->
                                    <div class="section-header">
                                        <div class="section-icon"
                                            style="background: linear-gradient(135deg,#6a1b9a,#ab47bc);">
                                            <i class="fas fa-graduation-cap"></i>
                                        </div>
                                        <div>
                                            <h2>Academic Details</h2>
                                        </div>
                                    </div>

                                    <div class="form-grid">
                                        <div class="form-group">
                                            <label>SSLC % <span class="req">*</span></label>
                                            <input type="number" step="0.01" min="0" max="100" name="sslc"
                                                placeholder="e.g. 78.50" required>
                                        </div>
                                        <div class="form-group">
                                            <label>SSLC Passing Year</label>
                                            <input type="number" name="sslcYear" placeholder="e.g. 2019" min="2000"
                                                max="2030">
                                        </div>
                                        <div class="form-group">
                                            <label>PUC % (if applicable)</label>
                                            <input type="number" step="0.01" min="0" max="100" name="puc"
                                                placeholder="e.g. 65.00">
                                        </div>
                                        <div class="form-group">
                                            <label>PUC Passing Year</label>
                                            <input type="number" name="pucYear" placeholder="e.g. 2021" min="2000"
                                                max="2030">
                                        </div>
                                        <div class="form-group">
                                            <label>ITI % (if applicable)</label>
                                            <input type="number" step="0.01" min="0" max="100" name="iti"
                                                placeholder="e.g. 72.00">
                                        </div>
                                        <div class="form-group">
                                            <label>ITI Passing Year</label>
                                            <input type="number" name="itiYear" placeholder="e.g. 2021" min="2000"
                                                max="2030">
                                        </div>
                                    </div>

                                    <!-- Semester Marks -->
                                    <div class="section-header" style="margin-top:25px;">
                                        <div class="section-icon"
                                            style="background: linear-gradient(135deg,#00695c,#26a69a);">
                                            <i class="fas fa-book-open"></i>
                                        </div>
                                        <div>
                                            <h2>Diploma Semester Marks</h2>
                                        </div>
                                    </div>

                                    <div class="form-grid three-col">
                                        <div class="form-group">
                                            <label>1st Semester %</label>
                                            <input type="number" step="0.01" min="0" max="100" name="sem1" id="sem1"
                                                placeholder="e.g. 72.5" oninput="calcAggregate()">
                                        </div>
                                        <div class="form-group">
                                            <label>2nd Semester %</label>
                                            <input type="number" step="0.01" min="0" max="100" name="sem2" id="sem2"
                                                placeholder="e.g. 68.0" oninput="calcAggregate()">
                                        </div>
                                        <div class="form-group">
                                            <label>3rd Semester %</label>
                                            <input type="number" step="0.01" min="0" max="100" name="sem3" id="sem3"
                                                placeholder="e.g. 75.0" oninput="calcAggregate()">
                                        </div>
                                        <div class="form-group">
                                            <label>4th Semester %</label>
                                            <input type="number" step="0.01" min="0" max="100" name="sem4" id="sem4"
                                                placeholder="e.g. 80.5" oninput="calcAggregate()">
                                        </div>
                                        <div class="form-group" style="grid-column: span 2;">
                                            <label>Diploma Aggregate % <span
                                                    style="color:var(--accent);">(Auto-calculated)</span></label>
                                            <div class="agg-display">
                                                <input type="number" step="0.01" name="diploma" id="diplomaAgg"
                                                    class="auto-calc" placeholder="Auto-calculated from semesters"
                                                    readonly>
                                                <span class="agg-badge" id="aggBadge">–.–%</span>
                                            </div>
                                            <p class="info-tip">Automatically calculated from Sem 1–4 marks entered
                                                above</p>
                                        </div>
                                    </div>

                                    <!-- Backlogs -->
                                    <div class="section-header" style="margin-top:25px;">
                                        <div class="section-icon"
                                            style="background: linear-gradient(135deg,#b71c1c,#e53935);">
                                            <i class="fas fa-exclamation-triangle"></i>
                                        </div>
                                        <div>
                                            <h2>Backlog Information</h2>
                                        </div>
                                    </div>

                                    <div class="form-grid">
                                        <div class="form-group">
                                            <label>Number of Current Backlogs</label>
                                            <input type="number" name="backlogs" id="backlogs" value="0" min="0"
                                                oninput="updateBacklogHistory()">
                                        </div>
                                        <div class="form-group">
                                            <label>History of Backlogs</label>
                                            <select name="backlogHistory" id="backlogHistory">
                                                <option value="NO">No – Clean Academic Record</option>
                                                <option value="YES">Yes – Has/Had Backlogs</option>
                                            </select>
                                        </div>
                                    </div>

                                    <!-- ========== SECTION 3: PLACEMENT INFO ========== -->
                                    <div class="section-header">
                                        <div class="section-icon"
                                            style="background: linear-gradient(135deg,#e65100,#ff6d00);">
                                            <i class="fas fa-briefcase"></i>
                                        </div>
                                        <div>
                                            <h2>Placement Information</h2>
                                        </div>
                                    </div>

                                    <div class="form-grid">
                                        <div class="form-group">
                                            <label>Placed Company</label>
                                            <input type="text" name="placedCompany"
                                                placeholder="Company name (leave blank if not placed)">
                                            <p class="info-tip">Leave blank if student is not yet placed</p>
                                        </div>
                                    </div>

                                    <div class="form-actions">
                                        <button type="reset" class="btn-reset" onclick="resetForm()">
                                            <i class="fas fa-redo"></i> Reset Form
                                        </button>
                                        <button type="submit" class="btn-submit" id="submitBtn"
                                            onclick="return validateForm()">
                                            <i class="fas fa-save"></i> Save Student Record
                                        </button>
                                    </div>
                                </form>
                            </div>
        </div>

        <script>
            function calcAggregate() {
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
                } else {
                    aggField.value = '';
                    badge.textContent = '–.–%';
                    badge.style.background = 'linear-gradient(135deg,#1565c0,#00b0ff)';
                }
            }

            function updateBacklogHistory() {
                const bl = parseInt(document.getElementById('backlogs').value) || 0;
                if (bl > 0) {
                    document.getElementById('backlogHistory').value = 'YES';
                }
            }

            function resetForm() {
                document.getElementById('diplomaAgg').value = '';
                document.getElementById('aggBadge').textContent = '–.–%';
                document.getElementById('aggBadge').style.background = 'linear-gradient(135deg,#1565c0,#00b0ff)';
            }

            function validateForm() {
                const email = document.getElementById('email').value.trim();
                const mobile = document.getElementById('mobile').value.trim();
                const altMobile = document.getElementById('altMobile').value.trim();

                // Email validation
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (email && !emailRegex.test(email)) {
                    alert('Please enter a valid Email ID.');
                    document.getElementById('email').focus();
                    return false;
                }

                // Mobile validation
                const mobileRegex = /^[6-9][0-9]{9}$/;
                if (mobile && !mobileRegex.test(mobile)) {
                    alert('Mobile number must be exactly 10 digits and start with 6-9.');
                    document.getElementById('mobile').focus();
                    return false;
                }

                // Alt mobile validation
                if (altMobile && !mobileRegex.test(altMobile)) {
                    alert('Alternative number must be exactly 10 digits and start with 6-9.');
                    document.getElementById('altMobile').focus();
                    return false;
                }

                return true;
            }
        </script>
    </body>

    </html>