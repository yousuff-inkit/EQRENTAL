<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
ClsConnection  ClsConnection=new ClsConnection();
Connection conn=null;
int i=0;
String value="";
String sqltest="";
String reg=request.getParameter("rg");
System.out.println(reg);

try
{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	
	if(!reg.equalsIgnoreCase("")){
		sqltest="  and reg_no like '"+reg+"%'";
	}
	String str="select reg_no,code_name from gl_vehmaster v inner join gl_vehplate p on v.pltid=p.doc_no where fstatus='L' and statu<>7 ";
	//+sqltest;
			//+" limit 25";
	System.out.println("str:::"+str);
	ResultSet rs=stmt.executeQuery(str);
	
	while(rs.next())
	{
		if(i==0){
			value+=rs.getString("reg_no")+"::"+rs.getString("code_name");	
		}
		else{
			value+=","+rs.getString("reg_no")+"::"+rs.getString("code_name");
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