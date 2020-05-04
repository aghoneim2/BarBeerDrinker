<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%ResultSet resultset =null;%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Drinker's Paradise</title>
</head>
<body>

<center>
<h1><b>Welcome to Drinker's Paradise! Run a query to start and crack open a cold one with the boys (and girls)!</b></h1>
</center>
<h2> Safest Drink to Pick </h2>
<p>Are you germaphobic? Do you worry about consuming contaminated beer whenever you go out for the night? 
Don't worry. The FDA recently conducted a health investigation of all beer factories in the nation and stored the
results in a company table.</p>

The safest beer is determined by choosing the beer manufacturer that passed the greatest number of health inspections
the FDA conducted. Choose a state and number of entries you wish to view to begin.

<form method="post" action="Safest.jsp">
<%
    try{
    	String url = "jdbc:mysql://project336.c9r8cskeqxon.us-east-2.rds.amazonaws.com:3306/foo";
		Class.forName("com.mysql.jdbc.Driver");
	
		Connection con = DriverManager.getConnection(url, "project336", "project336");
		Statement statement = con.createStatement() ;
		resultset =statement.executeQuery("SELECT DISTINCT state FROM bars ORDER BY state") ;
%>

	<select name="state" size=1>
		<%  while(resultset.next()){ %>
     	<option><%= resultset.getString(1)%></option>
       	<% } %>
  	</select>
<%
		con.close();
		resultset.close();
        }catch(Exception e)
        {
             out.println(e);
        }
%>
	<select name="limit" size=1>
  			<option value="10">10</option> 
			<option value="30">30</option>
			<option value="50">50</option>
			<option value="5000">5000</option>
	</select>&nbsp; 
	<input type="submit" value="submit">  
</form> 
<br> 

<h2> Most Dangerous Drink to Pick </h2>
Run this query to get the probability of choosing a specific (or any) tainted beer to drink in your state.

The probability is determined by number of factories with health violations in your state divided by the total number
of factories in the state (this is for any beer). 

To determine the probability for a specific beer, the query does the same thing as above, except this time
it is now looking at a specific beer factory instead of any beer factory in your state.
<form method="post" action="Dangerous.jsp">

<%
    try{
    	String url = "jdbc:mysql://project336.c9r8cskeqxon.us-east-2.rds.amazonaws.com:3306/foo";
		Class.forName("com.mysql.jdbc.Driver");
	
		Connection con = DriverManager.getConnection(url, "project336", "project336");
       	Statement statement = con.createStatement() ;
       	resultset =statement.executeQuery("SELECT DISTINCT state FROM bars ORDER BY state") ;
%>
 	<select name="state" size=1>
        	<%  while(resultset.next()){ %>
            <option><%= resultset.getString(1)%></option>
      <% } %>
  	 </select>

<%
		con.close();
		resultset.close();
        }catch(Exception e)
        {
             out.println(e);
        }
%>
<%
    try{
    	String url = "jdbc:mysql://project336.c9r8cskeqxon.us-east-2.rds.amazonaws.com:3306/foo";
		Class.forName("com.mysql.jdbc.Driver");
	
		Connection con = DriverManager.getConnection(url, "project336", "project336");
       	Statement statement = con.createStatement() ;
       	resultset =statement.executeQuery("SELECT DISTINCT beer FROM price ORDER BY beer") ;
%>
	
	<select name="beer" size=1>
        	<%  while(resultset.next()){ %>
            <option><%= resultset.getString(1)%></option>
        <% } %>
        </select>
<%
		con.close();
		resultset.close();
        }catch(Exception e)
        {
             out.println(e);
        }
%>
	&nbsp; 
	<input type="submit" value="submit">  
</form>
<br>

<h2> DATE </h2>
Planning to go on a date? Are you dating a guy or a girl? What state do you live in,
and when is this date?
<form method="post" action="Date.jsp">
  <input type="radio" name="determine_gender" value="male" checked="checked"/>I'm dating a guy!
  <br>
  <input type="radio" name="determine_gender" value="female"/>I'm dating a girl!
  <br>
<%
	try{
    	String url = "jdbc:mysql://project336.c9r8cskeqxon.us-east-2.rds.amazonaws.com:3306/foo";
		Class.forName("com.mysql.jdbc.Driver");
	
		Connection con = DriverManager.getConnection(url, "project336", "project336");
       	Statement statement = con.createStatement() ;
       	resultset =statement.executeQuery("SELECT DISTINCT state FROM bars ORDER BY state") ;
%>
 <select name="state" size=1>
       		<%  while(resultset.next()){ %>
        	<option><%= resultset.getString(1)%></option>
        <% } %>
        </select>
<%
		con.close();
		resultset.close();
        }catch(Exception e)
        {
             out.println(e);
        }
%>
  	<select name="day" size=1>
  			<option value="Sunday">Sunday</option> 
			<option value="Monday">Monday</option>
			<option value="Tuesday">Tuesday</option>
			<option value="Wednesday">Wednesday</option>
			<option value="Thursday">Thursday</option>
			<option value="Friday">Friday</option>
			<option value="Saturday">Saturday</option>
	</select>&nbsp; 
    <input type="submit" value="submit">
</form>
<br>

<h2> Music </h2>

Want to discover a new genre of music with your friends (or by yourself) while doing something fun?
Pick your state, the day you're planning to hang out, and favorite beers to get started! You can also choose
how many results you wish to view, too.

<form method="post" action="Music.jsp">
<%
    try{
    	String url = "jdbc:mysql://project336.c9r8cskeqxon.us-east-2.rds.amazonaws.com:3306/foo";
		Class.forName("com.mysql.jdbc.Driver");
	
		Connection con = DriverManager.getConnection(url, "project336", "project336");
       	Statement statement = con.createStatement() ;
       	resultset =statement.executeQuery("SELECT DISTINCT state FROM bars ORDER BY state") ;
%>
<select name="state" size=1>
        	<%  while(resultset.next()){ %>
            <option><%= resultset.getString(1)%></option>
        <% } %>
        </select>
<%
		con.close();
		resultset.close();
        }catch(Exception e)
        {
             out.println(e);
        }
%>
  	<select name="day" size=1>
  			<option value="Sunday">Sunday</option> 
			<option value="Monday">Monday</option>
			<option value="Tuesday">Tuesday</option>
			<option value="Wednesday">Wednesday</option>
			<option value="Thursday">Thursday</option>
			<option value="Friday">Friday</option>
			<option value="Saturday">Saturday</option>
	</select> 
<%
    try{
    	String url = "jdbc:mysql://project336.c9r8cskeqxon.us-east-2.rds.amazonaws.com:3306/foo";
		Class.forName("com.mysql.jdbc.Driver");
	
		Connection con = DriverManager.getConnection(url, "project336", "project336");
       	Statement statement = con.createStatement() ;
       	resultset =statement.executeQuery("SELECT DISTINCT beer FROM price ORDER BY beer") ;
%>
	<select name="beer" size=1>
        	<%  while(resultset.next()){ %>
            <option><%= resultset.getString(1)%></option>
       <% } %>
       </select>
<%
		con.close();
		resultset.close();
        }catch(Exception e)
        {
             out.println(e);
        }
%>
	<select name="limit" size=1>
  			<option value="10">10</option> 
			<option value="50">50</option>
			<option value="100">100</option>
			<option value="10000">10000</option> 
	</select>&nbsp;
	<input type="submit" value="submit"> 


</form>
<br>

<h2> Special Activities </h2>

Want to hang out with a group of friends (or by yourself), but not sure what you want to do? Pick your 
state, day of the week you want to hang out, and favorite beer to get started! You can also choose how
many results you wish to view, too.

<form method="post" action="Activities.jsp">
<%
    try{
    	String url = "jdbc:mysql://project336.c9r8cskeqxon.us-east-2.rds.amazonaws.com:3306/foo";
		Class.forName("com.mysql.jdbc.Driver");
	
		Connection con = DriverManager.getConnection(url, "project336", "project336");
       	Statement statement = con.createStatement() ;
       	resultset =statement.executeQuery("SELECT DISTINCT state FROM bars ORDER BY state") ;
%>
<select name="state" size=1>
        	<%  while(resultset.next()){ %>
            <option><%= resultset.getString(1)%></option>
        <% } %>
        </select>
<%
		con.close();
		resultset.close();
        }catch(Exception e)
        {
             out.println(e);
        }
%>
  	<select name="day" size=1>
  			<option value="Sunday">Sunday</option> 
			<option value="Monday">Monday</option>
			<option value="Tuesday">Tuesday</option>
			<option value="Wednesday">Wednesday</option>
			<option value="Thursday">Thursday</option>
			<option value="Friday">Friday</option>
			<option value="Saturday">Saturday</option>
	</select> 
<%
    try{
    	String url = "jdbc:mysql://project336.c9r8cskeqxon.us-east-2.rds.amazonaws.com:3306/foo";
		Class.forName("com.mysql.jdbc.Driver");
	
		Connection con = DriverManager.getConnection(url, "project336", "project336");
       	Statement statement = con.createStatement() ;
       	resultset =statement.executeQuery("SELECT DISTINCT beer FROM price ORDER BY beer") ;
%>
	<select name="beer" size=1>
        	<%  while(resultset.next()){ %>
            <option><%= resultset.getString(1)%></option>
       <% } %>
       </select>
<%
		con.close();
		resultset.close();
        }catch(Exception e)
        {
             out.println(e);
        }
%>
	<select name="limit" size=1>
  			<option value="10">10</option> 
			<option value="50">50</option>
			<option value="100">100</option>
			<option value="10000">10000</option> 
	</select>&nbsp;
	<input type="submit" value="submit"> 
</form>
<br>

<h2> Care to Subscribe? </h2>

Interested in subscribing to our monthly catalog? Fill in the following information below if you want 
to have a copy of <em>Drinker's Paradise</em> mailed to your house, <b>free of charge</b>!

<form method="post" action="Subscribe.jsp">
<table>
<tr>    
<td>First Name</td><td><input type="text" name="first"></td> 
</tr>
<tr>
<td>Last Name</td><td><input type="text" name="last"></td>
</tr>
<tr>
<td>Address</td><td><input type="text" name="address"></td>
</tr>
<tr>
<td>City</td><td><input type="text" name="city"></td>
</tr>
</table>

<input type="radio" name="determine_gender" value="Male" checked="checked"/>I'm a guy!
<br>
<input type="radio" name="determine_gender" value="Female"/>I'm a girl!
<br>

<%
    try{
    	String url = "jdbc:mysql://project336.c9r8cskeqxon.us-east-2.rds.amazonaws.com:3306/foo";
		Class.forName("com.mysql.jdbc.Driver");
	
		Connection con = DriverManager.getConnection(url, "project336", "project336");
       	Statement statement = con.createStatement() ;
       	resultset =statement.executeQuery("SELECT DISTINCT beer FROM price ORDER BY beer") ;
%>
	<select name="beer" size=1>
        	<%  while(resultset.next()){ %>
            <option><%= resultset.getString(1)%></option>
        <% } %>
        </select>
<%
		con.close();
		resultset.close();
        }catch(Exception e)
        {
             out.println(e);
        }
%>
<%
    try{
    	String url = "jdbc:mysql://project336.c9r8cskeqxon.us-east-2.rds.amazonaws.com:3306/foo";
		Class.forName("com.mysql.jdbc.Driver");
	
		Connection con = DriverManager.getConnection(url, "project336", "project336");
       	Statement statement = con.createStatement() ;
       	resultset =statement.executeQuery("SELECT DISTINCT state FROM bars ORDER BY state") ;
%>
 	<select name="state" size=1>
        	<%  while(resultset.next()){ %>
            <option><%= resultset.getString(1)%></option>
        <% } %>
   	</select>
<%
		con.close();
		resultset.close();
        }catch(Exception e)
        {
             out.println(e);
        }
%>
&nbsp;
<input type="submit" value="submit"> 

</form>
<br>

<h2> Verification </h2>

"Run" this query for verification purposes. The average price of beers for the weekday should be less than
the average price of beers for the weekend.
<form method="post" action="Verify.jsp">
	<input type="submit" value="submit">
</form>
<br>

<h2> Ranking of all bars </h2>
<p>
Want to figure out which bar is the best one to visit? Is Yelp to hard to understand? Well, you are in luck!
Recently, the Bar Quarterly released its all famous ranking of the top bar locations in the country. We at Drinker's 
Paradise have saved you time and effort and compiled all ranked bars in one place! Now you can look up any bar ranked
by the quarterly and see its score. 
<br>Just choose a state to see where the best bars are located.
<%
    try{
    	String url = "jdbc:mysql://project336.c9r8cskeqxon.us-east-2.rds.amazonaws.com:3306/foo";
		Class.forName("com.mysql.jdbc.Driver");
	
		Connection con = DriverManager.getConnection(url, "project336", "project336");
       	Statement statement = con.createStatement() ;
       	resultset =statement.executeQuery("SELECT DISTINCT state FROM bars ORDER BY state") ;
%>
</p>
<form method="post" action="Ranking.jsp">

 	<select name="state" size=1>
        <%  while(resultset.next()){ %>
            <option><%= resultset.getString(1)%></option>
        <% } %>
  	</select>
<%
		con.close();
		resultset.close();
        }catch(Exception e)
        {
             out.println(e);
        }
%>
	&nbsp; 
	<input type="submit" value="submit">  
</form>
<br>

<h2> Updating Information </h2>
<p> Are you an avid user in our website? Are you an owner for one of the bar-chains listed on this website?
Do you see a problem with some of the prices? 
Well, now you can edit the price here for everyone to see!
Simply choose the bar-chain, the day to edit the price and enter the price you want.
The edit is instant and other users will see the correct prices immediately! 
<br/>To update, please a bar and beer and enter the correct price between $1 and $9.</p>

<form method="post" action="EditPrice.jsp">
<br>
<%
    try{
    	String url = "jdbc:mysql://project336.c9r8cskeqxon.us-east-2.rds.amazonaws.com:3306/foo";
		Class.forName("com.mysql.jdbc.Driver");
	
		Connection con = DriverManager.getConnection(url, "project336", "project336");
       	Statement statement = con.createStatement() ;
       	resultset =statement.executeQuery("SELECT DISTINCT beer FROM price ORDER BY beer") ;
%>
	<select name="beer" size=1>
        	<%  while(resultset.next()){ %>
            <option><%= resultset.getString(1)%></option>
        <% } %>
        </select>
<%
		con.close();
		resultset.close();
        }catch(Exception e)
        {
             out.println(e);
        }
%>
<%
    try{
    	String url = "jdbc:mysql://project336.c9r8cskeqxon.us-east-2.rds.amazonaws.com:3306/foo";
		Class.forName("com.mysql.jdbc.Driver");
	
		Connection con = DriverManager.getConnection(url, "project336", "project336");
       	Statement statement = con.createStatement() ;
       	resultset =statement.executeQuery("SELECT DISTINCT bar FROM price ORDER BY bar") ;
%>
 	<select name="bar" size=1>
        	<%  while(resultset.next()){ %>
            <option><%= resultset.getString(1)%></option>
        <% } %>
   	</select>
<%
		con.close();
		resultset.close();
        }catch(Exception e)
        {
             out.println(e);
        }
%>
 	<select name="day" size=1>
  			<option value="Sunday">Sunday</option> 
			<option value="Monday">Monday</option>
			<option value="Tuesday">Tuesday</option>
			<option value="Wednesday">Wednesday</option>
			<option value="Thursday">Thursday</option>
			<option value="Friday">Friday</option>
			<option value="Saturday">Saturday</option>
	</select> 
	
	<input type="number" name="price" min="1" max = "9"/>
 	
&nbsp;
<input type="submit" value="submit"> 

</form>
<br>

</body>
</html>