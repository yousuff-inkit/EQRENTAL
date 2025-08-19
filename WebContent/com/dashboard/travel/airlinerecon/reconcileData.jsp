<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
	String id=request.getParameter("id")==null?"":request.getParameter("id");
	String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
	String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	Connection conn=null;
	int errorstatus=0;
	try{
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt=conn.createStatement();
		java.sql.Date sqlfromdate=null,sqltodate=null;
		String sqltest="";
		if(!fromdate.equalsIgnoreCase("")){
			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			sqltest+=" and d.issuedate>='"+sqlfromdate+"'";
		}
		if(!todate.equalsIgnoreCase("")){
			sqltodate=objcommon.changeStringtoSqlDate(todate);
			sqltest+=" and d.issuedate<='"+sqltodate+"'";
		}
		String strsql="update ti_ticketvoucherm m left join ti_ticketvoucherD d on m.doc_no=d.rdocno"+
		" left join ti_airline a on a.doc_no=d.airlineid left join gl_limoairlinedata air on (d.ticketno=SUBSTRING_INDEX(air.documentno,' ',1))"+
		" left join my_jvtran jv on (jv.acno=1735 and jv.doc_no=d.invtrno and jv.dtype='TINV') set air.reconstatus=1"+
		" where coalesce(air.reconstatus,0)=0 and m.status=3 and d.vnddocno=89 and coalesce(jv.tr_no,0)>0 and "+
		" d.ticketno=SUBSTRING_INDEX(air.documentno,' ',1) and round(jv.dramount*jv.id,2)=round(air.netamount,2) "+sqltest;
		int update=stmt.executeUpdate(strsql);
		if(update<=0){
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