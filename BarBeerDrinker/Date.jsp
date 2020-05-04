<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Your Date</title>
</head>
<body>
	<%
	    
		try {
	
		String url = "jdbc:mysql://project336.c9r8cskeqxon.us-east-2.rds.amazonaws.com:3306/foo";
			
		
		Class.forName("com.mysql.jdbc.Driver");
		
		Connection con = DriverManager.getConnection(url, "project336", "project336");
	

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			// Parameters
			String gender = request.getParameter("determine_gender");
			String state = request.getParameter("state");
			String day = request.getParameter("day");
			
			out.println("Looks like you are dating a " + gender + " on a " + day + "!");
			out.println("Here's a list of the most popular beer " + gender + 
					"s likes and bars that serve them in " + state + ".");
			out.println("Hope you have fun! :)");
			out.print("<br/><br/>");
			
			String query = "SELECT DISTINCT bars, address, day, beer, price, city FROM price, bars WHERE state = '" + state + "' AND beer = (SELECT DISTINCT beerLiked FROM people WHERE gender = '" + gender + "' GROUP BY beerLiked ORDER BY COUNT(beerLiked) DESC LIMIT 1) AND day = '" + day + "' AND bars = bar LIMIT 50;";
			
			ResultSet result = stmt.executeQuery(query); 
			
			// Printing out the table
			out.print("<table>");
			out.print("<td>");
			out.print("<center>");
			out.print("BAR");
			out.print("</center>");
			out.print("</td>");
			
			out.print("<td>");
			out.print("<center>");
			out.print("ADDRESS");
			out.print("</center>");
			out.print("</td>");
			
			out.print("<td>");
			out.print("<center>");
			out.print("DAY");
			out.print("</center>");
			out.print("</td>");
			
			out.print("<td>");
			out.print("<center>");
			out.print("BEER");
			out.print("</center>");
			out.print("</td>");
			
			out.print("<td>");
			out.print("<center>");
			out.print("PRICE");
			out.print("</center>");
			out.print("</td>");
			
			out.print("<td>");
			out.print("<center>");
			out.print("CITY");
			out.print("</center>");
			out.print("</td>");
			
			// Print out the results into the table
			
			while(result.next())
			{
				out.print("<tr>");
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("bars"));
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("address")); 
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("day"));
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("beer"));
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print("$" + result.getString("price"));
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("city")); 
				out.print("</center>");
				out.print("</td>");
				out.print("</tr>");
			}
			
			out.print("</table>");

			con.close();
		} catch (Exception e) {
			out.print(e);
		}
	%>

</body>
</html> 