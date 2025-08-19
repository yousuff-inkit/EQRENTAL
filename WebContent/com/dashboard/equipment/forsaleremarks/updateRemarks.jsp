<%@page import="com.connection.*" %>
<%@page import="java.sql.*" %>
<%
Connection conn=null;
ClsConnection objconn=new ClsConnection();
String movdocno=request.getParameter("movdocno")==null?"":request.getParameter("movdocno");
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks");
String gridstatus=request.getParameter("gridstatus")==null?"":request.getParameter("gridstatus");
String status="0";
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String strsql="select movdocno from gl_forsale where movdocno="+movdocno;
	ResultSet rscheck=stmt.executeQuery(strsql);
	int movdocnotemp=0;
	while(rscheck.next()){
		movdocnotemp=rscheck.getInt("movdocno");
	}
	String strinsert="";
	if(movdocnotemp==0){
		strinsert="insert into gl_forsale(movdocno,fleetno,remarks)values("+movdocno+","+fleetno+",'"+remarks+"')";
	}
	else{
		strinsert="update gl_forsale set remarks='"+remarks+"' where movdocno="+movdocno+"";
	}
	int updateval=stmt.executeUpdate(strinsert);
	if(updateval>=0){
		
			String strvehinsert="update gl_vehmaster set FORSALESTATUS='"+gridstatus+"' where fleet_no="+fleetno+"";
		
			int upvehval=stmt.executeUpdate(strvehinsert);
			
			if(upvehval>0){
				String strunrentinsert="update gl_forsale set FORSALESTATUS='"+gridstatus+"' where fleetno="+fleetno+"";
				int updatefle=stmt.executeUpdate(strunrentinsert);
				
				if(upvehval>0){
					String strfleetinsert="update gl_flchange set UNRENTABLESTATUS='"+gridstatus+"' where fleetno="+fleetno+"";
					int upfleetfle=stmt.executeUpdate(strfleetinsert);        
					
				}
			}
			
		
		
	}
	if(updateval>=0){
		status="1";
		conn.commit();
	}
	stmt.close();
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(status);
%>