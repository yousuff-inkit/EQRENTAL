
<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>


<%

System.out.println("Register");
	
	
	ClsConnection  ClsConnection=new ClsConnection();
	ClsEncrypt objencrypt=new ClsEncrypt();
	
		
	String fleet=request.getParameter("fleet");
	String reg=request.getParameter("regno");
	String type=request.getParameter("hand");
	String details=request.getParameter("details");
	String inspectid=request.getParameter("selectdoc");
	String userid=request.getParameter("userid");
	System.out.println(fleet+":"+reg+":"+type+":"+details+":"+inspectid+":"+userid);
	
	Connection conn=null;
	
	String str1="";
	
	String user="";
	
	int i=0;
	String doc="";
	String msg="";
	
	try
	{
		conn=ClsConnection.getMyConnection();
		Statement st=conn.createStatement();
		
		System.out.println("inside...........");
			CallableStatement stmt=conn.prepareCall("{ call an_takehandDML(?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(6, java.sql.Types.INTEGER);
			
			
			stmt.setString(1,reg);
			stmt.setString(2,details);
			stmt.setString(3,inspectid);
			stmt.setString(4,type);
			stmt.setString(5,userid);
			stmt.setString(7,fleet);
			stmt.executeUpdate();
			i=stmt.getInt("docNo");
			if(i>0)
			{
				doc=Integer.toString(i);
				msg="1";
				 
				
			}
			
	
		else
		{
			
			msg="0";
			//System.out.println("Incorrectusername...........");
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
	response.getWriter().write(msg+"::"+i); 
%>