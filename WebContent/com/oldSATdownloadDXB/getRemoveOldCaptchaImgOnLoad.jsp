<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@ page import="java.io.*"%>


<%	
    ClsConnection connobj=new  ClsConnection();
 	Connection conn = connobj.getMyConnection();
	Statement stmt = conn.createStatement ();
    String path="";
    
	String strSql = "select captchaPath from my_comp where comp_id='"+session.getAttribute("COMPANYID")+"'";
	ResultSet rs = stmt.executeQuery(strSql);
	while(rs.next ()) {
		path=rs.getString("captchaPath");
	}
	
	String imgPath = path+"/captcha.png";
	File temp=new File(imgPath);
	temp.delete();
	
	response.getWriter().print(path);
		
	stmt.close();	
	conn.close();
  %>
  
