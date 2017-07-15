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
//COPY/BACKUP OF TWITTER HOME MADE ON 5/13/15
//THIS VERSION HAS WORKING TWEET INPUT BUT NO LOG IN, TWEET LOOPING BUG HAS BEEN FIXED, THE OUTPUT HAS BEEN CLEANSED FOR JAVASCRIPT CODE
//I'm adding session variables to this one

	//the session variables are basically invisible things that you pass in the url (you don't but it's the same thing)
	//test session vars after correct signin
	
	//THESE WORK! THAT MEANS THE SESSION VARIABLES ARE WORKING!!!
	//
	//out.println("your email is "+session.getAttribute("session[email]")); 
	//out.println("your username is "+session.getAttribute("session[username]"));
	//out.println("your key is "+session.getAttribute("session[key]"));
	//out.println("your password is "+session.getAttribute("session[password]")); //<-- not sure if this should even get passed for security reasons
	
	
	//HOW TO USE THE SESSION VARIABLES!!
	//IT ONLY LETS YOU TWEET IF YOUR SESSION[KEY] IS THE SAME AS THE KEY IN THE URL --> that's just an if
	//FOLLOW BUTTON ONLY SHOWS UP IF THE SESSION[KEY] IS DIFFERENT THAN THE URL KEY
	//CLICK THE FOLLOW BUTTON --> FORM PASSES SHIT TO A BACK END (MIGHT NEED A NEW JSP) TO DO AN INSERTION
		//IN THE INSERTION, CHECK TO SEE IF THE FOLLOW ALREADY EXISTS IN THE TABLE BEFORE INSERTING
	

	//make an rs, stmt, and loop for each query 
	String tweet_count = "";
	String following_count = "";
	String follower_count = "";
	String key = request.getParameter("key"); 	
	String new_hashtag = "";
	String followversion = "twitter-follower-chris-01.jsp";
	String logoutversion = "twitter-logout-chris-01.jsp";
	//String output = "";
	//String print_username = "";
	//boolean mytweets = false;//if the user clicks the tweet count link, mytweets becomes true and the page displays only their tweets
	//^code this later
	
	String hashID = "";//the hashtag //I NEED TO MAKE A QUERY THAT DEALS WITH THIS
	String print_tweet = "";
	String name = "";
	String username = "";
	String profname = "";//the name of the person whose profile you're looking at
	boolean youfollow = false;
	ArrayList<Integer> pplyoufollow = new ArrayList<Integer>();

	//String tweetID = "";
	//ArrayList<String>() tweet_log;
	//out.println(key);
%>

<%
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
		
		java.sql.PreparedStatement psq = conn.prepareStatement("select name from cpardee.user_t where userID = ?");//the profile user name
		psq.setString(1,key);
		
		

		java.sql.ResultSet rsa = stmt.executeQuery(tweets);
		java.sql.ResultSet rsb = stmt1.executeQuery(following);
		java.sql.ResultSet rsc = stmt2.executeQuery(followers);
		java.sql.ResultSet rsq = psq.executeQuery();
		

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
	while(rsq.next())
	{
	profname = rsq.getString(1);
	}//end while
	
	java.sql.PreparedStatement psz = conn.prepareStatement("select following from cpardee.stalker_t where follower = ?");//all people who (you) the person logged in is following
	psz.setString(1, session.getAttribute("session[key]").toString());
	java.sql.ResultSet rsz = psz.executeQuery();
	
	while(rsz.next())
	{
	//populate an arraylist with all the people you follow and deal with it later
		pplyoufollow.add(rsz.getInt(1));
		//out.println(rsz.getInt(1));
		//out.println(session.getAttribute("session[key]").toString());
	}//end while
	
	//out.println("ppl you follow: "+pplyoufollow);
	
	//check to see if you follow the person whose page you're on
	if(pplyoufollow.contains(Integer.parseInt(key))) youfollow = true;//if the current page's key is in the list of ppl you follow then you're following that person
	//^works!!
	//out.println(youfollow);
        		
			%>


<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <meta name="description" content="">
    <meta name="author" content="">
    <style type="text/css">
    	body {
    		padding-top: 60px;
    		padding-bottom: 40px;
    	}
    	.sidebar-nav {
    		padding: 9px 0;
    	}
    </style>    
    <link rel="stylesheet" href="css/gordy_bootstrap.min.css">
</head>
<body class="user-style-theme1">
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
                <i class="nav-home"></i> <a href="#" class="brand">!Twitter</a>
				<div class="nav-collapse collapse">
					<p class="navbar-text pull-right">Logged in as <a href="#" class="navbar-link"><%=session.getAttribute("session[username]")%></a>
					</p>
					<ul class="nav">
						<li class="active"><a href="index.html">Home</a></li>
						<li><a href="queries.html">Test Queries</a></li>
						<li><a href="twitter-signin.html">Main sign-in</a></li>
					</ul>
				</div><!--/ .nav-collapse -->
			</div>
		</div>
	</div>

    <div class="container wrap">
        <div class="row">

            <!-- left column -->
            <div class="span4" id="secondary">
                <div class="module mini-profile">
                    <div class="content">
                        <div class="account-group">
                            <a href="#">
                                <img class="avatar size32" src="images/pirate_normal.jpg" alt="Gordy">
                                <b class="fullname"><%=profname%></b>
                                <small class="metadata">View my profile page</small>
                            </a>
                        </div>
                    </div>
                    <div class="js-mini-profile-stats-container">
                        <ul class="stats">
                            <li><a href="#"><strong><%=tweet_count%></strong>Tweets</a></li>
                            <li><a href="twitter-following.html"><strong><%=following_count%></strong>Following</a></li>
                            <li><a href="#"><strong><%=follower_count%></strong>Followers</a></li>
                        </ul>
                    </div>
                <%
                //out.println("key is "+key);
                if(key.equals(session.getAttribute("session[key]")))//if the page you're on is the page of the person logged in (YOUR page)
                {//you can only tweet on your page
                %>
                    <form action = "twitter-insert-chris-3.jsp" method = "POST"> <!--Tweet Submission-->
                        <textarea name = "tweet" class="tweet-box" maxlength = "140" placeholder="Compose new Tweet..." id="tweet-box-mini-home-profile"></textarea>
                        <input type="hidden" name="key" value = <%=key%>>
                        <input type="submit" value = "Submit"> 
                      <!--  <form action="twitter-insert.jsp" method = "post"> -->
                    </form> 
                <%
                }
                else//if they're different, the follow button should show up if you are not following the person
                {
                	//mysql query --> if you're following
                	//show the follow button if you're not following, but unfollow button if you are
                	//query for get all ppl you're following: select following from cpardee.stalker_t where follower = session key;
                	if(!youfollow)
                	{//if you're not folllowing, show follow button
                	%>
                	<form action = <%=followversion%> method = "post"> <!--pass vars to follow backend-->
                	<input type="hidden" name="key" value = <%=key%>>
                	<input type="hidden" name="youfollow" value = <%=youfollow%>>
                	<button type = "submit" value = "Follow">Follow</button>
                	</form>
                <%
                	}
                	else//if youfollow == true
                	{
                %>
               		<form action = <%=followversion%> method = "post"> <!--pass vars to follow backend-->
                	<input type="hidden" name="key" value = <%=key%>>
                	<input type="hidden" name="youfollow" value = <%=youfollow%>>
                	<button type = "submit" value = "Unfollow">Unfollow</button>
                	</form>
                <%
               		}
                }
                %>    
                </div>

                <div class="module other-side-content">
                    <div class="content">
                        <form action =<%=logoutversion%> method = "post">
                        <input type="hidden" name="logout" value = "true">
                        <button type = "submit" value="Log out">Log out</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- right column -->
            <div class="span8 content-main">
                <div class="module">
                    <div class="content-header">
                        <div class="header-inner">
                            <h2 class="js-timeline-title">Tweets</h2>
                        </div>
                    </div>

                    <!-- new tweets alert -->
                    <div class="stream-item hidden">
                        <div class="new-tweets-bar js-new-tweets-bar well">
                            2 new Tweets
                        </div>
                    </div>

                    <!-- all tweets -->
                    <div class="stream home-stream">
                    
    <%
     //Tweet Loop \\
 	//key is the follower/user logged in
 	
	//tweets of following (person being followed)
	java.sql.PreparedStatement ps = conn.prepareStatement("select distinct tweet, tweetID from cpardee.tweet_t, cpardee.stalker_t where ((cpardee.tweet_t.userID = cpardee.stalker_t.following and cpardee.stalker_t.follower = ?) or cpardee.tweet_t.userID = ?)");
	ps.setString(1,key);
	ps.setString(2,key);
	//username of following
	java.sql.PreparedStatement ps1 = conn.prepareStatement("select username from cpardee.user_t, cpardee.tweet_t where cpardee.tweet_t.userID = cpardee.user_t.userID and cpardee.tweet_t.tweetID = ?");
	//name of following
	java.sql.PreparedStatement ps2 = conn.prepareStatement("select name from cpardee.user_t, cpardee.tweet_t where cpardee.tweet_t.userID = cpardee.user_t.userID and cpardee.tweet_t.tweetID = ?");
	
	java.sql.ResultSet rs = ps.executeQuery();//tweets of following (MASTER LOOP)
	
	while(rs.next())//loops thru all the tweets/tweetIDs
	{	
		//	out.println("hey");
		ps1.setString(1,rs.getString("tweetID"));//username of following (tweeter)
		ps2.setString(1,rs.getString("tweetID"));//name of following (tweeter)
		print_tweet = rs.getString("tweet");
		
		java.sql.ResultSet rs1 = ps1.executeQuery();//tweet text
		
		//out.println("yo");
		while(rs1.next())//username
		{
			username = rs1.getString("username");
		}
		
		java.sql.ResultSet rs2 = ps2.executeQuery();//full name
		while(rs2.next())
 		{ 	
 			name = rs2.getString("name");
		}
		java.sql.Statement cp1 = conn.createStatement(); 
		//not sure what ^ this is for...
		
		//below needs to be edited\\
			
		/////
			//select hash_id from hash_table where hashtag = array[i]
			//if it contains a hashtag
			String[] words = print_tweet.split(" ");
			String output = ""; //the text that goes into the tweet
			for(int i =0; i<words.length; i++)//optimizes the tweet text for output
			{
			//out.println("yo");
			//out.println("current word: " + words[i]);
			//out.println("current word @ 0: " +words[i].charAt(0));
			//if(words[i].charAt(0) == '#') out.println("HEY!!!!!");
			
				//CLEANSE OUTPUT -- No Javascript!! -- (Check to see how twitter handles this!)
				words[i] = words[i].replaceAll("<","&lt");
 				words[i] = words[i].replaceAll(">","&gt");
			
				
				if(words[i].charAt(0) == '#')//this loop deals with hashtags
				{
					new_hashtag = words[i].substring(1);
					String new_hashID = "";
					String q1 = "select hashID from cpardee.hashtag_t where hashtag=" +  "'" + new_hashtag + "'";
				
					//out.println(q1);
					java.sql.ResultSet rs3 = cp1.executeQuery(q1);//grabs hashIDs of any hashtags in the current tweet
				
						while(rs3.next())//gets the hashids
						{
							new_hashID = rs3.getString("hashID");
						
							//out.println("the hashid is: " + new_hashID);
							//out.println("the username is "+username);
						}//end while
		
					output = output +"<a href = 'twitter-hashtags.jsp?hashID=" + new_hashID + "&key=" + key + "'" + "> " + words[i] + "</a>";
					//out.println(output);
					//out.println(key);
					//output is the tweet text that goes into the html, it needs to be cleansed
				}//end if
			
				else
				{
						output = output +" "+ words[i];
				}
			}//end for (optimizing output)
			//out.println("_"+username);
			
			
                    
    
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
                        
        <%
          }//end while (tweet text)              
                        
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
} //close try
	  catch (Exception e) 
	  {
		 out.println(e);
	  }
%>