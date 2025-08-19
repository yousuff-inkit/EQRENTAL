<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String masterdocno=request.getParameter("masterdocno")==null?"":request.getParameter("masterdocno");
int totalqty=0,qty=0;
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String str="select (select totalqty from gl_masterlagm where status=3 and doc_no="+masterdocno+") totalqty,(select count(*) from gl_lagmt where masterrefno="+masterdocno+" and status=3) qty";
	System.out.println(str);
	ResultSet rs=stmt.executeQuery(str);
	while(rs.next()){
		totalqty=rs.getInt("totalqty");
		qty=rs.getInt("qty");
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
System.out.println(totalqty+"::"+qty);
response.getWriter().write(totalqty+"::"+qty);
%>