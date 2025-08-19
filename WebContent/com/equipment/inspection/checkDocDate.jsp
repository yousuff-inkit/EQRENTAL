<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%String docdate=request.getParameter("docdate")==null?"":request.getParameter("docdate");
Connection conn=null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
int result=0;
try{
	java.sql.Date sqldate=null;
	if(!docdate.equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(docdate);
	}
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select if(a.sqldate<a.onemonthbackdate,0,1) result from (select '"+sqldate+"' sqldate,date_sub(curdate(),interval 1 month) onemonthbackdate) a";
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		result=rs.getInt("result");
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(result+"");
%>