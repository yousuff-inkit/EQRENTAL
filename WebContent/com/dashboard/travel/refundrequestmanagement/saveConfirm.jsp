<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
ClsConnection ClsConnection=new ClsConnection();
    String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno");    
	Connection conn = null;
	try{
		int id=0;
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
    	String strSql = "update tr_refundrequestm set confirm=1 where doc_no='"+docno+"'" ;   
		System.out.println("sql ====== "+strSql);
		id = stmt.executeUpdate(strSql);
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
  
 
 
 
 
 
 
 
 
 