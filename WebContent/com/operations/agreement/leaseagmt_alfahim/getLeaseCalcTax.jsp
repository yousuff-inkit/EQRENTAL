<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%
String total=request.getParameter("total")==null?"":request.getParameter("total");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String monthno=request.getParameter("monthno")==null?"":request.getParameter("monthno");
String rent=request.getParameter("rent")==null?"":request.getParameter("rent");
String cdw=request.getParameter("cdw")==null?"":request.getParameter("cdw");
String pai=request.getParameter("pai")==null?"":request.getParameter("pai");
String cdw1=request.getParameter("cdw1")==null?"":request.getParameter("cdw1");
String pai1=request.getParameter("pai1")==null?"":request.getParameter("pai1");
String gps=request.getParameter("gps")==null?"":request.getParameter("gps");
String babyseater=request.getParameter("babyseater")==null?"":request.getParameter("babyseater");
String cooler=request.getParameter("cooler")==null?"":request.getParameter("cooler");
String chaufferchg=request.getParameter("chaufferchg")==null?"":request.getParameter("chaufferchg");
String apc=request.getParameter("apc")==null?"":request.getParameter("apc");
Connection conn=null;
double taxtotal=0.0;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	ClsCommon objcommon=new ClsCommon();
	double vatpercent=0.0;
	java.sql.Date sqldate=null;
	int cldocno=0;
	String strgetclient="select cldocno,date from gl_lagmt where doc_no="+docno;
	ResultSet rsgetclient=stmt.executeQuery(strgetclient);
	while(rsgetclient.next()){
		cldocno=rsgetclient.getInt("cldocno");
		sqldate=rsgetclient.getDate("date");
	}
	int tax=0,clienttax=0;
	String strgetdocdate="select (select method from gl_config where field_nme='tax') tax,ac.cldocno,ac.tax clienttax from gl_lagmt agmt inner join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') where agmt.doc_no="+docno;
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
		/* double vatval=Double.parseDouble(total)*(vatpercent/100); */
		double vatval=vatpercent/100;
		double renttax=objcommon.sqlRound((Double.parseDouble(rent)+(Double.parseDouble(rent)*vatval)), 0);
		double cdwtax=objcommon.sqlRound((Double.parseDouble(cdw)+(Double.parseDouble(cdw)*vatval)), 0);
		double paitax=objcommon.sqlRound((Double.parseDouble(pai)+(Double.parseDouble(pai)*vatval)), 0);
		double cdw1tax=objcommon.sqlRound((Double.parseDouble(cdw1)+(Double.parseDouble(cdw1)*vatval)), 0);
		double pai1tax=objcommon.sqlRound((Double.parseDouble(pai1)+(Double.parseDouble(pai1)*vatval)), 0);
		double gpstax=objcommon.sqlRound((Double.parseDouble(gps)+(Double.parseDouble(gps)*vatval)), 0);
		double babyseatertax=objcommon.sqlRound((Double.parseDouble(babyseater)+(Double.parseDouble(babyseater)*vatval)), 0);
		double coolertax=objcommon.sqlRound((Double.parseDouble(cooler)+(Double.parseDouble(cooler)*vatval)), 0);
		double chauffertax=objcommon.sqlRound((Double.parseDouble(chaufferchg)+(Double.parseDouble(chaufferchg)*vatval)), 0);
		double apctax=objcommon.sqlRound((Double.parseDouble(apc)+(Double.parseDouble(apc)*vatval)), 0);
		double mastertotal=renttax+cdwtax+paitax+cdw1tax+pai1tax+gpstax+babyseatertax+coolertax+chauffertax+apctax;
		System.out.println(renttax+"//"+cdwtax+"//"+paitax+"//"+cdw1tax+"//"+pai1tax+"//"+gpstax+"//"+babyseatertax+"//"+cooler+"//"+chauffertax+"//"+mastertotal);
		
		taxtotal=mastertotal*Double.parseDouble(monthno);
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