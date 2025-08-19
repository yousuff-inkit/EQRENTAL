<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String strgridarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");
ClsConnection objconn=new ClsConnection();  
Connection conn=null;
String msg="";
int temp=0;
int insertval=0;
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	String brhid=session.getAttribute("BRANCHID")==null?"0":session.getAttribute("BRANCHID").toString();
    String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
    String username=session.getAttribute("USERNAME")==null?"0":session.getAttribute("USERNAME").toString();
	Statement stmt=conn.createStatement();
	for(int i=0;i<strgridarray.split(",").length;i++){
		String temparray[]=strgridarray.split(",")[i].split("::");
		String strsql="update gl_limomanagement set confirm=1 where docno="+temparray[0]+" and job='"+temparray[1]+"'";     
		insertval=stmt.executeUpdate(strsql);
		if(insertval<=0){
			errorstatus=1;
		}
		if(insertval>0){      
			String strsql2="update gl_limobookm set confirm=1 where doc_no="+temparray[0]+"";     
			insertval=stmt.executeUpdate(strsql2);
			if(insertval<=0){
				errorstatus=1;
			}
		}
		String strgetdetail="select docno,job from gl_limomanagement where docno="+temparray[0]+" and job='"+temparray[1]+"'";
		int bookingdocno=0;
		String jobname="";
		ResultSet rs=stmt.executeQuery(strgetdetail);
		while(rs.next()){
			bookingdocno=rs.getInt("docno");
			jobname=rs.getString("job");
		}
		String systemnote="Confirmation of "+bookingdocno+" - "+jobname+" by "+username;
		String strinsertlog="insert into gl_limomgmtlog(bookdocno, jobname, brhid, userid, logdate,systemremarks)values("+
		""+bookingdocno+",'"+jobname+"',"+brhid+","+userid+",now(),'"+systemnote+"')";
		int insertlog=stmt.executeUpdate(strinsertlog);
		if(insertlog<=0){
			errorstatus=1;
		}
	}
	if(errorstatus==0){
		conn.commit();
	}
	response.getWriter().print(insertval);           
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
%>