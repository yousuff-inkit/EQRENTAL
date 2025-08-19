<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="com.common.ClsEncrypt" %>
<%@page import="net.sf.json.JSONObject" %>


<%
System.out.println("welcome jsp");
	ClsConnection  ClsConnection=new ClsConnection();
	ClsEncrypt objencrypt=new ClsEncrypt();
	String uname=request.getParameter("username");
	String passwor=request.getParameter("password");
	String password=objencrypt.encrypt(passwor);
	System.out.println("uu"+uname);
	System.out.println("pp"+passwor);
	Connection conn=null;
	System.out.println("haiiiiiiiiiiii");
	String value="";
	
	String user="";
	String passw="",status="";
	int docno=0;
	
	
	try
	{
		conn=ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String str="select user_name, pass,doc_no,status from user_register where user_name='"+uname+"' and  pass='"+password+"'";
		//String str="select user_name, pass from user_register";
		System.out.println("strrrr....."+str);
		ResultSet rs=stmt.executeQuery(str);
		while(rs.next())
		{
			 user=rs.getString("user_name");
			 passw=objencrypt.decrypt(rs.getString("pass"));
			 docno=rs.getInt("doc_no");
			 status=rs.getString("status");
			    System.out.println("userid:"+docno);
				System.out.println("username:"+user);
				System.out.println("password:"+passw);
			if(uname.equalsIgnoreCase(user) && passwor.equalsIgnoreCase(passw))
			{
				//System.out.println("strrrr.....in condition true");
			session.setAttribute("USER-NAME",user);
			//session.setAttribute("USERID",docno);
			value="Successfully LoggedIn";
			//System.out.println("strrrr.....in condition true2");
			}
			else
			{
				System.out.println("elseeeeeeeee");
			 	value="Incorrect username or password";
			}
		
			System.out.println("status:"+status);
		
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
	

	response.getWriter().write(value+"::"+docno+"::"+status);
%>