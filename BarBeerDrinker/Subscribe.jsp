<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Subscribe</title> 
</head>
<body>
	<%
	    
		try {
	
			String url = "jdbc:mysql://project336.c9r8cskeqxon.us-east-2.rds.amazonaws.com:3306/foo";
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, "project336", "project336"); 
		
			// Parameters
			String beer = request.getParameter("beer");
			String first = request.getParameter("first");
			String last = request.getParameter("last");
			String address = request.getParameter("address");
			String gender = request.getParameter("determine_gender");
			String city = request.getParameter("city");
			String state = request.getParameter("state");
			
			
			// Do not pass null values into the table
			if (first.length() == 0 || last.length() == 0 || address.length() == 0 || city.length() == 0)
			{
				out.print("Enter the data in the fields correctly"); 
				return;
			}
			
			if (!Character.isDigit(address.charAt(0)))
			{
				out.print("Address must start with a digit or else it's not valid");
				return;
			}
			 
			String insert_query = "INSERT INTO people (first_name, last_name, gender, address, city, states, beerLiked)" + 
			"VALUES (?, ?, ?, ?, ?, ?, ?)";

			//Create a SQL statement
			PreparedStatement tuple = con.prepareStatement(insert_query); 
			tuple.setString(1, first);
			tuple.setString(2, last);
			tuple.setString(3, gender);
			tuple.setString(4, address);
			tuple.setString(5, city);
			tuple.setString(6, state);
			tuple.setString(7, beer);
			
			// Run the query to insert person into people table
			tuple.execute();
			
			// Verification query?
			Statement stmt = con.createStatement();
			String check_query = "SELECT first_name, last_name, gender, address, city, states, beerLiked FROM people WHERE first_name = '" + first + "' AND last_name = '" + 
			last + "' AND gender = '" + gender + "' AND address = '" + address + 
			"' AND city = '" + city + "' AND states = '" + state + 
			"' AND beerLiked = '" + beer + "';";
			ResultSet result = stmt.executeQuery(check_query);
			
			
			// Printing out the table
			out.print("<table>");
			out.print("<td>");
			out.print("<center>");
			out.print("FIRST NAME");
			out.print("</center>");
			out.print("</td>");
			
			out.print("<td>");
			out.print("<center>");
			out.print("LAST NAME");
			out.print("</center>");
			out.print("</td>");
			
			out.print("<td>");
			out.print("<center>");
			out.print("GENDER");
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
			out.print("FAVORITE BEER");
			out.print("</center>");
			out.print("</td>");
			
			// Print out the results into the table
			
			while(result.next())
			{
				out.print("<tr>");
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("first_name"));
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("last_name")); 
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("gender"));
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
				out.print(result.getString("states")); 
				out.print("</center>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("<center>");
				out.print(result.getString("beerLiked")); 
				out.print("</center>");
				out.print("</td>");
				out.print("</tr>");
			}
			
			out.print("</table>"); 
			out.print("<br/><br/>");
			out.print("Your entry was successfully inserted into our database. Thank you for your interest in Drinker's Paradise!");

			con.close();
		} catch (Exception e) {
			out.print(e);
		}
	%>

</body>
</html> 