<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.placementcell.model.Student" %>
        <% Student student=(Student) request.getAttribute("studentData"); if (student==null) {
            response.sendRedirect("login.jsp"); return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Student Dashboard | SGP Placement Cell</title>
                <!-- Google Fonts -->
                <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">
                <!-- Font Awesome -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <!-- Custom CSS -->
                <link rel="stylesheet" href="css/dashboard.css">
            </head>

            <body>

                <!-- Sidebar -->
                <div class="sidebar">
                    <h2>SGP Cell</h2>
                    <ul class="nav-links">
                        <li class="active"><i class="fas fa-home"></i> <a href="#">Dashboard</a></li>
                        <li><i class="fas fa-user-edit"></i> <a href="#">Edit Profile</a></li>
                        <li><i class="fas fa-file-invoice"></i> <a href="#">My Resume</a></li>
                        <li><i class="fas fa-briefcase"></i> <a href="#">Jobs Applied</a></li>
                        <li><i class="fas fa-cog"></i> <a href="#">Settings</a></li>
                    </ul>
                </div>

                <!-- Main Content -->
                <div class="main-content">
                    <header
                        style="display: flex; justify-content: flex-end; border-bottom: 2px solid #edeff2; padding-bottom: 1rem; margin-bottom: 2rem;">
                        <h1 style="margin:0; font-weight: 700; color: var(--primary-color); font-size: 1.1rem;">Welcome,
                            <%= student.getWelcomeName() %>! 👋
                        </h1>
                    </header>

                    <!-- Stats Grid -->
                    <div class="dashboard-grid">

                        <!-- Profile Summary Card -->
                        <div class="card">
                            <h3><i class="fas fa-id-card"></i> Profile Summary</h3>
                            <div class="profile-info">
                                <p><strong>Register No:</strong> <span>
                                        <%= student.getRegisterNumber() %>
                                    </span></p>
                                <p><strong>Branch:</strong> <span>
                                        <%= student.getBranch() %>
                                    </span></p>
                                <p><strong>Mobile:</strong> <span>
                                        <%= student.getMobileNumber() %>
                                    </span></p>
                                <p><strong>CGPA:</strong> <span style="color: var(--secondary); font-weight: bold;">
                                        <%= student.getCgpa() %>
                                    </span></p>
                            </div>
                        </div>

                        <!-- Academic Progress Card -->
                        <div class="card">
                            <h3><i class="fas fa-graduation-cap"></i> Academic Highlights</h3>
                            <label>SSLC Percentage</label>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: <%= student.getSslcPercentage() %>%"></div>
                            </div>

                            <label>PUC Percentage</label>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: <%= student.getPucPercentage() %>%"></div>
                            </div>

                            <label>Current CGPA</label>
                            <div class="skill-bar">
                                <div class="skill-progress" style="width: <%= (student.getCgpa() / 10.0) * 100 %>%">
                                </div>
                            </div>
                        </div>

                        <!-- Resume Quick View Card -->
                        <div class="card"
                            style="display: flex; flex-direction: column; justify-content: space-between;">
                            <div>
                                <h3><i class="fas fa-magic"></i> AI Resume</h3>
                                <p style="font-size: 0.9rem; color: #666;">Your professional resume is automatically
                                    generated based on your profile and academic data.</p>
                                <div style="background: var(--bg); padding: 10px; border-radius: 10px; margin: 10px 0;">
                                    <span style="font-size: 0.8rem; font-weight: bold;">SKILLS:</span><br>
                                    <span style="font-size: 0.8rem;">
                                        <%= (student.getSkills() !=null) ? student.getSkills() : "No skills added yet"
                                            %>
                                    </span>
                                </div>
                            </div>
                            <a href="#" class="btn-premium">View Full Resume <i class="fas fa-arrow-right"></i></a>
                        </div>

                    </div>

                    <!-- Recent Activity Section -->
                    <div class="card" style="margin-top: 2rem;">
                        <h3><i class="fas fa-bullhorn"></i> Important Announcements</h3>
                        <ul style="list-style: none; padding: 0;">
                            <li style="padding: 10px 0; border-bottom: 1px solid #eee;">
                                <span
                                    style="background: #e1f5fe; color: #01579b; padding: 2px 8px; border-radius: 4px; font-size: 0.8rem; margin-right: 10px;">New</span>
                                JSW Campus Drive started for Mechanical and Civil branches. Check eligibility list.
                            </li>
                            <li style="padding: 10px 0;">
                                <span
                                    style="background: #fff3e0; color: #e65100; padding: 2px 8px; border-radius: 4px; font-size: 0.8rem; margin-right: 10px;">Alert</span>
                                Please complete your profile details to be eligible for the upcoming IT drives.
                            </li>
                        </ul>
                    </div>
                </div>

            </body>

            </html>