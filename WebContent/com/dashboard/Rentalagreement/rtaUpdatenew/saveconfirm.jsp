
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


	String radocno=request.getParameter("con");
	System.out.println("radocno======="+radocno);
	String type=request.getParameter("type");
	System.out.println("type======="+type);
	 String upsql=null;
	 int val=0;
		Connection conn=null;

	 try{
 	 conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	   
	if (type.equalsIgnoreCase("rental")){
	
		upsql="update  gl_ragmt  set rtaupdate=1,rtaconfirm=1 where doc_no='"+radocno+"' ";
		System.out.println("cnfrm sqlR======="+upsql);
		 val= stmt.executeUpdate(upsql);
		 
		
		
	}
	if (type.equalsIgnoreCase("lease")){
		
		upsql="update  gl_lagmt  set rtaupdate=1,rtaconfirm=1 where status=3 and doc_no='"+radocno+"' ";
		System.out.println("cnfrm sqlL======="+upsql);
		 val= stmt.executeUpdate(upsql);
		
		
		
		
		
		
	}
	
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
