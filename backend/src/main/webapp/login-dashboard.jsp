<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.placementcell.model.Student" %>
        <%@ page import="com.placementcell.model.User" %>
            <% Student student=(Student) request.getAttribute("studentData"); User user=(User)
                session.getAttribute("user"); if (student==null || user==null) { response.sendRedirect("login.html");
                return; } %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Login Dashboard | SGP Ballari</title>
                    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
                        rel="stylesheet">
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <link rel="stylesheet" href="css/login-dashboard.css">
                </head>

                <body>

                    <!-- Sleek Glass Sidebar -->
                    <aside class="glass-sidebar">
                        <div class="logo-area">
                            <i class="fas fa-university fa-2x"></i>
                            <span style="font-weight: 700; font-size: 1.2rem;">SGP PORTAL</span>
                        </div>

                        <nav>
                            <a href="DashboardServlet" class="nav-item active"><i class="fas fa-th-large"></i>
                                Dashboard</a>
                            <a href="profile.jsp" class="nav-item"><i class="fas fa-user-circle"></i> Profile</a>
                            <a href="ResumeServlet" class="nav-item"><i class="fas fa-file-alt"></i> Resume Viewer</a>
                            <a href="javascript:void(0)" onclick="promptLockerPassword()" class="nav-item"><i
                                    class="fas fa-shield-alt"></i> Digi Locker</a>
                            <a href="#" class="nav-item"><i class="fas fa-briefcase"></i> Job Portal</a>
                        </nav>

                        <div style="position: absolute; bottom: 2rem; width: calc(100% - 4rem);">
                            <a href="LogoutServlet" class="nav-item"
                                style="background: rgba(230, 57, 70, 0.1); color: var(--accent);">
                                <i class="fas fa-power-off"></i> Logout
                            </a>
                        </div>
                    </aside>

                    <!-- Content Area -->
                    <main class="dashboard-container">

                        <header class="top-bar"
                            style="display: flex; justify-content: flex-end; border-bottom: 2px solid #eee; padding-bottom: 1rem; margin-bottom: 2rem;">
                            <h1 style="margin:0; font-weight: 700; color: var(--primary); font-size: 1.1rem;">Welcome,
                                <%= student.getWelcomeName() %>
                            </h1>
                        </header>

                        <div class="cockpit-grid">

                            <div class="main-cockpit">
                                <!-- Profile Identity Card -->
                                <div class="feature-card"
                                    style="grid-column: span 2; background: linear-gradient(135deg, #003366 0%, #0056b3 100%); color: white;">
                                    <div
                                        style="display: flex; justify-content: space-between; align-items: flex-start;">
                                        <div>
                                            <div
                                                style="display: flex; align-items: center; gap: 15px; margin-bottom: 10px;">
                                                <h2 style="margin:0; font-size: 2rem;">
                                                    <%= student.getFullName() %>
                                                </h2>
                                                <a href="profile.jsp"
                                                    style="color: white; background: rgba(255,255,255,0.2); width: 32px; height: 32px; border-radius: 50%; display: flex; align-items: center; justify-content: center; text-decoration: none; font-size: 0.8rem; transition: 0.3s;"
                                                    title="Edit Profile">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                            </div>
                                            <p style="opacity: 0.8;">
                                                <%= student.getRegisterNumber() %> | <%= student.getBranch() %>
                                            </p>
                                            <div style="margin-top: 1.5rem; display: flex; gap: 10px;">
                                                <span
                                                    style="background: rgba(255,255,255,0.2); padding: 5px 15px; border-radius: 5px; font-size: 0.8rem;">
                                                    <i class="fas fa-star"></i> Diploma Year: 2024
                                                </span>
                                                <span onclick="promptLockerPassword()"
                                                    style="background: #2ecc71; color: white; padding: 5px 15px; border-radius: 5px; font-size: 0.8rem; cursor: pointer;">
                                                    <i class="fas fa-shield-alt"></i> Secured Locker
                                                </span>
                                            </div>
                                        </div>
                                        <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="profile"
                                            style="width: 100px; filter: brightness(0) invert(1);">
                                    </div>
                                </div>

                                <!-- Session Stats -->
                                <div class="feature-card">
                                    <i class="fas fa-shield-alt bg-icon"></i>
                                    <h3>Session Info</h3>
                                    <p style="font-size: 0.8rem; color: #666; margin-bottom: 15px;">Securely logged in
                                        from
                                        Ballari Campus Network.</p>
                                    <div style="font-size: 0.85rem;">
                                        <p><i class="fas fa-network-wired" style="color: var(--secondary);"></i>
                                            <strong>IP:</strong>
                                            <%= session.getAttribute("loginIp") %>
                                        </p>
                                        <p><i class="fas fa-clock" style="color: var(--secondary);"></i>
                                            <strong>Time:</strong>
                                            <%= session.getAttribute("loginTime") %>
                                        </p>
                                    </div>
                                </div>

                                <!-- Academic Quick View -->
                                <div class="feature-card">
                                    <i class="fas fa-chart-line bg-icon"></i>
                                    <h3>Academic Performance</h3>
                                    <div style="text-align: center; margin-top: 10px;">
                                        <h1 style="font-size: 3rem; margin:0; color: var(--primary);">
                                            <%= student.getCgpa() %>
                                        </h1>
                                        <p style="font-size: 0.8rem; color: #666;">Current CGPA</p>
                                    </div>
                                    <div style="height: 10px; background: #eee; border-radius: 5px; margin-top: 15px;">
                                        <div
                                            style="width: <%= (student.getCgpa()/10)*100 %>%; height: 100%; background: var(--success); border-radius: 5px;">
                                        </div>
                                    </div>
                                </div>

                                <!-- Resume & Skills -->
                                <div class="feature-card" style="grid-column: span 2;">
                                    <i class="fas fa-laptop-code bg-icon"></i>
                                    <div style="display: flex; justify-content: space-between; align-items: center;">
                                        <div>
                                            <h3>Professional Resume</h3>
                                            <p style="color: #666; font-size: 0.9rem;">Your personalized placement
                                                resume is
                                                ready. Keep it updated for better sorting.</p>
                                        </div>
                                        <div style="display: flex; gap: 10px;">
                                            <a href="javascript:void(0)" onclick="openResumeUpdateModal()"
                                                class="nav-item"
                                                style="background: #f1f2f6; color: var(--primary); padding: 10px 20px; text-decoration: none; border-radius: 10px; font-weight: 600; font-size: 0.9rem;">
                                                <i class="fas fa-sync-alt"></i> Update Resume
                                            </a>
                                            <a href="ResumeServlet" target="_blank" class="nav-item active"
                                                style="padding: 10px 20px; text-decoration: none; border-radius: 10px; font-weight: 600; font-size: 0.9rem;">
                                                <i class="fas fa-file-pdf"></i> View Resume
                                            </a>
                                        </div>
                                    </div>
                                    <hr style="border: 0; border-top: 1px solid #eee; margin: 1.5rem 0;">
                                    <div style="display: flex; gap: 10px; flex-wrap: wrap;">
                                        <span
                                            style="background: #e1f5fe; color: #01579b; padding: 5px 15px; border-radius: 50px; font-size: 0.8rem;">Java</span>
                                        <span
                                            style="background: #f3e5f5; color: #7b1fa2; padding: 5px 15px; border-radius: 50px; font-size: 0.8rem;">SQL</span>
                                        <span
                                            style="background: #e8f5e9; color: #2e7d32; padding: 5px 15px; border-radius: 50px; font-size: 0.8rem;">Web
                                            Dev</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Activity Panel -->
                            <div class="activity-panel">
                                <h3>Campus Bulletin</h3>
                                <div class="timeline">
                                    <div class="timeline-item">
                                        <strong style="display: block;">JSW Steel Drive</strong>
                                        <small>Registration closes tomorrow</small>
                                    </div>
                                    <div class="timeline-item">
                                        <strong style="display: block;">Soft Skill Workshop</strong>
                                        <small>Feb 10th | Seminar Hall</small>
                                    </div>
                                    <div class="timeline-item">
                                        <strong style="display: block;">Profile Verification</strong>
                                        <small>Visit TPO office for signature</small>
                                    </div>
                                </div>

                                <div
                                    style="margin-top: 3rem; background: rgba(255,255,255,0.1); padding: 1.5rem; border-radius: 15px; text-align: center;">
                                    <i class="fas fa-lightbulb fa-2x" style="color: #ffd700; margin-bottom: 15px;"></i>
                                    <p style="font-size: 0.8rem;">Did you know? Completing your profile increases
                                        shortlist
                                        chances by 40%.</p>
                                </div>
                            </div>

                        </div>
                    </main>

                    <!-- Digi Locker Auth Modal -->
                    <div id="lockerAuthModal" class="modal"
                        style="display:none; position:fixed; z-index:2000; left:0; top:0; width:100%; height:100%; background:rgba(0,0,0,0.5); backdrop-filter:blur(5px);">
                        <div class="modal-content"
                            style="background:white; margin:10% auto; padding:2rem; border-radius:20px; width:90%; max-width:400px; text-align:center;">
                            <h2 style="color:var(--primary);">Security Check</h2>
                            <i class="fas fa-lock fa-3x" style="color:var(--primary); margin:1rem 0;"></i>
                            <p>Verify your password to access Digi Locker</p>
                            <input type="password" id="lockerPass" class="form-control"
                                style="width:100%; margin:1rem 0; padding:10px; border:1px solid #ddd; border-radius:8px;"
                                placeholder="Password">
                            <div style="display:flex; gap:10px; justify-content:center;">
                                <button onclick="closeLockerAuth()"
                                    style="padding:10px 20px; border-radius:8px; border:none; background:#eee;">Cancel</button>
                                <button onclick="verifyLockerAccess()"
                                    style="padding:10px 20px; border-radius:8px; border:none; background:var(--primary); color:white;">Unlock</button>
                            </div>
                        </div>
                    </div>

                    <!-- Digi Locker Content Modal -->
                    <div id="lockerContentModal" class="modal"
                        style="display:none; position:fixed; z-index:2000; left:0; top:0; width:100%; height:100%; background:rgba(0,0,0,0.5); backdrop-filter:blur(5px);">
                        <div class="modal-content"
                            style="background:white; margin:5% auto; padding:2rem; border-radius:20px; width:90%; max-width:800px;">
                            <div
                                style="display:flex; justify-content:space-between; align-items:center; margin-bottom:2rem;">
                                <h2 style="color:var(--primary); margin:0;"><i class="fas fa-shield-alt"></i> Digi
                                    Locker
                                </h2>
                                <span onclick="closeLockerContent()"
                                    style="cursor:pointer; font-size:1.5rem;">&times;</span>
                            </div>
                            <div
                                style="display:grid; grid-template-columns:repeat(auto-fit, minmax(200px, 1fr)); gap:20px;">
                                <div style="background:#f8f9fa; padding:20px; border-radius:15px; text-align:center;">
                                    <i class="fas fa-file-pdf fa-3x" style="color:#e63946; margin-bottom:10px;"></i>
                                    <h4>SSLC Marks Card</h4>
                                    <% if (student.getSslcCardPath() !=null) { %>
                                        <a href="<%= request.getContextPath() %>/ViewDocument?file=<%= student.getSslcCardPath() %>"
                                            target="_blank" style="color:var(--primary); font-weight:600;">View
                                            Document</a>
                                        <% } else { %>
                                            <p style="color:#7f8fa6; font-size:0.8rem;">Not Uploaded</p>
                                            <% } %>
                                </div>
                                <div style="background:#f8f9fa; padding:20px; border-radius:15px; text-align:center;">
                                    <i class="fas fa-file-pdf fa-3x" style="color:#2ecc71; margin-bottom:10px;"></i>
                                    <h4>Diploma Marksheet</h4>
                                    <% if (student.getDiplomaCardPath() !=null) { %>
                                        <a href="<%= request.getContextPath() %>/ViewDocument?file=<%= student.getDiplomaCardPath() %>"
                                            target="_blank" style="color:var(--primary); font-weight:600;">View
                                            Document</a>
                                        <% } else { %>
                                            <p style="color:#7f8fa6; font-size:0.8rem;">Not Uploaded</p>
                                            <% } %>
                                </div>
                                <div style="background:#f8f9fa; padding:20px; border-radius:15px; text-align:center;">
                                    <i class="fas fa-id-card fa-3x"
                                        style="color:var(--secondary); margin-bottom:10px;"></i>
                                    <h4>Current Resume</h4>
                                    <% if (student.getResumePath() !=null) { %>
                                        <a href="<%= request.getContextPath() %>/ViewDocument?file=<%= student.getResumePath() %>"
                                            target="_blank" style="color:var(--primary); font-weight:600;">View Recently
                                            Updated</a>
                                        <% if (student.getResumeDescription() !=null) { %>
                                            <p style="font-size: 0.75rem; color: #666; margin-top:5px;">"<%=
                                                    student.getResumeDescription() %>"</p>
                                            <% } %>
                                                <% } else { %>
                                                    <a href="<%= request.getContextPath() %>/ResumeServlet"
                                                        target="_blank"
                                                        style="color:var(--primary); font-weight:600;">View Auto-Gen
                                                        Resume</a>
                                                    <% } %>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Resume Update Multi-Step Modal -->
                    <div id="resumeUpdateModal" class="modal"
                        style="display:none; position:fixed; z-index:2000; left:0; top:0; width:100%; height:100%; background:rgba(0,0,0,0.5); backdrop-filter:blur(5px);">
                        <div class="modal-content"
                            style="background:white; margin:10% auto; padding:2rem; border-radius:20px; width:90%; max-width:500px;">
                            <form id="resumeUpdateForm" action="UpdateResumeServlet" method="POST"
                                enctype="multipart/form-data">
                                <!-- Step 1 -->
                                <div id="resStep1">
                                    <h2 style="color:var(--primary);">Generate & Update Resume</h2>
                                    <p>Step 1: Upload your custom resume file (PDF)</p>
                                    <input type="file" name="resumeFile" id="newResumeFile" accept=".pdf"
                                        style="width:100%; margin:1rem 0; padding:20px; border:2px dashed var(--primary); border-radius:10px;">

                                    <p style="margin-top:1rem;">Step 2: Describe your update / Career Objective</p>
                                    <p style="font-size: 0.7rem; color: #666; margin-bottom: 5px;">This text will also
                                        update your system-generated resume's objective.</p>
                                    <textarea name="resumeDescription"
                                        placeholder="e.g. Seeking a role in Java Development... or Updated marks for Sem 5."
                                        style="width:100%; padding:10px; border-radius:8px; border:1px solid #ddd; resize:none;"
                                        rows="3"></textarea>

                                    <div style="text-align:right; margin-top:1.5rem;">
                                        <button type="button" onclick="nextResumeStep()"
                                            style="padding:12px 30px; border-radius:10px; border:none; background:var(--primary); color:white; font-weight:600;">Next
                                            <i class="fas fa-arrow-right"></i></button>
                                    </div>
                                </div>
                                <!-- Step 2 -->
                                <div id="resStep2" style="display:none; text-align:center;">
                                    <h2 style="color:var(--primary);">Confirm Update</h2>
                                    <i class="fas fa-check-circle fa-4x" style="color:#2ecc71; margin:1.5rem 0;"></i>
                                    <p>This will update your <b>Custom Resume</b> and refresh your <b>Professional
                                            Objective</b> in the system-generated profile.</p>
                                    <div style="margin-top:2rem; display:flex; gap:10px; justify-content:center;">
                                        <button type="button" onclick="prevResumeStep()"
                                            style="padding:10px 25px; border-radius:8px; border:none; background:#eee;">Back</button>
                                        <button type="submit" onclick="finalizeResumeUpdate()"
                                            style="padding:10px 25px; border-radius:8px; border:none; background:#2ecc71; color:white; font-weight:600;">Generate
                                            & Save</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div id="toast"
                        style="display:none; position:fixed; bottom:30px; right:30px; padding:15px 25px; border-radius:10px; color:white; font-weight:600; z-index:3000;">
                    </div>

                    <script>
                        // Digi Locker Functions
                        function promptLockerPassword() {
                            document.getElementById('lockerAuthModal').style.display = 'block';
                        }
                        function closeLockerAuth() {
                            document.getElementById('lockerAuthModal').style.display = 'none';
                            document.getElementById('lockerPass').value = '';
                        }
                        function verifyLockerAccess() {
                            const pass = document.getElementById('lockerPass').value;
                            const realPass = '<%= user.getPassword() %>';
                            if (pass === realPass) {
                                closeLockerAuth();
                                document.getElementById('lockerContentModal').style.display = 'block';
                            } else {
                                showToast('Invalid Password! Use your account password.', '#e74c3c');
                            }
                        }
                        function closeLockerContent() {
                            document.getElementById('lockerContentModal').style.display = 'none';
                        }

                        // Resume Update Functions
                        function openResumeUpdateModal() {
                            document.getElementById('resumeUpdateModal').style.display = 'block';
                            document.getElementById('resStep1').style.display = 'block';
                            document.getElementById('resStep2').style.display = 'none';
                        }
                        function closeResumeUpdate() {
                            document.getElementById('resumeUpdateModal').style.display = 'none';
                        }
                        function nextResumeStep() {
                            if (document.getElementById('newResumeFile').files.length === 0) {
                                showToast('Please select a file first!', '#e67e22');
                                return;
                            }
                            document.getElementById('resStep1').style.display = 'none';
                            document.getElementById('resStep2').style.display = 'block';
                        }
                        function prevResumeStep() {
                            document.getElementById('resStep1').style.display = 'block';
                            document.getElementById('resStep2').style.display = 'none';
                        }
                        function finalizeResumeUpdate() {
                            // The form will submit normally. 
                            // We show a temporary toast but the page will reload.
                            showToast('Committing to Database...', '#3498db');
                        }

                        // Handle status messages from URL
                        window.onload = function () {
                            const urlParams = new URLSearchParams(window.location.search);
                            if (urlParams.get('status') === 'resume_updated') {
                                showToast('Resume Updated Successfully!', '#2ecc71');
                            } else if (urlParams.get('error')) {
                                showToast('Error: ' + urlParams.get('error'), '#e74c3c');
                            }
                        };

                        function showToast(msg, color) {
                            const t = document.getElementById('toast');
                            t.innerText = msg;
                            t.style.background = color;
                            t.style.display = 'block';
                            setTimeout(() => t.style.display = 'none', 3000);
                        }
                    </script>
                </body>

                </html>