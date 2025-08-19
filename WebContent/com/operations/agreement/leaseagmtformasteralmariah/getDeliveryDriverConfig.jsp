<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>;
<%@page import="javax.servlet.http.HttpSession"%>;

<%
Connection conn=null;
int driverconfig=0,invruleoveride=0,rentalagentdocno=0;
String rentalagent="";
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String str="select (select method from gl_config where field_nme='agmtDelDriver') agmtDelDriver,(select method from gl_config where field_nme='clientInvoiceRuleOverride') invruleoverride ";
	ResultSet rs=stmt.executeQuery(str);
	while(rs.next()){
		driverconfig=rs.getInt("agmtDelDriver");
		invruleoveride=rs.getInt("invruleoverride");
	}
	String strrentalagent="select doc_no,sal_name from my_salesman where sal_type='RLA' and status=3 and salesuserlink="+session.getAttribute("USERID").toString();
	System.out.println(strrentalagent);
	ResultSet rsrentalagent=stmt.executeQuery(strrentalagent);
	while(rsrentalagent.next()){
		rentalagentdocno=rsrentalagent.getInt("doc_no");
		rentalagent=rsrentalagent.getString("sal_name");
	}
	stmt.close();
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
//System.out.println("asd:"+driverconfig+"::"+invruleoveride+"::"+rentalagentdocno+"::"+rentalagent);
response.getWriter().write(driverconfig+"::"+invruleoveride+"::"+rentalagentdocno+"::"+rentalagent+":: ");
%>