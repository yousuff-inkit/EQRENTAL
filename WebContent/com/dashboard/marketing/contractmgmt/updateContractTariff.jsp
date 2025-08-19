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
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String temp0[]=request.getParameterValues("tariffarray[]");
ArrayList<String> tariffarray=new ArrayList();
for(int i=0;i<temp0.length;i++){
	tariffarray.add(temp0[i]);
}

Connection conn=null;
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	ClsCommon objcommon=new ClsCommon();
	
	conn.setAutoCommit(false);
	
	String userid=session.getAttribute("USERID").toString();
	
	int deletedetail=stmt.executeUpdate("delete from gl_rentalcontractd where rdocno="+docno);
	for(int i=0,j=1;i<tariffarray.size();i++,j++){
		String temp[]=tariffarray.get(i).split("::");
		String code=temp[0]==null || temp[0].trim().equalsIgnoreCase("") || temp[0].trim().equalsIgnoreCase("undefined") || temp[0].trim().isEmpty()?"0":temp[0].trim();
		String grpid=temp[1]==null || temp[1].trim().equalsIgnoreCase("") || temp[1].trim().equalsIgnoreCase("undefined") || temp[1].trim().isEmpty()?"0":temp[1].trim();
		String tarifdocno=temp[2]==null || temp[2].trim().equalsIgnoreCase("") || temp[2].trim().equalsIgnoreCase("undefined") || temp[2].trim().isEmpty()?"0":temp[2].trim();
		String qty=temp[3]==null || temp[3].trim().equalsIgnoreCase("") || temp[3].trim().equalsIgnoreCase("undefined") || temp[3].trim().isEmpty()?"0":temp[3].trim();
		String hiremode=temp[4]==null || temp[4].trim().equalsIgnoreCase("") || temp[4].trim().equalsIgnoreCase("undefined") || temp[4].trim().isEmpty()?"0":temp[4].trim();
		String subtotal=temp[5]==null || temp[5].trim().equalsIgnoreCase("") || temp[5].trim().equalsIgnoreCase("undefined") || temp[5].trim().isEmpty()?"0":temp[5].trim();
		String maxdiscount=temp[6]==null || temp[6].trim().equalsIgnoreCase("") || temp[6].trim().equalsIgnoreCase("undefined") || temp[6].trim().isEmpty()?"0":temp[6].trim();
		String discount=temp[7]==null || temp[7].trim().equalsIgnoreCase("") || temp[7].trim().equalsIgnoreCase("undefined") || temp[7].trim().isEmpty()?"0":temp[7].trim();
		String total=temp[8]==null || temp[8].trim().equalsIgnoreCase("") || temp[8].trim().equalsIgnoreCase("undefined") || temp[8].trim().isEmpty()?"0":temp[8].trim();
		String vatperc=temp[9]==null || temp[9].trim().equalsIgnoreCase("") || temp[9].trim().equalsIgnoreCase("undefined") || temp[9].trim().isEmpty()?"0":temp[9].trim();
		String vatamt=temp[10]==null || temp[10].trim().equalsIgnoreCase("") || temp[10].trim().equalsIgnoreCase("undefined") || temp[10].trim().isEmpty()?"0":temp[10].trim();
		String nettotal=temp[11]==null || temp[11].trim().equalsIgnoreCase("") || temp[11].trim().equalsIgnoreCase("undefined") || temp[11].trim().isEmpty()?"0":temp[11].trim();
		String equipdesc=temp[12]==null || temp[12].trim().equalsIgnoreCase("") || temp[12].trim().equalsIgnoreCase("undefined") || temp[12].trim().isEmpty()?"0":temp[12].trim();
		String detaildocno=temp[13]==null || temp[13].trim().equalsIgnoreCase("") || temp[13].trim().equalsIgnoreCase("undefined") || temp[13].trim().isEmpty()?"0":temp[13].trim();
		
		String strinsertdetail="insert into gl_rentalcontractd(rdocno, srno, code,grpid, tarifdocno, status,qty,hiremode,subtotal,discount,total,vatperc,vatamt,nettotal,maxdiscount,quotedetdocno,equipdesc)values("+
		""+docno+","+j+","+code+","+grpid+","+tarifdocno+",3,"+qty+",'"+hiremode+"',"+subtotal+","+discount+","+total+","+vatperc+","+vatamt+","+nettotal+","+maxdiscount+","+detaildocno+",'"+equipdesc+"')";
				
		int insertdetail=stmt.executeUpdate(strinsertdetail);
		if(insertdetail<=0){
			System.out.println("Detail Insert Error");
			errorstatus=1;
		}
	}
	
	String logsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+docno+",'"+brhid+"','BCM',now(),'"+userid+"','E')";
	int logins=stmt.executeUpdate(logsql);
	if(logins<=0){
		errorstatus=1;
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