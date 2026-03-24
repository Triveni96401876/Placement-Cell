<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <% List<String[]> activeJobs = (List<String[]>) request.getAttribute("activeJobs");
                int totalJobs = (activeJobs != null) ? activeJobs.size() : 0;
                %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Student Job Portal | SGP Placement Cell</title>
                    <!-- Bootstrap 5 CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <link
                        href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap"
                        rel="stylesheet">
                    <style>
                        :root {
                            --primary: #4361ee;
                            --bg: #f8f9fe;
                        }

                        body {
                            background-color: var(--bg);
                            font-family: 'Plus Jakarta Sans', sans-serif;
                            color: #1a1c2d;
                            padding-bottom: 50px;
                        }

                        .header-section {
                            background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
                            color: white;
                            padding: 60px 0;
                            margin-bottom: 50px;
                            border-radius: 0 0 50px 50px;
                            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                        }

                        .job-card {
                            background: #fff;
                            border-radius: 24px;
                            padding: 30px;
                            height: 100%;
                            border: 1px solid #f1f5f9;
                            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.04);
                            transition: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                            position: relative;
                            overflow: hidden;
                        }

                        .job-card:hover {
                            transform: translateY(-10px);
                            box-shadow: 0 20px 40px rgba(67, 97, 238, 0.1);
                            border-color: rgba(67, 97, 238, 0.2);
                        }

                        .company-logo {
                            width: 70px;
                            height: 70px;
                            background: #f8fafc;
                            border-radius: 20px;
                            padding: 12px;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            margin-bottom: 20px;
                            border: 1px solid #f1f5f9;
                        }

                        .company-logo img {
                            width: 100%;
                            height: 100%;
                            object-fit: contain;
                        }

                        .job-title {
                            font-weight: 800;
                            font-size: 1.35rem;
                            color: #1e293b;
                            margin-bottom: 5px;
                            letter-spacing: -0.5px;
                        }

                        .company-name {
                            font-weight: 700;
                            color: var(--primary);
                            font-size: 1rem;
                            margin-bottom: 15px;
                        }

                        .job-meta {
                            display: flex;
                            flex-wrap: wrap;
                            gap: 12px;
                            margin-bottom: 20px;
                        }

                        .meta-item {
                            background: #f8fafc;
                            padding: 6px 14px;
                            border-radius: 100px;
                            font-size: 0.8rem;
                            font-weight: 700;
                            color: #64748b;
                            display: flex;
                            align-items: center;
                            gap: 6px;
                        }

                        .btn-apply {
                            background: var(--primary);
                            color: white;
                            border: none;
                            padding: 12px 24px;
                            border-radius: 16px;
                            font-weight: 800;
                            width: 100%;
                            transition: 0.3s;
                            box-shadow: 0 4px 12px rgba(67, 97, 238, 0.2);
                        }

                        .btn-apply:hover {
                            background: #3f37c9;
                            transform: scale(1.02);
                            color: white;
                        }

                        .last-date {
                            font-size: 0.75rem;
                            text-align: center;
                            margin-top: 15px;
                            color: #94a3b8;
                            font-weight: 600;
                        }

                        .navbar-brand {
                            font-weight: 800;
                            font-size: 1.5rem;
                            letter-spacing: -1px;
                        }

                        .nav-link {
                            font-weight: 700;
                            margin-left: 15px;
                            color: #64748b;
                        }

                        .nav-link:hover {
                            color: var(--primary);
                        }
                    </style>
                </head>

                <body>

                    <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom py-3 sticky-top">
                        <div class="container">
                            <a class="navbar-brand text-primary" href="DashboardServlet">SGP Portal</a>
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                data-bs-target="#navbarNav">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarNav">
                                <ul class="navbar-nav ms-auto ps-4 fw-bold">
                                    <li class="nav-item ps-4"><a class="nav-link" href="DashboardServlet">Dashboard</a>
                                    </li>
                                    <li class="nav-item ps-4"><a class="nav-link active text-primary"
                                            href="JobPortalServlet">Jobs</a></li>
                                    <li class="nav-item ps-4"><a class="nav-link" href="LogoutServlet">Logout</a></li>
                                </ul>
                            </div>
                        </div>
                    </nav>

                    <header class="header-section text-center">
                        <div class="container">
                            <span
                                class="badge bg-primary bg-opacity-25 text-primary fw-bold px-3 py-2 rounded-pill mb-3">Sanjay
                                Gandhi Polytechnic, Ballari</span>
                            <h1 class="display-5 fw-bold mb-3">Student Placement Portal</h1>
                            <p class="lead opacity-75 fw-medium mx-auto" style="max-width: 600px;">Discover elite career
                                opportunities and take the first step towards your professional journey.</p>
                        </div>
                    </header>

                    <div class="container">
                        <% if (request.getParameter("msg") !=null) { %>
                            <div class="alert alert-success alert-dismissible fade show rounded-4 fw-bold mb-5 shadow-sm border-0 py-3"
                                role="alert">
                                <i class="fas fa-check-circle me-2"></i> Your application has been submitted
                                successfully.
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <% } %>

                                <div class="row g-4 justify-content-center">
                                    <% if (activeJobs !=null) { for (String[] job : activeJobs) { %>
                                        <div class="col-lg-4 col-md-6">
                                            <div class="job-card">
                                                <div class="company-logo">
                                                    <% if (job[8] !=null && !job[8].isEmpty()) { %>
                                                        <img src="<%= job[8] %>" alt="Company Logo">
                                                        <% } else { %>
                                                            <i class="fas fa-building text-muted fs-2"></i>
                                                            <% } %>
                                                </div>
                                                <div class="company-name text-uppercase small letter-spacing-1">
                                                    <%= job[1] %> / PLACEMENT
                                                </div>
                                                <h2 class="job-title">
                                                    <%= job[2] %>
                                                </h2>

                                                <div class="job-meta">
                                                    <div class="meta-item"><i class="fas fa-wallet"></i>
                                                        <%= job[4] %>
                                                    </div>
                                                    <div class="meta-item"><i class="fas fa-map-marker-alt"></i>
                                                        <%= job[5] %>
                                                    </div>
                                                    <div class="meta-item"><i class="fas fa-graduation-cap"></i>
                                                        <%= job[6] %> Branch
                                                    </div>
                                                </div>

                                                <div class="mb-4 text-muted small fw-medium"
                                                    style="display: -webkit-box; -webkit-line-clamp: 3; line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; line-height: 1.6;">
                                                    <%= job[3].replaceAll("<[^>]*>", " ") %>
                                                </div>

                                                <a href="<%= request.getContextPath() %>/student/student-job-details.jsp?id=<%= job[0] %>"
                                                    class="btn btn-apply">
                                                    View Details & Apply
                                                </a>

                                                <div class="last-date">
                                                    <i class="far fa-clock me-1"></i> Apply before: <span
                                                        class="text-danger fw-bold">
                                                        <%= job[7] %>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <% } } %>

                                            <% if (totalJobs==0) { %>
                                                <div class="col-12 text-center py-5">
                                                    <div class="bg-white p-5 rounded-5 shadow-sm border border-dashed">
                                                        <i class="fas fa-briefcase text-muted fs-1 mb-3"></i>
                                                        <h2 class="fw-bold">No jobs posted yet</h2>
                                                        <p class="text-muted fw-medium">Check back soon for new
                                                            opportunities</p>
                                                    </div>
                                                </div>
                                                <% } %>
                                </div>
                    </div>

                    <!-- Bootstrap 5 JS -->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                </body>

                </html>