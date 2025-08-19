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
<%@page import="com.sayaraInternal.*" %>
  
<%	
String value="";
ClsConnection ClsConnection=new ClsConnection();
Connection conn=null;
	try{
 //System.out.println("======aa==== ");		
		ClsAndroid and=new ClsAndroid();
		ClsCommon com=new ClsCommon();
		String rtype =request.getParameter("rtype");
		String agmtno=request.getParameter("rdocno");
		String userid=request.getParameter("userid");
		String km=request.getParameter("km");
		String fuel =request.getParameter("fuel");
		String time=request.getParameter("time");
		Date date=com.changeStringtoSqlDate(request.getParameter("date"));
		String kms=request.getParameter("kms");
		System.out.println("::"+kms);
		System.out.println(rtype+":"+agmtno+""+userid+":"+km+":"+fuel+":"+time+":"+date);

		conn=ClsConnection.getMyConnection();
		ClsCommon comm = new ClsCommon();
		fuel=and.getFuelvalue(fuel);
		CallableStatement stmtUpdaterent = null;
		 java.sql.Date sqlrentaldate=null;
		 int docno=0;
		 int aa=0;
		 
		 if(Double.parseDouble(km)<Double.parseDouble(kms))
			{
				System.out.println("dd");
				//response.getWriter().write("Delivery KM Less Than Out KM");
				response.getWriter().write("Collection KM Must be greater than Out KM (Out KM:"+kms+")");
				conn.close();
				
				return ;
				 
				
			}
		 
		 
		Statement stmt=conn.createStatement();
		
		stmtUpdaterent = conn.prepareCall("{CALL acollectionnDML(?,?,?,?,?,?,?,?)}");
		//CallableStatement stmt=conn.prepareCall("{call usersRegistrationDML(?,?,?,?)}");
		stmtUpdaterent.registerOutParameter(8, java.sql.Types.INTEGER);
		stmtUpdaterent.setString(1,agmtno);
		     stmtUpdaterent.setString(2,rtype);
			stmtUpdaterent.setString(3,km);
			stmtUpdaterent.setString(4,fuel); 
			stmtUpdaterent.setDate(5, date );
			stmtUpdaterent.setString(6,time);
			stmtUpdaterent.setString(7,userid);
		
			
			
			aa=stmtUpdaterent.executeUpdate();
			//docno=stmtUpdaterent.getInt("docNo");
			stmtUpdaterent.close();
			
			if(aa>=1){
				 
				/* response.getWriter().write("Updated Successfully"); */
				value="1";
				/* conn.close();
				return ; */
			}
			else{
				/* response.getWriter().write("Not Updated"); */
				value="Not Updated";
				/* conn.close();
				return ; */
				}
		 	
	}
	catch(Exception e){
		
		
	 	e.printStackTrace();
	 	/* conn.close(); */ 
	 	/*  response.getWriter().write("Not Updated"); */
	}
	finally
	{
		conn.close();
	}
	response.getWriter().write(value);
	
  %>