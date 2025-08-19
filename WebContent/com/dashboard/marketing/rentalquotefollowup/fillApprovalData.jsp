<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
ClsConnection objconn=new ClsConnection();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
System.out.println("Inside Approval Fill");
Connection conn=null;
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	ClsCommon objcommon=new ClsCommon();
	conn.setAutoCommit(false);
	String brhid=session.getAttribute("BRANCHID").toString();
	String userid=session.getAttribute("USERID").toString();
	
	String strgetdata="select fleet_no,qty,doc_no from gl_rentalquoted where rdocno="+docno;
	System.out.println(strgetdata);
	ResultSet rsgetdata=stmt.executeQuery(strgetdata);
	while(rsgetdata.next()){
		int qty=rsgetdata.getInt("qty");
		String fleetno=rsgetdata.getString("fleet_no");
		int detdocno=rsgetdata.getInt("doc_no");
		for(int i=1;i<=qty;i++){
			String strinsert="insert into gl_rentalquotecalc(rdocno,srno,fleet_no,detdocno) values("+docno+","+i+","+fleetno+","+detdocno+")";
			int insert=conn.createStatement().executeUpdate(strinsert);
			if(insert<=0){
				errorstatus=1;
			}
		}
	}
	
	if(errorstatus==0){
		conn.commit();
	}
	objdata.put("errorstatus",errorstatus);
}
catch(Exception e){
	errorstatus=1;
	e.printStackTrace();
}
finally{
	conn.close();
}

response.getWriter().write(objdata+"");
%>