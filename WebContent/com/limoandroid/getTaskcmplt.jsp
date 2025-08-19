<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%

/* String docno=request.getParameter("taskid");
String cuser=request.getParameter("cuser");
 */
String rdocno=request.getParameter("rdocno");
System.out.println(rdocno);
int docno=Integer.parseInt(request.getParameter("rdocno"));
String hiduser=request.getParameter("hiduser");
String remarks=request.getParameter("remarks");

System.out.println("hiduser::"+hiduser);

ClsConnection  ClsConnection=new ClsConnection();
Connection conn=null;
int i=0,val=0;
String msg="";

try
{
	conn=ClsConnection.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt = conn.createStatement();
	
	String str="update an_taskcreation set clstatus=1,act_status='Completed',ass_user='"+hiduser+"' where doc_no='"+docno+"'";
	
	System.out.println("an_assign::"+str);
	val=stmt.executeUpdate(str);
	
	if(val>0){
	msg="1";
	conn.commit();
	}

}
catch(Exception e)
{
	e.printStackTrace();

}
finally
{
	conn.close();
}

response.getWriter().write(msg);
%>