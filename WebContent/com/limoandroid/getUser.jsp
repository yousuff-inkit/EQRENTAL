<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
ClsConnection  ClsConnection=new ClsConnection();
Connection conn=null;

String userid=request.getParameter("userid");
int i=0;
String value="";

try
{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	
	/* String str="select doc_no,username from an_userregister where type='app'and doc_no not in('"+userid+"');"; */
	String str="select doc_no,username from an_userregister where dtype='app';";
	
	//System.out.println("user::"+str);
	
	ResultSet rs=stmt.executeQuery(str);
	
	while(rs.next())
	{
		if(i==0){
			value+=rs.getString("doc_no")+"::"+rs.getString("username");	
		}
		else{
			value+=","+rs.getString("doc_no")+"::"+rs.getString("username");
		}
		i++;
		
	}
	//System.out.println("user:"+value);

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