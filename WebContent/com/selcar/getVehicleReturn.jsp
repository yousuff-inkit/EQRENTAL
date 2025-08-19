
<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%


	
	ClsConnection  ClsConnection=new ClsConnection();
	String name=request.getParameter("name");
	String mobile=request.getParameter("mobile");
	String email=request.getParameter("email");
	String vehicleno=request.getParameter("vehno");
	String rtdate=request.getParameter("rdate");
	String rtime=request.getParameter("rtime");
	String place=request.getParameter("place");
	String userid=request.getParameter("userid");
	
	//String userid=session.getAttribute("DOC_NO").toString();
	Connection conn=null;
	
	
	int i=0;
	try
	{
		conn=ClsConnection.getMyConnection();
		//Statement stmt = conn.createStatement();
		
		CallableStatement stmt=conn.prepareCall("{call vehicleReturnDML(?,?,?,?,?,?,?,?,?)}");
		stmt.registerOutParameter(9,java.sql.Types.INTEGER);
		stmt.setString(1,name);
		stmt.setString(2,mobile);
		stmt.setString(3,email);
		stmt.setString(4,vehicleno);
		stmt.setString(5,rtdate);
		stmt.setString(6,rtime);
		stmt.setString(7,place);
		stmt.setString(8,userid);
		stmt.executeUpdate();
		i=stmt.getInt("docno");
		
		
		
	}
	catch(Exception e)
	{
		e.printStackTrace();
		
	}
	finally
	{
		conn.close();
	}
	if(i>0)
	{
     
		response.getWriter().write("Vehicle return is successfull");
	}
	else
	{
		response.getWriter().write("Error");
	}
%>