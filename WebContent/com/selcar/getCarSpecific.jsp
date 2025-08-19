<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%

ClsConnection ClsConnection=new ClsConnection();
String uid=request.getParameter("docno");
System.out.println("iddd::"+uid);

String seat="";
String door="";
String lugg="",fuel="",cruise="",weel="";
String value="1";
Connection conn=null;
try
{
conn=ClsConnection.getMyConnection();
Statement stmt = conn.createStatement();

String str="select seat,door,luggage,fuel,weel from an_vehspecific where rdocno='"+uid+"'";

ResultSet rs=stmt.executeQuery(str);
while(rs.next())
{
seat=rs.getString("seat");
door=rs.getString("door");
lugg=rs.getString("luggage");
fuel=rs.getString("fuel");
//cruise=rs.getString("cruise");
weel=rs.getString("weel");
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
System.out.println("nm"+seat+"mail"+door+"mbl"+lugg+"f"+fuel+"w"+weel);
response.getWriter().write(value+"::"+seat+"::"+door+"::"+lugg+"::"+fuel+"::"+weel);
%>