<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
String catid=request.getParameter("catid")==null?"":request.getParameter("catid");
try{
	
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	if(!catid.equalsIgnoreCase("")){
		String strcat="select doc_no docno,name refname from gl_vehsubcategory where status=3 and catid="+catid;
		JSONArray catarray=new JSONArray();
		ResultSet rscat=stmt.executeQuery(strcat);
		while(rscat.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("docno",rscat.getString("docno"));
			objtemp.put("refname",rscat.getString("refname"));
			catarray.add(objtemp);
		}
		objdata.put("subcatdata",catarray);
	}
	else{
		String strcat="select doc_no docno,name refname from gl_vehcategory where status=3";
		JSONArray catarray=new JSONArray();
		ResultSet rscat=stmt.executeQuery(strcat);
		while(rscat.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("docno",rscat.getString("docno"));
			objtemp.put("refname",rscat.getString("refname"));
			catarray.add(objtemp);
		}
		String strsize="select doc_no docno,unit refname from my_unitm where status=3";
		JSONArray sizearray=new JSONArray();
		ResultSet rssize=stmt.executeQuery(strsize);
		while(rssize.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("docno",rssize.getString("docno"));
			objtemp.put("refname",rssize.getString("refname"));
			sizearray.add(objtemp);
		}
		objdata.put("catdata",catarray);
		objdata.put("sizedata",sizearray);	
	}
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>
