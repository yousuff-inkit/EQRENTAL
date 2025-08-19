<% %>
<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.ClsCommon" %>

<%
	ClsConnection  ClsConnection=new ClsConnection();
	ClsCommon com=new ClsCommon();

	Date from=com.changeStringtoSqlDate(request.getParameter("from"));
	Date to=com.changeStringtoSqlDate(request.getParameter("to"));
	
	String vname=request.getParameter("vname");
	String monthly=request.getParameter("monthly");
	String weekly=request.getParameter("weekly");
	String daily=request.getParameter("daily");
	String adult=request.getParameter("adult");
	String door=request.getParameter("door");
	String luggage=request.getParameter("luggage");
	String fuel=request.getParameter("fuel");
	String whel=request.getParameter("wheel");
	String wheel="";
	if(whel.equalsIgnoreCase("1"))
	{
		wheel="Available";
	}
	else
	{
		wheel="Non-Available";
	}
	 System.out.println("gps......."+vname);
	 System.out.println("from......."+from);
	 System.out.println("to......."+to);
	
	int docno=0;
	String sqll="",sql="",value="";
	Connection conn=null;
	int i=0;
	
	
	try
	{
		conn=ClsConnection.getMyConnection();
		Statement stt=conn.createStatement();
		sqll="select coalesce(max(doc_no),0)+1 doc_no from an_offers";
	    ResultSet rs1=stt.executeQuery(sqll);
		while(rs1.next())
		{
			docno=rs1.getInt("doc_no");
		}
	    
		Statement st=conn.createStatement();
		sql="INSERT INTO an_offers(doc_no,fromdate,todate,vehicle_name,monthly,weekly,daily,adult,door,luggage,fuel,wheel)"
		+" VALUES ("+docno+",'"+from+"','" +to+"','"+vname+"','"+monthly+"','"+weekly+"','"+daily+"','"+adult+"','"+door+"','"+luggage+"','"+fuel+"','"+wheel+"')";
		i=st.executeUpdate(sql);
		if(i>0)
		{
			value="1";
		}
		else
		{
			value="0";
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
	response.getWriter().write(value);
%>