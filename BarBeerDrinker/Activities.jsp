<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Special Activities</title> 
</head>
<body>
	<%
	    
		try {
	
		String url = "jdbc:mysql://project336.c9r8cskeqxon.us-east-2.rds.amazonaws.com:3306/foo";
			
		
		Class.forName("com.mysql.jdbc.Driver");
		
		Connection con = DriverManager.getConnection(url, "project336", "project336");
		
		out.println("Have fun!");	
		out.println("<br>");
		out.println("<br>");
		out.println("<br>"); 
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			// Parameters
			String state = request.getParameter("state");
			String day = request.getParameter("day");
			String limit = request.getParameter("limit");
			String beer = request.getParameter("beer");
			
			String query = "SELECT DISTINCT o.*, p.beer, p.day FROM price p, (SELECT bars, address, city, state, special_activities FROM activities INNER JOIN bars ON bars.barID=activities.barID WHERE state = '" + state + "' ORDER BY city) as o WHERE p.beer = '" + beer + "' AND p.day = '" + day + "' LIMIT " + limit + ";";

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
			out.print("BEER");
			out.print("</center>");
			out.print("</td>");
			
			out.print("<td>");
			out.print("<center>");
			out.print("DAY");
			out.print("</center>");
			out.print("</td>");
			
			out.print("<td>");
			out.print("<center>");
			out.print("ADDRESS");
			out.print("</center>");
			out.print("</td>");
			
			out.print("<td>");
			out.print("<center>");
			out.print("CITY");
			out.print("</center>");
			out.print("</td>");
			
			out.print("<td>");
			out.print("<center>");
			out.print("STATE");
			out.print("</center>");
			out.print("</td>");
			
			out.print("<td>");
			out.print("<center>");
			out.print("SPECIAL ACTIVITY");
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
				out.print(result.getString("beer")); 
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("day"));
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("address"));
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("city")); 
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("state")); 
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("special_activities")); 
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