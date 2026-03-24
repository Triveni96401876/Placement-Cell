<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.placementcell.model.Student" %>
            <%@ page import="com.placementcell.model.User" %>
                <% List<Student> students = (List<Student>) request.getAttribute("studentList");
                        User u = (User) session.getAttribute("user");
                        if (u == null || (!"HOD".equals(u.getRole()) && !"ADMIN".equals(u.getRole()))) {
                        response.sendRedirect("login.jsp");
                        return;
                        }
                        String userName = (String) request.getAttribute("userName");
                        Integer totalReg = (Integer) request.getAttribute("totalReg");
                        Integer activeJobsCount = (Integer) request.getAttribute("activeJobsCount");
                        Double avgCgpa = (Double) request.getAttribute("avgCgpa");
                        if (avgCgpa == null) avgCgpa = 0.0;
                        // Get branch: from HOD session user or request param
                        String hodBranch = (u.getBranch() != null && !u.getBranch().isEmpty()) ? u.getBranch().trim() :
                        null;
                        // Normalize branch: "Computer Science Engineering (CSE)" -> "CSE"
                        if (hodBranch != null) {
                        if (hodBranch.toUpperCase().contains("COMPUTER") || hodBranch.equalsIgnoreCase("CSE")) hodBranch
                        = "CSE";
                        else if (hodBranch.toUpperCase().contains("MECHANICAL") || hodBranch.equalsIgnoreCase("MECH"))
                        hodBranch = "MECH";
                        else if (hodBranch.toUpperCase().contains("CIVIL")) hodBranch = "CIVIL";
                        else if (hodBranch.toUpperCase().contains("METALLURGY") || hodBranch.equalsIgnoreCase("MT"))
                        hodBranch = "MT";
                        else if (hodBranch.toUpperCase().contains("ELECTRICAL") || hodBranch.equalsIgnoreCase("EEE"))
                        hodBranch = "EEE";
                        }
                        // Fetch job applications DIRECTLY from DB
                        java.util.List<String[]> jobApplicationsList = new java.util.ArrayList<>();
                                try (java.sql.Connection _conn = com.placementcell.util.DBConnection.getConnection()) {
                                String _sql;
                                java.sql.PreparedStatement _ps;
                                if (hodBranch != null) {
                                _sql = "SELECT student_name, register_number, branch, email, phone, company_name, job_role, applied_date, resume FROM job_applications WHERE UPPER(TRIM(branch)) LIKE ? ORDER BY applied_date DESC";
                                _ps = _conn.prepareStatement(_sql);
                                _ps.setString(1, "%" + hodBranch.toUpperCase() + "%");
                                } else {
                                _sql = "SELECT student_name, register_number, branch, email, phone, company_name, job_role, applied_date, resume FROM job_applications ORDER BY applied_date DESC";
                                _ps = _conn.prepareStatement(_sql);
                                }
                                java.sql.ResultSet _rs = _ps.executeQuery();
                                while (_rs.next()) {
                                jobApplicationsList.add(new String[]{
                                _rs.getString("student_name"),
                                _rs.getString("register_number"),
                                _rs.getString("branch"),
                                _rs.getString("email"),
                                _rs.getString("phone"),
                                _rs.getString("company_name"),
                                _rs.getString("job_role"),
                                _rs.getTimestamp("applied_date") != null ? _rs.getTimestamp("applied_date").toString() :
                                "",
                                _rs.getString("resume") != null ? _rs.getString("resume") : ""
                                });
                                }
                                _rs.close(); _ps.close();
                                } catch (java.sql.SQLException _e) { _e.printStackTrace(); }
                                String currentBranch = request.getParameter("branch");
                                if (currentBranch != null) currentBranch = currentBranch.trim();
                                String branchLow = (currentBranch != null) ? currentBranch.toLowerCase() : "";

                                // Resolve actual branch if HOD
                                if ("HOD".equals(u.getRole())) {
                                currentBranch = (String) request.getAttribute("selectedBranch");
                                if (currentBranch == null) currentBranch = u.getBranch();
                                branchLow = (currentBranch != null) ? currentBranch.toLowerCase() : "";
                                }

                                // Branch Full Names Mapping
                                String displayBranch = "Branch";
                                if ("CSE".equals(currentBranch)) displayBranch = "Computer Science Engineering (CSE)";
                                else if ("MT".equals(currentBranch)) displayBranch = "Metallurgy";
                                else if ("MECH".equals(currentBranch)) displayBranch = "Mechanical Engineering (MECH)";
                                else if ("CIVIL".equals(currentBranch)) displayBranch = "Civil Engineering (CIVIL)";
                                else if ("EEE".equals(currentBranch)) displayBranch = "Electrical and Electronics Engineering (EEE)";
                                else if (currentBranch != null) displayBranch = currentBranch;

                                String dashClass = (currentBranch == null || currentBranch.isEmpty()) ? "active" : "";
                                String cseClass = branchLow.contains("computer") ? "active" : "";
                                String ceClass = branchLow.contains("civil") ? "active" : "";
                                String meClass = branchLow.contains("mechanical") ? "active" : "";
                                String mtClass = (branchLow.contains("metallurgy") || "mt".equals(branchLow) ||
                                "ece".equals(branchLow)) ? "active" : "";
                                String eeeClass = (branchLow.contains("electrical") || branchLow.contains("electronics")
                                || branchLow.contains("eee")) ? "active" : "";
                                String itClass = branchLow.contains("information") ? "active" : "";

                                %>
                                <!DOCTYPE html>
                                <html lang="en">

                                <head>
                                    <meta charset="UTF-8">
                                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                    <meta http-equiv="refresh" content="60">
                                    <title>HOD Dashboard | SGP Cell</title>
                                    <link
                                        href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
                                        rel="stylesheet">
                                    <link rel="stylesheet"
                                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                                    <style>
                                        :root {
                                            --primary: #5c67f2;
                                            --primary-soft: rgba(92, 103, 242, 0.1);
                                            --bg-body: #f8fafc;
                                            --sidebar-bg: #ffffff;
                                            --text-main: #1e293b;
                                            --text-muted: #64748b;
                                            --border: #e2e8f0;
                                            --card-shadow: 0 4px 24px rgba(0, 0, 0, 0.04);
                                        }

                                        * {
                                            margin: 0;
                                            padding: 0;
                                            box-sizing: border-box;
                                            font-family: 'Plus Jakarta Sans', sans-serif;
                                        }

                                        body {
                                            background-color: var(--bg-body);
                                            color: var(--text-main);
                                            display: flex;
                                            height: 100vh;
                                            overflow: hidden;
                                        }

                                        aside {
                                            width: 280px;
                                            background: var(--sidebar-bg);
                                            border-right: 1px solid var(--border);
                                            display: flex;
                                            flex-direction: column;
                                            padding: 32px 24px;
                                            flex-shrink: 0;
                                        }

                                        .brand {
                                            display: flex;
                                            align-items: center;
                                            gap: 12px;
                                            margin-bottom: 40px;
                                            padding-left: 8px;
                                        }

                                        .brand-logo {
                                            width: 44px;
                                            height: 44px;
                                            background: #ffffff;
                                            border: 1.5px solid var(--primary);
                                            border-radius: 12px;
                                            display: flex;
                                            align-items: center;
                                            justify-content: center;
                                            padding: 4px;
                                            box-shadow: 0 4px 12px rgba(92, 103, 242, 0.15);
                                        }

                                        .brand-logo img {
                                            width: 100%;
                                            height: 100%;
                                            object-fit: contain;
                                        }

                                        .brand-name {
                                            font-weight: 800;
                                            font-size: 1.25rem;
                                            color: #1e293b;
                                            letter-spacing: -0.5px;
                                        }

                                        nav {
                                            flex: 1;
                                            display: flex;
                                            flex-direction: column;
                                            gap: 4px;
                                        }

                                        .nav-link {
                                            display: flex;
                                            align-items: center;
                                            gap: 14px;
                                            padding: 12px 16px;
                                            text-decoration: none;
                                            color: var(--text-muted);
                                            font-size: 0.95rem;
                                            font-weight: 600;
                                            border-radius: 12px;
                                            transition: all 0.2s ease;
                                        }

                                        .nav-link i {
                                            font-size: 1.1rem;
                                            width: 24px;
                                            text-align: center;
                                        }

                                        .nav-link:hover {
                                            background: #f1f5f9;
                                            color: var(--text-main);
                                        }

                                        .nav-link.active {
                                            background: var(--primary-soft);
                                            color: var(--primary);
                                        }

                                        .sidebar-label-btn {
                                            margin: 24px 0 8px 0;
                                            display: flex;
                                            align-items: center;
                                            justify-content: space-between;
                                            padding: 12px 16px;
                                            background: #f8fafc;
                                            border: 1px solid var(--border);
                                            border-radius: 12px;
                                            cursor: pointer;
                                            transition: all 0.2s ease;
                                        }

                                        .sidebar-label-btn:hover {
                                            background: #f1f5f9;
                                            border-color: var(--primary);
                                        }

                                        .sidebar-label-text {
                                            font-size: 0.85rem;
                                            font-weight: 800;
                                            color: var(--text-dark);
                                            text-transform: uppercase;
                                            letter-spacing: 0.5px;
                                        }

                                        .sidebar-label-btn i {
                                            transition: transform 0.3s ease;
                                            color: var(--text-muted);
                                        }

                                        .branch-filter-list {
                                            display: none;
                                            flex-direction: column;
                                            gap: 4px;
                                            padding: 8px 0 8px 12px;
                                            animation: slideDown 0.3s ease-out forwards;
                                        }

                                        @keyframes slideDown {
                                            from {
                                                opacity: 0;
                                                transform: translateY(-10px);
                                            }

                                            to {
                                                opacity: 1;
                                                transform: translateY(0);
                                            }
                                        }

                                        .branch-item {
                                            display: flex;
                                            align-items: center;
                                            gap: 12px;
                                            padding: 10px 16px;
                                            text-decoration: none;
                                            color: var(--text-muted);
                                            font-size: 0.88rem;
                                            font-weight: 600;
                                            border-radius: 10px;
                                            transition: all 0.2s ease;
                                        }

                                        .branch-item i {
                                            width: 20px;
                                            text-align: center;
                                            font-size: 1.0rem;
                                            opacity: 0.7;
                                        }

                                        .branch-item:hover {
                                            background: #f8fafc;
                                            color: var(--primary);
                                        }

                                        .branch-item.active {
                                            background: var(--primary-soft);
                                            color: var(--primary);
                                        }

                                        .nav-bottom {
                                            margin-top: auto;
                                            border-top: 1px solid var(--border);
                                            padding-top: 24px;
                                            display: flex;
                                            flex-direction: column;
                                            gap: 4px;
                                        }

                                        .sign-out {
                                            color: #ef4444 !important;
                                        }

                                        .sign-out:hover {
                                            background: #fef2f2;
                                        }

                                        main {
                                            flex: 1;
                                            display: flex;
                                            flex-direction: column;
                                            overflow-y: auto;
                                            padding: 40px 48px;
                                        }

                                        .header-section {
                                            margin-bottom: 32px;
                                        }

                                        .header-section h1 {
                                            font-size: 2.2rem;
                                            font-weight: 800;
                                            color: #1e293b;
                                            margin-bottom: 4px;
                                        }

                                        .header-section p {
                                            color: var(--text-muted);
                                            font-weight: 500;
                                            font-size: 1.05rem;
                                        }

                                        .stats-grid {
                                            display: grid;
                                            grid-template-columns: repeat(2, 1fr);
                                            gap: 24px;
                                            margin-bottom: 40px;
                                        }

                                        .stat-card {
                                            background: white;
                                            padding: 24px;
                                            border-radius: 24px;
                                            display: flex;
                                            align-items: center;
                                            gap: 20px;
                                            border: 1px solid rgba(0, 0, 0, 0.02);
                                            box-shadow: var(--card-shadow);
                                        }

                                        .stat-icon {
                                            width: 56px;
                                            height: 56px;
                                            border-radius: 16px;
                                            display: flex;
                                            align-items: center;
                                            justify-content: center;
                                            font-size: 1.4rem;
                                        }

                                        .icon-blue {
                                            background: #eff6ff;
                                            color: #3b82f6;
                                        }

                                        .icon-pink {
                                            background: #fdf2f8;
                                            color: #ec4899;
                                        }

                                        .icon-yellow {
                                            background: #fffbeb;
                                            color: #f59e0b;
                                        }

                                        .stat-label {
                                            display: block;
                                            font-size: 0.85rem;
                                            font-weight: 600;
                                            color: #64748b;
                                            margin-bottom: 4px;
                                        }

                                        .stat-value {
                                            display: block;
                                            font-size: 1.5rem;
                                            font-weight: 800;
                                            color: #1e293b;
                                            letter-spacing: -0.5px;
                                        }

                                        .content-card {
                                            background: white;
                                            border-radius: 24px;
                                            padding: 32px;
                                            box-shadow: var(--card-shadow);
                                            border: 1px solid rgba(0, 0, 0, 0.02);
                                        }

                                        .card-header {
                                            display: flex;
                                            justify-content: space-between;
                                            align-items: center;
                                            margin-bottom: 24px;
                                        }

                                        .card-header h2 {
                                            display: flex;
                                            align-items: center;
                                            gap: 12px;
                                            font-size: 1.35rem;
                                            font-weight: 800;
                                            color: #1e293b;
                                        }

                                        .card-header h2 i {
                                            color: #94a3b8;
                                            font-size: 1.2rem;
                                        }

                                        .table-container {
                                            width: 100%;
                                            overflow-x: auto;
                                        }

                                        table {
                                            width: 100%;
                                            border-collapse: collapse;
                                        }

                                        th {
                                            text-align: left;
                                            padding: 16px 12px;
                                            font-size: 0.7rem;
                                            font-weight: 800;
                                            color: #94a3b8;
                                            text-transform: uppercase;
                                            letter-spacing: 1px;
                                            border-bottom: 1px solid #f1f5f9;
                                        }

                                        td {
                                            padding: 16px 12px;
                                            border-bottom: 1px solid #f8fafc;
                                            font-size: 0.95rem;
                                            font-weight: 600;
                                            color: #334155;
                                        }

                                        .student-cell {
                                            display: flex;
                                            align-items: center;
                                            gap: 12px;
                                        }

                                        .initial-avatar {
                                            width: 36px;
                                            height: 36px;
                                            border-radius: 50%;
                                            display: flex;
                                            align-items: center;
                                            justify-content: center;
                                            font-weight: 700;
                                            font-size: 0.85rem;
                                        }

                                        .branch-pill {
                                            padding: 6px 14px;
                                            border-radius: 100px;
                                            font-size: 0.8rem;
                                            font-weight: 700;
                                            display: inline-block;
                                        }

                                        .cgpa-pill {
                                            padding: 6px 12px;
                                            border-radius: 10px;
                                            background: #ecfdf5;
                                            color: #059669;
                                            font-weight: 700;
                                            font-size: 0.85rem;
                                        }

                                        .status-pill {
                                            display: inline-flex;
                                            align-items: center;
                                            gap: 6px;
                                            padding: 6px 12px;
                                            border-radius: 100px;
                                            background: #ecfdf5;
                                            color: #059669;
                                            font-size: 0.85rem;
                                            font-weight: 700;
                                        }

                                        .status-pill i {
                                            font-size: 0.9rem;
                                        }

                                        tr:hover td {
                                            background-color: #fcfdfe;
                                        }

                                        ::-webkit-scrollbar {
                                            width: 6px;
                                        }

                                        ::-webkit-scrollbar-track {
                                            background: transparent;
                                        }

                                        ::-webkit-scrollbar-thumb {
                                            background: #e2e8f0;
                                            border-radius: 10px;
                                        }

                                        .circular-modal {
                                            display: none;
                                            position: fixed;
                                            top: 0;
                                            left: 0;
                                            width: 100%;
                                            height: 100%;
                                            background: rgba(15, 23, 42, 0.6);
                                            backdrop-filter: blur(8px);
                                            z-index: 2000;
                                            align-items: center;
                                            justify-content: center;
                                            padding: 24px;
                                        }

                                        .circular-card {
                                            background: white;
                                            width: 100%;
                                            max-width: 500px;
                                            border-radius: 32px;
                                            padding: 40px;
                                            text-align: center;
                                            box-shadow: 0 32px 64px -12px rgba(0, 0, 0, 0.14);
                                            animation: modalIn 0.4s cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
                                            position: relative;
                                        }

                                        @keyframes modalIn {
                                            from {
                                                transform: scale(0.9);
                                                opacity: 0;
                                            }

                                            to {
                                                transform: scale(1);
                                                opacity: 1;
                                            }
                                        }

                                        .circular-icon-box {
                                            width: 80px;
                                            height: 80px;
                                            background: var(--primary-soft);
                                            color: var(--primary);
                                            border-radius: 24px;
                                            display: flex;
                                            align-items: center;
                                            justify-content: center;
                                            font-size: 2.5rem;
                                            margin: 0 auto 24px;
                                        }

                                        #circularTitle {
                                            font-size: 1.5rem;
                                            font-weight: 800;
                                            color: #1e293b;
                                            margin-bottom: 12px;
                                        }

                                        #circularText {
                                            color: #64748b;
                                            font-size: 1.05rem;
                                            line-height: 1.7;
                                            margin-bottom: 32px;
                                        }

                                        .btn-attachment {
                                            display: inline-flex;
                                            align-items: center;
                                            gap: 12px;
                                            padding: 14px 24px;
                                            background: #f8fafc;
                                            border: 2px solid var(--primary);
                                            border-radius: 16px;
                                            text-decoration: none;
                                            color: var(--primary);
                                            font-weight: 700;
                                            margin-bottom: 24px;
                                            transition: all 0.2s;
                                            width: 100%;
                                            justify-content: center;
                                        }

                                        .btn-attachment:hover {
                                            background: var(--primary);
                                            color: white;
                                        }

                                        .btn-got-it {
                                            width: 100%;
                                            padding: 16px;
                                            background: #1e293b;
                                            color: white;
                                            border: none;
                                            border-radius: 16px;
                                            font-weight: 700;
                                            font-size: 1rem;
                                            cursor: pointer;
                                            transition: all 0.2s;
                                        }

                                        .btn-got-it:hover {
                                            background: #0f172a;
                                            transform: translateY(-2px);
                                        }
                                    </style>
                                </head>

                                <body>
                                    <aside>
                                        <div class="brand">
                                            <div class="brand-logo"><img src="images/sgp1.jpeg"></div>
                                            <span class="brand-name">SGP CELL</span>
                                        </div>
                                        <nav>
                                            <a href="HODDashboardServlet" class="nav-link <%= dashClass %>"><i
                                                    class="fas fa-th-large"></i> Dashboard</a>
                                            <a href="#job-applications-section" class="nav-link"><i
                                                    class="fas fa-user-graduate"></i> Job Applications</a>

                                            <li style="margin-top: 32px; list-style: none;">
                                                <div id="circularDropdownBtn" onclick="toggleSidebarCirculars()"
                                                    style="background: #f8fafc; color: #5c67f2; border: 1px solid #e2e8f0; border-radius: 14px; padding: 14px 18px; cursor: pointer; display: flex; align-items: center; justify-content: space-between; transition: 0.3s; font-weight: 700; font-size: 0.9rem;">
                                                    <div style="display: flex; align-items: center; gap: 12px;">
                                                        <i class="fas fa-bullhorn" style="font-size: 1rem;"></i>
                                                        <span style="color: #475569;">View Circulars</span>
                                                    </div>
                                                    <i class="fas fa-chevron-down" id="circChevron" style="font-size: 0.75rem; color: #94a3b8; transition: transform 0.3s;"></i>
                                                </div>
                                                <!-- Sidebar Circulars List -->
                                                <div id="sidebarCircularsList" style="display: none; padding: 12px 5px; max-height: 350px; overflow-y: auto;">
                                                    <div id="sidebarCircularsContent" style="font-size: 0.85rem;"></div>
                                                </div>
                                            </li>
                                        </nav>
                                        <div class="nav-bottom">
                                            <a href="LogoutServlet" class="nav-link sign-out"><i
                                                    class="fas fa-sign-out-alt"></i> Sign Out</a>
                                        </div>
                                    </aside>
                                    <main>
                                        <div class="header-section">
                                            <h1>
                                                <%= displayBranch %> HOD Dashboard
                                            </h1>
                                            <p>
                                                Welcome back, <strong>
                                                    <%= u.getFullName() !=null ? u.getFullName() : "HOD" %>
                                                </strong>
                                            <div
                                                style="background: rgba(92, 103, 242, 0.1); padding: 8px 16px; border-radius: 12px; font-weight: 500; color: #5c67f2; display: inline-block; margin-top: 12px; border: 1px solid rgba(92, 103, 242, 0.2);">
                                                <i class="fas fa-id-badge" style="margin-right: 8px;"></i>
                                                <%= displayBranch %> Administration
                                            </div>
                                            </p>
                                        </div>
                                        <div class="stats-grid">
                                            <div class="stat-card">
                                                <div class="stat-icon" style="background: #e0f2fe; color: #0ea5e9;">
                                                    <i class="fas fa-users"></i>
                                                </div>
                                                <div class="stat-info">
                                                    <span class="stat-label">Total Students</span>
                                                    <span class="stat-value">
                                                        <%= totalReg %>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="stat-card">
                                                <div class="stat-icon" style="background: #fdf2f8; color: #ec4899;">
                                                    <i class="fas fa-graduation-cap"></i>
                                                </div>
                                                <div class="stat-info">
                                                    <span class="stat-label">Average CGPA</span>
                                                    <span class="stat-value">
                                                        <%= String.format("%.2f", avgCgpa) %>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="content-card">
                                            <div class="card-header">
                                                <h2><i class="fas fa-list-ul"></i> Students List - <span
                                                        id="branchLabel">
                                                        <%= (currentBranch !=null && !currentBranch.isEmpty() ?
                                                            currentBranch : "All" ) %>
                                                    </span></h2>
                                                <div style="display:flex; align-items:center; gap:12px;">
                                                    <div id="liveIndicator"
                                                        style="display:flex; align-items:center; gap:8px; background:#ecfdf5; padding:6px 12px; border-radius:100px; font-size:0.75rem; font-weight:700; color:#059669; border:1px solid #bbf7d0;">
                                                        <span
                                                            style="width:8px; height:8px; background:#10b981; border-radius:50%; display:inline-block; animation:pulse 2s infinite;"></span>
                                                        Live Sync
                                                    </div>
                                                    <span id="studentCount"
                                                        style="background:#f1f5f9; padding:6px 14px; border-radius:100px; font-size:0.82rem; font-weight:700; color:#475569;">0
                                                        students</span>
                                                    <span
                                                        style="font-size:0.75rem; color:#94a3b8; font-weight:600;">Last
                                                        update: <span id="lastRefreshed">-</span></span>
                                                </div>
                                            </div>
                                            <div class="table-container">
                                                <table id="studentsTable">
                                                    <thead>
                                                        <tr>
                                                            <th>Sl.No</th>
                                                            <th>Reg.No</th>
                                                            <th>Full Name</th>
                                                            <th>Placed in Company</th>
                                                            <th>Internship</th>
                                                            <th>Gender</th>
                                                            <th>Branch</th>
                                                            <th>Preference</th>
                                                            <th>Date of Birth</th>
                                                            <th>SSLC %</th>
                                                            <th>SSLC Year</th>
                                                            <th>PUC %</th>
                                                            <th>PUC Year</th>
                                                            <th>ITI %</th>
                                                            <th>ITI Year</th>
                                                            <th>Sem 1</th>
                                                            <th>Sem 2</th>
                                                            <th>Sem 3</th>
                                                            <th>Sem 4</th>
                                                            <th>Diploma Aggregate</th>
                                                            <th>Backlogs</th>
                                                            <th>History of Backlogs</th>
                                                            <th>Mobile</th>
                                                            <th>Alt. Contact</th>
                                                            <th>Email</th>
                                                            <th>Address</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="studentsTableBody">
                                                        <tr>
                                                            <td colspan="26"
                                                                style="text-align:center; padding:40px; color:#94a3b8;">
                                                                <i class="fas fa-circle-notch fa-spin"
                                                                    style="font-size:1.5rem;"></i><br>Loading student
                                                                data from
                                                                database...
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <!-- Job Applications Section -->
                                        <div id="job-applications-section" class="content-card"
                                            style="margin-top: 40px; border-radius: 28px;">
                                            <div class="card-header"
                                                style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px;">
                                                <h2><i class="fas fa-briefcase"></i> Students Job Applications (<%=
                                                        displayBranch %>)</h2>
                                                <button class="export-btn" onclick="exportApplicantsToExcel()"
                                                    style="padding: 10px 20px; border-radius: 12px; font-weight: 700; background: #10b981; color: white; border: none; cursor: pointer; display: flex; align-items: center; gap: 8px;">
                                                    <i class="fas fa-file-excel"></i> Export Applications
                                                </button>
                                            </div>
                                            <div class="table-container">
                                                <table id="applicantsTable">
                                                    <thead>
                                                        <tr>
                                                            <th>Student Name</th>
                                                            <th>Register No</th>
                                                            <th>Company</th>
                                                            <th>Job Role</th>
                                                            <th>Applied Date</th>
                                                            <th>Resume</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <% if (jobApplicationsList !=null &&
                                                            !jobApplicationsList.isEmpty()) { for (String[] app :
                                                            jobApplicationsList) { %>
                                                            <tr>
                                                                <td style="font-weight: 700; color: #1e293b;">
                                                                    <%= app[0] %>
                                                                </td>
                                                                <td style="font-weight: 600; color: #64748b;">
                                                                    <%= app[1] %>
                                                                </td>
                                                                <td><span
                                                                        style="background: #eef2ff; color: #5c67f2; padding: 4px 10px; border-radius: 8px; font-weight: 700;">
                                                                        <%= app[5] %>
                                                                    </span></td>
                                                                <td style="font-weight: 600; color: #475569;">
                                                                    <%= app[6] %>
                                                                </td>
                                                                <td style="font-size: 0.85rem; color: #64748b;">
                                                                    <%= app[7] %>
                                                                </td>
                                                                <td>
                                                                    <% if (app[8] !=null && !app[8].isEmpty()) { %>
                                                                        <a href="<%= app[8] %>" download
                                                                            style="color: var(--primary); text-decoration: none; font-weight: 700; display: inline-flex; align-items: center; gap: 6px;">
                                                                            <i class="fas fa-download"></i> Download
                                                                        </a>
                                                                        <% } else { %>
                                                                            <span
                                                                                style="color: #cbd5e1; font-style: italic;">No
                                                                                resume</span>
                                                                            <% } %>
                                                                </td>
                                                            </tr>
                                                            <% } } else { %>
                                                                <tr>
                                                                    <td colspan="6"
                                                                        style="text-align: center; padding: 30px; color: #94a3b8;">
                                                                        No job applications found for your branch.
                                                                    </td>
                                                                </tr>
                                                                <% } %>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </main>
                                    <div id="circularModal" class="circular-modal">
                                        <div class="circular-card">
                                            <div class="circular-icon-box"><i class="fas fa-bullhorn"></i></div>
                                            <h3 id="circularTitle">Circular Update</h3>
                                            <p id="circularText"></p>
                                            <div id="circularFileSection" style="display: none;">
                                                <a id="circularFileLink" href="#" target="_blank"
                                                    class="btn-attachment">
                                                    <i class="fas fa-file-pdf"></i>
                                                    <span>View Attachment</span>
                                                </a>
                                            </div>
                                            <button class="btn-got-it" onclick="closeCircular()">Got it,
                                                Thanks!</button>
                                        </div>
                                    </div>
                                    <style>
                                        @keyframes pulse {

                                            0%,
                                            100% {
                                                opacity: 1;
                                                transform: scale(1);
                                            }

                                            50% {
                                                opacity: 0.5;
                                                transform: scale(0.85);
                                            }
                                        }

                                        .new-row {
                                            animation: highlightNew 3s ease-out forwards;
                                        }

                                        @keyframes highlightNew {
                                            0% {
                                                background-color: #ecfdf5;
                                            }

                                            100% {
                                                background-color: transparent;
                                            }
                                        }

                                        .status-approved {
                                            background: #ecfdf5;
                                            color: #059669;
                                        }

                                        .status-pending {
                                            background: #fffbeb;
                                            color: #d97706;
                                        }

                                        .status-rejected {
                                            background: #fef2f2;
                                            color: #dc2626;
                                        }
                                    </style>
                                    <script>
                                        // ── Branch color mapping ────────────────────────────────
                                        const BRANCH_COLORS = {
                                            'Computer Science': { bc: '#6366f1', bb: '#eef2ff' },
                                            'Civil': { bc: '#10b981', bb: '#ecfdf5' },
                                            'Mechanical': { bc: '#2563eb', bb: '#eff6ff' },
                                            'Metallurgy': { bc: '#ec4899', bb: '#fdf2f8' },
                                            'Electrical & Electronics': { bc: '#f59e0b', bb: '#fffbeb' },
                                            'Information Technology': { bc: '#8b5cf6', bb: '#f5f3ff' }
                                        };
                                        const DEFAULT_COLOR = { bc: '#6366f1', bb: '#eef2ff' };

                                        let currentBranch = '<%= currentBranch != null ? currentBranch : "" %>';
                                        let knownIds = new Set();
                                        let isFirstLoad = true;

                                        function getBranchColor(branch) {
                                            if (!branch) return DEFAULT_COLOR;
                                            const bLow = branch.toLowerCase();
                                            if (bLow.includes("computer")) return BRANCH_COLORS['Computer Science'];
                                            if (bLow.includes("civil")) return BRANCH_COLORS['Civil'];
                                            if (bLow.includes("mechanical")) return BRANCH_COLORS['Mechanical'];
                                            if (bLow.includes("metallurgy")) return BRANCH_COLORS['Metallurgy'];
                                            if (bLow.includes("electrical") || bLow.includes("electronics") || bLow.includes("eee"))
                                                return BRANCH_COLORS['Electrical & Electronics'];
                                            if (bLow.includes("information")) return BRANCH_COLORS['Information Technology'];
                                            return DEFAULT_COLOR;
                                        }

                                        function fmt(val) {
                                            if (val === null || val === undefined) return '-';
                                            return parseFloat(val).toFixed(1);
                                        }

                                        function buildRow(s, isNew, sl) {
                                            var colors = getBranchColor(s.branch);
                                            var bc = colors.bc, bb = colors.bb;
                                            var initials = s.fullName ? s.fullName.charAt(0).toUpperCase() : '?';
                                            var tr = document.createElement('tr');
                                            if (isNew) tr.classList.add('new-row');

                                            var cells = [
                                                '<td>' + (sl || '-') + '</td>',
                                                '<td style="font-family:monospace;font-size:0.83rem;">' + (s.regNo || 'N/A') + '</td>',
                                                '<td><div class="student-cell"><div class="initial-avatar" style="background:' + bb + ';color:' + bc + ';">' + initials + '</div>' + (s.fullName || 'N/A') + '</div></td>',
                                                '<td style="color:#6366f1;font-weight:600;">' + (s.placedCompany || '-') + '</td>',
                                                '<td>' + (s.internship || '-') + '</td>',
                                                '<td>' + (s.gender || '-') + '</td>',
                                                '<td><span class="branch-pill" style="background:' + bb + ';color:' + bc + ';">' + (s.branch || 'N/A') + '</span></td>',
                                                '<td>' + (s.preference || '-') + '</td>',
                                                '<td>' + (s.dob || '-') + '</td>',
                                                '<td>' + fmt(s.sslc) + '%</td>',
                                                '<td>' + (s.sslcYear || '-') + '</td>',
                                                '<td>' + fmt(s.puc) + '%</td>',
                                                '<td>' + (s.pucYear || '-') + '</td>',
                                                '<td>' + fmt(s.iti) + '%</td>',
                                                '<td>' + (s.itiYear || '-') + '</td>',
                                                '<td>' + fmt(s.sem1) + '</td>',
                                                '<td>' + fmt(s.sem2) + '</td>',
                                                '<td>' + fmt(s.sem3) + '</td>',
                                                '<td>' + fmt(s.sem4) + '</td>',
                                                '<td>' + fmt(s.diploma) + '%</td>',
                                                '<td style="color:#ef4444;font-weight:700;">' + (s.backlogs !== null ? s.backlogs : '-') + '</td>',
                                                '<td>' + (s.backlogHistory || '-') + '</td>',
                                                '<td>' + (s.mobile || '-') + '</td>',
                                                '<td>' + (s.alternateMobile || '-') + '</td>',
                                                '<td style="font-size:0.83rem;color:#64748b;">' + (s.email || '-') + '</td>',
                                                '<td style="font-size:0.8rem;max-width:200px;white-space:normal;">' + (s.address || '-') + '</td>'
                                            ];
                                            tr.innerHTML = cells.join('');
                                            return tr;
                                        }

                                        function fetchStudents() {
                                            const url = 'HODStudentsAPI' + (currentBranch ? '?branch=' + encodeURIComponent(currentBranch) : '');
                                            console.log('Fetching students from:', url);
                                            fetch(url)
                                                .then(res => {
                                                    if (res.status === 401 || res.status === 403) {
                                                        console.error('Session expired or access denied to HODStudentsAPI');
                                                        return null;
                                                    }
                                                    return res.json();
                                                })
                                                .then(data => {
                                                    console.log('HOD API Response:', data);
                                                    if (!data || data.error) {
                                                        if (data && data.error) console.error('API Error:', data.error);
                                                        return;
                                                    }
                                                    const tbody = document.getElementById('studentsTableBody');
                                                    if (isFirstLoad) {
                                                        tbody.innerHTML = ''; // Clear loading spinner
                                                        if (data.students.length === 0) {
                                                            tbody.innerHTML = '<tr><td colspan="26" style="text-align:center;padding:40px;color:#94a3b8;"><i class="fas fa-users-slash"></i><br>No students found for this branch.</td></tr>';
                                                        } else {
                                                            data.students.forEach((s, idx) => {
                                                                knownIds.add(s.id);
                                                                tbody.appendChild(buildRow(s, false, idx + 1));
                                                            });
                                                        }
                                                        isFirstLoad = false;
                                                    } else {
                                                        // Only prepend newly admitted students
                                                        let newCount = 0;
                                                        // Assuming data.students is sorted by ID or admission date, newest first
                                                        // Or, if it's a full list, we need to iterate and check
                                                        // For simplicity, let's assume the API returns new students first or we check all
                                                        const existingRows = Array.from(tbody.querySelectorAll('tr'));
                                                        const existingIds = new Set();
                                                        existingRows.forEach(row => {
                                                            const cell = row.querySelector('td:nth-child(2)');
                                                            if (cell && cell.textContent && cell.textContent.trim() !== '' && cell.textContent.trim() !== 'Loading...') {
                                                                // Use Reg.No or unique data
                                                                // Actually, better use a data-id attribute if possible
                                                            }
                                                        });
                                                        // Update: Simplest way is to just check if we have new IDs
                                                        const receivedIds = data.students.map(s => s.id);
                                                        const hasNew = receivedIds.some(id => !knownIds.has(id));

                                                        // Rebuild the table to ensure correct serial numbers and include new students
                                                        let tempKnownIds = new Set();
                                                        let newStudentsAdded = [];

                                                        data.students.forEach(s => {
                                                            if (!knownIds.has(s.id)) {
                                                                newStudentsAdded.push(s);
                                                            }
                                                            tempKnownIds.add(s.id);
                                                        });

                                                        if (newStudentsAdded.length > 0) {
                                                            tbody.innerHTML = ''; // Clear existing rows
                                                            knownIds = tempKnownIds; // Update known IDs
                                                            data.students.forEach((s, idx) => {
                                                                const isNew = newStudentsAdded.some(ns => ns.id === s.id);
                                                                tbody.appendChild(buildRow(s, isNew, idx + 1));
                                                            });
                                                            newCount = newStudentsAdded.length;
                                                        }

                                                        if (newCount > 0) {
                                                            const indicator = document.getElementById('liveIndicator');
                                                            if (indicator) {
                                                                indicator.style.background = '#dcfce7';
                                                                setTimeout(() => { indicator.style.background = '#ecfdf5'; }, 1500);
                                                            }
                                                        }
                                                    }
                                                    // Update counters
                                                    const count = data.total || knownIds.size;
                                                    const countElem = document.getElementById('studentCount');
                                                    if (countElem) countElem.textContent = count + ' student' + (count !== 1 ? 's' : '');
                                                    const now = new Date();
                                                    const refreshElem = document.getElementById('lastRefreshed');
                                                    if (refreshElem) refreshElem.textContent = now.toLocaleTimeString();
                                                })
                                                .catch(err => console.warn('HOD poll error:', err));
                                        }

                                        function exportApplicantsToExcel() {
                                            const table = document.getElementById('applicantsTable');
                                            let csv = [];
                                            const rows = table.querySelectorAll('tr');

                                            for (let i = 0; i < rows.length; i++) {
                                                const row = [], cols = rows[i].querySelectorAll('td, th');
                                                for (let j = 0; j < cols.length - 1; j++) {
                                                    let text = cols[j].innerText.replace(/"/g, '""');
                                                    row.push('"' + text + '"');
                                                }
                                                csv.push(row.join(','));
                                            }
                                            const csvContent = "data:text/csv;charset=utf-8," + csv.join("\n");
                                            const encodedUri = encodeURI(csvContent);
                                            const link = document.createElement("a");
                                            link.setAttribute("href", encodedUri);
                                            link.setAttribute("download", "Job_Applicants_List.csv");
                                            document.body.appendChild(link);
                                            link.click();
                                            document.body.removeChild(link);
                                        }

                                        function toggleSidebarCirculars() {
                                            const list = document.getElementById('sidebarCircularsList');
                                            const icon = document.getElementById('circChevron');
                                            if (list.style.display === 'none') {
                                                list.style.display = 'block';
                                                icon.style.transform = 'rotate(180deg)';
                                                checkCirculars(true);
                                            } else {
                                                list.style.display = 'none';
                                                icon.style.transform = 'rotate(0deg)';
                                            }
                                        }

                                        function checkCirculars(isManual = false) {
                                            fetch('GetCircularServlet')
                                                .then(response => response.json())
                                                .then(data => {
                                                    const content = document.getElementById('sidebarCircularsContent');
                                                    if (data.status === 'success' && data.circulars && data.circulars.length > 0) {
                                                        // 1. Sidebar List
                                                        let sidebarHtml = '';
                                                        data.circulars.forEach((circ, index) => {
                                                            const dateDisp = circ.date ? new Date(circ.date).toLocaleDateString('en-IN', {day: 'numeric', month: 'short'}) : '';
                                                            sidebarHtml += `
                                                                <div style="margin-bottom: 15px; border-bottom: 1px solid #f1f5f9; padding-bottom: 12px;">
                                                                    <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 5px;">
                                                                        <span style="font-weight: 700; color: #1e293b; font-size: 0.82rem;">\${circ.title}</span>
                                                                        <span style="font-size: 0.68rem; color: #94a3b8; font-weight: 700;">\${dateDisp}</span>
                                                                    </div>
                                                                    <p style="color: #64748b; font-size: 0.76rem; line-height: 1.4; margin-bottom: 8px;">\${circ.message}</p>
                                                            `;
                                                            if (circ.filePath) {
                                                                sidebarHtml += `
                                                                    <a href="\${circ.filePath}" target="_blank" style="color: #5c67f2; text-decoration: none; font-weight: 700; font-size: 0.7rem; display: flex; align-items: center; gap: 5px;">
                                                                        <i class="fas fa-file-pdf"></i> View Attachment
                                                                    </a>
                                                                `;
                                                            }
                                                            sidebarHtml += `</div>`;
                                                        });
                                                        content.innerHTML = sidebarHtml;

                                                        // 2. Modal (Latest Only)
                                                        if (!isManual) {
                                                            const latest = data.circulars[0];
                                                            const modal = document.getElementById('circularModal');
                                                            const card = modal.querySelector('.circular-card');
                                                            
                                                            let modalHtml = `
                                                                <div class="circular-icon-box" style="width:55px; height:55px; font-size:1.6rem; margin-bottom:16px;"><i class="fas fa-bullhorn"></i></div>
                                                                <h3 style="margin-bottom: 10px; font-weight: 800; color: #1e293b;">New Circular</h3>
                                                                <div style="text-align: left; padding: 10px 15px; background: #f1f5f9; border-radius: 14px; margin-bottom: 20px;">
                                                                    <div style="display: flex; justify-content: space-between; margin-bottom: 8px;">
                                                                        <strong style="color: #1e293b; font-size: 0.95rem;">\${latest.title}</strong>
                                                                        <span style="font-size: 0.75rem; color: #94a3b8; font-weight: 700;">\${new Date(latest.date).toLocaleDateString('en-IN', {day: 'numeric', month: 'short', year: 'numeric'})}</span>
                                                                    </div>
                                                                    <p style="color: #475569; font-size: 0.88rem; line-height: 1.6; margin-bottom: 12px;">\${latest.message.replace(/\n/g, '<br>')}</p>
                                                            `;
                                                            
                                                            if (latest.filePath) {
                                                                modalHtml += `
                                                                    <a href="\${latest.filePath}" target="_blank" class="btn-attachment" style="padding: 10px 18px; font-size: 0.8rem; width: auto; background: #5c67f2; color:white; border-radius:10px; display:inline-block; text-decoration:none;">
                                                                        <i class="fas fa-file-pdf"></i> View Attachment
                                                                    </a>
                                                                `;
                                                            }
                                                            modalHtml += `</div>
                                                                <button class="btn-got-it" style="border-radius:10px; width:100%;" onclick="closeCircular()">Acknowledge</button>
                                                            `;
                                                            
                                                            card.innerHTML = modalHtml;
                                                            modal.style.display = 'flex';
                                                        }
                                                    } else if (isManual) {
                                                        content.innerHTML = '<p style="color: #94a3b8; font-style: italic; padding: 10px; font-size:0.8rem;">No active circulars.</p>';
                                                    }
                                                })
                                                .catch(err => {
                                                    console.error('Error fetching circulars:', err);
                                                });
                                        }

                                        function closeCircular() {
                                            document.getElementById('circularModal').style.display = 'none';
                                        }

                                        window.addEventListener('DOMContentLoaded', () => {
                                            fetchStudents();
                                            setTimeout(() => checkCirculars(false), 800);
                                            setInterval(fetchStudents, 15000);
                                        });
                                    </script>
                                </body>

                                </html>