<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
Connection conn=null;
double balance=0.0;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select round(sum(j.dramount),2) balance,j.acno from my_jvtran j left join my_head h on h.doc_no=j.acno and h.atype='AR' left join my_acbook ac on (h.doc_no=ac.acno) where "+
			" j.status=3 and j.yrid=0 and ac.cldocno="+cldocno+" group by j.acno";
	// System.out.println("==== "+strsql);
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		balance=rs.getDouble("balance");
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(balance+"");
%>