package com.dashboard.invoices.rental;


import java.sql.Connection;
/*import java.sql.Date;*/
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Map;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.common.ClsRentalInvoiceCalc;
import com.connection.ClsConnection;
import com.operations.commtransactions.invoice.ClsManualInvoiceBean;
import com.operations.commtransactions.invoice.ClsManualInvoiceDAO;

public class ClsRentalInvoiceAction {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
ClsRentalInvoiceDAO rentalinvoiceDAO=new ClsRentalInvoiceDAO();
private int invgridlength;
private String mode;
private String hidclient;
private String msg;
private String detail;
private String detailname;
private String chksalik;
private String chktraffic;
private String hidchksalik;
private String hidchktraffic;
private String chkexsalik;
private String chkextraffic;
private String hidchkexsalik;
private String hidchkextraffic;
private String hidchkall;
private String chkall;


public String getChkexsalik() {
	return chkexsalik;
}
public void setChkexsalik(String chkexsalik) {
	this.chkexsalik = chkexsalik;
}
public String getChkextraffic() {
	return chkextraffic;
}
public void setChkextraffic(String chkextraffic) {
	this.chkextraffic = chkextraffic;
}
public String getHidchkexsalik() {
	return hidchkexsalik;
}
public void setHidchkexsalik(String hidchkexsalik) {
	this.hidchkexsalik = hidchkexsalik;
}
public String getHidchkextraffic() {
	return hidchkextraffic;
}
public void setHidchkextraffic(String hidchkextraffic) {
	this.hidchkextraffic = hidchkextraffic;
}
public String getHidchkall() {
	return hidchkall;
}
public void setHidchkall(String hidchkall) {
	this.hidchkall = hidchkall;
}
public String getChkall() {
	return chkall;
}
public void setChkall(String chkall) {
	this.chkall = chkall;
}
public String getChksalik() {
	return chksalik;
}
public void setChksalik(String chksalik) {
	this.chksalik = chksalik;
}
public String getChktraffic() {
	return chktraffic;
}
public void setChktraffic(String chktraffic) {
	this.chktraffic = chktraffic;
}
public String getHidchksalik() {
	return hidchksalik;
}
public void setHidchksalik(String hidchksalik) {
	this.hidchksalik = hidchksalik;
}
public String getHidchktraffic() {
	return hidchktraffic;
}
public void setHidchktraffic(String hidchktraffic) {
	this.hidchktraffic = hidchktraffic;
}
public String getDetail() {
	return detail;
}
public void setDetail(String detail) {
	this.detail = detail;
}
public String getDetailname() {
	return detailname;
}
public void setDetailname(String detailname) {
	this.detailname = detailname;
}
public String getMsg() {
	return msg;
}
public void setMsg(String msg) {
	this.msg = msg;
}
public String getHidclient() {
	return hidclient;
}
public void setHidclient(String hidclient) {
	this.hidclient = hidclient;
}
public int getInvgridlength() {
	return invgridlength;
}
public void setInvgridlength(int invgridlength) {
	this.invgridlength = invgridlength;
}
public String getMode() {
	return mode;
}
public void setMode(String mode) {
	this.mode = mode;
}
public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	ArrayList<String> invoicedoc= new ArrayList<>();
//	System.out.println(session.getAttribute("BRANCHID"));
	Map<String, String[]> requestParams = request.getParameterMap();
//	System.out.println("chk=========== "+requestParams);
	session.getAttribute("BranchName");
	Connection conn =null;
	try{
		conn=ClsConnection.getMyConnection();
		String mode=getMode();
		Statement stmt=conn.createStatement();
		String sqlacno="select (select acno from gl_invmode where idno=1) rental,(select acno from gl_invmode where idno=2) acc,"+
		"(select acno from gl_invmode where idno=8) salik,(select acno from gl_invmode where idno=9) traffic,"+
		"(select acno from gl_invmode where idno=38) salikauhacno,(select acno from gl_invmode where idno=39) salikauhsrvcacno,"+
		"(select acno from gl_invmode where idno=14) saliksrvc,(select acno from gl_invmode where idno=15) trafficsrvc,"+
		"(select acno from gl_invmode where idno=17) insur,"+
		"(select acno from gl_invmode where idno=3) chauffer";
		ResultSet rsacno=stmt.executeQuery(sqlacno);
		int rentalacno=0,accacno=0,salikacno=0,trafficacno=0,saliksrvcacno=0,trafficsrvcacno=0,insuracno=0,deliveryacno=0,chaufferacno=0;
		int salikauhacno=0,salikauhsrvcacno=0;
		while(rsacno.next()){
			rentalacno=rsacno.getInt("rental");
			accacno=rsacno.getInt("acc");
			salikacno=rsacno.getInt("salik");
			trafficacno=rsacno.getInt("traffic");
			saliksrvcacno=rsacno.getInt("saliksrvc");
			trafficsrvcacno=rsacno.getInt("trafficsrvc");
			insuracno=rsacno.getInt("insur");
			chaufferacno=rsacno.getInt("chauffer");
			salikauhacno=rsacno.getInt("salikauhacno");
			salikauhsrvcacno=rsacno.getInt("salikauhsrvcacno");
		}

		if(mode.equalsIgnoreCase("A")){
	//		System.out.println("Inside Action Mode A");
			ArrayList<String> invoicearray= new ArrayList<>();
			ArrayList<String> newarray= new ArrayList<>();
			ArrayList<String> salikarray= new ArrayList<>();
			ArrayList<String> trafficarray= new ArrayList<>();
	//		System.out.println("inside tarifsave");
			String[] invoice = null;
			java.sql.Date fromdate=null,todate=null;
			for(int i=0;i<getInvgridlength();i++){
				String temp=requestParams.get("testinvoice"+i)[0];
				invoicearray.add(temp);
			}
			for(int j=0;j <getInvgridlength();j++){
				conn.setAutoCommit(false);
				newarray=new ArrayList<>();
				salikarray=new ArrayList<>();
				trafficarray=new ArrayList<>();
				invoice=invoicearray.get(j).split("::");
				fromdate=ClsCommon.changetstmptoSqlDate(invoice[2]);
				todate=ClsCommon.changetstmptoSqlDate(invoice[3]);
				int agmtno=Integer.parseInt(invoice[0]);
				ClsManualInvoiceDAO manualdao=new ClsManualInvoiceDAO();
				int oneDayExtraConfig=manualdao.getOneDayExtraConfig(conn);
				int invtype=0;
				int invcount=0;
				String agmttype="RAG";
				String strgetinvtype="";
				java.sql.Date tempfromdate=null;
				if(agmttype.equalsIgnoreCase("RAG")){
					strgetinvtype="select (select invtype from gl_ragmt where doc_no="+agmtno+") invtype,(select count(*) from gl_invm where rano="+agmtno+" and ratype='RAG') invcount";
					
				}
				else{
					strgetinvtype="select (select inv_type from gl_lagmt where doc_no="+agmtno+") invtype,(select count(*) from gl_invm where rano="+agmtno+" and ratype='LAG') invcount";
				}
				
				ResultSet rsgetinvtype=stmt.executeQuery(strgetinvtype);
				while(rsgetinvtype.next()){
					invtype=rsgetinvtype.getInt("invtype");
					invcount=rsgetinvtype.getInt("invcount");
				}
				if(invtype==1 && oneDayExtraConfig==1 && invcount==0){
					String straddonedate="select date_sub('"+fromdate+"',interval 1 day) invdate";
					ResultSet rsaddonedate=stmt.executeQuery(straddonedate);
					while(rsaddonedate.next()){
						tempfromdate=rsaddonedate.getDate("invdate");
					}
				}
				else{
					tempfromdate=fromdate;
				}
				
				String qty=ClsCommon.getMonthandDays(todate, tempfromdate, conn);
				String salikcount=invoice[18].toString();
				String trafficcount=invoice[19].toString();
				String salamount=invoice[20].toString();
				String salrate=invoice[21].toString();
				String note=ClsCommon.changeSqltoString(fromdate) +" to "+ClsCommon.changeSqltoString(todate) +" for Rental Aggrement no "+agmtno;
				
				//System.out.println("Salik: "+getHidchksalik());
				//System.out.println("Ex Salik: "+getHidchkexsalik());
				//System.out.println("Traffic: "+getHidchktraffic());
				//System.out.println("Ex Traffic: "+getHidchkextraffic());
				double chaufchg=manualdao.getChaufferCharge(agmtno, fromdate, todate, "RAG");
				
				//System.out.println("Chauffer Charge: "+chaufchg);
				
				double salikauhamt=Double.parseDouble(invoice[22]);
				double salikdxbamt=Double.parseDouble(invoice[23]);
				double salikauhsrvc=Double.parseDouble(invoice[24]);
				double salikdxbsrvc=Double.parseDouble(invoice[25]);
				int salikauhcount=Integer.parseInt(invoice[26]);
				int salikdxbcount=Integer.parseInt(invoice[27]);
				double salikauhrate=Double.parseDouble(invoice[28]);
				double salikdxbrate=Double.parseDouble(invoice[29]);
				double salikauhsrvcrate=Double.parseDouble(invoice[30]);
				double salikdxbsrvcrate=Double.parseDouble(invoice[31]);
										
				
				if(chaufchg>0){
					newarray.add("3"+"::"+chaufferacno+"::"+note+"::"+qty+"::"+chaufchg+"::"+chaufchg);
				}
				if(Double.parseDouble(invoice[8])>0){
					newarray.add("1"+"::"+rentalacno+"::"+note+"::"+qty+"::"+invoice[8]+"::"+invoice[8]);
				}
				if(Double.parseDouble(invoice[9])>0){
					newarray.add("2"+"::"+accacno+"::"+note+"::"+qty+"::"+invoice[9]+"::"+invoice[9]);	
				}
				//System.out.println("Ex Salik: "+getHidchkexsalik());
				//System.out.println("Salik: "+getHidchksalik());
				if(getHidchkexsalik().equalsIgnoreCase("0") && getHidchksalik().equalsIgnoreCase("0")){
					/*if(Double.parseDouble(invoice[10])>0){
						newarray.add("8"+"::"+salikacno+"::"+note+"::"+salikcount+"::"+salamount+"::"+invoice[10]);	
					}
					if(Double.parseDouble(invoice[12])>0){
						newarray.add("14"+"::"+saliksrvcacno+"::"+note+"::"+salikcount+"::"+salrate+"::"+invoice[12]);	
					}*/
					if(salikauhamt>0.0){
						newarray.add(38+"::"+salikauhacno+"::"+note+"::"+salikauhcount+"::"+salikauhrate+"::"+salikauhamt);
						newarray.add(39+"::"+salikauhsrvcacno+"::"+note+"::"+salikauhcount+"::"+salikauhsrvcrate+"::"+salikauhsrvc);
					}
					if(salikdxbamt>0.0){
						newarray.add(8+"::"+salikacno+"::"+note+"::"+salikdxbcount+"::"+salikdxbrate+"::"+salikdxbamt);
						newarray.add(14+"::"+saliksrvcacno+"::"+note+"::"+salikdxbcount+"::"+salikdxbsrvcrate+"::"+salikdxbsrvc);
					}
				}
					
				if(getHidchkextraffic().equalsIgnoreCase("0") && getHidchktraffic().equalsIgnoreCase("0")){
					if(Double.parseDouble(invoice[11])>0){
						newarray.add("9"+"::"+trafficacno+"::"+note+"::"+trafficcount+"::"+invoice[11]+"::"+invoice[11]);	
					}
					if(Double.parseDouble(invoice[13])>0){
						newarray.add("15"+"::"+trafficsrvcacno+"::"+note+"::"+trafficcount+"::"+invoice[13]+"::"+invoice[13]);	
					}
				}

				if(Double.parseDouble(invoice[17])>0){
					newarray.add("17"+"::"+insuracno+"::"+note+"::"+qty+"::"+invoice[17]+"::"+invoice[17]);	
				}
				
				if(getHidchksalik().equalsIgnoreCase("1")){
					/*if(Double.parseDouble(invoice[10])>0){
						salikarray.add("8"+"::"+salikacno+"::"+note+"::"+salikcount+"::"+salamount+"::"+invoice[10]);	
					}
					if(Double.parseDouble(invoice[12])>0){
						salikarray.add("14"+"::"+saliksrvcacno+"::"+note+"::"+salikcount+"::"+salrate+"::"+invoice[12]);	
					}*/
					
					if(salikauhamt>0.0){
						salikarray.add(38+"::"+salikauhacno+"::"+note+"::"+salikauhcount+"::"+salikauhrate+"::"+salikauhamt);
						salikarray.add(39+"::"+salikauhsrvcacno+"::"+note+"::"+salikauhcount+"::"+salikauhsrvcrate+"::"+salikauhsrvc);
					}
					if(salikdxbamt>0.0){
						salikarray.add(8+"::"+salikacno+"::"+note+"::"+salikdxbcount+"::"+salikdxbrate+"::"+salikdxbamt);
						salikarray.add(14+"::"+saliksrvcacno+"::"+note+"::"+salikdxbcount+"::"+salikdxbsrvcrate+"::"+salikdxbsrvc);
					}
				}
				
				if(getHidchktraffic().equalsIgnoreCase("1")){
					if(Double.parseDouble(invoice[11])>0){
						trafficarray.add("9"+"::"+trafficacno+"::"+note+"::"+trafficcount+"::"+invoice[11]+"::"+invoice[11]);	
					}
					if(Double.parseDouble(invoice[13])>0){
						trafficarray.add("15"+"::"+trafficsrvcacno+"::"+note+"::"+trafficcount+"::"+invoice[13]+"::"+invoice[13]);	
					}
				}
				
				Date date1=new Date();
				String pattern = "dd.MM.yyyy";
				SimpleDateFormat formatter = new SimpleDateFormat(pattern);
				String date2 = formatter.format(date1);
				java.sql.Date dates=ClsCommon.changeStringtoSqlDate(date2);
				//System.out.println(dates);
				//System.out.println("Check"+dates+":"+invoice[0]+":"+getHidclient()+":"+fromdate+":"+todate+":");
				System.out.println("array======= "+newarray);
				for(int t=0;t<newarray.size();t++){
					System.out.println(newarray.get(t));
				}
				String branchid=invoice[15];
				String currencyid=invoice[16];
				String userid=session.getAttribute("USERID").toString();
				String cldocno=invoice[7];
				String qty2=ClsCommon.getMonthandDays(todate, tempfromdate, conn);
				int advchk=rentalinvoiceDAO.getAdvance(agmtno,conn);
				java.sql.Date sqldate=null;
				if(advchk==1){
					sqldate=fromdate;
				}
				else{
					sqldate=todate;
				}
				int duplicatecount=manualdao.getDuplicateInvCount(conn, agmttype, agmtno+"", fromdate, todate, "2");
				int val=0;
				if(duplicatecount==0){
					val=manualdao.insert(conn,newarray, "RAG", sqldate,cldocno,agmtno,note,note, fromdate, todate, branchid,userid,
					currencyid, mode,invoice[4] , "INV###2", "INV",qty2);
				}
				if(val>0){
					if(salikarray.size()>0){
						duplicatecount=manualdao.getDuplicateInvCount(conn, agmttype, agmtno+"", fromdate, todate, "2");
						int valsalik=0;
						if(duplicatecount<=1){
							valsalik=manualdao.insert(conn,salikarray, "RAG", sqldate,cldocno,agmtno,note,note, fromdate, todate, branchid,userid,
							currencyid, mode,invoice[4] , "INV###2", "INV",qty2);
						}
						if(valsalik<=0){
							conn.close();
							return "fail";
						}
					}
					
					if(trafficarray.size()>0){
						duplicatecount=manualdao.getDuplicateInvCount(conn, agmttype, agmtno+"", fromdate, todate, "2");
						int valtraffic=0;
						if(duplicatecount<=1){
							valtraffic=manualdao.insert(conn,trafficarray, "RAG", sqldate,cldocno,agmtno,note,note, fromdate, todate, branchid,userid,
							currencyid, mode,invoice[4] , "INV###2", "INV",qty2);
						}
						if(valtraffic<=0){
							conn.close();
							return "fail";
						}
					}
					ResultSet rsinvdoc=stmt.executeQuery("select voc_no from gl_invm where doc_no="+val+"");
					if(rsinvdoc.next()){
						invoicedoc.add(rsinvdoc.getString("voc_no"));
					}
					conn.commit();
					setDetail("Invoices");
					setDetailname("Rental");
					setMsg("Successfully Saved");
				}
				else{
					setDetail("Invoices");
					setDetailname("Rental");
					setMsg("Not Saved");
					conn.close();
					return "fail";
				}
			}
			if(invoicedoc.size()==1){
				setMsg("Inv No "+invoicedoc.get(0)+" Successfully Generated");
			}
			else if(invoicedoc.size()>1){
				setMsg("Inv From "+invoicedoc.get(0)+" To "+invoicedoc.get(invoicedoc.size()-1)+" Successfully Generated");
			}
			conn.close();
			return "success";
		}
	}
	catch(Exception e1){
		e1.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
	conn.close();
	return "fail";
}
}


