<!doctype html>
<html lang="en">
<ge language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mysql.jdbc.*" %>


<%
//Backup made on 5/11/15
String name = request.getParameter("user[name]");//Full Name --works!
String email = request.getParameter("user[email]");//email --works!
String password = request.getParameter("user[password]");//password -- works!
String username = request.getParameter("user[username]");//password -- works!

//out.println(name);
//out.println(email);
//out.println(password);
//out.println(username);

//open SQL
int status = 0;
String url ="";
java.sql.Connection conn = null;
Class.forName("com.mysql.jdbc.Driver").newInstance();
url = "jdbc:mysql://localhost:3306/cpardee";   //your db ex) ljadow
conn = DriverManager.getConnection(url, "cpardee", "hello57"); //mysql id &  pwd

String loginversion = "twitter-signin-chris-02.jsp";

//insert into user_t (username, email, pwd, name) values(?,?,?,?);
java.sql.PreparedStatement ps = conn.prepareStatement("insert into user_t (username, email, pwd, name) values(?,?,?,?)");
ps.setString(1,username);
ps.setString(2,email);
ps.setString(3,password);
ps.setString(4,name);
status = ps.executeUpdate();//update the table
response.sendRedirect(loginversion);//redirect to the login screen (check if this is what twitter does)
	

//java.sql.ResultSet rs = ps.executeQuery();
/*while rs.next(){
out.println("login maybe successful");
response.sendRedirect(loginversion);
//break;//wtf do I do in here?
}*/

	
	
	




%>