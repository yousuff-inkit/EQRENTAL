<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String duedate=request.getParameter("duedate")==null?"":request.getParameter("duedate");
	String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
	java.sql.Date sqlduedate=null,sqloldduedate=null;
	if(!duedate.equalsIgnoreCase("") && duedate!=null){
		sqlduedate=objcommon.changeStringtoSqlDate(duedate);
	}
	String strsql="select duedate from gl_lagmt where status=3 and doc_no="+docno;
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		sqloldduedate=rs.getDate("duedate");
	}
	System.out.println(sqlduedate.compareTo(sqloldduedate));
	System.out.println(sqlduedate+"///"+sqloldduedate);
	if(sqlduedate.compareTo(sqloldduedate)<0){
		errorstatus=-1;
	}
	else{
		String strupdate="update gl_lagmt set duedate='"+sqlduedate+"' where status=3 and doc_no="+docno;
		int updateval=stmt.executeUpdate(strupdate);
		if(updateval<0){
			errorstatus=0;
		}
		else{
			
			errorstatus=1;
			conn.commit();
		}
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