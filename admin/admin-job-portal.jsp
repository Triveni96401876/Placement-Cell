<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <% List<String[]> jobs = (List<String[]>) request.getAttribute("activeJobs");
                int totalJobs = (jobs != null) ? jobs.size() : 0;
                %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Manage Job Portal | Admin Dashboard</title>
                    <!-- Bootstrap 5 CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <!-- Font Awesome -->
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <!-- Google Fonts -->
                    <link
                        href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap"
                        rel="stylesheet">
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
                    <style>
                        :root {
                            --primary: #4361ee;
                            --secondary: #3f37c9;
                            --bg: #f8f9fe;
                            --sidebar-width: 260px;
                            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                        }

                        body {
                            background-color: var(--bg);
                            font-family: 'Plus Jakarta Sans', sans-serif;
                            color: #1a1c2d;
                        }

                        .sidebar {
                            width: var(--sidebar-width);
                            background: #fff;
                            height: 100vh;
                            position: fixed;
                            top: 0;
                            left: 0;
                            z-index: 1000;
                            border-right: 1px solid #edf2f7;
                            padding: 1.5rem;
                        }

                        .sidebar-brand {
                            display: flex;
                            align-items: center;
                            gap: 12px;
                            margin-bottom: 2rem;
                            text-decoration: none;
                            color: #1a1c2d;
                        }

                        .sidebar-brand img {
                            width: 45px;
                            height: 45px;
                            border-radius: 12px;
                        }

                        .sidebar-brand span {
                            font-weight: 800;
                            font-size: 1.4rem;
                        }

                        .nav-link {
                            display: flex;
                            align-items: center;
                            gap: 12px;
                            padding: 0.8rem 1rem;
                            color: #718096;
                            font-weight: 600;
                            border-radius: 12px;
                            text-decoration: none;
                            margin-bottom: 0.5rem;
                            transition: var(--transition);
                        }

                        .nav-link:hover,
                        .nav-link.active {
                            background: #eef2ff;
                            color: var(--primary);
                        }

                        .main-content {
                            margin-left: var(--sidebar-width);
                            padding: 2rem;
                        }

                        .stat-card {
                            background: #fff;
                            border-radius: 20px;
                            padding: 1.5rem;
                            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.04);
                            border: 1px solid #f1f5f9;
                        }

                        .card-table {
                            background: #fff;
                            border-radius: 24px;
                            padding: 2rem;
                            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.04);
                            border: 1px solid #f1f5f9;
                        }

                        .table thead th {
                            background: #f8fafc;
                            border: none;
                            padding: 1rem;
                            font-weight: 700;
                            color: #64748b;
                            text-transform: uppercase;
                            font-size: 0.8rem;
                        }

                        .table tbody td {
                            padding: 1rem;
                            vertical-align: middle;
                            font-weight: 600;
                            color: #1e293b;
                        }

                        .btn-post {
                            background: var(--primary);
                            color: white;
                            font-weight: 700;
                            padding: 0.6rem 1.5rem;
                            border-radius: 12px;
                            box-shadow: 0 4px 12px rgba(67, 97, 238, 0.3);
                        }

                        .btn-post:hover {
                            background: var(--secondary);
                            color: white;
                        }

                        .action-btn {
                            width: 38px;
                            height: 38px;
                            border-radius: 10px;
                            display: inline-flex;
                            align-items: center;
                            justify-content: center;
                            margin-right: 5px;
                            transition: 0.2s;
                        }

                        .btn-edit {
                            background: #e0e7ff;
                            color: #4361ee;
                        }

                        .btn-delete {
                            background: #fee2e2;
                            color: #ef4444;
                        }

                        .btn-view {
                            background: #dcfce7;
                            color: #10b981;
                        }

                        .action-btn:hover {
                            transform: translateY(-2px);
                            opacity: 0.9;
                        }
                    </style>
                </head>

                <body>

                    <!-- Sidebar -->
                    <aside class="sidebar">
                        <a href="<%=request.getContextPath()%>/AdminDashboardServlet" class="sidebar-brand">
                            <img src="<%=request.getContextPath()%>/images/sgp1.jpeg" alt="Logo">
                            <span>SGP ADMIN</span>
                        </a>
                        <nav class="nav flex-column">
                            <a href="<%=request.getContextPath()%>/AdminDashboardServlet" class="nav-link"><i
                                    class="fas fa-th-large"></i>
                                Dashboard</a>
                            <a href="<%=request.getContextPath()%>/AdminDashboardServlet" class="nav-link"><i
                                    class="fas fa-user-graduate"></i>
                                Students</a>
                            <a href="<%=request.getContextPath()%>/AdminJobPortalServlet" class="nav-link active"><i
                                    class="fas fa-briefcase"></i> Job
                                Portal</a>
                            <a href="<%=request.getContextPath()%>/AdminViewApplicantsServlet" class="nav-link"><i
                                    class="fas fa-file-alt"></i> Job
                                Applications</a>
                            <a href="<%=request.getContextPath()%>/admin/admin-push-circular.jsp" class="nav-link"><i
                                    class="fas fa-bullhorn"></i>
                                Announcements</a>
                            <a href="<%=request.getContextPath()%>/LogoutServlet"
                                class="nav-link text-danger mt-auto"><i class="fas fa-sign-out-alt"></i> Logout</a>
                        </nav>
                    </aside>

                    <!-- Main Content -->
                    <main class="main-content">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div>
                                <h1 class="fw-bold h2 mb-1">Job Portal Dashboard</h1>
                                <p class="text-muted fw-medium">Manage and monitor job opportunities</p>
                            </div>
                            <a href="<%=request.getContextPath()%>/admin/admin-post-job.jsp" class="btn btn-post"><i
                                    class="fas fa-plus me-2"></i> Post New
                                Job</a>
                        </div>

                        <!-- Stats Row -->
                        <div class="row g-4 mb-4">
                            <div class="col-md-4">
                                <div class="stat-card">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-primary bg-opacity-10 p-3 rounded-4 me-3">
                                            <i class="fas fa-briefcase text-primary fs-3"></i>
                                        </div>
                                        <div>
                                            <h3 class="fw-bold mb-0">
                                                <%= totalJobs %>
                                            </h3>
                                            <p class="text-muted fw-bold small mb-0 uppercase">TOTAL JOBS POSTED</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Add more stats if needed -->
                        </div>

                        <!-- Filter & Table -->
                        <div class="card-table">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h2 class="fw-bold h4 mb-0">Manage Jobs</h2>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-success fw-bold px-4 rounded-3"
                                        onclick="exportJobsToExcel()">
                                        <i class="fas fa-file-excel me-2"></i> Export Job List
                                    </button>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table" id="jobTable">
                                    <thead>
                                        <tr>
                                            <th>Company</th>
                                            <th>Job Role</th>
                                            <th>Branch</th>
                                            <th>Salary</th>
                                            <th>Location</th>
                                            <th>Last Date</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if (jobs !=null) { for (String[] job : jobs) { %>
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <% if (job[8] !=null && !job[8].isEmpty()) { %>
                                                            <img src="<%= job[8] %>" alt="Logo"
                                                                class="rounded-circle me-2"
                                                                style="width: 32px; height: 32px; object-fit: contain; background: #eee;">
                                                            <% } %>
                                                                <%= job[1] %>
                                                    </div>
                                                </td>
                                                <td>
                                                    <%= job[2] %>
                                                </td>
                                                <td><span
                                                        class="badge bg-light text-primary border border-primary-subtle">
                                                        <%= job[6] %>
                                                    </span></td>
                                                <td>
                                                    <%= job[4] %>
                                                </td>
                                                <td><i class="fas fa-map-marker-alt text-muted me-1"></i>
                                                    <%= job[5] %>
                                                </td>
                                                <td>
                                                    <%= job[7] %>
                                                </td>
                                                <td>
                                                    <a href="<%=request.getContextPath()%>/EditJobServlet?id=<%= job[0] %>"
                                                        class="action-btn btn-edit" title="Edit"><i
                                                            class="fas fa-edit"></i></a>
                                                    <a href="<%=request.getContextPath()%>/DeleteJobServlet?id=<%= job[0] %>"
                                                        class="action-btn btn-delete" title="Delete"
                                                        onclick="return confirm('Are you sure you want to delete this job?')"><i
                                                            class="fas fa-trash"></i></a>
                                                    <a href="<%=request.getContextPath()%>/AdminViewApplicantsServlet?jobId=<%= job[0] %>"
                                                        class="action-btn btn-view" title="View Applicants"><i
                                                            class="fas fa-users"></i></a>
                                                </td>
                                            </tr>
                                            <% } } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </main>

                    <script>
                        function exportJobsToExcel() {
                            var table = document.getElementById("jobTable");
                            var wb = XLSX.utils.table_to_book(table, { sheet: "Jobs" });
                            XLSX.writeFile(wb, "SGP_Job_List.xlsx");
                        }
                    </script>
                </body>

                </html>