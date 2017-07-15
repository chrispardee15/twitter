<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mysql.jdbc.*" %>


<%
	   //make an rs, stmt, and loop for each query 
	String tweet_count = "";
	String following_count = "";
	String follower_count = "";
	String key = request.getParameter("key"); 	
	String new_hashtag = "";
	
	String hashID = "";//the hashtag //I NEED TO MAKE A QUERY THAT DEALS WITH THIS
	String print_tweet = "";
	String name = "";
	String username = "";

	//String tweetID = "";
	//ArrayList<String>() tweet_log;
	//out.println(key);
	

      try {
	java.sql.Connection conn = null;
	//out.println("the key is: " + key);

         String url = "";

         //sql query:
	String tweets = "select count(*), tweetID from tweet_t where userID =" + key; //+key get all rows int he student keybase
 	String following = "select count(*) from stalker_t where follower =" +key;
 	String followers = "select count(*) from stalker_t where following =" +key;
	 //String showtweets = "select a.* from tweet_t a inner join (select * from stalker_t where follower = "+key+") b on a.userID = b.following";
	 //String username = "select username from user_t where userID = 1;";
	 String hashtag = "";
	// String q1 = "select hashID from cpardee.hashtag_t where hashtag = "+hashtag+";";
	
	 //String username = //this is not the query I want. I want the username of the userID of the tweet, needs to be something like: "select username from user_t where userID =  (select userID from tweet_t where tweetID = iterator)";
	 
	 //open sql:
         Class.forName("com.mysql.jdbc.Driver").newInstance();
         url = "jdbc:mysql://localhost:3306/cpardee";   //your db ex) ljadow
         conn = DriverManager.getConnection(url, "cpardee", "hello57"); //mysql id &  pwd
         
    //___tweet, following, follower counts___\\   //THESE SHOULD BE PREPARED STATEMENTS BC IT WILL LOOK NICER
        java.sql.Statement stmt = conn.createStatement();
		java.sql.Statement stmt1 = conn.createStatement();
		java.sql.Statement stmt2 = conn.createStatement();

		java.sql.ResultSet rsa = stmt.executeQuery(tweets);
		java.sql.ResultSet rsb = stmt1.executeQuery(following);
		java.sql.ResultSet rsc = stmt2.executeQuery(followers);

	while(rsa.next())
	{
	tweet_count = rsa.getString(1);//tweet_count
	} //end while
	
	while(rsb.next())
	{
	following_count = rsb.getString(1); //following_count
	}//end while
	while(rsc.next())
	{
	follower_count = rsc.getString(1);
	}//end while
         
         
   // _______Working base______     \\
    //1. need the name of the person who tweeted (you literally just passed the key dude, like just take that in)
	java.sql.PreparedStatement ps = conn.prepareStatement("select name from cpardee.user_t where userID = (select userID from cpardee.tweet_t where tweetID = ?)");
	
	//2. select the username of the person
	java.sql.PreparedStatement ps1 = conn.prepareStatement("select username from cpardee.user_t where userID = (select userID from cpardee.tweet_t where tweetID = ?)");
	
	//3. select the tweetID of the hashid that you have passed (MAJOR LOOP)
	java.sql.PreparedStatement ps2 = conn.prepareStatement("select tweetID from cpardee.hash_tweet_rel where hashID = ?");
	ps2.setString(1,hashID);
	//4. select the tweet where the tweetID is the thing you just got 
	java.sql.PreparedStatement ps3 = conn.prepareStatement("select tweet from cpardee.tweet_t where tweetID = ?");
	
	//MAJOR LOOP
	java.sql.ResultSet rs2 = ps2.executeQuery();//tweet ID

	
	while(rs2.next())//loops thru all the tweet ids
	{	ps.setString(1,rs2.getString("tweetID"));
		ps1.setString(1,rs2.getString("tweetID"));
		ps3.setString(1,rs2.getString("tweetID"));
		
		java.sql.ResultSet rs3 = ps3.executeQuery();//tweet text
		while(rs3.next())
		{
			print_tweet = rs3.getString("tweet");
		}
		
		java.sql.ResultSet rs = ps.executeQuery();//full name
		 while(rs.next())
 		{ 	
 		name = rs.getString("name");
		}
		java.sql.Statement cp1 = conn.createStatement(); 
		java.sql.ResultSet rs1 = ps1.executeQuery();//username
		while(rs1.next())
		{
		username = rs1.getString("username");
		}
		
			
		/////
			//select hash_id from hash_table where hashtag = array[i]
			//if it contains a hashtag
			String[] words = print_tweet.split(" ");
			String output = ""; //the text that goes into the tweet
			for(int i =0; i<words.length; i++)
			{
			//out.println("current word: " + words[i]);
			//out.println("current word @ 0: " +words[i].charAt(0));
		
		
			//if(words[i].charAt(0) == '#') out.println("HEY!!!!!");
				if(words[i].charAt(0) == '#')
				{
		
					new_hashtag = words[i].substring(1);
					String new_hashID = "";
					String q1 = "select hashID from cpardee.hashtag_t where hashtag=" +  "'" + new_hashtag + "'";
				
					//out.println(q1);
					rs3 = cp1.executeQuery(q1);
				
						while(rs3.next())
						{
							new_hashID = rs3.getString("hashID");
						
							//out.println("the hashid is: " + new_hashID);
							//out.println("the username is "+username);
						}//end while
		
					output = output +"<a href = 'twitter-hashtags.jsp?hashID=" + new_hashID + "&key=" + key + "'" + "> " + words[i] + "</a>";
		
				}//end if
			
				else
				{
						output = output +" "+ words[i];
				}
			}//end for
		
		
			%>
			
							<!-- start tweet -->
							<div class="js-stream-item stream-item expanding-string-item">
								<div class="tweet original-tweet">
									<div class="content">
										<div class="stream-item-header">
											<small class="time">
												<a href="#" class="tweet-timestamp" title="10:15am - 16 Nov 12">
													<span class="_timestamp">6m</span>
												</a>
											</small>
											<a class="account-group">
												<img class="avatar" src="images/obama.png" alt="Barak Obama">
												<strong class="fullname"><%=name%></strong>
												<span>&rlm;</span>
												<span class="username">
													<s>@</s>
													<b><%=username%></b> 
												</span>
											</a>
										</div>
										<p class="js-tweet-text">
										  <%=output%>
											<a href="http://t.co/xOqdhPgH" class="twitter-timeline-link" target="_blank" title="http://OFA.BO/xRSG9n" dir="ltr">
												<span class="invisible">http://</span>
												<!-- <span class="js-display-url">OFA.BO/xRSG9n</span> -->
												<span class="invisible"></span>
												<span class="tco-ellipsis">
													<span class="invisible">&nbsp;</span>
												</span>
											</a>
										</p>
									</div>
								</a>
									<div class="expanded-content js-tweet-details-dropdown"></div>
								</div>
							</div><!-- end tweet -->
	<% //}//end while loop (username)
		}//end while (ps3)
		
	%>
			
						</div>
						<div class="stream-footer"></div>
						<div class="hidden-replies-container"></div>
						<div class="stream-autoplay-marker"></div>
					</div>
					</div>
			   
				</div>
			</div>
		</div>
		 <!-- Le javascript
		================================================== -->
		<!-- Placed at the end of the document so the pages load faster -->
		 <script type="text/javascript" src="js/main-ck.js"></script>
	  </body>
	</html>

	<%
} 
	  catch (Exception e) 
	  {
		 out.println(e);
	  }
	
%>