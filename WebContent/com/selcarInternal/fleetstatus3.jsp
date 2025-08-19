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
	
JSONArray jsonArray = new JSONArray();
String value="";
	try{
		
		ClsAndroid and=new ClsAndroid();
		//String dtype=session.getAttribute("Code").toString();
		String brch=request.getParameter("branch");
		String type=request.getParameter("type");
		String val=request.getParameter("values");
		String tran=request.getParameter("tran");
		System.out.println("=====jsp===== "+brch+"??"+type+"::"+val+"[[]]"+tran);
		jsonArray =and.searchVehgrid( brch,type,val,tran);
		
		System.out.println("========== "+jsonArray.toString());
		value="1";
	}
	catch(Exception e){
	 	e.printStackTrace();
	 	
	}
	
	 response.setContentType("application/json");
     response.setCharacterEncoding("UTF-8");
     response.getWriter().write(jsonArray.toString()+"::"+value);
  %>
  
