<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Random"%>

<%

String rescode=request.getParameter("code");
String code="a"+rescode;
String email=request.getParameter("email");

ClsConnection  ClsConnection=new ClsConnection();
Connection conn=null;
int val=0;
String method="";



String resetotp="";

try
{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();


	String str="select resetotp from user_register where email='"+email+"' ";
	ResultSet rs=stmt.executeQuery(str);
	
	
	while(rs.next())
	{
		 resetotp=rs.getString("resetotp"); 
	}
	
	if(code.equalsIgnoreCase(resetotp)){
		
			method="1";
		
	}
	
	
	
	System.out.println("method="+method);

}
catch(Exception e)
{
	e.printStackTrace();

}
finally
{
	conn.close();
}

response.getWriter().write(method);
%>