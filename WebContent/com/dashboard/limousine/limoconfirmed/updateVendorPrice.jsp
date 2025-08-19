<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String bookdocno=request.getParameter("bookdocno")==null?"":request.getParameter("bookdocno");
String docname=request.getParameter("docname")==null?"":request.getParameter("docname");
String vendoramount=request.getParameter("vendoramount")==null?"0.0":request.getParameter("vendoramount");
String vendordiscount=request.getParameter("vendordiscount")==null?"0.0":request.getParameter("vendordiscount");
String vendornetamount=request.getParameter("vendornetamount")==null?"0.0":request.getParameter("vendornetamount");

Connection conn=null;
int errorstatus=0;
try{
	if(!bookdocno.equalsIgnoreCase("")){
		ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt=conn.createStatement();
		String strsql="update gl_limomanagement set vendoramount="+vendoramount+",vendordiscount="+vendordiscount+",vendornetamount="+vendornetamount+" where docno="+bookdocno+" and job='"+docname+"'";
		int value=stmt.executeUpdate(strsql);	
		if(value<=0){
			errorstatus=1;
		}
		if(errorstatus==0){
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