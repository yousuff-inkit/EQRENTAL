<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.ClsCommon" %>

<%

	ClsConnection  ClsConnection=new ClsConnection();
	ClsCommon com=new ClsCommon();	

	String doc=request.getParameter("doc");
	
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
	System.out.println("from:"+from+":to:"+to);
	if(whel.equalsIgnoreCase("1"))
	{
		wheel="Available";
	}
	else
	{
		wheel="Non-Available";
	}
	System.out.println("..........."+doc);
	Connection conn=null;
	int i=0;
	try
	{
		conn=ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
	

		//String sqll="update vehicle_book set status=1,user_doc="+udoc+" where doc_no="+doc+" ";
		String sqll="update an_offers set fromdate='"+from+"',todate='"+to+"',vehicle_name='"+vname+"',monthly='"+monthly+"',weekly='"+weekly+"',daily='"+daily+"',adult='"+adult+"',door='"+door+"',luggage='"+luggage+"',fuel='"+fuel+"',wheel='"+wheel+"'  where doc_no="+doc;
		
		System.out.println(".....sqll.."+sqll);
		stmt.executeUpdate(sqll);
	
		response.getWriter().write("1");
	
	
	}
	catch(Exception e)
	{
		e.printStackTrace();
	
	}
	finally
	{
		conn.close();
	}


%>