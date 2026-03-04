<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.placementcell.model.Student" %>
        <% Student student=(Student) request.getAttribute("studentData"); if (student==null) {
            response.sendRedirect("DashboardServlet?error=not_found"); return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Student Details | <%= student.getFullName() %>
                </title>
                <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <style>
                    :root {
                        --primary: #00a8ff;
                        --white: #ffffff;
                        --text-dark: #2d3436;
                        --text-muted: #636e72;
                        --bg: #f8faff;
                        --card-bg: #ffffff;
                        --accent: #6c5ce7;
                    }

                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                        font-family: 'Outfit', sans-serif;
                    }

                    body {
                        background-color: var(--bg);
                        color: var(--text-dark);
                        line-height: 1.6;
                    }

                    .container {
                        max-width: 1000px;
                        margin: 50px auto;
                        padding: 0 20px;
                    }

                    .back-link {
                        display: inline-flex;
                        align-items: center;
                        gap: 10px;
                        color: var(--primary);
                        text-decoration: none;
                        font-weight: 700;
                        margin-bottom: 25px;
                        transition: 0.3s;
                    }

                    .back-link:hover {
                        transform: translateX(-5px);
                    }

                    .profile-header {
                        background: var(--card-bg);
                        padding: 40px;
                        border-radius: 30px;
                        display: flex;
                        align-items: center;
                        gap: 30px;
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                        margin-bottom: 30px;
                    }

                    .avatar-large {
                        width: 120px;
                        height: 120px;
                        background: linear-gradient(135deg, var(--primary), var(--accent));
                        color: white;
                        border-radius: 30px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 3rem;
                        font-weight: 800;
                    }

                    .header-info h1 {
                        font-size: 2.2rem;
                        font-weight: 800;
                        margin-bottom: 5px;
                    }

                    .badge {
                        display: inline-block;
                        padding: 6px 15px;
                        border-radius: 50px;
                        font-size: 0.85rem;
                        font-weight: 700;
                        background: rgba(0, 168, 255, 0.1);
                        color: var(--primary);
                        margin-top: 10px;
                    }

                    .details-grid {
                        display: grid;
                        grid-template-columns: repeat(2, 1fr);
                        gap: 25px;
                    }

                    .details-section {
                        background: var(--card-bg);
                        padding: 35px;
                        border-radius: 30px;
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                    }

                    .section-title {
                        font-size: 1.25rem;
                        font-weight: 800;
                        margin-bottom: 25px;
                        display: flex;
                        align-items: center;
                        gap: 12px;
                        color: var(--text-dark);
                    }

                    .section-title i {
                        color: var(--primary);
                    }

                    .info-list {
                        list-style: none;
                    }

                    .info-item {
                        margin-bottom: 15px;
                        display: flex;
                        flex-direction: column;
                    }

                    .info-item label {
                        font-size: 0.8rem;
                        font-weight: 700;
                        text-transform: uppercase;
                        color: var(--text-muted);
                        letter-spacing: 0.5px;
                    }

                    .info-item span {
                        font-size: 1.1rem;
                        font-weight: 500;
                        color: var(--text-dark);
                    }

                    .full-width {
                        grid-column: span 2;
                    }

                    @media (max-width: 768px) {
                        .details-grid {
                            grid-template-columns: 1fr;
                        }

                        .full-width {
                            grid-column: span 1;
                        }

                        .profile-header {
                            flex-direction: column;
                            text-align: center;
                        }
                    }
                </style>
            </head>

            <body>
                <div class="container">
                    <a href="DashboardServlet" class="back-link">
                        <i class="fas fa-arrow-left"></i> Back to Dashboard
                    </a>

                    <div class="profile-header">
                        <div class="avatar-large">
                            <%= student.getFullName().substring(0, 1) %>
                        </div>
                        <div class="header-info">
                            <h1>
                                <%= student.getFullName() %>
                            </h1>
                            <p style="color: var(--text-muted); font-weight: 500;">
                                <%= student.getRegisterNumber() %> • <%= student.getBranch() %>
                            </p>
                            <span class="badge">Student Profile</span>
                        </div>
                    </div>

                    <div class="details-grid">
                        <div class="details-section">
                            <h3 class="section-title"><i class="fas fa-user"></i> Personal Details</h3>
                            <div class="info-list">
                                <div class="info-item">
                                    <label>Full Name</label>
                                    <span>
                                        <%= student.getFullName() %>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <label>Gender</label>
                                    <span>
                                        <%= student.getGender() %>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <label>Mobile</label>
                                    <span>
                                        <%= student.getMobileNumber() %>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <label>Address</label>
                                    <span>
                                        <%= student.getAddress() %>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="details-section">
                            <h3 class="section-title"><i class="fas fa-graduation-cap"></i> Academic Info</h3>
                            <div class="info-list">
                                <div class="info-item">
                                    <label>Current CGPA</label>
                                    <span style="font-weight: 700; color: var(--primary);">
                                        <%= student.getCgpa() %>
                                    </span>
                                </div>
                                <div class="info-item">
                                    <label>SSLC Percentage</label>
                                    <span>
                                        <%= student.getSslcPercentage() %>% (<%= student.getSslcYear() %>)
                                    </span>
                                </div>
                                <div class="info-item">
                                    <label>Diploma Percentage</label>
                                    <span>
                                        <%= student.getDiplomaPercentage() %>% (<%= student.getDiplomaYear() %>)
                                    </span>
                                </div>
                                <div class="info-item">
                                    <label>Backlog Status</label>
                                    <span>
                                        <%= student.getBacklogStatus() %> (<%= student.getBacklogCount() %>)
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="details-section full-width">
                            <h3 class="section-title"><i class="fas fa-file-alt"></i> Documents</h3>
                            <div
                                style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px;">
                                <!-- SSLC Document -->
                                <div
                                    style="padding: 20px; border: 1px solid #eee; border-radius: 20px; background: #fcfdfe; display: flex; flex-direction: column; align-items: center; gap: 10px;">
                                    <i class="fas fa-file-contract" style="font-size: 2rem; color: var(--primary);"></i>
                                    <span style="font-weight: 700;">SSLC Marks Card</span>
                                    <% if (student.getSslcCardPath() !=null && !student.getSslcCardPath().isEmpty()) {
                                        %>
                                        <button onclick="viewDocument('sslc', '<%= student.getId() %>')"
                                            style="width: 100%; border: none; background: var(--primary); color: white; padding: 10px; border-radius: 12px; font-weight: 700; cursor: pointer;">
                                            <i class="fas fa-eye"></i> View
                                        </button>
                                        <% } else { %>
                                            <span style="color: var(--text-muted); font-size: 0.9rem;">Not
                                                Uploaded</span>
                                            <% } %>
                                </div>

                                <!-- Diploma Document -->
                                <div
                                    style="padding: 20px; border: 1px solid #eee; border-radius: 20px; background: #fcfdfe; display: flex; flex-direction: column; align-items: center; gap: 10px;">
                                    <i class="fas fa-certificate" style="font-size: 2rem; color: #6c5ce7;"></i>
                                    <span style="font-weight: 700;">Diploma Marks Card</span>
                                    <% if (student.getDiplomaCardPath() !=null &&
                                        !student.getDiplomaCardPath().isEmpty()) { %>
                                        <button onclick="viewDocument('diploma', '<%= student.getId() %>')"
                                            style="width: 100%; border: none; background: #6c5ce7; color: white; padding: 10px; border-radius: 12px; font-weight: 700; cursor: pointer;">
                                            <i class="fas fa-eye"></i> View
                                        </button>
                                        <% } else { %>
                                            <span style="color: var(--text-muted); font-size: 0.9rem;">Not
                                                Uploaded</span>
                                            <% } %>
                                </div>

                                <!-- Resume Document -->
                                <div
                                    style="padding: 20px; border: 1px solid #eee; border-radius: 20px; background: #fcfdfe; display: flex; flex-direction: column; align-items: center; gap: 10px;">
                                    <i class="fas fa-file-pdf" style="font-size: 2rem; color: #e74c3c;"></i>
                                    <span style="font-weight: 700;">Resume / CV</span>
                                    <% if (student.getResumePath() !=null && !student.getResumePath().isEmpty()) { %>
                                        <button onclick="viewDocument('resume', '<%= student.getId() %>')"
                                            style="width: 100%; border: none; background: #e74c3c; color: white; padding: 10px; border-radius: 12px; font-weight: 700; cursor: pointer;">
                                            <i class="fas fa-eye"></i> View
                                        </button>
                                        <% } else { %>
                                            <span style="color: var(--text-muted); font-size: 0.9rem;">Not
                                                Uploaded</span>
                                            <% } %>
                                </div>
                            </div>
                        </div>

                        <div class="details-section full-width">
                            <h3 class="section-title"><i class="fas fa-code"></i> Technical Skills</h3>
                            <div style="display: flex; flex-wrap: wrap; gap: 10px;">
                                <% if(student.getSkills() !=null && !student.getSkills().isEmpty()) { for(String skill :
                                    student.getSkills().split(",")) { %>
                                    <span
                                        style="background: #f0f3f6; padding: 8px 15px; border-radius: 12px; font-weight: 600; font-size: 0.9rem;">
                                        <%= skill.trim() %>
                                    </span>
                                    <% } } else { %>
                                        <p style="color: var(--text-muted);">No skills added yet.</p>
                                        <% } %>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Viewer Modal -->
                <div id="viewerModal"
                    style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.8); z-index: 3000; align-items: center; justify-content: center; backdrop-filter: blur(5px);">
                    <div
                        style="background: white; width: 90%; height: 90%; border-radius: 20px; display: flex; flex-direction: column; overflow: hidden; position: relative; box-shadow: 0 25px 50px rgba(0,0,0,0.5);">
                        <div
                            style="padding: 20px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; background: #f8f9fa;">
                            <h3 id="viewerTitle" style="margin: 0; color: #2d3436; font-weight: 700;">Document Viewer
                            </h3>
                            <button onclick="closeViewer()"
                                style="border: none; background: #dfe6e9; width: 40px; height: 40px; border-radius: 50%; cursor: pointer; transition: 0.3s; display: flex; align-items: center; justify-content: center;">
                                <i class="fas fa-times" style="color: #636e72;"></i>
                            </button>
                        </div>
                        <div style="flex: 1; position: relative; background: #dfe6e9;">
                            <div id="viewerLoader"
                                style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); text-align: center;">
                                <i class="fas fa-spinner fa-spin"
                                    style="font-size: 3rem; color: #00a8ff; margin-bottom: 10px;"></i>
                                <p style="color: #636e72; font-weight: 500;">Loading Document...</p>
                            </div>
                            <iframe id="viewerFrame"
                                style="width: 100%; height: 100%; border: none; display: none;"></iframe>
                        </div>
                    </div>
                </div>

                <script>
                    function viewDocument(type, id) {
                        const modal = document.getElementById('viewerModal');
                        const frame = document.getElementById('viewerFrame');
                        const loader = document.getElementById('viewerLoader');
                        const title = document.getElementById('viewerTitle');

                        const titles = {
                            'sslc': 'SSLC Marks Card',
                            'diploma': 'Diploma Marks Card',
                            'resume': 'Resume / CV'
                        };

                        title.innerText = titles[type] || 'Document Viewer';
                        modal.style.display = 'flex';
                        loader.style.display = 'block';
                        frame.style.display = 'none';

                        frame.src = `DocumentViewerServlet?type=${type}&id=${id}`;

                        frame.onload = function () {
                            loader.style.display = 'none';
                            frame.style.display = 'block';
                        };
                    }

                    function closeViewer() {
                        const modal = document.getElementById('viewerModal');
                        const frame = document.getElementById('viewerFrame');
                        modal.style.display = 'none';
                        frame.src = 'about:blank';
                    }
                </script>
            </body>

            </html>