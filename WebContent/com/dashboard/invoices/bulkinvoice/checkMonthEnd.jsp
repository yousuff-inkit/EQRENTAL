<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%@page import="java.sql.*" %>
<%
String date=request.getParameter("date")==null?"":request.getParameter("date");
Connection conn=null;
ClsCommon objcommon=new ClsCommon();
ClsConnection objconn=new ClsConnection();
int status=0;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	java.sql.Date sqldate=null;
	if(!date.equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(date);
	}
	String strsql="select case when LAST_DAY(cast('"+sqldate+"' as date))=cast('"+sqldate+"' as date) then 1 else 0 end status";
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		status=rs.getInt("status");
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(status+"");
%>