package com.finance.transactions.cashpayment;

public class ClsCashPaymentBean {
	
		private String account;
		private String description;
		 
		private int txtcashpaydocno;
		private String formdetailcode,watermark,verified;
		private String mode;
		private String deleted;
		private String msg;
		private String jqxCashPaymentDate;
		private String hidjqxCashPaymentDate;
		private String txtrefno;
		private int txtfromdocno;
		private String txtfromaccid;
		private String txtfromaccname;
		private String cmbfromcurrency;
		private String hidcmbfromcurrency;
		private double txtfromrate;
		private double txtfromamount;
		private double txtfrombaseamount;
		private String txtdescription;
		private String cmbtotype;
		private String hidcmbtotype;
		private int txttodocno;
		private int txttotrno;
		private int txttotranid;
		private String txttoaccid;
		private String txttoaccname;
		private String cmbtocurrency;
		private String hidcmbtocurrency;
		private double txttorate;
		private double txttoamount;
		private double txttobaseamount;
		private String hidfromcurrencytype;
		private String hidtocurrencytype;
		
		private double txtapplyinvoiceamt;
		private double txtapplyinvoiceapply;
		private double txtapplyinvoicebalance;
		
		private double txtdrtotal;
		private double txtcrtotal;
		
		private String maindate;
		private String hidmaindate;
		
		//Cash Payment Grid
		private int gridlength;
		
		//Apply-Invoicing Grid
		private int applylength;
		
		//Apply-Invoicing Grid Updating
		private int applylengthupdate;
		
		//Print
		private String lblcomptrn;
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
		private String lblname;
		private String lblvoucherno;
		private String lbldescription;
		private String lbldate;
		private String lblnetamount;
		private String lblnetamountwords;
		private String lbldebittotal;
		private String lblcredittotal;
		private String lblpreparedby,approved;
		private String lblpreparedon;
		private String lblpreparedat;
		private int status;
		
		//for hide
		private int firstarray;
		private int secarray;
		private int txtheader;
		private String applyquery;

		public String getLblcomptrn() {
			return lblcomptrn;
		}
		public void setLblcomptrn(String lblcomptrn) {
			this.lblcomptrn = lblcomptrn;
		}
		
		public String getAccount() {
			return account;
		}

		public void setAccount(String account) {
			this.account = account;
		}

		public String getDescription() {
			return description;
		}

		public void setDescription(String description) {
			this.description = description;
		}

		public int getTxtcashpaydocno() {
			return txtcashpaydocno;
		}

		public void setTxtcashpaydocno(int txtcashpaydocno) {
			this.txtcashpaydocno = txtcashpaydocno;
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

		public String getMsg() {
			return msg;
		}

		public void setMsg(String msg) {
			this.msg = msg;
		}

		public String getJqxCashPaymentDate() {
			return jqxCashPaymentDate;
		}

		public void setJqxCashPaymentDate(String jqxCashPaymentDate) {
			this.jqxCashPaymentDate = jqxCashPaymentDate;
		}

		public String getHidjqxCashPaymentDate() {
			return hidjqxCashPaymentDate;
		}

		public void setHidjqxCashPaymentDate(String hidjqxCashPaymentDate) {
			this.hidjqxCashPaymentDate = hidjqxCashPaymentDate;
		}

		public String getTxtrefno() {
			return txtrefno;
		}

		public void setTxtrefno(String txtrefno) {
			this.txtrefno = txtrefno;
		}

		public int getTxtfromdocno() {
			return txtfromdocno;
		}

		public void setTxtfromdocno(int txtfromdocno) {
			this.txtfromdocno = txtfromdocno;
		}

		public String getTxtfromaccid() {
			return txtfromaccid;
		}

		public void setTxtfromaccid(String txtfromaccid) {
			this.txtfromaccid = txtfromaccid;
		}

		public String getTxtfromaccname() {
			return txtfromaccname;
		}

		public void setTxtfromaccname(String txtfromaccname) {
			this.txtfromaccname = txtfromaccname;
		}

		public String getCmbfromcurrency() {
			return cmbfromcurrency;
		}

		public void setCmbfromcurrency(String cmbfromcurrency) {
			this.cmbfromcurrency = cmbfromcurrency;
		}

		public String getHidcmbfromcurrency() {
			return hidcmbfromcurrency;
		}

		public void setHidcmbfromcurrency(String hidcmbfromcurrency) {
			this.hidcmbfromcurrency = hidcmbfromcurrency;
		}

		public double getTxtfromrate() {
			return txtfromrate;
		}

		public void setTxtfromrate(double txtfromrate) {
			this.txtfromrate = txtfromrate;
		}

		public double getTxtfromamount() {
			return txtfromamount;
		}

		public void setTxtfromamount(double txtfromamount) {
			this.txtfromamount = txtfromamount;
		}

		public double getTxtfrombaseamount() {
			return txtfrombaseamount;
		}

		public void setTxtfrombaseamount(double txtfrombaseamount) {
			this.txtfrombaseamount = txtfrombaseamount;
		}

		public String getTxtdescription() {
			return txtdescription;
		}

		public void setTxtdescription(String txtdescription) {
			this.txtdescription = txtdescription;
		}

		public String getCmbtotype() {
			return cmbtotype;
		}

		public void setCmbtotype(String cmbtotype) {
			this.cmbtotype = cmbtotype;
		}

		public String getHidcmbtotype() {
			return hidcmbtotype;
		}

		public void setHidcmbtotype(String hidcmbtotype) {
			this.hidcmbtotype = hidcmbtotype;
		}

		public int getTxttodocno() {
			return txttodocno;
		}

		public void setTxttodocno(int txttodocno) {
			this.txttodocno = txttodocno;
		}

		public int getTxttotrno() {
			return txttotrno;
		}

		public void setTxttotrno(int txttotrno) {
			this.txttotrno = txttotrno;
		}

		public int getTxttotranid() {
			return txttotranid;
		}

		public void setTxttotranid(int txttotranid) {
			this.txttotranid = txttotranid;
		}

		public String getTxttoaccid() {
			return txttoaccid;
		}

		public void setTxttoaccid(String txttoaccid) {
			this.txttoaccid = txttoaccid;
		}

		public String getTxttoaccname() {
			return txttoaccname;
		}

		public void setTxttoaccname(String txttoaccname) {
			this.txttoaccname = txttoaccname;
		}

		public String getCmbtocurrency() {
			return cmbtocurrency;
		}

		public void setCmbtocurrency(String cmbtocurrency) {
			this.cmbtocurrency = cmbtocurrency;
		}

		public String getHidcmbtocurrency() {
			return hidcmbtocurrency;
		}

		public void setHidcmbtocurrency(String hidcmbtocurrency) {
			this.hidcmbtocurrency = hidcmbtocurrency;
		}

		public double getTxttorate() {
			return txttorate;
		}

		public void setTxttorate(double txttorate) {
			this.txttorate = txttorate;
		}

		public double getTxttoamount() {
			return txttoamount;
		}

		public void setTxttoamount(double txttoamount) {
			this.txttoamount = txttoamount;
		}

		public double getTxttobaseamount() {
			return txttobaseamount;
		}

		public void setTxttobaseamount(double txttobaseamount) {
			this.txttobaseamount = txttobaseamount;
		}

		public String getHidfromcurrencytype() {
			return hidfromcurrencytype;
		}

		public void setHidfromcurrencytype(String hidfromcurrencytype) {
			this.hidfromcurrencytype = hidfromcurrencytype;
		}

		public String getHidtocurrencytype() {
			return hidtocurrencytype;
		}

		public void setHidtocurrencytype(String hidtocurrencytype) {
			this.hidtocurrencytype = hidtocurrencytype;
		}

		public double getTxtapplyinvoiceamt() {
			return txtapplyinvoiceamt;
		}

		public void setTxtapplyinvoiceamt(double txtapplyinvoiceamt) {
			this.txtapplyinvoiceamt = txtapplyinvoiceamt;
		}

		public double getTxtapplyinvoiceapply() {
			return txtapplyinvoiceapply;
		}

		public void setTxtapplyinvoiceapply(double txtapplyinvoiceapply) {
			this.txtapplyinvoiceapply = txtapplyinvoiceapply;
		}

		public double getTxtapplyinvoicebalance() {
			return txtapplyinvoicebalance;
		}

		public void setTxtapplyinvoicebalance(double txtapplyinvoicebalance) {
			this.txtapplyinvoicebalance = txtapplyinvoicebalance;
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

		public int getApplylength() {
			return applylength;
		}

		public void setApplylength(int applylength) {
			this.applylength = applylength;
		}

		public int getApplylengthupdate() {
			return applylengthupdate;
		}

		public void setApplylengthupdate(int applylengthupdate) {
			this.applylengthupdate = applylengthupdate;
		}

		public String getMaindate() {
			return maindate;
		}

		public void setMaindate(String maindate) {
			this.maindate = maindate;
		}

		public String getHidmaindate() {
			return hidmaindate;
		}

		public void setHidmaindate(String hidmaindate) {
			this.hidmaindate = hidmaindate;
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

		public String getLblname() {
			return lblname;
		}

		public void setLblname(String lblname) {
			this.lblname = lblname;
		}

		public String getLblvoucherno() {
			return lblvoucherno;
		}

		public void setLblvoucherno(String lblvoucherno) {
			this.lblvoucherno = lblvoucherno;
		}

		public String getLbldescription() {
			return lbldescription;
		}

		public void setLbldescription(String lbldescription) {
			this.lbldescription = lbldescription;
		}

		public String getLbldate() {
			return lbldate;
		}

		public void setLbldate(String lbldate) {
			this.lbldate = lbldate;
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
		public int getSecarray() {
			return secarray;
		}
		public void setSecarray(int secarray) {
			this.secarray = secarray;
		}

		public int getTxtheader() {
			return txtheader;
		}

		public void setTxtheader(int txtheader) {
			this.txtheader = txtheader;
		}
		public String getWatermark() {
			return watermark;
		}
		public void setWatermark(String watermark) {
			this.watermark = watermark;
		}
		public String getApproved() {
			return approved;
		}
		public void setApproved(String approved) {
			this.approved = approved;
		}
		public String getVerified() {
			return verified;
		}
		public void setVerified(String verified) {
			this.verified = verified;
		}
		public int getStatus() {
			return status;
		}
		public void setStatus(int status) {
			this.status = status;
		}
		public String getApplyquery() {
			return applyquery;
		}
		public void setApplyquery(String applyquery) {
			this.applyquery = applyquery;
		}
}
