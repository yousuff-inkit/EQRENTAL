<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%

	ClsConnection  ClsConnection=new ClsConnection();
	
	String doc=request.getParameter("doc");
	//String udoc=request.getParameter("userdoc");
	System.out.println("..........."+doc);
	Connection conn=null;
	int i=0;
	try
	{
		conn=ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
	

		//String sqll="update vehicle_book set status=1,user_doc="+udoc+" where doc_no="+doc+" ";
		String sqll="delete from an_offers where doc_no="+doc;
		
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