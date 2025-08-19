package com.dashboard.invoices.leasequarterly;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.invoices.lease.ClsLeaseInvoiceBean;
import com.dashboard.invoices.lease.ClsLeaseInvoiceDAO;
import com.operations.commtransactions.invoice.ClsManualInvoiceDAO;

public class ClsLeaseQuarterlyInvoiceAction {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	private int gridlength;
	private String mode;
	private String hidclient;
	private String msg;
	private String detail;
	private String detailname;
	private String reqhidden;
	
	
	public String getReqhidden() {
		return reqhidden;
	}
	public void setReqhidden(String reqhidden) {
		this.reqhidden = reqhidden;
	}
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getHidclient() {
		return hidclient;
	}
	public void setHidclient(String hidclient) {
		this.hidclient = hidclient;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
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
	
	
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		ArrayList<String> invoicedoc= new ArrayList<>();
		
		String mode=getMode();
		ClsLeaseInvoiceBean bean=new ClsLeaseInvoiceBean();
	Connection conn = objconn.getMyConnection();
	try{

	Statement stmt=conn.createStatement();
	ClsLeaseInvoiceDAO leaseinvDAO=new ClsLeaseInvoiceDAO();

				/**/
	String sqlacno="select (select acno from gl_invmode where idno=1) rental,(select acno from gl_invmode where idno=2) acc,"+
			"(select acno from gl_invmode where idno=8) salik,(select acno from gl_invmode where idno=9) traffic,"+
			"(select acno from gl_invmode where idno=14) saliksrvc,(select acno from gl_invmode where idno=15) trafficsrvc,"+
			"(select acno from gl_invmode where idno=17) insur,(select acno from gl_invmode where idno=18) otherincome,"+
			"(select acno from gl_invmode where idno=3) chauffer";
	ResultSet rsacno=stmt.executeQuery(sqlacno);
	int rentalacno=0,accacno=0,salikacno=0,trafficacno=0,saliksrvcacno=0,trafficsrvcacno=0,insuracno=0,otherincomeacno=0,chaufferacno=0;
	while(rsacno.next()){
		rentalacno=rsacno.getInt("rental");
		accacno=rsacno.getInt("acc");
		salikacno=rsacno.getInt("salik");
		trafficacno=rsacno.getInt("traffic");
		saliksrvcacno=rsacno.getInt("saliksrvc");
		trafficsrvcacno=rsacno.getInt("trafficsrvc");
		insuracno=rsacno.getInt("insur");
		otherincomeacno=rsacno.getInt("otherincome");
		chaufferacno=rsacno.getInt("chauffer");
	}
	//stmt.close();

		if(mode.equalsIgnoreCase("A")){
			//System.out.println("Inside Action Mode A");
			ArrayList<String> invoicearray= new ArrayList<>();
			ArrayList<String> newarray= new ArrayList<>();
			ArrayList<String> salikarray= new ArrayList<>();
			ArrayList<String> trafficarray= new ArrayList<>();
			//System.out.println("inside tarifsave");
			String[] invoice = null;
			java.sql.Date fromdate=null,todate=null;
			
			/*for(int i=0;i<getInvgridlength();i++){
				//ClsTarifBean tarifbean=new ClsTarifBean();
				//System.out.println("request =========="+requestParams.get("testinvoice"+i)[0]);
				String temp=requestParams.get("testinvoice"+i)[0];
				String temp=getReqhidden()
				invoicearray.add(temp);
				
				//System.out.println("Check 1st Loop");
			}*/
			
			String dataarray[]=getReqhidden().split(",");
			for(int i=0;i<dataarray.length;i++){
				invoicearray.add(dataarray[i]);
			}
				for(int j=0;j <getGridlength();j++){
					conn.setAutoCommit(false);
					newarray=new ArrayList<>();
					 salikarray=new ArrayList<>();
					 trafficarray=new ArrayList<>();
					//System.out.println("INVLENGTH"+getInvgridlength());
					invoice=invoicearray.get(j).split("::");
					fromdate=objcommon.changetstmptoSqlDate(invoice[2]);
					todate=objcommon.changetstmptoSqlDate(invoice[3]);
					int agmtno=Integer.parseInt(invoice[0]);
					ArrayList<String> firstinvarray=leaseinvDAO.checkFirstInvoice(agmtno,1);
					double firstinvamount=Double.parseDouble(firstinvarray.get(0));	//Amount from OtherIncome Related
					String qty=objcommon.getMonthandDays(todate, fromdate, conn);
					String salikcount=invoice[18].toString();
					String trafficcount=invoice[19].toString();
					String salamount=invoice[20].toString();
					String salrate=invoice[21].toString();
					String note=objcommon.changeSqltoString(fromdate) +" to "+objcommon.changeSqltoString(todate) +" for Lease Aggrement no "+agmtno;
					//System.out.println("Salik: "+getHidchksalik());
					//System.out.println("Ex Salik: "+getHidchkexsalik());
					//System.out.println("Traffic: "+getHidchktraffic());
					//System.out.println("Ex Traffic: "+getHidchkextraffic());
					/*leaseinvoiceDAO.getChauffercharge(agmtno,fromdate,todate);*/
					ClsManualInvoiceDAO manualdao=new ClsManualInvoiceDAO();   
					double chaufchg=manualdao.getChaufferCharge(agmtno, fromdate, todate, "LAG");
					
					if(chaufchg>0){
						newarray.add("3"+"::"+chaufferacno+"::"+note+"::"+qty+"::"+chaufchg+"::"+chaufchg);
					}
						if(Double.parseDouble(invoice[8])>0){
							newarray.add("1"+"::"+rentalacno+"::"+note+"::"+qty+"::"+invoice[8]+"::"+invoice[8]);
						}
						if(Double.parseDouble(invoice[9])>0){
							newarray.add("2"+"::"+accacno+"::"+note+"::"+qty+"::"+invoice[9]+"::"+invoice[9]);	
						}
						
							if(Double.parseDouble(invoice[10])>0){
								newarray.add("8"+"::"+salikacno+"::"+note+"::"+salikcount+"::"+salamount+"::"+invoice[10]);	
							}
							
							if(Double.parseDouble(invoice[12])>0){
								newarray.add("14"+"::"+saliksrvcacno+"::"+note+"::"+salikcount+"::"+salrate+"::"+invoice[12]);	
							}
						
						
							if(Double.parseDouble(invoice[11])>0){
								newarray.add("9"+"::"+trafficacno+"::"+note+"::"+trafficcount+"::"+invoice[11]+"::"+invoice[11]);	
							}
							if(Double.parseDouble(invoice[13])>0){
								newarray.add("15"+"::"+trafficsrvcacno+"::"+note+"::"+trafficcount+"::"+invoice[13]+"::"+invoice[13]);	
							}
						
						if(Double.parseDouble(invoice[17])>0){
							newarray.add("17"+"::"+insuracno+"::"+note+"::"+qty+"::"+invoice[17]+"::"+invoice[17]);	
						}
						if(firstinvamount>0){
							newarray.add("18"+"::"+otherincomeacno+"::"+note+"::"+qty+"::"+firstinvamount+"::"+firstinvamount);
						}
					
					
					
					
					
				
				//System.out.println("Check 2nd Loop");
				
		 Date date1=new Date();
			String pattern = "dd.MM.yyyy";
			SimpleDateFormat formatter = new SimpleDateFormat(pattern);
			String date2 = formatter.format(date1);
			java.sql.Date dates=objcommon.changeStringtoSqlDate(date2);
			//System.out.println(dates);
			
			//System.out.println("Check"+dates+":"+invoice[0]+":"+getHidclient()+":"+fromdate+":"+todate+":");
			//System.out.println("array======= "+newarray);
			
			String branchid=invoice[15];
			String currencyid=invoice[16];
			String userid=session.getAttribute("USERID").toString();
			String cldocno=invoice[7];
			String qty2=objcommon.getMonthandDays(todate, fromdate, conn);
			ClsLeaseInvoiceDAO leaseInvoiceDAO=new ClsLeaseInvoiceDAO();
			int advchk=leaseInvoiceDAO.getAdvance(agmtno,conn);
			java.sql.Date sqldate=null;
			if(advchk==1){
				sqldate=fromdate;
			}
			else{
				sqldate=todate;
			}
		
			int val=manualdao.insert(conn,newarray, "LAG", sqldate,cldocno,agmtno,note,note, fromdate, todate, branchid,userid,
					currencyid, mode,invoice[4] , "INV###4", "INV",qty2);
						 if(val>0){
										 if(salikarray.size()>0){
											int valsalik=manualdao.insert(conn,salikarray, "LAG", sqldate,cldocno,agmtno,note,note, fromdate, todate, branchid,userid,
													currencyid, mode,invoice[4] , "INV###4", "INV",qty2);
											if(valsalik<=0){
												conn.close();
												return "fail";
											}
										}
										if(trafficarray.size()>0){
											int valtraffic=manualdao.insert(conn,trafficarray, "LAG", sqldate,cldocno,agmtno,note,note, fromdate, todate, branchid,userid,
													currencyid, mode,invoice[4] , "INV###4", "INV",qty2);
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
							setDetailname("Quarterly");
							 setMsg("Successfully Saved");
							
		}
						 else{
							 setDetail("Invoices");
								setDetailname("Quarterly");
							 setMsg("Not Saved");
							 conn.close();
							 return "fail";
						 }
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
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
		return "success";
	}
}
