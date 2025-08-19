<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<%
String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks");   
String statusid=request.getParameter("statusid")==null?"0":request.getParameter("statusid");
String rowno=request.getParameter("rowno")==null?"0":request.getParameter("rowno"); 
int errorstatus=0;
int sqlupdate=0;      
String strsql="";
Connection conn=null;
Statement stmt=null;
try{
	ClsConnection objconn=new ClsConnection();    
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	 stmt=conn.createStatement(); 
	 java.sql.Date sqldate = null;  
    String[] rownoarray = rowno.split(",");
    String brhid=session.getAttribute("BRANCHID")==null?"0":session.getAttribute("BRANCHID").toString();
    String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
    String username=session.getAttribute("USERNAME")==null?"0":session.getAttribute("USERNAME").toString();
    for (int i = 0; i < rownoarray.length; i++) {                          
		String rownoss=rownoarray[i];	
		if(!(rownoss.equalsIgnoreCase(""))){
			strsql="update gl_limomanagement set bstatus='"+statusid+"',remarks='"+remarks+"' where rowno='"+rownoss+"'";	
		 	sqlupdate=stmt.executeUpdate(strsql);     
			if(sqlupdate<=0){
				errorstatus=1;
			}
			String strgetdetail="select docno,job from gl_limomanagement where rowno='"+rownoss+"'";
			int bookdocno=0;
			String jobname="";
			ResultSet rs=stmt.executeQuery(strgetdetail);
			while(rs.next()){
				bookdocno=rs.getInt("docno");
				jobname=rs.getString("job");
			}
			String strgetstatus="select name from gl_limostatusdet where doc_no="+statusid;
			ResultSet rsstatus=stmt.executeQuery(strgetstatus);
			String status="";
			while(rsstatus.next()){
				status=rsstatus.getString("name");
			}
			String systemnote="Status Updation to "+status+" of "+bookdocno+" - "+jobname+" by "+username;
			String strinsertlog="insert into gl_limomgmtlog(bookdocno, jobname, brhid, userid, logdate,remarks, systemremarks)values("+
			""+bookdocno+",'"+jobname+"',"+brhid+","+userid+",now(),'"+remarks+"','"+systemnote+"')";
			int insertlog=stmt.executeUpdate(strinsertlog);
			if(insertlog<=0){
				errorstatus=1;
			}
		}
    }
	if(sqlupdate<=0){ 
		errorstatus=1;
	}
}
catch(Exception e){  
	e.printStackTrace();
}finally {
    if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
}
response.getWriter().write(errorstatus+"");
%>