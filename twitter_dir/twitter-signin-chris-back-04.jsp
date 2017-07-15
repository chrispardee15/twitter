

<!doctype html>
<html lang="en">
<ge language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mysql.jdbc.*" %>

<%
//Version made on 5/11/15 LAST UPDATE 5/13/15 @1:50PM -- MAKE A NEW VERSION IF CHANGES WILL BE MADE!!!
//!!!!!
//this is where I use session variables before passing them to twitter-home
 
//This version has working signin and deals with null inputs -- does not use sessions
//Take in parameters
//check parameters against tables
//if does not exist, redirect to original page with an error message telling them to sign up
//TWITTER LIMITS USERNAMES TO 15 CHARACTERS, SO DON'T LET PEOPLE SIGN UP WITH USERNAMES LONGER THAN THAT
//ERROR MESSAGE: "The username and password you entered did not match our records. Please double-check and try again."
//--Sign in--\\
String intext = request.getParameter("session[username_or_email]");//this works
String inpassword = request.getParameter("session[password]");//this works
String twitterVersion = "twitter-home-chris-08.jsp";//the current version of my twitter-home

//FIRST CATCH -- IF INTEXT/PASSWORD IS NULL REDIRECT BACK (TWITTER DOES NOT USE AN ERROR MESSAGE FOR THIS)
//error stuff
String errormessage = "";
String uperror = "";//error message
String loginVersion = "twitter-signin-chris-04.jsp";
boolean error = false;
boolean login = false;
String password = "";
String email = "";
String username = "";
String key = "";


while(true){
if(intext == null || intext.equals("")){
	error = true;
	errormessage += "Please write your username or email. ";
}
if(inpassword == null || inpassword.equals("")){
	error = true;
	errormessage += "Please write your password. ";
}
//more errors
if(error) break;//error redirect #1

// if(intext.equals("") || inpassword.equals("")) response.sendRedirect(loginVersion);
// else{
intext = intext.trim();//Gordie's probably gonna throw spaces on it
//out.println(intext);
//out.println(password);
boolean emailtruth = false;//if it is true that user input an email

//open SQL
String url ="";
java.sql.Connection conn = null;
Class.forName("com.mysql.jdbc.Driver").newInstance();
url = "jdbc:mysql://localhost:3306/cpardee";   //your db ex) ljadow
conn = DriverManager.getConnection(url, "cpardee", "hello57"); //mysql id &  pwd


//String loginversion ="twitter-signin-chris-02.jsp";

//error checks below
//two queries, one for email, one for username
//check to see if it was a username or an email
java.sql.Statement st = conn.createStatement();
String loginquery = "";//this is the select username, email, pwd from table

if(intext.contains("@") && (intext.contains(".com") || intext.contains(".net") || intext.contains(".gov") || intext.contains(".info") || intext.contains(".edu") || intext.contains(".org")))
{//assume it's an email -- seems easily breakable, use ors and all the possible .com extensions and have it be aware that the .com substring has to end the string
	loginquery = ("select username, email, pwd, userID from cpardee.user_t where email = \""+intext+"\"");//the query
	emailtruth = true;
}
else//it's a username
{
	loginquery = ("select username, email, pwd, userID from cpardee.user_t where username = \""+intext+"\"");
}

java.sql.ResultSet rs = st.executeQuery(loginquery);//username/email, password from table

while(rs.next())
{
	password = rs.getString("pwd");
	email = rs.getString("email");
	username = rs.getString("username");
	key = rs.getString("userID");
	
	if (emailtruth){//if we're dealing with an email
		if(email.equals(intext) && password.equals(inpassword)){
			//out.println("email and password match!");
			login = true;
			break;
		}
		else{
		 errormessage += "email and password do not match.";
		 error = true;
		}
	}
	else
	{//if we're dealing with a username
		if(username.equals(intext) && password.equals(inpassword)){
			//out.println("username and password match!");	
			login = true;
			break;
			//redirect to twitter-home and pass their userID as the key
		}
		else {
			errormessage += "username and password do not match.";
		 	error = true;
		 	}
	}//end else
	

	//put all other error messages here
	if(error) break;// <-- why the fuck can I not have an error here??
	
	//}//end greater else
	
}//end while next
	if(error) break;
	if (login) break;
}//end while true
if(error) response.sendRedirect(loginVersion+"?logerror="+errormessage);
else if (login){
		//set the email, username, password, and key to session variables
		session.setAttribute("session[password]", password);
		session.setAttribute("session[email]", email);
		session.setAttribute("session[username]", username);
		session.setAttribute("session[key]", key);
		//redirect to twitter home with your key
		response.sendRedirect(twitterVersion+"?key="+key);
	}

//everything(); 





//--Sign up--\\
%>