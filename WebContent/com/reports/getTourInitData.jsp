<%@page import="com.reports.ClsReportsDAO"%>   
<%@page import="java.util.ArrayList"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
	Connection conn=null;
	JSONObject objchartdata=new JSONObject();
	ClsReportsDAO dao=new ClsReportsDAO();   
	try{
		ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();  
		java.sql.Date sqldate=null;
		String cldocno="0";  
	
		objchartdata=dao.getCharttourData(conn);          
		
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	response.getWriter().print(objchartdata);       
%>