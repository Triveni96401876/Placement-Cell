<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.placementcell.model.User" %>
            <% User user=(User) session.getAttribute("user"); if (user==null || !"ADMIN".equals(user.getRole())) {
                response.sendRedirect("login.jsp"); return; } List<String[]> circulars = (List<String[]>)
                    request.getAttribute("circulars");
                    %>
                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>View Circulars | Admin Dashboard | SGP Placement Cell</title>
                        <link
                            href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap"
                            rel="stylesheet">
                        <link rel="stylesheet"
                            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                        <style>
                            :root {
                                --primary: #4361ee;
                                --secondary: #3f37c9;
                                --bg: #f8f9fe;
                                --sidebar-width: 280px;
                                --card-shadow: 0 10px 30px rgba(0, 0, 0, 0.04);
                                --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
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
                                display: flex;
                                min-height: 100vh;
                            }

                            /* Sidebar Styling (Same as dashboard) */
                            .sidebar {
                                width: var(--sidebar-width);
                                background: white;
                                border-right: 1px solid #edf2f7;
                                padding: 2rem 1.5rem;
                                display: flex;
                                flex-direction: column;
                                position: fixed;
                                height: 100vh;
                                z-index: 100;
                            }

                            .sidebar-brand {
                                display: flex;
                                align-items: center;
                                gap: 12px;
                                margin-bottom: 3rem;
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
                                font-size: 1.25rem;
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
                                padding: 1rem 1.25rem;
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
                                flex: 1;
                                padding: 2rem 3rem;
                            }

                            .page-header {
                                display: flex;
                                justify-content: space-between;
                                align-items: center;
                                margin-bottom: 2.5rem;
                            }

                            .page-title h1 {
                                font-size: 2rem;
                                font-weight: 800;
                                letter-spacing: -1px;
                                color: #1a1c2d;
                            }

                            .page-title p {
                                color: #718096;
                                font-weight: 600;
                                margin-top: 4px;
                            }

                            .btn-add {
                                background: var(--primary);
                                color: white;
                                padding: 0.75rem 1.5rem;
                                border-radius: 12px;
                                text-decoration: none;
                                font-weight: 700;
                                display: flex;
                                align-items: center;
                                gap: 10px;
                                transition: var(--transition);
                                box-shadow: 0 4px 12px rgba(67, 97, 238, 0.2);
                            }

                            .btn-add:hover {
                                background: var(--secondary);
                                transform: translateY(-2px);
                            }

                            /* Circulars Grid */
                            .circulars-grid {
                                display: grid;
                                grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
                                gap: 1.5rem;
                            }

                            .circular-card {
                                background: white;
                                border-radius: 20px;
                                padding: 1.75rem;
                                box-shadow: var(--card-shadow);
                                border: 1px solid #edf2f7;
                                display: flex;
                                flex-direction: column;
                                transition: var(--transition);
                            }

                            .circular-card:hover {
                                transform: translateY(-5px);
                                border-color: var(--primary);
                            }

                            .circular-header {
                                display: flex;
                                justify-content: space-between;
                                align-items: flex-start;
                                margin-bottom: 1rem;
                            }

                            .target-badge {
                                padding: 4px 10px;
                                border-radius: 8px;
                                font-size: 0.7rem;
                                font-weight: 800;
                                text-transform: uppercase;
                            }

                            .target-all {
                                background: #eef2ff;
                                color: #4361ee;
                            }

                            .target-student {
                                background: #ecfdf5;
                                color: #10b981;
                            }

                            .target-hod {
                                background: #fffbeb;
                                color: #f59e0b;
                            }

                            .circular-date {
                                font-size: 0.75rem;
                                color: #a0aec0;
                                font-weight: 600;
                            }

                            .circular-title {
                                font-size: 1.25rem;
                                font-weight: 800;
                                color: #1a1c2d;
                                margin-bottom: 0.75rem;
                                line-height: 1.3;
                            }

                            .circular-message {
                                font-size: 0.95rem;
                                color: #4a5568;
                                line-height: 1.6;
                                margin-bottom: 1.5rem;
                                flex: 1;
                            }

                            .circular-footer {
                                display: flex;
                                justify-content: space-between;
                                align-items: center;
                                padding-top: 1.25rem;
                                border-top: 1px solid #f7fafc;
                            }

                            .file-link {
                                display: flex;
                                align-items: center;
                                gap: 8px;
                                color: var(--primary);
                                text-decoration: none;
                                font-weight: 700;
                                font-size: 0.85rem;
                            }

                            .btn-delete {
                                color: #ff4d4d;
                                background: #fff5f5;
                                width: 36px;
                                height: 36px;
                                border-radius: 10px;
                                display: flex;
                                align-items: center;
                                justify-content: center;
                                text-decoration: none;
                                transition: var(--transition);
                            }

                            .btn-delete:hover {
                                background: #ff4d4d;
                                color: white;
                            }

                            .empty-state {
                                grid-column: 1 / -1;
                                background: white;
                                border-radius: 20px;
                                padding: 4rem;
                                text-align: center;
                                box-shadow: var(--card-shadow);
                            }

                            .empty-state i {
                                font-size: 4rem;
                                color: #e2e8f0;
                                margin-bottom: 1.5rem;
                            }

                            .empty-state h2 {
                                font-weight: 800;
                                color: #4a5568;
                                margin-bottom: 0.5rem;
                            }

                            .empty-state p {
                                color: #a0aec0;
                            }
                        </style>
                    </head>

                    <body>
                        <!-- Sidebar -->
                        <aside class="sidebar">
                            <div class="sidebar-brand">
                                <img src="<%=request.getContextPath()%>/images/sgp1.jpeg" alt="Logo">
                                <span>SGP ADMIN</span>
                            </div>

                            <ul class="nav-menu">
                                <li class="nav-item">
                                    <a href="<%=request.getContextPath()%>/AdminDashboardServlet" class="nav-link">
                                        <i class="fas fa-th-large"></i> Dashboard
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="<%=request.getContextPath()%>/AdminDashboardServlet" class="nav-link">
                                        <i class="fas fa-database"></i> Student Records
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="<%=request.getContextPath()%>/admin/admin-push-circular.jsp"
                                        class="nav-link">
                                        <i class="fas fa-bullhorn"></i> Push Circular
                                    </a>
                                </li>
                            </ul>

                            <a href="<%=request.getContextPath()%>/LogoutServlet" class="btn-signout">
                                <i class="fas fa-sign-out-alt"></i> Sign Out
                            </a>
                        </aside>

                        <!-- Main Content -->
                        <main class="main-content">
                            <div class="page-header">
                                <div class="page-title">
                                    <h1>Circulars History</h1>
                                    <p>View and manage all announcements sent to Students and HODs</p>
                                </div>
                                <a href="<%=request.getContextPath()%>/admin/admin-push-circular.jsp" class="btn-add">
                                    <i class="fas fa-plus"></i> New Circular
                                </a>
                            </div>

                            <div class="circulars-grid">
                                <% if (circulars !=null && !circulars.isEmpty()) { for (String[] circular : circulars) {
                                    String id=circular[0]; String title=circular[1]; String message=circular[2]; String
                                    target=circular[3]; String filePath=circular[4]; String date=circular[5]; String
                                    targetClass="target-all" ; if ("STUDENT".equalsIgnoreCase(target))
                                    targetClass="target-student" ; else if ("HOD".equalsIgnoreCase(target))
                                    targetClass="target-hod" ; %>
                                    <div class="circular-card">
                                        <div class="circular-header">
                                            <span class="target-badge <%= targetClass %>">
                                                <%= target %>
                                            </span>
                                            <span class="circular-date">
                                                <%= date.substring(0, 16) %>
                                            </span>
                                        </div>
                                        <h2 class="circular-title">
                                            <%= title %>
                                        </h2>
                                        <div class="circular-message">
                                            <%= message %>
                                        </div>
                                        <div class="circular-footer">
                                            <% if (filePath !=null && !filePath.isEmpty()) { %>
                                                <a href="<%= request.getContextPath() %>/ViewDocument?file=<%= filePath %>"
                                                    target="_blank" class="file-link">
                                                    <i class="fas fa-paperclip"></i> View Attachment
                                                </a>
                                                <% } else { %>
                                                    <span></span>
                                                    <% } %>
                                                        <a href="<%=request.getContextPath()%>/DeleteCircularServlet?id=<%= id %>"
                                                            class="btn-delete" title="Delete Circular"
                                                            onclick="return confirm('Are you sure you want to delete this circular?')">
                                                            <i class="fas fa-trash-alt"></i>
                                                        </a>
                                        </div>
                                    </div>
                                    <% } } else { %>
                                        <div class="empty-state">
                                            <i class="fas fa-bullhorn"></i>
                                            <h2>No Circulars Found</h2>
                                            <p>You haven't pushed any circulars yet. Create one to keep everyone
                                                informed.</p>
                                        </div>
                                        <% } %>
                            </div>
                        </main>
                    </body>

                    </html>