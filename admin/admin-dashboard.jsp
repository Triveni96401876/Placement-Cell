<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.placementcell.model.Student" %>
            <%@ page import="com.placementcell.model.User" %>
                <% User user=(User) session.getAttribute("user"); if (user==null || !"ADMIN".equals(user.getRole())) {
                    response.sendRedirect("login.html"); return; } List<Student> students = (List<Student>)
                        request.getAttribute("studentList");
                        Integer totalStudents = (Integer) request.getAttribute("totalStudents");
                        Integer activeDrives = (Integer) request.getAttribute("activeDrives");
                        Integer placedStudents = (Integer) request.getAttribute("placedStudents");
                        Integer totalCirculars = (Integer) request.getAttribute("totalCirculars");

                        if (totalStudents == null) totalStudents = 0;
                        if (placedStudents == null) placedStudents = 0;
                        if (totalCirculars == null) totalCirculars = 0;
                        %>
                        <!DOCTYPE html>
                        <html lang="en">

                        <head>
                            <meta charset="UTF-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <title>Nayeem Basha | Admin Dashboard | SGP Placement Cell</title>
                            <link
                                href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap"
                                rel="stylesheet">
                            <link rel="stylesheet"
                                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                            <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
                            <style>
                                :root {
                                    --primary: #4361ee;
                                    --secondary: #3f37c9;
                                    --bg: #f8f9fe;
                                    --sidebar-width: 240px;
                                    --card-shadow: 0 10px 30px rgba(0, 0, 0, 0.04);
                                    --transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
                                }

                                * {
                                    margin: 0;
                                    padding: 0;
                                    box-sizing: border-box;
                                    font-family: 'Plus Jakarta Sans', sans-serif;
                                }

                                body {
                                    background-color: var(--bg);
                                    color: #1a1c2d;
                                    min-height: 100vh;
                                    margin: 0;
                                    padding: 0;
                                    overflow-x: hidden;
                                    scrollbar-gutter: stable;
                                }

                                /* Sidebar Styling */
                                .sidebar {
                                    width: var(--sidebar-width);
                                    background: white;
                                    border-right: 1px solid #edf2f7;
                                    padding: 1rem 1.25rem;
                                    display: flex;
                                    flex-direction: column;
                                    position: fixed;
                                    top: 0;
                                    left: 0;
                                    height: 100vh;
                                    z-index: 1000;
                                }

                                .sidebar-brand {
                                    display: flex;
                                    align-items: center;
                                    gap: 12px;
                                    margin-bottom: 1.5rem;
                                    padding: 0 0.5rem;
                                }

                                .sidebar-brand img {
                                    width: 45px;
                                    height: 45px;
                                    border-radius: 12px;
                                    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                                }

                                .sidebar-brand span {
                                    font-weight: 800;
                                    font-size: 1.35rem;
                                    letter-spacing: -0.5px;
                                    color: #1a1c2d;
                                }

                                .nav-menu {
                                    list-style: none;
                                    flex: 1;
                                }

                                .nav-item {
                                    margin-bottom: 0.5rem;
                                }

                                .nav-link {
                                    display: flex;
                                    align-items: center;
                                    gap: 12px;
                                    padding: 0.6rem 0.85rem;
                                    text-decoration: none;
                                    color: #718096;
                                    font-weight: 600;
                                    border-radius: 14px;
                                    transition: var(--transition);
                                }

                                .nav-link:hover {
                                    background: #f7fafc;
                                    color: var(--primary);
                                }

                                .nav-link.active {
                                    background: #eef2ff;
                                    color: var(--primary);
                                }

                                .nav-link i {
                                    font-size: 1.2rem;
                                    width: 24px;
                                }

                                .btn-signout {
                                    margin-top: auto;
                                    background: #ff4d4d;
                                    color: white;
                                    border: none;
                                    padding: 1rem;
                                    border-radius: 16px;
                                    font-weight: 700;
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    gap: 10px;
                                    cursor: pointer;
                                    text-decoration: none;
                                    transition: var(--transition);
                                    box-shadow: 0 4px 15px rgba(255, 77, 77, 0.2);
                                }

                                .btn-signout:hover {
                                    background: #e60000;
                                    transform: translateY(-2px);
                                }

                                /* Main Content */
                                .main-content {
                                    margin-left: var(--sidebar-width);
                                    padding: 1.5rem 2rem;
                                    min-height: 100vh;
                                    position: relative;
                                    width: auto;
                                    max-width: 100%;
                                }

                                /* Top Header */
                                .top-header {
                                    display: flex;
                                    justify-content: space-between;
                                    align-items: center;
                                    margin-bottom: 0.75rem;
                                }

                                .search-bar {
                                    background: white;
                                    padding: 0.75rem 1.5rem;
                                    border-radius: 14px;
                                    display: flex;
                                    align-items: center;
                                    gap: 12px;
                                    width: 450px;
                                    box-shadow: var(--card-shadow);
                                    border: 1px solid transparent;
                                    transition: var(--transition);
                                }

                                .search-bar:focus-within {
                                    border-color: var(--primary);
                                    box-shadow: 0 0 0 4px rgba(67, 97, 238, 0.1);
                                }

                                .search-bar input {
                                    border: none;
                                    outline: none;
                                    width: 100%;
                                    font-size: 0.95rem;
                                    font-weight: 500;
                                }

                                .admin-profile {
                                    display: flex;
                                    align-items: center;
                                    gap: 15px;
                                }

                                .profile-info {
                                    text-align: right;
                                }

                                .profile-info h4 {
                                    font-weight: 700;
                                    font-size: 0.95rem;
                                }

                                .profile-info p {
                                    font-size: 0.75rem;
                                    color: #718096;
                                    font-weight: 600;
                                }

                                .profile-avatar {
                                    width: 45px;
                                    height: 45px;
                                    background: var(--primary);
                                    color: white;
                                    border-radius: 12px;
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    font-weight: 700;
                                    font-size: 1.1rem;
                                    box-shadow: 0 4px 12px rgba(67, 97, 238, 0.3);
                                }

                                /* Dashboard Titles */
                                .page-title {
                                    font-size: 1.8rem;
                                    font-weight: 800;
                                    letter-spacing: -1px;
                                    margin-bottom: 1.5rem;
                                    color: #1a1c2d;
                                }

                                /* Stats Cards */
                                .stats-grid {
                                    display: grid;
                                    grid-template-columns: repeat(3, 1fr);
                                    gap: 2rem;
                                    margin-bottom: 2.5rem;
                                }

                                .stat-card {
                                    background: white;
                                    padding: 2rem;
                                    border-radius: 24px;
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    gap: 1.5rem;
                                    height: 150px;
                                    box-shadow: var(--card-shadow);
                                    transition: var(--transition);
                                }

                                .stat-card:hover {
                                    transform: translateY(-5px);
                                }

                                .stat-icon {
                                    width: 70px;
                                    height: 70px;
                                    border-radius: 20px;
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    font-size: 1.75rem;
                                }

                                .icon-blue {
                                    background: #eef2ff;
                                    color: #4361ee;
                                }

                                .icon-green {
                                    background: #ecfdf5;
                                    color: #10b981;
                                }

                                .icon-purple {
                                    background: #f5f3ff;
                                    color: #8b5cf6;
                                }

                                .icon-yellow {
                                    background: #fffbeb;
                                    color: #f59e0b;
                                }

                                .backlog-count {
                                    font-size: 0.8rem;
                                    font-weight: 700;
                                }

                                .has-backlogs {
                                    color: #ef4444;
                                }

                                .no-backlogs {
                                    color: #10b981;
                                }

                                .stat-details h3 {
                                    font-size: 2.5rem;
                                    font-weight: 800;
                                    line-height: 1;
                                    margin-bottom: 8px;
                                }

                                .stat-details p {
                                    font-size: 0.95rem;
                                    color: #718096;
                                    font-weight: 700;
                                    text-transform: uppercase;
                                    letter-spacing: 1px;
                                }

                                /* Filters Section */
                                .content-card {
                                    background: white;
                                    border-radius: 24px;
                                    padding: 0.75rem 1rem;
                                    box-shadow: var(--card-shadow);
                                }

                                .section-header {
                                    margin-bottom: 0.5rem;
                                }

                                .section-header h2 {
                                    font-size: 1.5rem;
                                    font-weight: 800;
                                    letter-spacing: -0.5px;
                                }

                                .filter-grid {
                                    display: grid;
                                    grid-template-columns: repeat(3, 1fr);
                                    gap: 0.6rem;
                                    margin-bottom: 0.6rem;
                                }

                                .form-group {
                                    display: flex;
                                    flex-direction: column;
                                    gap: 8px;
                                }

                                .form-group label {
                                    font-size: 0.85rem;
                                    font-weight: 700;
                                    color: #4a5568;
                                }

                                .form-select,
                                .form-input {
                                    background: #f7fafc;
                                    border: 1.5px solid #edf2f7;
                                    padding: 0.6rem 1rem;
                                    border-radius: 12px;
                                    font-weight: 600;
                                    color: #2d3748;
                                    outline: none;
                                    transition: var(--transition);
                                }

                                .form-select:focus,
                                .form-input:focus {
                                    background: white;
                                    border-color: var(--primary);
                                    box-shadow: 0 0 0 4px rgba(67, 97, 238, 0.05);
                                }

                                .btn-apply {
                                    grid-column: span 3;
                                    background: var(--primary);
                                    color: white;
                                    border: none;
                                    padding: 0.7rem;
                                    border-radius: 14px;
                                    font-weight: 700;
                                    cursor: pointer;
                                    transition: var(--transition);
                                    margin-top: 0.25rem;
                                }

                                .btn-apply:hover {
                                    background: var(--secondary);
                                    box-shadow: 0 8px 20px rgba(67, 97, 238, 0.2);
                                }

                                /* Table Styling */
                                .table-responsive {
                                    margin-top: 1.5rem;
                                    overflow-x: auto;
                                }

                                table {
                                    width: 100%;
                                    border-collapse: separate;
                                    border-spacing: 0 8px;
                                }

                                th {
                                    text-align: left;
                                    padding: 0.75rem 1rem;
                                    font-size: 0.85rem;
                                    font-weight: 800;
                                    color: #a0aec0;
                                    text-transform: uppercase;
                                    letter-spacing: 1px;
                                }

                                td {
                                    padding: 1rem;
                                    background: #fdfdff;
                                    border-top: 1px solid #f7fafc;
                                    border-bottom: 1px solid #f7fafc;
                                    font-weight: 600;
                                    font-size: 0.95rem;
                                }

                                td:first-child {
                                    border-left: 1px solid #f7fafc;
                                    border-radius: 16px 0 0 16px;
                                }

                                td:last-child {
                                    border-right: 1px solid #f7fafc;
                                    border-radius: 0 16px 16px 0;
                                }

                                .tr-hover:hover td {
                                    background: #f8faff;
                                    border-color: #eef2ff;
                                }

                                .status-badge {
                                    padding: 6px 14px;
                                    border-radius: 100px;
                                    font-size: 0.75rem;
                                    font-weight: 800;
                                }

                                .status-placed {
                                    background: #ecfdf5;
                                    color: #10b981;
                                }

                                .status-pending {
                                    background: #fff7ed;
                                    color: #f97316;
                                }

                                .btn-action {
                                    width: 36px;
                                    height: 36px;
                                    border-radius: 10px;
                                    display: inline-flex;
                                    align-items: center;
                                    justify-content: center;
                                    text-decoration: none;
                                    transition: var(--transition);
                                }

                                .btn-view {
                                    background: #eef2ff;
                                    color: var(--primary);
                                }

                                .btn-view:hover {
                                    background: var(--primary);
                                    color: white;
                                }

                                .export-btn {
                                    background: #10b981;
                                    color: white;
                                    border: none;
                                    padding: 0.6rem 1.2rem;
                                    border-radius: 10px;
                                    font-weight: 700;
                                    font-size: 0.85rem;
                                    cursor: pointer;
                                    display: flex;
                                    align-items: center;
                                    gap: 8px;
                                    margin-left: auto;
                                }
                            </style>
                        </head>

                        <body>
                            <!-- Sidebar -->
                            <aside class="sidebar">
                                <div class="sidebar-brand">
                                    <img src="images/sgp1.jpeg" alt="Logo">
                                    <span>SGP ADMIN</span>
                                </div>

                                <ul class="nav-menu">
                                    <li class="nav-item">
                                        <a href="AdminDashboardServlet" class="nav-link active">
                                            <i class="fas fa-th-large"></i> Dashboard
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="AdminDashboardServlet" class="nav-link">
                                            <i class="fas fa-database"></i> Student Records
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="admin-push-circular.jsp" class="nav-link">
                                            <i class="fas fa-bullhorn"></i> Push Circular
                                        </a>
                                    </li>
                                </ul>

                                <a href="LogoutServlet" class="btn-signout">
                                    <i class="fas fa-sign-out-alt"></i> Sign Out
                                </a>
                            </aside>

                            <!-- Main Content -->
                            <main class="main-content">
                                <!-- Admin Profile -->
                                <div
                                    style="display: flex; align-items: center; gap: 20px; margin-bottom: 2.5rem; background: white; padding: 0 40px; border-radius: 28px; box-shadow: var(--card-shadow); border: 1px solid #f1f5f9; width: fit-content; height: 150px;">
                                    <div
                                        style="width: 80px; height: 80px; background: var(--primary); color: white; border-radius: 22px; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 2rem; box-shadow: 0 8px 20px rgba(67, 97, 238, 0.3);">
                                        NB</div>
                                    <div>
                                        <h4 style="font-weight: 800; font-size: 1.6rem; color: #1a1c2d; margin: 0;">
                                            Nayeem Basha</h4>
                                        <p style="font-size: 1.1rem; color: #718096; font-weight: 600; margin: 0;">
                                            Training & Placement Officer</p>
                                    </div>
                                </div>

                                <!-- Page Title -->
                                <div style="margin-bottom: 2.5rem;">
                                    <h1 class="page-title" style="margin-bottom: 0.25rem;">Admin Records Dashboard</h1>
                                    <p style="color: #718096; font-weight: 600; font-size: 1rem;">Manage and monitor
                                        student placement progress</p>
                                </div>

                                <!-- Stats Grid -->
                                <div class="stats-grid">
                                    <div class="stat-card">
                                        <div class="stat-icon icon-blue">
                                            <i class="fas fa-user-graduate"></i>
                                        </div>
                                        <div class="stat-details">
                                            <h3>
                                                <%= totalStudents %>
                                            </h3>
                                            <p>Total Students</p>
                                        </div>
                                    </div>
                                    <div class="stat-card">
                                        <div class="stat-icon icon-green">
                                            <i class="fas fa-check-circle"></i>
                                        </div>
                                        <div class="stat-details">
                                            <h3>
                                                <%= placedStudents %>
                                            </h3>
                                            <p>Placed Students</p>
                                        </div>
                                    </div>
                                    <a href="AdminViewCircularsServlet" class="stat-card"
                                        style="text-decoration: none;">
                                        <div class="stat-icon icon-yellow">
                                            <i class="fas fa-file-alt"></i>
                                        </div>
                                        <div class="stat-details">
                                            <h3>
                                                <%= totalCirculars %>
                                            </h3>
                                            <p>Circulars Released</p>
                                        </div>
                                    </a>
                                </div>

                                <!-- Student Database Section -->
                                <div class="content-card"
                                    style="padding: 2.5rem; border-radius: 28px; box-shadow: var(--card-shadow); background: white;">
                                    <div class="section-header"
                                        style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2.5rem; min-height: 80px;">
                                        <h2
                                            style="font-size: 1.8rem; font-weight: 800; display: flex; align-items: center; gap: 15px;">
                                            <i class="fas fa-database"
                                                style="color: var(--primary); font-size: 2rem;"></i> Student
                                            Database
                                        </h2>
                                        <button class="export-btn" onclick="exportToExcel()"
                                            style="padding: 12px 24px; border-radius: 14px; font-weight: 700; background: #10b981; color: white; border: none; cursor: pointer; display: flex; align-items: center; gap: 10px; font-size: 1rem;">
                                            <i class="fas fa-file-excel"></i> Export Selected
                                        </button>
                                    </div>

                                    <form action="AdminDashboardServlet" method="GET">
                                        <div class="filter-grid"
                                            style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 1.5rem; margin-bottom: 1.5rem; background: #f8fafc; padding: 1.5rem; border-radius: 18px;">
                                            <div class="form-group">
                                                <label
                                                    style="font-size: 0.9rem; font-weight: 700; margin-bottom: 0.5rem; display: block; color: #4a5568;">Placement
                                                    Status</label>
                                                <select name="placementStatus"
                                                    style="width: 100%; padding: 12px; border-radius: 10px; border: 1px solid #e2e8f0; font-weight: 600;">
                                                    <option value="">All Status</option>
                                                    <option value="PLACED">Placed</option>
                                                    <option value="UNPLACED">Not Placed</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label
                                                    style="font-size: 0.9rem; font-weight: 700; margin-bottom: 0.5rem; display: block; color: #4a5568;">Preference</label>
                                                <select name="preference"
                                                    style="width: 100%; padding: 12px; border-radius: 10px; border: 1px solid #e2e8f0; font-weight: 600;">
                                                    <option value="">All Preferences</option>
                                                    <option value="Job">Job Only</option>
                                                    <option value="Higher Education">Higher Education</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label
                                                    style="font-size: 0.9rem; font-weight: 700; margin-bottom: 0.5rem; display: block; color: #4a5568;">Backlogs</label>
                                                <select name="backlogs"
                                                    style="width: 100%; padding: 12px; border-radius: 10px; border: 1px solid #e2e8f0; font-weight: 600;">
                                                    <option value="">Any Backlogs</option>
                                                    <option value="0">No Backlogs</option>
                                                    <option value="1">1 or More</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label
                                                    style="font-size: 0.9rem; font-weight: 700; margin-bottom: 0.5rem; display: block; color: #4a5568;">Register
                                                    Number</label>
                                                <input type="text" name="regNo"
                                                    style="width: 100%; padding: 12px; border-radius: 10px; border: 1px solid #e2e8f0; font-weight: 600;"
                                                    placeholder="Search Reg No...">
                                            </div>
                                            <div class="form-group">
                                                <label
                                                    style="font-size: 0.9rem; font-weight: 700; margin-bottom: 0.5rem; display: block; color: #4a5568;">Branch</label>
                                                <select name="branch"
                                                    style="width: 100%; padding: 12px; border-radius: 10px; border: 1px solid #e2e8f0; font-weight: 600;">
                                                    <option value="">All Branches</option>
                                                    <option value="Civil">Civil Engineering</option>
                                                    <option value="Computer Science">Computer Science</option>
                                                    <option value="Electrical & Electronics">Electrical & Electronics
                                                    </option>
                                                    <option value="Mechanical">Mechanical Engineering</option>
                                                    <option value="Metallurgy">Metallurgy</option>
                                                </select>
                                            </div>
                                            <div style="display: flex; align-items: flex-end;">
                                                <button type="submit" class="btn-apply"
                                                    style="width: 100%; height: 30px; background: var(--primary); color: white; border: none; border-radius: 12px; font-weight: 800; cursor: pointer; display: flex; align-items: center; justify-content: center; gap: 8px;">
                                                    <i class="fas fa-filter"></i> Apply Filters
                                                </button>
                                            </div>
                                        </div>
                                    </form>

                                    <div class="table-responsive">
                                        <table id="studentTable">
                                            <thead>
                                                <tr>
                                                    <th>Sl No</th>
                                                    <th>Reg No</th>
                                                    <th>Full Name</th>
                                                    <th>Branch</th>
                                                    <th>Preference</th>
                                                    <th>Email address</th>
                                                    <th>Address</th>
                                                    <th>SSLC %</th>
                                                    <th>Sem1</th>
                                                    <th>Sem2</th>
                                                    <th>Sem3</th>
                                                    <th>Sem4</th>
                                                    <th>Sem5</th>
                                                    <th>Sem6</th>
                                                    <th>CGPA</th>
                                                    <th>Backlogs</th>
                                                    <th>Mobile</th>
                                                    <th>Status</th>
                                                    <th>Internship</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% String ST_PLACED="PLACED" ; String CL_PLACED="status-placed" ; String
                                                    CL_PENDING="status-pending" ; String VAL_PENDING="PENDING" ; if
                                                    (students !=null && !students.isEmpty()) { int slNo=1; for (Student
                                                    s : students) { %>
                                                    <tr class="tr-hover">
                                                        <td style="font-size: 0.75rem; color: #a0aec0;">
                                                            <%= slNo++ %>
                                                        </td>
                                                        <td style="color: var(--primary); font-weight: 800;">
                                                            <%= s.getRegisterNumber() %>
                                                        </td>
                                                        <td title="<%= s.getEmail() %>">
                                                            <%= s.getFullName() %>
                                                        </td>
                                                        <td style="font-size: 0.8rem; color: #4a5568;">
                                                            <%= s.getBranch() %>
                                                        </td>
                                                        <td>
                                                            <span
                                                                style="font-size: 0.75rem; background: #f0f4ff; color: #4361ee; padding: 4px 10px; border-radius: 8px; font-weight: 700;">
                                                                <%= (s.getPreference() !=null) ? s.getPreference()
                                                                    : "Job" %>
                                                            </span>
                                                        </td>
                                                        <td style="font-size: 0.8rem; color: #4a5568;">
                                                            <%= s.getEmail() !=null ? s.getEmail() : "-" %>
                                                        </td>
                                                        <td style="font-size: 0.8rem; color: #4a5568; max-width: 150px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"
                                                            title="<%= s.getAddress() %>">
                                                            <%= s.getAddress() !=null ? s.getAddress() : "-" %>
                                                        </td>
                                                        <td style="font-size: 0.8rem; color: #4a5568;">
                                                            <%= s.getSslcPercentage() !=null ? s.getSslcPercentage()
                                                                + "%" : "-" %>
                                                        </td>
                                                        <td style="font-size: 0.8rem; color: #4a5568;">
                                                            <%= s.getSem1() !=null ? s.getSem1() : "-" %>
                                                        </td>
                                                        <td style="font-size: 0.8rem; color: #4a5568;">
                                                            <%= s.getSem2() !=null ? s.getSem2() : "-" %>
                                                        </td>
                                                        <td style="font-size: 0.8rem; color: #4a5568;">
                                                            <%= s.getSem3() !=null ? s.getSem3() : "-" %>
                                                        </td>
                                                        <td style="font-size: 0.8rem; color: #4a5568;">
                                                            <%= s.getSem4() !=null ? s.getSem4() : "-" %>
                                                        </td>
                                                        <td style="font-size: 0.8rem; color: #4a5568;">
                                                            <%= s.getSem5() !=null ? s.getSem5() : "-" %>
                                                        </td>
                                                        <td style="font-size: 0.8rem; color: #4a5568;">
                                                            <%= s.getSem6() !=null ? s.getSem6() : "-" %>
                                                        </td>
                                                        <td style="font-weight: 700;">
                                                            <%= s.getCgpa() %>
                                                        </td>
                                                        <td>
                                                            <% int bCount=(s.getBacklogCount() !=null) ?
                                                                s.getBacklogCount() : 0; String bClass=(bCount> 0) ?
                                                                "has-backlogs" : "no-backlogs";
                                                                %>
                                                                <span class="backlog-count <%= bClass %>">
                                                                    <%= bCount %>
                                                                </span>
                                                        </td>
                                                        <td style="color: #718096; font-size: 0.8rem;">
                                                            <%= s.getMobileNumber() !=null ? s.getMobileNumber() : "-"
                                                                %>
                                                        </td>
                                                        <td>
                                                            <div
                                                                class="status-badge <%= ST_PLACED.equals(s.getPlacementStatus()) ? CL_PLACED : CL_PENDING %>">
                                                                <%= s.getPlacementStatus() !=null ?
                                                                    s.getPlacementStatus() : VAL_PENDING %>
                                                            </div>
                                                            <% if (ST_PLACED.equals(s.getPlacementStatus()) &&
                                                                s.getPlacedCompany() !=null) { %>
                                                                <div
                                                                    style="font-size: 0.65rem; color: #10b981; margin-top: 2px; font-weight: 700;">
                                                                    <%= s.getPlacedCompany() %>
                                                                </div>
                                                                <% } %>
                                                        </td>
                                                        <td
                                                            style="font-size: 0.75rem; color: #4361ee; font-weight: 700;">
                                                            <%= s.getInternship() !=null ? s.getInternship() : "-" %>
                                                        </td>
                                                        <td>
                                                            <div style="display: flex; gap: 8px;">
                                                                <a href="AdminEditStudentServlet?id=<%= s.getId() %>"
                                                                    class="btn-action btn-view" title="Edit Student">
                                                                    <i class="fas fa-edit"></i>
                                                                </a>
                                                                <% if (s.getResumePath() !=null &&
                                                                    !s.getResumePath().isEmpty()) { %>
                                                                    <a href="<%= request.getContextPath() %>/ViewDocument?file=<%= s.getResumePath() %>"
                                                                        target="_blank" class="btn-action btn-view"
                                                                        title="Resume">
                                                                        <i class="fas fa-file-pdf"></i>
                                                                    </a>
                                                                    <% } %>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <% } } else { %>
                                                        <tr>
                                                            <td colspan="19"
                                                                style="text-align: center; padding: 3rem; color: #a0aec0;">
                                                                No students found matching your criteria.</td>
                                                        </tr>
                                                        <% } %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </main>

                            <script>
                                function exportToExcel() {
                                    var table = document.getElementById("studentTable");
                                    var wb = XLSX.utils.table_to_book(table, { sheet: "Students List" });
                                    XLSX.writeFile(wb, "SGP_Admin_Database.xlsx");
                                }
                            </script>
                        </body>

                        </html>