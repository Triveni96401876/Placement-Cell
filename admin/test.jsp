<%@ page import="java.sql.*, com.placementcell.util.DBConnection, java.io.*" %>
    <% StringBuilder sb=new StringBuilder(); sb.append("Starting test...\n"); try (Connection
        conn=DBConnection.getConnection(); PreparedStatement stmt=conn.prepareStatement("SELECT s.*, ad.*, r.sslc_path,
        r.diploma_path, r.resume_path, r.resume_description FROM students s JOIN academic_details ad ON
        s.id=ad.student_id LEFT JOIN resumes r ON s.id=r.student_id WHERE 1=1 ORDER BY s.id DESC LIMIT 1")) { ResultSet
        rs=stmt.executeQuery(); if (rs.next()) { sb.append("Got row!\n"); sb.append("sem1: " + rs.getDouble(" sem1")
        + "\n" ); sb.append("sem2: " + rs.getDouble(" sem2") + "\n" ); sb.append("sem3: " + rs.getDouble(" sem3") + "\n"
        ); sb.append("sem4: " + rs.getDouble(" sem4") + "\n" ); sb.append("sem5: " + rs.getDouble(" sem5") + "\n" );
        sb.append("sem6: " + rs.getDouble(" sem6") + "\n" ); sb.append("internship: " + rs.getString(" internship")
        + "\n" ); sb.append("Success!\n"); } else { sb.append("No rows found!\n"); } } catch (Exception e) {
        sb.append("EXCEPTION: " + e.getMessage() + " \n"); StringWriter sw=new StringWriter(); PrintWriter pw=new
        PrintWriter(sw); e.printStackTrace(pw); sb.append(sw.toString() + "\n" ); }
        out.println(sb.toString().replace("\n", "<br/>" )); %>