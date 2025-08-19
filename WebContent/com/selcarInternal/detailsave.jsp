<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>


<%

System.out.println("TakeHand Save");
	
	
	ClsConnection  ClsConnection=new ClsConnection();
	ClsEncrypt objencrypt=new ClsEncrypt();
	Connection conn=null;
	
	String str1="";
	
	String user="";
	
	int j=0;
	int k=0;
	String doc="";
	String rdoc="";
	String msg="";
	//String rdoc=request.getParameter("doc");
	
	
	String type=request.getParameter("take");
	String userid=request.getParameter("userid");
	String fleet=request.getParameter("fleet");
	String reg=request.getParameter("regfleet");
	String details=request.getParameter("details");
	String inspectid=request.getParameter("selectdoc");
	
	conn=ClsConnection.getMyConnection();
	Statement st=conn.createStatement();
			
	
	/* System.out.println("__"+str[0]); */
	try
	{
		
			CallableStatement stmt=conn.prepareCall("{call an_takehandDML(?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(7, java.sql.Types.INTEGER);
			stmt.setString(1,fleet);
			stmt.setString(2,reg);
			stmt.setString(3,details);
			stmt.setString(4,inspectid);
			stmt.setString(5,type);
			stmt.setString(6,userid);
			stmt.executeUpdate();
			k=stmt.getInt("docNo");
			if(k>0)
			{
				rdoc=Integer.toString(k);
				msg="1";
				 
				
			}
			
	
			else
			{
				
				msg="0";
				//System.out.println("Incorrectusername...........");
			}

		
		
		System.out.println(rdoc);
		
		}
	catch(Exception e)
	{
		e.printStackTrace();
		
	}
	
	finally
	{
		conn.close();
	}
	
	
	
	
    
	response.getWriter().write(msg+"::"+rdoc);  
%>