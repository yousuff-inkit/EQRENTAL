<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String masterrefno=request.getParameter("masterrefno")==null || request.getParameter("masterrefno")==""?"0":request.getParameter("masterrefno");
String fleetno=request.getParameter("fleetno")==null || request.getParameter("fleetno")==""?"0":request.getParameter("fleetno");
String brand="",model="";
int brandid=0,modelid=0,mastervehqty=0,agmtvehqty=0;   
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	
	Statement stmt=conn.createStatement();
	String strgetbrand="select veh.brdid,veh.vmodid,brd.brand_name,model.vtype from gl_vehmaster veh left join gl_vehbrand brd on "+
	" veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no where fleet_no="+fleetno;
	System.out.println(strgetbrand);
	ResultSet rsgetbrand=stmt.executeQuery(strgetbrand);
	while(rsgetbrand.next()){
		brandid=rsgetbrand.getInt("brdid");
		modelid=rsgetbrand.getInt("vmodid");
		brand=rsgetbrand.getString("brand_name");
		model=rsgetbrand.getString("vtype");
	}
	String strgetqty="select (select qty from gl_masterlagd where rdocno="+masterrefno+" and brdid="+brandid+" and modelid="+modelid+") mastervehqty,"+
	" (select count(*) from gl_lagmt agmt left join gl_vehmaster veh on (if(agmt.perfleet=0,agmt.tmpfleet,agmt.perfleet)=veh.fleet_no) where "+
	" agmt.masterrefno="+masterrefno+" and veh.brdid="+brandid+" and veh.vmodid="+modelid+") agmtvehqty";
	System.out.println(strgetqty);   
	ResultSet rsgetqty=stmt.executeQuery(strgetqty);
	while(rsgetqty.next()){
		mastervehqty=rsgetqty.getInt("mastervehqty");
		agmtvehqty=rsgetqty.getInt("agmtvehqty");
	}
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(brand+"::"+model+"::"+mastervehqty+"::"+agmtvehqty);
%>