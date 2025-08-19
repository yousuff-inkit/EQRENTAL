<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="com.common.ClsEncrypt" %>
<%@page import="net.sf.json.JSONObject" %>
<%@page import="net.sf.json.JSONArray" %>
<%@page import="com.connection.*" %>
<%@page import="com.sayaraInternal.*" %>
  
<%	
	
JSONArray jsonArray = new JSONArray();
String result="false";
	try{
		
		ClsAndroid and=new ClsAndroid();
		String regno=request.getParameter("reg_no")==null?"":request.getParameter("reg_no").toString();
		//String del_KM=request.getParameter("del_KM");
		 jsonArray=and.collectionnsearch("1",regno);
	System.out.println("======reg==== "+jsonArray);
	}
	catch(Exception e){
	 	e.printStackTrace();
	 	
	}
	
	 response.setContentType("application/json");
     response.setCharacterEncoding("UTF-8");
     response.getWriter().write(jsonArray.toString());
  %>
  
