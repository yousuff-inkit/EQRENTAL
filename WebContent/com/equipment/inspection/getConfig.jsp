<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%
 	Connection conn = null;
ClsConnection objconn=new ClsConnection();
try{
	conn= objconn.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select method from gl_config where field_nme='mobileprint'";
	ResultSet rs = stmt.executeQuery(strSql);
	String branch="";
	String id="";
	while(rs.next()) {
		branch=rs.getString("method");		
  		} 
	
	System.out.println("printconfig======"+branch);
	stmt.close();
	conn.close();

	response.getWriter().write(branch);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
	%>