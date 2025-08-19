package com.equipment.inspection;

public class ClsEquipmentInspectionBean {
	private int docno;
	private String date, username, base, left, right, signature, clientmail,
			front, back, interior;
	private String hiddate;
	private String cmbtype;
	private String hidcmbtype;
	private String cmbreftype;

	public String getFront() {
		return front;
	}

	public void setFront(String front) {
		this.front = front;
	}

	public String getBack() {
		return back;
	}

	public void setBack(String back) {
		this.back = back;
	}

	public String getInterior() {
		return interior;
	}

	public String getLblclientid() {
		return lblclientid;
	}

	public void setLblclientid(String lblclientid) {
		this.lblclientid = lblclientid;
	}

	public String getLblclntmob() {
		return lblclntmob;
	}

	public void setLblclntmob(String lblclntmob) {
		this.lblclntmob = lblclntmob;
	}

	public String getLbldriver() {
		return lbldriver;
	}

	public void setLbldriver(String lbldriver) {
		this.lbldriver = lbldriver;
	}

	public String getLbldrivermob() {
		return lbldrivermob;
	}

	public void setLbldrivermob(String lbldrivermob) {
		this.lbldrivermob = lbldrivermob;
	}

	public String getLbldriverdob() {
		return lbldriverdob;
	}

	public void setLbldriverdob(String lbldriverdob) {
		this.lbldriverdob = lbldriverdob;
	}

	public String getLbldriverdlno() {
		return lbldriverdlno;
	}

	public void setLbldriverdlno(String lbldriverdlno) {
		this.lbldriverdlno = lbldriverdlno;
	}

	public String getLblpltcode() {
		return lblpltcode;
	}

	public void setLblpltcode(String lblpltcode) {
		this.lblpltcode = lblpltcode;
	}

	public String getLbldout() {
		return lbldout;
	}

	public void setLbldout(String lbldout) {
		this.lbldout = lbldout;
	}

	public String getLbltout() {
		return lbltout;
	}

	public void setLbltout(String lbltout) {
		this.lbltout = lbltout;
	}

	public String getLblkmout() {
		return lblkmout;
	}

	public void setLblkmout(String lblkmout) {
		this.lblkmout = lblkmout;
	}

	public String getLblfout() {
		return lblfout;
	}

	public void setLblfout(String lblfout) {
		this.lblfout = lblfout;
	}

	public String getLbloutby() {
		return lbloutby;
	}

	public void setLbloutby(String lbloutby) {
		this.lbloutby = lbloutby;
	}

	public void setInterior(String interior) {
		this.interior = interior;
	}

	private String hidcmbreftype, lblclientid, lblclntmob, lbldriver,
			lbldrivermob, lbldriverdob, lbldriverdlno, lblpltcode, lbldout,
			lbltout, lblkmout, lblfout, lbloutby;
	private int rdocno;
	private String amount;
	private String accdate;
	private String hidaccdate;
	private String prcs;
	private String collectdate;
	private String hidcollectdate;
	private String accplace;
	private String accfines;
	private String cmbclaim;
	private String hidcmbclaim;
	private String msg;
	private String mode;
	private String deleted;
	private String formdetail;
	private String formdetailcode;
	private String hidaccidents;
	private String accremarks;
	private String rfleet;
	private String cmbagmtbranch;
	private String hidcmbagmtbranch;
	private String client;
	private String regno;
	// print

	private String lblcompname;
	private String lblcompaddress;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbldocno;
	private String lbldate;
	private String lbltime;
	private String lbltype;
	private String lblreftype;
	private String lblreffleetno;
	private String lblrefdocno;
	private String lblaccdate;
	private String lblprcs;
	private String lblcoldate;
	private String lblplace;
	private String lblfines;
	private String lblclaim;
	private String lblremarks;
	private String lblamount;
	private String lblaccident;
	private String lblprintname;
	private String lblregno;
	private String lblfleetname;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getBase() {
		return base;
	}

	public void setBase(String base) {
		this.base = base;
	}

	public String getLeft() {
		return left;
	}

	public void setLeft(String left) {
		this.left = left;
	}

	public String getRight() {
		return right;
	}

	public void setRight(String right) {
		this.right = right;
	}

	public String getLblregno() {
		return lblregno;
	}

	public void setLblregno(String lblregno) {
		this.lblregno = lblregno;
	}

	public String getLblfleetname() {
		return lblfleetname;
	}

	public void setLblfleetname(String lblfleetname) {
		this.lblfleetname = lblfleetname;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getRegno() {
		return regno;
	}

	public void setRegno(String regno) {
		this.regno = regno;
	}

	public String getCmbagmtbranch() {
		return cmbagmtbranch;
	}

	public void setCmbagmtbranch(String cmbagmtbranch) {
		this.cmbagmtbranch = cmbagmtbranch;
	}

	public String getHidcmbagmtbranch() {
		return hidcmbagmtbranch;
	}

	public void setHidcmbagmtbranch(String hidcmbagmtbranch) {
		this.hidcmbagmtbranch = hidcmbagmtbranch;
	}

	public String getLblprintname() {
		return lblprintname;
	}

	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}

	public String getLblaccident() {
		return lblaccident;
	}

	public void setLblaccident(String lblaccident) {
		this.lblaccident = lblaccident;
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

	public String getLbldocno() {
		return lbldocno;
	}

	public void setLbldocno(String lbldocno) {
		this.lbldocno = lbldocno;
	}

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}

	public String getLbltime() {
		return lbltime;
	}

	public void setLbltime(String lbltime) {
		this.lbltime = lbltime;
	}

	public String getLbltype() {
		return lbltype;
	}

	public void setLbltype(String lbltype) {
		this.lbltype = lbltype;
	}

	public String getLblreftype() {
		return lblreftype;
	}

	public void setLblreftype(String lblreftype) {
		this.lblreftype = lblreftype;
	}

	public String getLblreffleetno() {
		return lblreffleetno;
	}

	public void setLblreffleetno(String lblreffleetno) {
		this.lblreffleetno = lblreffleetno;
	}

	public String getLblrefdocno() {
		return lblrefdocno;
	}

	public void setLblrefdocno(String lblrefdocno) {
		this.lblrefdocno = lblrefdocno;
	}

	public String getLblaccdate() {
		return lblaccdate;
	}

	public void setLblaccdate(String lblaccdate) {
		this.lblaccdate = lblaccdate;
	}

	public String getLblprcs() {
		return lblprcs;
	}

	public void setLblprcs(String lblprcs) {
		this.lblprcs = lblprcs;
	}

	public String getLblcoldate() {
		return lblcoldate;
	}

	public void setLblcoldate(String lblcoldate) {
		this.lblcoldate = lblcoldate;
	}

	public String getLblplace() {
		return lblplace;
	}

	public void setLblplace(String lblplace) {
		this.lblplace = lblplace;
	}

	public String getLblfines() {
		return lblfines;
	}

	public void setLblfines(String lblfines) {
		this.lblfines = lblfines;
	}

	public String getLblclaim() {
		return lblclaim;
	}

	public void setLblclaim(String lblclaim) {
		this.lblclaim = lblclaim;
	}

	public String getLblremarks() {
		return lblremarks;
	}

	public void setLblremarks(String lblremarks) {
		this.lblremarks = lblremarks;
	}

	public String getLblamount() {
		return lblamount;
	}

	public void setLblamount(String lblamount) {
		this.lblamount = lblamount;
	}

	public String getHidaccidents() {
		return hidaccidents;
	}

	public void setHidaccidents(String hidaccidents) {
		this.hidaccidents = hidaccidents;
	}

	public String getAccremarks() {
		return accremarks;
	}

	public void setAccremarks(String accremarks) {
		this.accremarks = accremarks;
	}

	public String getRfleet() {
		return rfleet;
	}

	public void setRfleet(String rfleet) {
		this.rfleet = rfleet;
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

	public String getFormdetail() {
		return formdetail;
	}

	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getHiddate() {
		return hiddate;
	}

	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
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

	public String getCmbreftype() {
		return cmbreftype;
	}

	public void setCmbreftype(String cmbreftype) {
		this.cmbreftype = cmbreftype;
	}

	public String getHidcmbreftype() {
		return hidcmbreftype;
	}

	public void setHidcmbreftype(String hidcmbreftype) {
		this.hidcmbreftype = hidcmbreftype;
	}

	public int getRdocno() {
		return rdocno;
	}

	public void setRdocno(int rdocno) {
		this.rdocno = rdocno;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getAccdate() {
		return accdate;
	}

	public void setAccdate(String accdate) {
		this.accdate = accdate;
	}

	public String getHidaccdate() {
		return hidaccdate;
	}

	public void setHidaccdate(String hidaccdate) {
		this.hidaccdate = hidaccdate;
	}

	public String getPrcs() {
		return prcs;
	}

	public void setPrcs(String prcs) {
		this.prcs = prcs;
	}

	public String getCollectdate() {
		return collectdate;
	}

	public void setCollectdate(String collectdate) {
		this.collectdate = collectdate;
	}

	public String getHidcollectdate() {
		return hidcollectdate;
	}

	public void setHidcollectdate(String hidcollectdate) {
		this.hidcollectdate = hidcollectdate;
	}

	public String getAccplace() {
		return accplace;
	}

	public void setAccplace(String accplace) {
		this.accplace = accplace;
	}

	public String getAccfines() {
		return accfines;
	}

	public void setAccfines(String accfines) {
		this.accfines = accfines;
	}

	public String getCmbclaim() {
		return cmbclaim;
	}

	public void setCmbclaim(String cmbclaim) {
		this.cmbclaim = cmbclaim;
	}

	public String getHidcmbclaim() {
		return hidcmbclaim;
	}

	public void setHidcmbclaim(String hidcmbclaim) {
		this.hidcmbclaim = hidcmbclaim;
	}

	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}

	public String getClientmail() {
		return clientmail;
	}

	public void setClientmail(String clientmail) {
		this.clientmail = clientmail;
	}

}
