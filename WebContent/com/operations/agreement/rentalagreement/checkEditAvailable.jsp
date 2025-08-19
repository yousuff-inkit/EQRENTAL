<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
JSONObject objdata=new JSONObject();
Connection conn=null;
ClsConnection objconn=new ClsConnection();
try{
	int errorstatus=0;
	int delivery=0,delstatus=0;
	String errormsg="";
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select clstatus from gl_ragmt where status=3 and doc_no="+agmtno;
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		if(rs.getInt("clstatus")==1){
			errorstatus=1;
			errormsg="Agreement Closed";
		}
	}
	if(errorstatus==0){
		String strinvcount="select count(*) rowcount from gl_invm where status=3 and ratype='RAG' and manual<>1 and rano="+agmtno;
		ResultSet rsinvcount=stmt.executeQuery(strinvcount);
		while(rsinvcount.next()){
			if(rsinvcount.getInt("rowcount")>0){
				errorstatus=1;
				errormsg="Agreement Invoiced";
			}
		}
		if(errorstatus==0){
			String strreplacecount="select count(*) rowcount from gl_vehreplace where status=3 and rtype='RAG' and rdocno="+agmtno;
			ResultSet rsreplacecount=stmt.executeQuery(strreplacecount);
			while(rsreplacecount.next()){
				if(rsreplacecount.getInt("rowcount")>0){
					errorstatus=1;
					errormsg="Agreement Vehicle Replaced";
				}
			}
		}
		if(errorstatus==0){
			String strdelivery="select delivery,delstatus from gl_ragmt where status=3 and doc_no="+agmtno;
			ResultSet rsdelivery=stmt.executeQuery(strdelivery);
			while(rsdelivery.next()){
				delivery=rsdelivery.getInt("delivery");
				delstatus=rsdelivery.getInt("delstatus");
			}
			/* if(delivery>0 && delstatus>0){
				errorstatus=1;
				errormsg="Delivery completed";
			} */
		}
	}
	objdata.put("errorstatus", errorstatus);
	objdata.put("errormsg",errormsg);
	objdata.put("delivery",delivery);
	objdata.put("delstatus",delstatus);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
System.out.println(objdata);
response.getWriter().write(objdata+"");
%>