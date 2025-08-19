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
ClsConnection ClsConnection=new ClsConnection();
Connection conn=null;
JSONArray RESULTDATA=new JSONArray();
String open="";
String close="";

try{
	ClsAndroid and=new ClsAndroid();
	ClsCommon com=new ClsCommon();
//System.out.println("======aa==== ");		
	// ClsAndroid and=new ClsAndroid();
	//String dtype=session.getAttribute("Code").toString();
	Date from=com.changeStringtoSqlDate(request.getParameter("from")); 
	Date to=com.changeStringtoSqlDate(request.getParameter("to")); 

	
	
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement();
			
			 
			
			if(!(from==null))
			{


           		String sql="select (select count(*) from gl_ragmt where odate>='"+from+"' and odate<='"+to+"' and status=3  ) open, (select count(*) from gl_ragmtclosem where indate>='"+from+"' and indate<='"+to+"' and status=3 )close;";
           		
          			System.out.println("----"+sql);
           		ResultSet resultSet = stmtVeh.executeQuery(sql);
           		/*  RESULTDATA=ClsCommon.convertToJSON(resultSet); */
    				/* stmtVeh.close(); */
    				while(resultSet.next()){
    	 				//fleet=resultSet.getString("fleet");
    	    			open=resultSet.getString("open");
    	    			close=resultSet.getString("close");
    	    			System.out.println("open:"+open);
    	    			System.out.println("close:"+close);
    	 			}
    				
           	}
           	
        	conn.close();
}
catch(Exception e){
		e.printStackTrace();
		conn.close();
	}	

response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");
response.getWriter().write( open.toString()+"::"+close.toString());

 
		
	     




%>



