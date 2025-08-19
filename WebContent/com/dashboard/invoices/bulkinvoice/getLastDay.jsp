<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.*"%>
<%
Connection conn=null;
String date=request.getParameter("date")==null?"":request.getParameter("date");
java.sql.Date sqldate=null;
try{
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	
	if(!date.equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(date);
	}
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select case when '"+sqldate+"'=LAST_DAY('"+sqldate+"') then LAST_DAY('"+sqldate+"') else LAST_DAY(date_add('"+sqldate+"', interval 1 month )) end sqldate";
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		sqldate=rs.getDate("sqldate");
	}
	stmt.close();
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(sqldate+"");

%>