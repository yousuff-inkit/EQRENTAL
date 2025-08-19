<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
    String rdocno=request.getParameter("rdocno")=="" || request.getParameter("rdocno")==null?"0":request.getParameter("rdocno");
    Connection conn = null;      
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();  
	Statement stmt = conn.createStatement ();  
	Double total=0.0;
	// String strSql = "select coalesce(sum(amount),0) total from gl_rentreceipt where rtype='Service Request' and aggno='"+rdocno+"' group by aggno";
	String strSql = "select coalesce(sum(dramount*id),0) total from my_jvtran j inner join my_acbook a on j.acno=a.acno where j.status=3 and rtype='Service Request' and rdocno='"+rdocno+"' group by rdocno ";
	System.out.println("sql---->>>"+strSql);    
	ResultSet rs = stmt.executeQuery(strSql);         
	while(rs.next()){             
		total=rs.getDouble("total");
  		}        
	stmt.close();
	conn.close();  

	response.getWriter().print(total);             
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>