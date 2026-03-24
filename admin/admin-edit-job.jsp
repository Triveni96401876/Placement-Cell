<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <% String[] job=(String[]) request.getAttribute("job"); if (job==null) {
        response.sendRedirect("AdminJobPortalServlet"); return; } %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Edit Job | SGP Admin</title>
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
                    padding: 50px 0;
                }

                .form-card {
                    background: #fff;
                    border-radius: 32px;
                    padding: 40px;
                    box-shadow: 0 20px 50px -12px rgba(0, 0, 0, 0.1);
                }

                .btn-update {
                    background: var(--primary);
                    color: white;
                    border-radius: 18px;
                    font-weight: 800;
                    padding: 15px;
                    width: 100%;
                    -border: none;
                }
            </style>
        </head>

        <body>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="form-card shadow-sm">
                            <h1 class="fw-bold mb-4 text-center">Edit Job Details</h1>
                            <form action="UpdateJobServlet" method="POST" enctype="multipart/form-data">
                                <input type="hidden" name="id" value="<%= job[0] %>">
                                <input type="hidden" name="oldLogo" value="<%= job[8] %>">

                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold small text-muted">COMPANY NAME</label>
                                        <input type="text" name="companyName" class="form-control" value="<%= job[1] %>"
                                            required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold small text-muted">LOGO (LEAVE EMPTY TO KEEP
                                            SAME)</label>
                                        <input type="file" name="companyLogo" class="form-control" accept="image/*">
                                    </div>
                                    <div class="col-md-12">
                                        <label class="form-label fw-bold small text-muted">JOB ROLE</label>
                                        <input type="text" name="jobRole" class="form-control" value="<%= job[2] %>"
                                            required>
                                    </div>
                                    <div class="col-md-12">
                                        <label class="form-label fw-bold small text-muted">DESCRIPTION</label>
                                        <textarea name="description" class="form-control" rows="5"
                                            required><%= job[3] %></textarea>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label fw-bold small text-muted">SALARY</label>
                                        <input type="text" name="salary" class="form-control" value="<%= job[4] %>"
                                            required>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label fw-bold small text-muted">LOCATION</label>
                                        <input type="text" name="location" class="form-control" value="<%= job[5] %>"
                                            required>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label fw-bold small text-muted">BRANCH</label>
                                        <select name="branch" class="form-select" required>
                                            <option value="All Branches" <%="All Branches"
                                                .equals(job[6])?"selected":""%>>All Branches</option>
                                            <option value="CSE" <%="CSE" .equals(job[6])?"selected":""%>>CSE</option>
                                            <option value="ME" <%="ME" .equals(job[6])?"selected":""%>>ME</option>
                                            <option value="EEE" <%="EEE" .equals(job[6])?"selected":""%>>EEE</option>
                                            <option value="Civil" <%="Civil" .equals(job[6])?"selected":""%>>Civil
                                            </option>
                                            <option value="MT" <%="MT" .equals(job[6])?"selected":""%>>MT</option>
                                        </select>
                                    </div>
                                    <div class="col-md-12">
                                        <label class="form-label fw-bold small text-muted">LAST DATE</label>
                                        <input type="date" name="lastDate" class="form-control" value="<%= job[7] %>"
                                            required>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-update mt-5">Update Job Details</button>
                            </form>
                            <div class="text-center mt-3">
                                <a href="AdminJobPortalServlet" class="text-decoration-none text-muted small fw-bold"><i
                                        class="fas fa-chevron-left me-1"></i> Cancel Edit</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>

        </html>