<%@ page session="false" language="java" import="java.util.*" %>
<%
 HttpSession session = request.getSession(true);
 %>

<!doctype html>
<html lang="en">
<ge language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mysql.jdbc.*" %>

<%
//this page basically just clears the session variables/kills the session and redirects to the signin screen

if (request.getParameter("logout") != null) {  
    session.invalidate();
    response.sendRedirect("twitter-signin-chris-04.jsp?logout=true");
    return; // <--- Here.
}

%>