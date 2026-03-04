<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.placementcell.model.Student" %>
        <%@ page import="com.placementcell.model.User" %>
            <% Student student=(Student) request.getAttribute("studentData"); User user=(User)
                session.getAttribute("user"); if (student==null || user==null) { response.sendRedirect("login.html");
                return; } String fullName=student.getFullName() !=null ? student.getFullName() : "Student" ; String
                regNo=student.getRegisterNumber() !=null ? student.getRegisterNumber() : "N/A" ; %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Doc Locker | SGP Placement Cell</title>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
                        rel="stylesheet">
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <style>
                        :root {
                            --primary: #00a8ff;
                            --primary-dark: #0097e6;
                            --success: #4CAF50;
                            --danger: #f44336;
                            --white: #ffffff;
                            --text-dark: #2c3e50;
                            --text-light: #95a5a6;
                            --card-bg: #ffffff;
                            --main-bg: #eceef1;
                            --shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                        }

                        * {
                            margin: 0;
                            padding: 0;
                            box-sizing: border-box;
                            font-family: 'Outfit', sans-serif;
                        }

                        body {
                            background: var(--main-bg);
                            min-height: 100vh;
                            padding: 40px 20px;
                        }

                        .container {
                            max-width: 1200px;
                            margin: 0 auto;
                            filter: blur(8px);
                            transition: filter 0.5s ease;
                        }

                        .container.unlocked {
                            filter: blur(0);
                        }

                        /* Security Overlay */
                        .security-overlay {
                            position: fixed;
                            top: 0;
                            left: 0;
                            width: 100%;
                            height: 100%;
                            background: rgba(0, 0, 0, 0.8);
                            backdrop-filter: blur(15px);
                            z-index: 2000;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            transition: opacity 0.5s ease;
                        }

                        .security-card {
                            background: white;
                            padding: 50px;
                            border-radius: 30px;
                            text-align: center;
                            max-width: 450px;
                            width: 90%;
                            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                        }

                        .security-icon {
                            font-size: 4rem;
                            color: var(--primary);
                            margin-bottom: 25px;
                            animation: pulse 2s infinite;
                        }

                        @keyframes pulse {
                            0% {
                                transform: scale(1);
                            }

                            50% {
                                transform: scale(1.1);
                            }

                            100% {
                                transform: scale(1);
                            }
                        }

                        .security-card h2 {
                            font-size: 2rem;
                            color: var(--text-dark);
                            margin-bottom: 10px;
                        }

                        .security-card p {
                            color: var(--text-light);
                            margin-bottom: 30px;
                        }

                        .pin-input {
                            width: 100%;
                            padding: 20px;
                            font-size: 2rem;
                            text-align: center;
                            letter-spacing: 15px;
                            border: 3px solid #eee;
                            border-radius: 15px;
                            margin-bottom: 25px;
                            outline: none;
                            transition: var(--transition);
                            color: var(--text-dark);
                        }

                        .pin-input:focus {
                            border-color: var(--primary);
                            box-shadow: 0 0 15px rgba(0, 168, 255, 0.2);
                        }

                        .btn-unlock {
                            width: 100%;
                            padding: 18px;
                            background: var(--primary);
                            color: white;
                            border: none;
                            border-radius: 15px;
                            font-size: 1.1rem;
                            font-weight: 700;
                            cursor: pointer;
                            transition: var(--transition);
                        }

                        .btn-unlock:hover {
                            background: var(--primary-dark);
                            transform: translateY(-3px);
                        }

                        /* Existing Styles */
                        .header {
                            background: white;
                            border-radius: 24px;
                            padding: 30px 40px;
                            margin-bottom: 30px;
                            box-shadow: var(--shadow);
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                        }

                        .header-left {
                            display: flex;
                            align-items: center;
                            gap: 20px;
                        }

                        .header-icon {
                            width: 60px;
                            height: 60px;
                            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
                            border-radius: 16px;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            color: white;
                            font-size: 1.8rem;
                        }

                        .header-title h1 {
                            font-size: 1.8rem;
                            color: var(--text-dark);
                            font-weight: 700;
                            margin-bottom: 5px;
                        }

                        .header-title p {
                            color: var(--text-light);
                            font-size: 0.95rem;
                        }

                        .btn-back {
                            background: var(--primary);
                            color: white;
                            padding: 12px 30px;
                            border-radius: 50px;
                            text-decoration: none;
                            font-weight: 600;
                            font-size: 0.95rem;
                            display: flex;
                            align-items: center;
                            gap: 10px;
                            transition: var(--transition);
                            box-shadow: 0 4px 10px rgba(0, 168, 255, 0.2);
                        }

                        .btn-back:hover {
                            background: var(--primary-dark);
                            transform: translateY(-2px);
                            box-shadow: 0 6px 15px rgba(0, 168, 255, 0.3);
                        }

                        .documents-grid {
                            display: grid;
                            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
                            gap: 25px;
                            margin-bottom: 30px;
                        }

                        .document-card {
                            background: white;
                            border-radius: 20px;
                            padding: 30px;
                            box-shadow: var(--shadow);
                            transition: var(--transition);
                            border-left: 5px solid var(--primary);
                        }

                        .document-card:hover {
                            transform: translateY(-5px);
                            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
                        }

                        .document-header {
                            display: flex;
                            align-items: center;
                            gap: 15px;
                            margin-bottom: 20px;
                        }

                        .document-icon {
                            width: 50px;
                            height: 50px;
                            background: linear-gradient(135deg, #667eea, #764ba2);
                            border-radius: 12px;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            color: white;
                            font-size: 1.5rem;
                        }

                        .document-card.marks-card .document-icon {
                            background: linear-gradient(135deg, #f093fb, #f5576c);
                        }

                        .document-card.diploma-card .document-icon {
                            background: linear-gradient(135deg, #4facfe, #00f2fe);
                        }

                        .document-card.resume-card .document-icon {
                            background: linear-gradient(135deg, #84fab0, #8fd3f4);
                        }

                        .document-title {
                            flex: 1;
                        }

                        .document-title h3 {
                            font-size: 1.2rem;
                            color: var(--text-dark);
                            font-weight: 700;
                            margin-bottom: 5px;
                        }

                        .document-title p {
                            font-size: 0.85rem;
                            color: var(--text-light);
                        }

                        .document-info {
                            margin-bottom: 20px;
                        }

                        .info-row {
                            display: flex;
                            justify-content: space-between;
                            padding: 10px 0;
                            border-bottom: 1px solid #f0f0f0;
                        }

                        .info-row:last-child {
                            border-bottom: none;
                        }

                        .info-label {
                            font-weight: 600;
                            color: var(--text-dark);
                            font-size: 0.9rem;
                        }

                        .info-value {
                            color: var(--text-light);
                            font-size: 0.9rem;
                        }

                        .document-actions {
                            display: flex;
                            gap: 10px;
                        }

                        .btn-action {
                            flex: 1;
                            padding: 12px 20px;
                            border: none;
                            border-radius: 12px;
                            font-weight: 600;
                            font-size: 0.9rem;
                            cursor: pointer;
                            transition: var(--transition);
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            gap: 8px;
                            text-decoration: none;
                        }

                        .btn-view {
                            background: var(--primary);
                            color: white;
                        }

                        .btn-view:hover {
                            background: var(--primary-dark);
                            transform: translateY(-2px);
                        }

                        .btn-upload {
                            background: #f8f9fa;
                            color: var(--text-dark);
                            border: 2px solid #e0e0e0;
                        }

                        .btn-upload:hover {
                            background: var(--success);
                            color: white;
                            border-color: var(--success);
                        }

                        .btn-disabled {
                            background: #f0f0f0;
                            color: #ccc;
                            cursor: not-allowed;
                        }

                        .status-badge {
                            display: inline-block;
                            padding: 5px 15px;
                            border-radius: 20px;
                            font-size: 0.8rem;
                            font-weight: 600;
                        }

                        .status-uploaded {
                            background: #e8f5e9;
                            color: var(--success);
                        }

                        .status-pending {
                            background: #fff3e0;
                            color: #ff9800;
                        }

                        .upload-modal {
                            display: none;
                            position: fixed;
                            top: 0;
                            left: 0;
                            width: 100%;
                            height: 100%;
                            background: rgba(0, 0, 0, 0.5);
                            z-index: 1000;
                            align-items: center;
                            justify-content: center;
                        }

                        .upload-modal.active {
                            display: flex;
                        }

                        .modal-content {
                            background: white;
                            border-radius: 24px;
                            padding: 40px;
                            max-width: 500px;
                            width: 90%;
                            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
                        }

                        .modal-header {
                            margin-bottom: 25px;
                        }

                        .modal-header h2 {
                            font-size: 1.5rem;
                            color: var(--text-dark);
                            font-weight: 700;
                            margin-bottom: 10px;
                        }

                        .modal-header p {
                            color: var(--text-light);
                            font-size: 0.9rem;
                        }

                        .form-group {
                            margin-bottom: 20px;
                        }

                        .form-group label {
                            display: block;
                            font-weight: 600;
                            color: var(--text-dark);
                            margin-bottom: 10px;
                            font-size: 0.95rem;
                        }

                        .file-input-wrapper {
                            position: relative;
                            border: 2px dashed #e0e0e0;
                            border-radius: 12px;
                            padding: 30px;
                            text-align: center;
                            cursor: pointer;
                            transition: var(--transition);
                        }

                        .file-input-wrapper:hover {
                            border-color: var(--primary);
                            background: #f8f9fa;
                        }

                        .file-input-wrapper input[type="file"] {
                            position: absolute;
                            opacity: 0;
                            width: 100%;
                            height: 100%;
                            top: 0;
                            left: 0;
                            cursor: pointer;
                        }

                        .file-input-icon {
                            font-size: 2.5rem;
                            color: var(--primary);
                            margin-bottom: 10px;
                        }

                        .file-input-text {
                            color: var(--text-light);
                            font-size: 0.9rem;
                        }

                        .modal-actions {
                            display: flex;
                            gap: 15px;
                            margin-top: 30px;
                        }

                        .btn-modal {
                            flex: 1;
                            padding: 14px 20px;
                            border: none;
                            border-radius: 12px;
                            font-weight: 600;
                            font-size: 0.95rem;
                            cursor: pointer;
                            transition: var(--transition);
                        }

                        .btn-submit {
                            background: var(--primary);
                            color: white;
                        }

                        .btn-submit:hover {
                            background: var(--primary-dark);
                        }

                        .btn-cancel {
                            background: #f0f0f0;
                            color: var(--text-dark);
                        }

                        .btn-cancel:hover {
                            background: #e0e0e0;
                        }

                        @media (max-width: 768px) {
                            .documents-grid {
                                grid-template-columns: 1fr;
                            }

                            .header {
                                flex-direction: column;
                                gap: 20px;
                            }
                        }

                        /* Viewer Modal */
                        .viewer-modal {
                            display: none;
                            position: fixed;
                            top: 0;
                            left: 0;
                            width: 100%;
                            height: 100%;
                            background: rgba(0, 0, 0, 0.9);
                            backdrop-filter: blur(10px);
                            z-index: 3000;
                            flex-direction: column;
                        }

                        .viewer-header {
                            padding: 20px;
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            color: white;
                            background: rgba(255, 255, 255, 0.1);
                        }

                        .viewer-content {
                            flex: 1;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            position: relative;
                            padding: 20px;
                        }

                        .viewer-frame {
                            width: 100%;
                            height: 100%;
                            border-radius: 12px;
                            border: none;
                            background: white;
                            max-width: 1000px;
                        }

                        .viewer-image {
                            max-width: 100%;
                            max-height: 100%;
                            border-radius: 8px;
                            box-shadow: 0 0 30px rgba(0, 0, 0, 0.5);
                        }

                        .viewer-loader {
                            position: absolute;
                            top: 50%;
                            left: 50%;
                            transform: translate(-50%, -50%);
                            text-align: center;
                            color: white;
                        }

                        .spinner {
                            width: 50px;
                            height: 50px;
                            border: 5px solid rgba(255, 255, 255, 0.2);
                            border-top-color: var(--primary);
                            border-radius: 50%;
                            animation: spin 1s linear infinite;
                            margin-bottom: 10px;
                        }

                        @keyframes spin {
                            to {
                                transform: rotate(360deg);
                            }
                        }

                        .btn-close-viewer {
                            background: rgba(255, 255, 255, 0.2);
                            border: none;
                            color: white;
                            width: 40px;
                            height: 40px;
                            border-radius: 50%;
                            cursor: pointer;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            font-size: 1.2rem;
                            transition: var(--transition);
                        }

                        .btn-close-viewer:hover {
                            background: var(--danger);
                            transform: rotate(90deg);
                        }
                    </style>
                </head>

                <body>
                    <!-- Security Overlay -->
                    <div class="security-overlay" id="securityOverlay">
                        <div class="security-card">
                            <div class="security-icon">
                                <i class="fas fa-lock"></i>
                            </div>
                            <h2>Secure Access</h2>
                            <p>Please enter your 4-digit security PIN to access the Doc Locker.</p>
                            <input type="password" class="pin-input" id="pinInput" maxlength="4" placeholder="••••"
                                autofocus>
                            <button class="btn-unlock" onclick="checkPin()">
                                <i class="fas fa-key"></i> Unlock Locker
                            </button>
                            <p id="pinError" style="color: var(--danger); margin-top: 15px; display: none;">Invalid PIN.
                                Please try again.</p>
                        </div>
                    </div>

                    <div class="container" id="lockerContainer">
                        <div class="header">
                            <div class="header-left">
                                <div class="header-icon">
                                    <i class="fas fa-shield-alt"></i>
                                </div>
                                <div class="header-title">
                                    <h1>Doc Locker</h1>
                                    <p>Securely store and manage your academic documents</p>
                                </div>
                            </div>
                            <a href="dashboardServlet" class="btn-back">
                                <i class="fas fa-arrow-left"></i>
                                Back to Dashboard
                            </a>
                        </div>

                        <% String status=request.getParameter("status"); String error=request.getParameter("error"); if
                            ("upload_success".equals(status)) { %>
                            <div
                                style="background: #e8f5e9; color: #2e7d32; padding: 15px; border-radius: 12px; margin-bottom: 25px; border: 1px solid #c8e6c9;">
                                <i class="fas fa-check-circle"></i> Document uploaded successfully!
                            </div>
                            <% } else if (error !=null) { %>
                                <div
                                    style="background: #ffebee; color: #c62828; padding: 15px; border-radius: 12px; margin-bottom: 25px; border: 1px solid #ffcdd2;">
                                    <i class="fas fa-exclamation-circle"></i> Error: <%= error.replace("_", " " ) %>
                                </div>
                                <% } %>

                                    <div class="documents-grid">
                                        <!-- SSLC Marks Card -->
                                        <div class="document-card marks-card" <% if (student.getSslcCardPath() !=null &&
                                            !student.getSslcCardPath().isEmpty()) { %>
                                            onclick="viewDocument('sslc', '<%= student.getId() %>')" style="cursor:
                                                pointer;"
                                                <% } %>>
                                                    <div class="document-header">
                                                        <div class="document-icon">
                                                            <i class="fas fa-certificate"></i>
                                                        </div>
                                                        <div class="document-title">
                                                            <h3>SSLC Marks Card</h3>
                                                            <p>10th Standard Certificate</p>
                                                        </div>
                                                    </div>
                                                    <div class="document-info">
                                                        <div class="info-row">
                                                            <span class="info-label">Percentage:</span>
                                                            <span class="info-value">
                                                                <%= student.getSslcPercentage() !=null ?
                                                                    student.getSslcPercentage() + "%" : "N/A" %>
                                                            </span>
                                                        </div>
                                                        <div class="info-row">
                                                            <span class="info-label">Year:</span>
                                                            <span class="info-value">
                                                                <%= student.getSslcYear() !=null ? student.getSslcYear()
                                                                    : "N/A" %>
                                                            </span>
                                                        </div>
                                                        <div class="info-row">
                                                            <span class="info-label">Status:</span>
                                                            <span class="info-value">
                                                                <% if (student.getSslcCardPath() !=null &&
                                                                    !student.getSslcCardPath().isEmpty()) { %>
                                                                    <span
                                                                        class="status-badge status-uploaded">Uploaded</span>
                                                                    <% } else { %>
                                                                        <span class="status-badge status-pending">Not
                                                                            Uploaded</span>
                                                                        <% } %>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="document-actions" onclick="event.stopPropagation();">
                                                        <% if (student.getSslcCardPath() !=null &&
                                                            !student.getSslcCardPath().isEmpty()) { %>
                                                            <button
                                                                onclick="viewDocument('sslc', '<%= student.getId() %>')"
                                                                class="btn-action btn-view">
                                                                <i class="fas fa-eye"></i> View
                                                            </button>
                                                            <% } else { %>
                                                                <button class="btn-action btn-upload"
                                                                    onclick="openUploadModal('sslc')">
                                                                    <i class="fas fa-upload"></i> Upload
                                                                </button>
                                                                <% } %>
                                                    </div>
                                        </div>

                                        <!-- Diploma Marks Card -->
                                        <div class="document-card diploma-card" <% if (student.getDiplomaCardPath()
                                            !=null && !student.getDiplomaCardPath().isEmpty()) { %>
                                            onclick="viewDocument('diploma', '<%= student.getId() %>')" style="cursor:
                                                pointer;"
                                                <% } %>>
                                                    <div class="document-header">
                                                        <div class="document-icon">
                                                            <i class="fas fa-graduation-cap"></i>
                                                        </div>
                                                        <div class="document-title">
                                                            <h3>Diploma Marks Card</h3>
                                                            <p>All Semester Marks</p>
                                                        </div>
                                                    </div>
                                                    <div class="document-info">
                                                        <div class="info-row">
                                                            <span class="info-label">CGPA:</span>
                                                            <span class="info-value">
                                                                <%= student.getCgpa() !=null ? student.getCgpa() : "N/A"
                                                                    %>
                                                            </span>
                                                        </div>
                                                        <div class="info-row">
                                                            <span class="info-label">Branch:</span>
                                                            <span class="info-value">
                                                                <%= student.getBranch() !=null ? student.getBranch()
                                                                    : "N/A" %>
                                                            </span>
                                                        </div>
                                                        <div class="info-row">
                                                            <span class="info-label">Status:</span>
                                                            <span class="info-value">
                                                                <% if (student.getDiplomaCardPath() !=null &&
                                                                    !student.getDiplomaCardPath().isEmpty()) { %>
                                                                    <span
                                                                        class="status-badge status-uploaded">Uploaded</span>
                                                                    <% } else { %>
                                                                        <span class="status-badge status-pending">Not
                                                                            Uploaded</span>
                                                                        <% } %>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="document-actions" onclick="event.stopPropagation();">
                                                        <% if (student.getDiplomaCardPath() !=null &&
                                                            !student.getDiplomaCardPath().isEmpty()) { %>
                                                            <button
                                                                onclick="viewDocument('diploma', '<%= student.getId() %>')"
                                                                class="btn-action btn-view">
                                                                <i class="fas fa-eye"></i> View
                                                            </button>
                                                            <% } else { %>
                                                                <button class="btn-action btn-upload"
                                                                    onclick="openUploadModal('diploma')">
                                                                    <i class="fas fa-upload"></i> Upload Document
                                                                </button>
                                                                <% } %>
                                                    </div>
                                        </div>

                                        <!-- Resume -->
                                        <div class="document-card resume-card" <% if (student.getResumePath() !=null &&
                                            !student.getResumePath().isEmpty()) { %>
                                            onclick="viewDocument('resume', '<%= student.getId() %>')" style="cursor:
                                                pointer;"
                                                <% } %>>
                                                    <div class="document-header">
                                                        <div class="document-icon">
                                                            <i class="fas fa-file-alt"></i>
                                                        </div>
                                                        <div class="document-title">
                                                            <h3>My Resume</h3>
                                                            <p>Professional CV</p>
                                                        </div>
                                                    </div>
                                                    <div class="document-info">
                                                        <div class="info-row">
                                                            <span class="info-label">Format:</span>
                                                            <span class="info-value">PDF</span>
                                                        </div>
                                                        <div class="info-row">
                                                            <span class="info-label">Type:</span>
                                                            <span class="info-value">Standard</span>
                                                        </div>
                                                        <div class="info-row">
                                                            <span class="info-label">Status:</span>
                                                            <span class="info-value">
                                                                <% if (student.getResumePath() !=null &&
                                                                    !student.getResumePath().isEmpty()) { %>
                                                                    <span
                                                                        class="status-badge status-uploaded">Uploaded</span>
                                                                    <% } else { %>
                                                                        <span class="status-badge status-pending">Not
                                                                            Uploaded</span>
                                                                        <% } %>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="document-actions" onclick="event.stopPropagation();">
                                                        <% if (student.getResumePath() !=null &&
                                                            !student.getResumePath().isEmpty()) { %>
                                                            <button
                                                                onclick="viewDocument('resume', '<%= student.getId() %>')"
                                                                class="btn-action btn-view">
                                                                <i class="fas fa-eye"></i> View
                                                            </button>
                                                            <% } else { %>
                                                                <button class="btn-action btn-upload"
                                                                    onclick="openUploadModal('resume')">
                                                                    <i class="fas fa-upload"></i> Upload Document
                                                                </button>
                                                                <% } %>
                                                    </div>
                                        </div>
                                    </div>
                    </div>

                    <!-- Upload Modal -->
                    <div class="upload-modal" id="uploadModal">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h2>Upload Document</h2>
                                <p>Please select a PDF or image file to upload (Max 50MB)</p>
                            </div>
                            <form id="uploadForm" action="UploadDocumentServlet" method="POST"
                                enctype="multipart/form-data">
                                <input type="hidden" name="documentType" id="documentType">
                                <div class="form-group">
                                    <label>Select File</label>
                                    <div class="file-input-wrapper">
                                        <input type="file" name="documentFile" id="documentFile" required
                                            accept=".pdf,.jpg,.jpeg,.png">
                                        <div class="file-dummy">
                                            <i class="fas fa-cloud-upload-alt"></i>
                                            <span class="file-name">Click to choose or drag & drop</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-actions">
                                    <button type="button" class="btn-modal btn-cancel"
                                        onclick="closeUploadModal()">Cancel</button>
                                    <button type="submit" class="btn-modal btn-submit">
                                        <i class="fas fa-upload"></i> Upload
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Viewer Modal -->
                    <div id="viewerModal" class="viewer-modal">
                        <div class="viewer-header">
                            <h3 id="viewerTitle">Document Preview</h3>
                            <button class="btn-close-viewer" onclick="closeViewer()">
                                <i class="fas fa-times"></i>
                            </button>
                        </div>
                        <div class="viewer-content">
                            <div id="viewerLoader" class="viewer-loader">
                                <div class="spinner"></div>
                                <p>Loading Document...</p>
                            </div>
                            <iframe id="viewerFrame" class="viewer-frame" style="display: none;"></iframe>
                            <img id="viewerImage" class="viewer-image" style="display: none;">
                        </div>
                    </div>

                    <script>
                        // Security Check
                        const CORRECT_PIN = "1234"; // Default security password

                        function checkPin() {
                            const input = document.getElementById('pinInput').value;
                            const error = document.getElementById('pinError');
                            const overlay = document.getElementById('securityOverlay');
                            const container = document.getElementById('lockerContainer');

                            if (input === CORRECT_PIN) {
                                overlay.style.opacity = '0';
                                setTimeout(() => {
                                    overlay.style.display = 'none';
                                    container.classList.add('unlocked');
                                }, 500);
                            } else {
                                error.style.display = 'block';
                                document.getElementById('pinInput').value = '';
                                document.getElementById('pinInput').focus();

                                // Shake effect
                                document.querySelector('.security-card').animate([
                                    { transform: 'translateX(0)' },
                                    { transform: 'translateX(-10px)' },
                                    { transform: 'translateX(10px)' },
                                    { transform: 'translateX(-10px)' },
                                    { transform: 'translateX(0)' }
                                ], { duration: 300 });
                            }
                        }

                        // Allow Enter key to submit PIN
                        document.getElementById('pinInput').addEventListener('keypress', function (e) {
                            if (e.key === 'Enter') {
                                checkPin();
                            }
                        });

                        function openUploadModal(type) {
                            document.getElementById('documentType').value = type;
                            document.getElementById('uploadModal').classList.add('active');
                        }

                        function closeUploadModal() {
                            document.getElementById('uploadModal').classList.remove('active');
                            document.getElementById('uploadForm').reset();
                        }

                        // Close modal when clicking outside
                        document.getElementById('uploadModal').addEventListener('click', function (e) {
                            if (e.target === this) {
                                closeUploadModal();
                            }
                        });

                        // Viewer Functions
                        function viewDocument(type, id) {
                            if (!type || !id) {
                                alert('Error: Missing document info.');
                                return;
                            }

                            const modal = document.getElementById('viewerModal');
                            const loader = document.getElementById('viewerLoader');
                            const frame = document.getElementById('viewerFrame');
                            const img = document.getElementById('viewerImage');
                            const title = document.getElementById('viewerTitle');

                            const titles = {
                                'sslc': 'SSLC Marks Card',
                                'diploma': 'Diploma Marks Card',
                                'resume': 'Resume / CV'
                            };

                            title.innerText = titles[type] || 'Document Preview';
                            modal.style.display = 'flex';
                            loader.innerHTML = '<div class="spinner"></div><p>Loading Document...</p>';
                            loader.style.display = 'block';
                            frame.style.display = 'none';
                            img.style.display = 'none';

                            console.log('viewDocument called with type:', type, 'id:', id);
                            const url = 'DocumentViewerServlet?type=' + type + '&id=' + id;
                            console.log('Requesting URL:', url);

                            frame.src = url;

                            frame.onload = function () {
                                // Small timeout to ensure content is rendered
                                setTimeout(() => {
                                    loader.style.display = 'none';
                                    frame.style.display = 'block';
                                }, 500);
                            };

                            frame.onerror = function () {
                                loader.innerHTML = '<i class="fas fa-exclamation-triangle" style="font-size: 3rem; color: #ff4444; margin-bottom: 10px;"></i><p>Document not found or error loading.</p>';
                            };
                        }

                        function closeViewer() {
                            const modal = document.getElementById('viewerModal');
                            const frame = document.getElementById('viewerFrame');
                            const img = document.getElementById('viewerImage');

                            if (modal) modal.style.display = 'none';
                            if (frame) frame.src = 'about:blank';
                            if (img) img.src = '';
                        }
                    </script>
                </body>

                </html>