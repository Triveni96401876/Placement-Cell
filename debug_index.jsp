<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.io.*, java.util.*" %>
        <html>

        <body>
            <h3>Classpath Debugger</h3>
            <pre>
    <%
        try {
            Class<?> clazz = Class.forName("com.placementcell.model.User");
            out.println("SUCCESS: User class found at: " + clazz.getProtectionDomain().getCodeSource().getLocation());
        } catch(Throwable e) {
            out.println("FAILURE: User class NOT found: " + e.getMessage());
            e.printStackTrace(new PrintWriter(out));
        }
        
        try {
            Class<?> studentClazz = Class.forName("com.placementcell.model.Student");
            out.println("SUCCESS: Student class found at: " + studentClazz.getProtectionDomain().getCodeSource().getLocation());
        } catch(Throwable e) {
            out.println("FAILURE: Student class NOT found: " + e.getMessage());
        }
    %>
    </pre>
        </body>

        </html>