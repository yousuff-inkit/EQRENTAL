<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%

	ClsConnection  ClsConnection=new ClsConnection();
	
	String doc=request.getParameter("doc");
	String udoc=request.getParameter("userdoc");
	
	Connection conn=null;
	int i=0;
	try
	{
		conn=ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
	

		String sqll="update vehicle_service set status=1,user_doc="+udoc+" where doc_no="+doc+" ";
		stmt.executeUpdate(sqll);
	
		response.getWriter().write("updated");
	
	
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