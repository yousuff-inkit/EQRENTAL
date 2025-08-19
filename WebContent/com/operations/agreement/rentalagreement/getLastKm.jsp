<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
Connection conn=null;
ClsConnection objconn=new ClsConnection();
int km=0;
try{
	conn=objconn.getMyConnection();
	ResultSet rs=conn.createStatement().executeQuery("select round(okm,0) lastkm from gl_ragmt where doc_no="+agmtno);
	while(rs.next()){
		km=rs.getInt("lastkm");
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(km+"");
%>