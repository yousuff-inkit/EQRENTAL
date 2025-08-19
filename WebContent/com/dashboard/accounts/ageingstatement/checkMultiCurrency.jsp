<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
ClsConnection ClsConnection=new ClsConnection();

	Connection conn = null;
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();

		String strSql = "select doc_no from my_brch where multicur=1;";
		ResultSet rs = stmt.executeQuery(strSql);
		int multicurrency=0;
		while(rs.next()) {
			multicurrency=1;	
	  	} 
		
		response.getWriter().write(multicurrency+"####");
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}
  %>
  
