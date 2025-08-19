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
Connection conn=null;       
String stdtotal=request.getParameter("stdtotal")==null || request.getParameter("stdtotal").trim().equalsIgnoreCase("")?"0.0":request.getParameter("stdtotal").toString();
String stdadult=request.getParameter("stdadult")==null || request.getParameter("stdadult").trim().equalsIgnoreCase("")?"0.0":request.getParameter("stdadult").toString();
String stdchild=request.getParameter("stdchild")==null || request.getParameter("stdchild").trim().equalsIgnoreCase("")?"0.0":request.getParameter("stdchild").toString();
String tourrow=request.getParameter("tourrow")==null || request.getParameter("tourrow").trim().equalsIgnoreCase("")?"0":request.getParameter("tourrow").toString();
String vendorid=request.getParameter("vendorid")==null || request.getParameter("vendorid").trim().equalsIgnoreCase("")?"0":request.getParameter("vendorid").toString();
	try{
		String sql=null;
		int val=0;
	 	conn=ClsConnection.getMyConnection();  
	 	Statement stmt = conn.createStatement();		
		String strcountdata="";
				   strcountdata="update tr_srtour set stdtotal="+stdtotal+", vendorid='"+vendorid+"',adultval="+stdadult+",childval="+stdchild+" where rowno='"+tourrow+"'";      
				   //System.out.println("strcountdata--->>>"+strcountdata);                                                         
				   val=stmt.executeUpdate(strcountdata); 
			 	  //System.out.println("val--->>>"+val);  
	 	      
	 	response.getWriter().print(val);     
	 	conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   } finally{
	   conn.close();
   }

%>
