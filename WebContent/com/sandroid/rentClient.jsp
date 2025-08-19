<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
ClsConnection  ClsConnection=new ClsConnection();
Connection conn=null;
int i=0;
String value="";
String client=request.getParameter("cl");
System.out.println("doc"+client);

try
{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	String sqltest="";
	
	if(!client.equalsIgnoreCase("")){
		sqltest="  and refname like '"+client+"%'";
	}
	
	String str="select doc_no,refname from my_acbook where dtype='CRM' and status=3 ";
	//+sqltest;
	//+" limit 10"
	System.out.println("str:"+str);
	ResultSet rs=stmt.executeQuery(str);
	
	while(rs.next())
	{
		if(i==0){
			value+=rs.getString("doc_no")+"::"+rs.getString("refname");	
		}
		else{
			value+=","+rs.getString("doc_no")+"::"+rs.getString("refname");
		}
		i++;
		
	}
	System.out.println("refname:"+value);

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