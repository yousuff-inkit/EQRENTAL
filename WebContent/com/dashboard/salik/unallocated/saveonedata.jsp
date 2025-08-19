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
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();

String uptodate=request.getParameter("uptodate")==null?"0":request.getParameter("uptodate");
Date uptosqldate=objcommon.changeStringtoSqlDate(uptodate);


String strsalikarray=request.getParameter("salikarray");
ArrayList<String> salikarray= new ArrayList<String>();
for(int i=0;i<strsalikarray.split(",").length;i++){
	salikarray.add(strsalikarray.split(",")[i]);
	System.out.println("Salik Data Passed"+salikarray.get(i));
}
String rtype=request.getParameter("trftype");
String cmballocatebranch=request.getParameter("cmballocatebranch");
String rentaldoc=request.getParameter("rentaldoc");
String leasedoc=request.getParameter("leasedoc");
String drdoc=request.getParameter("drdoc");
String staffdoc=request.getParameter("staffdoc");
String fleet_no=request.getParameter("fleet_no");

String upsql=null;
int val=0;
int chafid=0; 
int  empid=0;
String emptype="";
int laradocno=0;
Connection conn = null;
int errorstatus=0;
try{
	conn = objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt = conn.createStatement ();
	if(rtype.equalsIgnoreCase("RAG"))
	{
		String ragsql="select chif,drid,cldocno from  gl_ragmt where doc_no='"+rentaldoc+"'";	 
		ResultSet newone = stmt.executeQuery(ragsql);
		if(newone.next())
		{
			chafid=newone.getInt("chif");
			if(chafid==1) 
			{
				empid=newone.getInt("drid");	
				emptype="DRV";
			}
			else{
				empid=newone.getInt("cldocno");	
				emptype="CRM";
			}
		}
		for(int i=0;i<salikarray.size();i++){
			String sqlup2="update gl_salik set isallocated=1,reason='Allocated',ra_no='"+rentaldoc+"',branch='"+cmballocatebranch+"',emp_id='"+empid+"',"+
			" emp_type='"+emptype+"',Fleetno='"+fleet_no+"',rtype='RM',manual=1 where trans='"+salikarray.get(i)+"'"; 
			System.out.println(sqlup2);
			int updateval=stmt.executeUpdate(sqlup2);	
			if(updateval<=0){
				errorstatus=1;
				break;
			}
		}
		
	}
	else if(rtype.equalsIgnoreCase("LAG"))
	{
		String lagsql="select chif,drid,cldocno  from  gl_lagmt where doc_no='"+leasedoc+"'";	 
		ResultSet leasers = stmt.executeQuery(lagsql);
		if(leasers.next())
		{
			chafid=leasers.getInt("chif");
			if(chafid==1){
				empid=leasers.getInt("drid");	
				emptype="DRV";
			}
			else{
				empid=leasers.getInt("cldocno");	
				emptype="CRM";
			}
		}
		for(int i=0;i<salikarray.size();i++){
			String sqlup2="update gl_salik set isallocated=1,reason='Allocated',ra_no='"+leasedoc+"',branch='"+cmballocatebranch+"',emp_id='"+empid+"',"+
			" emp_type='"+emptype+"',Fleetno='"+fleet_no+"',rtype='LA',manual=1 where trans='"+salikarray.get(i)+"'"; 
			System.out.println(sqlup2);
			int updateval=stmt.executeUpdate(sqlup2);	
			if(updateval<=0){
				errorstatus=1;
				break;
			}
		}
	}
	else if(rtype.equalsIgnoreCase("DRV"))
	{
		empid=Integer.parseInt(drdoc); 
		emptype="DRV";
		for(int i=0;i<salikarray.size();i++){
			String sqlup2="update gl_salik set isallocated=1,reason='Allocated',branch='"+cmballocatebranch+"',emp_id='"+empid+"',"+
			" emp_type='"+emptype+"',Fleetno='"+fleet_no+"',rtype='DR',manual=1 where trans='"+salikarray.get(i)+"'"; 
			System.out.println(sqlup2);
			int updateval=stmt.executeUpdate(sqlup2);	
			if(updateval<=0){
				errorstatus=1;
				break;
			}
		}
	}
	else if(rtype.equalsIgnoreCase("STF"))
	{
		empid=Integer.parseInt(staffdoc); 
		emptype="STF";
		for(int i=0;i<salikarray.size();i++){
			String sqlup2="update gl_salik set isallocated=1,reason='Allocated',branch='"+cmballocatebranch+"',emp_id='"+empid+"',"+
			" emp_type='"+emptype+"',Fleetno='"+fleet_no+"',rtype='ST',manual=1 where trans='"+salikarray.get(i)+"'"; 
			System.out.println(sqlup2);
			int updateval=stmt.executeUpdate(sqlup2);	
			if(updateval<=0){
				errorstatus=1;
				break;
			}
		}
 	}
	if(errorstatus==0){
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
if(errorstatus==0){
	response.getWriter().write("10");
}
else{
	response.getWriter().write("12");
} 	
	 	
%>
