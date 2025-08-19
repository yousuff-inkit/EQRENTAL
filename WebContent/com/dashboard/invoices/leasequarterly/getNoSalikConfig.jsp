<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
int method=0;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String str="select method from gl_config where field_nme='InvQuarterlyNoSalik'";
	ResultSet rs=stmt.executeQuery(str);
	while(rs.next()){
		method=rs.getInt("method");
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(method+"");
%>