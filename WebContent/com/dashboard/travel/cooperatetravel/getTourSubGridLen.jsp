<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
    String rdocno=request.getParameter("rdocno")=="" || request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").toString();
    ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
    	String adult="0",child="0";
			String strSql = "select coalesce(adult,0) adult,coalesce(child,0) child from tr_srtour where rowno='"+rdocno+"'";     
		    System.out.println("sql====="+strSql);                      
			ResultSet rs1 = stmt.executeQuery(strSql);   
			while(rs1.next()) {
				adult=rs1.getString("adult");
				child=rs1.getString("child");   
		  		}  
				response.getWriter().write(adult+"####"+child);                            
 		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>