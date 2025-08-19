<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession" %>


<%	 
    ClsConnection conobj= new ClsConnection();
	String curid = request.getParameter("curid")==null?"":request.getParameter("curid");

 	Connection conn = conobj.getMyConnection();
	Statement stmt = conn.createStatement ();    
	 
	String strSql = "select round(rate,4) rate from my_curbook where curid='"+curid+"'";     
	
	ResultSet rs = stmt.executeQuery(strSql);  
	String rate="";
	while(rs.next()) {   
	         	 rate =rs.getString("rate");
	}
   
    response.getWriter().print(rate);       
	stmt.close();
	conn.close();
  %>