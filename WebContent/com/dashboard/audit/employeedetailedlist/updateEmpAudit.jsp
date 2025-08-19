<%@page import="java.sql.*"%>
<%@page import="com.connection.*"%>
<%
String empdocno=request.getParameter("empdocno")==null?"":request.getParameter("empdocno");
Connection conn=null;
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String strsql="update hr_empm set audit=1 where doc_no="+empdocno;
	System.out.println("Update Query:"+strsql);
	int updateval=stmt.executeUpdate(strsql);
	if(updateval<=0){
		errorstatus=1;
	}
	String branchid=session.getAttribute("BRANCHID").toString();
	String userid=session.getAttribute("USERID").toString();
	String strloginsert="insert into gl_biblog(doc_no, brhId, dtype, edate, userId,ENTRY)values("+empdocno+","+branchid+",'BAED',now(),"+userid+",'A')";
	System.out.println(strloginsert);
	int loginsert=stmt.executeUpdate(strloginsert);
	if(loginsert<=0){
		errorstatus=1;
	}
	if(errorstatus==0){
		conn.commit();
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