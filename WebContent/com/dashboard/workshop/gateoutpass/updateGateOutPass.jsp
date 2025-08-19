
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
String outdate=request.getParameter("outdate")==null?"":request.getParameter("outdate");
String outtime=request.getParameter("outtime")==null?"":request.getParameter("outtime");
String amount=request.getParameter("amount")==null?"":request.getParameter("amount");
String clientinvoice=request.getParameter("clientinvoice")==null?"0":request.getParameter("clientinvoice");
String outremarks=request.getParameter("remarks")==null?"":request.getParameter("remarks");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
Connection conn=null;
String status="";
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	java.sql.Date sqloutdate=null;
	if(!outdate.equalsIgnoreCase("")){
		sqloutdate=objcommon.changeStringtoSqlDate(outdate);
	}
	if(amount.equalsIgnoreCase("")){
		amount="0.0";
	}
	int fleetno=0;
	String strfleetno="select fleet_no from gl_workgateinpassm where doc_no="+gatedocno+" and brhid="+branch;
	ResultSet rsfleet=stmt.executeQuery(strfleetno);
	while(rsfleet.next()){
		fleetno=rsfleet.getInt("fleet_no");
	}
	String str="update gl_workgateinpassm set clientinvoice="+clientinvoice+",processstatus=3,outstatus=1,outdate='"+sqloutdate+"',outtime='"+outtime+"',invamount="+amount+",outremarks='"+outremarks+"' where doc_no="+gatedocno+" and brhid="+branch;
	System.out.println(str);
	int updateval=stmt.executeUpdate(str);
	if(updateval>0){
		String strupdateveh="update gl_equipmaster set gatestatus=0 where fleet_no="+fleetno;
		int updateveh=stmt.executeUpdate(strupdateveh);
		if(updateveh>0){
			conn.commit();
			status=updateval+"";
		}
	}
	else{
		status="0";
	}
	
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(status);
%>