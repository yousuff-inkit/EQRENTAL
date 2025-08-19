<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String driverid=request.getParameter("driverid")==null?"":request.getParameter("driverid");
String fleetno="",fleetname="";
Connection conn=null;
ClsConnection objconn=new ClsConnection();
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select l.fleet_no,concat(veh.fleet_no,' - ',veh.flname) flname from gl_lvehassign l left join gl_vehmaster veh on l.fleet_no=veh.fleet_no where l.srno=(select max(srno) maxsrno from gl_lvehassign where drid=2 and clstatus=0)";
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		fleetno=rs.getString("fleet_no");
		fleetname=rs.getString("flname");
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(fleetno+"::"+fleetname);
%>