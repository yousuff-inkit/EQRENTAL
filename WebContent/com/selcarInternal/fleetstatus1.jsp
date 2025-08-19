<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="com.common.ClsEncrypt" %>
<%@page import="net.sf.json.JSONObject" %>
<%@page import="net.sf.json.JSONArray" %>
<%@page import="com.connection.*" %>
<%@page import="com.selcarInternal.*" %>
  
<%	
ClsAndroid and=new ClsAndroid();
	Connection conn = null;
JSONArray jsonArray = new JSONArray();
String value="";
	try{
		
		
		//String dtype=session.getAttribute("Code").toString();
		
		jsonArray =and.fleetstatus1("a");
		value="1";
		//System.out.println("========== "+jsonArray.toString());
	}
	catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}
	
	 response.setContentType("application/json");
     response.setCharacterEncoding("UTF-8");
     response.getWriter().write(jsonArray.toString()+"::"+value);
  %>
  
