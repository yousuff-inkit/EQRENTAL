<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String agmtno=request.getParameter("docno")==null?"":request.getParameter("docno");
Connection conn=null;
java.sql.Date showdate=null;
String strshowdate="";
String showtime="";
int showagmtdate=0;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	int delcal=0,delcheck=0,delstatus=0;
	String strSql = "select (select method from gl_config where field_nme='delcal') delcal,(select method from gl_config where field_nme='closecal') closecal,"+
			" (select invdate from gl_lagmt where doc_no="+agmtno+") invdate";
	ResultSet resultSet = stmt.executeQuery(strSql);
	while(resultSet.next()){
		delcal=resultSet.getInt("delcal");
	}
	String	strdelcheck="select delstatus,delivery from gl_lagmt where doc_no="+agmtno;
	ResultSet rsdelcheck=stmt.executeQuery(strdelcheck);
	if(rsdelcheck.next()){
		if(rsdelcheck.getInt("delivery")==1){
			delcheck=rsdelcheck.getInt("delstatus");
			delstatus=rsdelcheck.getInt("delstatus");
		}
		else if(rsdelcheck.getInt("delivery")==0){
			delcheck=1;
		}
	}
	java.sql.Date indate=null,coldate=null;
	String intime="",coltime="";
	String stragmtsql="select indate,intime,coldate,coltime from gl_ragmtclosem where agmtno="+agmtno;
	ResultSet rsagmt=stmt.executeQuery(stragmtsql);
	while(rsagmt.next()){
		indate=rsagmt.getDate("indate");
		intime=rsagmt.getString("intime");
		coldate=rsagmt.getDate("coldate");
		coltime=rsagmt.getString("coltime");
	}

	
	
	if(coldate!=null && delcal==0){
		//Delivery Date And Time
		showdate=coldate;
		showtime=coltime;
	}
	else{
		//Agreement Date And Time
		showdate=indate;
		showtime=intime;
	}
	ResultSet rsconvert=stmt.executeQuery("select (select date_format('"+showdate+"','%d.%m.%Y'))strdate,(select method from gl_config where field_nme='ShowAgmtDate') showagmtdate ");
	while(rsconvert.next()){
		strshowdate=rsconvert.getString("strdate");
		showagmtdate=rsconvert.getInt("showagmtdate");
	}
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(strshowdate+"::"+showtime+"::"+showagmtdate);
%>