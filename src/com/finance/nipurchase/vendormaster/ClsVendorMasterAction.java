package com.finance.nipurchase.vendormaster;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsVendorMasterAction extends ActionSupport{
    
	ClsCommon commonDAO= new ClsCommon();
	ClsVendorDetailsDAO vendorDetailsDAO= new ClsVendorDetailsDAO();
	ClsVendorDetailsBean vendorDetailsbean;

	private int txtvendordocno;
	private String formdetailcode;
	private String chkstatus;
	private String mode;
	private String deleted;
	private String msg;
	private String jqxVendorDate;
	private String hidjqxVendorDate;
	private int txtcode;
	private String txtvendorname;
	private String cmbcurrency,cmbcommmode;
	private String hidcmbcurrency,hidcmbcommmode;

	public String getCmbcommmode() {
		return cmbcommmode;
	}
	public void setCmbcommmode(String cmbcommmode) {
		this.cmbcommmode = cmbcommmode;
	}
	public String getHidcmbcommmode() {
		return hidcmbcommmode;
	}
	public void setHidcmbcommmode(String hidcmbcommmode) {
		this.hidcmbcommmode = hidcmbcommmode;
	}


	private String cmbcategory;
	private String hidcmbcategory;
	
	private String cmbaccgroup;
	private String hidcmbaccgroup;
	private String txtaccount;
	private int txtcredit_period_min;
	private int txtcredit_period_max;
	private int txtcredit_limit;
	
	private String txtaddress;
	private String txtaddress1;
	private String txttel;
	private String txtmob;
	private String txtoffice;
	private String txtfax;
	private String txtemail;
	private String txtcontact;
	private String txtextno;
	private int vendorgridlenght;
	private int cpgridlength;
	
	public String getTxtaccountno() {
		return txtaccountno;
	}
	public void setTxtaccountno(String txtaccountno) {
		this.txtaccountno = txtaccountno;
	}
	public String getTxtbankname() {
		return txtbankname;
	}
	public void setTxtbankname(String txtbankname) {
		this.txtbankname = txtbankname;
	}
	public String getTxtbranchname() {
		return txtbranchname;
	}
	public void setTxtbranchname(String txtbranchname) {
		this.txtbranchname = txtbranchname;
	}
	public String getTxtbranchaddress() {
		return txtbranchaddress;
	}
	public void setTxtbranchaddress(String txtbranchaddress) {
		this.txtbranchaddress = txtbranchaddress;
	}
	public String getTxtswiftno() {
		return txtswiftno;
	}
	public void setTxtswiftno(String txtswiftno) {
		this.txtswiftno = txtswiftno;
	}
	public String getTxtibanno() {
		return txtibanno;
	}
	public void setTxtibanno(String txtibanno) {
		this.txtibanno = txtibanno;
	}
	public String getTxtcity() {
		return txtcity;
	}
	public void setTxtcity(String txtcity) {
		this.txtcity = txtcity;
	}
	public String getTxtcountryname() {
		return txtcountryname;
	}
	public void setTxtcountryname(String txtcountryname) {
		this.txtcountryname = txtcountryname;
	}
	public String getTxtcdocno() {
		return txtcdocno;
	}
	public void setTxtcdocno(String txtcdocno) {
		this.txtcdocno = txtcdocno;
	}


	private String txtregisteredtrnno;
	private String cmbtype;
	private String hidcmbtype;
	private String vndtax;
	private String txtaccountno;
	private String txtbankname;
	private String txtbranchname;
	private String txtbranchaddress;
	private String txtswiftno;
	private String txtibanno;
	private String txtcity;
	private String txtcountryname;
	private String txtcdocno;
	
	public int getCpgridlength() {
		return cpgridlength;
	}
	public void setCpgridlength(int cpgridlength) {
		this.cpgridlength = cpgridlength;
	}
		
	public String getVndtax() {
		return vndtax;
	}

	public void setVndtax(String vndtax) {
		this.vndtax = vndtax;
	}

	public String getTxtregisteredtrnno() {
		return txtregisteredtrnno;
	}

	public void setTxtregisteredtrnno(String txtregisteredtrnno) {
		this.txtregisteredtrnno = txtregisteredtrnno;
	}

	public String getCmbtype() {
		return cmbtype;
	}

	public void setCmbtype(String cmbtype) {
		this.cmbtype = cmbtype;
	}

	public String getHidcmbtype() {
		return hidcmbtype;
	}

	public void setHidcmbtype(String hidcmbtype) {
		this.hidcmbtype = hidcmbtype;
	}

	public int getVendorgridlenght() {
		return vendorgridlenght;
	}

	public void setVendorgridlenght(int vendorgridlenght) {
		this.vendorgridlenght = vendorgridlenght;
	}

	public int getTxtvendordocno() {
		return txtvendordocno;
	}

	public void setTxtvendordocno(int txtvendordocno) {
		this.txtvendordocno = txtvendordocno;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	
	public String getChkstatus() {
		return chkstatus;
	}

	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getJqxVendorDate() {
		return jqxVendorDate;
	}

	public void setJqxVendorDate(String jqxVendorDate) {
		this.jqxVendorDate = jqxVendorDate;
	}

	public String getHidjqxVendorDate() {
		return hidjqxVendorDate;
	}

	public void setHidjqxVendorDate(String hidjqxVendorDate) {
		this.hidjqxVendorDate = hidjqxVendorDate;
	}

	public int getTxtcode() {
		return txtcode;
	}

	public void setTxtcode(int txtcode) {
		this.txtcode = txtcode;
	}

	public String getTxtvendorname() {
		return txtvendorname;
	}

	public void setTxtvendorname(String txtvendorname) {
		this.txtvendorname = txtvendorname;
	}

	public String getCmbcurrency() {
		return cmbcurrency;
	}

	public void setCmbcurrency(String cmbcurrency) {
		this.cmbcurrency = cmbcurrency;
	}

	public String getHidcmbcurrency() {
		return hidcmbcurrency;
	}

	public void setHidcmbcurrency(String hidcmbcurrency) {
		this.hidcmbcurrency = hidcmbcurrency;
	}

	public String getCmbcategory() {
		return cmbcategory;
	}

	public void setCmbcategory(String cmbcategory) {
		this.cmbcategory = cmbcategory;
	}

	public String getHidcmbcategory() {
		return hidcmbcategory;
	}

	public void setHidcmbcategory(String hidcmbcategory) {
		this.hidcmbcategory = hidcmbcategory;
	}

	public String getCmbaccgroup() {
		return cmbaccgroup;
	}

	public void setCmbaccgroup(String cmbaccgroup) {
		this.cmbaccgroup = cmbaccgroup;
	}

	public String getHidcmbaccgroup() {
		return hidcmbaccgroup;
	}

	public void setHidcmbaccgroup(String hidcmbaccgroup) {
		this.hidcmbaccgroup = hidcmbaccgroup;
	}

	public String getTxtaccount() {
		return txtaccount;
	}

	public void setTxtaccount(String txtaccount) {
		this.txtaccount = txtaccount;
	}

	public int getTxtcredit_period_min() {
		return txtcredit_period_min;
	}

	public void setTxtcredit_period_min(int txtcredit_period_min) {
		this.txtcredit_period_min = txtcredit_period_min;
	}

	public int getTxtcredit_period_max() {
		return txtcredit_period_max;
	}

	public void setTxtcredit_period_max(int txtcredit_period_max) {
		this.txtcredit_period_max = txtcredit_period_max;
	}

	public int getTxtcredit_limit() {
		return txtcredit_limit;
	}

	public void setTxtcredit_limit(int txtcredit_limit) {
		this.txtcredit_limit = txtcredit_limit;
	}

	public String getTxtaddress() {
		return txtaddress;
	}

	public void setTxtaddress(String txtaddress) {
		this.txtaddress = txtaddress;
	}

	public String getTxtaddress1() {
		return txtaddress1;
	}

	public void setTxtaddress1(String txtaddress1) {
		this.txtaddress1 = txtaddress1;
	}

	public String getTxttel() {
		return txttel;
	}

	public void setTxttel(String txttel) {
		this.txttel = txttel;
	}

	public String getTxtmob() {
		return txtmob;
	}

	public void setTxtmob(String txtmob) {
		this.txtmob = txtmob;
	}

	public String getTxtoffice() {
		return txtoffice;
	}

	public void setTxtoffice(String txtoffice) {
		this.txtoffice = txtoffice;
	}

	public String getTxtfax() {
		return txtfax;
	}

	public void setTxtfax(String txtfax) {
		this.txtfax = txtfax;
	}

	public String getTxtemail() {
		return txtemail;
	}

	public void setTxtemail(String txtemail) {
		this.txtemail = txtemail;
	}

	public String getTxtcontact() {
		return txtcontact;
	}

	public void setTxtcontact(String txtcontact) {
		this.txtcontact = txtcontact;
	}

	public String getTxtextno() {
		return txtextno;
	}

	public void setTxtextno(String txtextno) {
		this.txtextno = txtextno;
	}

	
	java.sql.Date vendorDate ;
	
	
	public String saveAction() throws ParseException, SQLException{
		System.out.println("in save");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
	    vendorDate = commonDAO.changeStringtoSqlDate(getJqxVendorDate());
		
		if(mode.equalsIgnoreCase("A")){
			System.out.println("in add");
			ArrayList<String> venarray= new ArrayList<String>();
			for(int i=0;i<getVendorgridlenght();i++){
				String temp2=requestParams.get("ventest"+i)[0];
				venarray.add(temp2);
			}
				ArrayList<String> cnparray= new ArrayList<String>();
				for(int j=0;j<getCpgridlength();j++){
					String temp=requestParams.get("test"+j)[0];
					cnparray.add(temp);
				}	
			
			
						int val=vendorDetailsDAO.insert(vendorDate,getFormdetailcode(),getTxtvendorname(),getCmbcurrency(),getCmbcategory(),getCmbtype(),getTxtregisteredtrnno(),getCmbaccgroup(),getTxtaccount(),
								getTxtcredit_period_min(),getTxtcredit_period_max(),getTxtcredit_limit(),getTxtaddress(),getTxtaddress1(),getTxttel(),getTxtmob(),
								getTxtoffice(),getTxtfax(),getTxtemail(),getTxtcontact(),getTxtextno(),session,request,venarray,cnparray,getVndtax(),getTxtaccountno(),getTxtbankname(),getTxtbranchname(),getTxtbranchaddress(),getTxtswiftno(),getTxtibanno(),getTxtcity(),getTxtcdocno(),getCmbcommmode());
						if(val>0.0){
							
							setTxtvendordocno(val);
							setTxtcode(val);
							setTxtaccount(request.getAttribute("acno").toString());
							setData();
							
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setData();
							setMsg("Not Saved");
							return "fail";
						}	
		}
		else if(mode.equalsIgnoreCase("E")){
			
			ArrayList<String> venarray= new ArrayList<String>();
			for(int i=0;i<getVendorgridlenght();i++){
				String temp2=requestParams.get("ventest"+i)[0];
				venarray.add(temp2);
				
			}
			ArrayList<String> cnparray= new ArrayList<String>();
			for(int j=0;j<getCpgridlength();j++){
				String temp=requestParams.get("test"+j)[0];
				cnparray.add(temp);
			}	
			int Status=vendorDetailsDAO.edit(getTxtvendordocno(),getFormdetailcode(),vendorDate,getTxtvendorname(),getCmbcurrency(),getCmbcategory(),getCmbtype(),getTxtregisteredtrnno(),getCmbaccgroup(),getTxtaccount(),
					getTxtcredit_period_min(),getTxtcredit_period_max(),getTxtcredit_limit(),getTxtaddress(),getTxtaddress1(),getTxttel(),getTxtmob(),
					getTxtoffice(),getTxtfax(),getTxtemail(),getTxtcontact(),getTxtextno(),venarray,cnparray,session,getVndtax(),getTxtaccountno(),getTxtbankname(),getTxtbranchname(),getTxtbranchaddress(),getTxtswiftno(),getTxtibanno(),getTxtcity(),getTxtcdocno(),getCmbcommmode());
			if(Status>0){
					
					setTxtvendordocno(getTxtvendordocno());
					setTxtaccount(getTxtaccount());
					setTxtcode(getTxtcode());
					setData();
					
					setMsg("Updated Successfully");
				    return "success";
			}
			else{
				setTxtvendordocno(getTxtvendordocno());
				setTxtaccount(getTxtaccount());
				setTxtcode(getTxtcode());
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			int Status=vendorDetailsDAO.delete(getTxtvendordocno(),getTxtaccount(),getFormdetailcode(),session);
		if(Status>0){
					
					setTxtvendordocno(getTxtvendordocno());
					setTxtcode(getTxtcode());
					setTxtaccount(getTxtaccount());
					setData();
			
					setDeleted("DELETED");
					setMsg("Successfully Deleted");
					return "success";
		}
		else if(Status==-1){
			setChkstatus("1");
			setData();
			setMsg("Transaction Already Exists.");
			return "fail";
		}
		else{
			setTxtvendordocno(getTxtvendordocno());
			setTxtaccount(getTxtaccount());
			setTxtcode(getTxtcode());
			setData();
			setMsg("Not Deleted");
			return "fail";
		}
		}
	
			else if(mode.equalsIgnoreCase("View")){   
				vendorDetailsbean=vendorDetailsDAO.getViewDetails(getTxtvendordocno());
				setHidcmbcommmode(vendorDetailsbean.getHidcmbcommmode());      
				setJqxVendorDate(vendorDetailsbean.getJqxVendorDate());
				setTxtcode(vendorDetailsbean.getTxtcode());
				setTxtvendorname(vendorDetailsbean.getTxtvendorname());
				setHidcmbcurrency(vendorDetailsbean.getHidcmbcurrency());
				setHidcmbcategory(vendorDetailsbean.getHidcmbcategory());
				setHidcmbtype(vendorDetailsbean.getHidcmbtype());
				setTxtregisteredtrnno(vendorDetailsbean.getTxtregisteredtrnno());
				setVndtax(vendorDetailsbean.getVndtax());
				
				setHidcmbaccgroup(vendorDetailsbean.getHidcmbaccgroup());
				setTxtaccount(vendorDetailsbean.getTxtaccount());
				setTxtcredit_period_min(vendorDetailsbean.getTxtcredit_period_min());
				setTxtcredit_period_max(vendorDetailsbean.getTxtcredit_period_max());
				setTxtcredit_limit(vendorDetailsbean.getTxtcredit_limit());
				setTxtaddress(vendorDetailsbean.getTxtaddress());
				setTxtaddress1(vendorDetailsbean.getTxtaddress1());
				setTxttel(vendorDetailsbean.getTxttel());
				setTxtmob(vendorDetailsbean.getTxtmob());
				setTxtoffice(vendorDetailsbean.getTxtoffice());
				setTxtfax(vendorDetailsbean.getTxtfax());
				setTxtemail(vendorDetailsbean.getTxtemail());
				setTxtcontact(vendorDetailsbean.getTxtcontact());
				setTxtextno(vendorDetailsbean.getTxtextno());
				setTxtaccountno(vendorDetailsbean.getTxtaccountno());
				setTxtbankname(vendorDetailsbean.getTxtbankname());
				setTxtbranchname(vendorDetailsbean.getTxtbranchname());
				setTxtbranchaddress(vendorDetailsbean.getTxtbranchaddress());
				setTxtibanno(vendorDetailsbean.getTxtibanno());
				setTxtswiftno(vendorDetailsbean.getTxtswiftno());
				setTxtcity(vendorDetailsbean.getTxtcity());
				setTxtcdocno(vendorDetailsbean.getTxtcdocno());
				setTxtcountryname(vendorDetailsbean.getTxtcountryname());
				setFormdetailcode(vendorDetailsbean.getFormdetailcode());
				
				return "success";
			}
			return "fail";
}

			public JSONArray searchDetails(String vndname,String vndaccno,String vndmob,String vndtel,String id ){
				  JSONArray cellarray = new JSONArray();
				  		  JSONObject cellobj = null;
				  try {
					  cellarray= vendorDetailsDAO.vndMainSearch(vndname,vndaccno,vndmob,vndtel,id);
			
				  } catch (SQLException e) {
					  e.printStackTrace();
					  }
				return cellarray;
			}
			
			public void setData() {
				setHidcmbcommmode(getCmbcommmode());
				setHidjqxVendorDate(vendorDate.toString());
				setTxtvendorname(getTxtvendorname());
				setHidcmbcurrency(getCmbcurrency());
				setHidcmbcategory(getCmbcategory());
				setHidcmbaccgroup(getCmbaccgroup());
				setTxtcredit_period_min(getTxtcredit_period_min());
				setTxtcredit_period_max(getTxtcredit_period_max());
				setTxtcredit_limit(getTxtcredit_limit());
				
				setTxtaddress(getTxtaddress());
				setTxtaddress1(getTxtaddress1());
				setTxttel(getTxttel());
				setTxtmob(getTxtmob());
				setTxtoffice(getTxtoffice());
				setTxtfax(getTxtfax());
				setTxtemail(getTxtemail());
				setTxtcontact(getTxtcontact());
				setTxtextno(getTxtextno());
				setFormdetailcode(getFormdetailcode());
				setVndtax(getVndtax());
				setTxtaccountno(getTxtaccountno());
				setTxtbankname(getTxtbankname());
				setTxtbranchname(getTxtbranchname());
				setTxtbranchaddress(getTxtbranchaddress());
				setTxtibanno(getTxtibanno());
				setTxtswiftno(getTxtswiftno());
				setTxtcity(getTxtcity());
				setTxtcdocno(getTxtcdocno());
				setTxtcountryname(getTxtcountryname());
				setHidcmbtype(getCmbtype());
				
				
			}
	
}
