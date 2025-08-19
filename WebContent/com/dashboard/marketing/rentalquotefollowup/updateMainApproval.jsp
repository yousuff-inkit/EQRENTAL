<%@page import="java.util.ArrayList"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
ClsConnection objconn=new ClsConnection();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String temp[]=request.getParameterValues("fleetarray[]");
ArrayList<String> fleetarray=new ArrayList();
for(int i=0;i<temp.length;i++){
	fleetarray.add(temp[i]);
}

Connection conn=null;
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	ClsCommon objcommon=new ClsCommon();
	
	conn.setAutoCommit(false);
	String brhid=session.getAttribute("BRANCHID").toString();
	String userid=session.getAttribute("USERID").toString();
	for(int i=0;i<fleetarray.size();i++){
		String calcdocno=fleetarray.get(i).split("::")[0];
		String fleetno=fleetarray.get(i).split("::")[1];
		String grpid=fleetarray.get(i).split("::")[2];
		String strupdate="update gl_rentalquotecalc set fleet_no="+fleetno+",currentfleetno="+fleetno+",grpid="+grpid+",approved=1 where doc_no="+calcdocno;
		System.out.println(strupdate);
		int update=stmt.executeUpdate(strupdate);
		if(update<0){
			errorstatus=1;
		}
		String strupdateveh="update gl_equipmaster set tran_code='PDI' where fleet_no="+fleetno;
		System.out.println(strupdateveh);
		int updateveh=stmt.executeUpdate(strupdateveh);
		if(updateveh<0){
			errorstatus=1;
		}
		
	}
	String strgetnotapprovedcount="select count(*) itemcount from gl_rentalquotecalc where approved=0 and rdocno="+docno;
	System.out.println(strgetnotapprovedcount);
	int itemcount=-1;
	ResultSet rsgetcount=stmt.executeQuery(strgetnotapprovedcount);
	while(rsgetcount.next()){
		itemcount=rsgetcount.getInt("itemcount");
	}
	if(itemcount==0){
		String strupdate="update gl_rentalquotem set processstatus=3 where doc_no="+docno;	
		System.out.println(strupdate);
		int update=stmt.executeUpdate(strupdate);
		if(update<=0){
			errorstatus=1;
		}	
	}
	if(errorstatus==0){
		conn.commit();	
	}
	
}
catch(Exception e){
	errorstatus=1;
	e.printStackTrace();
}
finally{
	conn.close();
}
objdata.put("errorstatus",errorstatus);
response.getWriter().write(objdata+"");
%>