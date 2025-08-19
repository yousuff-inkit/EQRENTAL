
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
			CallableStatement stmt=conn.prepareCall("{call an_takehandDML(?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(7, java.sql.Types.INTEGER);
			stmt.setString(1,fleet);
			stmt.setString(2,reg);
			stmt.setString(3,details);
			stmt.setString(4,inspectid);
			stmt.setString(5,type);
			stmt.setString(6,userid);
			stmt.executeUpdate();
			i=stmt.getInt("docno");
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