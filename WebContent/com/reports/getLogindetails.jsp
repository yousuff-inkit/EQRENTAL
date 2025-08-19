<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsEncrypt" %>  
<%@page import="java.sql.ResultSet" %>    

<%	
    ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	ResultSet rs=null;
	Statement  stmt=null;
	String user=request.getParameter("user")==null?"":request.getParameter("user");
	String pass=request.getParameter("pass")==null?"":request.getParameter("pass");  
	int val=0;
	try{
		conn = ClsConnection.getMyConnection();
		stmt = conn.createStatement();
		ClsEncrypt ClsEncrypt=new ClsEncrypt();
		pass=ClsEncrypt.getInstance().encrypt(pass);     
		String strSql = "select coalesce(doc_no,0) doc_no from my_user where user_id='"+user+"' and pass='"+pass+"' and block=0";
		System.out.println("=== "+strSql);
	    rs = stmt.executeQuery(strSql);  
		if(rs.next()){  
			if(rs.getInt("doc_no")>0){
				val=1;
			}
		}else{
			val=0;    
		}
		response.getWriter().print(val);
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally {
		if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
		if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
		if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
		}
  %>
  