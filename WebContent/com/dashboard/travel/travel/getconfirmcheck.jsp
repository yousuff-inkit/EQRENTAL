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
	int val=0,xodoc=0,method=0,cpudoc=0;
	String strSql2 = "select coalesce(method,0) method  from gl_config where field_nme='lammo tourism'";  
	ResultSet rs2 = stmt.executeQuery(strSql2);         
	while(rs2.next()){           
		method=rs2.getInt("method");
  		} 
	String strSql = "select coalesce(xodoc,0) xodoc,coalesce(cpudoc,0) cpudoc from tr_srtour where rdocno='"+rdocno+"'";  
	ResultSet rs = stmt.executeQuery(strSql);         
	while(rs.next()){           
		xodoc=rs.getInt("xodoc");
		cpudoc=rs.getInt("cpudoc");
  		} 
	if(method==1){  
		if(cpudoc>0){         
			val=1;           
		}  
	}else{
		if(xodoc>0){           
			val=1;           
		}
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