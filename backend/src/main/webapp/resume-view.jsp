<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.placementcell.model.Student" %>
        <% Student student=(Student) request.getAttribute("studentResume"); if (student==null) {
            response.sendRedirect("DashboardServlet"); return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Resume - <%= student.getFullName() %>
                </title>
                <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap"
                    rel="stylesheet">
                <style>
                    body {
                        font-family: 'Roboto', sans-serif;
                        background: #f0f2f5;
                        margin: 0;
                        padding: 40px;
                    }

                    .resume-container {
                        background: white;
                        width: 8.5in;
                        min-height: 11in;
                        margin: 0 auto;
                        padding: 50px;
                        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                    }

                    .header {
                        text-align: center;
                        border-bottom: 2px solid #333;
                        padding-bottom: 20px;
                        margin-bottom: 30px;
                    }

                    .name {
                        font-size: 28px;
                        font-weight: 700;
                        color: #1a1a1a;
                        margin-bottom: 10px;
                    }

                    .contact {
                        color: #666;
                        font-size: 14px;
                    }

                    .section {
                        margin-bottom: 25px;
                    }

                    .section-title {
                        font-size: 18px;
                        font-weight: 700;
                        color: #1a1a1a;
                        border-bottom: 1px solid #ccc;
                        padding-bottom: 5px;
                        margin-bottom: 15px;
                        text-transform: uppercase;
                    }

                    .row {
                        display: flex;
                        justify-content: space-between;
                        margin-bottom: 10px;
                    }

                    .label {
                        font-weight: 500;
                        width: 200px;
                        color: #333;
                    }

                    .value {
                        flex: 1;
                        color: #555;
                    }

                    .skills-list {
                        display: flex;
                        flex-wrap: wrap;
                        gap: 8px;
                    }

                    .skill-item {
                        background: #eee;
                        padding: 5px 12px;
                        border-radius: 4px;
                        font-size: 13px;
                    }

                    .no-print {
                        position: fixed;
                        top: 20px;
                        right: 20px;
                    }

                    .btn {
                        background: #00a8ff;
                        color: white;
                        border: none;
                        padding: 10px 20px;
                        border-radius: 5px;
                        cursor: pointer;
                        text-decoration: none;
                        font-weight: 500;
                    }

                    @media print {
                        .no-print {
                            display: none;
                        }

                        body {
                            padding: 0;
                            background: white;
                        }

                        .resume-container {
                            box-shadow: none;
                            margin: 0;
                        }
                    }
                </style>
            </head>

            <body>
                <div class="no-print">
                    <a href="DashboardServlet" class="btn" style="background: #666;">Dashboard</a>
                    <button class="btn" onclick="window.print()">Print / Download</button>
                </div>

                <div class="resume-container">
                    <div class="header">
                        <div class="name">
                            <%= student.getFullName() %>
                        </div>
                        <div class="contact">
                            ID: <%= student.getRegisterNumber() %> |
                                Email: <%= (student.getUserId() !=null) ? "Authenticated Student" : "N/A" %> |
                                    Mobile: <%= student.getMobileNumber() %>
                        </div>
                        <div class="contact">Address: Ballari, Karnataka</div>
                    </div>

                    <div class="section">
                        <div class="section-title">Career Objective</div>
                        <p style="font-size: 14px; line-height: 1.6; color: #555;">
                            <%= (student.getCareerObjective() !=null && !student.getCareerObjective().isEmpty()) ?
                                student.getCareerObjective()
                                : "Motivated Technical Diploma student from Sanjay Gandhi Polytechnic, Ballari. Seeking a professional opportunity to apply my knowledge in "
                                + student.getBranch()
                                + " and contribute to organizational goals while enhancing my technical skills." %>
                        </p>
                    </div>

                    <div class="section">
                        <div class="section-title">Education</div>
                        <div class="row">
                            <div class="label">Diploma (<%= student.getBranch() %>)</div>
                            <div class="value">
                                <strong>Sanjay Gandhi Polytechnic, Ballari</strong><br>
                                CGPA: <%= student.getCgpa() %>
                            </div>
                        </div>
                        <div class="row">
                            <div class="label">SSLC (10th)</div>
                            <div class="value">Percentage: <%= student.getSslcPercentage() %>%</div>
                        </div>
                        <div class="row">
                            <div class="label">PUC / Diploma entry</div>
                            <div class="value">Percentage: <%= student.getPucPercentage() %>%</div>
                        </div>
                    </div>

                    <div class="section">
                        <div class="section-title">Technical Skills</div>
                        <div class="skills-list">
                            <% if(student.getSkills() !=null) { for(String s : student.getSkills().split(",")) { %>
                                <span class="skill-item">
                                    <%= s.trim() %>
                                </span>
                                <% } } %>
                        </div>
                    </div>

                    <div class="section">
                        <div class="section-title">Personal Details</div>
                        <div class="row">
                            <div class="label">Gender</div>
                            <div class="value">
                                <%= student.getGender() %>
                            </div>
                        </div>
                        <div class="row">
                            <div class="label">Branch</div>
                            <div class="value">
                                <%= student.getBranch() %>
                            </div>
                        </div>
                        <div class="row">
                            <div class="label">Languages</div>
                            <div class="value">English, Kannada, Hindi</div>
                        </div>
                    </div>

                    <div class="section">
                        <div class="section-title">Declaration</div>
                        <p style="font-size: 14px; color: #555;">
                            I hereby declare that the details provided above are true and correct to the best of my
                            knowledge.
                        </p>
                        <div style="margin-top: 50px; text-align: right;">
                            <strong>(Signature)</strong>
                        </div>
                    </div>
                </div>
            </body>

            </html>