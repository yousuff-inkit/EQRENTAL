<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
String delfleetno=request.getParameter("delfleetno")==null?"":request.getParameter("delfleetno").toString();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno").toString();
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	//Getting Fleets
	String strgetdelstart="select dout,tout,kmout from gl_vmove where fleet_no="+delfleetno+" and rdocno="+docno+" and rdtype='ERC'";
	java.sql.Date sqldate=null;
	String starttime="";
	String startkm="0";
	ResultSet rs=stmt.executeQuery(strgetdelstart);
	while(rs.next()){
		sqldate=rs.getDate("dout");
		starttime=rs.getString("tout");
		startkm=rs.getString("kmout");
	}
	objdata.put("delstartdate",sqldate.toString());
	objdata.put("delstarttime",starttime);
	objdata.put("delstartkm",startkm);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>