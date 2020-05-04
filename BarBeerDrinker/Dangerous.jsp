<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Most Dangerous Beer</title> 
</head>
<body>
<p>Take care!<br/><br/><br/></p>
	<%
	    
		try {
	
			String url = "jdbc:mysql://project336.c9r8cskeqxon.us-east-2.rds.amazonaws.com:3306/foo";
			
			
			Class.forName("com.mysql.jdbc.Driver");
			
			Connection con = DriverManager.getConnection(url, "project336", "project336"); 
		
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			// Parameters
			String state = request.getParameter("state"); 
			String beer = request.getParameter("beer");
			
			if (beer.contentEquals("Any") == false) // User is choosing a specific beer
			{
				
			String table_query = "SELECT * FROM safety WHERE state = '" + state + "' AND (sanitation_issue = 'Moldy Kegs' OR sanitation_issue = 'Insect infestation' OR sanitation_issue = 'Chemical leak' OR sanitation_issue = 'Rat infestation') AND beer = '" + beer + "';";
			
			ResultSet result = stmt.executeQuery(table_query); 
			
			// Printing out the table
			out.print("<table>");
			out.print("<td>");
			out.print("<center>");
			out.print("BEER");
			out.print("</center>");
			out.print("</td>");
			
			out.print("<td>");
			out.print("<center>");
			out.print("ADDRESS");
			out.print("</center>");
			out.print("</td>");
			
			out.print("<td>");
			out.print("<center>");
			out.print("SANITATION VIOLATION");
			out.print("</center>");
			out.print("</td>");
			
			out.print("<td>");
			out.print("<center>");
			out.print("DAYS SINCE INSPECTION");
			out.print("</center>");
			out.print("</td>");
			
			out.print("<td>");
			out.print("<center>");
			out.print("FIXED?");
			out.print("</center>");
			out.print("</td>");
			
			out.print("<td>");
			out.print("<center>");
			out.print("STATE");
			out.print("</center>");
			out.print("</td>");
			
			// Print out the results into the  results table
			while(result.next())
			{
				out.print("<tr>");
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("Beer"));
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("Address")); 
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("Sanitation_Issue"));
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("Days_passed"));
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("Fixed_or_not"));
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("state")); 
				out.print("</center>");
				out.print("</td>");
				out.print("</tr>");
			}
			
			out.print("</table>"); 
			
			out.print("<br>");
			out.print("<br>");
			out.print("<br>");
			out.print("<br>");
			
			// Calculate the probability of choosing a tainted beer
			String probability_query = "SET @VIOLATIONS := (SELECT COUNT(*) FROM safety WHERE state = '" + state + "' AND (sanitation_issue = 'Moldy Kegs' OR sanitation_issue = 'Insect infestation' OR sanitation_issue = 'Chemical leak' OR sanitation_issue = 'Rat infestation') AND beer = '" + beer + "');";
			String total_query		 = "SET @TOTAL := (SELECT COUNT(*) FROM safety WHERE state = '" + state + "'  AND beer = '" + beer + "');";
			String average			= "SELECT (@VIOLATIONS/@TOTAL) * 100 AS probability;"; 
			ResultSet violations = stmt.executeQuery(probability_query); 
			ResultSet total = stmt.executeQuery(total_query); 
			ResultSet probability = stmt.executeQuery(average); 
			
			// Print out the probability
			
			out.print("<table>");
			out.print("<td>");
			out.print("<center>");
			out.print("PROBABILITY OF CHOOSING A DIRTY BEER");
			out.print("</center>");
			out.print("</td>");
			
			while(probability.next())
			{
				out.print("<tr>");
				out.print("<td>");
				out.print("<center>");
				
				if (probability.getString("probability") == null)
				{
					out.print("0 percent chance");
					out.print("</center>");
					out.print("</td>");
					out.print("</tr>");
				}
				
				else
				{
				out.print(probability.getString("probability"));
				out.print("</center>");
				out.print("</td>");
				out.print("</tr>");
				}
			}
			
			out.print("</table>"); 
			

			con.close();
			
			}
			
			else if (beer.contentEquals("Any")) // User wants info for ANY beer
			{
				String table_query = "SELECT * FROM safety WHERE state = '" + state + "' AND (sanitation_issue = 'Moldy Kegs' OR sanitation_issue = 'Insect infestation' OR sanitation_issue = 'Chemical leak' OR sanitation_issue = 'Rat infestation');";
				
				ResultSet result = stmt.executeQuery(table_query); 
				
				// Printing out the table
				out.print("<table>");
				out.print("<td>");
				out.print("<center>");
				out.print("BEER");
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print("ADDRESS");
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print("SANITATION VIOLATION");
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print("DAYS SINCE INSPECTION");
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print("FIXED?");
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print("STATE");
				out.print("</center>");
				out.print("</td>");
				
				// Print out the results into the  results table
				while(result.next())
				{
					out.print("<tr>");
					out.print("<td>");
					out.print("<center>");
					out.print(result.getString("Beer"));
					out.print("</center>");
					out.print("</td>");
					
					out.print("<td>");
					out.print("<center>");
					out.print(result.getString("Address")); 
					out.print("</center>");
					out.print("</td>");
					
					out.print("<td>");
					out.print("<center>");
					out.print(result.getString("Sanitation_Issue"));
					out.print("</center>");
					out.print("</td>");
					
					out.print("<td>");
					out.print("<center>");
					out.print(result.getString("Days_passed"));
					out.print("</center>");
					out.print("</td>");
					
					out.print("<td>");
					out.print("<center>");
					out.print(result.getString("Fixed_or_not"));
					out.print("</center>");
					out.print("</td>");
					
					out.print("<td>");
					out.print("<center>");
					out.print(result.getString("state")); 
					out.print("</center>");
					out.print("</td>");
					out.print("</tr>");
				}
				
				out.print("</table>"); 
				
				out.print("<br>");
				out.print("<br>");
				out.print("<br>");
				out.print("<br>");
				
				// Calculate the probability of choosing a tainted beer
				 
				String probability_query = "SET @VIOLATIONS := (SELECT COUNT(*) FROM safety WHERE state = '" + state + "' AND (sanitation_issue = 'Moldy Kegs' OR sanitation_issue = 'Insect infestation' OR sanitation_issue = 'Chemical leak' OR sanitation_issue = 'Rat infestation'));";
				String total_query		 = "SET @TOTAL := (SELECT COUNT(*) FROM safety WHERE state = '" + state + "');";
				String average			= "SELECT (@VIOLATIONS/@TOTAL) * 100 AS probability;"; 
				ResultSet violations = stmt.executeQuery(probability_query); 
				ResultSet total = stmt.executeQuery(total_query); 
				ResultSet probability = stmt.executeQuery(average); 
				
				// Print out the probability
				
				out.print("<table>");
				out.print("<td>");
				out.print("<center>");
				out.print("PROBABILITY OF CHOOSING A DIRTY BEER");
				out.print("</center>");
				out.print("</td>");
				
				while(probability.next())
				{
					out.print("<tr>");
					out.print("<td>");
					out.print("<center>");
					
					if (probability.getString("probability") == null)
					{
						out.print("0 percent chance");
						out.print("</center>");
						out.print("</td>");
						out.print("</tr>");
					}
					
					else
					{
					out.print(probability.getString("probability"));
					out.print("</center>");
					out.print("</td>");
					out.print("</tr>");
					}
				}
				
				out.print("</table>"); 
				

				con.close();
				
			}
		} catch (Exception e) {
			out.print(e);
		}
	%>

</body>
</html> 