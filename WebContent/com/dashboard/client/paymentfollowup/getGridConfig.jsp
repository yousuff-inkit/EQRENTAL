<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		
		String strSql = "select method from gl_config where field_nme='PaymentDueDate'"; 
		ResultSet rs = stmt.executeQuery(strSql);
		String method="";
		while(rs.next()) {
				method=rs.getString("method"); 
	  		} 
		response.getWriter().print(method);
		stmt.close();  
	}catch(Exception e){
	 	e.printStackTrace();
	}finally{
		conn.close();
	}
  %>