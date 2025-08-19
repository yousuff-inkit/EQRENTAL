<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
String refno=request.getParameter("refno")==null?"":request.getParameter("refno");
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select * from (select coalesce(sum(calc.approved),0) maxqty,d.outqty outqty,coalesce(m.voc_no,'') refno,m.date,concat('NAME: ',coalesce(ac.refname,''),' ADDRESS: ',coalesce(ac.address,''))"+
	" clientdetails,m.doc_no docno,m.voc_no vocno,m.brhid,m.cldocno,'QOT' reftype,coalesce(m.doc_no,'') hidrefno,"+
	" coalesce(ac.sal_id,'') salid,coalesce(sal.sal_name,'') salesman,round(coalesce(m.delcharges,0),2) delcharges,round(coalesce(m.collcharges,0),2) collcharges,round(coalesce(m.vatamt,0),2) vatamt, round(coalesce(m.totalamt,0),2) totalamt,m.description,m.delremark,round(coalesce(m.srvcharges,0),2) srvcharges,coalesce(m.srvdesc,'')srvdesc  from gl_rentalquotem m"+
	" left join gl_rentalquoted d on m.doc_no=d.rdocno left join gl_rentalquotecalc calc on (d.doc_no=calc.detdocno and calc.approved=1  and calc.contractdocno=0) left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') left join my_salm sal on ac.sal_id=sal.doc_no"+
	" where m.doc_no="+refno+" and m.status=3 and m.followupstatus<>2 group by m.doc_no) base where base.maxqty-base.outqty>0";
	
	ResultSet rs=stmt.executeQuery(strsql);
	int errorstatus=1;
	while(rs.next()){
		objdata.put("cldocno",rs.getString("cldocno"));
		objdata.put("clientdetails",rs.getString("clientdetails"));
		objdata.put("reftype",rs.getString("reftype"));
		objdata.put("refno",rs.getString("refno"));
		objdata.put("hidrefno",rs.getString("hidrefno"));
		objdata.put("salesman",rs.getString("salesman"));
		objdata.put("salid",rs.getString("salid"));
		objdata.put("delcharges",rs.getString("delcharges"));
		objdata.put("collcharges",rs.getString("collcharges"));
		objdata.put("vatamt",rs.getString("vatamt"));
		objdata.put("totalamt",rs.getString("totalamt"));
		objdata.put("description",rs.getString("description"));
		objdata.put("delremark",rs.getString("delremark"));
		objdata.put("srvcharges",rs.getString("srvcharges"));
		objdata.put("srvdesc",rs.getString("srvdesc"));
		errorstatus=0;
	}
	objdata.put("errorstatus",errorstatus);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>