<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>   
<%	
ClsConnection ClsConnection=new ClsConnection();  
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;   
    
	try{
	 	conn = ClsConnection.getMyConnection();       
		Statement stmt = conn.createStatement();           
		String rowno=request.getParameter("rowno")=="" || request.getParameter("rowno")==null?"0":request.getParameter("rowno");
		int val=0;  
		String strcountdata="";
				   strcountdata="update tr_srtour set confirm=1 where rowno='"+rowno+"'";   
				   //System.out.println("strcountdata--->>>"+strcountdata);                                                         
				   val=stmt.executeUpdate(strcountdata); 
			 	  //System.out.println("val--->>>"+val);      
			response.getWriter().print(val);                  
 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
