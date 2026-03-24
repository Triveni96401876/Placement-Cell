<%@ page import="com.placementcell.util.DBConnection, java.sql.*, java.util.*" %>
    <% out.println("<h3>Announcements in DB:</h3>
        <table border='1'>
            <tr>
                <th>ID</th>
                <th>Type</th>
                <th>Title</th>
                <th>Created At</th>
                <th>Created By</th>
            </tr>");
            try (Connection c = DBConnection.getConnection();
            Statement s = c.createStatement();
            ResultSet rs = s.executeQuery("SELECT * FROM announcements ORDER BY created_at DESC")) {
            while(rs.next()) {
            out.println("<tr>");
                out.println("<td>" + rs.getInt("id") + "</td>");
                out.println("<td>" + rs.getString("announcement_type") + "</td>");
                out.println("<td>" + rs.getString("title") + "</td>");
                out.println("<td>" + rs.getTimestamp("created_at") + "</td>");
                out.println("<td>" + rs.getString("created_by") + "</td>");
                out.println("</tr>");
            }
            } catch(Exception e) {
            out.println("Error: " + e.getMessage());
            }
            out.println("
        </table>");
        %>