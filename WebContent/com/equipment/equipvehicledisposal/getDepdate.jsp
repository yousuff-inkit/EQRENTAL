<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.ClsCommon"%>

<%
JSONObject objdata=new JSONObject();
Connection conn=null;
ClsConnection objconn=new ClsConnection();
conn=objconn.getMyConnection();
Statement stmtfleet=conn.createStatement();
ClsCommon objcommon=new ClsCommon();

String fleet=request.getParameter("fleet")==null?"0":request.getParameter("fleet");
String saledate=request.getParameter("saledate")==null?"0":request.getParameter("saledate");

try{
	java.sql.Date deprdate=null;
	double amt=0.00;
	int monthdiff=0;
	java.sql.Date docdate=null;
	if(!(saledate.equalsIgnoreCase(""))){
		docdate=objcommon.changeStringtoSqlDate(saledate);
	}
	String strfleet="select datediff(depr_date,'"+docdate+"') monthdiff,depr_date,sum(e.dramount) amt from gl_equipmaster g left join eq_assettran e on e.fleet_no=g.fleet_no "
			+" where g.fleet_no="+fleet;
	System.out.println("strfleet==="+strfleet);
	ResultSet rsfleet=stmtfleet.executeQuery(strfleet);
	if(rsfleet.next()){
		monthdiff=rsfleet.getInt("monthdiff");
		amt=rsfleet.getDouble("amt");
		deprdate=rsfleet.getDate("depr_date");

	}
	response.getWriter().write(monthdiff+"::"+amt+"::"+deprdate+"::");
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>