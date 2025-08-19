
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
	String rowno=request.getParameter("rowno");
	String sql=null;
	int val=0;

 	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();

		 /*Audit */
    	 sql="update my_fileattach  set status=3 where rowno='"+rowno+"'";
		 System.out.println(sql);
     	 val= stmt.executeUpdate(sql);
		 				
		 response.getWriter().print(val);

	 	stmt.close();
	 	conn.close();
  }catch(Exception e){

	 			conn.close();
	 			e.printStackTrace();
	 		}
	 	
	%>
