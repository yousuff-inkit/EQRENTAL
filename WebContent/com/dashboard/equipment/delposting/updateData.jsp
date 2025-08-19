<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.ibm.icu.text.SimpleDateFormat" %>
<%
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
Connection conn=null;

String errorstatus="0";

String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String invno=request.getParameter("invno")==null?"":request.getParameter("invno");
String invdate=request.getParameter("invdate")=="" || request.getParameter("invdate")==null?"":request.getParameter("invdate");
String gatepassno=request.getParameter("gatepassno")==null?"":request.getParameter("gatepassno");

try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	java.sql.Date sqlinvdate=null;
	SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");              
	
    if(!invdate.equalsIgnoreCase("") && !invdate.equalsIgnoreCase("0")){
    	sqlinvdate=objcommon.changeStringtoSqlDate(invdate);   
    }	
	
	invdate = sqlinvdate != null? "'"+sqlinvdate+"'" : null;
    
	String insql="update eq_deldetails  set invno='"+invno+"', invdate="+invdate+", gatepassno='"+gatepassno+"' where srno="+docno;

	int insertlog=stmt.executeUpdate(insql);
	
	conn.setAutoCommit(false);
	
    if(insertlog>0){
		
		String branch="";
		ResultSet result = stmt.executeQuery("select brhid from eq_deldetails where srno="+docno); 
		while(result.next()){
			branch=result.getString("brhid");
		}
    	    	
    	String logsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+branch+"','BDP',now(),'"+session.getAttribute("USERID").toString()+"','E');";
      
		insertlog=stmt.executeUpdate(logsql);
    	if(insertlog<=0){
    		System.out.println("biblog Insert Error");
    		errorstatus="1";
    	}
    	
    }
    else{
    	System.out.println("Logistic Posting Update error");
    	errorstatus="1";
    }
	
	if(errorstatus=="0"){
    	conn.commit();
    }
        		
    response.getWriter().write(errorstatus);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}

%>