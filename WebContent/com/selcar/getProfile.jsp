<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%

ClsConnection  ClsConnection=new ClsConnection();
String uid=request.getParameter("userid");
System.out.println("iddd::"+uid);

String uname="";
String email="";
String mobile="";
String value="welcome";
Connection conn=null;
try
{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	
	String str="select name, email,mobile_no from user_register where doc_no='"+uid+"'";
	
	ResultSet rs=stmt.executeQuery(str);
	while(rs.next())
	{
		uname=rs.getString("name");
		email=rs.getString("email");
		mobile=rs.getString("mobile_no");
	}
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	conn.close();
}
System.out.println("nm"+uname+"mail"+email+"mbl"+mobile);
response.getWriter().write(value+"::"+uname+"::"+email+"::"+mobile);

%>