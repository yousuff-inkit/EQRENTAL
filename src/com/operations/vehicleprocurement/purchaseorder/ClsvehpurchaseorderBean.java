package com.operations.vehicleprocurement.purchaseorder;

import java.io.IOException;



public class ClsvehpurchaseorderBean{
	
	
	
	private String lbldate,lbltype,lbldesc1,expdeldate,lblvendoeacc,lblvendoeaccName,lbltotal;
	
	private int lbldoc;
	private String lblcomptrn; 
	private String lblventrnno;
	
	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;
	private String lbltaxamount,lblnettotal;

private String vehpurorderDate,hidvehpurorderDate,accid,vehpuraccname,headacccode,vehtype,vehrefno,vehpurorderdelDate,hidvehpurorderdelDate,vehdesc;
	
	private int  docno;
	  private String masterrefno,brchName;
	  public String getVehpurorderDate() {
		return vehpurorderDate;
	}

	public void setVehpurorderDate(String vehpurorderDate) {
		this.vehpurorderDate = vehpurorderDate;
	}

	public String getHidvehpurorderDate() {
		return hidvehpurorderDate;
	}

	public void setHidvehpurorderDate(String hidvehpurorderDate) {
		this.hidvehpurorderDate = hidvehpurorderDate;
	}

	public String getAccid() {
		return accid;
	}

	public void setAccid(String accid) {
		this.accid = accid;
	}

	public String getVehpuraccname() {
		return vehpuraccname;
	}

	public void setVehpuraccname(String vehpuraccname) {
		this.vehpuraccname = vehpuraccname;
	}

	public String getHeadacccode() {
		return headacccode;
	}

	public void setHeadacccode(String headacccode) {
		this.headacccode = headacccode;
	}

	public String getVehtype() {
		return vehtype;
	}

	public void setVehtype(String vehtype) {
		this.vehtype = vehtype;
	}

	public String getVehrefno() {
		return vehrefno;
	}

	public void setVehrefno(String vehrefno) {
		this.vehrefno = vehrefno;
	}

	public String getVehpurorderdelDate() {
		return vehpurorderdelDate;
	}

	public void setVehpurorderdelDate(String vehpurorderdelDate) {
		this.vehpurorderdelDate = vehpurorderdelDate;
	}

	public String getHidvehpurorderdelDate() {
		return hidvehpurorderdelDate;
	}

	public void setHidvehpurorderdelDate(String hidvehpurorderdelDate) {
		this.hidvehpurorderdelDate = hidvehpurorderdelDate;
	}

	public String getVehdesc() {
		return vehdesc;
	}

	public void setVehdesc(String vehdesc) {
		this.vehdesc = vehdesc;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public String getMasterrefno() {
		return masterrefno;
	}

	public void setMasterrefno(String masterrefno) {
		this.masterrefno = masterrefno;
	}

	public String getBrchName() {
		return brchName;
	}

	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}

	public int getMasterdoc_no() {
		return masterdoc_no;
	}

	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}

	public Double getNettotal() {
		return nettotal;
	}

	public void setNettotal(Double nettotal) {
		this.nettotal = nettotal;
	}

	public Double getTaxamount() {
		return taxamount;
	}

	public void setTaxamount(Double taxamount) {
		this.taxamount = taxamount;
	}

	private int masterdoc_no;
    private Double nettotal,taxamount;
	
	public String getLblventrnno() {
		return lblventrnno;
	}

	public void setLblventrnno(String lblventrnno) {
		this.lblventrnno = lblventrnno;
	}

	public String getLblcomptrn() {
		return lblcomptrn;
	}

	public void setLblcomptrn(String lblcomptrn) {
		this.lblcomptrn = lblcomptrn;
	}

	public String getLbltaxamount() {
		return lbltaxamount;
	}

	public void setLbltaxamount(String lbltaxamount) {
		this.lbltaxamount = lbltaxamount;
	}

	public String getLblnettotal() {
		return lblnettotal;
	}

	public void setLblnettotal(String lblnettotal) {
		this.lblnettotal = lblnettotal;
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

	public String getLbldesc1() {
		return lbldesc1;
	}

	public void setLbldesc1(String lbldesc1) {
		this.lbldesc1 = lbldesc1;
	}

	public String getExpdeldate() {
		return expdeldate;
	}

	public void setExpdeldate(String expdeldate) {
		this.expdeldate = expdeldate;
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

	public String getLbltotal() {
		return lbltotal;
	}

	public void setLbltotal(String lbltotal) {
		this.lbltotal = lbltotal;
	}
	//terms and conditions
	public String lblterms;
	public String getLblterms() {
		return lblterms;
	}

	public void setLblterms(String lblterms) {
		this.lblterms = lblterms;
	}
	
	
	

}
