<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
ClsConnection objconn=new ClsConnection();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String lpono=request.getParameter("lpono")==null?"":request.getParameter("lpono");
String lpodate=request.getParameter("lpodate")==null?"":request.getParameter("lpodate");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
Connection conn=null;
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	java.sql.Date sqldate=null;
	ClsCommon objcommon=new ClsCommon();
	if(!lpodate.equalsIgnoreCase("") && lpodate!=null){
		sqldate=objcommon.changeStringtoSqlDate(lpodate);
	}
	conn.setAutoCommit(false);
	String userid=session.getAttribute("USERID").toString();

	String strupdatequote="update gl_rentalcontractm set lpono='"+lpono+"', lpodate='"+sqldate+"' where doc_no="+docno;	
	int updatequote=stmt.executeUpdate(strupdatequote);
	if(updatequote<=0){
		errorstatus=1;
	}
	
	String logsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docno+",'"+brhid+"','BCM',now(),'"+userid+"','A')";
	int logins=stmt.executeUpdate(logsql);
	if(logins<=0){
		errorstatus=1;
	}
	
	if(errorstatus==0){
		conn.commit();	
	}
		
}
catch(Exception e){
	errorstatus=1;
	e.printStackTrace();
}
finally{
	conn.close();
}
objdata.put("errorstatus",errorstatus);
response.getWriter().write(objdata+"");
%>