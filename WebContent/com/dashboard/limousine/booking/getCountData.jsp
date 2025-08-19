<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String result="",sqltest="";
int errorstatus=0;
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement(); 
	java.sql.Date sqlfromdate=null;
	java.sql.Date sqltodate=null;
	if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
		sqltest+=" and brhid="+branch+"";     
	}
	if(!fromdate.equalsIgnoreCase("")){
		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		sqltest+=" and pickupdate>='"+sqlfromdate+"'";
	}
	if(!todate.equalsIgnoreCase("")){
		sqltodate=objcommon.changeStringtoSqlDate(todate);
		sqltest+=" and pickupdate<='"+sqltodate+"'";
	}
	
	String strcountdata="select (select count(*) from gl_limomanagement where bstatus=2 and confirm=0 "+sqltest+")  confirmation,(select count(*) from gl_limomanagement where bstatus=2 and confirm=0 "+sqltest+")  jobassn,(select count(*) from gl_limomanagement where bstatus=4 and confirm=0 "+sqltest+")  chgtime";  
	ResultSet rs=stmt.executeQuery(strcountdata);  
	while(rs.next()){       
		result=rs.getString("confirmation")+"::"+rs.getString("jobassn")+"::"+rs.getString("chgtime");
	}  
}       
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(result);
%>