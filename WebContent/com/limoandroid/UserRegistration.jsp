
<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>


<%

// System.out.println("Registration");
	
	
	ClsConnection  ClsConnection=new ClsConnection();
	ClsEncrypt objencrypt=new ClsEncrypt();
	
		
	//String web=request.getParameter("web");
	String runame=request.getParameter("username");
	String pass=request.getParameter("password");
	String email=request.getParameter("email");
	String mobile=request.getParameter("mobile");
	String rpassword=objencrypt.encrypt(pass);
	
	
	Connection conn=null;
	
	String str1="";
	
	String user="";
	
	int i=0;
	String doc="";
	String msg="";
	
	try
	{
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		Statement st=conn.createStatement();
		
		
		str1="select username from an_userregister where username='"+runame+"'";
		ResultSet rs1=st.executeQuery(str1);
		while(rs1.next())
		{
			
			user=rs1.getString("username");
		}
		
		if(!runame.equalsIgnoreCase(user))
		
		{
// 			System.out.println("inside...........");
			CallableStatement stmt=conn.prepareCall("{call usersRegistrationDML(?,?,?,?,?)}");
			stmt.registerOutParameter(5, java.sql.Types.INTEGER);
			stmt.setString(1,email);
			stmt.setString(2,runame);
			stmt.setString(3,rpassword);
			stmt.setString(4,mobile);
			stmt.executeUpdate();
			i=stmt.getInt("docno");
			if(i>0)
			{
				doc=Integer.toString(i);
// 				System.out.println("ins"+doc);
// 				System.out.println("web"+web);
// 				System.out.println("runame"+runame);
// 				System.out.println("pass"+rpassword);
				
				
				msg="1";
				conn.commit();
				 
				
			}
			
		}
		else
		{
			
			msg="0";
// 			System.out.println("Incorrectusername...........");
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