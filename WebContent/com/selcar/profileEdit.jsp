<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.ClsEncrypt"%>

<%

ClsConnection  ClsConnection=new ClsConnection();
ClsEncrypt objencrypt=new ClsEncrypt();
String ename=request.getParameter("ename");
String email=request.getParameter("eemail");
String mob=request.getParameter("emobile");
String pswd=request.getParameter("epswd");
String epswd=objencrypt.encrypt(pswd);
String uid=request.getParameter("userid");

System.out.println("ename::"+ename+"email:"+email+"pswd:"+pswd+"uid:"+uid+"mob:"+mob);

String str="",str1="";
String name="",uemail="",mobile="";
String value="";
int i=0;
Connection conn=null;
try
{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	
	str1="select email,mobile_no from user_register where doc_no!="+uid;
	System.out.println("user::"+str1);
	ResultSet rs1=stmt.executeQuery(str1);
	while(rs1.next())
	{
		uemail=rs1.getString("email");
		mobile=rs1.getString("mobile_no");
		System.out.println("uemail:"+uemail+"mobile:"+mobile);
		
		
		if(!email.equalsIgnoreCase("uemail") && !mob.equalsIgnoreCase("mobile"))
		{
			str="update user_register set name='"+ename+"', email='"+email+"', mobile_no='"+mob+"', pass='"+epswd+"' where doc_no="+uid;
			
		}
		
		
	}
	
	System.out.println("str:"+str);
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
System.out.println("value:"+value);
response.getWriter().write(value);

%>