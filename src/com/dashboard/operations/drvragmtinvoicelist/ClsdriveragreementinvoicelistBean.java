package com.dashboard.operations.drvragmtinvoicelist;

public class ClsdriveragreementinvoicelistBean {
	
	private int txtdebitnotedocno;
	private String formdetailcode;
	private String mode;
	private String deleted;
	private String jqxDebitNoteDate;
	private String hidjqxDebitNoteDate;
	private String txtrefno;
	private int txtdocno;
	private int txttrno;
	private String cmbtype;
	private String hidcmbtype;
	private String txtaccid;
	private String txtaccname;
	private String cmbcurrency;
	private String hidcmbcurrency;
	private String hidcurrencytype;
	private double txtrate;
	private double txtamount;
	private double txtbaseamount;
	private String txtdescription;
	private double txtdrtotal;
	private double txtcrtotal;
	private String lbllpono;
	//Debit-Note Grid
	private int gridlength;
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblpobox;
	private String lblprintname;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lblservicetax;
	private String lblpan;
	private String lblcstno;
	
	private String lbldocumentno;
	private String lbldate;
	private String lblcreditordebit;
	private String lblaccountname;
	private String lbldescription;
	private String lbldebittotal;
	private String lblcredittotal;
	private String lblnetamount;
	private String lblnetamountwords;
	private String lblpreparedby;
	private String lblpreparedon;
	private String lblpreparedat;
	private String lblagreement;
	private String lbldriver;
	private int firstarray;
	private int txtheader;
	private String lblaccount,lbladdress1,lbladdress2,lblclienttrn,lblmobile,lblphone,lbldriven,lblinvfrom,lblinvto,lblcontractstart,
	lblwithtaxvalue,lblwithtaxamount,lblwithtaxtotal,lblwithouttaxvalue,lblwithouttaxamount,lblwithouttaxtotal,
	lbltaxgroupvalue,lbltaxgrouptotal,lblnettaxvalue,lblnettaxamount,lblnettaxtotal,lblrano,lblcomptrn;
	
	
	public String getLblcomptrn() {
		return lblcomptrn;
	}

	public void setLblcomptrn(String lblcomptrn) {
		this.lblcomptrn = lblcomptrn;
	}

	public String getLblrano() {
		return lblrano;
	}

	public void setLblrano(String lblrano) {
		this.lblrano = lblrano;
	}

	public String getLblwithtaxvalue() {
		return lblwithtaxvalue;
	}

	public void setLblwithtaxvalue(String lblwithtaxvalue) {
		this.lblwithtaxvalue = lblwithtaxvalue;
	}

	public String getLblwithtaxamount() {
		return lblwithtaxamount;
	}

	public void setLblwithtaxamount(String lblwithtaxamount) {
		this.lblwithtaxamount = lblwithtaxamount;
	}

	public String getLblwithtaxtotal() {
		return lblwithtaxtotal;
	}

	public void setLblwithtaxtotal(String lblwithtaxtotal) {
		this.lblwithtaxtotal = lblwithtaxtotal;
	}

	public String getLblwithouttaxvalue() {
		return lblwithouttaxvalue;
	}

	public void setLblwithouttaxvalue(String lblwithouttaxvalue) {
		this.lblwithouttaxvalue = lblwithouttaxvalue;
	}

	public String getLblwithouttaxamount() {
		return lblwithouttaxamount;
	}

	public void setLblwithouttaxamount(String lblwithouttaxamount) {
		this.lblwithouttaxamount = lblwithouttaxamount;
	}

	public String getLblwithouttaxtotal() {
		return lblwithouttaxtotal;
	}

	public void setLblwithouttaxtotal(String lblwithouttaxtotal) {
		this.lblwithouttaxtotal = lblwithouttaxtotal;
	}

	public String getLbltaxgroupvalue() {
		return lbltaxgroupvalue;
	}

	public void setLbltaxgroupvalue(String lbltaxgroupvalue) {
		this.lbltaxgroupvalue = lbltaxgroupvalue;
	}

	public String getLbltaxgrouptotal() {
		return lbltaxgrouptotal;
	}

	public void setLbltaxgrouptotal(String lbltaxgrouptotal) {
		this.lbltaxgrouptotal = lbltaxgrouptotal;
	}

	public String getLblnettaxvalue() {
		return lblnettaxvalue;
	}

	public void setLblnettaxvalue(String lblnettaxvalue) {
		this.lblnettaxvalue = lblnettaxvalue;
	}

	public String getLblnettaxamount() {
		return lblnettaxamount;
	}

	public void setLblnettaxamount(String lblnettaxamount) {
		this.lblnettaxamount = lblnettaxamount;
	}

	public String getLblnettaxtotal() {
		return lblnettaxtotal;
	}

	public void setLblnettaxtotal(String lblnettaxtotal) {
		this.lblnettaxtotal = lblnettaxtotal;
	}

	public String getLblcontractstart() {
		return lblcontractstart;
	}

	public void setLblcontractstart(String lblcontractstart) {
		this.lblcontractstart = lblcontractstart;
	}

	public String getLblinvfrom() {
		return lblinvfrom;
	}

	public void setLblinvfrom(String lblinvfrom) {
		this.lblinvfrom = lblinvfrom;
	}

	public String getLblinvto() {
		return lblinvto;
	}

	public void setLblinvto(String lblinvto) {
		this.lblinvto = lblinvto;
	}

	public String getLblaccount() {
		return lblaccount;
	}

	public void setLblaccount(String lblaccount) {
		this.lblaccount = lblaccount;
	}

	public String getLbladdress1() {
		return lbladdress1;
	}

	public void setLbladdress1(String lbladdress1) {
		this.lbladdress1 = lbladdress1;
	}

	public String getLbladdress2() {
		return lbladdress2;
	}

	public void setLbladdress2(String lbladdress2) {
		this.lbladdress2 = lbladdress2;
	}

	public String getLblclienttrn() {
		return lblclienttrn;
	}

	public void setLblclienttrn(String lblclienttrn) {
		this.lblclienttrn = lblclienttrn;
	}

	public String getLblmobile() {
		return lblmobile;
	}

	public void setLblmobile(String lblmobile) {
		this.lblmobile = lblmobile;
	}

	public String getLblphone() {
		return lblphone;
	}

	public void setLblphone(String lblphone) {
		this.lblphone = lblphone;
	}

	public String getLbldriven() {
		return lbldriven;
	}

	public void setLbldriven(String lbldriven) {
		this.lbldriven = lbldriven;
	}

	public String getLbldriver() {
		return lbldriver;
	}

	public void setLbldriver(String lbldriver) {
		this.lbldriver = lbldriver;
	}

	public String getLblagreement() {
		return lblagreement;
	}

	public void setLblagreement(String lblagreement) {
		this.lblagreement = lblagreement;
	}

	public String getLbllpono() {
		return lbllpono;
	}

	public void setLbllpono(String lbllpono) {
		this.lbllpono = lbllpono;
	}

	public int getTxtdebitnotedocno() {
		return txtdebitnotedocno;
	}

	public void setTxtdebitnotedocno(int txtdebitnotedocno) {
		this.txtdebitnotedocno = txtdebitnotedocno;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
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

	public String getJqxDebitNoteDate() {
		return jqxDebitNoteDate;
	}

	public void setJqxDebitNoteDate(String jqxDebitNoteDate) {
		this.jqxDebitNoteDate = jqxDebitNoteDate;
	}

	public String getHidjqxDebitNoteDate() {
		return hidjqxDebitNoteDate;
	}

	public void setHidjqxDebitNoteDate(String hidjqxDebitNoteDate) {
		this.hidjqxDebitNoteDate = hidjqxDebitNoteDate;
	}

	public String getTxtrefno() {
		return txtrefno;
	}

	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}

	public int getTxtdocno() {
		return txtdocno;
	}

	public void setTxtdocno(int txtdocno) {
		this.txtdocno = txtdocno;
	}

	public int getTxttrno() {
		return txttrno;
	}

	public void setTxttrno(int txttrno) {
		this.txttrno = txttrno;
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

	public String getTxtaccid() {
		return txtaccid;
	}

	public void setTxtaccid(String txtaccid) {
		this.txtaccid = txtaccid;
	}

	public String getTxtaccname() {
		return txtaccname;
	}

	public void setTxtaccname(String txtaccname) {
		this.txtaccname = txtaccname;
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

	public String getHidcurrencytype() {
		return hidcurrencytype;
	}

	public void setHidcurrencytype(String hidcurrencytype) {
		this.hidcurrencytype = hidcurrencytype;
	}

	public double getTxtrate() {
		return txtrate;
	}

	public void setTxtrate(double txtrate) {
		this.txtrate = txtrate;
	}

	public double getTxtamount() {
		return txtamount;
	}

	public void setTxtamount(double txtamount) {
		this.txtamount = txtamount;
	}

	public double getTxtbaseamount() {
		return txtbaseamount;
	}

	public void setTxtbaseamount(double txtbaseamount) {
		this.txtbaseamount = txtbaseamount;
	}

	public String getTxtdescription() {
		return txtdescription;
	}

	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}

	public double getTxtdrtotal() {
		return txtdrtotal;
	}

	public void setTxtdrtotal(double txtdrtotal) {
		this.txtdrtotal = txtdrtotal;
	}

	public double getTxtcrtotal() {
		return txtcrtotal;
	}

	public void setTxtcrtotal(double txtcrtotal) {
		this.txtcrtotal = txtcrtotal;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
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

	public String getLblpobox() {
		return lblpobox;
	}

	public void setLblpobox(String lblpobox) {
		this.lblpobox = lblpobox;
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

	public String getLbldocumentno() {
		return lbldocumentno;
	}

	public void setLbldocumentno(String lbldocumentno) {
		this.lbldocumentno = lbldocumentno;
	}

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}

	public String getLblcreditordebit() {
		return lblcreditordebit;
	}

	public void setLblcreditordebit(String lblcreditordebit) {
		this.lblcreditordebit = lblcreditordebit;
	}

	public String getLblaccountname() {
		return lblaccountname;
	}

	public void setLblaccountname(String lblaccountname) {
		this.lblaccountname = lblaccountname;
	}

	public String getLbldescription() {
		return lbldescription;
	}

	public void setLbldescription(String lbldescription) {
		this.lbldescription = lbldescription;
	}

	public String getLbldebittotal() {
		return lbldebittotal;
	}

	public void setLbldebittotal(String lbldebittotal) {
		this.lbldebittotal = lbldebittotal;
	}

	public String getLblcredittotal() {
		return lblcredittotal;
	}

	public void setLblcredittotal(String lblcredittotal) {
		this.lblcredittotal = lblcredittotal;
	}

	public String getLblnetamount() {
		return lblnetamount;
	}

	public void setLblnetamount(String lblnetamount) {
		this.lblnetamount = lblnetamount;
	}

	public String getLblnetamountwords() {
		return lblnetamountwords;
	}

	public void setLblnetamountwords(String lblnetamountwords) {
		this.lblnetamountwords = lblnetamountwords;
	}
	
	public String getLblpreparedby() {
		return lblpreparedby;
	}

	public void setLblpreparedby(String lblpreparedby) {
		this.lblpreparedby = lblpreparedby;
	}

	public String getLblpreparedon() {
		return lblpreparedon;
	}

	public void setLblpreparedon(String lblpreparedon) {
		this.lblpreparedon = lblpreparedon;
	}

	public String getLblpreparedat() {
		return lblpreparedat;
	}

	public void setLblpreparedat(String lblpreparedat) {
		this.lblpreparedat = lblpreparedat;
	}

	public int getFirstarray() {
		return firstarray;
	}

	public void setFirstarray(int firstarray) {
		this.firstarray = firstarray;
	}

	public int getTxtheader() {
		return txtheader;
	}

	public void setTxtheader(int txtheader) {
		this.txtheader = txtheader;
	}
	
}
