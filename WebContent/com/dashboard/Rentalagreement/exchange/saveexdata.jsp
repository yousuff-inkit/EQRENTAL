
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
int errorstatus=0;
ClsCommon ClsCommon=new ClsCommon();


	String rentaldoc=request.getParameter("rentaldoc");
	
	String fleetno=request.getParameter("fleetno");

	String inkm=request.getParameter("inkm");
	String infuel=request.getParameter("infuel");
	String indate=request.getParameter("indate");
	String intime=request.getParameter("intime");
    String group=request.getParameter("group");
    String vlocation=request.getParameter("vlocation");
    
    String branchval=request.getParameter("branchval");
    
    String cldocno=request.getParameter("cldocno");
    
    
    int  cldoc=Integer.parseInt(cldocno);

	   String eorcs=request.getParameter("eorc");
	    int  eorc=Integer.parseInt(eorcs);
	       
	    String outfleet=request.getParameter("outfleet");
	    
	    String outdrvid=request.getParameter("outdrvid");
	    
	    String outkm=request.getParameter("outkm");
    
    String outfuel=request.getParameter("outfuel");
	    
	String exdate=request.getParameter("exdate");
	String extime=request.getParameter("extime");
	
	String outloc=request.getParameter("outloc");
	String remarkss=request.getParameter("remarkss");
	
	
	
	java.sql.Date sqlindate = ClsCommon.changeStringtoSqlDate(indate);
	
	java.sql.Date sqlexchdate= null;
	if(eorc==1)
	{
    sqlexchdate=ClsCommon.changeStringtoSqlDate(exdate);
	}
	 String upsql=null;
	 Connection conn=null;
	 int val=0;
	 String docno="";

	 
	 CallableStatement stmtUpdaterent = null;
	 try{
		// rentaldoc fleetno inkm infuel sqlindate intime vlocation branchval cldoc eorc outfleet outdrvid outkm outfuel sqlexchdate extime		
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			stmtUpdaterent = conn.prepareCall("{CALL rentalVehExchangeDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtUpdaterent.setString(1,rentaldoc);
			stmtUpdaterent.setString(2,fleetno);
			stmtUpdaterent.setString(3,inkm);
			stmtUpdaterent.setString(4,infuel);
			stmtUpdaterent.setDate(5,sqlindate); 
			stmtUpdaterent.setString(6,intime); 
			
			stmtUpdaterent.setString(7,vlocation);
			stmtUpdaterent.setString(8,branchval);
			stmtUpdaterent.setInt(9,cldoc);
		    stmtUpdaterent.setInt(10,eorc);
			stmtUpdaterent.setString(11,outfleet);
		    stmtUpdaterent.setString(12,outdrvid);
		    stmtUpdaterent.setString(13,outkm);
		   	stmtUpdaterent.setString(14,outfuel);
		   	stmtUpdaterent.setDate(15,sqlexchdate);
		   	stmtUpdaterent.setString(16,extime);
		  	stmtUpdaterent.setString(17,outloc);
			stmtUpdaterent.setString(18,remarkss);
		  	
			int aa=stmtUpdaterent.executeUpdate();
		//	docno=stmtUpdaterent.getString("docNo");
			if(aa<=0){
				errorstatus=1;
			}
			Statement stmt=conn.createStatement();
			if(eorc==2){
				String strupdate="update my_acbook set rostatus=if(rostatus=0,0,rostatus-1) where cldocno="+cldoc+" and dtype='CRM'";
				System.out.println(strupdate);
				int update=stmt.executeUpdate(strupdate);
				if(update<0){
					errorstatus=1;
				}	
			}
			String entry="";
			if(eorc==1){
				entry="X";
			}
			else{
				entry="C";
			}
			//String branchid=session.getAttribute("BRANCHID").toString();
			String userid=session.getAttribute("USERID").toString();
			String strloginsert="insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+rentaldoc+","+branchval+",'RAG',now(),"+userid+",'"+entry+"')";
			int loginsert=stmt.executeUpdate(strloginsert);
			if(loginsert<=0){
				errorstatus=1;
			}
			if(errorstatus==0)
			{
      			conn.commit();
			}
		}
	 	catch(Exception e){
			e.printStackTrace();
			errorstatus=1;
			conn.close();
		}
		finally{
			conn.close();
		}
		response.getWriter().write(errorstatus+"");
	    
	%>
