package com.dashboard.trafficfine.trafficfineclosedagmt;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

public class ClsTrafficfineSaperateClosedAgmtAction extends ActionSupport{
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

    
	ClsTrafficfineSaperateClosedAgmtDAO trafficDAO= new ClsTrafficfineSaperateClosedAgmtDAO();
	ClsTrafficfineClosedAgmtBean trafficBean;
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblprintname;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String msg;
	private String mode;
	private String cmbbranch;
	private String fromdate;
	private String todate;
	private String txtcldocno;
	private String rentaltype;
	private String txtagreementno;
	private String detail;
	private String detailname;
	private String ticketno;
	private String hidchksaperate;
	
	
	public String getHidchksaperate() {
		return hidchksaperate;
	}

	public void setHidchksaperate(String hidchksaperate) {
		this.hidchksaperate = hidchksaperate;
	}

	public String getTicketno() {
		return ticketno;
	}

	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
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

	public String getCmbbranch() {
		return cmbbranch;
	}

	public void setCmbbranch(String cmbbranch) {
		this.cmbbranch = cmbbranch;
	}

	public String getFromdate() {
		return fromdate;
	}

	public void setFromdate(String fromdate) {
		this.fromdate = fromdate;
	}

	public String getTodate() {
		return todate;
	}

	public void setTodate(String todate) {
		this.todate = todate;
	}

	public String getTxtcldocno() {
		return txtcldocno;
	}

	public void setTxtcldocno(String txtcldocno) {
		this.txtcldocno = txtcldocno;
	}

	public String getRentaltype() {
		return rentaltype;
	}

	public void setRentaltype(String rentaltype) {
		this.rentaltype = rentaltype;
	}

	public String getTxtagreementno() {
		return txtagreementno;
	}

	public void setTxtagreementno(String txtagreementno) {
		this.txtagreementno = txtagreementno;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getLblcompname() {
		return lblcompname;
	}

	public void setLblcompname(String lblcompname) {
		this.lblcompname = lblcompname;
	}

	public String getLblcompaddress() {
		return lblcompaddress;
	}

	public void setLblcompaddress(String lblcompaddress) {
		this.lblcompaddress = lblcompaddress;
	}

	public String getLblprintname() {
		return lblprintname;
	}

	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}

	public String getLblcomptel() {
		return lblcomptel;
	}

	public void setLblcomptel(String lblcomptel) {
		this.lblcomptel = lblcomptel;
	}

	public String getLblcompfax() {
		return lblcompfax;
	}

	public void setLblcompfax(String lblcompfax) {
		this.lblcompfax = lblcompfax;
	}

	public String getLblbranch() {
		return lblbranch;
	}

	public void setLblbranch(String lblbranch) {
		this.lblbranch = lblbranch;
	}

	public String getLbllocation() {
		return lbllocation;
	}

	public void setLbllocation(String lbllocation) {
		this.lbllocation = lbllocation;
	}

	public String saveAction() throws ParseException, SQLException{

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
//		System.out.println(session.getAttribute("BRANCHID"));
		Map<String, String[]> requestParams = request.getParameterMap();
//		System.out.println("chk=========== "+requestParams);
		ClsTrafficfineSaperateClosedAgmtDAO trafficdao=new ClsTrafficfineSaperateClosedAgmtDAO();
		if(mode.equalsIgnoreCase("A")){
			java.sql.Date sqlfromdate=null;
			if(getFromdate()!=null){
				sqlfromdate=ClsCommon.changeStringtoSqlDate(getFromdate());
			}
			java.sql.Date sqltodate=null;
			if(getTodate()!=null){
				sqltodate=ClsCommon.changeStringtoSqlDate(getTodate());
			}
			System.out.println("Check"+getCmbbranch()+"//"+sqlfromdate+"//"+sqltodate+"//"+getTxtcldocno()+"//"+getRentaltype()+"//"+getTxtagreementno()+"//"+getTicketno()+"//"+getHidchksaperate());
			ArrayList<String> invoicearray=trafficdao.getTrafficDetails(getCmbbranch(),sqlfromdate,sqltodate,getTxtcldocno(),getRentaltype(),getTxtagreementno(),session,getTicketno(),getHidchksaperate());
			System.out.println("===== "+invoicearray);
			if(invoicearray.size()>0){
				setDetail("Traffic Fine");
				setDetailname("Not Invoiced Traffic");
				setFromdate(sqlfromdate.toString());
				setTodate(sqltodate.toString());
				if(invoicearray.size()==1){
					setMsg("Inv No "+invoicearray.get(0)+" Successfully generated");
				}
				else if(invoicearray.size()>1){
					setMsg("Inv From "+invoicearray.get(0)+" To "+invoicearray.get(invoicearray.size()-1)+" Successfully Generated");
				}
					return "success";
				}
			else{
				setDetail("Traffic Fine");
				setDetailname("Not Invoiced Traffic");
				setFromdate(sqlfromdate.toString());
				setTodate(sqltodate.toString());			
				
				setMsg("Not Invoiced");
					return "fail";
			}
		}
		
	return "fail";	
	}
	
	public String printTobeInvoicedAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		String branch = request.getParameter("branch");
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		String agmtno=request.getParameter("agmtno")==null || request.getParameter("agmtno").trim().equalsIgnoreCase("")?"0":request.getParameter("agmtno").toString();
		String rentaltype=request.getParameter("rentaltype")==null || request.getParameter("rentaltype").trim().equalsIgnoreCase("")?"0":request.getParameter("rentaltype").toString();
		String cldocno=request.getParameter("cldocno")==null || request.getParameter("cldocno").trim().equalsIgnoreCase("")?"0":request.getParameter("cldocno").toString();
		trafficBean=trafficDAO.getPrintToBeInvoiced(request,branch,fromDate,toDate,agmtno,rentaltype,cldocno);
		setLblcompname(trafficBean.getLblcompname());
		setLblcompaddress(trafficBean.getLblcompaddress());
		setLblprintname("Traffic - To be Invoiced");
		setLblcomptel(trafficBean.getLblcomptel());
		setLblcompfax(trafficBean.getLblcompfax());
		setLblbranch(trafficBean.getLblbranch());
		setLbllocation(trafficBean.getLbllocation());
		
		return "print";
	}
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		String branch = request.getParameter("branch");
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		trafficBean=trafficDAO.getPrint(request,branch,fromDate,toDate);
		setLblcompname(trafficBean.getLblcompname());
		setLblcompaddress(trafficBean.getLblcompaddress());
		setLblprintname("Traffic - Invoiced");
		setLblcomptel(trafficBean.getLblcomptel());
		setLblcompfax(trafficBean.getLblcompfax());
		setLblbranch(trafficBean.getLblbranch());
		setLbllocation(trafficBean.getLbllocation());
		
		return "print";
	}
}
