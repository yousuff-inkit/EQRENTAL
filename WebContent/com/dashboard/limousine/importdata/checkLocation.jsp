<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%

String pickuplocation=request.getParameter("pickuplocation")==null?"":request.getParameter("pickuplocation").toString();
String dropofflocation=request.getParameter("dropofflocation")==null?"":request.getParameter("dropofflocation").toString();
Connection conn=null;
ClsConnection objconn=new ClsConnection();
int pickuplocationcount=0,dropofflocationcount=0;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	String strpickuplocation="select count(*) rowcount from gl_cordinates where location='"+pickuplocation+"' and status=3";
	ResultSet rspickuplocation=stmt.executeQuery(strpickuplocation);
	while(rspickuplocation.next()){
		pickuplocationcount=rspickuplocation.getInt("rowcount");
	}
	String strdropofflocation="select count(*) rowcount from gl_cordinates where location='"+dropofflocation+"' and status=3";
	ResultSet rsdropofflocation=stmt.executeQuery(strdropofflocation);
	while(rsdropofflocation.next()){
		dropofflocationcount=rsdropofflocation.getInt("rowcount");
	}
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(pickuplocationcount+"::"+dropofflocationcount);
%>