<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <% List<String[]> registrations = (List<String[]>) request.getAttribute("registrations"); %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Registered Candidates | SGP Admin</title>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
                        rel="stylesheet">
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <style>
                        :root {
                            --primary: #6366f1;
                            --primary-light: #818cf8;
                            --secondary: #4f46e5;
                            --success: #10b981;
                            --warning: #f59e0b;
                            --danger: #ef4444;
                            --bg: #f8fafc;
                            --surface: #ffffff;
                            --text: #0f172a;
                            --text-muted: #64748b;
                            --border: #e2e8f0;
                            --radius-xl: 24px;
                            --radius-lg: 16px;
                            --shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.05);
                        }

                        * {
                            margin: 0;
                            padding: 0;
                            box-sizing: border-box;
                            font-family: 'Outfit', sans-serif;
                        }

                        body {
                            background: var(--bg);
                            color: var(--text);
                            min-height: 100vh;
                            padding: 40px 20px;
                            background-image:
                                radial-gradient(at 0% 0%, rgba(99, 102, 241, 0.05) 0px, transparent 50%),
                                radial-gradient(at 100% 100%, rgba(79, 70, 229, 0.05) 0px, transparent 50%);
                        }

                        .container {
                            max-width: 1400px;
                            margin: 0 auto;
                        }

                        /* Glassmorphic Header */
                        .header {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            margin-bottom: 30px;
                            background: rgba(255, 255, 255, 0.8);
                            backdrop-filter: blur(12px);
                            padding: 24px 32px;
                            border-radius: var(--radius-xl);
                            border: 1px solid var(--surface);
                            box-shadow: var(--shadow);
                            animation: slideDown 0.6s cubic-bezier(0.16, 1, 0.3, 1);
                        }

                        @keyframes slideDown {
                            from {
                                transform: translateY(-20px);
                                opacity: 0;
                            }

                            to {
                                transform: translateY(0);
                                opacity: 1;
                            }
                        }

                        .header-title {
                            display: flex;
                            align-items: center;
                            gap: 16px;
                        }

                        .header-icon {
                            width: 48px;
                            height: 48px;
                            background: linear-gradient(135deg, var(--primary), var(--secondary));
                            color: white;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            border-radius: 14px;
                            font-size: 1.4rem;
                            box-shadow: 0 8px 15px rgba(99, 102, 241, 0.3);
                        }

                        .header h1 {
                            font-size: 1.75rem;
                            font-weight: 800;
                            letter-spacing: -0.02em;
                            color: var(--text);
                        }

                        .search-container {
                            position: relative;
                            display: flex;
                            align-items: center;
                            gap: 16px;
                        }

                        .search-wrapper {
                            position: relative;
                        }

                        .search-wrapper i {
                            position: absolute;
                            left: 16px;
                            top: 50%;
                            transform: translateY(-50%);
                            color: var(--text-muted);
                            transition: color 0.3s;
                        }

                        .search-input {
                            padding: 12px 16px 12px 48px;
                            border: 2px solid #f1f5f9;
                            border-radius: 14px;
                            outline: none;
                            width: 320px;
                            font-size: 0.95rem;
                            font-weight: 500;
                            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                            background: #f8fafc;
                        }

                        .search-input:focus {
                            border-color: var(--primary-light);
                            background: white;
                            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
                            width: 380px;
                        }

                        .search-input:focus+i {
                            color: var(--primary);
                        }

                        .btn-back {
                            display: flex;
                            align-items: center;
                            gap: 8px;
                            padding: 12px 20px;
                            background: white;
                            color: var(--text-muted);
                            text-decoration: none;
                            border-radius: 14px;
                            font-weight: 700;
                            font-size: 0.9rem;
                            transition: all 0.2s;
                            border: 1px solid var(--border);
                        }

                        .btn-back:hover {
                            background: #f8fafc;
                            color: var(--text);
                            transform: translateX(-4px);
                        }

                        /* Enhanced Table View */
                        .table-card {
                            background: white;
                            border-radius: var(--radius-xl);
                            overflow: hidden;
                            box-shadow: var(--shadow);
                            border: 1px solid var(--border);
                            animation: fadeIn 0.8s ease-out;
                        }

                        @keyframes fadeIn {
                            from {
                                opacity: 0;
                                transform: translateY(10px);
                            }

                            to {
                                opacity: 1;
                                transform: translateY(0);
                            }
                        }

                        table {
                            width: 100%;
                            border-collapse: collapse;
                        }

                        th {
                            background: #f8fafc;
                            padding: 24px 20px;
                            font-weight: 700;
                            color: var(--text-muted);
                            text-transform: uppercase;
                            font-size: 0.75rem;
                            letter-spacing: 0.05em;
                            border-bottom: 2px solid var(--bg);
                        }

                        td {
                            padding: 20px;
                            border-bottom: 1px solid #f1f5f9;
                            vertical-align: middle;
                        }

                        tr:last-child td {
                            border-bottom: none;
                        }

                        tr:hover {
                            background: #fafbff;
                        }

                        /* List Items Styling */
                        .job-tag {
                            background: rgba(99, 102, 241, 0.08);
                            color: var(--primary);
                            padding: 6px 14px;
                            border-radius: 10px;
                            font-size: 0.8rem;
                            font-weight: 700;
                            display: inline-block;
                            border: 1px solid rgba(99, 102, 241, 0.1);
                        }

                        .candidate-profile {
                            display: flex;
                            gap: 14px;
                            align-items: center;
                        }

                        .profile-img {
                            width: 50px;
                            height: 50px;
                            border-radius: 16px;
                            object-fit: cover;
                            border: 2px solid white;
                            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
                            background: #f1f5f9;
                        }

                        .candidate-name {
                            display: block;
                            font-weight: 800;
                            color: var(--text);
                            font-size: 1rem;
                            margin-bottom: 2px;
                        }

                        .candidate-meta {
                            font-size: 0.8rem;
                            color: var(--text-muted);
                            display: flex;
                            gap: 12px;
                        }

                        .stats-badge {
                            font-weight: 700;
                            color: var(--secondary);
                            font-size: 0.9rem;
                            margin-bottom: 4px;
                        }

                        .cgpa-pill {
                            background: #f1f5f9;
                            padding: 2px 8px;
                            border-radius: 6px;
                            color: var(--text);
                        }

                        .backlog-warning {
                            color: var(--warning);
                            font-weight: 600;
                            font-size: 0.75rem;
                        }

                        .backlog-none {
                            color: var(--success);
                            font-weight: 600;
                            font-size: 0.75rem;
                        }

                        .sem-grid {
                            display: grid;
                            grid-template-columns: repeat(3, 1fr);
                            gap: 4px;
                        }

                        .sem-cell {
                            background: #f8fafc;
                            padding: 4px 8px;
                            border-radius: 6px;
                            font-size: 0.7rem;
                            color: var(--text-muted);
                            border: 1px solid #f1f5f9;
                        }

                        .sem-cell strong {
                            color: var(--text);
                        }

                        .resume-btn {
                            display: inline-flex;
                            align-items: center;
                            gap: 6px;
                            padding: 8px 14px;
                            background: var(--primary);
                            color: white;
                            text-decoration: none;
                            border-radius: 10px;
                            font-size: 0.8rem;
                            font-weight: 700;
                            transition: all 0.2s;
                            box-shadow: 0 4px 10px rgba(99, 102, 241, 0.2);
                        }

                        .resume-btn:hover {
                            background: var(--secondary);
                            transform: translateY(-2px);
                            box-shadow: 0 6px 12px rgba(99, 102, 241, 0.3);
                        }

                        .date-applied {
                            font-size: 0.85rem;
                            color: var(--text-muted);
                            font-weight: 500;
                        }

                        /* Empty State */
                        .empty-state {
                            text-align: center;
                            padding: 80px 40px;
                            background: white;
                        }

                        .empty-illustration {
                            width: 200px;
                            height: 200px;
                            background: rgba(99, 102, 241, 0.05);
                            border-radius: 50%;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            margin: 0 auto 30px;
                            position: relative;
                        }

                        .empty-illustration i {
                            font-size: 5rem;
                            color: var(--primary);
                            opacity: 0.3;
                        }

                        .empty-illustration::after {
                            content: '';
                            position: absolute;
                            inset: -10px;
                            border: 2px dashed rgba(99, 102, 241, 0.1);
                            border-radius: 50%;
                            animation: rotate 20s linear infinite;
                        }

                        @keyframes rotate {
                            from {
                                transform: rotate(0deg);
                            }

                            to {
                                transform: rotate(360deg);
                            }
                        }

                        .empty-state h2 {
                            font-size: 1.5rem;
                            font-weight: 800;
                            color: var(--text);
                            margin-bottom: 12px;
                        }

                        .empty-state p {
                            color: var(--text-muted);
                            max-width: 400px;
                            margin: 0 auto;
                            line-height: 1.6;
                        }
                    </style>
                </head>

                <body>
                    <div class="container">
                        <header class="header">
                            <div class="header-title">
                                <div class="header-icon">
                                    <i class="fas fa-users-viewfinder"></i>
                                </div>
                                <div>
                                    <% String jTitle=(String) request.getAttribute("filteredJobTitle"); %>
                                        <h1>
                                            <%= (jTitle !=null) ? "Applicants for " + jTitle : "Registered Candidates"
                                                %>
                                        </h1>
                                </div>
                            </div>

                            <div class="search-container">
                                <div class="search-wrapper">
                                    <i class="fas fa-search"></i>
                                    <input type="text" id="regSearch" class="search-input"
                                        placeholder="Filter by name, USN, or job...">
                                </div>
                                <a href="<%=request.getContextPath()%>/AdminDashboardServlet" class="btn-back">
                                    <i class="fas fa-arrow-left"></i> Dashboard
                                </a>
                            </div>
                        </header>

                        <section class="table-card">
                            <% if (registrations !=null && !registrations.isEmpty()) { %>
                                <table id="regTable">
                                    <thead>
                                        <tr>
                                            <th width="15%">Job Profile</th>
                                            <th width="25%">Candidate Profile</th>
                                            <th width="20%">Academics</th>
                                            <th width="15%">Semester Performance</th>
                                            <th width="15%">Links & Skills</th>
                                            <th width="10%">Applied On</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (String[] reg : registrations) { %>
                                            <tr>
                                                <td>
                                                    <span class="job-tag">
                                                        <%= reg[0] %>
                                                    </span>
                                                </td>
                                                <td>
                                                    <div class="candidate-profile">
                                                        <% if (reg.length> 18 && reg[18] != null && !reg[18].isEmpty())
                                                            { %>
                                                            <img src="<%= reg[18] %>" class="profile-img" alt="profile">
                                                            <% } else { %>
                                                                <div class="profile-img"
                                                                    style="display: flex; align-items: center; justify-content: center; font-size: 1.2rem; color: var(--text-muted);">
                                                                    <i class="fas fa-user"></i>
                                                                </div>
                                                                <% } %>
                                                                    <div>
                                                                        <span class="candidate-name">
                                                                            <%= reg[1] %>
                                                                        </span>
                                                                        <div class="candidate-meta">
                                                                            <span><i class="fas fa-envelope"></i>
                                                                                <%= reg[2] %>
                                                                            </span>
                                                                        </div>
                                                                    </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="stats-badge">
                                                        <%= reg[4] %>
                                                    </div>
                                                    <div
                                                        style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 4px;">
                                                        Agg: <strong>
                                                            <%= reg[5] %>%
                                                        </strong> |
                                                        CGPA: <span class="cgpa-pill">
                                                            <%= reg[6] %>
                                                        </span>
                                                    </div>
                                                    <% int bCount=(reg.length> 16) ? Integer.parseInt(reg[16]) : 0; %>
                                                        <div class="<%= (bCount > 0) ? " backlog-warning"
                                                            : "backlog-none" %>">
                                                            <i class="fas fa-circle"
                                                                style="font-size: 0.5rem; vertical-align: middle; margin-right: 4px;"></i>
                                                            <%= (bCount> 0) ? bCount + " Active Backlogs" : "Clear
                                                                History" %>
                                                        </div>
                                                </td>
                                                <td>
                                                    <div class="sem-grid">
                                                        <% for(int i=1; i<=6; i++) { String val=(reg.length> (9+i)) ?
                                                            reg[9+i] : "0"; %>
                                                            <div class="sem-cell">S<%=i%>: <strong>
                                                                        <%=val%>
                                                                    </strong></div>
                                                            <% } %>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div style="font-size: 0.75rem; color: var(--text-muted); margin-bottom: 10px; display: -webkit-box; -webkit-line-clamp: 1; line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden;"
                                                        title="<%= reg[7] %>">
                                                        <i class="fas fa-microchip"></i>
                                                        <%= (reg[7] !=null) ? reg[7] : "N/A" %>
                                                    </div>
                                                    <% if (reg[8] !=null && !reg[8].isEmpty()) { %>
                                                        <a href="<%= reg[8] %>" target="_blank" class="resume-btn">
                                                            <i class="fas fa-file-pdf"></i> View Resume
                                                        </a>
                                                        <% } %>
                                                </td>
                                                <td>
                                                    <div class="date-applied">
                                                        <%= (reg[9].length()> 10) ? reg[9].substring(0, 10) : reg[9] %>
                                                    </div>
                                                </td>
                                            </tr>
                                            <% } %>
                                    </tbody>
                                </table>
                                <% } else { %>
                                    <div class="empty-state">
                                        <div class="empty-illustration">
                                            <i class="fas fa-folder-open"></i>
                                        </div>
                                        <h2>No applications found</h2>
                                        <p>It looks like there are no registrations for this profile yet. Once students
                                            apply, you'll see them listed here with all their details.</p>
                                    </div>
                                    <% } %>
                        </section>
                    </div>

                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            const searchInput = document.getElementById('regSearch');
                            const table = document.getElementById('regTable');
                            if (table) {
                                const rows = table.querySelectorAll('tbody tr');
                                searchInput.addEventListener('input', function () {
                                    const q = searchInput.value.toLowerCase();
                                    rows.forEach(row => {
                                        const text = row.innerText.toLowerCase();
                                        row.style.display = text.includes(q) ? '' : 'none';
                                    });
                                });
                            }
                        });
                    </script>
                </body>

                </html>