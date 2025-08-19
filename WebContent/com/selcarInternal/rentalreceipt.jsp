<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="com.common.ClsEncrypt" %>
<%@page import="net.sf.json.JSONObject" %>
<%@page import="net.sf.json.JSONArray" %>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%@page import="com.selcarInternal.*" %>
  
<%	
ClsConnection ClsConnection=new ClsConnection();
Connection conn=null;
String value="";
String typ="",cardtype="";
	try{
 		System.out.println("======aa==== ");		
		ClsAndroid and=new ClsAndroid();
		ClsCommon com=new ClsCommon();
		String usrid=request.getParameter("userid");
		String branchno=request.getParameter("branch");
		String refname=request.getParameter("fname");
		System.out.println("fname"+refname);
		String type=request.getParameter("typ");
		String cardtyp =request.getParameter("card");
		String checkno=request.getParameter("chekno");
		Date datess=com.changeStringtoSqlDate(request.getParameter("date"));
		String amount=request.getParameter("amount");
		String description=request.getParameter("describ");
		
		 
		if(type.equalsIgnoreCase("1"))
		{
			typ="cash";
		}
		if(type.equalsIgnoreCase("2"))
		{
			typ="card";
		}
		if(type.equalsIgnoreCase("3"))
		{
			typ="cheque";
		}
		
		if(cardtyp.equalsIgnoreCase("1"))
		{
			cardtype="VISA";
		}
		if(cardtyp.equalsIgnoreCase("2"))
		{
			cardtype="MASTER";
		}
		if(cardtyp.equalsIgnoreCase("3"))
		{
			cardtype="AMEX";
		}
		//System.out.println(typ);
		System.out.println(usrid+":"+branchno+":"+refname+":"+refname+":"+type+":"+cardtype+":"+checkno+":"+datess+":"+amount+":"+description);

		conn=ClsConnection.getMyConnection();
		type=and.gettype(type);
		CallableStatement stmtUpdaterent = null;
		 java.sql.Date sqlrentaldate=null;
		 int docno=0;
		 int aa=0;
		 
		 stmtUpdaterent = conn.prepareCall("{ CALL arentalreceipttDML(?,?,?,?,?,?,?,?,?,?)}");
		
			stmtUpdaterent.registerOutParameter(9, java.sql.Types.INTEGER);
			
			
			
		    stmtUpdaterent.setString(1,branchno);
			stmtUpdaterent.setString(2, refname );
			stmtUpdaterent.setString(3,typ); 
			stmtUpdaterent.setString(4, cardtype);
			stmtUpdaterent.setString(5,checkno);
			stmtUpdaterent.setDate(6,datess);
			stmtUpdaterent.setString(7,amount);
			stmtUpdaterent.setString(8,description);
			stmtUpdaterent.setString(10,usrid);
			
			stmtUpdaterent.executeUpdate();
			aa=stmtUpdaterent.getInt("docNo");
			stmtUpdaterent.close();
			
			if(aa>0){
				 
				/* response.getWriter().write("Updated Successfully"); */
				System.out.println("1");
				value="1";
				/* conn.close();
				return ; */
			}
			else{
				/* response.getWriter().write("Not Updated"); */
				System.out.println("0");
				value="0";
				/* conn.close();
				return ; */
				}
		 	
		
	}
	
	catch(Exception e){
		
		
	 	e.printStackTrace();
	 	 
	 	// response.getWriter().write("Not Updated");
	}
	finally
	{
		conn.close();
	}
	 response.getWriter().write(value);
	
  %>