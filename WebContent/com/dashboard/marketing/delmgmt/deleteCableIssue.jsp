<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
int errorstatus=0;
String contractdocno=request.getParameter("docno")==null?"":request.getParameter("docno");
String grpdocno=request.getParameter("grpdocno")==null?"":request.getParameter("grpdocno");

try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	
	String strdelete="delete from my_cableissue where assetgrpid="+grpdocno+" and contractdocno="+contractdocno;
	int delete=stmt.executeUpdate(strdelete);
	if(delete<=0){
		errorstatus=1;
	}
	if(errorstatus==0){
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
finally{
	conn.close();
}
objdata.put("errorstatus",errorstatus);
response.getWriter().write(objdata+"");
%>