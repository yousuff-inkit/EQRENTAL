<%@page import="com.dashboard.equipment.equiputildownload.ClsEquipUtilDownloadDAO"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String contractdocno=request.getParameter("contractdocno")==null?"":request.getParameter("contractdocno").toString();
String collectqty=request.getParameter("collectqty")==null?"":request.getParameter("collectqty").toString();
String assetgrpdocno=request.getParameter("assetgrpdocno")==null?"":request.getParameter("assetgrpdocno").toString();
String cablerowno=request.getParameter("cablerowno")==null?"":request.getParameter("cablerowno").toString();
Connection conn=null;
JSONObject objdata=new JSONObject();
int errorstatus=0;
try{
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	
	String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
	
	//Fetching Contract Branch
	
	int brhid=0;
	String strfetchbranch="select brhid from gl_rentalcontractm where doc_no="+contractdocno;
	ResultSet rsfetchbranch=stmt.executeQuery(strfetchbranch);
	while(rsfetchbranch.next()){
		brhid=rsfetchbranch.getInt("brhid");
	}
	String strinsert="insert into my_cableissue(assetgrpid,contractdocno,edate,userid,qty,status)values("+assetgrpdocno+","+contractdocno+",now(),"+userid+",("+collectqty+"*-1),3)";
	int insert=stmt.executeUpdate(strinsert);
	if(insert<=0){
		System.out.println("Master Insert Error");
		errorstatus=1;
	}
	
	String strupdate="update my_cableissue set collectqty="+collectqty+" where rowno="+cablerowno;
	int update=stmt.executeUpdate(strupdate);
	if(update<0){
		System.out.println("Collection Quantity Update Error");
		errorstatus=1;
	}
	
	PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
	stmtlog.setInt(1,Integer.parseInt(cablerowno));
	stmtlog.setInt(2,brhid);
	stmtlog.setString(3,"BECM");
	stmtlog.setInt(4, Integer.parseInt(userid));
	stmtlog.setInt(5, 0);
	stmtlog.setInt(6, 0);
	stmtlog.setString(7, "A");
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