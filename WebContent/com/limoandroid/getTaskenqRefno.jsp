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
	
	
	String str1="select telesales,salesman from an_userregister where doc_no='"+userid+"'";
	System.out.println("str1:"+str1);
	ResultSet rst=stmtt.executeQuery(str1);
	while(rst.next())
	{
		telid=Integer.parseInt(rst.getString("telesales"));
		salid=Integer.parseInt(rst.getString("salesman"));
	}
	System.out.println("telid:"+telid+":salid:"+salid);
	if(telid>0)
	{
		sqltext=sqltext+" telesales='"+telid+"'"; 
	}
	if(salid>0)
	{
		sqltext=sqltext+" sal_id='"+salid+"'";
	}
	
	System.out.println("sqltext:"+sqltext);
	 String str="select voc_no from in_enqm"; 
	/*String str="select voc_no from in_enqm where "+sqltext;*/
	
	System.out.println("user::"+str);
	
	ResultSet rs=stmt.executeQuery(str);
	
	while(rs.next())
	{
		if(i==0){
			value+=rs.getString("voc_no");	
		}
		else{
			value+=","+rs.getString("voc_no");
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