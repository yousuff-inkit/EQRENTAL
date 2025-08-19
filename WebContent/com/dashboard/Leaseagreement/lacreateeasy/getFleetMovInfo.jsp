<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String fleetno=request.getParameter("fleetno")==null?"0":request.getParameter("fleetno");
Connection conn=null;
String kmin="",din="",tin="",fin=""; 
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	String strgetdata="select round(kmin,0) kmin,din,tin,fin from gl_vmove where doc_no=(select max(doc_no) from gl_vmove where fleet_no="+fleetno+")";
	ResultSet rs=stmt.executeQuery(strgetdata);
	while(rs.next()){
		kmin=rs.getString("kmin");
		fin=rs.getString("fin");
	}
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(kmin+"::"+fin);
%>