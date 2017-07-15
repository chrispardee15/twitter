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
//this page does the msql insertion/update for new followers and unfollows
//this just does the insertion

//session.getAttribute("session[key]");//you (this is an object do .toString() if necessary)
String key = request.getParameter("key");//the person you want to follow/unfollow
String youfollow = request.getParameter("youfollow");//whether you're following them or not
int status = 0;
String twitterversion = "twitter-home-chris-08.jsp";

//open SQL
String url ="";
java.sql.Connection conn = null;
Class.forName("com.mysql.jdbc.Driver").newInstance();
url = "jdbc:mysql://localhost:3306/cpardee";   //your db ex) ljadow
conn = DriverManager.getConnection(url, "cpardee", "hello57"); //mysql id &  pwd

	
	java.sql.PreparedStatement psa = conn.prepareStatement("insert into cpardee.stalker_t (follower, following) values(?, ?)");//the insertion
	psa.setString(1,session.getAttribute("session[key]").toString());
	psa.setString(2,key);
	
	java.sql.PreparedStatement psb = conn.prepareStatement("delete from cpardee.stalker_t  where follower = ? and following = ?");//the deletion
	psb.setString(1,session.getAttribute("session[key]").toString());
	psb.setString(2,key);
	
	
	if(youfollow.equals("true"))//I forgot youfollow is a string now
	{
		//execute the unfollow query
		status = psb.executeUpdate();
	}
	else
	{
		//execute the follow query
		status = psa.executeUpdate();
	}
//go back to twitter-home at the page you just were
response.sendRedirect(twitterversion+"?key="+key);
	
	
	

%>