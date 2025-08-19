<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String cnttrno=request.getParameter("cnttrno")=="" || request.getParameter("cnttrno")==null?"0":request.getParameter("cnttrno");
ClsConnection objconn=new ClsConnection();  
Connection conn=null;
String msg="";
int temp=0;
int insertval=0;
try{
	conn=objconn.getMyConnection();
	String userid=session.getAttribute("USERID").toString();
	Statement stmt=conn.createStatement();
	String strsql="update in_endorsementmgmt set confirm=1 where rowno='"+cnttrno+"'";  
	//System.out.println("strSql===="+strsql);     
	insertval=stmt.executeUpdate(strsql);
	//System.out.println("insertval=="+insertval);
	
	response.getWriter().print(insertval);    
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
%>