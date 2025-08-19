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
	int val=0,cnfrm=0;
	String strSql = "select 1 cnfrm from tr_srtour where rdocno='"+rdocno+"' and confrmdate is not null";  
	ResultSet rs = stmt.executeQuery(strSql);         
	while(rs.next()){           
		cnfrm=rs.getInt("cnfrm");
  		}       
	if(cnfrm>0){            
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