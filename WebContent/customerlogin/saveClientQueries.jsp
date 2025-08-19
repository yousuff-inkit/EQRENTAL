<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.operations.crm.callregister.ClsCallRegisterAction"%>
<%@page import="com.operations.crm.callregister.ClsCallRegisterDAO"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String fleetno=request.getParameter("regno")==null?"":request.getParameter("regno").toString();
String calledby=request.getParameter("calledby")==null?"":request.getParameter("calledby").toString();
String mobile=request.getParameter("mobile")==null?"":request.getParameter("mobile").toString();
String place=request.getParameter("place")==null?"":request.getParameter("place").toString();
String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks").toString();
String date=request.getParameter("date")==null?"":request.getParameter("date").toString();
String type=request.getParameter("type")==null?"":request.getParameter("type").toString();
String cldocno=session.getAttribute("CLDOCNO")==null?"":session.getAttribute("CLDOCNO").toString();
System.out.println("Inside AJAX");
Connection conn=null;
JSONObject objdata=new JSONObject();
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	ClsCallRegisterDAO calldao=new ClsCallRegisterDAO();
	String strmisc="select curdate() basedate,veh.REG_NO from gl_vehmaster veh left join gl_vehplate plt on veh.pltid=plt.doc_no where veh.statu=3 and veh.fleet_no="+fleetno;
	java.sql.Date sqlbasedate=null;
	String regno="";
	ResultSet rsmisc=conn.createStatement().executeQuery(strmisc);
	
	while(rsmisc.next()){
		sqlbasedate=rsmisc.getDate("basedate");
		regno=rsmisc.getString("reg_no");
	}
	
	java.sql.Date sqldatetime=null;
	SimpleDateFormat sdf1 = new SimpleDateFormat("dd.MM.yyyy HH:mm");
	java.util.Date datetime = sdf1.parse(date);
	sqldatetime= new java.sql.Date(datetime.getTime());
	
	int insertval=calldao.insert(sqlbasedate, "ECR", regno, fleetno, Integer.parseInt(cldocno),calledby, mobile, "0", type, sqldatetime, date, remarks, place, session, request,"A");
	System.out.println("Call Register Doc:"+insertval);
	if(insertval<=0){
		errorstatus=1;
		objdata.put("feeddocno",insertval);
	}
	else{
		objdata.put("feeddocno",insertval);
	}
	objdata.put("errorstatus",errorstatus);
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
	objdata.put("errorstatus",errorstatus);
}
finally{
	conn.close();
}

response.getWriter().write(objdata+"");
%>