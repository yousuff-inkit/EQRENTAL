<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
    ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	String locid=request.getParameter("locid")==null || request.getParameter("locid")==""?"0":request.getParameter("locid");
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
        int brhid=0;
			String strSql = "select brhid from my_locm where status=3 and doc_no='"+locid+"'";     
		    System.out.println("sql====="+strSql);              
			ResultSet rs1 = stmt.executeQuery(strSql);
			while(rs1.next()) {
				brhid=rs1.getInt("brhid");     
		  		}  
		
		response.getWriter().print(brhid);                         
 		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>