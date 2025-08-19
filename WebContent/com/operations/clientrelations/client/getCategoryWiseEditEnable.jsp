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
		String category=request.getParameter("category");
		String catWiseEditDisable="0";
		
		String strSql = "select coalesce(ulevel,0) ulevel from my_clcatm where dtype='CRM' and doc_no='"+category+"'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String uLevel="0";
		while(rs.next()) {
			uLevel=rs.getString("ulevel");
		} 
		
		if(uLevel.equalsIgnoreCase("1")){
			String strSql1 = "select coalesce(clientedit,0) clientedit from my_user where doc_no='"+session.getAttribute("USERID").toString().trim()+"'";
			ResultSet rs1 = stmt.executeQuery(strSql1);
			
			String clientEdit="0";
			while(rs1.next()) {
				clientEdit=rs1.getString("clientedit");
			} 
			
			if(clientEdit.equalsIgnoreCase("0")){
				catWiseEditDisable="1";
			}
		}
		
		
		response.getWriter().write(catWiseEditDisable);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  