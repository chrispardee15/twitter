<!doctype html>
<html lang="en">
<ge language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mysql.jdbc.*" %>


<%
//Version made on 5/12/15
//LAST UPDATE 5/12/15 @4:10PM -- MAKE A NEW VERSION IF CHANGES WILL BE MADE!!!
//!!!!!
//This version checks for null usernames, usernames with non-alphanumeric characters, and solely numeric usernames
String name = request.getParameter("user[name]");//Full Name --works!
String email = request.getParameter("user[email]");//email --works!
String password = request.getParameter("user[password]");//password -- works!
String username = request.getParameter("user[username]");//password -- works!
//THIS JSP DOES ALL THE CHECKS BEFORE THE INSERTION

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
String errormessage ="";

//FIRST Catch -- javascript insertion/ non alphanumeric

	
	//boolean c = (new RegExp("/^[a-z0-9]+$/i")).test(username);
// if (username.contains("/^[a-z0-9]+$/i")){
// 		//redirect with error message
// 		//error
// 		out.println("Invalid username! Alphanumerics only and not all numeric.");
// 		//response.sendRedirect(loginversion);
// 	}
// if(username.contains("!") || username.contains("+") ||username.contains(">") || username.contains("<") || username.contains("[") || username.contains("]") || username.contains("%") || username.contains(",") || username.contains("=") || username.contains("&") || username.contains("-") || username.contains("\'") || username.contains(".") || username.contains("~") || username.contains("(") || username.contains(")") || username.contains("|") || username.contains("/") || username.contains("{") || username.contains("}") || username.contains("\n") || username.contains("\ ") ||username.contains("?") || username.contains("@") || username.contains(":") || username.contains(";") || username.contains("^") || username.contains("`") || username.contains("*")){//this is definitely not all of them, the only way to do that properly is the regex method that I can't get to work.
// //redirect with error message -- Invalid username! Alphanumerics only and not all numeric.
// 
// }
// for(int i = 0; i< username.length(); i++){
// 	if(Character.toString(username.charAt(i)).matches("^[A-Za-z0-9_.]+$")){
// 		//out.println("Invalid username! Alphanumerics only and not all numeric.");
// 		out.println("you good man!");
// 	}
// 	//else out.println("nope");
// 	else out.println("Invalid username! Alphanumerics only and not all numeric.");
// }
if(username.equals("")|| username == null){
	errormessage = "A username is required!";
	response.sendRedirect(loginversion+"?uperror="+errormessage);
}
else if(!(username.matches("^[0-9]*$"))){//if it is not only numbers -- works
	if(!username.matches("^[A-Za-z0-9_.]+$")){//if it is non alphanumeric -- works
		//out.println("you good man!");
		//redirect with error message
		errormessage = "Invalid username! Alphanumerics only and not all numeric.";
		response.sendRedirect(loginversion+"?uperror="+errormessage);	
	}	
}
else 
{
	errormessage = "Invalid username! Alphanumerics only and not all numeric.";
	response.sendRedirect(loginversion+"?uperror="+errormessage);	
}
//else out.println("Invalid username! Alphanumerics only and not all numeric. (all numeric)");
//redirect with error message



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