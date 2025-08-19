
 <%@page import="java.sql.Date"%>
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

<%@page import="java.sql.ResultSet"%>
<%	
ClsCommon com= new ClsCommon();

	String userids=request.getParameter("userids");
	String userdesc=request.getParameter("userdesc");
	String fleetno=request.getParameter("fleetno");
	String odate=request.getParameter("odate");
	Date date=com.changetstmptoSqlDate(odate);
	String cldocno=request.getParameter("cldocno");
	 ClsConnection connDAO=new ClsConnection();
    


	 String upsql=null;
	 Connection conn=null;
	 int val=0;


	 int docno=0;


	
	 try{
		 conn = connDAO.getMyConnection();
			
		 Statement stmt = conn.createStatement ();
		 
		
		 String sqls="select coalesce((max(doc_no)+1),1) docno from gl_rdisclevel";
		 ResultSet rs=stmt.executeQuery(sqls);
		 
		 if(rs.next())
		 {
			 docno=rs.getInt("docno");
			 
			 
		 }
		 
		 
		 
		String sqlsave="insert into  gl_rdisclevel(doc_no,nuserid,desc1, date, ouserid,fleet_no,cldocno,date1) values ('"+docno+"','"+userids+"','"+userdesc+"',now(),'"+session.getAttribute("USERID").toString()+"','"+fleetno+"','"+cldocno+"','"+date+"')";
		// System.out.println("aaaaaa ====== "+sqlsave);
        val=stmt.executeUpdate(sqlsave); 
             
             
             
			response.getWriter().print(docno);
			 

	


		}catch(Exception e){
			
			conn.close();
			e.printStackTrace();
		}

	
		 
	 
	 	//System.out.println("aaaaaa"+accode);


				conn.close();
	 	  
	    
	
	%>
