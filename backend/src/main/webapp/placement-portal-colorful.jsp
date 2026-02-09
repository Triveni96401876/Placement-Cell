<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.placementcell.model.Student" %>
        <% Student student=(Student) request.getAttribute("studentData"); String welcomeName=(student !=null) ?
            student.getWelcomeName() : "Student" ; String fullName=(student !=null) ? student.getFullName() : "Student"
            ; String regNo=(student !=null) ? student.getRegisterNumber() : "N/A" ; String branch=(student !=null) ?
            student.getBranch() : "N/A" ; String mobile=(student !=null) ? student.getMobileNumber() : "N/A" ; //
            Academic details Double cgpa=(student !=null) ? student.getCgpa() : 0.0; Double sslc=(student !=null) ?
            student.getSslcPercentage() : 0.0; Double puc=(student !=null) ? student.getPucPercentage() : 0.0; String
            skills=(student !=null && student.getSkills() !=null) ? student.getSkills() : "No skills updated" ; %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>SGP Placement Portal | <%= welcomeName %>
                </title>
                <!-- CSS -->
                <link rel="stylesheet" href="css/placement-colorful.css">
                <!-- Font Awesome -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <style>
                    .stat-badge {
                        background: rgba(0, 168, 255, 0.1);
                        color: #00a8ff;
                        padding: 5px 12px;
                        border-radius: 20px;
                        font-size: 0.85rem;
                        font-weight: 700;
                    }

                    .skills-tag {
                        display: inline-block;
                        background: #f1f2f6;
                        color: #2f3640;
                        padding: 4px 10px;
                        border-radius: 6px;
                        font-size: 0.8rem;
                        margin: 2px;
                        border: 1px solid #dcdde1;
                    }
                </style>
            </head>

            <body>

                <header class="header">
                    <div class="logo-area">
                        <img src="images/sgp1.jpeg" alt="SGP Logo" class="header-logo"
                            onerror="this.src='https://via.placeholder.com/40x40?text=SGP'">
                        <span class="app-name">SGP PLACEMENT CELL</span>
                    </div>
                    <div class="header-right">
                        <span id="user-display" style="font-weight: 600; margin-right: 15px;">Welcome, <%= welcomeName
                                %>
                        </span>
                        <div class="header-btns">
                            <a href="LogoutServlet" class="header-btn logout-btn">Logout</a>
                        </div>
                        <div class="menu-icon"><i class="fas fa-bars"></i></div>
                    </div>
                </header>

                <div class="container">
                    <aside class="sidebar">
                        <nav class="nav-menu">
                            <a href="#" class="nav-item active">
                                <i class="fas fa-th-large"></i> Dashboard
                            </a>
                            <a href="profile.jsp" class="nav-item">
                                <i class="fas fa-user-circle"></i> Account
                            </a>
                            <a href="#" class="nav-item">
                                <i class="fas fa-bullhorn"></i> Circulars
                            </a>
                            <a href="#about-college" class="nav-item" style="margin-top: 2rem;">
                                <i class="fas fa-university"></i> About SGP
                            </a>
                        </nav>
                    </aside>

                    <main class="main-content">
                        <h1 class="welcome-title" id="welcome-header">Hello, <%= welcomeName %>!</h1>

                        <div class="dashboard-grid">
                            <!-- Left Main Section -->
                            <div class="left-section">
                                <div class="feature-row">
                                    <div class="feature-box box-resume" onclick="window.location.href='profile.jsp'"
                                        style="cursor: pointer;">
                                        <i class="fas fa-file-invoice fa-2x"></i>
                                        Resume Update
                                    </div>
                                    <div class="feature-box box-locker" style="cursor: pointer;">
                                        <i class="fas fa-shield-alt fa-2x"></i>
                                        Digi Locker
                                    </div>
                                </div>

                                <div class="info-card">
                                    <div class="card-header">
                                        <h3>Personal Details</h3>
                                        <button class="btn-edit" onclick="window.location.href='profile.jsp'"><i
                                                class="fas fa-edit"></i> Edit</button>
                                    </div>
                                    <div
                                        style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; font-size: 0.95rem;">
                                        <p><strong>Name:</strong>
                                            <%= fullName %>
                                        </p>
                                        <p><strong>ID:</strong>
                                            <%= regNo %>
                                        </p>
                                        <p><strong>Branch:</strong>
                                            <%= (branch !=null && branch.equals("CS")) ? "Computer Science" : branch %>
                                        </p>
                                        <p><strong>Contact:</strong>
                                            <%= mobile %>
                                        </p>
                                    </div>
                                </div>

                                <!-- Academic Performance Card -->
                                <div class="info-card">
                                    <div class="card-header">
                                        <h3>Academic Performance</h3>
                                        <span class="stat-badge">Current CGPA: <%= cgpa %></span>
                                    </div>
                                    <div
                                        style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 10px;">
                                        <div
                                            style="text-align: center; padding: 10px; background: #f8f9fa; border-radius: 10px;">
                                            <div style="font-size: 0.8rem; color: #7f8fa6;">SSLC %</div>
                                            <div style="font-size: 1.2rem; font-weight: 700; color: #2f3640;">
                                                <%= sslc %>%
                                            </div>
                                        </div>
                                        <div
                                            style="text-align: center; padding: 10px; background: #f8f9fa; border-radius: 10px;">
                                            <div style="font-size: 0.8rem; color: #7f8fa6;">PUC/Diploma %</div>
                                            <div style="font-size: 1.2rem; font-weight: 700; color: #2f3640;">
                                                <%= puc %>%
                                            </div>
                                        </div>
                                    </div>
                                    <div style="margin-top: 20px;">
                                        <h4 style="font-size: 0.9rem; margin-bottom: 8px; color: #7f8fa6;">Key Skills:
                                        </h4>
                                        <div>
                                            <% for(String skill : skills.split(",")) { %>
                                                <span class="skills-tag">
                                                    <%= skill.trim() %>
                                                </span>
                                                <% } %>
                                        </div>
                                    </div>
                                </div>

                                <div id="about-college" class="college-about">
                                    <h3>About Sanjay Gandhi Polytechnic</h3>
                                    <p style="margin-top: 10px; font-size: 0.9rem; line-height: 1.6; color: #4b5563;">
                                        Established in 1991, SGP Ballari is a premier technical institution committed to
                                        empowering students with quality education. With state-of-the-art labs and
                                        expert faculty, we bridge the gap between academia and industry.</p>
                                </div>
                            </div>

                            <!-- Right Side Section -->
                            <div class="right-section">
                                <div class="info-card">
                                    <div class="card-header">
                                        <h3>Latest Circulars</h3>
                                        <i class="fas fa-bullhorn" style="color: var(--primary);"></i>
                                    </div>
                                    <div style="margin-top: 15px; max-height: 250px; overflow-y: auto;">
                                        <% java.util.List<String> circularList = (java.util.List<String>)
                                                request.getAttribute("circulars");
                                                if (circularList != null && !circularList.isEmpty()) {
                                                for (String msg : circularList) {
                                                %>
                                                <div
                                                    style="padding: 12px; border-radius: 8px; background: #f0faff; border-left: 4px solid var(--primary); margin-bottom: 10px; font-size: 0.85rem;">
                                                    <%= msg %>
                                                </div>
                                                <% } } else { %>
                                                    <p style="text-align: center; color: #7f8fa6; font-size: 0.85rem;">
                                                        No active circulars at the moment.</p>
                                                    <% } %>
                                    </div>
                                </div>

                                <div class="info-card">
                                    <h3>Upcoming Events</h3>
                                    <ul style="list-style: none; margin-top: 15px; font-size: 0.85rem;">
                                        <li
                                            style="margin-bottom: 12px; border-bottom: 1px solid var(--secondary); padding-bottom: 8px;">
                                            <i class="fas fa-calendar-check"
                                                style="color: var(--primary); margin-right: 8px;"></i> JSW Campus Drive
                                            - Feb 10
                                        </li>
                                        <li style="padding-top: 4px;">
                                            <i class="fas fa-calendar-check"
                                                style="color: var(--primary); margin-right: 8px;"></i> Seminar on AI -
                                            Feb 15
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </main>
                </div>

            </body>

            </html>