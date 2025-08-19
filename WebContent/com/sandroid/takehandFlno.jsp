<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
ClsConnection  ClsConnection=new ClsConnection();
Connection conn=null;
int i=0;
String value="";
String sqltest="";
String fleet=request.getParameter("fl");
System.out.println(":"+fleet);

try
{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	
	if(!fleet.equalsIgnoreCase("")){
		sqltest="  and fleet_no like '"+fleet+"%'";
	}
	
	String str="select fleet_no,code_name from gl_vehmaster v inner join gl_vehplate p on v.pltid=p.doc_no where fstatus='L' and statu<>7 ";
	//+sqltest;
			//+" limit 25";
	System.out.println("str:::"+str);
	ResultSet rs=stmt.executeQuery(str);
	
	while(rs.next())
	{
		if(i==0){
			value+=rs.getString("fleet_no")+"::"+rs.getString("code_name");	
		}
		else{
			value+=","+rs.getString("fleet_no")+"::"+rs.getString("code_name");
		}
		i++;
		
	}
	System.out.println("branchname:"+value);

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