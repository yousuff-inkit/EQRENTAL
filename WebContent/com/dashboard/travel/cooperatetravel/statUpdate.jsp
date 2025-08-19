<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<%
String statusid=request.getParameter("statusid")==null?"0":request.getParameter("statusid");
String trno=request.getParameter("trno")==null?"0":request.getParameter("trno"); 
int errorstatus=0;
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();          
	String strsql="update in_endorsementmgmt set estatus='"+statusid+"',lstdate=now(),lstuser='"+session.getAttribute("USERNAME").toString()+"' where rowno='"+trno+"'";	
	System.out.println("strSql===="+strsql); 
	int sqlupdate=stmt.executeUpdate(strsql);       
	if(sqlupdate<=0){ 
		errorstatus=1;
	}
}
catch(Exception e){  
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>