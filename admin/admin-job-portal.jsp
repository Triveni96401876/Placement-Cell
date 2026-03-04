<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <% List<String[]> jobs = (List<String[]>) request.getAttribute("activeJobs");
                %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Job Portal | SGP Admin</title>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
                        rel="stylesheet">
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <style>
                        :root {
                            --primary: #4834d4;
                            --bg: #f8fafc;
                            --text: #2d3436;
                            --muted: #636e72;
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
                            padding-bottom: 50px;
                        }

                        .container {
                            max-width: 900px;
                            margin: 40px auto;
                            padding: 0 20px;
                        }

                        .nav-back {
                            display: inline-flex;
                            align-items: center;
                            gap: 8px;
                            color: var(--muted);
                            text-decoration: none;
                            margin-bottom: 20px;
                            font-weight: 600;
                        }

                        .header {
                            display: flex;
                            align-items: center;
                            gap: 15px;
                            margin-bottom: 30px;
                        }

                        .header i {
                            font-size: 1.5rem;
                            color: #00a8ff;
                        }

                        .header h1 {
                            font-size: 1.6rem;
                            font-weight: 700;
                        }

                        .card {
                            background: #fff;
                            border-radius: 16px;
                            padding: 30px;
                            margin-bottom: 25px;
                            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.04);
                            position: relative;
                            border-left: 6px solid #4895ef;
                        }

                        .badge {
                            position: absolute;
                            top: 25px;
                            right: 25px;
                            background: #f1f2f6;
                            color: var(--primary);
                            padding: 6px 14px;
                            border-radius: 20px;
                            font-size: 0.75rem;
                            font-weight: 700;
                            text-transform: uppercase;
                        }

                        .title {
                            font-size: 1.4rem;
                            font-weight: 700;
                            margin-bottom: 15px;
                            text-transform: lowercase;
                        }

                        .row {
                            font-size: 1rem;
                            margin-bottom: 4px;
                            color: var(--muted);
                        }

                        .label {
                            font-weight: 600;
                            color: #555;
                            text-transform: capitalize;
                        }

                        .desc {
                            font-size: 0.95rem;
                            line-height: 1.6;
                            margin: 15px 0;
                        }

                        .date {
                            font-size: 0.8rem;
                            color: #95a5a6;
                            margin-bottom: 20px;
                        }

                        .btn {
                            display: inline-flex;
                            background: var(--primary);
                            color: #fff;
                            padding: 10px 24px;
                            border-radius: 12px;
                            text-decoration: none;
                            font-weight: 600;
                            box-shadow: 0 4px 15px rgba(72, 52, 212, 0.2);
                            transition: 0.3s;
                        }

                        .btn:hover {
                            transform: scale(1.05);
                        }
                    </style>
                </head>

                <body>
                    <div class="container">
                        <a href="AdminDashboardServlet" class="nav-back"><i class="fas fa-chevron-left"></i> Back to
                            Dashboard</a>
                        <div class="header"><i class="fas fa-bullhorn"></i>
                            <h1>Job Portal Updates & Announcements</h1>
                        </div>
                        <% if(jobs !=null) { for(int i=0; i < jobs.size(); i++) { String[] job=jobs.get(i); String
                            title=job[1]; String raw=job[2]; String time=job[4]; String co="SGP" ; String lo="Bengaluru"
                            ; String sa="4.5LPA" ; String dl="2026-02-25" ; String ds=raw; try { if(raw !=null &&
                            raw.contains("<b>")) {
                            co = raw.split("<b>Company:</b>")[1].split("<br>")[0].trim();
                            lo = raw.split("<b>Location:</b>")[1].split("<br>")[0].trim();
                            sa = raw.split("<b>Salary:</b>")[1].split("<br>")[0].trim();
                            dl = raw.split("<b>Deadline:</b>")[1].split("<br>")[0].trim();
                            ds = raw.split("<br><br>")[1].replace("<br>", "\n").replaceAll("<[^>]*>", "");
                                }
                                } catch(Exception e) {}
                                %>
                                <div class="card">
                                    <span class="badge">Job Opportunity</span>
                                    <h2 class="title">
                                        <%= title %>
                                    </h2>
                                    <div class="row"><span class="label">company:</span>
                                        <%= co %>
                                    </div>
                                    <div class="row"><span class="label">location:</span>
                                        <%= lo %>
                                    </div>
                                    <div class="row"><span class="label">salary:</span>
                                        <%= sa %>
                                    </div>
                                    <div class="row"><span class="label">deadline:</span>
                                        <%= dl %>
                                    </div>
                                    <div class="desc">
                                        <%= ds %>
                                    </div>
                                    <div class="date">Posted on: <%= time %>
                                    </div>
                                    <a href="AdminRegistrationsServlet?jobId=<%= job[0] %>" class="btn">View Applicants
                                        ></a>
                                </div>
                                <% } } %>
                    </div>
                </body>

                </html>