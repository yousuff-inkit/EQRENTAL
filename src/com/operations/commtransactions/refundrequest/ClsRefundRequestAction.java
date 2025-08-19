package com.operations.commtransactions.refundrequest;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.math.BigDecimal;
import java.sql.Connection;
import java.util.Date;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;   
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.common.*;
import com.connection.ClsConnection;
import com.mailwithpdf.EmailProcess;
import com.mailwithpdf.SendEmailAction;
import com.sun.xml.internal.messaging.saaj.packaging.mime.MessagingException;

import javax.mail.internet.AddressException;
import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.operations.agreement.rentalagreement.ClsRentalAgreementDAO;


@SuppressWarnings("serial")
public class ClsRefundRequestAction extends ActionSupport{
	ClsRefundRequestDAO DAO= new ClsRefundRequestDAO();      
	ClsRefundRequestBean pintbean= new ClsRefundRequestBean(); 
	ClsCommon cmn=new ClsCommon();
	ClsConnection connDAO=new ClsConnection();
	private int docno,tourgridlenght,masterdoc_no,ticketgridlenght,hotelgridlenght;    
	public int getTicketgridlenght() {
		return ticketgridlenght;
	}

	public void setTicketgridlenght(int ticketgridlenght) {
		this.ticketgridlenght = ticketgridlenght;
	}

	public int getHotelgridlenght() {
		return hotelgridlenght;
	}

	public void setHotelgridlenght(int hotelgridlenght) {
		this.hotelgridlenght = hotelgridlenght;
	}

	private String brchName,travelDate,hidtravelDate,cmbreftype,refdocno,txtremarks,refno,txtclientname;
	public String getRefno() {  
		return refno;
	}

	public void setRefno(String refno) {
		this.refno = refno;
	}

	public String getTxtclientname() {
		return txtclientname;
	}

	public void setTxtclientname(String txtclientname) {
		this.txtclientname = txtclientname;
	}

	private String msg,mode,formdetailcode,deleted,hidreftype;  
	
	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public int getTourgridlenght() {
		return tourgridlenght;
	}

	public void setTourgridlenght(int tourgridlenght) {
		this.tourgridlenght = tourgridlenght;
	}

	public int getMasterdoc_no() {
		return masterdoc_no;
	}

	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}

	public String getBrchName() {
		return brchName;
	}

	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}

	public String getTravelDate() {
		return travelDate;
	}

	public void setTravelDate(String travelDate) {
		this.travelDate = travelDate;
	}

	public String getHidtravelDate() {
		return hidtravelDate;
	}

	public void setHidtravelDate(String hidtravelDate) {
		this.hidtravelDate = hidtravelDate;
	}

	public String getCmbreftype() {
		return cmbreftype;
	}

	public void setCmbreftype(String cmbreftype) {
		this.cmbreftype = cmbreftype;
	}

	public String getRefdocno() {
		return refdocno;
	}

	public void setRefdocno(String refdocno) {
		this.refdocno = refdocno;
	}

	public String getTxtremarks() {
		return txtremarks;
	}

	public void setTxtremarks(String txtremarks) {
		this.txtremarks = txtremarks;
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

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public String getHidreftype() {
		return hidreftype;
	}

	public void setHidreftype(String hidreftype) {
		this.hidreftype = hidreftype;
	}

	private Map<String, Object> param=null;  
	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	public String saveAction() throws ParseException, SQLException{      
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		java.sql.Date sqlStartDate = cmn.changeStringtoSqlDate(getTravelDate());   
		String mode=getMode();

		if(mode.equalsIgnoreCase("A")){
			ArrayList<String> tourarray= new ArrayList<>();
			ArrayList<String> ticketarray= new ArrayList<>();
			ArrayList<String> hotelarray= new ArrayList<>();
			System.out.println("getTourgridlenght()======"+getTourgridlenght());
			System.out.println("getTicketgridlenght()======"+getTicketgridlenght());
			System.out.println("getHotelgridlenght()======"+getHotelgridlenght());
			for(int i=0;i<getTourgridlenght();i++){
				String temp1=requestParams.get("tour"+i)[0];       
				tourarray.add(temp1);      
			} 
			for(int i=0;i<getTicketgridlenght();i++){
				String temp2=requestParams.get("ticket"+i)[0];       
				ticketarray.add(temp2);      
			} 
			for(int i=0;i<getHotelgridlenght();i++){   
				String temp3=requestParams.get("hotel"+i)[0];            
				hotelarray.add(temp3);                 
			} 
			int val=DAO.insert(sqlStartDate,getCmbreftype(),getRefdocno(),getTxtremarks(),getBrchName(),getMode(),tourarray,ticketarray,hotelarray,session,request);                  
			int vdocno=(int) request.getAttribute("vocno");
			if(val>0){
				setDocno(vdocno);   
				setMasterdoc_no(val);
				setData();
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setDocno(vdocno);   
				setMasterdoc_no(val);
				setData();
				setMsg("Not Saved");
				return "fail";
			}
		}  
		if(mode.equalsIgnoreCase("view")){
			setHidtravelDate(sqlStartDate.toString());     
		}
	return "fail";	
	} 
	public void setData(){
		setRefno(getRefno());
		setRefdocno(getRefdocno());
		setHidreftype(getCmbreftype());
		setTxtremarks(getTxtremarks());
		setTxtclientname(getTxtclientname());
		setHidtravelDate(getHidtravelDate());      
	}
	
}
