<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
	JSONObject objdata=new JSONObject();
	Connection conn=null;
	try{
		ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		String strgetbranch="select branchname name,doc_no docno from my_brch where status=3";
		ResultSet rsgetbranch=stmt.executeQuery(strgetbranch);
		JSONArray brancharray=new JSONArray();
		while(rsgetbranch.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("name",rsgetbranch.getString("name"));
			objtemp.put("docno",rsgetbranch.getString("docno"));
			brancharray.add(objtemp);
		}
		String strgetfleet="select concat(fleet_no,' - ',reg_no,' ',flname) name,fleet_no fleetno from gl_vehmaster where statu=3 and fstatus<>'Z'";
		ResultSet rsgetfleet=stmt.executeQuery(strgetfleet);
		JSONArray fleetarray=new JSONArray();
		while(rsgetfleet.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("name",rsgetfleet.getString("name"));
			objtemp.put("fleetno",rsgetfleet.getString("fleetno"));
			fleetarray.add(objtemp);
		}
		objdata.put("branchdata",brancharray);
		objdata.put("fleetdata",fleetarray);
		conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
	response.getWriter().write(objdata+"");
%>