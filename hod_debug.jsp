<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.sql.*, com.placementcell.util.DBConnection, com.placementcell.model.User" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Debug HOD Apps</title>
        </head>

        <body style="font-family: monospace; padding: 20px;">
            <h2>HOD Debug Page</h2>

            <% User u=(User) session.getAttribute("user"); if (u !=null) { %>
                <p><b>Session User:</b>
                    <%= u.getEmail() %>
                </p>
                <p><b>Role:</b>
                    <%= u.getRole() %>
                </p>
                <p><b>Branch from session:</b> [<%= u.getBranch() %>]</p>
                <% } else { %>
                    <p style="color:red">No user in session - please login first!</p>
                    <% } %>

                        <h3>All Job Applications in DB:</h3>
                        <table border="1" cellpadding="5">
                            <tr>
                                <th>Student</th>
                                <th>Reg No</th>
                                <th>Branch in DB</th>
                                <th>Company</th>
                                <th>Role</th>
                            </tr>
                            <% try (Connection conn=DBConnection.getConnection(); Statement stmt=conn.createStatement();
                                ResultSet rs=stmt.executeQuery("SELECT student_name, register_number, branch,
                                company_name, job_role FROM job_applications ORDER BY applied_date DESC")) { int
                                count=0; while (rs.next()) { count++; %>
                                <tr>
                                    <td>
                                        <%= rs.getString(1) %>
                                    </td>
                                    <td>
                                        <%= rs.getString(2) %>
                                    </td>
                                    <td><b style="color:blue">[<%= rs.getString(3) %>]</b></td>
                                    <td>
                                        <%= rs.getString(4) %>
                                    </td>
                                    <td>
                                        <%= rs.getString(5) %>
                                    </td>
                                </tr>
                                <% } if (count==0) { %>
                                    <tr>
                                        <td colspan="5" style="color:red">NO APPLICATIONS IN DATABASE</td>
                                    </tr>
                                    <% } %>
                                        <% } catch (Exception e) { %>
                                            <tr>
                                                <td colspan="5" style="color:red">DB Error: <%= e.getMessage() %>
                                                </td>
                                            </tr>
                                            <% } %>
                        </table>

                        <h3>HOD Users in DB:</h3>
                        <table border="1" cellpadding="5">
                            <tr>
                                <th>ID</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Branch in DB</th>
                            </tr>
                            <% try (Connection conn=DBConnection.getConnection(); Statement stmt=conn.createStatement();
                                ResultSet rs=stmt.executeQuery("SELECT id, email, role, branch FROM users WHERE role IN
                                ('HOD','ADMIN')")) { while (rs.next()) { %>
                                <tr>
                                    <td>
                                        <%= rs.getString(1) %>
                                    </td>
                                    <td>
                                        <%= rs.getString(2) %>
                                    </td>
                                    <td>
                                        <%= rs.getString(3) %>
                                    </td>
                                    <td><b style="color:green">[<%= rs.getString(4) %>]</b></td>
                                </tr>
                                <% } } catch (Exception e) { out.println("DB Error: " + e.getMessage()); } %>
</table>
</body>
</html>