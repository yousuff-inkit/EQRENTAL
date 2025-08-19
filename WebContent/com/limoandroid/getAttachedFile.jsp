<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%

String docno=request.getParameter("docno");

System.out.println("docno:"+docno);

ClsConnection  ClsConnection=new ClsConnection();
Connection conn=null;
int i=0;
String value="";

try
{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	
	/* String str="select remarks,r.username,action_status,ass_date,ass_time from an_taskcreationdets t left join an_userregister r on t.assnfrom_user=r.doc_no where rdocno='"+docno+"'"; */
	String str="select doc_no,user,path,filename from my_fileattach where doc_no='"+docno+"' and dtype='APP';";
	
	
	
	System.out.println("file-str::"+str);
	
	ResultSet rs=stmt.executeQuery(str);
	
	while(rs.next())
	{
		if(i==0){
			value+=rs.getString("doc_no")+"::"+rs.getString("user")+"::"+rs.getString("path")+"::"+rs.getString("filename");
		}
		else{
			value+="###"+rs.getString("doc_no")+"::"+rs.getString("user")+"::"+rs.getString("path")+"::"+rs.getString("filename");
		}
		i++;
		
	}
	System.out.println("fff:"+value);

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