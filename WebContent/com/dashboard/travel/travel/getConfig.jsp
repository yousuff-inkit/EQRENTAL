<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
    Connection conn = null;      
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();  
	Statement stmt = conn.createStatement ();  
	int val=0,val2=0;
	String strSql = "select coalesce(method,0) method from gl_config where field_nme='lammo tourism'";                  
	//System.out.println("strSql===="+strSql);
	ResultSet rs = stmt.executeQuery(strSql);         
	while(rs.next()) {         
		val=rs.getInt("method");
  	}       
	String strSql2 = "select coalesce(method,0) method from gl_config where field_nme='trustxohide'";                  
	//System.out.println("strSql===="+strSql2);
	ResultSet rs2 = stmt.executeQuery(strSql2);         
	while(rs2.next()) {         
		val2=rs2.getInt("method");
  	}
	stmt.close();
	conn.close();  
	response.getWriter().print(val+"###"+val2);           
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>