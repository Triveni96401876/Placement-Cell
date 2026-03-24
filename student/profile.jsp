<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.placementcell.model.Student" %>
        <% Student student=(Student) session.getAttribute("student"); if (student==null) {
            response.sendRedirect("login.jsp"); return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Update Profile | SGP Placement Cell</title>
                <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <style>
                    :root {
                        --primary: #00a8ff;
                        --primary-dark: #0097e6;
                        --bg-light: #f5f6fa;
                        --white: #ffffff;
                        --text-dark: #2f3640;
                        --text-muted: #7f8fa6;
                        --border-color: #edeff2;
                        --shadow: 0 8px 32px 0 rgba(0, 168, 255, 0.08);
                    }

                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                        font-family: 'Poppins', sans-serif;
                    }

                    body {
                        background: var(--bg-light);
                        color: var(--text-dark);
                        min-height: 100vh;
                        padding-bottom: 2rem;
                    }

                    .header {
                        background: var(--white);
                        height: 70px;
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                        padding: 0 5%;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                    }

                    .logo {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        text-decoration: none;
                        color: var(--primary);
                        font-weight: 700;
                    }

                    .container {
                        max-width: 900px;
                        margin: 2rem auto;
                        padding: 0 20px;
                    }

                    .profile-card {
                        background: var(--white);
                        border-radius: 20px;
                        box-shadow: var(--shadow);
                        overflow: hidden;
                    }

                    .card-header {
                        background: var(--primary);
                        color: white;
                        padding: 2rem;
                        text-align: center;
                    }

                    .form-body {
                        padding: 2rem;
                    }

                    .section-title {
                        font-size: 1.1rem;
                        font-weight: 700;
                        color: var(--primary);
                        margin: 2rem 0 1rem;
                        border-bottom: 2px solid var(--bg-light);
                        padding-bottom: 10px;
                    }

                    .grid {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 1.5rem;
                    }

                    .sem-grid {
                        display: grid;
                        grid-template-columns: repeat(3, 1fr);
                        gap: 1rem;
                    }

                    .form-group {
                        display: flex;
                        flex-direction: column;
                        gap: 6px;
                        margin-bottom: 1rem;
                    }

                    .form-group label {
                        font-weight: 600;
                        font-size: 0.85rem;
                        color: var(--text-muted);
                    }

                    .form-group input,
                    .form-group select,
                    .form-group textarea {
                        padding: 10px 14px;
                        border: 2px solid var(--border-color);
                        border-radius: 10px;
                        outline: none;
                        transition: 0.3s;
                        font-size: 0.9rem;
                    }

                    .form-group input:focus {
                        border-color: var(--primary);
                        background: #f0faff;
                    }

                    .btn-update {
                        background: var(--primary);
                        color: white;
                        border: none;
                        padding: 15px;
                        border-radius: 50px;
                        font-weight: 700;
                        cursor: pointer;
                        width: 100%;
                        margin-top: 2rem;
                        transition: 0.3s;
                    }

                    .btn-update:hover {
                        background: var(--primary-dark);
                        transform: translateY(-2px);
                    }

                    .back-btn {
                        display: inline-flex;
                        align-items: center;
                        gap: 5px;
                        text-decoration: none;
                        color: var(--text-muted);
                        font-weight: 600;
                        margin-bottom: 1.5rem;
                        transition: 0.3s;
                    }

                    .back-btn:hover {
                        color: var(--primary);
                    }
                </style>
            </head>

            <body>
                <header class="header">
                    <a href="<%= request.getContextPath() %>/DashboardServlet" class="logo">
                        <img src="../images/sgp1.jpeg" width="40" height="40" style="border-radius: 5px;">
                        SGP PLACEMENT CELL
                    </a>
                    <div class="user-info">
                        <span style="font-weight: 600;">Account Settings</span>
                    </div>
                </header>

                <div class="container">
                    <a href="<%= request.getContextPath() %>/DashboardServlet" class="back-btn"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>

                    <div class="profile-card">
                        <div class="card-header">
                            <h2>Update Your Profile</h2>
                            <p>Ensure your academic database details are correct</p>
                        </div>

                        <form action="<%= request.getContextPath() %>/UpdateProfileServlet" method="POST" class="form-body">
                            <!-- Personal -->
                            <div class="section-title"><i class="fas fa-user-edit"></i> 1. Personal Info</div>
                            <div class="grid">
                                <div class="form-group">
                                    <label>Full Name</label>
                                    <input type="text" name="fullName" value="<%= student.getFullName() %>" required>
                                </div>
                                <div class="form-group">
                                    <label>D.O.B</label>
                                    <input type="date" name="dob" value="<%= student.getDateOfBirth() %>">
                                </div>
                                <div class="form-group">
                                    <label>Mobile Number</label>
                                    <input type="tel" name="mobile" value="<%= student.getMobileNumber() %>"
                                        maxlength="10" minlength="10" pattern="[0-9]{10}" required>
                                </div>
                                <div class="form-group">
                                    <label>Alt Mobile Number</label>
                                    <input type="tel" name="altMobile" maxlength="10" minlength="10" pattern="[0-9]{10}"
                                        value="<%= (student.getAlternativeMobileNumber()!=null)?student.getAlternativeMobileNumber():"" %>">
                                </div>
                                <div class="form-group" style="grid-column: span 2;">
                                    <label>Address</label>
                                    <textarea name="address"
                                        rows="2"><%= (student.getAddress()!=null)?student.getAddress():"" %></textarea>
                                </div>
                            </div>

                            <!-- Schooling -->
                            <div class="section-title"><i class="fas fa-school"></i> 2. Schooling Details</div>
                            <div class="grid">
                                <div class="form-group">
                                    <label>SSLC %</label>
                                    <input type="number" step="0.01" name="sslc"
                                        value="<%= student.getSslcPercentage() %>">
                                </div>
                                <div class="form-group">
                                    <label>SSLC Year</label>
                                    <input type="number" name="sslcYear" value="<%= student.getSslcYear() %>">
                                </div>
                                <div class="form-group">
                                    <label>PUC %</label>
                                    <input type="number" step="0.01" name="puc"
                                        value="<%= student.getPucPercentage() %>">
                                </div>
                                <div class="form-group">
                                    <label>PUC Year</label>
                                    <input type="number" name="pucYear" value="<%= student.getPucYear() %>">
                                </div>
                            </div>

                            <!-- Diploma -->
                            <div class="section-title"><i class="fas fa-graduation-cap"></i> 3. Diploma Semesters</div>
                            <div class="sem-grid">
                                <div class="form-group"><label>S1 (%)</label><input type="number" step="0.01"
                                        name="sem1" value="<%= student.getSem1() %>"></div>
                                <div class="form-group"><label>S2 (%)</label><input type="number" step="0.01"
                                        name="sem2" value="<%= student.getSem2() %>"></div>
                                <div class="form-group"><label>S3 (%)</label><input type="number" step="0.01"
                                        name="sem3" value="<%= student.getSem3() %>"></div>
                                <div class="form-group"><label>S4 (%)</label><input type="number" step="0.01"
                                        name="sem4" value="<%= student.getSem4() %>"></div>
                                <div class="form-group"><label>S5 (%)</label><input type="number" step="0.01"
                                        name="sem5" value="<%= student.getSem5() %>"></div>
                                <div class="form-group"><label>S6 (%)</label><input type="number" step="0.01"
                                        name="sem6" value="<%= student.getSem6() %>"></div>
                            </div>
                            <div class="grid">
                                <div class="form-group">
                                    <label>Aggregate CGPA</label>
                                    <input type="number" step="0.01" name="cgpa" value="<%= student.getCgpa() %>"
                                        required>
                                </div>
                                <div class="form-group">
                                    <label>Backlog History</label>
                                    <input type="text" name="backlogHistory"
                                        value="<%= (student.getBacklogHistory()!=null)?student.getBacklogHistory():"" %>">
                                </div>
                            </div>

                            <!-- Professional -->
                            <div class="section-title"><i class="fas fa-tools"></i> 4. Professional</div>
                            <div class="form-group">
                                <label>Skills (Comma separated)</label>
                                <input type="text" name="skills"
                                    value="<%= (student.getSkills() != null) ? student.getSkills() : "" %>">
                            </div>

                            <button type="submit" class="btn-update" id="submitBtn"
                                style="background:#2ecc71; height: 60px; font-size: 1.2rem; box-shadow: 0 10px 20px rgba(46, 204, 113, 0.3);">Commit
                                Changes & Save</button>
                        </form>
                    </div>
                </div>

                <script>
                    document.querySelector('form').onsubmit = function () {
                        const btn = document.getElementById('submitBtn');
                        btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Committing to Database...';
                        btn.style.background = '#27ae60';
                        btn.style.opacity = '0.8';
                        btn.style.pointerEvents = 'none';
                    };
                </script>
            </body>

            </html>