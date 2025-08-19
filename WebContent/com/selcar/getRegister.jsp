
<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%@page import="com.mailwithpdf.*" %>
<%@page import="com.sms.SmsAction" %>

<%

	EmailProcess ep=new EmailProcess(); 
	SmsAction sms=new SmsAction();
	
	ClsConnection  ClsConnection=new ClsConnection();
	ClsEncrypt objencrypt=new ClsEncrypt();
	
	
	System.out.println("getRegister");
	
	String docno=request.getParameter("userid");
	String random="a"+request.getParameter("rnum");
	
	System.out.println("userid:"+docno);
	System.out.println("random:"+random);
	
	Connection conn=null;
	
	String str="",str1="",str2="";
	String rname="";
	String remail="",rmobile="",otp="";
	String msg="";
	int i=0;
	try
	{
		
		conn=ClsConnection.getMyConnection();
		Statement st=conn.createStatement();
		
		str="select name,email,mobile_no,otp from user_register where doc_no='"+docno+"'";
		System.out.println("str::"+str);
		ResultSet rs=st.executeQuery(str);
		while(rs.next())
		{
			rname=rs.getString("name");
			remail=rs.getString("email");
			rmobile=rs.getString("mobile_no");
			otp=rs.getString("otp");
		}
		
		Statement st1=conn.createStatement();
		Statement st2=conn.createStatement();
		
		System.out.println("rname:"+rname);
		System.out.println("remail:"+remail);
		System.out.println("rmobile:"+rmobile);
		System.out.println("otp:"+otp);
		
		if(random.equalsIgnoreCase(otp))
		{
			ep.sendEmailwithpdf("smtp.gmail.com", "587", "gatewayerp55@gmail.com", "gwsupport#321", remail, "SELCAR REGISTRATION",
					"Thank you for registering on the SEL Car Rental App, your registration has been completed successfully.",null,"");
					      
					sms.doSendSmsApp(rmobile, rname, docno,"APP", "1",conn);
							
					str2="update user_register set status=1 where doc_no="+docno+"";
					i=st2.executeUpdate(str2);
							
					msg="1";
					System.out.println("1...........");
					
					
		}
		
		else
		{
			/* str1="delete from user_register where doc_no="+docno+"";
			st1.executeUpdate(str1); */
			msg="0";
			System.out.println("username0...........");
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
	response.getWriter().write(msg);
%>