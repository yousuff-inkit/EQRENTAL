<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	Connection conn = null;
	String acno=request.getParameter("acno")==null?"":request.getParameter("acno");
	int status=0;
	try{
		ClsConnection connDAO = new ClsConnection();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select method from gl_config where field_nme='tax'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		int method=0;
		while(rs.next()) {
			method=rs.getInt("method");
		} 
		String strgetvendortax="select tax from my_acbook where acno="+acno;
		ResultSet rsvndtax=stmt.executeQuery(strgetvendortax);
		int vndtax=0;
		while(rsvndtax.next()){
			vndtax=rsvndtax.getInt("tax");
		}
		if(method==1 && vndtax==1){
			status=1;
		}
		else{
			status=0;
		}
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
	response.getWriter().write(status+"");
  %>
  