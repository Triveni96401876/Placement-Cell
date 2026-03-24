<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Post Job Opportunity | SGP Admin</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link
            href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap"
            rel="stylesheet">
        <style>
            :root {
                --primary: #4361ee;
                --secondary: #3f37c9;
                --bg: #f8f9fe;
            }

            body {
                background-color: var(--bg);
                font-family: 'Plus Jakarta Sans', sans-serif;
                color: #1a1c2d;
                padding: 50px 0;
            }

            .form-card {
                background: #fff;
                border-radius: 32px;
                padding: 40px;
                box-shadow: 0 20px 50px -12px rgba(0, 0, 0, 0.1);
                border: 1px solid #f1f5f9;
            }

            .form-label {
                font-weight: 700;
                font-size: 0.9rem;
                color: #475569;
                margin-left: 5px;
                margin-bottom: 8px;
            }

            .form-control,
            .form-select {
                padding: 12px 20px;
                background: #f1f5f9;
                border: 2px solid transparent;
                border-radius: 16px;
                font-weight: 600;
                transition: 0.3s;
            }

            .form-control:focus,
            .form-select:focus {
                background: white;
                border-color: var(--primary);
                box-shadow: 0 0 0 4px rgba(67, 97, 238, 0.1);
            }

            .btn-post {
                background: var(--primary);
                color: white;
                padding: 15px;
                border-radius: 18px;
                font-weight: 800;
                font-size: 1.1rem;
                width: 100%;
                margin-top: 20px;
                box-shadow: 0 10px 25px rgba(67, 97, 238, 0.3);
                border: none;
                transition: 0.3s;
            }

            .btn-post:hover {
                transform: translateY(-3px);
                background: var(--secondary);
                color: white;
            }

            .icon-box {
                width: 70px;
                height: 70px;
                background: linear-gradient(135deg, var(--primary), var(--secondary));
                color: white;
                border-radius: 20px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.8rem;
                margin: 0 auto 25px;
                box-shadow: 0 10px 20px rgba(67, 97, 238, 0.2);
                transform: rotate(-5deg);
            }
        </style>
    </head>

    <body>

        <div class="container overflow-hidden">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="form-card">
                        <div class="text-center mb-5">
                            <div class="icon-box">
                                <i class="fas fa-bullhorn"></i>
                            </div>
                            <h1 class="fw-bold h2 mb-1">Broadcast Job Opportunity</h1>
                            <p class="text-muted fw-bold small uppercase">NEW HIRING UPDATE FOR STUDENT COMMUNITY</p>
                        </div>

                        <form action="<%=request.getContextPath()%>/PostJobServlet" method="POST" enctype="multipart/form-data">
                            <div class="row g-4">
                                <div class="col-md-6">
                                    <label class="form-label">Company Name</label>
                                    <input type="text" name="companyName" class="form-control"
                                        placeholder="e.g. Google, JSW" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Company Logo Upload</label>
                                    <input type="file" name="companyLogo" class="form-control" accept="image/*">
                                </div>
                                <div class="col-md-12">
                                    <label class="form-label">Job Role</label>
                                    <input type="text" name="jobRole" class="form-control"
                                        placeholder="e.g. GET, Apprentice, Engineer" required>
                                </div>
                                <div class="col-md-12">
                                    <label class="form-label">Job Description</label>
                                    <textarea name="description" class="form-control" rows="5"
                                        placeholder="Detailed requirements & highlights..." required></textarea>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Salary Package</label>
                                    <input type="text" name="salary" class="form-control" placeholder="e.g. 5.5 LPA"
                                        required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Job Location</label>
                                    <input type="text" name="location" class="form-control"
                                        placeholder="e.g. Pune, Bengaluru" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Eligible Branch</label>
                                    <select name="branch" class="form-select" required>
                                        <option value="All Branches">All Branches</option>
                                        <option value="CSE">CSE</option>
                                        <option value="ME">ME</option>
                                        <option value="EEE">EEE</option>
                                        <option value="Civil">Civil</option>
                                        <option value="MT">MT</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Last Date to Apply</label>
                                    <input type="date" name="lastDate" class="form-control" required>
                                </div>
                                <div class="col-md-12">
                                    <label class="form-label">Application Link</label>
                                    <input type="url" name="applyLink" class="form-control"
                                        placeholder="e.g. https://company.com/apply">
                                </div>
                            </div>

                            <button type="submit" class="btn btn-post mt-5">
                                Post Job Now <i class="fas fa-paper-plane ms-2"></i>
                            </button>
                        </form>

                        <div class="text-center mt-4">
                            <a href="<%=request.getContextPath()%>/AdminJobPortalServlet"
                                class="text-decoration-none text-muted fw-bold small">
                                <i class="fas fa-chevron-left me-1"></i> Cancel / Return to Jobs
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </body>

    </html>