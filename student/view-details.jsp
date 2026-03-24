<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.placementcell.model.Student" %>
        <% Student student=(Student) request.getAttribute("studentData"); if (student==null) {
            response.sendRedirect("DashboardServlet?error=not_found"); return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Student Details | <%= student.getFullName() %>
                </title>
                <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <style>
                    :root {
                        --primary: #00a8ff;
                        --white: #ffffff;
                        --text-dark: #2d3436;
                        --text-muted: #636e72;
                        --bg: #f8faff;
                        --card-bg: #ffffff;
                        --accent: #6c5ce7;
                    }

                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                        font-family: 'Outfit', sans-serif;
                    }

                    body {
                        background-color: var(--bg);
                        color: var(--text-dark);
                        line-height: 1.6;
                    }

                    .container {
                        max-width: 1000px;
                        margin: 50px auto;
                        padding: 0 20px;
                    }

                    .back-link {
                        display: inline-flex;
                        align-items: center;
                        gap: 10px;
                        color: var(--primary);
                        text-decoration: none;
                        font-weight: 700;
                        margin-bottom: 25px;
                        transition: 0.3s;
                    }

                    .back-link:hover {
                        transform: translateX(-5px);
                    }

                    .profile-header {
                        background: var(--card-bg);
                        padding: 40px;
                        border-radius: 30px;
                        display: flex;
                        align-items: center;
                        gap: 30px;
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                        margin-bottom: 30px;
                    }

                    .avatar-large {
                        width: 120px;
                        height: 120px;
                        background: linear-gradient(135deg, var(--primary), var(--accent));
                        color: white;
                        border-radius: 30px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 3rem;
                        font-weight: 800;
                    }

                    .header-info h1 {
                        font-size: 2.2rem;
                        font-weight: 800;
                        margin-bottom: 5px;
                    }

                    .badge {
                        display: inline-block;
                        padding: 6px 15px;
                        border-radius: 50px;
                        font-size: 0.85rem;
                        font-weight: 700;
                        background: rgba(0, 168, 255, 0.1);
                        color: var(--primary);
                        margin-top: 10px;
                    }

                    .details-grid {
                        display: grid;
                        grid-template-columns: repeat(2, 1fr);
                        gap: 25px;
                    }

                    .details-section {
                        background: var(--card-bg);
                        padding: 35px;
                        border-radius: 30px;
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                    }

                    .section-title {
                        font-size: 1.25rem;
                        font-weight: 800;
                        margin-bottom: 25px;
                        display: flex;
                        align-items: center;
                        gap: 12px;
                        color: var(--text-dark);
                    }

                    .section-title i {
                        color: var(--primary);
                    }

                    .info-list {
                        list-style: none;
                    }

                    .info-item {
                        margin-bottom: 15px;
                        display: flex;
                        flex-direction: column;
                    }

                    .info-item label {
                        font-size: 0.8rem;
                        font-weight: 700;
                        text-transform: uppercase;
                        color: var(--text-muted);
                        letter-spacing: 0.5px;
                    }

                    .info-item span {
                        font-size: 1.1rem;
                        font-weight: 500;
                        color: var(--text-dark);
                    }

                    .full-width {
                        grid-column: span 2;
                    }

                    @media (max-width: 768px) {
                        .details-grid {
                            grid-template-columns: 1fr;
                        }

                        .full-width {
                            grid-column: span 1;
                        }

                        .profile-header {
                            flex-direction: column;
                            text-align: center;
                        }
                    }
                </style>
            </head>

            <body>
                <div class="container">
                    <a href="DashboardServlet" class="back-link">
                        <i class="fas fa-arrow-left"></i> Back to Dashboard
                    </a>

                    <div class="profile-header">
                        <div class="avatar-large">
                            <%= student.getFullName().substring(0, 1) %>
                        </div>
                        <div
                            style="color: red; font-size: 2rem; font-weight: 800; position: absolute; top: 10px; right: 20px;">
                            v4</div>
                        <div class="header-info">
                            <h1>
                                <%= student.getFullName() %>
                            </h1>
                            <p style="color: var(--text-muted); font-weight: 500;">
                                <%= student.getRegisterNumber() %> • <%= student.getBranch() %>
                            </p>
                            <span class="badge">Student Profile</span>
                            <div style="margin-top: 15px;">
                                <a href="<%= request.getContextPath() %>/student/profile.jsp" class="btn"
                                    style="text-decoration: none; background: var(--primary); color: white; padding: 10px 25px; border-radius: 50px; font-weight: 700; font-size: 0.9rem; box-shadow: 0 4px 15px rgba(0, 168, 255, 0.2); transition: 0.3s; display: inline-flex; align-items: center; gap: 8px;">
                                    <i class="fas fa-edit"></i> Edit Profile
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="details-grid">
                        <div class="details-section">
                            <h3 class="section-title"><i class="fas fa-user"></i> Personal Details</h3>
                            <div class="info-list">
                                <div class="info-item">
                                    <label>Full Name</label>
                                    <span>
                                        <%= student.getFullName() %>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <label>Gender</label>
                                    <span>
                                        <%= student.getGender() %>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <label>Mobile</label>
                                    <span>
                                        <%= student.getMobileNumber() %>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <label>Address</label>
                                    <span>
                                        <%= student.getAddress() %>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="details-section">
                            <h3 class="section-title"><i class="fas fa-graduation-cap"></i> Academic Info</h3>
                            <div class="info-list">
                                <div class="info-item">
                                    <label>Current CGPA</label>
                                    <span style="font-weight: 700; color: var(--primary);">
                                        <%= student.getCgpa() %>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <label>SSLC Percentage</label>
                                    <span>
                                        <%= student.getSslcPercentage() %>% (<%= student.getSslcYear() %>)
                                    </span>
                                </div>
                                <div class="info-item">
                                    <label>Diploma Percentage</label>
                                    <span>
                                        <%= student.getDiplomaPercentage() %>% (<%= student.getDiplomaYear() %>)
                                    </span>
                                </div>
                                <div class="info-item">
                                    <label>Backlog Status</label>
                                    <span>
                                        <%= student.getBacklogStatus() %> (<%= student.getBacklogCount() %>)
                                    </span>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>

                </div>
            </body>

            </html>