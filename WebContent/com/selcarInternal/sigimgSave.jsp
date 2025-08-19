<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="net.sf.json.*"%>
<%@page import="java.util.Arrays"%>
 <%
System.out.println("in save jsp");
   
	String rdocno=request.getParameter("selectdoc");
	//System.out.println("rdocno======"+rdocno);
	String sign=request.getParameter("sign");
	//System.out.println("sign======"+sign);
	String signagmt=request.getParameter("signagmt");
	//System.out.println("signagmt======"+signagmt);
	String rdoc="";
	String msg="";
	String value="";
	int j=0;
	int k=0;
ClsConnection  ClsConnection=new ClsConnection();
Connection conn=null;
try
{
conn = ClsConnection.getMyConnection();
Statement stmt = conn.createStatement();
String str="select imgPath from my_comp";
ResultSet rs=stmt.executeQuery(str);

while(rs.next())
{
		value+=rs.getString("imgPath");	
	
}
System.out.println("path:"+value);
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