<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="com.common.ClsEncrypt" %>
<%@page import="net.sf.json.JSONObject" %>

<%	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	ClsEncrypt objencrypt=new ClsEncrypt();
	Connection conn = null;
	
	String username="", password="",value="";
	int userid=0;
	String userName=request.getParameter("uname");
	String pass=request.getParameter("upass");
	String passwor=objencrypt.encrypt(pass);
	System.out.println("userName:"+userName);
	System.out.println("pass:"+pass);
	try{
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
		
		String strSql = "select * from usersregistration where username='"+userName+"' and password='"+passwor+"'";
		System.out.println("str:"+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		
		while(rs.next()) 
		{
			System.out.println("inside");
			userid=rs.getInt("doc_no");
			username=rs.getString("username");
			password=objencrypt.decrypt(rs.getString("password"));
			System.out.println("userid:"+userid);
			System.out.println("username:"+username);
			System.out.println("password:"+password);
			
			if(userName.equalsIgnoreCase(username) && pass.equalsIgnoreCase(password))
			{
				session.setAttribute("USER-NAME",username);
			
				value="1";
			
			}
			else
			{
				System.out.println("elseeeeeeeee");
			 	value="0";
			}
		}
		/* else{			
			conn.close();
			obj.put("info", "fail");
		} */
		
	}
	catch(Exception e)
	{
	 	e.printStackTrace();
	 	conn.close();
	}
	finally
	{
		conn.close();
	}
	
	 /* response.setContentType("application/json");
     response.setCharacterEncoding("UTF-8"); */
     /* response.getWriter().write(obj.toString()); */
     response.getWriter().write(value+"::"+userid);
  %>