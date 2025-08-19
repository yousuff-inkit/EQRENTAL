<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
ClsConnection  ClsConnection=new ClsConnection();
Connection conn=null;
int i=0;
String value="";

try
{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	
	String str="select * from duration_book";
	ResultSet rs=stmt.executeQuery(str);
	
	while(rs.next())
	{
		if(i==0){
			value+=rs.getString("doc_no")+"::"+rs.getString("duration");	
		}
		else{
			value+=","+rs.getString("doc_no")+"::"+rs.getString("duration");
		}
		i++;
		
	}
	System.out.println("duration:"+value);

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