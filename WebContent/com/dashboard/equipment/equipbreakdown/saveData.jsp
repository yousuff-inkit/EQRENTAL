<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid").toString();
String contractdocno=request.getParameter("contractdocno")==null?"":request.getParameter("contractdocno").toString();
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno").toString();
String calcdocno=request.getParameter("calcdocno")==null?"":request.getParameter("calcdocno").toString();
String date=request.getParameter("date")==null?"":request.getParameter("date").toString();
String time=request.getParameter("time")==null?"":request.getParameter("time").toString();
String amount=request.getParameter("amount")==null?"0.0":request.getParameter("amount").toString();
String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks").toString();
String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
String mode=request.getParameter("mode")==null?"":request.getParameter("mode").toString();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno").toString();

Connection conn=null;
JSONObject objdata=new JSONObject();
int errorstatus=0;
try{
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	
	if(mode.equalsIgnoreCase("1")){
		java.sql.Date sqldate=null;
		if(!date.equalsIgnoreCase("")){
			sqldate=objcommon.changeStringtoSqlDate(date);
		}
		String strmaxdocno="select coalesce(max(doc_no),0)+1 maxdocno from eq_breakdown";
		ResultSet rsmaxdocno=stmt.executeQuery(strmaxdocno);
		while(rsmaxdocno.next()){
			docno=rsmaxdocno.getString("maxdocno");
		}
		String strinsert="insert into eq_breakdown(doc_no,date, brhid, userid, contractdocno, fleet_no, calcdocno, startdate, starttime, startremarks)values("+
		""+docno+",CURDATE(),"+brhid+","+userid+","+contractdocno+","+fleetno+","+calcdocno+",'"+sqldate+"','"+time+"','"+remarks+"')";
		System.out.println(strinsert);
		int insert=stmt.executeUpdate(strinsert);
		if(insert<=0){
			errorstatus=1;
		}
	
	}
	else if(mode.equalsIgnoreCase("2")){
		java.sql.Date sqldate=null;
		if(!date.equalsIgnoreCase("")){
			sqldate=objcommon.changeStringtoSqlDate(date);
		}
		String strupdate="update eq_breakdown set enddate='"+sqldate+"',endtime='"+time+"',endremarks='"+remarks+"',clstatus=1,amount="+amount+" where doc_no="+docno;
		int update=stmt.executeUpdate(strupdate);
		if(update<=0){
			errorstatus=1;
		}
	}
	
	PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
	stmtlog.setInt(1,Integer.parseInt(docno));
	stmtlog.setInt(2,Integer.parseInt(brhid));
	stmtlog.setString(3,"BEQB");
	stmtlog.setInt(4, Integer.parseInt(userid));
	stmtlog.setInt(5, 0);
	stmtlog.setInt(6, 0);
	stmtlog.setString(7, (mode.equalsIgnoreCase("1")?"A":"C"));
	int log=stmtlog.executeUpdate();
	if(log<=0){
		errorstatus=1;
	}
	if(errorstatus==0){
		conn.commit();
	}
	
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
finally{
	conn.close();
}
objdata.put("errorstatus",errorstatus);
response.getWriter().write(objdata+"");
%>