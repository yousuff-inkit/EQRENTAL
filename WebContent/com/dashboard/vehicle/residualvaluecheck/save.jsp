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
String fleet=request.getParameter("fleet");
String purcost=request.getParameter("purcost");
String resval=request.getParameter("resval");
String upsql=null;
String sql=null;
int val=0;
int val1=0;
int count=0;
Connection conn=null;
int errorstatus=0;
try{
	conn = ClsConnection.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt = conn.createStatement ();
	String sqllimo="";
	String sqlmaincount="select count(*) count from gc_assettran where fleet_no='"+fleet+"'";
	int maincount=0;
	ResultSet rsmaincount=stmt.executeQuery(sqlmaincount);
	while(rsmaincount.next()){
		maincount=rsmaincount.getInt("count");
	}
	if(maincount!=0){
		sql="select count(*) count from gc_assettran where fleet_no='"+fleet+"' and Ttype='VPO'";
		ResultSet resultSet = stmt.executeQuery(sql);
	    if (resultSet.next()) {
	    	count=resultSet.getInt("count");
	    }	
		if(count==0){
			upsql="update gl_vehmaster set PRCH_COST='"+purcost+"',residual_val="+resval+"  where fleet_no='"+fleet+"' ";
		 	val=stmt.executeUpdate(upsql);
		 	if(val<0){
		 		errorstatus=1;
		 	}
		 	
		 	String strasset="update gc_assettran set dramount="+Double.parseDouble(purcost)*-1+" where fleet_no="+fleet+" and ttype='VPO'";
		 	int updateasset=stmt.executeUpdate(strasset);
		 	if(updateasset<0){
		 		errorstatus=1;
		 	}
		 	if(errorstatus==0){
		 		conn.commit();
		 	}
		 	/* if(errorstatus==0){
		 		int assetdocno=0;
				String strgetassetdocno="select coalesce((max(doc_no)+1),1) docno from gc_assettran";
				ResultSet rsgetassetdocno = stmt.executeQuery (strgetassetdocno);
				while(rsgetassetdocno.next()) {
					assetdocno=rsgetassetdocno.getInt("docno");		
				}
				int vehacno=0;     
				String strgetvehacno="select  acno from my_account where codeno='VEH'";
				ResultSet rsgetvehacno = stmt.executeQuery (strgetvehacno);
				while(rsgetvehacno.next()) {
					vehacno=rsgetvehacno.getInt("acno");		
				}
				int trno=0;
				String strgettrno="select coalesce((max(tr_no)+1),1) trno from my_trno";
				ResultSet rsgettrno = stmt.executeQuery (strgettrno);
				while(rsgettrno.next()) {
					trno=rsgettrno.getInt("trno");		
				}
				String strinserttrno="";
		 		String sqlinsertasset="INSERT INTO gc_assettran(date,doc_no,fleet_no,acno,dramount,brhid,ttype,ftype,tr_no)VALUES"
		 		       + " (CURDATE(),'"+assetdocno+"','"+fleet+"','"+vehacno+"','"+purcost+"','"+session.getAttribute("BRANCHID").toString()+"',"
		 		       +"'FAD',1,'"+trno+"' )";
		 		int insertgcasset=stmt.executeUpdate(sqlinsertasset);
		 		if(insertgcasset<=0){
		 			errorstatus=1;
		 		}
		 	} */
		 	
		
		}	
	}
	else{
		errorstatus=-1;
	}
	response.getWriter().print(errorstatus);
	 
	 	
	 	stmt.close();
	 	conn.close();
	
	 	}
    catch(Exception e){

	 conn.close();
	 e.printStackTrace();
	 		}	  
	    
	
	%>
