<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.placementcell.model.Student" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>SGP Admin Dashboard | Placement Cell</title>
                <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <!-- SheetJS for Excel export -->
                <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
                <style>
                    :root {
                        --primary: #00a8ff;
                        --primary-dark: #0097e6;
                        --bg: #f5f6fa;
                        --white: #ffffff;
                        --text: #2f3640;
                        --border: #edeff2;
                    }

                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                        font-family: 'Poppins', sans-serif;
                    }

                    body {
                        background: var(--bg);
                        color: var(--text);
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

                    .container {
                        padding: 30px 5%;
                    }

                    .admin-banner {
                        background: var(--primary);
                        color: white;
                        padding: 25px;
                        border-radius: 15px;
                        margin-bottom: 25px;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                    }

                    .filter-section {
                        background: white;
                        padding: 25px;
                        border-radius: 15px;
                        margin-bottom: 25px;
                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.02);
                    }

                    .filter-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
                        gap: 20px;
                        align-items: end;
                    }

                    .form-group {
                        display: flex;
                        flex-direction: column;
                        gap: 8px;
                    }

                    .form-group label {
                        font-size: 0.8rem;
                        font-weight: 600;
                        color: #7f8fa6;
                    }

                    .form-group input,
                    .form-group select {
                        padding: 10px;
                        border: 2px solid var(--border);
                        border-radius: 8px;
                        outline: none;
                    }

                    .btn {
                        padding: 10px 20px;
                        border-radius: 8px;
                        border: none;
                        font-weight: 600;
                        cursor: pointer;
                        transition: 0.3s;
                        display: inline-flex;
                        align-items: center;
                        gap: 8px;
                    }

                    .btn-primary {
                        background: var(--primary);
                        color: white;
                    }

                    .btn-success {
                        background: #2ed573;
                        color: white;
                    }

                    .btn-danger {
                        background: #ff4757;
                        color: white;
                    }

                    .table-container {
                        background: white;
                        border-radius: 15px;
                        overflow: hidden;
                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.02);
                    }

                    table {
                        width: 100%;
                        border-collapse: collapse;
                        text-align: left;
                    }

                    th {
                        background: #f8f9fa;
                        padding: 15px;
                        font-size: 0.85rem;
                        color: #7f8fa6;
                        text-transform: uppercase;
                        border-bottom: 2px solid var(--border);
                    }

                    td {
                        padding: 15px;
                        border-bottom: 1px solid var(--border);
                        font-size: 0.9rem;
                    }

                    tr:hover {
                        background: #f0faff;
                    }
                </style>
            </head>

            <body>
                <header class="header">
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <img src="images/sgp1.jpeg" width="40" height="40" style="border-radius: 5px;">
                        <h2 style="color: var(--primary);">SGP ADMIN PANEL</h2>
                    </div>
                    <a href="LogoutServlet" class="btn btn-danger" style="text-decoration: none;">LOGOUT</a>
                </header>

                <div class="container">
                    <div class="admin-banner">
                        <div>
                            <h1 style="font-size: 1.5rem;">Placement Management System</h1>
                            <p>Filter students, export databases, and generate eligibility lists</p>
                        </div>
                        <button class="btn btn-success" onclick="exportToExcel()"><i class="fas fa-file-excel"></i>
                            Export Selected to Excel</button>
                    </div>

                    <div class="filter-section">
                        <h3 style="margin-bottom: 15px;"><i class="fas fa-filter"></i> Search Criteria</h3>
                        <form action="AdminDashboardServlet" method="GET" class="filter-grid">
                            <div class="form-group">
                                <label>Branch</label>
                                <select name="branch">
                                    <option value="">All Branches</option>
                                    <option value="Computer Science">Computer Science</option>
                                    <option value="Electronics & Comm">Electronics & Comm</option>
                                    <option value="Mechanical Engg">Mechanical Engg</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Min CGPA</label>
                                <input type="number" step="0.1" name="minCgpa" placeholder="7.0">
                            </div>
                            <div class="form-group">
                                <label>Min SSLC %</label>
                                <input type="number" step="0.1" name="minSslc" placeholder="60">
                            </div>
                            <div class="form-group">
                                <label>Min PUC %</label>
                                <input type="number" step="0.1" name="minPuc" placeholder="60">
                            </div>
                            <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i> Apply
                                Filter</button>
                            <a href="AdminDashboardServlet" class="btn"
                                style="background: #e1e9f5; color: #57606f; text-decoration: none;">Reset</a>
                        </form>
                    </div>

                    <div class="table-container">
                        <table id="studentTable">
                            <thead>
                                <tr>
                                    <th>Register No</th>
                                    <th>Student Name</th>
                                    <th>Branch</th>
                                    <th>CGPA</th>
                                    <th>SSLC %</th>
                                    <th>Documents</th>
                                    <th>Contact</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Student> students = (List<Student>) request.getAttribute("studentList");
                                        if (students != null && !students.isEmpty()) {
                                        for (Student s : students) {
                                        %>
                                        <tr>
                                            <td style="font-weight: 700;">
                                                <%= s.getRegisterNumber() %>
                                            </td>
                                            <td>
                                                <%= s.getFullName() %>
                                            </td>
                                            <td><span
                                                    style="background: #f0faff; color: var(--primary); padding: 4px 10px; border-radius: 20px; font-size: 0.8rem; font-weight: 600;">
                                                    <%= s.getBranch() %>
                                                </span></td>
                                            <td>
                                                <%= s.getCgpa() %>
                                            </td>
                                            <td>
                                                <%= s.getSslcPercentage() %>%
                                            </td>
                                            <td style="display: flex; gap: 8px;">
                                                <% if (s.getSslcCardPath() !=null) { %>
                                                    <a href="<%= request.getContextPath() %>/ViewDocument?file=<%= s.getSslcCardPath() %>"
                                                        target="_blank" title="SSLC Marks Card"
                                                        style="color: #e67e22;"><i class="fas fa-file-pdf"></i></a>
                                                    <% } %>
                                                        <% if (s.getDiplomaCardPath() !=null) { %>
                                                            <a href="<%= request.getContextPath() %>/ViewDocument?file=<%= s.getDiplomaCardPath() %>"
                                                                target="_blank" title="Diploma Marksheet"
                                                                style="color: #27ae60;"><i
                                                                    class="fas fa-file-invoice"></i></a>
                                                            <% } %>
                                                                <% if (s.getResumePath() !=null) { %>
                                                                    <a href="<%= request.getContextPath() %>/ViewDocument?file=<%= s.getResumePath() %>"
                                                                        target="_blank" title="Latest Resume"
                                                                        style="color: #3498db;"><i
                                                                            class="fas fa-file-alt"></i></a>
                                                                    <% } else { %>
                                                                        <a href="ResumeServlet?id=<%= s.getId() %>"
                                                                            target="_blank"
                                                                            title="Auto-Generated Resume"
                                                                            style="color: #95a5a6;"><i
                                                                                class="fas fa-robot"></i></a>
                                                                        <% } %>
                                            </td>
                                            <td>
                                                <%= s.getMobileNumber() %>
                                            </td>
                                            <td><button class="btn btn-primary"
                                                    style="padding: 5px 10px; font-size: 0.75rem;">Shortlist</button>
                                            </td>
                                        </tr>
                                        <% } } else { %>
                                            <tr>
                                                <td colspan="8"
                                                    style="text-align: center; padding: 40px; color: #7f8fa6;">No
                                                    students found matching your criteria.</td>
                                            </tr>
                                            <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <script>
                    function exportToExcel() {
                        var table = document.getElementById("studentTable");
                        var wb = XLSX.utils.table_to_book(table, { sheet: "Shortlisted Students" });
                        XLSX.writeFile(wb, "SGP_Placement_List.xlsx");
                    }
                </script>
            </body>

            </html>