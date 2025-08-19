<%@page import="com.dashboard.limousine.importdata.ClsLimoImportDataDAO"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%
	Connection conn = null;
	ClsConnection objconn=new ClsConnection();
	try{ 
	 	conn = objconn.getMyConnection();
	 	String docNo=request.getParameter("docNo");
	 	String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
	 	ClsLimoImportDataDAO jvt = new ClsLimoImportDataDAO();
		int val=jvt.ExcelImport(docNo,cldocno);
		response.getWriter().print(val);
	 	conn.close(); 
	}catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
  
