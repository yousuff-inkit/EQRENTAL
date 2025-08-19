<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Random"%>

<%
ClsEncrypt objencrypt=new ClsEncrypt();


String newpass=request.getParameter("newpass");
String rnewpass=objencrypt.encrypt(newpass);
String confirmpass=request.getParameter("confirmpass");
String rconfirmpass=objencrypt.encrypt(confirmpass);
String email=request.getParameter("email");


System.out.println("newpass="+newpass+"rnewpass=="+rnewpass+"confirmpass=="+confirmpass+"rconfirmpass=="+rconfirmpass);
ClsConnection  ClsConnection=new ClsConnection();
Connection conn=null;
int val=0;
String method="";



String emails="";

try
{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();


	String str="select email from user_register where email='"+email+"' ";
	ResultSet rs=stmt.executeQuery(str);
	
	
	while(rs.next())
	{
		 emails=rs.getString("email"); 
	}
	
	if(newpass.equalsIgnoreCase(confirmpass)){
		
		String sqls="update user_register set pass='"+rconfirmpass+"' where email='"+emails+"'";
		val=stmt.executeUpdate(sqls);
		if(val>0){
			method="1";
		}
		
		
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