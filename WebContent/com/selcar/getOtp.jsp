
<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%@page import="com.mailwithpdf.*" %>
<%@page import="com.sms.SmsAction" %>
<%@page import="java.util.Random"%>

<%

System.out.println("getOtp");
	SmsAction sms=new SmsAction();
	
	ClsConnection  ClsConnection=new ClsConnection();
	ClsEncrypt objencrypt=new ClsEncrypt();
	
	Random random = new Random();
	 /* String generatedPassword ="a"+ String.format("%04d", random.nextInt(10000)); */ 
	 String generatePassword=String.format("%04d", random.nextInt(10000));
	 String generatedPassword="a"+generatePassword;

	 /* String generatePassword="0120";
	 String generatedPassword="a"+"0120";*/	
	System.out.println("generatedPassword:"+generatedPassword);
	System.out.println("generatePassword:"+generatePassword);
	
	//String generatePassword=generatedPassword.replace("0","a");
	
	String rname=request.getParameter("name");
	String remail=request.getParameter("email");
	String rmobile=request.getParameter("mobile");
	String runame=request.getParameter("username");
	String pass=request.getParameter("password");
	String rpassword=objencrypt.encrypt(pass);
	
	//System.out.println("generatePassword"+generatePassword);
	
	Connection conn=null;
	
	String str="";
	String str1="";
	String email="";
	String mobileno="";
	String user="";
	String str2="";
	String doctype="";
	String status="";
	int i=0;
	String doc="";
	String msg="";
	
	try
	{
		conn=ClsConnection.getMyConnection();
		Statement st=conn.createStatement();
		
		str="select email from user_register where email='"+remail+"'";
		System.out.println("str::"+str);
		ResultSet rs=st.executeQuery(str);
		while(rs.next())
		{
			email=rs.getString("email");
			
		}
		str1="select user_name from user_register where user_name='"+runame+"'";
		ResultSet rs1=st.executeQuery(str1);
		while(rs1.next())
		{
			
			user=rs1.getString("user_name");
		}
		
		if(!remail.equalsIgnoreCase(email) && !runame.equalsIgnoreCase(user))
		
		{
			System.out.println("inside...........");
			CallableStatement stmt=conn.prepareCall("{call userRegisterDML(?,?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(8, java.sql.Types.INTEGER);
			stmt.setString(1,rname);
			stmt.setString(2,remail);
			stmt.setString(3,rmobile);
			stmt.setString(4,runame);
			stmt.setString(5,rpassword);
			/* stmt.setString(6,generatedPassword); */
			stmt.setString(6,generatedPassword);
			stmt.setString(7,"0");
			stmt.executeUpdate();
			i=stmt.getInt("docno");
			if(i>0)
			{
				doc=Integer.toString(i);
				System.out.println("ins"+doc);
				System.out.println("phone"+rmobile);
				System.out.println("name"+rname);
				
				sms.doSendSmsOtp(rmobile, rname, doc,"OTP", "1",generatePassword,conn);
				msg="1";
				 
				
			}
			
		}
		else if(remail.equalsIgnoreCase(email))
		{
			
			msg="0";
			System.out.println("Error");
		}
		else
		{
			
			msg="-1";
			System.out.println("username...........");
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