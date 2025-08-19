<%@page import="com.common.ClsCommon"%>    
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
<%@page import="java.io.*" %>
<%@page import="org.apache.struts2.ServletActionContext" %>
<%@page import="com.dashboard.travel.travel.ClsTravelAction"%>               
<%
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();        
	ClsCommon ClsCommon=new ClsCommon();
	String amendment=request.getParameter("amendment")==null || request.getParameter("amendment")==""?"0":request.getParameter("amendment").trim().toString();
	String rdocno=request.getParameter("rdocno")==null || request.getParameter("rdocno")==""?"0":request.getParameter("rdocno").trim().toString();
	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid").trim().toString();
	String id=request.getParameter("id")==null || request.getParameter("id")==""?"0":request.getParameter("id").trim().toString();   
	String status="1";  
	String mobile="";
	String msg="";       
	try{   
	 	conn = ClsConnection.getMyConnection();               
	 	ClsTravelAction tvlaction=new ClsTravelAction();
 	 	if(id.equalsIgnoreCase("1") || id.equalsIgnoreCase("3")){  
 	 		tvlaction.emailAction(rdocno,brhid,amendment);	
	 	}
	 	System.out.println("IN send mail==");   
	 	//Getting Data for WhatsApp
	 	Statement stmt=conn.createStatement();
	 	if(id.equalsIgnoreCase("2") || id.equalsIgnoreCase("3")){		
		 	String strgetdata = "select vendorid,mail1,per_mob from tr_srtour t left join my_acbook ac on ac.cldocno=t.vendorid and dtype='vnd' where rdocno='"+rdocno+"' limit 1";   
	 		ResultSet rsgetdata = stmt.executeQuery(strgetdata);   
	 		while(rsgetdata.next ()) {
	 			mobile=rsgetdata.getString("per_mob");                
	 		}
	 		String strmessage="select coalesce(msg,'') msg from my_whatsappsettings where dtype='TRXO' and  brhid in("+brhid+",0) and status=3";
	 		ResultSet rsmsg=stmt.executeQuery(strmessage);
	 		String sqlmessage="";
	 		while(rsmsg.next()){
	 			sqlmessage=rsmsg.getString("msg").replaceAll("branch", brhid).replaceAll("documentno", rdocno);
	 			//.replaceAll("documenttype", '');
	 		}
		    
	 		if(!(sqlmessage.trim().equalsIgnoreCase(""))){
			    ResultSet rsfinalmsg=stmt.executeQuery(sqlmessage);
			    while(rsfinalmsg.next()) {
				   msg =rsfinalmsg.getString("msg");	
			    }
			}
	 		if(!msg.equalsIgnoreCase("") && !mobile.equalsIgnoreCase("")){
	 			String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
	 			String strinsertlog="insert into my_whatsappbox(edate,sender,message,staus,phone)values(now(),"+userid+",'"+msg+"',1,'"+mobile+"')";
	 			int insertlog=stmt.executeUpdate(strinsertlog);
	 		} 
	 	}      
	}catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   }finally{
	   conn.close();
   }
   response.getWriter().print(status+" :: "+mobile+" :: "+msg);
%>