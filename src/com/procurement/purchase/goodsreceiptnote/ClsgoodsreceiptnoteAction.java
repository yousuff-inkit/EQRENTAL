package com.procurement.purchase.goodsreceiptnote;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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

import com.common.ClsCommon;
import com.connection.ClsConnection;
 
 

 
public class ClsgoodsreceiptnoteAction{
	
	ClsCommon ClsCommon=new ClsCommon();
	
	private String  masterdate,hidmasterdate,deliverydate,hiddeliverydate,delterms,payterms,purdesc,msg,mode,deleted,
	formdetailcode,txtlocation,puraccname,refno,refmasterdoc_no, reftype,rrefno,reftypeval,invdate,hidinvdate,invno,editdata,gridqry,refinvno,DOC_NO,acno,locId;
	
	private double currate,productTotal,descPercentage,descountVal,roundOf,netTotaldown,nettotal,orderValue,cmbcurrval,prddiscount;
	
	private int docno,cmbcurr,chkdiscount,accdocno,descgridlenght,serviecGridlength,masterdoc_no,chkdiscountval,puraccid,txtlocationid;
	private String url;
	
	//invdate hidinvdate
	// masterdate hidmasterdate refmasterdoc_no txtlocation txtlocationid

	public String getLocId() {
		return locId;
	}

	public void setLocId(String locId) {
		this.locId = locId;
	}
	
	 public String getAcno() {
		return acno;
	}

	public void setAcno(String acno) {
		this.acno = acno;
	}
	
	public String getDOC_NO() {
		return DOC_NO;
	}

	public void setDOC_NO(String dOC_NO) {
		DOC_NO = dOC_NO;
	}

	
	public String getRefinvno() {
		return refinvno;
	}

	public void setRefinvno(String refinvno) {
		this.refinvno = refinvno;
	}
	
	 public String getGridqry() {
			return gridqry;
		}

		public void setGridqry(String gridqry) {
			this.gridqry = gridqry;
		}

	 private int  hideitemtype, itemdocno,itemtype,costtr_no;
	 
	 private String itemname;
	 
	
	
	public int getHideitemtype() {
		return hideitemtype;
	}

	public void setHideitemtype(int hideitemtype) {
		this.hideitemtype = hideitemtype;
	}

	public int getItemdocno() {
		return itemdocno;
	}

	public void setItemdocno(int itemdocno) {
		this.itemdocno = itemdocno;
	}

	public int getItemtype() {
		return itemtype;
	}

	public void setItemtype(int itemtype) {
		this.itemtype = itemtype;
	}

	public int getCosttr_no() {
		return costtr_no;
	}

	public void setCosttr_no(int costtr_no) {
		this.costtr_no = costtr_no;
	}

	public String getItemname() {
		return itemname;
	}

	public void setItemname(String itemname) {
		this.itemname = itemname;
	}

	public String getEditdata() {
		return editdata;
	}

	public void setEditdata(String editdata) {
		this.editdata = editdata;
	}
	
	
	public double getPrddiscount() {
		return prddiscount;
	}



	public void setPrddiscount(double prddiscount) {
		this.prddiscount = prddiscount;
	}


	public String getReftypeval() {
		return reftypeval;
	}

	public void setReftypeval(String reftypeval) {
		this.reftypeval = reftypeval;
	}

	public String getReftype() {
		return reftype;
	}

	public void setReftype(String reftype) {     
		this.reftype = reftype;
	}

	public String getRrefno() {
		return rrefno;
	}

	public void setRrefno(String rrefno) {
		this.rrefno = rrefno;
	}

 

	public String getDeliverydate() {
		return deliverydate;
	}

	public void setDeliverydate(String deliverydate) { 
		this.deliverydate = deliverydate;
	}

	public String getHiddeliverydate() {
		return hiddeliverydate;
	}

	public void setHiddeliverydate(String hiddeliverydate) {
		this.hiddeliverydate = hiddeliverydate;
	}

	public String getDelterms() {
		return delterms;
	}

	public void setDelterms(String delterms) {
		this.delterms = delterms;
	}

	public String getPayterms() {
		return payterms;
	}

	public void setPayterms(String payterms) {
		this.payterms = payterms;
	}

	public String getPurdesc() {
		return purdesc;
	}

	public void setPurdesc(String purdesc) {
		this.purdesc = purdesc;
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

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public double getCurrate() {
		return currate;
	}

	public void setCurrate(double currate) { 
		this.currate = currate;
	}

	public double getProductTotal() { 
		return productTotal;
	}

	public void setProductTotal(double productTotal) {   
		this.productTotal = productTotal;
	}

	public double getDescPercentage() {
		return descPercentage;
	}

	public void setDescPercentage(double descPercentage) {
		this.descPercentage = descPercentage;
	}

	public double getDescountVal() {
		return descountVal;
	}

	public void setDescountVal(double descountVal) {
		this.descountVal = descountVal;
	}

	public double getRoundOf() {
		return roundOf;
	}

	public void setRoundOf(double roundOf) {
		this.roundOf = roundOf;
	}

	public double getNetTotaldown() {
		return netTotaldown;
	}

	public void setNetTotaldown(double netTotaldown) {
		this.netTotaldown = netTotaldown;
	}

	public double getNettotal() {
		return nettotal;
	}

	public void setNettotal(double nettotal) {
		this.nettotal = nettotal;
	}

	public double getOrderValue() {
		return orderValue;
	}

	public void setOrderValue(double orderValue) {
		this.orderValue = orderValue;
	}

	public String getRefno() {
		return refno;
	}

	public void setRefno(String refno) {
		this.refno = refno;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public int getCmbcurr() {
		return cmbcurr;
	}

	public void setCmbcurr(int cmbcurr) {
		this.cmbcurr = cmbcurr;
	}

	public int getChkdiscount() {
		return chkdiscount;
	}

	public void setChkdiscount(int chkdiscount) {
		this.chkdiscount = chkdiscount;
	}
	
/*	nipurchaseorderdate hidnipurchaseorderdate refno docno cmbcurr currate
	
	deliverydate hiddeliverydate delterms payterms purdesc  productTotal chkdiscount descPercentage descountVal roundOf netTotaldown nettotal  orderValue msg mode deleted*/
	
	
	
	public int getAccdocno() {
		return accdocno;
	}

	public void setAccdocno(int accdocno) {
		this.accdocno = accdocno;
	}
	
	
	

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}




	public int getDescgridlenght() {
		return descgridlenght;
	}

	public void setDescgridlenght(int descgridlenght) {
		this.descgridlenght = descgridlenght;
	}

	public int getServiecGridlength() {
		return serviecGridlength;
	}

	public void setServiecGridlength(int serviecGridlength) {
		this.serviecGridlength = serviecGridlength;
	}




	public int getMasterdoc_no() {
		return masterdoc_no;
	}

	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}




	public int getChkdiscountval() {
		return chkdiscountval;
	}

	public void setChkdiscountval(int chkdiscountval) {
		this.chkdiscountval = chkdiscountval;
	}




	public String getPuraccname() {
		return puraccname;
	}

	public void setPuraccname(String puraccname) {
		this.puraccname = puraccname;
	}

	public int getPuraccid() {
		return puraccid;
	}

	public void setPuraccid(int puraccid) {      
		this.puraccid = puraccid;
	}



 

 



	public double getCmbcurrval() {
		return cmbcurrval;
	}

	public void setCmbcurrval(double cmbcurrval) {
		this.cmbcurrval = cmbcurrval;
	}



	public String getMasterdate() {                           
		return masterdate;
	}

	public void setMasterdate(String masterdate) {
		this.masterdate = masterdate;
	}

	public String getHidmasterdate() {
		return hidmasterdate;
	}

	public void setHidmasterdate(String hidmasterdate) {
		this.hidmasterdate = hidmasterdate;
	}

	public String getTxtlocation() {
		return txtlocation;
	}

	public void setTxtlocation(String txtlocation) {
		this.txtlocation = txtlocation;
	}

	public String getRefmasterdoc_no() {
		return refmasterdoc_no;
	}

	public void setRefmasterdoc_no(String refmasterdoc_no) {
		this.refmasterdoc_no = refmasterdoc_no;
	}

	public int getTxtlocationid() {
		return txtlocationid;
	}

	public void setTxtlocationid(int txtlocationid) {
		this.txtlocationid = txtlocationid;
	}











	public String getInvdate() {
		return invdate;
	}

	public void setInvdate(String invdate) {
		this.invdate = invdate;
	}

	public String getHidinvdate() {
		return hidinvdate;
	}

	public void setHidinvdate(String hidinvdate) {     
		this.hidinvdate = hidinvdate;
	}











	public String getInvno() {
		return invno;
	}

	public void setInvno(String invno) {
		this.invno = invno;
	}




	private String lbldate,lbltype,lblvendoeacc,lblvendoeaccName, expdeldate,lbldelterms ,lblpaytems, lbldesc1,lblrefno,lblinvno,lblinvdate,lblloc;
	
	
	private int lbldoc;


	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;	

	 








	public String getLblloc() {
		return lblloc;
	}

	public void setLblloc(String lblloc) {
		this.lblloc = lblloc;
	}

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}

	public String getLbltype() {
		return lbltype;
	}

	public void setLbltype(String lbltype) {
		this.lbltype = lbltype;
	}

	public String getLblvendoeacc() {
		return lblvendoeacc;
	}

	public void setLblvendoeacc(String lblvendoeacc) {
		this.lblvendoeacc = lblvendoeacc;
	}

	public String getLblvendoeaccName() {
		return lblvendoeaccName;
	}

	public void setLblvendoeaccName(String lblvendoeaccName) {
		this.lblvendoeaccName = lblvendoeaccName;
	}

	public String getExpdeldate() {
		return expdeldate;
	}

	public void setExpdeldate(String expdeldate) {
		this.expdeldate = expdeldate;
	}

	public String getLbldelterms() {
		return lbldelterms;
	}

	public void setLbldelterms(String lbldelterms) {
		this.lbldelterms = lbldelterms;
	}

	public String getLblpaytems() {
		return lblpaytems;
	}

	public void setLblpaytems(String lblpaytems) {
		this.lblpaytems = lblpaytems;
	}

	public String getLbldesc1() {
		return lbldesc1;
	}

	public void setLbldesc1(String lbldesc1) {
		this.lbldesc1 = lbldesc1;
	}

	public String getLblrefno() {
		return lblrefno;
	}

	public void setLblrefno(String lblrefno) {
		this.lblrefno = lblrefno;
	}

	public String getLblinvno() {
		return lblinvno;
	}

	public void setLblinvno(String lblinvno) {
		this.lblinvno = lblinvno;
	}

	public String getLblinvdate() {
		return lblinvdate;
	}

	public void setLblinvdate(String lblinvdate) {
		this.lblinvdate = lblinvdate;
	}

	public int getLbldoc() {
		return lbldoc;
	}

	public void setLbldoc(int lbldoc) {
		this.lbldoc = lbldoc;
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

	public String getLblprintname() {
		return lblprintname;
	}

	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}




	ClsgoodsreceiptnoteDAO saveObj = new ClsgoodsreceiptnoteDAO();
	
	ClsgoodsreceiptnoteBean viewObj = new ClsgoodsreceiptnoteBean();
 
	ClsgoodsreceiptnoteBean pintbean = new ClsgoodsreceiptnoteBean();
		
		public String saveAction() throws ParseException, SQLException{
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			Map<String, String[]> requestParams = request.getParameterMap();
			
			String mode=getMode();

//System.out.println("========="+getFormdetailcode());
			//System.out.println("========="+getCmbcurr());
			//  setHidmasterdate() getTxtlocation() getRefmasterdoc_no() 
	if(mode.equalsIgnoreCase("A")){
		java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getMasterdate());
		java.sql.Date deldate = ClsCommon.changeStringtoSqlDate(getDeliverydate());
		
		
		java.sql.Date invdate = ClsCommon.changeStringtoSqlDate(getInvdate());
		 
		 
		
		 
		
		ArrayList<String> masterarray= new ArrayList<>();
		
		//System.out.println("=====1=="+getServiecGridlength());
		
		for(int i=0;i<getServiecGridlength();i++){
			
		 
			String temp2=requestParams.get("sertest"+i)[0];
		 
		
			masterarray.add(temp2);
			 
		}
		
		int val=saveObj.insert(masterdate,deldate,getRefno(),getAccdocno(),getCmbcurr(),getCurrate(),getDelterms(),getPayterms(),
				getPurdesc(),getProductTotal(),getDescPercentage(),getDescountVal(),getRoundOf() ,getNetTotaldown(),getNettotal(),
				getOrderValue(),getChkdiscount(),session,getMode(),getFormdetailcode(),request, 
				masterarray,getReftype(),getRefmasterdoc_no(),getPrddiscount(),getTxtlocationid(),invdate,getInvno(),getItemtype(),getCosttr_no());
		int vdocno=(int) request.getAttribute("vocno");
		if(val>0)
		{
			setDocno(vdocno);
			setMasterdoc_no(val);
			 
			setInvno(getInvno());
			
			 setHidinvdate(invdate.toString());
			setReftypeval(getReftype());
			setRrefno(getRrefno());
			setRefmasterdoc_no(getRefmasterdoc_no());
			
			setHidmasterdate(masterdate.toString());
			setDeliverydate(deldate.toString());
			setDelterms(getDelterms());
			setPayterms(getPayterms());
			setPurdesc(getPurdesc());
			setCurrate(getCurrate());
			setRefno(getRefno());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
			 setPuraccid(getPuraccid()); 
			 setPuraccname(getPuraccname());
			 
			  setTxtlocation(getTxtlocation());
			 
			 setTxtlocationid(getTxtlocationid());
			 
			//duwn
			 setProductTotal(getProductTotal());
			 setChkdiscountval(getChkdiscount());
			 setDescPercentage(getDescPercentage());
			 
			 setPrddiscount(getPrddiscount());
			 
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(getNetTotaldown());
             setNettotal(getNettotal());
             setOrderValue(getOrderValue());
			 
             setHideitemtype(getItemtype());
          	
          	setCosttr_no(getCosttr_no());
          
          	setItemname(getItemname());
          	
          	setItemdocno(getItemdocno());
			 
			setMsg("Successfully Saved");
			return "success";
			
		}
		else
		{
			setInvno(getInvno());
			 setHidinvdate(invdate.toString());
			setHidmasterdate(masterdate.toString());
			setDeliverydate(deldate.toString());
			setDelterms(getDelterms());
			setPayterms(getPayterms());
			setPurdesc(getPurdesc());
			setCurrate(getCurrate());
			setRefno(getRefno());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
			 setPuraccid(getPuraccid()); 
			 setPuraccname(getPuraccname());
			 
			 setTxtlocationid(getTxtlocationid());
				setTxtlocation(getTxtlocation());
			//duwn
			 
				setRefmasterdoc_no(getRefmasterdoc_no());
				setReftypeval(getReftype());
				setRrefno(getRrefno());
				
			 setProductTotal(getProductTotal());
			 setChkdiscountval(getChkdiscount());
			 setDescPercentage(getDescPercentage());
			 setPrddiscount(getPrddiscount());
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(getNetTotaldown());
             setNettotal(getNettotal());
             setOrderValue(getOrderValue());
			 
             setHideitemtype(getItemtype());
          	
          	setCosttr_no(getCosttr_no());
          
          	setItemname(getItemname());
          	
          	setItemdocno(getItemdocno());
			setMsg("Not Saved");
			return "fail";
			
		}
		
		
		
		
		
		
	}
	else if(mode.equalsIgnoreCase("E")){
		java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getMasterdate());
		java.sql.Date deldate = ClsCommon.changeStringtoSqlDate(getDeliverydate());
		java.sql.Date invdate = ClsCommon.changeStringtoSqlDate(getInvdate());
		
		ArrayList<String> masterarray= new ArrayList<>();
		for(int i=0;i<getServiecGridlength();i++){
			
		 
			String temp2=requestParams.get("sertest"+i)[0];
		 
		
			masterarray.add(temp2);
			 
		}
		
		int val=saveObj.update(getMasterdoc_no(),masterdate,deldate,getRefno(),getAccdocno(),getCmbcurr(),getCurrate(),
				getDelterms(),getPayterms(),getPurdesc(),getProductTotal(),getDescPercentage(),getDescountVal(),getRoundOf() ,
				getNetTotaldown(),getNettotal(),getOrderValue(),getChkdiscount(),session,getMode(),getFormdetailcode(),request,
				masterarray,getReftype(),getRefmasterdoc_no(),getPrddiscount(),getTxtlocationid(),invdate,getInvno(),getEditdata(),getItemtype(),getCosttr_no());
		
		if(val>0)
		{
			setDocno(getDocno());
			setMasterdoc_no(getMasterdoc_no());
			
			 setHidinvdate(invdate.toString());
			setReftypeval(getReftype());
			
			setRrefno(getRrefno());
			setRefmasterdoc_no(getRefmasterdoc_no());
			
			setInvno(getInvno());
			
			setHidmasterdate(masterdate.toString());
			setDeliverydate(deldate.toString());
			setDelterms(getDelterms());
			setPayterms(getPayterms());
			setPurdesc(getPurdesc());
			setCurrate(getCurrate());
			setRefno(getRefno());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
			 setPuraccid(getPuraccid()); 
			 setPuraccname(getPuraccname());
			 
			  setTxtlocation(getTxtlocation());
			
			setTxtlocationid(getTxtlocationid());
			 
 
			//duwn
			 setProductTotal(getProductTotal());
			 setChkdiscountval(getChkdiscount());
			 setDescPercentage(getDescPercentage());
			 setPrddiscount(getPrddiscount());
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(getNetTotaldown());
             setNettotal(getNettotal());
             setOrderValue(getOrderValue());
			 
             setHideitemtype(getItemtype());
          	
          	setCosttr_no(getCosttr_no());
          
          	setItemname(getItemname());
          	
          	setItemdocno(getItemdocno());	
 			setMsg("Updated Successfully");
			return "success";
			
		}
		else
		{
			setInvno(getInvno());
			 setHidinvdate(invdate.toString());
			setHidmasterdate(masterdate.toString());
			setDeliverydate(deldate.toString());
	
			setReftypeval(getReftype());
			setRrefno(getRrefno());
			setRefmasterdoc_no(getRefmasterdoc_no());
			
			setDelterms(getDelterms());
			setPayterms(getPayterms());
			setPurdesc(getPurdesc());
			setCurrate(getCurrate());
			setRefno(getRefno());
			setCmbcurrval(getCmbcurr());
			setAccdocno(getAccdocno());
			 setPuraccid(getPuraccid()); 
			 setPuraccname(getPuraccname());
			//duwn
			 
			 
			  setTxtlocation(getTxtlocation());
				
			setTxtlocationid(getTxtlocationid());
			 
			 
			 
			 setProductTotal(getProductTotal());
			 setChkdiscountval(getChkdiscount());
			 setDescPercentage(getDescPercentage());
			 setPrddiscount(getPrddiscount());
			 
			 setDescountVal(getDescountVal());
			 setRoundOf(getRoundOf());
			 setNetTotaldown(getNetTotaldown());
             setNettotal(getNettotal());
             setOrderValue(getOrderValue());
             setHideitemtype(getItemtype());
          	
          	setCosttr_no(getCosttr_no());
          
          	setItemname(getItemname());
          	
          	setItemdocno(getItemdocno());
			
				setMsg("Not Updated");
			return "fail";
			
		}
		
	 
	}
 
	else if(mode.equalsIgnoreCase("view")){
		
		ClsgoodsreceiptnoteDAO ClsgoodsreceiptnoteDAO=new ClsgoodsreceiptnoteDAO();
		viewObj=ClsgoodsreceiptnoteDAO.getViewDetails(getMasterdoc_no());
		
		
		
		
		setDocno(viewObj.getDocno());
		setMasterdoc_no(getMasterdoc_no());
 
		
		 setInvdate(viewObj.getInvdate());
		 setInvno(viewObj.getInvno());
		
		
		
		setHidmasterdate(viewObj.getMasterdate());
		setHiddeliverydate(viewObj.getDeliverydate());
		setDelterms(viewObj.getDelterms());
		setPayterms(viewObj.getPayterms());
		setPurdesc(viewObj.getPurdesc());
		setCurrate(viewObj.getCurrate());
		setRefno(viewObj.getRefno());
		setCmbcurrval(viewObj.getCmbcurr());
		setAccdocno(viewObj.getAccdocno());
		 setPuraccid(viewObj.getPuraccid()); 
		 setPuraccname(viewObj.getPuraccname());
		 
		 
			
		 setReftypeval(viewObj.getReftype());
		 setRrefno(viewObj.getRrefno());
		 
		setRefmasterdoc_no(viewObj.getRefmasterdoc_no());
		
		
		
		 setTxtlocation(viewObj.getTxtlocation());
		
		 setTxtlocationid(viewObj.getTxtlocationid());
		
		 
		 
		//duwn
		 setProductTotal(viewObj.getProductTotal());
		 setChkdiscountval(viewObj.getChkdiscountval());
		 setDescPercentage(viewObj.getDescPercentage());
		 
		 setPrddiscount(viewObj.getPrddiscount());
		 
		 
		 setDescountVal(viewObj.getDescountVal());
		 setRoundOf(viewObj.getRoundOf());
		 setNetTotaldown(viewObj.getNetTotaldown());
         setNettotal(viewObj.getNettotal());
         setOrderValue(viewObj.getOrderValue());
		
         setHideitemtype(viewObj.getItemtype());
			
			setCosttr_no(viewObj.getCosttr_no());

			setItemname(viewObj.getItemname());
			
			setItemdocno(viewObj.getItemdocno());
		
         return "success";
		
	}
		
		
		
		
		return "fail";
		
		
		
		
		
	}
	
	
		public String printAction() throws ParseException, SQLException{
			
			  HttpServletRequest request=ServletActionContext.getRequest();
			  System.out.println("--in print action--");
			 int doc=Integer.parseInt(request.getParameter("docno"));
			 setUrl(ClsCommon.getPrintPath("GRN"));
			 ClsgoodsreceiptnoteDAO ClsgoodsreceiptnoteDAO=new ClsgoodsreceiptnoteDAO();
			 pintbean=ClsgoodsreceiptnoteDAO.getPrint(doc,request);
		  
			 
			
			  //cl details
			 
			    setLblprintname("Goods Receipt Note");
			    setLbldoc(pintbean.getLbldoc());
			    setLbldate(pintbean.getLbldate());
			     setLblrefno(pintbean.getLblrefno());
			     setLbldesc1(pintbean.getLbldesc1());
			    
		 	      
	    	     setLblpaytems(pintbean.getLblpaytems());
	    	     setLbldelterms(pintbean.getLbldelterms());
	    	     setLbltype(pintbean.getLbltype());
	    	     setLblvendoeacc(pintbean.getLblvendoeacc());  
	    	     setLblvendoeaccName(pintbean.getLblvendoeaccName());
			     setExpdeldate(pintbean.getExpdeldate());
		 
						
			   	    
                  setLblinvno(pintbean.getLblinvno());
                 setLblinvdate(pintbean.getLblinvdate());
			  
			     
	    	  
					   setLblbranch(pintbean.getLblbranch());
					   setLblcompname(pintbean.getLblcompname());
					  
					   setLblcompaddress(pintbean.getLblcompaddress());
					   setLblcomptel(pintbean.getLblcomptel());
					   setLblcompfax(pintbean.getLblcompfax());
					   setLbllocation(pintbean.getLbllocation());
					  

					    setLblloc(pintbean.getLblloc());
					    if(ClsCommon.getPrintPath("GRN").contains(".jrxml")==true){
			    			HttpServletResponse response = ServletActionContext.getResponse();
			    		    
			    			HashMap<String,String> param = new HashMap<String,String>();
			    			Connection conn = null;
			    			String reportFileName = "DeliveryNote";
			    			ClsConnection conobj=new ClsConnection();
			    			conn = conobj.getMyConnection();
			    			try {      
			    				 // setLblprintname();
			    				 param.put("docno",pintbean.getDOC_NO());
			    				
			    				 param.put("printname", getLblprintname());
			    				 //param.put("tinno", pintbean.getLbltrno()); 
			    				 param.put("invqry", pintbean.getGridqry());
			    				 param.put("preparedby", "");
			    				 param.put("cusname", pintbean.getLblvendoeaccName());    	
			    				 //param.put("trnno", pintbean.getClienttrno());
			    				 //param.put("invno", pintbean.getLbldoc());
			    				 param.put("date", pintbean.getLbldate());
			    				 param.put("location",pintbean.getLocId());
			    				 param.put("refdetail",pintbean.getRefinvno());
			    				 //param.put("salesman", pintbean.getLblsalesPerson());
			    				 param.put("description", pintbean.getLbldesc1());
			    				 //param.put("claddress", pintbean.getAddress());
			    				 param.put("Cuscode",pintbean.getAcno());
			    				 //param.put("Fax1",pintbean.getFax1());
			    				 param.put("refandno",pintbean.getRefno());
			    				 //param.put("dellocation",pintbean.getDellocation());
			    				 //param.put("clmob", pintbean.getMob());
			    				 //if(getReftype().equalsIgnoreCase("GRN")){
			    					 param.put("refdetname", "Ref Detail :");
			    					 //param.put("refdetail", pintbean.getRefdetail());
			    				 //}
			    				 String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
						        	imgpath=imgpath.replace("\\", "\\\\");    
						          param.put("imghedderpath", imgpath);
			    				  //param.put("location", pintbean.getLbllocation1());
			    				 //param.put("locationaddress", pintbean.getLbllocationaddress());
			    				 ClsCommon com=new ClsCommon();
			    				 //System.out.println("In INVOICE PRINT JRXML");   
			    				JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/Procurement/Purchase/goodsreceiptnote/"+ClsCommon.getPrintPath("GRN")));
			    				 JasperReport jasperReport = JasperCompileManager.compileReport(design);
			    				 generateReportPDF(response, param, jasperReport, conn);
			    				 conn.close();
			    			 }
			    			catch(Exception e){
			    				 conn.close();
			    				 e.printStackTrace();
			    			 }
			 
			 }
			    	   return "print";
		}
			
			    	   private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {
			    	  		  byte[] bytes = null;
			    	          bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
			    	            resp.reset();
			    	          resp.resetBuffer();
			    	          
			    	          resp.setContentType("application/pdf");
			    	          resp.setContentLength(bytes.length);
			    	          ServletOutputStream ouputStream = resp.getOutputStream();
			    	          ouputStream.write(bytes, 0, bytes.length);
			    	         
			    	          ouputStream.flush();
			    	          ouputStream.close();
			    	         
			    	               
			    	      
			    	   }

					public String getUrl() {
						return url;
					}

					public void setUrl(String url) {
						this.url = url;
					}
					
					
		
		
			    	   }
		
		
	

 
			
			
	

