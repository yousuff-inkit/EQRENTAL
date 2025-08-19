<%@page import="com.operations.commtransactions.proformainvoice.ClsProformaInvoiceDAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.dashboard.invoices.proforma.ClsProformaInvDAO"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.*"%>
<%
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
ClsProformaInvDAO objproforma=new ClsProformaInvDAO();
ClsProformaInvoiceDAO objinvoice=new ClsProformaInvoiceDAO();
String stragmtarray=request.getParameter("agmtarray")==null?"":request.getParameter("agmtarray");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String uptodate=request.getParameter("uptodate")==null?"":request.getParameter("uptodate");
//System.out.println("Passed Values:"+request.getParameterValues("agmtarray"));
JSONObject objdata=new JSONObject();
Connection conn=null;
int errorstatus=0;
ArrayList<String> docarray=new ArrayList();
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	ArrayList<String> agmtarray=new ArrayList();
	for(int i=0;i<stragmtarray.split(",").length;i++){
		agmtarray.add(stragmtarray.split(",")[i]);
	}
	
	String sqlacno="select (select acno from gl_invmode where idno=1) rental,"+
	"(select acno from gl_invmode where idno=2) acc,"+
	"(select acno from gl_invmode where idno=8) salik,(select acno from gl_invmode where idno=9) traffic,"+
	"(select acno from gl_invmode where idno=14) saliksrvc,(select acno from gl_invmode where idno=15) trafficsrvc,"+
	"(select acno from gl_invmode where idno=17) insur,"+
	"(select acno from gl_invmode where idno=3) chauffer";
	ResultSet rsacno=stmt.executeQuery(sqlacno);
	int rentalacno=0,accacno=0,salikacno=0,trafficacno=0,saliksrvcacno=0,trafficsrvcacno=0,insuracno=0,deliveryacno=0,chaufferacno=0;
	while(rsacno.next()){
		rentalacno=rsacno.getInt("rental");
		accacno=rsacno.getInt("acc");
		salikacno=rsacno.getInt("salik");
		trafficacno=rsacno.getInt("traffic");
		saliksrvcacno=rsacno.getInt("saliksrvc");
		trafficsrvcacno=rsacno.getInt("trafficsrvc");
		insuracno=rsacno.getInt("insur");
		chaufferacno=rsacno.getInt("chauffer");
	}
	String userid=session.getAttribute("USERID").toString();
	String currencyid=session.getAttribute("CURRENCYID").toString();
	for(int i=0;i<agmtarray.size();i++){
		System.out.println("Array Recieved: "+agmtarray.get(i));
		ArrayList<String> invoicearray=new ArrayList();
		String temp[]=agmtarray.get(i).split("::");
		
		/* agmtno+"::"+totalamt+"::"+rentalamt+"::"+accamt+"::"+insuramt+"::"+salikamt+"::"+saliksrvc+"::"+salikcount+"::"+trafficamt+"::"+
		trafficsrvc+"::"+trafficcount+"::"+fromdate+"::"+todate+"::"+agmtvocno); */
		java.sql.Date sqluptodate=null;
		if(!uptodate.equalsIgnoreCase("")){
			sqluptodate=objcommon.changeStringtoSqlDate(uptodate);
		}
		java.sql.Date sqlbasedate=null,sqlinvdate=null;
		
		String strgetagmtdata="select ac.acno clientacno,date_format(agmt.invdate,'%d.%m.%Y') strinvdate,agmt.invdate,agmt.voc_no,agmt.cldocno,CURDATE() basedate,"+
		" agmt.brhid from gl_ragmt agmt left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') where agmt.doc_no="+temp[0];
		ResultSet rsgetagmtdata=stmt.executeQuery(strgetagmtdata);
		String invdate="",agmtvocno="";
		int cldocno=0,brhid=0,clientacno=0;
		
		while(rsgetagmtdata.next()){
			sqlinvdate=rsgetagmtdata.getDate("invdate");
			invdate=rsgetagmtdata.getString("strinvdate");
			agmtvocno=rsgetagmtdata.getString("voc_no");
			sqlbasedate=rsgetagmtdata.getDate("basedate");
			cldocno=rsgetagmtdata.getInt("cldocno");
			brhid=rsgetagmtdata.getInt("brhid");
			clientacno=rsgetagmtdata.getInt("clientacno");
		}
		
		String note=invdate+" to "+uptodate+" for Rental Agreement no "+agmtvocno;
		if(Double.parseDouble(temp[2])>0.0){
			//Rental charges
			invoicearray.add("1"+"::"+rentalacno+"::"+note+"::"+temp[11]+"::"+temp[2]+"::"+temp[2]);
		}
		if(Double.parseDouble(temp[3])>0.0){
			invoicearray.add("2"+"::"+accacno+"::"+note+"::"+temp[11]+"::"+temp[3]+"::"+temp[3]);
		}
		if(Double.parseDouble(temp[4])>0.0){
			invoicearray.add("17"+"::"+insuracno+"::"+note+"::"+temp[11]+"::"+temp[4]+"::"+temp[4]);
		}
		if(Double.parseDouble(temp[5])>0.0){
			invoicearray.add("8"+"::"+salikacno+"::"+note+"::"+temp[7]+"::"+temp[5]+"::"+temp[5]);
		}
		if(Double.parseDouble(temp[6])>0.0){
			invoicearray.add("14"+"::"+saliksrvcacno+"::"+note+"::"+temp[7]+"::"+temp[6]+"::"+temp[6]);
		}
		if(Double.parseDouble(temp[8])>0.0){
			invoicearray.add("9"+"::"+trafficacno+"::"+note+"::"+temp[10]+"::"+temp[8]+"::"+temp[8]);
		}
		if(Double.parseDouble(temp[9])>0.0){
			invoicearray.add("15"+"::"+trafficsrvcacno+"::"+note+"::"+temp[10]+"::"+temp[9]+"::"+temp[9]);
		}
		int value=objinvoice.insert(conn, invoicearray, "RAG", sqlbasedate, cldocno+"", Integer.parseInt(temp[0]), note, note, sqlinvdate, sqluptodate, 
		brhid+"", userid, currencyid, "A", clientacno+"", "PRIV", "PRIV", "");
		if(value<=0){
			errorstatus=1;
		}
		
		String strgetvoc="select voc_no from gl_proinvm where doc_no="+value;
		ResultSet rsgetvoc=stmt.executeQuery(strgetvoc);
		while(rsgetvoc.next()){
			docarray.add(rsgetvoc.getString("voc_no"));
		}
	}
	if(errorstatus==0){
		conn.commit();
	}	
	objdata.put("errorstatus",errorstatus);
	String errormsg="";
	if(docarray.size()==1){
		errormsg="Successfully created Proforma Inv #"+docarray.get(0);
	}
	else if(docarray.size()>1){
		errormsg="Successfully created Proforma Inv #"+docarray.get(0)+" to #"+docarray.get(docarray.size()-1);
	}
	else{
		errormsg="Not Saved";
	}
	objdata.put("errormsg",errormsg);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>