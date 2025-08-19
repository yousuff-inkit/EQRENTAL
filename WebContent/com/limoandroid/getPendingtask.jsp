<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%

String userid=request.getParameter("userid");

System.out.println(userid);

ClsConnection  ClsConnection=new ClsConnection();
Connection conn=null;
int i=0;
String value="";

try
{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	
	String str="select doc_no,ref_type,ref_no,strt_date,strt_time,description,act_status from an_taskcreation t left join an_taskcreationdets a on t.doc_no=a.rdocno where a.userid='"+userid+"' or t.userid='"+userid+"' and t.close_status=0 and utype='app' group by doc_no";
	
	System.out.println("pending::"+str);
	
	ResultSet rs=stmt.executeQuery(str);
	
	while(rs.next())
	{
		if(i==0){
			value+=rs.getString("doc_no")+"::"+rs.getString("ref_type")+"::"+rs.getString("ref_no")+"::"+rs.getString("strt_date")+"::"+rs.getString("strt_time")+"::"+rs.getString("description")+"::"+rs.getString("act_status");	
		}
		else{
			value+=","+rs.getString("doc_no")+"::"+rs.getString("ref_type")+"::"+rs.getString("ref_no")+"::"+rs.getString("strt_date")+"::"+rs.getString("strt_time")+"::"+rs.getString("description")+"::"+rs.getString("act_status");
		}
		i++;
		
	}
	System.out.println("create:"+value);

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