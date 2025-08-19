<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	//Getting OP Assets
	
	String stropassets="SELECT grp.doc_no docno,grp.grp_name refname,COALESCE(m.totalqty,0) totalqty,COALESCE(iss.issueqty,0) issueqty FROM my_fagrp grp"+ 
	" LEFT JOIN (SELECT SUM(noofitems) totalqty,assetgp grpid FROM my_fixm WHERE STATUS=3 GROUP BY assetgp) m ON grp.doc_no=m.grpid"+ 
	" LEFT JOIN (SELECT SUM(qty) issueqty,assetgrpid grpid FROM my_cableissue WHERE STATUS=3 GROUP BY assetgrpid) iss ON grp.doc_no=iss.grpid"+ 
	" WHERE grp.status=3 AND grp.chkopasset=1";
	ResultSet rsopassets=stmt.executeQuery(stropassets);
	JSONArray assetgrparray=new JSONArray();
	while(rsopassets.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rsopassets.getString("docno"));
		objtemp.put("refname",rsopassets.getString("refname"));
		objtemp.put("totalqty",rsopassets.getString("totalqty"));
		objtemp.put("issueqty",rsopassets.getString("issueqty"));
		double balqty=rsopassets.getDouble("totalqty")-rsopassets.getDouble("issueqty");
		objtemp.put("balqty",balqty);
		assetgrparray.add(objtemp);
	}
	
	String strgetcable="SELECT grp.doc_no grpdocno,grp.grp_name refname,round(cb.qty,0) qty FROM my_cableissue cb LEFT JOIN my_fagrp grp ON cb.assetgrpid=grp.doc_no WHERE cb.status=3 and cb.contractdocno="+docno;
	ResultSet rscable=stmt.executeQuery(strgetcable);
	JSONArray cablearray=new JSONArray();
	while(rscable.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("grpdocno",rscable.getString("grpdocno"));
		objtemp.put("refname",rscable.getString("refname"));
		objtemp.put("qty",rscable.getString("qty"));
		cablearray.add(objtemp);	
	}
	objdata.put("cabledata",cablearray);
	objdata.put("assetgrpdata",assetgrparray);
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>