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
		
		String selectedclients=request.getParameter("selectedclients");
	    
		String sql=null;
		int val=0,docNo=0;
	
		String sqls="select coalesce(max(doc_no)+1,1) doc_no from gl_bcap";
        ResultSet resultSet = stmt.executeQuery(sqls);
  
        while (resultSet.next()) {
		   docNo=resultSet.getInt("doc_no");
        }
        
		 /*Approval */
    	 sql="update  my_acbook set status=3 where dtype='CRM' and doc_no in ("+selectedclients+")";
     	 val= stmt.executeUpdate(sql);
	 	 
     	 /*Inserting gl_bcap*/
	     String sql2="insert into gl_bcap(doc_no, cldocno, brhid, userid) values('"+docNo+"', '"+selectedclients+"', '"+session.getAttribute("BRANCHID").toString()+"', '"+session.getAttribute("USERID").toString()+"')";
	     int data= stmt.executeUpdate(sql2);
		 if(data<=0){
			 	stmt.close();
				conn.close();
			}
		 /*Inserting gl_bcap Ends*/
		 
     	 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+session.getAttribute("BRANCHID").toString()+"','BCAP',now(),'"+session.getAttribute("USERID").toString()+"','A')";
	 	 int data1= stmt.executeUpdate(sql);
		 				
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
