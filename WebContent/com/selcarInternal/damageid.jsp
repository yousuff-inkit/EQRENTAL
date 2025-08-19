<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="net.sf.json.*"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.common.ClsCommon"%>
 <%
System.out.println("in damage jsp");
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


  PreparedStatement ps=conn.prepareStatement("select doc_no from gl_damage where name='"+desc+"';"); 
  ResultSet rs=ps.executeQuery();

  while(rs.next()){
		tst=rs.getString("doc_no");
		
 }	
		
  System.out.println("damage========="+tst);
  
  

 
  


	
		
 ps.close();

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