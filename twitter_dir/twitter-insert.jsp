<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mysql.jdbc.*" %>

<%/*

1. insert tweet
2. parse tweet & check if it has hashtags that aren’t in the table (split & loop)
if doesn’t exist, then insert
if does exist, don’t insert
3. Get tweetID that was just inserted (select max tweetID)
4. Loop to get the hashIDs again, and insert those with the tweetID that was just inserted
5. Go back to twitter-home with key (URL Redirect**look that up**)

*/
//String insQ = "";
String key = request.getParameter("key");//the userID
String tweet = request.getParameter("tweet").trim().replaceAll(" +", " ");//the tweet text 
//^got from http://stackoverflow.com/questions/2932392/java-how-to-replace-2-or-more-spaces-with-single-space-in-string-and-delete-lead
//String submittext = "hello";
String redirectURL = "";


    if(tweet.length()!=0){
	try {

	int status = 0;					//holds status for successful insertion
    java.sql.Connection conn = null;
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    String url = "jdbc:mysql://127.0.0.1/cpardee";			//location and name of database
	String userid = "cpardee";
	String password = "hello57";
	
	
	//String fname = request.getParameter("first_name") ;//read param, set to local variable

    conn = DriverManager.getConnection(url, userid, password);	//connect to database
	// 1. insert tweet (raw data, no split)
	java.sql.PreparedStatement ps = conn.prepareStatement("insert into tweet_t (tweet,userID) values (?,?)");//column name AS IT IS IN THE DATABASE
	ps.setString (1,tweet);
	ps.setString (2,key);//1, key
	status = ps.executeUpdate();					//attempt insert; 2, tweet
	
// 2. parse tweet & check if it has hashtags that aren’t in the table (split & loop)

String[] words = tweet.split(" ");//split @ spaces

for(int i = 0; i<words.length; i++){//iterate over each word
out.println(words[i]);
	if(words[i].charAt(0)== '#'){//if the first character of the word is a hashtag
	//out.println("heyo");
	String hash = words[i].substring(1,words[i].length());//the name of the hashtag without the # symbol
	// String gethashID = "select hashID from hashtag_t where hashtag = '"+hash+"';";//this query works
// 	//out.println("heeyyy"+gethashID);
// 	java.sql.Statement stmt = conn.createStatement();
	//java.sql.PreparedStatement ps2 = conn.prepareStatement("select hashID from from hashtag_t where hashtag = ? ");
	java.sql.PreparedStatement ps2 = conn.prepareStatement("select hashID from cpardee.hashtag_t where hashtag=?");
	ps2.setString(1,hash);
 	java.sql.ResultSet rs = ps2.executeQuery();//query that gets the hashid for a given hash value/name. 
	
	// java.sql.PreparedStatement ps2 = conn.prepareStatement("select hashID from hashtag_t where hashtag = '?';");
// 	ps2.setString(1,hash);
// 	String hashID = "";
	// status = ps2.executeUpdate();
// 	out.println(ps2.executeUpdate());
	
		if(!rs.next()){//this is if the hashtag doesn't currently exist
		//out.println("hi");

		java.sql.PreparedStatement ps1 = conn.prepareStatement("insert into hashtag_t (hashtag) values (?)");//column name AS IT IS IN THE DATABASE
		ps1.setString (1,hash);//1, key
		status = ps1.executeUpdate();
		}//close if
	
	}//close if
	
	}//close for
	
	// 3. Get tweetID that was just inserted (select max tweetID)
//select tweet from tweet_t where tweetID = (select max(tweetID) from tweet_t); -- gets the most recent tweet
java.sql.PreparedStatement ps5 = conn.prepareStatement("select max(tweetID) from tweet_t;");
java.sql.ResultSet rs5 = ps5.executeQuery();
while(rs5.next()){
String tID = rs5.getString(1);
//out.println(tID);

java.sql.PreparedStatement ps3 = conn.prepareStatement("select tweet from tweet_t where tweetID = "+tID+";");
//int maxtweet = ps3.executeUpdate();
java.sql.ResultSet rs2 = ps3.executeQuery();
// 4. Loop to get the hashIDs again, and insert those with the tweetID that was just inserted

while(rs2.next()){
String[] words1 = rs2.getString("tweet").split(" ");

//String hID = ""; 

for(int i =0; i<words1.length; i++){
	if(words[i].charAt(0)== '#'){
	java.sql.PreparedStatement ps6 = conn.prepareStatement("select hashID from hashtag_t where hashtag = '"+words[i].substring(1,words[i].length())+"';");
	java.sql.ResultSet rs6 = ps6.executeQuery();
	//String hID = "select hashID from hashtag_t where hashtag = "+words[i].substring(1,words[i].length())+";";//hashID
	while(rs6.next()){
	String hID = rs6.getString(1);
	//out.println(hID);
	//insert into hash_tweet_rel (tweetID, hashID) values (?,?);
	java.sql.PreparedStatement ps4 = conn.prepareStatement("insert into hash_tweet_rel (tweetID, hashID) values (?,?);");
	ps4.setString(1,tID);
	ps4.setString(2,hID);
	status = ps4.executeUpdate();
	}//end while
	}//end if
}//end for
}//end while


}//end while
redirectURL = "twitter-home.jsp?key=" + key;
                response.sendRedirect(redirectURL);

// 5. Go back to twitter-home with key (URL Redirect**look that up**)

} //close try
      	
	catch (Exception e) 
	{
        out.println("There was an error:" +  e);
        }//close catch
}//close if
else{
redirectURL = "twitter-home.jsp?key=" + key;
                response.sendRedirect(redirectURL);
}//close else
%>



