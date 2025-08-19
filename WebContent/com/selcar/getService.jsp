<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%@page import="com.mailwithpdf.*" %>

<%

	EmailProcess ep=new EmailProcess();
	System.out.println("service");
	String name=request.getParameter("name");
	String mobile=request.getParameter("mobile");
	String email=request.getParameter("email");
	String vehno=request.getParameter("veh_no");
	String service_type=request.getParameter("service");
	String userid=request.getParameter("userid");
	
	//String userid=session.getAttribute("DOC_NO").toString();
	

	ClsConnection  ClsConnection=new ClsConnection();
	Connection conn=null;
	int i=0;
	String type="";
	try
	{
		conn=ClsConnection.getMyConnection();
		//Statement stmt = conn.createStatement();
	
		CallableStatement stmt=conn.prepareCall("{call vehicleServiceDML(?,?,?,?,?,?,?)}");
		stmt.registerOutParameter(7, java.sql.Types.INTEGER);
		stmt.setString(1,name);
		stmt.setString(2,mobile);
		stmt.setString(3,email);
		stmt.setString(4,vehno);
		stmt.setString(5,service_type);
		stmt.setString(6,userid);
		
		stmt.executeUpdate();
		i=stmt.getInt("docno");
		
		Statement stmt1=conn.createStatement();
		String sqlt1= "select service from service_type where doc_no="+service_type;
		ResultSet rs3=stmt1.executeQuery(sqlt1);
		while(rs3.next())
		{
			type=rs3.getString("service");
		}
		
       
		if(i>0)
		{
			
			 ep.sendEmailwithpdf("smtp.gmail.com", "587", "gatewayerp55@gmail.com", "gwsupport#321", "selcargate@gmail.com", "VEHICLE SERVICE",
					"You have new service request from the customer <b>"+name+"</b><br><b>Mobile no. :</b> "+mobile+"<b><br>Email id :</b> "+email+"<b><br>Vehicle no. :</b> "+vehno+"<b><br>Service type :</b> "+type+"",null,"");
			 
			 
			response.getWriter().write("Servicing completed");
		}
		else
		{
			response.getWriter().write("Servicing error");
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
	
%>