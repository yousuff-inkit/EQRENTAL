<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
ClsConnection  ClsConnection=new ClsConnection();
Connection conn=null;

int i=0;
String value="";
int telid=0,salid=0;
String sqltext="";
String userid=request.getParameter("userid");

try
{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
Statement stmtt = conn.createStatement();
	

	 String str="select rowno from an_starttripdet"; 
     System.out.println("user::"+str);
	
	ResultSet rs=stmt.executeQuery(str);
	
	while(rs.next())
	{
		if(i==0){
			value+=rs.getString("rowno");	
		}
		else{
			value+=","+rs.getString("rowno");
		}
		i++;
		
	}
	System.out.println("enq:"+value);

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