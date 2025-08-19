<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%

String doc=request.getParameter("doc");

System.out.println(doc);

ClsConnection  ClsConnection=new ClsConnection();
Connection conn=null;
int i=0;
String value="";

try
{
	conn=ClsConnection.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt = conn.createStatement();
	
	String str="update an_taskcreation set act_status='Accepted' where doc_no='"+doc+"'";
	
	System.out.println("Action::"+str);
	
	i=stmt.executeUpdate(str);
	
	System.out.println("update::"+i);
	if(i>0)
	{
		value="1";
		conn.commit();
	}
	else
	{
		value="0";
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

response.getWriter().write(value);
%>