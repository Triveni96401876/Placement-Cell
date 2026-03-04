<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.placementcell.model.Student" %>
        <% String[] job=(String[]) request.getAttribute("job"); Student student=(Student)
            request.getAttribute("student"); if (job==null || student==null) {
            response.sendRedirect("DashboardServlet"); return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Application | <%= job[1] %> | SGP</title>
                <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <style>
                    :root {
                        --primary: #6366f1;
                        --secondary: #4f46e5;
                        --success: #10b981;
                        --bg: #f8fafc;
                        --surface: #ffffff;
                        --text: #1e293b;
                        --text-muted: #64748b;
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
                        display: flex;
                        justify-content: center;
                    }

                    .container {
                        width: 100%;
                        max-width: 1000px;
                        display: grid;
                        grid-template-columns: 1fr 1.5fr;
                        gap: 30px;
                        animation: fadeIn 0.8s ease;
                    }

                    @keyframes fadeIn {
                        from {
                            opacity: 0;
                            transform: translateY(20px);
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }

                    /* Left Side: Job Info */
                    .info-card {
                        background: linear-gradient(135deg, var(--primary), var(--secondary));
                        border-radius: 30px;
                        padding: 40px;
                        color: white;
                        box-shadow: 0 20px 40px rgba(99, 102, 241, 0.2);
                        height: fit-content;
                        position: sticky;
                        top: 40px;
                    }

                    .info-card h2 {
                        font-size: 2rem;
                        font-weight: 800;
                        margin-bottom: 20px;
                        line-height: 1.2;
                    }

                    .info-card .company {
                        font-size: 1.2rem;
                        font-weight: 600;
                        opacity: 0.9;
                        margin-bottom: 30px;
                        display: block;
                    }

                    .feature-list {
                        list-style: none;
                        margin-bottom: 40px;
                    }

                    .feature-list li {
                        margin-bottom: 15px;
                        display: flex;
                        align-items: flex-start;
                        gap: 12px;
                        font-size: 0.95rem;
                        line-height: 1.5;
                    }

                    .feature-list i {
                        margin-top: 4px;
                        font-size: 1.1rem;
                    }

                    .btn-cancel {
                        display: inline-block;
                        padding: 12px 25px;
                        background: rgba(255, 255, 255, 0.1);
                        color: white;
                        text-decoration: none;
                        border-radius: 12px;
                        font-weight: 600;
                        backdrop-filter: blur(5px);
                        transition: 0.3s;
                    }

                    .btn-cancel:hover {
                        background: rgba(255, 255, 255, 0.2);
                    }

                    /* Right Side: Form */
                    .form-card {
                        background: white;
                        border-radius: 30px;
                        padding: 50px;
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.03);
                        border: 1px solid #e2e8f0;
                    }

                    .form-card h3 {
                        font-size: 1.5rem;
                        font-weight: 800;
                        margin-bottom: 30px;
                        display: flex;
                        align-items: center;
                        gap: 12px;
                    }

                    .form-card h3 i {
                        color: var(--primary);
                    }

                    .form-section {
                        margin-bottom: 35px;
                    }

                    .section-title {
                        font-size: 0.85rem;
                        font-weight: 700;
                        color: var(--text-muted);
                        text-transform: uppercase;
                        letter-spacing: 1px;
                        margin-bottom: 20px;
                        border-bottom: 1px solid #f1f5f9;
                        padding-bottom: 10px;
                    }

                    .grid-inputs {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 20px;
                    }

                    .input-full {
                        grid-column: span 2;
                    }

                    .form-group {
                        position: relative;
                    }

                    .form-group label {
                        display: block;
                        font-size: 0.9rem;
                        font-weight: 700;
                        color: #475569;
                        margin-bottom: 8px;
                        margin-left: 5px;
                    }

                    .form-group input,
                    .form-group select,
                    .form-group textarea {
                        width: 100%;
                        padding: 14px 18px;
                        background: #f8fafc;
                        border: 2px solid transparent;
                        border-radius: 14px;
                        font-size: 1rem;
                        color: var(--text);
                        transition: all 0.3s;
                        outline: none;
                    }

                    .form-group input:focus {
                        border-color: var(--primary);
                        background: white;
                        box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.05);
                    }

                    .form-group input:read-only {
                        background: #f1f5f9;
                        cursor: not-allowed;
                        opacity: 0.8;
                    }

                    .submit-btn {
                        width: 100%;
                        padding: 18px;
                        background: linear-gradient(to right, var(--primary), var(--secondary));
                        color: white;
                        border: none;
                        border-radius: 16px;
                        font-size: 1.1rem;
                        font-weight: 800;
                        cursor: pointer;
                        transition: 0.4s;
                        box-shadow: 0 10px 20px rgba(99, 102, 241, 0.3);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        gap: 12px;
                    }

                    .submit-btn:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 15px 30px rgba(99, 102, 241, 0.4);
                    }

                    @media (max-width: 900px) {
                        .container {
                            grid-template-columns: 1fr;
                        }

                        .info-card {
                            position: relative;
                            top: 0;
                        }

                        .form-card {
                            padding: 30px;
                        }
                    }
                </style>
            </head>

            <body>
                <div class="container">
                    <!-- Job Snapshot -->
                    <div class="info-card">
                        <span class="company">HIRING PARTNER UPDATE</span>
                        <h2>
                            <%= job[1] %>
                        </h2>

                        <ul class="feature-list">
                            <li><i class="fas fa-check-circle"></i> Complete your application using the form.</li>
                            <li><i class="fas fa-check-circle"></i> Your academic data (CGPA, Sem Results) will be
                                pre-filled system-wide.</li>
                            <li><i class="fas fa-check-circle"></i> Please ensure your resume link is updated in your
                                profile.</li>
                        </ul>

                        <div style="margin-top: auto;">
                            <a href="dashboardServlet" class="btn-cancel"><i class="fas fa-times"></i> Cancel
                                Application</a>
                        </div>
                    </div>

                    <!-- Registration Form -->
                    <div class="form-card">
                        <h3><i class="fas fa-file-signature"></i> Finalize Application</h3>

                        <form action="ApplyJobServlet" method="POST">
                            <input type="hidden" name="jobId" value="<%= job[0] %>">
                            <input type="hidden" name="studentId" value="<%= student.getId() %>">

                            <!-- Profile Confirmation -->
                            <div class="form-section">
                                <div class="section-title">Identity Confirmation</div>
                                <div class="grid-inputs">
                                    <div class="form-group">
                                        <label>Full Name</label>
                                        <input type="text" name="name" value="<%= student.getFullName() %>" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label>Register Number</label>
                                        <input type="text" name="regNo" value="<%= student.getRegisterNumber() %>"
                                            readonly>
                                    </div>
                                    <div class="form-group">
                                        <label>Email Address</label>
                                        <input type="email" name="email" value="<%= student.getEmail() %>" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label>Primary Phone</label>
                                        <input type="text" name="phone" value="<%= student.getMobileNumber() %>"
                                            required>
                                    </div>
                                </div>
                            </div>

                            <!-- Academic Verification -->
                            <div class="form-section">
                                <div class="section-title">Academic Data Sync</div>
                                <div class="grid-inputs">
                                    <div class="form-group">
                                        <label>Branch</label>
                                        <input type="text" name="branch" value="<%= student.getBranch() %>" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label>Current Semester</label>
                                        <input type="text" name="semester"
                                            value="<%= student.getSemester() != null ? student.getSemester() : " N/A"
                                            %>" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label>Aggregate CGPA</label>
                                        <input type="text" name="cgpa" value="<%= student.getCgpa() %>" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label>Active Backlogs</label>
                                        <input type="text" name="backlogs" value="<%= student.getBacklogs() %>"
                                            readonly>
                                    </div>
                                </div>
                            </div>

                            <!-- Skills & Links -->
                            <div class="form-section">
                                <div class="section-title">Professional Profile</div>
                                <div class="form-group input-full" style="margin-bottom: 20px;">
                                    <label>Technical Skills (Comma separated)</label>
                                    <input type="text" name="skills"
                                        value="<%= student.getSkills() != null ? student.getSkills() : "" %>"
                                        placeholder="e.g. Java, Python, SQL, Web Dev" required>
                                </div>
                                <div class="form-group input-full">
                                    <label>Resume / Portfolio Link (PDF Cloud Link)</label>
                                    <input type="url" name="resume"
                                        value="<%= student.getResumePath() != null ? student.getResumePath() : "" %>"
                                        placeholder="Drop your Google Drive/Dropbox PDF Link here" required>
                                </div>
                            </div>

                            <button type="submit" class="submit-btn" id="submitBtn">
                                Submit Application <i class="fas fa-paper-plane"></i>
                            </button>
                        </form>
                    </div>
                </div>

                <script>
                    document.querySelector('form').addEventListener('submit', function (e) {
                        const btn = document.getElementById('submitBtn');
                        btn.innerHTML = '<i class="fas fa-circle-notch fa-spin"></i> Processing...';
                        btn.style.opacity = '0.7';
                        btn.style.pointerEvents = 'none';
                    });
                </script>
            </body>

            </html>