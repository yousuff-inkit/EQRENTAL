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
	String strsql="select count(*) itemcount from gl_rentalquotecalc where rdocno="+docno+" and approved=1";
	ResultSet rs=stmt.executeQuery(strsql);
	int itemcount=0;
	while(rs.next()){
		itemcount=rs.getInt("itemcount");
	}
	objdata.put("itemcount",itemcount);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>