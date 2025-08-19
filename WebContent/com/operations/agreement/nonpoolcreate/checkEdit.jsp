<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
	ClsConnection objconn=new ClsConnection();
	int errorstatus=0;
	String errormsg="";
	Connection conn=null;
	String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
	String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
	try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		String strcheckclosing="select clstatus from gl_nonpoolveh where doc_no="+docno;
		ResultSet rscheckclosing=stmt.executeQuery(strcheckclosing);
		while(rscheckclosing.next()){
			if(rscheckclosing.getInt("clstatus")==1){
				errorstatus=1;
				errormsg="Agreement already closed";
			}
		}
		if(errorstatus==0){
			String strcheckvehicle="select tran_code from gl_vehmaster where fleet_no="+fleetno;
			ResultSet rscheckvehicle=stmt.executeQuery(strcheckvehicle);
			while(rscheckvehicle.next()){
				if(!rscheckvehicle.getString("tran_code").equalsIgnoreCase("RR")){
					errorstatus=1;
					errormsg="Transactions exists";
				}
			}
		}
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
	response.getWriter().write(errorstatus+"***"+errormsg);
%>