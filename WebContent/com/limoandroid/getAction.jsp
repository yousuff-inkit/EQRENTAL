<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%

String userid=request.getParameter("userid");
String cuser=request.getParameter("cuser");
String status=request.getParameter("status");
System.out.println("userid"+userid+"cuser:"+cuser);
String str1="";
ClsConnection  ClsConnection=new ClsConnection();
Connection conn=null;
int i=0;
String value="";
String str="";
String user="";
try
{
	conn=ClsConnection.getMyConnection();
	
	Statement stmtt = conn.createStatement();
	str1="select username from an_userregister where doc_no='"+userid+"'"; 
	ResultSet rss=stmtt.executeQuery(str1);
	while(rss.next())
	{
		user=rss.getString("username");
	}
	System.out.println("user"+user);
	Statement stmt = conn.createStatement();
	if(status.equalsIgnoreCase("Assigned"))
	{
		str="select doc_no,tasks from an_taskmanage where doc_no=1;";
	}
	else if(userid.equalsIgnoreCase(cuser) && status.equalsIgnoreCase("Accepted"))
	{
	
		str="select doc_no,tasks from an_taskmanage where doc_no!=1;";
	}
	else if(userid.equalsIgnoreCase(cuser) && status.equalsIgnoreCase("Completed"))
	{
		str="select doc_no,tasks from an_taskmanage where doc_no not in (1,2,3);";
	}
	else
	{
		str="select doc_no,tasks from an_taskmanage where doc_no not in (1,4);";
	}
	System.out.println("Action::"+str);
	
	ResultSet rs=stmt.executeQuery(str);
	
	while(rs.next())
	{
		if(i==0){
			value+=rs.getString("doc_no")+"::"+rs.getString("tasks");	
		}
		else{
			value+=","+rs.getString("doc_no")+"::"+rs.getString("tasks");
		}
		i++;
		
	}
	System.out.println("actions:"+value);

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