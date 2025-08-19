<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
	ClsConnection  ClsConnection=new ClsConnection();
	Connection conn=null;
	
	int i=0;
	String value="";

	try
	{
		conn=ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String str="select doc_no,fleetname,daily_rate,week_rate,month_rate,image_path from an_vehonline";
		ResultSet rs=stmt.executeQuery(str);
		
		while(rs.next())
		{
			if(i==0){
				value+=rs.getString("doc_no")+"::"+rs.getString("fleetname")+"::"+rs.getString("month_rate")+"::"+rs.getString("week_rate")+"::"+rs.getString("daily_rate")+"::"+rs.getString("image_path");	
			}
			else{
				value+=","+rs.getString("doc_no")+"::"+rs.getString("fleetname")+"::"+rs.getString("month_rate")+"::"+rs.getString("week_rate")+"::"+rs.getString("daily_rate")+"::"+rs.getString("image_path");
			}
			i++;
			
		}
		System.out.println("fleet:"+value);

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