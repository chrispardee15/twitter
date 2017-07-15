<!doctype html>
<html lang="en">
<ge language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mysql.jdbc.*" %>

<%
//Version 5/12/15
//LAST UPDATE 5/12/15 @4:10PM -- MAKE A NEW VERSION IF CHANGES WILL BE MADE!!!
//!!!!!
//This version checks for null inputs


//Full name's limit is 20
//Email does not have a limit
//password does not have a limit (SQL's is 100)

//take in params
String name = request.getParameter("user[name]");//Full Name -- works
String errormessage ="";
if (name!= null || !name.equals("")){
 name = "\""+name+"\"";//this works!!
}
String email = request.getParameter("user[email]");//email -- works
String password = request.getParameter("user[password]");//password -- works
String backend = "twitter-signup-chris-back-02.jsp";//the version of the insertion back end to redirect to 

//out.println(name);
//out.println(email);
//out.println(password);
String uperror = "";//error message
boolean error = false;
String loginversion ="twitter-signin-chris-02.jsp";

//error checks
if(name.equals("") || name.equals("\"\"")|| name == null){
	errormessage += "Please write your full name ";
	
	error = true;
}
if(email.equals("")|| email == null){
	errormessage += "Please write your email ";
	error = true;
}
if(password.equals("")|| password == null){
	errormessage += "Please write a password ";
	error = true;
}
//put all other error messages here
if(error) response.sendRedirect(loginversion+"?uperror="+errormessage);

%>

<body>

<form action = <%=backend%>> <!-- I either have to do the insertion inside this form somehow or make another jsp back end to handle it-->
<input type = "text" id = "signup-user-name" name="user[name]" maxlength="20" value = <%=name%>></textarea> <!--fix the fact that it only has the first name -->
<input type="text" id="signup-user-email" autocomplete="off" maxlength = "30" name="user[email]" value = <%=email%>>
<input type="password" id="signup-user-password" autocomplete="off" name="user[password]" value = <%=password%>>
<input type="text" id="signup-user-username" autocomplete="off" maxlength="15" name="user[username]" placeholder ="username">
<button type ="submit">Sign up</button>
</form>