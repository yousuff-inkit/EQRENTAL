<%@page import="java.util.ArrayList"%>
<%@page import="com.limousine.limobooking.ClsLimoBookingDAO"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String docname=request.getParameter("docname")==null?"":request.getParameter("docname");
String pickuplocationid=request.getParameter("pickuplocationid")==null?"":request.getParameter("pickuplocationid");
String pickuplocation=request.getParameter("pickuplocation")==null?"":request.getParameter("pickuplocation");
String pickupaddress=request.getParameter("pickupaddress")==null?"":request.getParameter("pickupaddress");
String dropofflocationid=request.getParameter("dropofflocationid")==null?"":request.getParameter("dropofflocationid");
String dropoffaddress=request.getParameter("dropoffaddress")==null?"":request.getParameter("dropoffaddress");
String dropofflocation=request.getParameter("dropofflocation")==null?"":request.getParameter("dropofflocation");
String brand=request.getParameter("brand")==null?"":request.getParameter("brand");
String brandid=request.getParameter("brandid")==null?"":request.getParameter("brandid");
String modelid=request.getParameter("modelid")==null?"":request.getParameter("modelid");
String model=request.getParameter("model")==null?"":request.getParameter("model");
String tarifdocno=request.getParameter("tarifdocno")==null?"":request.getParameter("tarifdocno");
String tarifdetaildocno=request.getParameter("tarifdetaildocno")==null?"":request.getParameter("tarifdetaildocno");
String bookdocno=request.getParameter("bookdocno")==null?"":request.getParameter("bookdocno");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String estdistance=request.getParameter("estdistance")==null?"":request.getParameter("estdistance");
String esttime=request.getParameter("esttime")==null?"":request.getParameter("esttime");
String tarif=request.getParameter("tarif")==null?"":request.getParameter("tarif");
String exdistancerate=request.getParameter("exdistancerate")==null?"":request.getParameter("exdistancerate");
String extimerate=request.getParameter("extimerate")==null?"":request.getParameter("extimerate");
String groupid=request.getParameter("groupid")==null?"":request.getParameter("groupid");
ClsConnection objconn=new ClsConnection();
Connection conn=null;
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	/* int groupid=0;
	String strgetgroup="select vgrpid from gl_vehmaster where brdid="+brandid+" and vmodid="+modelid;
	ResultSet rsgetgroup=stmt.executeQuery(strgetgroup);
	while(rsgetgroup.next()){
		groupid=rsgetgroup.getInt("vgrpid");
	} */
	String strupdate="update gl_limobooktransfer set pickuplocid="+pickuplocationid+", pickupadress='"+pickupaddress+"', "+
	" dropfflocid="+dropofflocationid+", dropoffaddress='"+dropoffaddress+"', brandid="+brandid+", modelid="+modelid+",tarifdocno="+tarifdocno+","+
	" gid="+groupid+",tarifdetaildocno="+tarifdetaildocno+",estdist="+estdistance+", esttime='"+esttime+"',tarif="+tarif+", exdistrate="+exdistancerate+",extimerate="+extimerate+",detailupdate=1 where bookdocno="+bookdocno+" and docname='"+docname+"'";
	System.out.println(strupdate);
	int updatetransfer=stmt.executeUpdate(strupdate);
	if(updatetransfer<=0){
		errorstatus=1;
	}
	String strupdatemgmt="update gl_limomanagement set plocation='"+pickuplocation+"',paddress='"+pickupaddress+"',dlocation='"+dropofflocation+"',daddress='"+dropoffaddress+"',brand='"+brand+"',model='"+model+"' where docno="+bookdocno+" and job='"+docname+"'";
	System.out.println(strupdatemgmt);
	int updatemgmt=stmt.executeUpdate(strupdatemgmt);
	if(updatemgmt<=0){
		errorstatus=1;
	}
	if(errorstatus==0){
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>