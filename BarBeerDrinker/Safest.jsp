<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Safest Beer</title> 
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
			String state = request.getParameter("state");
			String limit = request.getParameter("limit");
			
			String query = "SELECT DISTINCT p.bar, p.beer, p.price, p.day, b.address, b.city, b.state FROM price p, bars b WHERE beer = (SELECT Beer FROM safety WHERE sanitation_issue = 'Nothing' GROUP BY Beer ORDER BY COUNT(Beer) DESC LIMIT 1)"
					+ "AND b.bars = p.bar AND b.state = '" + state + "' ORDER BY price ASC LIMIT " + limit + ";"; 
			// out.println(query);
			
			
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
			out.print("PRICE");
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
			
			// Print out the results into the table
			
			while(result.next())
			{
				out.print("<tr>");
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("p.bar"));
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("p.beer")); 
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print("$" + result.getString("p.price"));
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("p.day"));
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("b.address"));
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("b.city")); 
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("b.state")); 
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