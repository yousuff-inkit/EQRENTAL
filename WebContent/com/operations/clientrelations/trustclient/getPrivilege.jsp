<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	

	Connection conn = null;
	
	try{
		ClsConnection connDAO = new ClsConnection();
	 	conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select doc_no,name from my_clprivilage where status=3;";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String name="";
		String pvlid="";
		while(rs.next()) {
			name+=rs.getString("name")+",";		
			pvlid+=rs.getString("doc_no")+",";
	  		} 
		
		name=name.substring(0, name.length()>0?name.length()-1:0);
		
		response.getWriter().write(name+"####"+pvlid);    
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>    