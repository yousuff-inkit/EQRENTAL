<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>

 <%@page import="com.operations.vehicletransactions.custody.ClsCustodyDAO" %>
 <%
 ClsConnection viewDAO= new ClsConnection();
Connection conn=null;
try{
	conn=viewDAO.getMyConnection();
String temp=request.getParameter("id");
 	
	Statement stmt = conn.createStatement ();
	String strSql = "select loc_name,doc_no from my_locm where status<>7 and brhid="+temp;
	ResultSet rs = stmt.executeQuery(strSql);
	String loc="";
	String id="";
	while(rs.next()) {
		loc+=rs.getString("loc_name")+",";		
		id+=rs.getString("doc_no")+",";
  		} 
	loc=loc.substring(0, loc.length()-1);
	stmt.close();
	conn.close();
	response.getWriter().write(loc+"***"+id);
	//System.out.println("Location:"+loc+"***"+id);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
  %>