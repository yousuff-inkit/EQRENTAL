<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>    
<%
String transfertype=request.getParameter("transfertype")=="" || request.getParameter("transfertype")==null?"0":request.getParameter("transfertype").toString();  
String cldocno=request.getParameter("cldocno")=="" || request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").toString();
String pickuplocid=request.getParameter("pickuplocid")=="" || request.getParameter("pickuplocid")==null?"0":request.getParameter("pickuplocid").toString();
String dropofflocid=request.getParameter("dropofflocid")=="" || request.getParameter("dropofflocid")==null?"0":request.getParameter("dropofflocid").toString();
String groupid=request.getParameter("groupid")=="" || request.getParameter("groupid")==null?"0":request.getParameter("groupid").toString();     
String result="";
int errorstatus=0;         
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();   
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();  
	ResultSet resultSet =null,resultSet1=null,resultSet2=null;
	String sqltest="";
	
	int clientcatid=0;
	String clientcatname="";   
	String clientname="";
	String strclientcategory="select cat.doc_no,cat.cat_name,ac.refname from my_acbook ac left join my_clcatm cat on ac.catid=cat.doc_no where ac.cldocno="+cldocno+" and ac.dtype='CRM';";
	ResultSet rsclientcat=stmt.executeQuery(strclientcategory);
	while(rsclientcat.next()){
		clientcatid=rsclientcat.getInt("doc_no");  
		clientcatname=rsclientcat.getString("cat_name");
		clientname=rsclientcat.getString("refname");
	}
	
	String strsql="";      
	result=0+"::"+0+"::"+0+"::"+0+"::"+0+"::"+0+"::"+0;    
	strsql="select tarifdetaildocno,estdistance,esttime,coalesce(tarif,0) tarif,exdistancerate,extimerate,doc_no tarifdocno from (select m.doc_no,m.validto,concat(m.tariftype,' - ','"+clientname+"',' - ',m.desc1) tariftype,m.tarifclient,tran.gid,tran.doc_no "+
			" tarifdetaildocno,tran.estdist estdistance,tran.esttime,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate from gl_limotarifm m left join"+
			" gl_limotariftransfer tran on tran.tarifdocno=m.doc_no where m.tariffor='"+transfertype+"' and current_date between m.validfrom and m.validto and m.status=3 and (tran.gid="+groupid+" and "+
			" tran.pickuplocid="+pickuplocid+" and tran.dropofflocid='"+dropofflocid+"') and m.tariftype='Client' and m.tarifclient="+cldocno+" group by m.doc_no union all "+
			" select aa.doc_no,aa.validto,concat(aa.tariftype,' - ','"+clientcatname+"',' - ',aa.desc1) tariftype,aa.doc_no tarifdetaildocno,aa.gid,aa.tarifclient,aa.estdistance,"+
			" aa.esttime,aa.tarif,aa.exdistancerate,aa.extimerate from (select m.doc_no,m.validto,m.tariftype,m.tarifclient,m.desc1,tran.estdist estdistance,tran.doc_no "+
			" tarifdetaildocno,tran.esttime,tran.gid,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate from gl_limotarifm m left join gl_limotariftransfer tran on"+
			" tran.tarifdocno=m.doc_no where m.tariffor='"+transfertype+"' and current_date between m.validfrom and m.validto and m.status=3 and (tran.gid="+groupid+" and tran.pickuplocid="+pickuplocid+" "+
			" and tran.dropofflocid='"+dropofflocid+"') and m.tariftype='Corporate' and m.tarifclient="+clientcatid+" group by m.doc_no) aa union all"+
			" select m.doc_no,m.validto,concat(m.tariftype,' - ',m.desc1) tariftype,m.tarifclient,tran.doc_no tarifdetaildocno,tran.gid,tran.estdist estdistance,"+
			" tran.esttime,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate from gl_limotarifm m left join gl_limotariftransfer tran on tran.tarifdocno=m.doc_no "+
			" where m.tariffor='"+transfertype+"' and current_date between m.validfrom and m.validto and m.status=3 and (tran.gid="+groupid+" and tran.pickuplocid="+pickuplocid+" and "+
			" tran.dropofflocid='"+dropofflocid+"') and m.tariftype='regular' group by m.doc_no) zz ";
	
	System.out.println("Tarif Query:---"+strsql);      
	ResultSet rs=stmt.executeQuery(strsql);     
	while(rs.next()){         
		result=rs.getString("tarifdetaildocno")+"::"+rs.getString("estdistance")+"::"+rs.getString("esttime")+"::"+rs.getString("exdistancerate")+"::"+rs.getString("extimerate")+"::"+rs.getString("tarif")+"::"+rs.getString("tarifdocno");        
    }
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(result);
%>  