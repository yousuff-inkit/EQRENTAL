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
	java.sql.Date odate=null,deldate=null;
	String otime="",deltime="";
	String stragmtsql="select outdate,outtime,outkm,outfuel from gl_lagmt where doc_no="+agmtno;
	ResultSet rsagmt=stmt.executeQuery(stragmtsql);
	while(rsagmt.next()){
		odate=rsagmt.getDate("outdate");
		otime=rsagmt.getString("outtime");
	}

	if(delstatus==1){
		String strmovsql="select mov.din,mov.tin,mov.kmin,mov.fin from gl_vmove mov left join gl_lagmt agmt "+
					" on (mov.rdocno=agmt.doc_no and mov.rdtype='LAG') where mov.rdtype='LAG' and mov.rdocno="+agmtno+" and mov.trancode='DL' and mov.repno=0";
		ResultSet rsmov=stmt.executeQuery(strmovsql);
		while(rsmov.next()){
			deldate=rsmov.getDate("din");
			deltime=rsmov.getString("tin");
		}
	}
	
	if(deldate!=null && delcal==0){
		//Delivery Date And Time
		showdate=deldate;
		showtime=deltime;
	}
	else{
		//Agreement Date And Time
		showdate=odate;
		showtime=otime;
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