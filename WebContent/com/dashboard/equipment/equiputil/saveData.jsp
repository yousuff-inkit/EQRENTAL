<%@page import="com.dashboard.equipment.equiputildownload.ClsEquipUtilDownloadDAO"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String date=request.getParameter("date")==null?"":request.getParameter("date").toString();

Connection conn=null;
JSONObject objdata=new JSONObject();
int errorstatus=0;
try{
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	java.sql.Date sqldate=null;
	if(!date.equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(date);
	}
	ClsEquipUtilDownloadDAO dao=new ClsEquipUtilDownloadDAO();
	int value=dao.downloadData(sqldate, conn);
	if(value<=0){
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