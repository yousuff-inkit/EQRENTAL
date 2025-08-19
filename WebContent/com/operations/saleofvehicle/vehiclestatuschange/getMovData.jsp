<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
java.sql.Date sqldate=null;
String time="";
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select din,tin from gl_vmove where doc_no=(select max(doc_no) from gl_vmove where fleet_no="+fleetno+")";
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		sqldate=rs.getDate("din");
		time=rs.getString("tin");
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(sqldate+"::"+time);
%>