<%@page import="com.common.ClsCommon"%>
<%@page import="com.operations.commtransactions.rentalrefund.ClsRentalRefundDAO"%>
<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;
	Connection con = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();
		
		String rtype=request.getParameter("rtype")==null?"0":request.getParameter("rtype").trim();
		//System.out.println("rtype======="+rtype);
		String rdocno=request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").trim();
		//System.out.println("rdocno======"+rdocno);
		String trno=request.getParameter("trno")==null?"0":request.getParameter("trno").trim();
		//System.out.println("trno======"+trno);
		String sql="",sql1="",msg="",sql2="";
		int val=0;
		
		if(rtype.equalsIgnoreCase("Rental"))
		{
			sql1="RAG";
		}else{
			sql1="LAG";
		}
		
		if(!(trno.equalsIgnoreCase("0"))){
			//System.out.println("in update=======");
			
			 sql2="select acno from my_account where codeno='rsecurity'";
			 //System.out.println("sql2====="+sql2);
			 ResultSet resultSet = stmt.executeQuery (sql2);
			 if(resultSet.next()){
				 val=resultSet.getInt("acno");
			 sql="update my_jvtran set rdocno="+rdocno+",rtype='"+sql1+"' where acno="+val+" and tr_no="+trno+"";
			 //System.out.println("sql====="+sql);
			 val= stmt.executeUpdate(sql);
			 //System.out.println("val====="+val);
			 }
		}
		
		 
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
  
