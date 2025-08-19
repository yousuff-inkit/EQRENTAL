
 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%	

ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();


	String fleet=request.getParameter("fleet");
	
String purcost=request.getParameter("purcost");
String resval=request.getParameter("resval");





	 String upsql=null;
	 String sql=null;

	 int val=0;
	 int val1=0;
	 int count=0;
	 
	 Connection conn=null;

	 try{
 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String sqllimo="";
	System.out.println(sql+"ssql");
	sql="select count(*) count from gc_assettran where fleet_no='"+fleet+"' and Ttype='VPO'";
	ResultSet resultSet = stmt.executeQuery(sql);
	
    if (resultSet.next()) {
    	count=resultSet.getInt("count");
    }	
    
	if(count>=1){
	 
	 
	 val=1;
  
	}				
		 response.getWriter().print(val);
	 
	 	
	 	stmt.close();
	 	conn.close();
	
	 	}
    catch(Exception e){

	 conn.close();
	 e.printStackTrace();
	 		}	  
	    
	
	%>
