package com.equipment.equippurchase;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.operations.vehicleprocurement.purchase.ClsvehpurchaseDAO;
import com.operations.vehicleprocurement.purchaseorder.ClsvehpurchaseorderDAO;

/**
 * Servlet implementation class ClsvehpurchaseAction
 */
public class ClsEquipPurchaseAction extends HttpServlet {

	ClsCommon ClsCommon=new ClsCommon();

	ClsEquipPurchaseDAO vehpurchaseDAO= new ClsEquipPurchaseDAO(); 
ClsEquipPurchaseBean pintbean= new ClsEquipPurchaseBean(); 
ClsEquipPurchaseBean bean;
private String restructure;

private int cmbbilltype;
public int getCmbbilltype() {
	return cmbbilltype;
}

public void setCmbbilltype(int cmbbilltype) {
	this.cmbbilltype = cmbbilltype;
}

public int getHidcmbbilltype() {
	return hidcmbbilltype;
}

public void setHidcmbbilltype(int hidcmbbilltype) {
	this.hidcmbbilltype = hidcmbbilltype;
}

private int hidcmbbilltype;


	public String getRestructure() {
		return restructure;
	}

	public void setRestructure(String restructure) {
		this.restructure = restructure;
	}
	
	private String vehpurorderDate,hidvehpurorderDate,accid,vehpuraccname,headacccode,vehtype,vehrefno,vehpurorderdelDate,hidvehpurorderdelDate,vehdesc,invno,vehpurinvDate,hidvehpurinvDate;
	
	private int  docno,vehpurchasegridlenght,fleetupdateval,distributionlenght,detval;
	
	private String deleted,mode,msg,formdetailcode,vehtypeval;
    private Double nettotal,taxamount,totalamt;
   
    
    private String brchName,masterrefno,dealno;
    
    private String jqxStartDate,hidjqxStartDate,secchaqueno,nameincheque,txtdescription,uptoDate,hiduptoDate;
       private int  calcumethod,finaccdocno,banckaccdocno,interestaccdocno,loanaccdocno,paymentmethod,instnos,tranno;
       
      private BigDecimal downpayment,loanamount,chqamount;
      private String lblcomptrn,lblclienttrn;

      private String url;
		
		public String getUrl() {
			return url;
		}
		public void setUrl(String url) {
			this.url = url;
		}
      
      public String getLblclienttrn() {
		return lblclienttrn;
	}

	public void setLblclienttrn(String lblclienttrn) {
		this.lblclienttrn = lblclienttrn;
	}

	public String getLblcomptrn() {
		return lblcomptrn;
	}

	public void setLblcomptrn(String lblcomptrn) {
		this.lblcomptrn = lblcomptrn;
	}

	public Double getTaxamount() {
		return taxamount;
	}

	public void setTaxamount(Double taxamount) {
		this.taxamount = taxamount;
	}

	public Double getTotalamt() {
		return totalamt;
	}

	public void setTotalamt(Double totalamt) {
		this.totalamt = totalamt;
	}

	private String financeaccid,financeaccname,bankaccid,bankaccname,interestaccid,intaccname,loanaccid,loanaccname;
  
    
      private double perinterest,pricetottal;
      
      private int  calcuval,paymentval;
      
     private int Clstatus,masterstatus,masterdoc_no; 
     
     
     private String bankcurrency,intercurrency,loancurrecy,vendorcurr; 
     private double bankrate,interrate,loanrate,vendorrate;
      
      //-----------------------------------------------------------------------
      
 
     
     
  	public int getMasterstatus() {
 		return masterstatus;
 	}





	public String getDealno() {
		return dealno;
	}

	public void setDealno(String dealno) {
		this.dealno = dealno;
	}





	public int getTranno() {
		return tranno;
	}



	public void setTranno(int tranno) {
		this.tranno = tranno;
	}



	public void setMasterstatus(int masterstatus) {
 		this.masterstatus = masterstatus;
 	}

 	public double getPricetottal() {
 		return pricetottal;
 	}






	public void setPricetottal(double pricetottal) {
 		this.pricetottal = pricetottal;
 	}
     
     
      public String getFinanceaccid() {
		return financeaccid;
	}






	public void setFinanceaccid(String financeaccid) { 
		this.financeaccid = financeaccid; 
	}

	public String getFinanceaccname() {
		return financeaccname;
	}

	public void setFinanceaccname(String financeaccname) {
		this.financeaccname = financeaccname;
	}

	public String getBankaccid() {
		return bankaccid;
	}

	public void setBankaccid(String bankaccid) {
		this.bankaccid = bankaccid;
	}

	public String getBankaccname() {
		return bankaccname;
	}

	public void setBankaccname(String bankaccname) {
		this.bankaccname = bankaccname;
	}

	public String getInterestaccid() {
		return interestaccid;
	}

	public void setInterestaccid(String interestaccid) {
		this.interestaccid = interestaccid;
	}

	public String getIntaccname() {
		return intaccname;
	}

	public void setIntaccname(String intaccname) {
		this.intaccname = intaccname;
	}

	public String getLoanaccid() {
		return loanaccid;
	}

	public void setLoanaccid(String loanaccid) {
		this.loanaccid = loanaccid;
	}

	public String getLoanaccname() {
		return loanaccname;
	}

	public void setLoanaccname(String loanaccname) {
		this.loanaccname = loanaccname;
	}

	public int getCalcuval() {
  		return calcuval;
  	}

  	public void setCalcuval(int calcuval) {
  		this.calcuval = calcuval;
  	}

  	public int getPaymentval() {
  		return paymentval;
  	}

  	public void setPaymentval(int paymentval) {
  		this.paymentval = paymentval;
  	}
      
      
      
  	public int getDetval() {
		return detval;
	}

	

	public void setDetval(int detval) {
		this.detval = detval;
	}
	
	public int getDistributionlenght() {            
		return distributionlenght;
	}

	public void setDistributionlenght(int distributionlenght) {
		this.distributionlenght = distributionlenght;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}

	
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
	public Double getNettotal() {
		return nettotal;
	}
	public void setNettotal(Double nettotal) {
		this.nettotal = nettotal;
	}
	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getVehtypeval() {
		return vehtypeval;
	}
	public void setVehtypeval(String vehtypeval) {
		this.vehtypeval = vehtypeval;
	}

	public int getVehpurchasegridlenght() {
		return vehpurchasegridlenght;
	}
	public void setVehpurchasegridlenght(int vehpurchasegridlenght) {
		this.vehpurchasegridlenght = vehpurchasegridlenght;
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
	

	public String getInvno() {
		return invno;
	}
	public void setInvno(String invno) {
		this.invno = invno;
	}
	public String getVehpurinvDate() {
		return vehpurinvDate;
	}
	public void setVehpurinvDate(String vehpurinvDate) {
		this.vehpurinvDate = vehpurinvDate;
	}
	public String getHidvehpurinvDate() {
		return hidvehpurinvDate;
	}
	public void setHidvehpurinvDate(String hidvehpurinvDate) {
		this.hidvehpurinvDate = hidvehpurinvDate;
	}
	
	
	public int getFleetupdateval() {
		return fleetupdateval;
	}
	public void setFleetupdateval(int fleetupdateval) {
		this.fleetupdateval = fleetupdateval;
	}
	//----------------------------------------------------------------
	
	
	public String getJqxStartDate() {
		return jqxStartDate;
	}
	public void setJqxStartDate(String jqxStartDate) {
		this.jqxStartDate = jqxStartDate;
	}
	public String getHidjqxStartDate() {
		return hidjqxStartDate;
	}
	public void setHidjqxStartDate(String hidjqxStartDate) {
		this.hidjqxStartDate = hidjqxStartDate;
	}
	public String getSecchaqueno() {
		return secchaqueno;
	}
	public void setSecchaqueno(String secchaqueno) { 
		this.secchaqueno = secchaqueno;
	}
	public String getNameincheque() {
		return nameincheque;
	}
	public void setNameincheque(String nameincheque) {
		this.nameincheque = nameincheque;
	}
	public String getTxtdescription() {
		return txtdescription;
	}
	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}
	public int getCalcumethod() {
		return calcumethod;
	}
	public void setCalcumethod(int calcumethod) {
		this.calcumethod = calcumethod;
	}
	public int getFinaccdocno() {
		return finaccdocno;
	}
	public void setFinaccdocno(int finaccdocno) {
		this.finaccdocno = finaccdocno;
	}
	public int getBanckaccdocno() {
		return banckaccdocno;
	}
	public void setBanckaccdocno(int banckaccdocno) {
		this.banckaccdocno = banckaccdocno;
	}
	public int getInterestaccdocno() {
		return interestaccdocno;
	}
	public void setInterestaccdocno(int interestaccdocno) {
		this.interestaccdocno = interestaccdocno;
	}
	public int getLoanaccdocno() {
		return loanaccdocno;
	}
	public void setLoanaccdocno(int loanaccdocno) {
		this.loanaccdocno = loanaccdocno;
	}
	public int getPaymentmethod() {
		return paymentmethod;
	}
	public void setPaymentmethod(int paymentmethod) {
		this.paymentmethod = paymentmethod;
	}
/*	public double getDownpayment() {
		return downpayment;
	}
	public void setDownpayment(double downpayment) {
		this.downpayment = downpayment;
	}
	public double getLoanamount() {
		return loanamount;
	}
	public void setLoanamount(double loanamount) {
		this.loanamount = loanamount;
	}
	public double getChqamount() {
		return chqamount;
	}
	public void setChqamount(double chqamount) {
		this.chqamount = chqamount;
	}
	*/
	
	
	public int getInstnos() {
		return instnos;
	}
	public BigDecimal getDownpayment() {
		return downpayment;
	}

	public void setDownpayment(BigDecimal downpayment) {
		this.downpayment = downpayment;
	}

	public BigDecimal getLoanamount() {
		return loanamount;
	}

	public void setLoanamount(BigDecimal loanamount) {
		this.loanamount = loanamount;
	}

	public BigDecimal getChqamount() {
		return chqamount;
	}

	public void setChqamount(BigDecimal chqamount) {
		this.chqamount = chqamount;
	}

	public void setInstnos(int instnos) {
		this.instnos = instnos;
	}
	public double getPerinterest() {
		return perinterest;
	}
	public void setPerinterest(double perinterest) {  
		this.perinterest = perinterest;
	}
	
	
	
	
	
	public int getClstatus() {
		return Clstatus;
	}

	public void setClstatus(int clstatus) {
		Clstatus = clstatus;
	}
	
	

	public String getBankcurrency() {
		return bankcurrency;
	}

	public void setBankcurrency(String bankcurrency) { 
		this.bankcurrency = bankcurrency;
	}

	public String getIntercurrency() {
		return intercurrency;
	}

	public void setIntercurrency(String intercurrency) {
		this.intercurrency = intercurrency;
	}

	public String getLoancurrecy() {
		return loancurrecy;
	}

	public void setLoancurrecy(String loancurrecy) {
		this.loancurrecy = loancurrecy;
	}

	public double getBankrate() {
		return bankrate;
	}

	public void setBankrate(double bankrate) {
		this.bankrate = bankrate;
	}

	public double getInterrate() {
		return interrate;
	}

	public void setInterrate(double interrate) {
		this.interrate = interrate;
	}

	public double getLoanrate() {
		return loanrate;
	}

	public void setLoanrate(double loanrate) {
		this.loanrate = loanrate;
	}
	
	
	
	
	

	public String getVendorcurr() {
		return vendorcurr;
	}

	public void setVendorcurr(String vendorcurr) {
		this.vendorcurr = vendorcurr;
	}

	public double getVendorrate() {
		return vendorrate;
	}

	public void setVendorrate(double vendorrate) {
		this.vendorrate = vendorrate;
	}
       
	
	
	
	public String getUptoDate() {
		return uptoDate;
	}


	public void setUptoDate(String uptoDate) {
		this.uptoDate = uptoDate;
	}

	public String getHiduptoDate() {
		return hiduptoDate;
	}

	public void setHiduptoDate(String hiduptoDate) {
		this.hiduptoDate = hiduptoDate;
	}

	
	
	


	public String getBrchName() {
		return brchName;
	}



	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}



	public String getMasterrefno() {
		return masterrefno;
	}



	public void setMasterrefno(String masterrefno) {
		this.masterrefno = masterrefno;
	}



	public int getMasterdoc_no() {
		return masterdoc_no;
	}



	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}

	//--------------------------------------------------------print-------------------------------------------------------
	
		private String lbldate,lbltype,lbldesc1,expdeldate,lblvendoeacc,lblvendoeaccName,lbltotal, lbltax, lblnettotal, lblpurchaseDate,lblinvno;
		
		private int lbldoc,firstarray,rowdatascount;
		
		private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;
		
	       private String lbldownpayment,lblloanamt,lblstartdate,lblperinterst,lblcalcumethod,lblnoofinst,lblfinacc,lblfinaccName,lblbankacc,lblbankaccName;
	       private String lblintacc,lblintaccName,lblloanacc,lblloanaccName,lblsecucqNo,lblanamt,lbluptodate,lblpayval,lblnameinchq,lblDesc,amountinwords;
	       
	       private String lblpricitotalamount,lblinttotalamount,lbltotalgridamount,lbltotalint;
	       
	       
		//-------------------------------------
		
	       
	       
			public int getRowdatascount() {
				return rowdatascount;
			}





			public String getLbltax() {
				return lbltax;
			}

			public void setLbltax(String lbltax) {
				this.lbltax = lbltax;
			}

			public String getLblnettotal() {
				return lblnettotal;
			}

			public void setLblnettotal(String lblnettotal) {
				this.lblnettotal = lblnettotal;
			}

			public String getLblpricitotalamount() {
				return lblpricitotalamount;
			}





			public void setLblpricitotalamount(String lblpricitotalamount) {
				this.lblpricitotalamount = lblpricitotalamount;
			}





			public String getLblinttotalamount() {
				return lblinttotalamount;
			}





			public void setLblinttotalamount(String lblinttotalamount) {
				this.lblinttotalamount = lblinttotalamount;
			}





			public String getLbltotalgridamount() {
				return lbltotalgridamount;
			}





			public void setLbltotalgridamount(String lbltotalgridamount) {
				this.lbltotalgridamount = lbltotalgridamount;
			}





			public String getLbltotalint() {
				return lbltotalint;
			}





			public void setLbltotalint(String lbltotalint) {
				this.lbltotalint = lbltotalint;
			}





			public void setRowdatascount(int rowdatascount) {
				this.rowdatascount = rowdatascount;
			}

	       

	public String getLbldate() {
			return lbldate;
		}








		public String getAmountinwords() {
		return amountinwords;
	}





	public void setAmountinwords(String amountinwords) {
		this.amountinwords = amountinwords;
	}





		public int getFirstarray() {
		return firstarray;
	}



	public void setFirstarray(int firstarray) {
		this.firstarray = firstarray;
	}



		public String getLbldownpayment() {
		return lbldownpayment;
	}



	public void setLbldownpayment(String lbldownpayment) {
		this.lbldownpayment = lbldownpayment;
	}



	public String getLblloanamt() {
		return lblloanamt;
	}



	public void setLblloanamt(String lblloanamt) {
		this.lblloanamt = lblloanamt;
	}



	public String getLblstartdate() {
		return lblstartdate;
	}



	public void setLblstartdate(String lblstartdate) {
		this.lblstartdate = lblstartdate;
	}



	public String getLblperinterst() {
		return lblperinterst;
	}



	public void setLblperinterst(String lblperinterst) {
		this.lblperinterst = lblperinterst;
	}



	public String getLblcalcumethod() {
		return lblcalcumethod;
	}



	public void setLblcalcumethod(String lblcalcumethod) {
		this.lblcalcumethod = lblcalcumethod;
	}



	public String getLblnoofinst() {
		return lblnoofinst;
	}



	public void setLblnoofinst(String lblnoofinst) {
		this.lblnoofinst = lblnoofinst;
	}



	public String getLblfinacc() {
		return lblfinacc;
	}



	public void setLblfinacc(String lblfinacc) {
		this.lblfinacc = lblfinacc;
	}



	public String getLblfinaccName() {
		return lblfinaccName;
	}



	public void setLblfinaccName(String lblfinaccName) {
		this.lblfinaccName = lblfinaccName;
	}



	public String getLblbankacc() {
		return lblbankacc;
	}



	public void setLblbankacc(String lblbankacc) {
		this.lblbankacc = lblbankacc;
	}



	public String getLblbankaccName() {
		return lblbankaccName;
	}



	public void setLblbankaccName(String lblbankaccName) {
		this.lblbankaccName = lblbankaccName;
	}



	public String getLblintacc() {
		return lblintacc;
	}



	public void setLblintacc(String lblintacc) {
		this.lblintacc = lblintacc;
	}



	public String getLblintaccName() {
		return lblintaccName;
	}



	public void setLblintaccName(String lblintaccName) {
		this.lblintaccName = lblintaccName;
	}



	public String getLblloanacc() {
		return lblloanacc;
	}



	public void setLblloanacc(String lblloanacc) {
		this.lblloanacc = lblloanacc;
	}



	public String getLblloanaccName() {
		return lblloanaccName;
	}



	public void setLblloanaccName(String lblloanaccName) {
		this.lblloanaccName = lblloanaccName;
	}



	public String getLblsecucqNo() {
		return lblsecucqNo;
	}



	public void setLblsecucqNo(String lblsecucqNo) {
		this.lblsecucqNo = lblsecucqNo;
	}



	public String getLblanamt() {
		return lblanamt;
	}



	public void setLblanamt(String lblanamt) {
		this.lblanamt = lblanamt;
	}



	public String getLbluptodate() {
		return lbluptodate;
	}



	public void setLbluptodate(String lbluptodate) {
		this.lbluptodate = lbluptodate;
	}



	public String getLblpayval() {
		return lblpayval;
	}



	public void setLblpayval(String lblpayval) {
		this.lblpayval = lblpayval;
	}



	public String getLblnameinchq() {
		return lblnameinchq;
	}



	public void setLblnameinchq(String lblnameinchq) {
		this.lblnameinchq = lblnameinchq;
	}



	public String getLblDesc() {
		return lblDesc;
	}



	public void setLblDesc(String lblDesc) {
		this.lblDesc = lblDesc;
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



		public String getLbltotal() {
			return lbltotal;
		}



		public void setLbltotal(String lbltotal) {
			this.lbltotal = lbltotal;
		}



		public String getLblpurchaseDate() {
			return lblpurchaseDate;
		}



		public void setLblpurchaseDate(String lblpurchaseDate) {
			this.lblpurchaseDate = lblpurchaseDate;
		}



		public String getLblinvno() {
			return lblinvno;
		}



		public void setLblinvno(String lblinvno) {
			this.lblinvno = lblinvno;
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


       
       
       
       

	public String saveAction() throws ParseException, SQLException{           
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getVehpurorderDate());
		java.sql.Date sqlpurdeldate = ClsCommon.changeStringtoSqlDate(getVehpurorderdelDate());
		
		java.sql.Date invDate = ClsCommon.changeStringtoSqlDate(getVehpurinvDate());
		String mode=getMode();
//System.out.println("---------sss---"+getLoanamount());


if(mode.equalsIgnoreCase("A")){
	
	
	ArrayList<String> descarray= new ArrayList<>();
	for(int i=0;i<getVehpurchasegridlenght() ;i++){
		String temp2=requestParams.get("vehpurchasetest"+i)[0];
	// String temp2=request.getAttribute("enqtest"+i).toString();
	
		descarray.add(temp2);
	 
	}
	int val=vehpurchaseDAO.insert(sqlStartDate,sqlpurdeldate,invDate,getHeadacccode(),getVehtype(),getMasterrefno(),getNettotal(),
			getVehdesc(),session,getMode(),getFormdetailcode(),descarray,getInvno(),request,getCmbbilltype());
	int vdocno=(int) request.getAttribute("vocno");
	if(val>0){
		setHidvehpurorderDate(sqlStartDate.toString());
		setHidvehpurorderdelDate(sqlpurdeldate.toString());
		setHidvehpurinvDate(invDate.toString());
		setAccid(getAccid());
		setVehpuraccname(getVehpuraccname());
		setVehtypeval(getVehtype());
		setHeadacccode(getHeadacccode());
		setVehrefno(getVehrefno());
		setMasterrefno(getMasterrefno());
		setNettotal(getNettotal());
		setVehdesc(getVehdesc());
		setHidcmbbilltype(getCmbbilltype());

		setDocno(vdocno);
		setMasterdoc_no(val);
	
		setMsg("Successfully Saved");
		return "success";
	}
	else{
		setMsg("Not Saved");
		setHidvehpurorderDate(sqlStartDate.toString());
		setHidvehpurorderdelDate(sqlpurdeldate.toString());
		setHidvehpurinvDate(invDate.toString());
		setAccid(getAccid());
		setVehpuraccname(getVehpuraccname());
		setVehtypeval(getVehtype());
		setHeadacccode(getHeadacccode());
		setVehrefno(getVehrefno());
		setNettotal(getNettotal());
		setVehdesc(getVehdesc());
		setDocno(vdocno);
		setMasterdoc_no(val);
		setHidcmbbilltype(getCmbbilltype());

		return "fail";
	}
}

else if(mode.equalsIgnoreCase("UPD")){
	java.sql.Date sqldetDate = ClsCommon.changeStringtoSqlDate(getJqxStartDate());
	java.sql.Date sqluptoDate = ClsCommon.changeStringtoSqlDate(getUptoDate());
	java.sql.Date docDate = ClsCommon.changeStringtoSqlDate(getVehpurorderDate());
	ArrayList<String> descarray= new ArrayList<>();
	for(int i=0;i<getVehpurchasegridlenght() ;i++){
		String temp2=requestParams.get("vehpurchasetest"+i)[0];
	// String temp2=request.getAttribute("enqtest"+i).toString();
	
		descarray.add(temp2);
	 
	}
	int val=vehpurchaseDAO.update(descarray,request,session,getPricetottal(),getHeadacccode(),getMasterdoc_no(),getVendorcurr(),getVendorrate(),docDate);
	if(val>0){
		 setHidvehpurorderDate(sqlStartDate.toString());
		setHidvehpurorderdelDate(sqlpurdeldate.toString());
		setHidvehpurinvDate(invDate.toString());
		setAccid(getAccid());
		setVehpuraccname(getVehpuraccname());
		setVehtypeval(getVehtype());
		setHeadacccode(getHeadacccode());
		setVehrefno(getVehrefno());
		setNettotal(getNettotal());
		setTranno(getTranno());
		setVehdesc(getVehdesc());
		setMasterdoc_no(getMasterdoc_no());
		setMasterrefno(getMasterrefno());
		setDocno(getDocno());
		setFleetupdateval(1);
		//setMsg("Successfully Saved");
		
		if(getMasterstatus()==1)
		{
		   setHidvehpurorderDate(sqlStartDate.toString());
			setHidvehpurorderdelDate(sqlpurdeldate.toString());
			setHidvehpurinvDate(invDate.toString());
			setAccid(getAccid());
			setVehpuraccname(getVehpuraccname());
			setVehtypeval(getVehtype());
			setHeadacccode(getHeadacccode());
			setVehrefno(getVehrefno());
			setNettotal(getNettotal());
			setVehdesc(getVehdesc());
		
			setHidjqxStartDate(sqldetDate.toString());
			
			setHiduptoDate(sqluptoDate.toString());
			
			setSecchaqueno(getSecchaqueno());
			setNameincheque(getNameincheque());
			setDealno(getDealno());
			setTxtdescription(getTxtdescription());
			setCalcuval(getCalcumethod());
			setFinaccdocno(getFinaccdocno());
			setBanckaccdocno(getBanckaccdocno());
		
			setInterestaccdocno(getInterestaccdocno());
			setLoanaccdocno(getLoanaccdocno());
			setPaymentval(getPaymentmethod());
			
			
			setTaxamount(getTaxamount());
			setTotalamt(getTotalamt());
			setDownpayment(getDownpayment());
			setLoanamount(getLoanamount());
			setChqamount(getChqamount());
			
			setPerinterest(getPerinterest());
			setInstnos(getInstnos());
			
			
			
			 setFinanceaccid(getFinanceaccid());
			 setFinanceaccname(getFinanceaccname());
			 setBankaccid(getBankaccid());
			 setBankaccname(getBankaccname());
			 setInterestaccid(getInterestaccid()); 
			 setIntaccname(getIntaccname());
			 setLoanaccid(getLoanaccid());
			 setLoanaccname(getLoanaccname());
			 setTranno(getTranno());
				setDetval(10);
		}
				//setDocno(getDocno());
		return "success";
	}
	else{
	//	setMsg("Not Saved");
		setFleetupdateval(2);
		setHidvehpurorderDate(sqlStartDate.toString());
		setHidvehpurorderdelDate(sqlpurdeldate.toString());
		setHidvehpurinvDate(invDate.toString());
		setAccid(getAccid());
		setVehpuraccname(getVehpuraccname());
		setVehtypeval(getVehtype());
		setHeadacccode(getHeadacccode());
		setVehrefno(getVehrefno());
		setNettotal(getNettotal());
		setVehdesc(getVehdesc());
		setDocno(getDocno());
		setMasterdoc_no(getMasterdoc_no());
		setMasterrefno(getMasterrefno());
		if(getMasterstatus()==1)
		{
			setTranno(getTranno());
		 setHidvehpurorderDate(sqlStartDate.toString());
			setHidvehpurorderdelDate(sqlpurdeldate.toString());
			setHidvehpurinvDate(invDate.toString());
			setAccid(getAccid());
			setVehpuraccname(getVehpuraccname());
			setVehtypeval(getVehtype());
			setHeadacccode(getHeadacccode());
			setVehrefno(getVehrefno());
			setNettotal(getNettotal());
			setVehdesc(getVehdesc());
		
			setHidjqxStartDate(sqldetDate.toString());
			
			setHiduptoDate(sqluptoDate.toString());
			
			setSecchaqueno(getSecchaqueno());
			setNameincheque(getNameincheque());
			setDealno(getDealno());
			setTxtdescription(getTxtdescription());
			setCalcuval(getCalcumethod());
			setFinaccdocno(getFinaccdocno());
			setBanckaccdocno(getBanckaccdocno());
		
			setInterestaccdocno(getInterestaccdocno());
			setLoanaccdocno(getLoanaccdocno());
			setPaymentval(getPaymentmethod());
			
			setTaxamount(getTaxamount());
			setTotalamt(getTotalamt());
			setDownpayment(getDownpayment());
			setLoanamount(getLoanamount());
			setChqamount(getChqamount());
			
			setPerinterest(getPerinterest());
			setInstnos(getInstnos());
			
			
			
			 setFinanceaccid(getFinanceaccid());
			 setFinanceaccname(getFinanceaccname());
			 setBankaccid(getBankaccid());
			 setBankaccname(getBankaccname());
			 setInterestaccid(getInterestaccid()); 
			 setIntaccname(getIntaccname());
			 setLoanaccid(getLoanaccid());
			 setLoanaccname(getLoanaccname());
			 setDetval(10);
		}
			//setDocno(getDocno());
		return "fail";
	}
}

else if(mode.equalsIgnoreCase("POS")){
	java.sql.Date sqldetDate = ClsCommon.changeStringtoSqlDate(getJqxStartDate());
	java.sql.Date sqluptoDate = ClsCommon.changeStringtoSqlDate(getUptoDate());
	ArrayList<String> descarray= new ArrayList<>();
	for(int i=0;i<getVehpurchasegridlenght() ;i++){
		String temp2=requestParams.get("vehpurchasetest"+i)[0];
	// String temp2=request.getAttribute("enqtest"+i).toString();
	
		descarray.add(temp2);
	 
	}
	int val=vehpurchaseDAO.postingupdate(sqlStartDate,descarray,request,session,getPricetottal(),getHeadacccode(),getMasterdoc_no(),getVendorcurr(),getVendorrate(),invDate,getInvno());
	if(val>0){
		 setHidvehpurorderDate(sqlStartDate.toString());
		setHidvehpurorderdelDate(sqlpurdeldate.toString());
		setHidvehpurinvDate(invDate.toString());
		setAccid(getAccid());
		setVehpuraccname(getVehpuraccname());
		setVehtypeval(getVehtype());
		setHeadacccode(getHeadacccode());
		setVehrefno(getVehrefno());
		setNettotal(getNettotal());
		setVehdesc(getVehdesc());
		setMasterdoc_no(getMasterdoc_no());
		setMasterrefno(getMasterrefno());
		setDocno(getDocno());
		setFleetupdateval(3);
		setTranno(getTranno());
		//setMsg("Updated Successfully");
		if(getMasterstatus()==1)
		{
		    setHidvehpurorderDate(sqlStartDate.toString());
			setHidvehpurorderdelDate(sqlpurdeldate.toString());
			setHidvehpurinvDate(invDate.toString());
			setAccid(getAccid());
			setVehpuraccname(getVehpuraccname());
			setVehtypeval(getVehtype());
			setHeadacccode(getHeadacccode());
			setVehrefno(getVehrefno());
			setNettotal(getNettotal());
			setVehdesc(getVehdesc());
		
			setHidjqxStartDate(sqldetDate.toString());
			
			setHiduptoDate(sqluptoDate.toString());
			
			setSecchaqueno(getSecchaqueno());
			setNameincheque(getNameincheque());
			setDealno(getDealno());
			setTxtdescription(getTxtdescription());
			setCalcuval(getCalcumethod());
			setFinaccdocno(getFinaccdocno());
			setBanckaccdocno(getBanckaccdocno());
		
			setInterestaccdocno(getInterestaccdocno());
			setLoanaccdocno(getLoanaccdocno());
			setPaymentval(getPaymentmethod());
			setDownpayment(getDownpayment());
			setLoanamount(getLoanamount());
			setChqamount(getChqamount());
			
			setPerinterest(getPerinterest());
			setInstnos(getInstnos());
			
			
			
			 setFinanceaccid(getFinanceaccid());
			 setFinanceaccname(getFinanceaccname());
			 setBankaccid(getBankaccid());
			 setBankaccname(getBankaccname());
			 setInterestaccid(getInterestaccid()); 
			 setIntaccname(getIntaccname());
			 setLoanaccid(getLoanaccid());
			 setLoanaccname(getLoanaccname());
			 setDetval(10);
			 
		}
			 
			 
		return "success";
	}
	else{
	//	setMsg("Not Saved");
		setFleetupdateval(4);
		setHidvehpurorderDate(sqlStartDate.toString());
		setHidvehpurorderdelDate(sqlpurdeldate.toString());
		setHidvehpurinvDate(invDate.toString());
		setAccid(getAccid());
		setVehpuraccname(getVehpuraccname());
		setVehtypeval(getVehtype());
		setHeadacccode(getHeadacccode());
		setVehrefno(getVehrefno());
		setNettotal(getNettotal());
		setVehdesc(getVehdesc());
		setDocno(getDocno());
		setMasterdoc_no(getMasterdoc_no());
		setMasterrefno(getMasterrefno());
		setTranno(getTranno());
		//setMsg("Not Updated Please sadfkjhasdifb");
		if(getMasterstatus()==1)
		{
		    setHidvehpurorderDate(sqlStartDate.toString());
			setHidvehpurorderdelDate(sqlpurdeldate.toString());
			setHidvehpurinvDate(invDate.toString());
			setAccid(getAccid());
			setVehpuraccname(getVehpuraccname());
			setVehtypeval(getVehtype());
			setHeadacccode(getHeadacccode());
			setVehrefno(getVehrefno());
			setNettotal(getNettotal());
			setVehdesc(getVehdesc());
		
			setHidjqxStartDate(sqldetDate.toString());
			
			setHiduptoDate(sqluptoDate.toString());
			
			setSecchaqueno(getSecchaqueno());
			setNameincheque(getNameincheque());
			setDealno(getDealno());
			setTxtdescription(getTxtdescription());
			setCalcuval(getCalcumethod());
			setFinaccdocno(getFinaccdocno());
			setBanckaccdocno(getBanckaccdocno());
		
			setInterestaccdocno(getInterestaccdocno());
			setLoanaccdocno(getLoanaccdocno());
			setPaymentval(getPaymentmethod());
			setDownpayment(getDownpayment());
			setLoanamount(getLoanamount());
			setChqamount(getChqamount());
			
			setPerinterest(getPerinterest());
			setInstnos(getInstnos());
			
			
			
			 setFinanceaccid(getFinanceaccid());
			 setFinanceaccname(getFinanceaccname());
			 setBankaccid(getBankaccid());
			 setBankaccname(getBankaccname());
			 setInterestaccid(getInterestaccid()); 
			 setIntaccname(getIntaccname());
			 setLoanaccid(getLoanaccid());
			 setLoanaccname(getLoanaccname());
			 setDetval(10);
		}	 
			 
		return "fail";
	}
}
//----------------------------------------------------------

else if(mode.equalsIgnoreCase("ADD")){
	
		java.sql.Date sqldetDate = ClsCommon.changeStringtoSqlDate(getJqxStartDate());
		java.sql.Date sqluptoDate = ClsCommon.changeStringtoSqlDate(getUptoDate());
		
		
		
	ArrayList<String> detarray= new ArrayList<>();
	for(int i=0;i<getDistributionlenght() ;i++){
		String temp2=requestParams.get("dettest"+i)[0];
	// String temp2=request.getAttribute("enqtest"+i).toString();
	
		detarray.add(temp2);
		//getDistributionlenght() ,  dettest
	 
	}
//	System.out.println("-----------"+detarray);
	int val=vehpurchaseDAO.detupdate(getDealno(),getMasterdoc_no(),sqldetDate,getSecchaqueno(),getNameincheque(),getTxtdescription(),getCalcumethod(),
			getFinaccdocno(),getBanckaccdocno(),getInterestaccdocno(), getLoanaccdocno(),getPaymentmethod(), getTaxamount(), getTotalamt(), getDownpayment(),
			getLoanamount(),getChqamount(),detarray,request,getPerinterest(),getInstnos(),session,getBankcurrency(),getIntercurrency(),
			getLoancurrecy(),getBankrate(),getInterrate(),getLoanrate(),sqluptoDate,getVehdesc());
	if(val>0){
		
		// getCalcuval()  getPaymentval()
		
		 setHidvehpurorderDate(sqlStartDate.toString());
		setHidvehpurorderdelDate(sqlpurdeldate.toString());
		setHidvehpurinvDate(invDate.toString());
		setAccid(getAccid());
		setVehpuraccname(getVehpuraccname());
		setVehtypeval(getVehtype());
		setHeadacccode(getHeadacccode());
		setVehrefno(getVehrefno());
		setNettotal(getNettotal());
		setVehdesc(getVehdesc());
		setMasterdoc_no(getMasterdoc_no());
		setMasterrefno(getMasterrefno());
		setHidjqxStartDate(sqldetDate.toString());
		
		setHiduptoDate(sqluptoDate.toString());
		
		setSecchaqueno(getSecchaqueno());
		setNameincheque(getNameincheque());
		setDealno(getDealno());
		//setNameincheque(getNameincheque());
		
		setTxtdescription(getTxtdescription());
		setCalcuval(getCalcumethod());
		setFinaccdocno(getFinaccdocno());
		setBanckaccdocno(getBanckaccdocno());
	
		setInterestaccdocno(getInterestaccdocno());
		setLoanaccdocno(getLoanaccdocno());
		setPaymentval(getPaymentmethod());
		setDownpayment(getDownpayment());
		setLoanamount(getLoanamount());
		setChqamount(getChqamount());
		
		setPerinterest(getPerinterest());
		setInstnos(getInstnos());
		
		
		
		 setFinanceaccid(getFinanceaccid());
		 setFinanceaccname(getFinanceaccname());
		 setBankaccid(getBankaccid());
		 setBankaccname(getBankaccname());
		 setInterestaccid(getInterestaccid()); 
		 setIntaccname(getIntaccname());
		 setLoanaccid(getLoanaccid());
		 setLoanaccname(getLoanaccname());
		 setTranno(getTranno());
		setDocno(getDocno());
		setDetval(10);
		setMasterstatus(1);
		//setMsg("Successfully Saved");
		return "success";
	}
	else{
	//	setMsg("Not Saved");
		setDetval(11);
		setHidvehpurorderDate(sqlStartDate.toString());
		setHidvehpurorderdelDate(sqlpurdeldate.toString());
		setHidvehpurinvDate(invDate.toString());
		setAccid(getAccid());
		setVehpuraccname(getVehpuraccname());
		setVehtypeval(getVehtype());
		setHeadacccode(getHeadacccode());
		setVehrefno(getVehrefno());
		setNettotal(getNettotal());
		setVehdesc(getVehdesc());
		
		setMasterdoc_no(getMasterdoc_no());
		setMasterrefno(getMasterrefno());
		setHiduptoDate(sqluptoDate.toString());
		
		setDealno(getDealno());
		
		setHidjqxStartDate(sqldetDate.toString());
		setSecchaqueno(getSecchaqueno());
		setNameincheque(getNameincheque());
		setDealno(getDealno());
		setTxtdescription(getTxtdescription());
		setCalcuval(getCalcumethod());
		setFinaccdocno(getFinaccdocno());
		setBanckaccdocno(getBanckaccdocno());
	
		setInterestaccdocno(getInterestaccdocno());
		setLoanaccdocno(getLoanaccdocno());
		setPaymentval(getPaymentmethod());
		setDownpayment(getDownpayment());
		setLoanamount(getLoanamount());
		setChqamount(getChqamount());
		
		
		setTranno(getTranno());
		 setFinanceaccid(getFinanceaccid());
		 setFinanceaccname(getFinanceaccname());
		 setBankaccid(getBankaccid());
		 setBankaccname(getBankaccname());
		 setInterestaccid(getInterestaccid()); 
		 setIntaccname(getIntaccname());
		 setLoanaccid(getLoanaccid());
		 setLoanaccname(getLoanaccname());
		
		setPerinterest(getPerinterest());
		setInstnos(getInstnos());
		setDocno(getDocno());

		return "fail";
	}
}
	/*else if(mode.equalsIgnoreCase("E")){
		ArrayList<String> descarray= new ArrayList<>();
		for(int i=0;i<getVehpurchasegridlenght();i++){
			String temp2=requestParams.get("vehpurchasetest"+i)[0];
		// String temp2=request.getAttribute("enqtest"+i).toString();
		
			descarray.add(temp2);
			
		}
		boolean Status=vehpurchaseDAO.edit(getDocno(),sqlStartDate,sqlpurdeldate,invDate,getHeadacccode(),getVehtype(),getVehrefno(),getNettotal(),getVehdesc(),session,getMode(),getFormdetailcode(),descarray,getInvno());
		if(Status){
			
			 setHidvehpurorderDate(sqlStartDate.toString());
				setHidvehpurorderdelDate(sqlpurdeldate.toString());
				setHidvehpurinvDate(invDate.toString());
				setAccid(getAccid());
				setVehpuraccname(getVehpuraccname());
				setVehtypeval(getVehtype());
				setHeadacccode(getHeadacccode());
				setVehrefno(getVehrefno());
				setNettotal(getNettotal());
				setVehdesc(getVehdesc());
			    setDocno(getDocno());
		
			setMsg("Updated Successfully");
			return "success";
		
		}
		else{
			 setHidvehpurorderDate(sqlStartDate.toString());
				setHidvehpurorderdelDate(sqlpurdeldate.toString());
				setHidvehpurinvDate(invDate.toString());
				setAccid(getAccid());
				setVehpuraccname(getVehpuraccname());
				setVehtypeval(getVehtype());
				setHeadacccode(getHeadacccode());
				setVehrefno(getVehrefno());
				setNettotal(getNettotal());
				setVehdesc(getVehdesc());
			    setDocno(getDocno());
			setMsg("Not Updated");
			return "fail";
		}
	}
else if(mode.equalsIgnoreCase("D")){
		boolean Status=vehpurchaseDAO.delete(getDocno(),session,getMode(),getFormdetailcode());
	if(Status){
		 setHidvehpurorderDate(sqlStartDate.toString());
			setHidvehpurorderdelDate(sqlpurdeldate.toString());
			setHidvehpurinvDate(invDate.toString());
			setAccid(getAccid());
			setVehpuraccname(getVehpuraccname());
			setVehtypeval(getVehtype());
			setHeadacccode(getHeadacccode());
			setVehrefno(getVehrefno());
			setNettotal(getNettotal());
			setVehdesc(getVehdesc());
			setDocno(getDocno());
		setDeleted("DELETED");
		setMsg("Successfully Deleted");
		return "success";
	}
	else{
		
			setAccid(getAccid());
			setVehpuraccname(getVehpuraccname());
			setVehtypeval(getVehtype());
			setHeadacccode(getHeadacccode());
			setVehrefno(getVehrefno());
			setNettotal(getNettotal());
			setVehdesc(getVehdesc());
			setDocno(getDocno());
		setMsg("Not Deleted");
		return "fail";

		
	}

}*/
else if(mode.equalsIgnoreCase("view")){
	     setHidvehpurorderDate(sqlStartDate.toString());
		setHidvehpurorderdelDate(sqlpurdeldate.toString());
		setHidvehpurinvDate(invDate.toString());

	
		//String branch=null;
		
		bean=vehpurchaseDAO.getViewDetails(session,getMasterdoc_no());
		
		setTaxamount(bean.getTaxamount());
		setTotalamt(bean.getTotalamt());
		
		setRestructure(bean.getRestructure());
		setHidjqxStartDate(bean.getJqxStartDate());
		
		setHiduptoDate(bean.getUptoDate());
		
		setSecchaqueno(bean.getSecchaqueno());
		setNameincheque(bean.getNameincheque());
		setTxtdescription(bean.getTxtdescription());
		setCalcuval(bean.getCalcumethod());
		setFinaccdocno(bean.getFinaccdocno());
		setBanckaccdocno(bean.getBanckaccdocno());
	
		setInterestaccdocno(bean.getInterestaccdocno());
		setLoanaccdocno(bean.getLoanaccdocno());
		setPaymentval(bean.getPaymentmethod());
		setDownpayment(bean.getDownpayment());
		setLoanamount(bean.getLoanamount());
		setChqamount(bean.getChqamount());
		
		setDealno(bean.getDealno());

		 setFinanceaccid(bean.getFinanceaccid());
		 setFinanceaccname(bean.getFinanceaccname());
		 setBankaccid(bean.getBankaccid());
		 setBankaccname(bean.getBankaccname());
		 setInterestaccid(bean.getInterestaccid()); 
		 setIntaccname(bean.getIntaccname());
		 setLoanaccid(bean.getLoanaccid());
		 setLoanaccname(bean.getLoanaccname());
		
		setPerinterest(bean.getPerinterest());
		setInstnos(bean.getInstnos());
		setDetval(bean.getDetval());
		setTranno(getTranno());
		//System.out.println("-------bean.getDetval()----"+bean.getDetval());
		
		setClstatus(bean.getClstatus());
		setMasterstatus(bean.getMasterstatus());
		// masterBean.setMasterstatus(1);
	
		return "success";
	}
  

return "fail";	

}
	
	
	public String printAction() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		int doc=Integer.parseInt(request.getParameter("docno"));
		String dtype=request.getParameter("dtype").toString();
		setUrl(ClsCommon.getPrintPath(dtype));
			
		 pintbean=vehpurchaseDAO.getPrint(doc,request);
		// ArrayList<String> arraylist = ClsvehpurchaseDAO.getPrintdetails(doc);
		 
		
		  //cl details

		 setLblprintname("Tax Equipment Purchase");
		    setLbldoc(pintbean.getLbldoc());
	    setLbldate(pintbean.getLbldate());
	    setLbltype(pintbean.getLbltype());
	    setLbldesc1(pintbean.getLbldesc1());
	    
	    setExpdeldate(pintbean.getExpdeldate());
	    

		
		 setLblvendoeacc(pintbean.getLblvendoeacc());
		 setLblvendoeaccName(pintbean.getLblvendoeaccName());
		
	  setLblbranch(pintbean.getLblbranch());
	   setLblcompname(pintbean.getLblcompname());
	  
	  setLblcompaddress(pintbean.getLblcompaddress());
	 
	   setLblcomptel(pintbean.getLblcomptel());
	  setLblcomptrn(pintbean.getLblcomptrn());
	  setLblclienttrn(pintbean.getLblclienttrn());
	  setLblcompfax(pintbean.getLblcompfax());
	   setLbllocation(pintbean.getLbllocation());
	  setLbltotal(pintbean.getLbltotal());
	  setLbltax(pintbean.getLbltax());
	  setLblnettotal(pintbean.getLblnettotal());
	  
	  setLblinvno(pintbean.getLblinvno());
	  setLblpurchaseDate(pintbean.getLblpurchaseDate());
	  

	  //----------------------------------
	  
	  setLblstartdate(pintbean.getLblstartdate());
		setLbluptodate(pintbean.getLbluptodate());
		
		
		setLbldownpayment(pintbean.getLbldownpayment());
		setLblloanamt(pintbean.getLblloanamt());
		setLblsecucqNo(pintbean.getLblsecucqNo());
		setLblnameinchq(pintbean.getLblnameinchq());
		setLblDesc(pintbean.getLblDesc());
		
		setLblcalcumethod(pintbean.getLblcalcumethod());
		
	
		
		setLblpayval(pintbean.getLblpayval());
		
	
		setLblanamt(pintbean.getLblanamt());
		
		//setLblfinacc setLblfinaccName setLblbankacc setLblbankaccName setLblintacc getLblintaccName getLblloanacc setLblloanaccName

		setLblfinacc(pintbean.getLblfinacc());
		setLblfinaccName(pintbean.getLblfinaccName());
		setLblbankacc(pintbean.getLblbankacc());
		setLblbankaccName(pintbean.getLblbankaccName());
		setLblintacc(pintbean.getLblintacc()); 
		setLblintaccName(pintbean.getLblintaccName());
		setLblloanacc(pintbean.getLblloanacc());
		setLblloanaccName(pintbean.getLblloanaccName());
		
		setLblperinterst(pintbean.getLblperinterst());
		setLblnoofinst(pintbean.getLblnoofinst());
		

		setFirstarray(pintbean.getFirstarray());
		
		
		
		 setLblpricitotalamount(pintbean.getLblpricitotalamount());
		 setLblinttotalamount(pintbean.getLblinttotalamount());
		 setLbltotalgridamount(pintbean.getLbltotalgridamount());
		 setLbltotalint(pintbean.getLbltotalint());
	
		
	//	System.out.println("-------"+pintbean.getAmountinwords());
		 
		setAmountinwords(pintbean.getAmountinwords());
		
		 return "print";
		 }	
	
	
}
