
 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

Connection conn=null;

try{

	String radocno=request.getParameter("radocno");
	String branchval=request.getParameter("branchval");
	String permfleet=request.getParameter("permfleet");
	
    
	


	 String upsql=null;

	 int val=0;
	

	 
 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	   
		
	
		upsql="update  gl_lagmt  set perfleet='"+permfleet+"' where status=3 and doc_no='"+radocno+"' ";
		
		 val= stmt.executeUpdate(upsql);
		
		 

	
		 response.getWriter().print(val);
	 
	 	//System.out.println("aaaaaa"+accode);
	 	stmt.close();
	 	conn.close();
	 	  
	}

	catch(Exception e){

				conn.close();
				e.printStackTrace();
			}
	
	%>
