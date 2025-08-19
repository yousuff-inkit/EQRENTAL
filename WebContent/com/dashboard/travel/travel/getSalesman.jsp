<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
    String userid=request.getParameter("userid")=="" || request.getParameter("userid")==null?"0":request.getParameter("userid");
    Connection conn = null;      
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();  
	Statement stmt = conn.createStatement (); 
	String salesman="",salid="";  
	String strSql = "select coalesce(sal_name,'') salesman,coalesce(doc_no,'') salid from my_salm where salesuserlink='"+userid+"'";  
	ResultSet rs = stmt.executeQuery(strSql);         
	while(rs.next()){             
		salesman=rs.getString("salesman");
		salid=rs.getString("salid");      
  	}        
	stmt.close();
	conn.close();  
	response.getWriter().print(salesman+"###"+salid);                  
}
catch(Exception e){
	e.printStackTrace();  
	conn.close();
}
%>