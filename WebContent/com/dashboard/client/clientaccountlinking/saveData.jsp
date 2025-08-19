<%@page import="com.opensymphony.xwork2.util.TextParseUtil.ParsedValueEvaluator"%>
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
	Connection conn = null;
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		String cldocno=request.getParameter("cldocno")==null || request.getParameter("cldocno")==""?"0":request.getParameter("cldocno");
		String acno=request.getParameter("acno")==null || request.getParameter("acno")==""?"0":request.getParameter("acno");
	    String sql="";int val=0;
		   
	            sql="update my_acbook set limoacno='"+acno+"' where cldocno='"+cldocno+"'";  
				System.out.println("sql====="+sql); 
	            val= stmt.executeUpdate(sql);
				  
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
