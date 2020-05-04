<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Price</title> 
</head>
<body>
	<%
	    
		try {
			
			if (request.getParameter("price") == "")
			{
				out.print("Price cannot be empty, please return and enter a price");
				return;
			}
	
			String url = "jdbc:mysql://project336.c9r8cskeqxon.us-east-2.rds.amazonaws.com:3306/foo";
			
			
			Class.forName("com.mysql.jdbc.Driver");
			
			Connection con = DriverManager.getConnection(url, "project336", "project336");
		
			// Parameters
			String beer = request.getParameter("beer");
			String bar = request.getParameter("bar");
			String day = request.getParameter("day");
			Integer price = Integer.parseInt(request.getParameter("price"), 10);
			
			
			// Check for pricing constraints
			
			if (price > 7 && ((day.contentEquals("Friday") != true) && (day.contentEquals("Saturday") != true) && (day.contentEquals("Sunday") != true)))
				{
					out.print("Price of $" + price + " for " + beer + " is not possible on " + day + ". ");
					price = 5;
					out.print("Price was set to maximum possible for weekdays");
					out.print("<br/><br/>");
				}else if (price > 7 && (day.contentEquals("Friday") == true || day.contentEquals("Saturday") == true || day.contentEquals("Sunday") == true)
							&& (beer.contentEquals("Corona") != true && beer.contentEquals("Heineken") != true && beer.contentEquals("Guinness") != true))
				{
					out.print("Price of $" + price + " for " + beer + " is not possible on " + day + ". ");
					price = 7;
					out.print("Price was set to maximum possible for weekends where the beer is not Corona, Guinness, or Heineken");
					out.print("<br/><br/>");
				}else if (price < 7 && (day.contentEquals("Friday") == true || day.contentEquals("Saturday") == true || day.contentEquals("Sunday") == true)
						&& (beer.contentEquals("Corona") == true || beer.contentEquals("Heineken") == true || beer.contentEquals("Guinness") == true))
				{
					out.print("Price of $" + price + " for " + beer + " is not possible on " + day + ". ");
					price = 7;
					out.print("Price was set to minimum possible for weekends where the beer is Corona, Guinness, or Heineken");
					out.print("<br/><br/>");
				}
			String insert_query = "UPDATE price SET price = ? WHERE beer = ? AND bar = ? and day = ?;";

			//Create a SQL statement
			PreparedStatement tuple = con.prepareStatement(insert_query); 
			tuple.setInt(1, price);
			tuple.setString(2, beer);
			tuple.setString(3, bar);
			tuple.setString(4, day);
			
			// Run the query to insert person into people table
			tuple.execute();
			
			// Verification query?
			Statement stmt = con.createStatement();
			String check_query = "SELECT bar, beer, price, day FROM price WHERE bar = '" + bar + "' AND beer = '" + 
			beer + "' AND price = '" + price + "' AND day = '" + day + "';";
			ResultSet result = stmt.executeQuery(check_query);
			
			
			// Printing out the table
			out.print("<table>");
			out.print("<td>");
			out.print("<center>");
			out.print("BEER");
			out.print("</center>");
			out.print("</td>");
			
			out.print("<td>");
			out.print("<center>");
			out.print("BAR");
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
			
			
			// Print out the results into the table
			
			while(result.next())
			{
				out.print("<tr>");
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("beer"));
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("bar")); 
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("price"));
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("day"));
				out.print("</center>");
				out.print("</td>");
			}
			
			out.print("</table>"); 
			
			out.print("<br/><br/><br/>");
			
			out.print("Your prices were successfully updated in the database. Thank you for your interest in Drinker's Paradise!");

			con.close();
		} catch (Exception e) {
			out.print(e);
		}
	%>

</body>
</html> 