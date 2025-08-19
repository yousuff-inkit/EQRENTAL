<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="com.common.ClsEncrypt" %>
<%@page import="net.sf.json.JSONObject" %>
<%@page import="net.sf.json.JSONArray" %>
<%@page import="com.connection.*" %>
<%@page import="com.selcarInternal.*"%>
  
<%
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();
Connection conn=null;
JSONArray RESULTDATA=new JSONArray();
String value="";
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


           		String sql="select r.voc_no,r.brchid,a.refname,t.rate from gl_lagmtclosem r left join my_acbook a on r.cldocno=a.cldocno and dtype='CRM' left join gl_ltarif t on r.doc_no=t.rdocno where indate>='"+from+"' and indate<='"+to+"';";
           		
          			System.out.println("--ggg--"+sql);
           		ResultSet resultSet = stmtVeh.executeQuery(sql);
           		  RESULTDATA=ClsCommon.convertToJSON(resultSet); 
           		  System.out.println("leaseclose"+RESULTDATA);
    				 stmtVeh.close(); 
    				value="1";
    				
           	}
           	
        	conn.close();
}
catch(Exception e){
		e.printStackTrace();
		conn.close();
	}	

response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");
response.getWriter().write(  RESULTDATA.toString()+"::"+value);

 
		
	     




%>



