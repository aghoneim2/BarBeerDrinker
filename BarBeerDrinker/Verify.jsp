<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>VERIFICATION STATUS</title> 
</head>
<body>
	<%
	    
		try {
	
		String url = "jdbc:mysql://project336.c9r8cskeqxon.us-east-2.rds.amazonaws.com:3306/foo";
			
		
		Class.forName("com.mysql.jdbc.Driver");
		
		Connection con = DriverManager.getConnection(url, "project336", "project336");
		
			//Create a SQL statement
			Statement stmt = con.createStatement();
			Statement stmt1 = con.createStatement();
			Statement stmt2 = con.createStatement();
			Statement stmt3 = con.createStatement();
			
			// THIS PART IS VERIFYING THE PATTERN I.E. PRINTING OUT TRUE
			
			// Parameters
			String query_weekday = "SET @weekdays := ((SELECT DISTINCT sum(avg_price_weekdays) / 18.0 FROM (SELECT avg(price) AS avg_price_weekdays FROM price WHERE day = 'Monday' OR day = 'Tuesday' OR day = 'Wednesday' OR day = 'Thursday' OR day = 'Friday' GROUP BY beer) t));";
			String query_weekend="SET @weekends := ((SELECT DISTINCT sum(avg_price_weekends) / 18.0 FROM (SELECT avg(price) AS avg_price_weekends FROM price WHERE day = 'Saturday' OR day = 'Sunday' GROUP BY beer) t));";
			ResultSet result_weekday = stmt.executeQuery(query_weekday); 
			

			ResultSet result_weekend = stmt1.executeQuery(query_weekend);
			
			
			
			
			String verify = "SELECT IF (@weekdays <= @weekends, 'true', 'false') AS verification;"; 
			ResultSet result_verify = stmt2.executeQuery(verify);
			
			
			// Printing out the table for verification (should always print true)
			out.print("<table>");
			out.print("<td>");
			out.print("<center>");
			out.print("IS AVERAGE FOR WEEKDAYS <= AVERAGE FOR WEEKENDS?");
			out.print("</center>");
			out.print("</td>");
			
			
			// Print out the weekday into the table
			while(result_verify.next())
			{
				out.print("<tr>");
				out.print("<td>");
				out.print("<center>");
				out.print(result_verify.getString("verification"));
				out.print("</center>");
				out.print("</td>");
				out.print("</tr>");
			}
			
			out.print("</table>"); 
			out.print("<br>");
			out.print("<br>");
			out.print("<br>");
			out.print("<br>");
			
			// THIS PART IS PRINTING OUT THE INDIVIDUAL PRICES
			
						String dummy = "SELECT TRUNCATE(@weekdays, 2) AS weekdays;";
						String dummy2 = "SELECT TRUNCATE(@weekends, 2) AS weekends;";
						ResultSet result = stmt3.executeQuery(dummy);   
						
						
						// Printing out the table
						out.print("<table>");
						out.print("<td>");
						out.print("<center>");
						out.print("WEEKDAYS");
						out.print("</center>");
						out.print("</td>");
						
						
						// Print out the weekday into the table
						while(result.next())
						{
							out.print("<tr>");
							out.print("<td>");
							out.print("<center>");
							out.print("$" + result.getString("weekdays"));
							out.print("</center>");
							out.print("</td>");
							out.print("</tr>");
						}
						
						out.print("</table>"); 
						
						// Printing out the table
						out.print("<table>");
						out.print("<td>");
						out.print("<center>");
						out.print("WEEKENDS"); 
						out.print("</center>");
						out.print("</td>");
						
						result = stmt3.executeQuery(dummy2);
						
						// Print out the weekend into the table
						while(result.next())
						{
							out.print("<tr>");
							out.print("<td>");
							out.print("<center>");
							out.print("$" + result.getString("weekends"));
							out.print("</center>");
							out.print("</td>");
							out.print("</tr>");
						} 
						
						out.print("</table>"); 
						out.print("<br>");
						out.print("<br>");
						out.print("<br>");
						out.print("<br>");
						
						out.print("It is obvious that the average price on weekdays is <= average price on weekends for beer");

			
			con.close(); 
		} catch (Exception e) {
			out.print(e);
		}
	%>

</body>
</html> 