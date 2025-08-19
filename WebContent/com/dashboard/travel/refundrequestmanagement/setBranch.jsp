
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
ClsConnection ClsConnection=new ClsConnection();
    String brch=request.getParameter("branch");
	Connection conn = null;
	try{
		int id=0;
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
    	String strSql = "select branchname,doc_no from my_brch where doc_no='"+brch+"'  and status<>7" ;   
		System.out.println("sql ====== "+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		while(rs.next()) {
				session.setAttribute("BRANCHNAME", rs.getString("branchname"));      
				session.setAttribute("BRANCHID", rs.getString("doc_no"));
				id=1;
	  		} 
		response.getWriter().print(id);       
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
 
 
 
 
 
 
 
 
 