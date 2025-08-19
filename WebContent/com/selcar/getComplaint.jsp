
<%@page import="com.common.ClsEncrypt"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
String name=request.getParameter("name");
String mobile=request.getParameter("mobile");
String email=request.getParameter("email");
String vehno=request.getParameter("vehno");
String complaint=request.getParameter("complaint");
String userid=request.getParameter("userid");

ClsConnection  ClsConnection=new ClsConnection();
Connection conn=null;
int i=0;
try
{
	conn=ClsConnection.getMyConnection();
	//Statement stmt = conn.createStatement();

	CallableStatement stmt=conn.prepareCall("{call vehicleComplaintDML(?,?,?,?,?,?,?)}");
	stmt.registerOutParameter(7, java.sql.Types.INTEGER);
	stmt.setString(1,name);
	stmt.setString(2,mobile);
	stmt.setString(3,email);
	stmt.setString(4,vehno);
	stmt.setString(5,complaint);
	stmt.setString(6,userid);
	
	stmt.executeUpdate();
	i=stmt.getInt("docno");

}
catch(Exception e)
{
	e.printStackTrace();

}
finally
{
	conn.close();
}
if(i>0)
{

	response.getWriter().write("Complaint Received");
}
else
{
	response.getWriter().write("Error occured");
}

%>