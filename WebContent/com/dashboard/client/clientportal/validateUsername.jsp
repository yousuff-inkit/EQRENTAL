<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
int errorstatus=0;
String clientusername=request.getParameter("clientusername")==null?"":request.getParameter("clientusername").toString();
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno").toString();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String str="select count(*) rowcount from my_acbook where clientusername='"+clientusername+"' and status=3 and dtype='CRM' and cldocno<>"+cldocno+"";
	int rowcount=0;
	ResultSet rs=stmt.executeQuery(str);
	while(rs.next()){
		rowcount=rs.getInt("rowcount");
	}
	if(rowcount>0){
		errorstatus=1;
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