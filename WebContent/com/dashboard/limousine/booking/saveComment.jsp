<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String comment=request.getParameter("comment")==null?"":request.getParameter("comment");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
ClsConnection objconn=new ClsConnection();
Connection conn=null;
String msg="";
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);   
	String userid=session.getAttribute("USERID").toString();
	Statement stmt=conn.createStatement();        
	String strsql="insert into in_comments(bookno,userid,msgdate,msg)values("+docno+","+userid+",now(),'"+comment+"')";
	int insertval=stmt.executeUpdate(strsql);     
	
	if(insertval>0){    
		conn.commit();
	} 
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(msg);
%>