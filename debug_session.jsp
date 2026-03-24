<%@ page import="com.placementcell.model.User" %>
    <% User u=(User) session.getAttribute("user"); if (u==null) { out.println("No user in session"); } else {
        out.println("USER ID: " + u.getId());
        out.println(" EMAIL: " + u.getEmail());
        out.println(" ROLE: " + u.getRole());
        out.println(" BRANCH: " + u.getBranch());
        out.println(" FULL NAME: " + u.getFullName());
    }
%>