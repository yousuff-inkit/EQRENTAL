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
		
		String trno=request.getParameter("trno");
		String accountno=request.getParameter("accountno");
		String outamounts=request.getParameter("outamount");
		String dtype=request.getParameter("dtype");
		
		String branchid=request.getParameter("branchid");
		String date=request.getParameter("date");
		String reason=request.getParameter("reason");
		String removeall=request.getParameter("removeall")==null || request.getParameter("removeall").trim().equalsIgnoreCase("") ?"0":request.getParameter("removeall");
		
		int ap_trid=0;
		double outamount = Double.parseDouble(outamounts);
		double amount=0.00;
		
		java.sql.Date sqlDate=null;

	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		}

		String sql=null;
		int val=0,docNo=0;
		
        sql="select coalesce(max(doc_no)+1,1) doc_no from gl_bad";
        ResultSet resultSet = stmt.executeQuery(sql);
  
        while (resultSet.next()) {
		   docNo=resultSet.getInt("doc_no");
        }
  
        ClsApplyDelete applyDelete = new ClsApplyDelete();
		int applydelete=applyDelete.getFinanceApplyDelete(conn, Integer.parseInt(trno));
	    if(applydelete<0){
	    	System.out.println("*** ERROR IN APPLY DELETE ***");
        }
		  
		 /*Master Insertion */
	     sql="insert into gl_bad(doc_no, date, reason, acno, tranid, brhid, userid) values("+docNo+", '"+sqlDate+"', '"+reason+"', "+accountno+", 0, '"+branchid+"', '"+session.getAttribute("USERID").toString()+"')";
		 val= stmt.executeUpdate(sql);
	     /*Master Insertion Ends*/
	     
	     if(removeall.equalsIgnoreCase("1")) {
	     
			 String sql1="select atype from my_head where doc_no='"+accountno+"'";
	         ResultSet resultSet1 = stmt.executeQuery(sql1);
	  		 String atype="";
	         while (resultSet1.next()) {
	        	 atype=resultSet1.getString("atype");
	         }
			 
	         if(atype.equalsIgnoreCase("AR")){
	        	 
	        	 String sql2="select j.tr_no,J.TRANID,j.dramount,j.out_amount,d.* from my_jvtran j left join  my_outd d on j.tranid=d.tranid where status=3 and acno='"+accountno+"' and dramount<0 and out_amount!=0  and d.tranid is null ORDER BY J.TRANID,D.TRANID";
	             ResultSet resultSet2 = stmt.executeQuery(sql2);
	      		 
	             while (resultSet2.next()) {
	            	 int applydelete1=applyDelete.getFinanceApplyDelete(conn, resultSet2.getInt("tr_no"));
	         	     if(applydelete1<0){
	         	    	System.out.println("*** ERROR IN APPLY DELETE ***");
	                 }	 
	             }
	             
	             String sql3="select j.tr_no,J.TRANID, COALESCE(j.dramount,0),j.out_amount,d.* from my_jvtran j left join  my_outd d on j.tranid=d.ap_trid where status=3 and acno='"+accountno+"' and dramount>0 and out_amount!=0  and d.tranid is null ORDER BY j.tranid,d.ap_trid";
	             ResultSet resultSet3 = stmt.executeQuery(sql3);
	      		 
	             while (resultSet3.next()) {
	            	 int applydelete2=applyDelete.getFinanceApplyDelete(conn, resultSet3.getInt("tr_no"));
	         	     if(applydelete2<0){
	         	    	System.out.println("*** ERROR IN APPLY DELETE ***");
	                 }	 
	             }
	             
	             String sql4="select j.tr_no,J.TRANID,j.dramount,j.out_amount,d.* from my_jvtran j left join my_outd d on j.tranid=d.tranid left join my_jvtran J1 on j1.tranid=d.AP_trid where J.status=3 and j.acno='"+accountno+"' and j.dramount<0 and j.out_amount!=0 and j1.tranid is null ORDER BY J.TRANID,D.TRANID";
	             ResultSet resultSet4 = stmt.executeQuery(sql4);
	      		 
	             while (resultSet4.next()) {
	            	 int applydelete3=applyDelete.getFinanceApplyDelete(conn, resultSet4.getInt("tr_no"));
	         	     if(applydelete3<0){
	         	    	System.out.println("*** ERROR IN APPLY DELETE ***");
	                 }	 
	             }
	             
	             String sql5="select j.tr_no,J.TRANID,j.dramount,j.out_amount,d.* from my_jvtran j left join my_outd d on j.tranid=d.ap_trid left join my_jvtran J1 on j1.tranid=d.tranid where J.status=3 and j.acno='"+accountno+"' and j.dramount>0 and j.out_amount!=0 and j1.tranid is null ORDER BY j.tranid,d.ap_trid";
	             ResultSet resultSet5 = stmt.executeQuery(sql5);
	      		 
	             while (resultSet5.next()) {
	            	 int applydelete4=applyDelete.getFinanceApplyDelete(conn, resultSet5.getInt("tr_no"));
	         	     if(applydelete4<0){
	         	    	System.out.println("*** ERROR IN APPLY DELETE ***");
	                 }	 
	             }
	              
	         } else if(atype.equalsIgnoreCase("AP")){
	        	 
	        	 String sql2="select j.tr_no,J.TRANID,j.dramount,j.out_amount,d.* from my_jvtran j left join my_outd d on j.tranid=d.ap_trid where status=3 and acno='"+accountno+"' and dramount<0 and out_amount!=0 and d.tranid is null ORDER BY J.TRANID,D.TRANID";
	             ResultSet resultSet2 = stmt.executeQuery(sql2);
	      		 
	             while (resultSet2.next()) {
	            	 int applydelete1=applyDelete.getFinanceApplyDelete(conn, resultSet2.getInt("tr_no"));
	         	     if(applydelete1<0){
	         	    	System.out.println("*** ERROR IN APPLY DELETE ***");
	                 }	 
	             }
	             
	             String sql3="select j.tr_no,J.TRANID,COALESCE(j.dramount,0),j.out_amount,d.* from my_jvtran j left join my_outd d on j.tranid=d.tranid where status=3 and acno='"+accountno+"' and dramount>0 and out_amount!=0  and d.tranid is null ORDER BY j.tranid,d.ap_trid";
	             ResultSet resultSet3 = stmt.executeQuery(sql3);
	      		 
	             while (resultSet3.next()) {
	            	 int applydelete2=applyDelete.getFinanceApplyDelete(conn, resultSet3.getInt("tr_no"));
	         	     if(applydelete2<0){
	         	    	System.out.println("*** ERROR IN APPLY DELETE ***");
	                 }	 
	             }
	             
	             String sql4="select j.tr_no,J.TRANID,j.dramount,j.out_amount,d.* from my_jvtran j left join my_outd d on j.tranid=d.tranid left join  my_jvtran J1 on j1.tranid=d.AP_trid where J.status=3 and j.acno='"+accountno+"' and j.dramount>0 and j.out_amount!=0   and j1.tranid is null ORDER BY J.TRANID,D.TRANID";
	             ResultSet resultSet4 = stmt.executeQuery(sql4);
	      		 
	             while (resultSet4.next()) {
	            	 int applydelete3=applyDelete.getFinanceApplyDelete(conn, resultSet4.getInt("tr_no"));
	         	     if(applydelete3<0){
	         	    	System.out.println("*** ERROR IN APPLY DELETE ***");
	                 }	 
	             }
	             
	             String sql5="select j.tr_no,J.TRANID,j.dramount,j.out_amount,d.* from my_jvtran j left join my_outd d on j.tranid=d.ap_trid left join  my_jvtran J1 on j1.tranid=d.tranid where J.status=3 and j.acno='"+accountno+"' and j.dramount<0 and j.out_amount!=0   and j1.tranid is null ORDER BY j.tranid,d.ap_trid";
	             ResultSet resultSet5 = stmt.executeQuery(sql5);
	      		 
	             while (resultSet5.next()) {
	            	 int applydelete4=applyDelete.getFinanceApplyDelete(conn, resultSet5.getInt("tr_no"));
	         	     if(applydelete4<0){
	         	    	System.out.println("*** ERROR IN APPLY DELETE ***");
	                 }	 
	             }
	              
	         }
         
	     }
	    
		 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branchid+"','BAD',now(),'"+session.getAttribute("USERID").toString()+"','A')";
		 int data= stmt.executeUpdate(sql);
		 
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
