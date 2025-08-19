<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>   
<%
    String masterdoc=request.getParameter("masterdoc")==null || request.getParameter("masterdoc")==""?"0":request.getParameter("masterdoc");
    String date=request.getParameter("date")==null || request.getParameter("date")==""?"0":request.getParameter("date");    
    Connection conn = null;  
    ClsCommon ClsCommon=new ClsCommon();
    java.sql.Date sqldate=null;
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();  
	Statement stmt = conn.createStatement ();  
	int val=0;
	if(!date.equalsIgnoreCase("0")){          
   	 sqldate=ClsCommon.changeStringtoSqlDate(date);  
    }
	String strSql = "select if(max(date)='"+sqldate+"',1,0) val from hr_incrm where empid='"+masterdoc+"' and dtype='HSAP' and status=3";
	//System.out.println("strSql---------->>>"+strSql);
	ResultSet rs = stmt.executeQuery(strSql);         
	while(rs.next()) {         
		val=rs.getInt("val");          
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