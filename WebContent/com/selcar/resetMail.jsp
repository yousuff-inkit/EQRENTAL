<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Random"%>
<%@page import="com.mailwithpdf.*" %>

<%

String email=request.getParameter("email");
EmailProcess ep=new EmailProcess();

ClsConnection  ClsConnection=new ClsConnection();
Connection conn=null;
int val=0;
String method="";

Random random = new Random();
/* String generatedPassword ="a"+ String.format("%04d", random.nextInt(10000)); */ 
String generatePassword=String.format("%04d", random.nextInt(10000));
String generatedPassword="a"+generatePassword;

/* String generatePassword="0120";
String generatedPassword="a"+"0120";*/	
/* System.out.println("generatedPassword:"+generatedPassword);
System.out.println("generatePassword:"+generatePassword);
 */
String emailid="",user="";

try
{
	conn=ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();

	/* String str="select * from car_names"; */
	String str="select user_name,email from user_register where email='"+email+"' ";
	ResultSet rs=stmt.executeQuery(str);
	
	
	while(rs.next())
	{
		//method=1;
		 emailid=rs.getString("email"); 
		 user=rs.getString("user_name"); 
	}
	
	if(email.equalsIgnoreCase(emailid)){
		String sqls="update user_register set resetotp='"+generatedPassword+"' where email='"+emailid+"'";
		val=stmt.executeUpdate(sqls);
		if(val>0){
					      
				
			ep.sendEmailwithpdf("smtp.gmail.com", "587", "selcarae@gmail.com", "Selcar@702", email, "SELCAR RESET CODE", 
					"Hi <b>"+user+"</b>,<br><br> We understand you'd like to change your password.<br> Reset Code :<b>"+generatePassword+"</b> for verification. <br><br>If you did not ask for a password change, just ignore this email.<br><br><br>Thanks,<br> Selcar Team",null,"");

			method="1";
		}
		else{
			method="0";
		}
	}
	
	
	
	System.out.println("method="+method);

}
catch(Exception e)
{
	e.printStackTrace();

}
finally
{
	conn.close();
}

response.getWriter().write(method);
%>