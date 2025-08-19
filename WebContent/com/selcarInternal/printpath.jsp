<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="net.sf.json.*"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.common.ClsCommon"%>
 <%
System.out.println("in printpath jsp");
	String rdoc="",tst="";
	String msg="";
	int j=0,i=0;
	int k=0;
	String desc=request.getParameter("desc");
ClsConnection  ClsConnection=new ClsConnection();
ClsCommon   ClsCommon =new ClsCommon();
Connection conn=null;
conn = ClsConnection.getMyConnection();  

JSONArray RESULTDATA=new JSONArray();
try
{

  Statement stmt=conn.createStatement();
  String sqltst="select path from my_fileattach where doc_no='"+desc+"' and descpt='print'";
  System.out.println("Print Fetch SQL======="+sqltst); 
  ResultSet rs=stmt.executeQuery(sqltst);
  /*PreparedStatement ps=conn.prepareStatement("select path from my_fileattach where doc_no='"+desc+"' and descpt='print';"); 
  ResultSet rs=ps.executeQuery();*/

  while(rs.next()){
		tst=rs.getString("path");
		
 }	
		
  System.out.println("printpath========="+tst);
  
  

 
  


	
		
 stmt.close();

}
catch(Exception e)
{
	e.printStackTrace();

}
finally
{
	conn.close();
}

response.getWriter().write(tst);
%>