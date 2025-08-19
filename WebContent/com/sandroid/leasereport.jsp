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

ClsCommon ClsCommon=new ClsCommon();
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


           		String sql="select(select count(*) from gl_lagmt where outdate>='"+from+"' and outdate<='"+to+"' and status=3 )open,(select count(*) from gl_lagmtclosem where indate>='"+from+"' and indate<='"+to+"' and status=3 )close;";
           		
          			System.out.println("----"+sql);
           		ResultSet resultSet = stmtVeh.executeQuery(sql);
           		 /* RESULTDATA=ClsCommon.convertToJSON(resultSet); */
           		while(resultSet.next()){
	 				//fleet=resultSet.getString("fleet");
	    			open=resultSet.getString("open");
	    			close=resultSet.getString("close");
	    			System.out.println("lopen:"+open);
	    			System.out.println("lclose:"+close);
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



