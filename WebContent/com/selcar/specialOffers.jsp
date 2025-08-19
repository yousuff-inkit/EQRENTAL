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
		
		/* String str="select doc_no,DATE_FORMAT(fromdate,'%d %M')fromdate,DATE_FORMAT(todate,'%d %M')todate,vehicle_name,monthly,weekly,daily,adult,door,luggage,fuel,wheel from an_offers"; */
		
		String str="select of.doc_no,DATE_FORMAT(fromdate,'%d %M')fromdate,DATE_FORMAT(todate,'%d %M')todate,of.vehicle_name,of.monthly,of.weekly,of.daily,of.adult,of.door,of.luggage,of.fuel,of.wheel,f.path from an_offers of left join my_fileattach f on of.doc_no=f.doc_no where f.dtype='OFFR' and f.status=3";
		System.out.println("str:"+str);
		ResultSet rs=stmt.executeQuery(str);
		
		while(rs.next())
		{
			if(i==0){
				value+=rs.getString("doc_no")+"::"+rs.getString("fromdate")+"::"+rs.getString("todate")+"::"+rs.getString("vehicle_name")+"::"+rs.getString("monthly")+"::"+rs.getString("weekly")+"::"+rs.getString("daily")+"::"+rs.getString("adult")+"::"+rs.getString("door")+"::"+rs.getString("luggage")+"::"+rs.getString("fuel")+"::"+rs.getString("wheel")+"::"+rs.getString("path");	
			}
			else{
				value+=","+rs.getString("doc_no")+"::"+rs.getString("fromdate")+"::"+rs.getString("todate")+"::"+rs.getString("vehicle_name")+"::"+rs.getString("monthly")+"::"+rs.getString("weekly")+"::"+rs.getString("daily")+"::"+rs.getString("adult")+"::"+rs.getString("door")+"::"+rs.getString("luggage")+"::"+rs.getString("fuel")+"::"+rs.getString("wheel")+"::"+rs.getString("path");
			}
			i++;
			
		}
		System.out.println("values::"+value);

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