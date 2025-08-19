<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject data=new JSONObject();
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strgetclient="select ac.refname,ac.cldocno from my_acbook ac where dtype='CRM' and status=3";
	ResultSet rsgetclient=stmt.executeQuery(strgetclient);
	JSONArray clientarray=new JSONArray();
	while(rsgetclient.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("refname",rsgetclient.getString("refname"));
		objtemp.put("cldocno",rsgetclient.getString("cldocno"));
		clientarray.add(objtemp);
	}
	
	String strgetinsur="select ac.refname,ac.cldocno from my_acbook ac left join my_clcatm cat on ac.catid=cat.doc_no where ac.dtype='crm' and ac.status=3"
			+ " and cat.status=3 and cat.insurance=1";
	ResultSet rsgetinsur=stmt.executeQuery(strgetinsur);
	JSONArray insurarray=new JSONArray();
	while(rsgetinsur.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("refname",rsgetinsur.getString("refname"));
		objtemp.put("cldocno",rsgetinsur.getString("cldocno"));
		insurarray.add(objtemp);
	}
	
	String strgetbranch="select doc_no docno,branchname refname from my_brch where status=3";
	ResultSet rsgetbranch=stmt.executeQuery(strgetbranch);
	JSONArray brancharray=new JSONArray();
	while(rsgetbranch.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("refname",rsgetbranch.getString("refname"));
		objtemp.put("docno",rsgetbranch.getString("docno"));
		brancharray.add(objtemp);
	}
	data.put("clientdata",clientarray);
	data.put("insurdata",insurarray);
	data.put("branchdata",brancharray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(data+"");
%>