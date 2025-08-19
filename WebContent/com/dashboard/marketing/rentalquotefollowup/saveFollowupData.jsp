<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
ClsConnection objconn=new ClsConnection();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String status=request.getParameter("status")==null?"":request.getParameter("status");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String desc=request.getParameter("desc")==null?"":request.getParameter("desc");
Connection conn=null;
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	java.sql.Date sqldate=null;
	ClsCommon objcommon=new ClsCommon();
	if(!date.equalsIgnoreCase("") && date!=null){
		sqldate=objcommon.changeStringtoSqlDate(date);
	}
	conn.setAutoCommit(false);
	String brhid=session.getAttribute("BRANCHID").toString();
	String userid=session.getAttribute("USERID").toString();
	String strinsert="insert into gl_brentalquote(date, rdocno, description, fdate, brhid, userid, status)values(curdate(),"+docno+",'"+desc+"','"+sqldate+"',"+brhid+","+userid+","+status+")";
	int insert=stmt.executeUpdate(strinsert);
	if(insert<=0){
		errorstatus=1;		
	}
	else{
		String strupdatequote="update gl_rentalquotem set followupstatus="+status+" where doc_no="+docno;	
		int updatequote=stmt.executeUpdate(strupdatequote);
		if(updatequote<=0){
			errorstatus=1;
		}
		if(status.equalsIgnoreCase("3")){
			String strupdate="update gl_rentalquotem set processstatus=2 where doc_no="+docno;	
			int update=stmt.executeUpdate(strupdate);
			if(update<=0){
				errorstatus=1;
			}
		}
		if(errorstatus==0){
			conn.commit();	
		}
		
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