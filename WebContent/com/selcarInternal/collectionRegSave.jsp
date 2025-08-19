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
		String repno=request.getParameter("repno");
		String drvid=request.getParameter("drid");
		String rpl=request.getParameter("rplno");
		
		String pkupno=request.getParameter("pkupno");
		String typechk=request.getParameter("typechk");
		System.out.println("::"+kms);
		System.out.println(rtype+":"+agmtno+""+userid+":"+km+":"+fuel+":"+time+":"+date+"==collection:repno==="+repno+"==:drvid==="+drvid+"===pkupno==="+pkupno+"===typechk==="+typechk);

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
		
		stmtUpdaterent = conn.prepareCall("{ CALL acollectionnDML(?,?,?,?,?,?,?,?,?,?,?)}");
		//CallableStatement stmt=conn.prepareCall("{call usersRegistrationDML(?,?,?,?)}");
		stmtUpdaterent.registerOutParameter(7, java.sql.Types.INTEGER);
		
		
		     stmtUpdaterent.setString(1,rtype);
			stmtUpdaterent.setString(2,km);
			stmtUpdaterent.setString(3,fuel); 
			stmtUpdaterent.setDate(4, date );
			stmtUpdaterent.setString(5,time);
			stmtUpdaterent.setString(6,userid);
			stmtUpdaterent.setString(8,agmtno);
			stmtUpdaterent.setString(9,repno);
			stmtUpdaterent.setString(10,pkupno);
			stmtUpdaterent.setString(11,typechk);
			
			stmtUpdaterent.executeUpdate();
			aa=stmtUpdaterent.getInt("docNo");
			stmtUpdaterent.close();
			
			if(aa>=1){
				Statement stmtnw=conn.createStatement();
				/* response.getWriter().write("Updated Successfully"); */
				if(!repno.equalsIgnoreCase("0")){
				String tst="update gl_vehreplace set cldrvid="+drvid+",cldate='"+date+"',cltime='"+time+"',clkm="+km+",clfuel="+fuel+",clstatus=1 where doc_no="+repno+"";
				System.out.println("RPLcollectionupdate===="+tst);
				int val=stmtnw.executeUpdate(tst);
				if(val>0){
					value="1";
				}else{
					value="Not Updated";
				}
				}else{
					value="1";
				}
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