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
	int val=0,xodoc=0,method=0;
	
	String strConfig = "select coalesce(method,0) method from gl_config where field_nme='lammo tourism'";  
	System.out.print("strConfig==="+strConfig);    
	ResultSet rs1 = stmt.executeQuery(strConfig);             
	while(rs1.next()){                  
		method=rs1.getInt("method");             
  	} 
	if(method==1){
		
		String strSql = "select * from tr_servicereqm where doc_no="+rdocno+" and cldocno!=0 ";  
		System.out.print("strSql==="+strSql);    
		ResultSet rs = stmt.executeQuery(strSql);           
		while(rs.next()){           
			val=1;       
	  		}       
		if(val==0){         
			
		strSql = "select coalesce(srno,0) srno from gl_rentreceipt where aggno='"+rdocno+"' and rtype='Service Request'";  
		System.out.print("strSql==="+strSql);    
		rs = stmt.executeQuery(strSql);           
		while(rs.next()){           
			xodoc=rs.getInt("srno");       
	  		}       
		if(xodoc>0){         
			val=1;           
		}
		
		String strSql2 = "select coalesce(tr_no,0) tr_no from my_jvtran where rdocno='"+rdocno+"' and rtype='Service Request'";  
		System.out.print("strSql2==="+strSql2);    
		ResultSet rs2 = stmt.executeQuery(strSql2);           
		while(rs2.next()){           
			xodoc=rs2.getInt("tr_no");       
	  		}       
		if(xodoc>0){         
			val=1;           
		} 
		}
		}else{
		String strSql = "select coalesce(srno,0) srno from gl_rentreceipt where aggno='"+rdocno+"' and rtype='Service Request'";  
		System.out.print("strSql==="+strSql);    
		ResultSet rs = stmt.executeQuery(strSql);           
		while(rs.next()){           
			xodoc=rs.getInt("srno");       
	  		}       
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