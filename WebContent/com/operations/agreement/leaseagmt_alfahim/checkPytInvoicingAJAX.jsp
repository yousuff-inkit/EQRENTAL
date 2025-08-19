<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
Connection conn=null;
String errorstatus="0";
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select count(*) maxcount from gl_leasepytcalc where rdocno="+docno+" and markstatus>0";
	System.out.println("Payment Inv Count Query:"+strsql);
	ResultSet rs=stmt.executeQuery(strsql);
	int count=0;
	while(rs.next()){
		if(rs.getInt("maxcount")>1){
			errorstatus="2";
		}
		else{
			errorstatus="0";
		}
	}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus="1";
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus);
%>