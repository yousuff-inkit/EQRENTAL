<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>  
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();
String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
String dates="";
	Connection conn = null;
	try{  
	 	conn = ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
  		int val=0,monthdiff=0;
  		 if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
				sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
      }
			if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
				sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		 }
		String sql = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
		System.out.println("sql------>>"+sql);
		ResultSet rs1 = stmt.executeQuery(sql);    
		
		while(rs1.next()) {
			monthdiff=rs1.getInt("monthdiff");
		} 
		 System.out.println("monthdiff--->>"+monthdiff);   
		if(monthdiff>11){
			val=1;
		}
	     System.out.println("val--->>"+val);
	     
	     response.getWriter().print(val);  
	  
	 	 stmt.close();
	 	 conn.close();    
	}catch(Exception e){
	 	e.printStackTrace();	  
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
  
