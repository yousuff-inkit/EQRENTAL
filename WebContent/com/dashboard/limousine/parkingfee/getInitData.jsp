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
	String strgetclient="select refname,cldocno from my_acbook where dtype='CRM' and status=3";
	JSONArray clientarray=new JSONArray();
	JSONArray locarray=new JSONArray();
	ResultSet rsgetclient=stmt.executeQuery(strgetclient);
	while(rsgetclient.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("name",rsgetclient.getString("refname"));
		objtemp.put("value",rsgetclient.getString("cldocno"));
		clientarray.add(objtemp);
	}
	String strgetloc="select doc_no,location from gl_cordinates where status=3 and chkairport=1";
	ResultSet rsgetloc=stmt.executeQuery(strgetloc);
	while(rsgetloc.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("name",rsgetloc.getString("location"));
		objtemp.put("value",rsgetloc.getString("doc_no"));
		locarray.add(objtemp);
	}
	objdata.put("clientdata",clientarray);
	objdata.put("locdata",locarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>