<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<% 
Connection conn=null;
int val=0;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	String strsql = "select method from gl_config where field_nme='TaskManagement'";
	ResultSet rs = stmt.executeQuery(strsql);
	while(rs.next()){
		val = rs.getInt("method");  
	}
	stmt.close();  
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().print(val);  
%>