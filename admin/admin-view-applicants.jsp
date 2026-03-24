<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <% List<String[]> applicants = (List<String[]>) request.getAttribute("applicants");
                int totalApplicants = (applicants != null) ? applicants.size() : 0;
                %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Job Applications | SGP Admin</title>
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

                        .main-content {
                            margin-left: var(--sidebar-width);
                            padding: 2rem;
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
                        }

                        .nav-link.active {
                            background: #eef2ff;
                            color: var(--primary);
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
                            <a href="<%=request.getContextPath()%>/AdminJobPortalServlet" class="nav-link"><i
                                    class="fas fa-briefcase"></i> Job
                                Portal</a>
                            <a href="<%=request.getContextPath()%>/AdminViewApplicantsServlet"
                                class="nav-link active"><i class="fas fa-file-alt"></i>
                                Job Applications</a>
                            <a href="<%=request.getContextPath()%>/admin/admin-push-circular.jsp" class="nav-link"><i
                                    class="fas fa-bullhorn"></i>
                                Announcements</a>
                            <a href="<%=request.getContextPath()%>/LogoutServlet"
                                class="nav-link text-danger mt-auto"><i class="fas fa-sign-out-alt"></i> Logout</a>
                        </nav>
                    </aside>

                    <main class="main-content">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div>
                                <h1 class="fw-bold h2 mb-1">Job Applications List</h1>
                                <p class="text-muted fw-medium">Monitor all applications submitted by students</p>
                            </div>
                            <button class="btn btn-success fw-bold px-4 rounded-3" onclick="exportApplicantsToExcel()">
                                <i class="fas fa-file-excel me-2"></i> Export Applicants List
                            </button>
                        </div>

                        <div class="card-table">
                            <div class="row g-3 mb-4">
                                <div class="col-md-4">
                                    <input type="text" id="searchInput" class="form-control rounded-3"
                                        placeholder="Search by Company or Branch..." onkeyup="filterTable()">
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table" id="applicantTable">
                                    <thead>
                                        <tr>
                                            <th>Student Name</th>
                                            <th>Reg Number</th>
                                            <th>Branch</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Company</th>
                                            <th>Applied Date</th>
                                            <th>Resume</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if (applicants !=null) { for (String[] app : applicants) { %>
                                            <tr>
                                                <td>
                                                    <%= app[0] %>
                                                </td>
                                                <td class="text-primary fw-bold">
                                                    <%= app[1] %>
                                                </td>
                                                <td><span
                                                        class="badge bg-light text-primary border border-primary-subtle">
                                                        <%= app[2] %>
                                                    </span></td>
                                                <td>
                                                    <%= app[3] %>
                                                </td>
                                                <td>
                                                    <%= app[4] %>
                                                </td>
                                                <td class="fw-bold text-dark">
                                                    <%= app[5] %> (<%= app[6] %>)
                                                </td>
                                                <td><small class="text-muted">
                                                        <%= app[7] %>
                                                    </small></td>
                                                <td>
                                                    <% if (app[8] !=null && !app[8].isEmpty()) { %>
                                                        <a href="<%= app[8] %>"
                                                            class="btn btn-sm btn-outline-primary fw-bold rounded-pill px-3"
                                                            target="_blank">
                                                            <i class="fas fa-download me-1"></i> Resume
                                                        </a>
                                                        <% } else { %>
                                                            <span class="text-muted small">N/A</span>
                                                            <% } %>
                                                </td>
                                            </tr>
                                            <% } } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </main>

                    <script>
                        function filterTable() {
                            var input, filter, table, tr, td, i, j, txtValue;
                            input = document.getElementById("searchInput");
                            filter = input.value.toUpperCase();
                            table = document.getElementById("applicantTable");
                            tr = table.getElementsByTagName("tr");
                            for (i = 1; i < tr.length; i++) {
                                var found = false;
                                td = tr[i].getElementsByTagName("td");
                                for (j = 0; j < td.length; j++) {
                                    if (td[j]) {
                                        txtValue = td[j].textContent || td[j].innerText;
                                        if (txtValue.toUpperCase().indexOf(filter) > -1) {
                                            found = true;
                                            break;
                                        }
                                    }
                                }
                                tr[i].style.display = found ? "" : "none";
                            }
                        }

                        function exportApplicantsToExcel() {
                            var table = document.getElementById("applicantTable");
                            var wb = XLSX.utils.table_to_book(table, { sheet: "Applicants" });
                            XLSX.writeFile(wb, "SGP_Job_Applications.xlsx");
                        }
                    </script>
                </body>

                </html>