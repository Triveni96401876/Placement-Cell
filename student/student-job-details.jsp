<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.placementcell.dao.JobDAO" %>
        <% String idStr=request.getParameter("id"); String[] job=null; if (idStr !=null) { JobDAO jobDAO=new JobDAO();
            job=jobDAO.getJobById(Integer.parseInt(idStr)); } if (job==null) {
            response.sendRedirect(request.getContextPath() + "/JobPortalServlet" ); return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>
                    <%= job[2] %> at <%= job[1] %> | SGP Portal
                </title>
                <!-- Bootstrap 5 CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                        padding-bottom: 80px;
                    }

                    .detail-card {
                        background: #fff;
                        border-radius: 32px;
                        padding: 50px;
                        box-shadow: 0 20px 50px -12px rgba(0, 0, 0, 0.05);
                        border: 1px solid #f1f5f9;
                        margin-top: -60px;
                        position: relative;
                        z-index: 10;
                    }

                    .company-header {
                        background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
                        height: 250px;
                        border-radius: 0 0 50px 50px;
                    }

                    .logo-container {
                        width: 120px;
                        height: 120px;
                        background: white;
                        border-radius: 30px;
                        padding: 20px;
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        margin-bottom: 30px;
                        border: 1px solid #f1f5f9;
                    }

                    .logo-container img {
                        width: 100%;
                        height: 100%;
                        object-fit: contain;
                    }

                    .section-title {
                        font-weight: 800;
                        font-size: 1.25rem;
                        color: #1e293b;
                        margin-bottom: 20px;
                        display: flex;
                        align-items: center;
                        gap: 12px;
                    }

                    .section-title i {
                        color: var(--primary);
                    }

                    .info-pill {
                        background: #f8fafc;
                        padding: 15px 25px;
                        border-radius: 20px;
                        display: flex;
                        flex-direction: column;
                        gap: 5px;
                        border: 1px solid #f1f5f9;
                    }

                    .info-pill label {
                        font-size: 0.75rem;
                        font-weight: 800;
                        color: #94a3b8;
                        text-transform: uppercase;
                        letter-spacing: 1px;
                    }

                    .info-pill span {
                        font-weight: 700;
                        color: #1e293b;
                        font-size: 1rem;
                    }

                    .description-content {
                        line-height: 1.8;
                        color: #475569;
                        font-size: 1.1rem;
                        white-space: pre-wrap;
                    }

                    .apply-sidebar {
                        background: #f8fafc;
                        border-radius: 28px;
                        padding: 30px;
                        border: 1px solid #f1f5f9;
                        position: sticky;
                        top: 100px;
                    }

                    .btn-apply-now {
                        background: var(--primary);
                        color: white;
                        padding: 18px;
                        border-radius: 20px;
                        font-weight: 800;
                        font-size: 1.2rem;
                        width: 100%;
                        border: none;
                        box-shadow: 0 10px 25px rgba(67, 97, 238, 0.3);
                        transition: 0.3s;
                    }

                    .btn-apply-now:hover {
                        transform: translateY(-5px);
                        background: #3f37c9;
                        box-shadow: 0 15px 35px rgba(67, 97, 238, 0.4);
                        color: white;
                    }
                </style>
            </head>

            <body>

                <div class="company-header">
                    <div class="container py-4">
                        <a href="<%= request.getContextPath() %>/JobPortalServlet"
                            class="btn btn-outline-light rounded-pill px-4 fw-bold">
                            <i class="fas fa-arrow-left me-2"></i> Back to Jobs
                        </a>
                    </div>
                </div>

                <div class="container">
                    <div class="row g-5">
                        <div class="col-lg-8">
                            <div class="detail-card">
                                <div class="logo-container">
                                    <% if (job[8] !=null && !job[8].isEmpty()) { %>
                                        <img src="<%= request.getContextPath() %>/<%= job[8] %>" alt="Logo">
                                        <% } else { %>
                                            <i class="fas fa-building text-muted fs-1"></i>
                                            <% } %>
                                </div>

                                <h1 class="display-6 fw-bold mb-2">
                                    <%= job[2] %>
                                </h1>
                                <h4 class="text-primary fw-bold mb-4">
                                    <%= job[1] %>
                                </h4>

                                <div class="row g-3 mb-5">
                                    <div class="col-md-4">
                                        <div class="info-pill">
                                            <label>Salary Package</label>
                                            <span>
                                                <%= job[4] %>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="info-pill">
                                            <label>Job Location</label>
                                            <span>
                                                <%= job[5] %>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="info-pill">
                                            <label>Eligibility</label>
                                            <span>
                                                <%= job[6] %>
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-5">
                                    <h3 class="section-title"><i class="fas fa-align-left"></i> Job Description</h3>
                                    <div class="description-content">
                                        <%= job[3] %>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4">
                            <div class="apply-sidebar shadow-sm">
                                <h5 class="fw-bold mb-4">Ready to Apply?</h5>

                                <form action="<%= request.getContextPath() %>/ApplyJobServlet" method="POST"
                                    enctype="multipart/form-data">
                                    <input type="hidden" name="jobId" value="<%= job[0] %>">
                                    <input type="hidden" name="companyName" value="<%= job[1] %>">
                                    <input type="hidden" name="jobRole" value="<%= job[2] %>">

                                    <div class="mb-4">
                                        <label class="form-label fw-bold small text-muted">UPLOAD UPDATED RESUME
                                            (OPTIONAL)</label>
                                        <input type="file" name="resumeFile" class="form-control rounded-3"
                                            accept=".pdf,.doc,.docx">
                                        <p class="text-muted smallest mt-2 fw-medium"><i class="fas fa-info-circle"></i>
                                            If not uploaded, your profile resume will be used.</p>
                                    </div>

                                    <button type="submit" class="btn-apply-now mb-3">
                                        Apply Now <i class="fas fa-paper-plane ms-2"></i>
                                    </button>
                                </form>

                                <hr class="my-4 opacity-10">

                                <div class="d-flex align-items-center gap-3 mb-3">
                                    <div class="bg-danger bg-opacity-10 p-2 rounded-circle">
                                        <i class="far fa-calendar-alt text-danger"></i>
                                    </div>
                                    <div>
                                        <p class="mb-0 text-muted small fw-bold">LAST DATE TO APPLY</p>
                                        <h6 class="mb-0 fw-bold">
                                            <%= job[7] %>
                                        </h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Bootstrap 5 JS -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>