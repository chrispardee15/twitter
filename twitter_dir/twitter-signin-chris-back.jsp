<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mysql.jdbc.*" %>

//Take in parameters
//check parameters against tables
//if does not exist, redirect to original page with an error message telling them to sign up
//--Sign in--\\
String intext = request.getParameter("session[username_or_email]");
String password = request.getParameter("session[password]");
out.println(intext);
out.println(password);

//--Sign up--\\