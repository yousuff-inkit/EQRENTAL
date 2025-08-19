
<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon(); 
String documenttype = request.getParameter("documenttype")==null?"":request.getParameter("documenttype").trim();
String branch = request.getParameter("branch")==null?"":request.getParameter("branch").trim();
String authority=request.getParameter("authority")==null?"":request.getParameter("authority").trim();
String cmbtype=request.getParameter("cmbtype")==null?"":request.getParameter("cmbtype").trim();
String vehicle=request.getParameter("vehicle")==null || request.getParameter("vehicle").equalsIgnoreCase("")?"0":request.getParameter("vehicle").trim();
String driver=request.getParameter("driver")==null || request.getParameter("driver").equalsIgnoreCase("")?"0":request.getParameter("driver").trim();
String passno=request.getParameter("passno")==null?"":request.getParameter("passno").trim();
String issuedate= request.getParameter("issuedate")==null?"":request.getParameter("issuedate").trim();
String expirydate = request.getParameter("expirydate")==null?"":request.getParameter("expirydate").trim();
String docno = request.getParameter("docno")==null?"":request.getParameter("docno").trim();
String notes= request.getParameter("notes")==null?"":request.getParameter("notes").trim();
String desc = request.getParameter("desc")==null?"":request.getParameter("desc").trim();
String extendexpirydate = request.getParameter("extendexpirydate")==null?"":request.getParameter("extendexpirydate").trim();
String userid=session.getAttribute("USERID").toString();
String hiddrivertype = request.getParameter("hiddrivertype")==null?"":request.getParameter("hiddrivertype").trim();

Connection conn=null;
String errorstatus="0";
try{
	java.sql.Date sqlexpirydate=null;
	java.sql.Date sqlissuedate=null;
	java.sql.Date sqlextendexpirydate=null;
	
	if(!expirydate.equalsIgnoreCase(""))
	{
		sqlexpirydate=objcommon.changeStringtoSqlDate(expirydate);
	}
	if(!issuedate.equalsIgnoreCase(""))
	{
		sqlissuedate=objcommon.changeStringtoSqlDate(issuedate);
	}
	if(!extendexpirydate.equalsIgnoreCase(""))
	{
		sqlextendexpirydate=objcommon.changeStringtoSqlDate(extendexpirydate);
	}
		
	int val=0;
	int maxdocno=0; 
	conn = objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt = conn.createStatement ();
	if(documenttype.equalsIgnoreCase("1")){
		String getdocno="select coalesce(max(doc_no)+1,1) docNo from gl_securitypassmgmt"	;
		ResultSet result = stmt.executeQuery(getdocno); 
   		while(result.next()){
   	 		maxdocno=result.getInt("docNo");
   		}
		String insql="insert into gl_securitypassmgmt(doc_no, authid, type, fleet_no, drvid , drvtype , passno, description, issuedate, expirydate, notes, "+
   		" brhid, userid, status, autodate) values("+maxdocno+","+authority+",'"+cmbtype+"',"+vehicle+","+driver+",'"+hiddrivertype+"','"+passno+"','"+desc+"','"+sqlissuedate+"',"+
		" '"+sqlexpirydate+"','"+notes+"',"+branch+","+userid+",3,CURDATE())";
		System.out.println(insql);
		int insertval= stmt.executeUpdate(insql);
		if(insertval<=0){
			errorstatus="1";
		}
		if(insertval>0){
			String datalog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+maxdocno+"','1','BSPM',now(),'"+userid+"','A')";
			int loginsert=stmt.executeUpdate(datalog);			
			if(loginsert<=0){
				errorstatus="1";
			}
		}
	}
	else if(documenttype.equalsIgnoreCase("2")){
		String insql="update gl_securitypassmgmt set authid="+authority+",type='"+cmbtype+"', fleet_no="+vehicle+", drvid="+driver+", drvtype='"+hiddrivertype+"' , passno='"+passno+"', description='"+desc+"', issuedate='"+sqlissuedate+"', expirydate='"+sqlexpirydate+"', notes='"+notes+"' where doc_no="+docno;
		System.out.println(insql);
		int editval= stmt.executeUpdate(insql);
		if(editval<=0){
			errorstatus="1";
		}
		if(editval>=0){
			String datalog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','1','BSPM',now(),'"+userid+"','E')";
			int loginsert=stmt.executeUpdate(datalog);
			if(loginsert<=0){
				errorstatus="1";
			}
		}
		
		}
	if(documenttype.equalsIgnoreCase("3")){
		String insql="update gl_securitypassmgmt set expirydate='"+sqlextendexpirydate+"'  where doc_no="+docno+"";
		System.out.println(insql);
		int editval= stmt.executeUpdate(insql);
		if(editval<=0){
			errorstatus="1";
		}
		if(editval>=0){
			String datalog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','1','BSPM',now(),'"+userid+"','E')";
			int loginsert=stmt.executeUpdate(datalog);
			if(loginsert<=0){
				errorstatus="1";
			}
		}
	}
	if(!errorstatus.equalsIgnoreCase("1")){
		conn.commit();
		conn.close();
	}
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
	response.getWriter().write(errorstatus);
%>
