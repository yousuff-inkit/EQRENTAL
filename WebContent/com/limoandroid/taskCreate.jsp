
<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>


<%

		System.out.println("in taskcreation");
	
		//String task=request.getParameter("task");
		String reftype=request.getParameter("reftype");
		String refno=request.getParameter("refno");
		String sdate=request.getParameter("sdate");
		String stime=request.getParameter("stime");
		String user=request.getParameter("user");
		String hiduser=request.getParameter("hiduser")==""?"0":request.getParameter("hiduser").trim();
		System.out.println("hiduser======="+hiduser);
		String desc=request.getParameter("desc");
		String userid=request.getParameter("userid")==""?"0":request.getParameter("userid").trim();
		System.out.println("userid======="+userid);
		String type="app";
		
	
	
	ClsConnection  ClsConnection=new ClsConnection();
	
	
	Connection conn=null;
	
	
	int i=0;
	String msg="";
	String doc="";
	
	try
	{
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		Statement st=conn.createStatement();
		
		
		
		    CallableStatement stmt=conn.prepareCall("{call an_taskcreationDML(?,?,?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(9, java.sql.Types.INTEGER);
			//stmt.setString(1,task);
			stmt.setString(1,reftype);
			stmt.setString(2,refno);
			stmt.setString(3,sdate);
			stmt.setString(4,stime);
			stmt.setString(5,hiduser);
			stmt.setString(6,desc);
			stmt.setString(7,userid);
			stmt.setString(8,type);
			stmt.executeUpdate();
			i=stmt.getInt("docno");
			if(i>0)
			{
				doc=Integer.toString(i);
				
				System.out.println("msg");
				msg="1";
				conn.commit();
				
				 
				
			}
			
			else
			{
				msg="0";
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