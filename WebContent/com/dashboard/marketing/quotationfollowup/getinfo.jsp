<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();

Connection conn=null;

try{
	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	String strSql = "select process,rowno from gl_bibp where bibdid=88";
	ResultSet rs = stmt.executeQuery(strSql);
	String pro="",sr="";
	while(rs.next()) {
				pro+=rs.getString("process")+",";
				sr+=rs.getString("rowno")+",";
			} 
	String procc[]=pro.split(",");
	String brnId[]=sr.split(",");
	pro=pro.substring(0, pro.length()-1);
	sr=sr.substring(0, sr.length()-1);
	
	response.getWriter().write(sr+"####"+pro);
	stmt.close();
	conn.close();
}
catch(Exception e){

		conn.close();
		e.printStackTrace();
	}
  %>
  