<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	//Getting Fleets
	String strgetfleet="select fleet_no,flname,tran_code from gl_vehmaster where statu=3 and status='IN'";
	JSONArray fleetarray=new JSONArray();
	ResultSet rsfleet=stmt.executeQuery(strgetfleet);
	while(rsfleet.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("fleetno",rsfleet.getString("fleet_no"));
		objtemp.put("fleetname",rsfleet.getString("flname"));
		fleetarray.add(objtemp);
	}
	//Getting Drivers
	String strgetdrv="select doc_no,sal_name from my_salesman where sal_type='DRV' and status=3";
	JSONArray drvarray=new JSONArray();
	ResultSet rsdrv=stmt.executeQuery(strgetdrv);
	while(rsdrv.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("drvdocno",rsdrv.getString("doc_no"));
		objtemp.put("drvname",rsdrv.getString("sal_name"));
		drvarray.add(objtemp);
	}
	//Getting Tax Config
	String strgettax="select method from gl_config where field_nme='tax'";
	int taxconfig=0;
	ResultSet rstax=stmt.executeQuery(strgettax);
	while(rstax.next()){
		taxconfig=rstax.getInt("method");
	}
	//Getting taxpercent;
	String strtaxpercent="select set_per,vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno left join my_brch br on (tax.province=br.province) where tax.status<>7 and curdate() between tax.fromdate and tax.todate  and br.doc_no=1";
	double taxpercent=0.0;
	ResultSet rstaxpercent=stmt.executeQuery(strtaxpercent);
	while(rstaxpercent.next()){
		taxpercent=rstaxpercent.getDouble("vat_per");
	}
	//Getting Vendors
	String strgetvendor="select cldocno,refname,tax from my_acbook where dtype='VND' and status=3";
	JSONArray vendorarray=new JSONArray();
	ResultSet rsvendor=stmt.executeQuery(strgetvendor);
	while(rsvendor.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("cldocno",rsvendor.getString("cldocno"));
		objtemp.put("refname",rsvendor.getString("refname"));
		objtemp.put("taxpercent",rsvendor.getInt("tax")==1 && taxconfig==1 ? taxpercent:0.0);
		vendorarray.add(objtemp);
	}
	objdata.put("fleetdata",fleetarray);
	objdata.put("drvdata",drvarray);
	objdata.put("vendordata",vendorarray);
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>