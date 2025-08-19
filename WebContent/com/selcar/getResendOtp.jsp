
<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%@page import="com.mailwithpdf.*" %>
<%@page import="com.sms.SmsAction" %>
<%@page import="java.util.Random"%>

<%

	EmailProcess ep=new EmailProcess(); 
	SmsAction sms=new SmsAction();
	
	
	
	ClsConnection  ClsConnection=new ClsConnection();
	ClsEncrypt objencrypt=new ClsEncrypt();
	
	Random random = new Random();
	/* String generatedPassword ="a"+String.format("%04d", random.nextInt(10000)); */
	 String generatePassword=String.format("%04d", random.nextInt(10000));
	 String generatedPassword="a"+generatePassword;

	/* String generatePassword="0120";
	String generatedPassword="a"+"0120"; */
	
	System.out.println("generatedPassword2:"+generatedPassword);
	System.out.println("generatePassword:"+generatePassword);
	
	System.out.println("getRegister");
	
	String docno=request.getParameter("userid");
	
	
	System.out.println("userid:"+docno);
	
	
	Connection conn=null;
	
	String str="";
	String rname="";
	String remail="",rmobile="",otp="";
	String msg="";
	int i=0;
	try
	{
		
		conn=ClsConnection.getMyConnection();
		Statement st=conn.createStatement();
		
		str="update user_register set otp='"+generatedPassword+"' where doc_no="+docno;
		System.out.println("updatestr::"+str);
		i=st.executeUpdate(str);
		
		Statement st1=conn.createStatement();
		
		str="select name,email,mobile_no,otp from user_register where doc_no='"+docno+"'";
		System.out.println("resendstr::"+str);
		ResultSet rs1=st1.executeQuery(str);
		while(rs1.next())
		{
			rname=rs1.getString("name");
			remail=rs1.getString("email");
			rmobile=rs1.getString("mobile_no");
			otp=rs1.getString("otp");
		}
		System.out.println("otp:"+otp);
		System.out.println("sms:");
		sms.doSendSmsOtp(rmobile, rname, docno,"OTP", "1",generatePassword,conn);
		msg="1";
		
	}
	catch(Exception e)
	{
		e.printStackTrace();
		
	}
	
	finally
	{
		conn.close();
	}
	response.getWriter().write(msg);
%>