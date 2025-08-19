<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="net.sf.json.*"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.common.ClsCommon"%>
 <%
System.out.println("in getpictures jsp");
 Thread.sleep(1000);
	String rdoc="",tst="";
	String msg="";
	int j=0,i=0;
	int k=0;
	String desc=request.getParameter("desc");
	String pic=request.getParameter("picname");
	String fleet=request.getParameter("fleetno");
	byte b[]=new byte[1000];
ClsConnection  ClsConnection=new ClsConnection();
ClsCommon   ClsCommon =new ClsCommon();
Connection conn=null;
conn = ClsConnection.getMyConnection();  

JSONArray RESULTDATA=new JSONArray();
try
{
  Statement stmt=conn.createStatement();
  if(!(desc.equalsIgnoreCase(""))){
  String sqltst="select path from my_fileattach where dtype='VIP' and descpt='"+pic+"' and doc_no ='"+desc+"'";
  
  /* String sqltst="select path from my_fileattach where doc_no='"+desc+"'  and dtype='VIP' and descpt='"+pic+"'"; */
  System.out.println("Pictures Fetch SQL======="+sqltst);
  /* PreparedStatement ps=conn.prepareStatement("select path from my_fileattach where doc_no='"+desc+"'  and dtype='VIP' and descpt='"+pic+"';"); */ 
  ResultSet rs=stmt.executeQuery(sqltst);

  while(rs.next()){
		tst+=rs.getString("path")+"::";
		i++;
 }	
		
  System.out.println("path========="+tst);
  } 
  

 
  


	
		
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

response.getWriter().write(tst+"####"+i);
%>