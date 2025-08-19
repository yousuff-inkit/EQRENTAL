<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
    String trno=request.getParameter("txttranno")==null?"0":request.getParameter("txttranno");
 	Connection conn = null;
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();  
	int val=0,posttrno=0;
	String strSql = "select posttrno from gl_rentreceipt where tr_no='"+trno+"'";
	//System.out.println("strSql--------->>"+strSql);      
	ResultSet rs = stmt.executeQuery(strSql);   
   
	if(rs.next()) {   
		posttrno=rs.getInt("posttrno");
  		}    
	if(posttrno>0){
		val=1;   
	}
	String strSql2 = "select * from my_chqdet where tr_no='"+trno+"' and !((pdc=1 and status='E') or (pdc=0))";
	ResultSet rs2 = stmt.executeQuery(strSql2);   
	//System.out.println("strSql2--------->>"+strSql2);   
	if(rs2.next()) {   
		val=1; 
	}
	stmt.close();
	conn.close();  

	response.getWriter().print(val);         
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>