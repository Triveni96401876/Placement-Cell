<%@ page import="java.sql.*, com.placementcell.util.DBConnection, java.util.*" %>
    <div style="font-family: monospace;">
        <h3>Debug Job Applications</h3>
        <table border="1">
            <tr>
                <th>Student Name</th>
                <th>Reg No</th>
                <th>Branch</th>
                <th>Job Role</th>
                <th>Company</th>
            </tr>
            <% try (Connection conn=DBConnection.getConnection(); Statement stmt=conn.createStatement(); ResultSet
                rs=stmt.executeQuery("SELECT student_name, register_number, branch, job_role, company_name FROM
                job_applications")) { while (rs.next()) { %>
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
                    <td>
                        <%= rs.getString(4) %>
                    </td>
                    <td>
                        <%= rs.getString(5) %>
                    </td>
                </tr>
                <% } } catch (Exception e) { out.println("Error: " + e.getMessage());
            }
        %>
    </table>
</div>