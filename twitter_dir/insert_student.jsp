<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mysql.jdbc.*" %>

<%
     
      try {

	int status = 0;					//holds status for successful insertion
        java.sql.Connection conn = null;
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        String url = "jdbc:mysql://127.0.0.1/gordie";			//location and name of database
	String userid = "gordie";
	String password = "happy95";

	String fname = request.getParameter("first_name") ;//read param, set to local variable

        conn = DriverManager.getConnection(url, userid, password);	//connect to database

	java.sql.PreparedStatement ps = conn.prepareStatement("insert into cpardee.student_t (full_name) values (?.?)");//column name AS IT IS IN THE DATABASE

	ps.setString (1,fname);//1, key
	status = ps.executeUpdate();					//attempt insert; 2, tweet

      	} //close try
	catch (Exception e) 
	{
        out.println("There was an error:" +  e);
        }
%>
</BODY>
</HTML>


