<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
ClsConnection objconn=new ClsConnection();
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select doc_no,cat_name from my_clcatm where dtype='CRM' and status=3";
	ResultSet rs=stmt.executeQuery(strsql);
	JSONArray dataarray=new JSONArray();
	while(rs.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rs.getString("doc_no"));
		objtemp.put("category",rs.getString("cat_name"));
		dataarray.add(objtemp);
	}
	objdata.put("catdata",dataarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>