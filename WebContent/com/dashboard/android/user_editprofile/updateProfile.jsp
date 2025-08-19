<%@page import="com.connection.*" %>
<%@page import="java.sql.*"%>
<%@page import="com.common.ClsCommon" %>
<%@page import="com.common.ClsEncrypt"%>


<%
	ClsConnection  ClsConnection=new ClsConnection();
	ClsCommon com=new ClsCommon();
	ClsEncrypt objencrypt=new ClsEncrypt();
	
	String doc=request.getParameter("doc");
	String name=request.getParameter("name");
	String email=request.getParameter("email");
	String mobile=request.getParameter("mobile");
	String uname=request.getParameter("uname");
	String pass=request.getParameter("pswd");
	String pswd=objencrypt.encrypt(pass);
	System.out.println(doc+"::"+name+"::"+email+"::"+mobile+"::"+uname+"pass:"+pass);
	
	Connection conn=null;
	String str="",str1="";
	String uemail="",emobile="";
	String value="";
	int i=0;
	try
	{
		conn=ClsConnection.getMyConnection();
		Statement st=conn.createStatement();
		
		str1="select email,mobile_no from user_register where doc_no!="+doc;
		System.out.println("user::"+str1);
		ResultSet rs1=st.executeQuery(str1);
		while(rs1.next())
		{
			uemail=rs1.getString("email");
			emobile=rs1.getString("mobile_no");
			System.out.println("uemail:"+uemail+"mobile:"+mobile);
			
			
			if(!email.equalsIgnoreCase("uemail") && !emobile.equalsIgnoreCase("mobile"))
			{
				if(!pass.equalsIgnoreCase(""))
				{
					str="update user_register set name='"+name+"', email='"+email+"', mobile_no='"+mobile+"', user_name='"+uname+"',pass='"+pswd+"' where doc_no="+doc;
					
				}
				else
				{
					str="update user_register set name='"+name+"', email='"+email+"', mobile_no='"+mobile+"', user_name='"+uname+"' where doc_no="+doc;
						
				}
					
				
			}
		}
		
		System.out.println("str1:"+str);
		Statement stmt=conn.createStatement();
		i=stmt.executeUpdate(str);
		System.out.println("i;"+i);
		if(i>0)
		{
			value="1";
		}
		else
		{
			value="0";
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
	response.getWriter().write(value);

%>