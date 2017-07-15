<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mysql.jdbc.*" %>


<%
	    
	String tweet_count = "";
	String data = request.getParameter("key"); 	
	out.println(data);

      try {
	java.sql.Connection con = null;
	out.println("the key is: " + data);

         String url = "";

         //sql query:
	 String query = "select count(*), tweetID from tweet_t where userID =" + data; //+data get all rows int he student database

	 //open sql:
         Class.forName("com.mysql.jdbc.Driver").newInstance();
         url = "jdbc:mysql://localhost:3306/cpardee";   //your db ex) ljadow
         con = DriverManager.getConnection(url, "cpardee", "hello57"); //mysql id &  pwd
         java.sql.Statement stmt = con.createStatement();
         
	 //executes the query:
	 java.sql.ResultSet rs = stmt.executeQuery(query);


	//loop through result set until there is not a next:
         while(rs.next())
	 	{
		tweet_count = rs.getString(1);//tweet_count
	 

	 	} //end while

      } catch (Exception e) {
         out.println(e);
      }

%>

<%=tweet_count%>


</BODY>
</HTML>


