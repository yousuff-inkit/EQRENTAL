<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String reqsrno=request.getParameter("reqsrno").equalsIgnoreCase("") || request.getParameter("reqsrno")==null?"0":request.getParameter("reqsrno");
String calcdocno=request.getParameter("calcdocno").equalsIgnoreCase("") || request.getParameter("calcdocno")==null?"0":request.getParameter("calcdocno");
String reqdocno=request.getParameter("reqdocno").equalsIgnoreCase("") || request.getParameter("reqdocno")==null?"0":request.getParameter("reqdocno");
String total=request.getParameter("total").equalsIgnoreCase("") || request.getParameter("total")==null?"0":request.getParameter("total");
String residalvalue=request.getParameter("residalvalue").equalsIgnoreCase("") || request.getParameter("residalvalue")==null?"0":request.getParameter("residalvalue");
String vehiclecost=request.getParameter("vehiclecost").equalsIgnoreCase("") || request.getParameter("vehiclecost")==null?"0":request.getParameter("vehiclecost");
String excesskmrate=request.getParameter("excesskmrate").equalsIgnoreCase("") || request.getParameter("excesskmrate")==null?"0":request.getParameter("excesskmrate");
String landedcost=request.getParameter("landedcost").equalsIgnoreCase("") || request.getParameter("landedcost")==null?"0":request.getParameter("landedcost");
String margincost=request.getParameter("margincost").equalsIgnoreCase("") || request.getParameter("margincost")==null?"0":request.getParameter("margincost");
String daimler=request.getParameter("daimler").equalsIgnoreCase("") || request.getParameter("daimler")==null?"0":request.getParameter("daimler");
String vat=request.getParameter("vat").equalsIgnoreCase("") || request.getParameter("vat")==null?"0":request.getParameter("vat");
double taxtotal=0.0;
// taxtotal=Double.parseDouble(total)+Double.parseDouble(vat);

taxtotal=Double.parseDouble(total);
Connection conn=null;
int status=0;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String strsql="update gl_leasecalcreq set totalvalue="+taxtotal+",savestatus=1,residalvalue="+residalvalue+",prchcost="+vehiclecost+",excesskmrate="+excesskmrate+",landedcost="+landedcost+",margin="+margincost+",daimlersupport="+daimler+" where rdocno="+calcdocno+" and leasereqdocno="+reqdocno+" and"+
			" reqsrno="+reqsrno;
	System.out.println(strsql);
	int updateval=stmt.executeUpdate(strsql);
	if(updateval>0){
		String strupdate="update gl_lprd set masterstatus=2 where rdocno="+reqdocno+" and sr_no="+reqsrno;
		int lprdupdate=stmt.executeUpdate(strupdate);
		if(lprdupdate>0){
			status=1; 			
			conn.commit();
		}
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(status+"");
%>