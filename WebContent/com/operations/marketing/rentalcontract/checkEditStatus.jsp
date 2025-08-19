<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	int status=0;
	
	String strsql="select doc_no from gl_rentalcontractm where doc_no="+docno+" and (delinvno<>0 or collectinvno<>0 or srvinvno<>0)";
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		status=1;
	}
	
	String strsql1="select contractdocno from gl_rentalquotecalc where contractdocno="+docno+" and delstartdate<invdate";
	ResultSet rs1=stmt.executeQuery(strsql1);
	while(rs1.next()){
		status=1;
	}
	
	objdata.put("status",status);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>