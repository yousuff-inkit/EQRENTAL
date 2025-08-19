<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%
String total=request.getParameter("total")==null?"":request.getParameter("total");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String date=request.getParameter("date")==null?"":request.getParameter("date");
Connection conn=null;
double taxtotal=0.0;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	ClsCommon objcommon=new ClsCommon();
	double vatpercent=0.0;
	java.sql.Date sqldate=null;
	if(!date.equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(date);
	}
	int tax=0,clienttax=0;
	String strgetdocdate="select (select method from gl_config where field_nme='tax') tax,ac.cldocno,ac.tax clienttax from  my_acbook ac where ac.cldocno="+cldocno;
	ResultSet rsgetdocdate=stmt.executeQuery(strgetdocdate);
	while(rsgetdocdate.next()){
		tax=rsgetdocdate.getInt("tax");
		clienttax=rsgetdocdate.getInt("clienttax");
	}
	if(tax==1 && clienttax==1){
		String strtax="select coalesce(vat_per,0.0) vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+sqldate+"' between tax.fromdate and tax.todate";
		ResultSet rstax=stmt.executeQuery(strtax);
		while(rstax.next()){
			vatpercent=rstax.getDouble("vat_per");
		}
		
	}
	if(vatpercent>0.0){
		/*double vatval=Double.parseDouble(total)*(vatpercent/100);
		taxtotal=Double.parseDouble(total)-vatval;*/
		vatpercent=vatpercent+100;
		taxtotal=(Double.parseDouble(total)/vatpercent)*100;
	}
	else{
		taxtotal=Double.parseDouble(total);
	}
	ResultSet rsround=stmt.executeQuery("select round("+taxtotal+",0) taxtotal");
	while(rsround.next()){
		taxtotal=rsround.getDouble("taxtotal");
	}
	System.out.println(taxtotal);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(taxtotal+"");
%>