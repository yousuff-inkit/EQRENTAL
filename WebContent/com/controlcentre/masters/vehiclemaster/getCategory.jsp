<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
ClsConnection ClsConnection=new ClsConnection();
 	Connection conn = null;
try{	
	conn=ClsConnection.getMyConnection();
Statement stmt = conn.createStatement ();
	String strSql = "select name,doc_no from gl_vehcategory where status<>7";
	ResultSet rs = stmt.executeQuery(strSql);
	//System.out.println(strSql);
	String catname="";
	String catid="";
	while(rs.next()) {
		catname+=rs.getString("name")+",";		
		catid+=rs.getString("doc_no")+",";
  		} 
	if(catname.length()>0){
		catname=catname.substring(0, catname.length()-1);	
	}
	stmt.close();
	conn.close();
	response.getWriter().write(catname+"***"+catid);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
%>
  
