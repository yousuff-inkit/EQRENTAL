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
	String str="select remarks,r.username,action_status,date_format(date(ass_date),'%d-%m-%Y') ass_date,time(ass_date) ass_time from an_taskcreationdets t left join an_userregister r on t.assnfrom_user=r.doc_no where rdocno='"+docno+"'";
	
	
	
	System.out.println("ass-str::"+str);
	
	ResultSet rs=stmt.executeQuery(str);
	
	while(rs.next())
	{
		if(i==0){
			value+=rs.getString("username")+"::"+rs.getString("remarks")+"::"+rs.getString("action_status")+"::"
		+rs.getString("ass_date")+"::"+rs.getString("ass_time");
		}
		else{
			value+="###"+rs.getString("username")+"::"+rs.getString("remarks")+"::"+rs.getString("action_status")+"::"
				+rs.getString("ass_date")+"::"+rs.getString("ass_time");
		}
		i++;
		
	}
	System.out.println("quot:"+value);

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