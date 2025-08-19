package com.dashboard.client.vehiclemovement;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.dashboard.vehicle.drivermovement.ClsDriverMovBean;
import com.dashboard.vehicle.drivermovement.ClsDriverMovDAO;
import com.opensymphony.xwork2.ActionSupport;

public class ClsVehicleMovAction extends ActionSupport {
	ClsVehicleMovDAO vehmovDAO= new ClsVehicleMovDAO();
	ClsVehicleMovBean vehmovBean;
	
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblprintname;
	private String lblprintname1;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lblservicetax;
	private String lblpan;
	private String lblcstno;
	private String lblnetbalance;
	
	private String lblname;
	private String lblmobno;
	private String lblmail;
	private String lblcode;
	
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
	public String getLblprintname1() {
		return lblprintname1;
	}
	public void setLblprintname1(String lblprintname1) {
		this.lblprintname1 = lblprintname1;
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
	public String getLblservicetax() {
		return lblservicetax;
	}
	public void setLblservicetax(String lblservicetax) {
		this.lblservicetax = lblservicetax;
	}
	public String getLblpan() {
		return lblpan;
	}
	public void setLblpan(String lblpan) {
		this.lblpan = lblpan;
	}
	public String getLblcstno() {
		return lblcstno;
	}
	public void setLblcstno(String lblcstno) {
		this.lblcstno = lblcstno;
	}
	public String getLblnetbalance() {
		return lblnetbalance;
	}
	public void setLblnetbalance(String lblnetbalance) {
		this.lblnetbalance = lblnetbalance;
	}
	public String getLblname() {
		return lblname;
	}
	public void setLblname(String lblname) {
		this.lblname = lblname;
	}

	public String getLblmobno() {
		return lblmobno;
	}
	public void setLblmobno(String lblmobno) {
		this.lblmobno = lblmobno;
	}
	public String getLblmail() {
		return lblmail;
	}
	public void setLblmail(String lblmail) {
		this.lblmail = lblmail;
	}
	public String getLblcode() {
		return lblcode;
	}
	public void setLblcode(String lblcode) {
		this.lblcode = lblcode;
	}
	
public String printAction() throws ParseException, SQLException{
		
	
		HttpServletRequest request=ServletActionContext.getRequest();
	//	String ready = request.getParameter("ready");
		String client = request.getParameter("client");
		String frmDate = request.getParameter("fromdate");
		String toDate = request.getParameter("todate");
		
		vehmovBean=vehmovDAO.getPrint(request,client,frmDate,toDate);
		setLblcompname(vehmovBean.getLblcompname());
		setLblcompaddress(vehmovBean.getLblcompaddress());
		setLblprintname(vehmovBean.getLblprintname());
		setLblprintname1(vehmovBean.getLblprintname1());
		setLblcomptel(vehmovBean.getLblcomptel());
		setLblcompfax(vehmovBean.getLblcompfax());
		setLblbranch(vehmovBean.getLblbranch());
		setLbllocation(vehmovBean.getLbllocation());
		setLblservicetax(vehmovBean.getLblservicetax());
		setLblpan(vehmovBean.getLblpan());
		setLblcstno(vehmovBean.getLblcstno());
		setLblnetbalance(vehmovBean.getLblnetbalance());
		
		
		setLblcode(vehmovBean.getLblcode());
		setLblname(vehmovBean.getLblname());
		setLblmobno(vehmovBean.getLblmobno());
		setLblmail(vehmovBean.getLblmail());
		
		
		
		return "print";
	}

}
