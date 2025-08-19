package com.operations.agreement.rentalagreement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.common.ClsAmountToWords;

import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.text.SimpleDateFormat;
import java.util.Date;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.vehicletransactions.vehicleinspection.ClsVehicleInspectionBean;
import com.operations.vehicletransactions.vehicleinspection.ClsVehicleInspectionDAO;


 

 
public class ClsRentalAgreementAction {
	ClsRentalAgreementDAO rentalAgmtDAO= new ClsRentalAgreementDAO();
	ClsVehicleInspectionDAO inspDAO= new ClsVehicleInspectionDAO();
	ClsVehicleInspectionBean inspbean=new ClsVehicleInspectionBean();
	ClsConnection conobj=new ClsConnection();
	ClsCommon commonDAO=new ClsCommon();
	
	
	ClsRentalAgreementBean RentalAgreementBean;
	ClsRentalAgreementBean bean;
	//  main 

	private String vehauth,branchwisname;
	
	private String rentalproject,hidrentalproject;
		private String lbldesc,lblauthority;
		private double totaltot,rentaltotals;
		
		public double getRentaltotals() {
			return rentaltotals;
		}

		public void setRentaltotals(double rentaltotals) {
			this.rentaltotals = rentaltotals;
		}
		
		public String getLblauthority() {
			return lblauthority;
		}

		public void setLblauthority(String lblauthority) {
			this.lblauthority = lblauthority;
		}
		public double getTotaltot() {
			return totaltot;
		}

		public void setTotaltot(double totaltot) {
			this.totaltot = totaltot;
		}
	public String getLbldesc() {
		return lbldesc;
	}

	public void setLbldesc(String lbldesc) {
		this.lbldesc = lbldesc;
	}

	
	public String getRentalproject() {
		return rentalproject;
	}

	public void setRentalproject(String rentalproject) {
		this.rentalproject = rentalproject;
	}

	public String getHidrentalproject() {
		return hidrentalproject;
	}

	public void setHidrentalproject(String hidrentalproject) {
		this.hidrentalproject = hidrentalproject;
	}

	private String cardtype;
	private int docno;
	private String jqxRentalDate;
	private String hidjqxRentalDate;
	// veh
	private String  txtfleetno;	
	private String vehlocation;
	// client
	private String txtcusid;
	private int re_salmanid;
	private String re_clcodeno;
	private String re_clacno;
	private String rentaldesc;
	// chauffeur select
	private int additional_driver;
	private String adidrvcharges,inspdoc;
	private int delivery_chk;
	private int radrivercheck;
	private String lblclientrn;
	private int del_chaufferid,configmethod;
	
	//client driver
	private String client_driverid;
	
	// driver grid
	
	private int drivergridlength,specialdiscountuser;

	  //  tariff grid
	private int tariffgridlength;


	 // tariff main
	 private String ratariffsystem;
	 private String ratariffdocno1;
	 private String invoice;
	 private String excessinsur;
	 private String veh_fleetgrouptariff;
	 
	 // tariff sub
	 private String re_Km;
	 private String ratariff_fuel;
	
	
	 private int tariffsales_Agentid;
	 private int tariffrenral_Agentid;
	 private String jqxDateOut;  //out date
	 private String hidjqxDateOut;
	 private String jqxTimeOut;   // out time
	 private String hidjqxTimeOut;
	 private String ratariff_checkout;
	 private int ratariff_checkoutid;
	 private String jqxOnDate;   // due date
	 private String hidjqxOnDate;
	 private String jqxOnTime;   // due time
	 private String hidjqxOnTime;
	 
	 // payment grid
	 private int paymentgridlength;

	 // payment sub
	 private String payment_Mra,checkbranch;
	 private String payment_PO;
	 private String payment_Conveh;// original fleet
	 
	  // delivery driver
	 
	 private String del_KM;
	 private String del_Fuel;
	 private String jqxDeliveryOut;
	 private String hidjqxDeliveryOut;
	 private String jqxDelTimeOut;
	 private String hidjqxDelTimeOut;
	
	 // hidden
	 private String rentaltype; 
	 private String mode;
	 private String deleted,formdetailcode,hidvehfuel,delcharges,signpath;
	 
	 //==================================================
	 
	 // for reload
	 
	 // all
	 private String vehdetails;
	 private String client_Name;
	 private String re_salman;
	 private String radriverlist;
	 private String rasales_Agent;
	 private String rarenral_Agent;
	 private String cusaddress;
	 
	 private int delchkvalue;
	 private int chaffchkvalue;
	 private int add_drchk;
	 private String lblpassissdate;
	 
	 
	 public String getLblclientrn() {
		return lblclientrn;
	}

	public void setLblclientrn(String lblclientrn) {
		this.lblclientrn = lblclientrn;
	}

	public String getLblpassissdate() {
		return lblpassissdate;
	}

	public void setLblpassissdate(String lblpassissdate) {
		this.lblpassissdate = lblpassissdate;
	}
	  private String lblvisaexp;
		
	public String getLblvisaexp() {
		return lblvisaexp;
	}

	public void setLblvisaexp(String lblvisaexp) {
		this.lblvisaexp = lblvisaexp;
	}

	//
	 private String del_Driver;
	 private String del_chaufferid2;
	 //
	 private String systemval;
	 private String invoval;
	 
	 private int masterdoc_no;
	 //=========================================================
	 private String hiddel_Fuel;
	/* private String */
	
	 //////////////////////////////////////////////////// advance new
	 
	private int  advance_chkval;
	private int advance_chk;
	 
	 private String msg,rentalstatus;
	 
	 private String url; 
	 
	 private String brchName;
	// -----------------------------------------------------------------------------------------------------------------------------------------------------

	 private String clname,claddress,clmobno,clemail,barnchval,mrano,rentaldoc,radrname,radlno,passno,licexpdate,passexpdate,dobdate;
	 
	 
	private String ravehname,ravehregno,ravehmodel,ravehgroup,radateout,ratimeout,raklmout,excessinsu;  
	 
	 
	 private String radaily,raweakly,ramonthly,tariff,racdwscdw,raaccessory,rarentserdue,raadditionalcge,rafuelout,totalpaids,invamount,balance,rasupercdw,ravmd;
	 
	

	private String inkm,infuel,indate,intime,docnoval,rastatus,rayom,racolor,adddrname1,adddrname2,addlicno1,addlicno2,expdate1,expdate2,adddob1,adddob2,raextrakm,raexxtakmchg,rarenttypes;
		private String companyname,address,mobileno,fax,location;
	
		private String deldates,deltimes,delkmins,delfuels;
		private String coldates,coltimes,colkmins,colfuels;
		
		private String outdetails,deldetailss;
		
		private String indetails,coldetails;
		
		private String salikcharge,trafficcharge,totalsalikandtraffic;
		
		private String ldllandno ;
		
		private String lblnation,lblissfromdate,lblissby,lblidno,lblpassissued;
		
		private String lbladdpassno1,lbladdpassexp1,lbladdnation1,lbladdissby1,lbladdissfrom1,lbladdid1,lbladdpassissued1;
		
		
		private String lblcompwebsite,lblcompmail;
		private Map<String, Object> param = null;
public Map<String, Object> getParam() {
			return param;
		}

		public void setParam(Map<String, Object> param) {
			this.param = param;
		}

		//mm
		private String lbltel1,lbltel2, duedate, salagent ,raagent, salname,duetime,createdate ;
			
		
		
		
		
	//yeti=======	
		
		private String securitycardno,securityexpdate,securitypreauthno,securitypreauthamt,tarifftotal,racdwscdwtotal,raaccessorytotal,laldelchargetotal, advtotalamont,advpaidamount,advbalance;
		
	//-----------------	
		
		private String ch_no;
		
	//---------print----------//
		private String rayear,ravehplate,lblnofdays,lbltraficfine,lblsalik,lblrentaldesc,lblrentaltype,lblrentalrate,lblcldocno,lbluser,lblcurrentdate;
		private String ravehauthregno;
		
		
				private String lbldeldate;
				private String lbldeltime;
				private String lbldelkm;
				private String lbldelfuel;
				private String lblcollectdate;
				private String lblcollecttime;
				private String lblcollectkm;
				private String lblcollectfuel;
				private String lblvisaissdate;
				
				
				public String getLblvisaissdate() {
					return lblvisaissdate;
				}

				public void setLblvisaissdate(String lblvisaissdate) {
					this.lblvisaissdate = lblvisaissdate;
				}

				public String getLbldeldate() {
					return lbldeldate;
				}

				public void setLbldeldate(String lbldeldate) {
					this.lbldeldate = lbldeldate;
				}

				public String getLbldeltime() {
					return lbldeltime;
				}

				public void setLbldeltime(String lbldeltime) {
					this.lbldeltime = lbldeltime;
				}

				public String getLbldelkm() {
					return lbldelkm;
				}

				public void setLbldelkm(String lbldelkm) {
					this.lbldelkm = lbldelkm;
				}

				public String getLbldelfuel() {
					return lbldelfuel;
				}

				public void setLbldelfuel(String lbldelfuel) {
					this.lbldelfuel = lbldelfuel;
				}

				public String getLblcollectdate() {
					return lblcollectdate;
				}

				public void setLblcollectdate(String lblcollectdate) {
					this.lblcollectdate = lblcollectdate;
				}

				public String getLblcollecttime() {
					return lblcollecttime;
				}

				public void setLblcollecttime(String lblcollecttime) {
					this.lblcollecttime = lblcollecttime;
				}

				public String getLblcollectkm() {
					return lblcollectkm;
				}

				public void setLblcollectkm(String lblcollectkm) {
					this.lblcollectkm = lblcollectkm;
				}

				public String getLblcollectfuel() {
					return lblcollectfuel;
				}

				public void setLblcollectfuel(String lblcollectfuel) {
					this.lblcollectfuel = lblcollectfuel;
				}
				
		
		
	public String getRavehauthregno() {
			return ravehauthregno;
		}
		public void setRavehauthregno(String ravehauthregno) {
			this.ravehauthregno = ravehauthregno;
		}
				
	public String getLblcurrentdate() {
			return lblcurrentdate;
		}
		public void setLblcurrentdate(String lblcurrentdate) {
			this.lblcurrentdate = lblcurrentdate;
		}	
	public String getLbluser() {
			return lbluser;
		}
		public void setLbluser(String lbluser) {
			this.lbluser = lbluser;
		}
	public String getLblcldocno() {
			return lblcldocno;
		}
		public void setLblcldocno(String lblcldocno) {
			this.lblcldocno = lblcldocno;
		}
	public String getLblrentaltype() {
			return lblrentaltype;
		}
		public void setLblrentaltype(String lblrentaltype) {
			this.lblrentaltype = lblrentaltype;
		}
		public String getLblrentalrate() {
			return lblrentalrate;
		}
		public void setLblrentalrate(String lblrentalrate) {
			this.lblrentalrate = lblrentalrate;
		}
	public String getLblrentaldesc() {
			return lblrentaldesc;
		}
		public void setLblrentaldesc(String lblrentaldesc) {
			this.lblrentaldesc = lblrentaldesc;
		}
	public String getLbltraficfine() {
			return lbltraficfine;
		}
		public void setLbltraficfine(String lbltraficfine) {
			this.lbltraficfine = lbltraficfine;
		}
		public String getLblsalik() {
			return lblsalik;
		}
		public void setLblsalik(String lblsalik) {
			this.lblsalik = lblsalik;
		}
	public String getLblnofdays() {
			return lblnofdays;
		}
		public void setLblnofdays(String lblnofdays) {
			this.lblnofdays = lblnofdays;
		}
	public String getRavehplate() {
			return ravehplate;
		}
		public void setRavehplate(String ravehplate) {
			this.ravehplate = ravehplate;
		}
	public String getDuetime() {
			return duetime;
		}
		public void setDuetime(String duetime) {
			this.duetime = duetime;
		}
	public String getSalname() { 
			return salname;   
		}
		public void setSalname(String salname) {
			this.salname = salname;
		}	
		
		
		
	 public int getSpecialdiscountuser() {
		 return specialdiscountuser;
		}
		public void setSpecialdiscountuser(int specialdiscountuser) {
			this.specialdiscountuser = specialdiscountuser;
		}
						public String getDuedate() {
			return duedate;
		}
		public void setDuedate(String duedate) {
			this.duedate = duedate;
		}
		
		
		
		
		public String getCreatedate() {
			return createdate;
		}
		public void setCreatedate(String createdate) {
			this.createdate = createdate;
		}
		
		
		
		
		
		public String getSalagent() {
			return salagent;
		}
		public void setSalagent(String salagent) {
			this.salagent = salagent;
		}
		public String getRaagent() {
			return raagent;
		}
		public void setRaagent(String raagent) {
			this.raagent = raagent;
		}
						public String getCheckbranch() {
			return checkbranch;
		}
		public void setCheckbranch(String checkbranch) {
			this.checkbranch = checkbranch;
		}
						public String getRasupercdw() {
			return rasupercdw;
		}
		public void setRasupercdw(String rasupercdw) {
			this.rasupercdw = rasupercdw;
		}


 
						public String getRavmd() {
			return ravmd;
		}
		public void setRavmd(String ravmd) {
			this.ravmd = ravmd;
		}
		 public String getRarentserdue() {
				return rarentserdue;
			}
			public void setRarentserdue(String rarentserdue) {
				this.rarentserdue = rarentserdue;
			}
						public String getLbltel1() {
					return lbltel1;
				}
				public void setLbltel1(String lbltel1) {
					this.lbltel1 = lbltel1;
				}
				public String getLbltel2() {
					return lbltel2;
				}
				public void setLbltel2(String lbltel2) {
					this.lbltel2 = lbltel2;
				}
				public String getLblidno() {
					return lblidno;
				}
				public void setLblidno(String lblidno) {
					this.lblidno = lblidno;
				}
		         public String getLblpassissued() {
					return lblpassissued;
				}
				public void setLblpassissued(String lblpassissued) {
					this.lblpassissued = lblpassissued;
				}
				public String getLbladdpassno1() {
					return lbladdpassno1;
				}
				public void setLbladdpassno1(String lbladdpassno1) {
					this.lbladdpassno1 = lbladdpassno1;
				}
				public String getLbladdpassexp1() {
					return lbladdpassexp1;
				}
				public void setLbladdpassexp1(String lbladdpassexp1) {
					this.lbladdpassexp1 = lbladdpassexp1;
				}
				public String getLbladdnation1() {
					return lbladdnation1;
				}
				public void setLbladdnation1(String lbladdnation1) {
					this.lbladdnation1 = lbladdnation1;
				}
				public String getLbladdissby1() {
					return lbladdissby1;
				}
				public void setLbladdissby1(String lbladdissby1) {
					this.lbladdissby1 = lbladdissby1;
				}
				public String getLbladdissfrom1() {
					return lbladdissfrom1;
				}
				public void setLbladdissfrom1(String lbladdissfrom1) {
					this.lbladdissfrom1 = lbladdissfrom1;
				}
				public String getLbladdid1() {
					return lbladdid1;
				}
				public void setLbladdid1(String lbladdid1) {
					this.lbladdid1 = lbladdid1;
				}
				public String getLbladdpassissued1() {
					return lbladdpassissued1;
				}
				public void setLbladdpassissued1(String lbladdpassissued1) {
					this.lbladdpassissued1 = lbladdpassissued1;
				}
		
		  public String getLblcompwebsite() {
					return lblcompwebsite;
				}
				public void setLblcompwebsite(String lblcompwebsite) {
					this.lblcompwebsite = lblcompwebsite;
				}
				public String getLblcompmail() {
					return lblcompmail;
				}
				public void setLblcompmail(String lblcompmail) {
					this.lblcompmail = lblcompmail;
				}
				
				
		 public String getLblnation() {
					return lblnation;
				}
				public void setLblnation(String lblnation) {
					this.lblnation = lblnation;
				}
				public String getLblissfromdate() {
					return lblissfromdate;
				}
				public void setLblissfromdate(String lblissfromdate) {
					this.lblissfromdate = lblissfromdate;
				}
				public String getLblissby() {
					return lblissby;
				}
				public void setLblissby(String lblissby) {
					this.lblissby = lblissby;
				}
				
	 // rental status for open or close
		
/*		private String lbldrmobno,lbldrmobno1,lblplaceissue,lblplaceissue1,passno1,lbpassexpdate,lbpassexpdate1;


		private String  lbfueltype,lbmodel,kmused,noofdays,pertel,faxno;

		private String lbmasterdate,lbexpcarddate,lbsecurity;*/
		
		/*public String getLbldrmobno() {
			return lbldrmobno;
		}
		public void setLbldrmobno(String lbldrmobno) {
			this.lbldrmobno = lbldrmobno;
		}
		public String getLbldrmobno1() {
			return lbldrmobno1;
		}
		public void setLbldrmobno1(String lbldrmobno1) {
			this.lbldrmobno1 = lbldrmobno1;
		}
		public String getLblplaceissue() {
			return lblplaceissue;
		}
		public void setLblplaceissue(String lblplaceissue) {
			this.lblplaceissue = lblplaceissue;
		}
		public String getLblplaceissue1() {
			return lblplaceissue1;
		}
		public void setLblplaceissue1(String lblplaceissue1) {
			this.lblplaceissue1 = lblplaceissue1;
		}
		public String getPassno1() {
			return passno1;
		}
		public void setPassno1(String passno1) {
			this.passno1 = passno1;
		}
		public String getLbpassexpdate() {
			return lbpassexpdate;
		}
		public void setLbpassexpdate(String lbpassexpdate) {
			this.lbpassexpdate = lbpassexpdate;
		}
		public String getLbpassexpdate1() {
			return lbpassexpdate1;
		}
		public void setLbpassexpdate1(String lbpassexpdate1) {
			this.lbpassexpdate1 = lbpassexpdate1;
		}
		public String getLbfueltype() {
			return lbfueltype;
		}
		public void setLbfueltype(String lbfueltype) {
			this.lbfueltype = lbfueltype;
		}
		public String getLbmodel() {
			return lbmodel;
		}
		public void setLbmodel(String lbmodel) {
			this.lbmodel = lbmodel;
		}
		public String getKmused() {
			return kmused;
		}
		public void setKmused(String kmused) {
			this.kmused = kmused;
		}
		public String getNoofdays() {
			return noofdays;
		}
		public void setNoofdays(String noofdays) {
			this.noofdays = noofdays;
		}
		public String getPertel() {
			return pertel;
		}
		public void setPertel(String pertel) {
			this.pertel = pertel;
		}
		public String getFaxno() {
			return faxno;
		}
		public void setFaxno(String faxno) {
			this.faxno = faxno;
		}
		public String getLbmasterdate() {
			return lbmasterdate;
		}
		public void setLbmasterdate(String lbmasterdate) {
			this.lbmasterdate = lbmasterdate;
		}
		public String getLbexpcarddate() {
			return lbexpcarddate;
		}
		public void setLbexpcarddate(String lbexpcarddate) {
			this.lbexpcarddate = lbexpcarddate;
		}
		public String getLbsecurity() {
			return lbsecurity;
		}
		public void setLbsecurity(String lbsecurity) {
			this.lbsecurity = lbsecurity;
		}*/
	/*	public int getFirstarray() {
			return firstarray;
		}
		public void setFirstarray(int firstarray) {
			this.firstarray = firstarray;
		}


		private int firstarray;*/
		
//---------------------------------------------------------------------------------------------------------------------------------------------------------	 
			//Closing Summary Print
				private String branchname;
			
				private String lblclientname;
				private String lblfleetno;
				private String lblfleetname;
				private String lbldateout;
				private String lbltimeout;
				private String lblkmout;
				private String lblfuelout;
				private String lbldatein;
				private String lbltimein;
				private String lblkmin;
				private String lblfuelin;
				
				private String lblsumotherdebit;
				private String lblsumothercredit;
				private String lblsumcrvdebit;
				private String lblsumcrvcredit;
				private String lblnetbalance;
		
		
		
		
		         public int getConfigmethod() {
					return configmethod;
				}
				public void setConfigmethod(int configmethod) {
					this.configmethod = configmethod;
				}
				//---------------------------------------------------
				public int getMasterdoc_no() {
					return masterdoc_no;
				}
				public void setMasterdoc_no(int masterdoc_no) {
					this.masterdoc_no = masterdoc_no;
				}
			
				public String getOutdetails() {
					return outdetails;
				}
			
				public String getUrl() {
					return url;
				}
				public void setUrl(String url) {
					this.url = url;
				}
				public String getIndetails() {
					return indetails;
				}
				public void setIndetails(String indetails) {
					this.indetails = indetails;
				}
				public String getColdetails() {
					return coldetails;
				}
				public void setColdetails(String coldetails) {
					this.coldetails = coldetails;
				}
				public void setOutdetails(String outdetails) {
					this.outdetails = outdetails;
				}
				public String getDeldetailss() {
					return deldetailss;
				}
				public void setDeldetailss(String deldetailss) {
					this.deldetailss = deldetailss;
				}
				public String getBranchname() {
					return branchname;
				}
				public void setBranchname(String branchname) {
					this.branchname = branchname;
				}
				public String getLblclientname() {
					return lblclientname;
				}
				public void setLblclientname(String lblclientname) {
					this.lblclientname = lblclientname;
				}
				public String getLblfleetno() {
					return lblfleetno;
				}
				public void setLblfleetno(String lblfleetno) {
					this.lblfleetno = lblfleetno;
				}
				public String getLblfleetname() {
					return lblfleetname;
				}
				public void setLblfleetname(String lblfleetname) {
					this.lblfleetname = lblfleetname;
				}
				public String getLbldateout() {
					return lbldateout;
				}
				public void setLbldateout(String lbldateout) {
					this.lbldateout = lbldateout;
				}
				public String getLbltimeout() {
					return lbltimeout;
				}
				public void setLbltimeout(String lbltimeout) {
					this.lbltimeout = lbltimeout;
				}
				public String getLblkmout() {
					return lblkmout;
				}
				public void setLblkmout(String lblkmout) {
					this.lblkmout = lblkmout;
				}
				public String getLblfuelout() {
					return lblfuelout;
				}
				public void setLblfuelout(String lblfuelout) {
					this.lblfuelout = lblfuelout;
				}
				public String getLbldatein() {
					return lbldatein;
				}
				public void setLbldatein(String lbldatein) {
					this.lbldatein = lbldatein;
				}
				public String getLbltimein() {
					return lbltimein;
				}
				public void setLbltimein(String lbltimein) {
					this.lbltimein = lbltimein;
				}
				public String getLblkmin() {
					return lblkmin;
				}
				public void setLblkmin(String lblkmin) {
					this.lblkmin = lblkmin;
				}
				public String getLblfuelin() {
					return lblfuelin;
				}
				public void setLblfuelin(String lblfuelin) {
					this.lblfuelin = lblfuelin;
				}
				public String getLblsumotherdebit() {
					return lblsumotherdebit;
				}
				public void setLblsumotherdebit(String lblsumotherdebit) {
					this.lblsumotherdebit = lblsumotherdebit;
				}
				public String getLblsumothercredit() {
					return lblsumothercredit;
				}
				public void setLblsumothercredit(String lblsumothercredit) {
					this.lblsumothercredit = lblsumothercredit;
				}
				public String getLblsumcrvdebit() {
					return lblsumcrvdebit;
				}
				public void setLblsumcrvdebit(String lblsumcrvdebit) {
					this.lblsumcrvdebit = lblsumcrvdebit;
				}
				public String getLblsumcrvcredit() {
					return lblsumcrvcredit;
				}
				public void setLblsumcrvcredit(String lblsumcrvcredit) {
					this.lblsumcrvcredit = lblsumcrvcredit;
				}
				public String getLblnetbalance() {
					return lblnetbalance;
				}
				public void setLblnetbalance(String lblnetbalance) {
					this.lblnetbalance = lblnetbalance;
				}
	//----------------------------------------------			
		
		
	
		public String getTotalpaids() {
			return totalpaids;
		}
		
		public void setTotalpaids(String totalpaids) {
			this.totalpaids = totalpaids;
		}
		
		
		
	
		public String getInvamount() {
			return invamount;
		}
		
		public void setInvamount(String invamount) {
			this.invamount = invamount;
		}
		public String getBalance() {
			return balance;
		}
		public void setBalance(String balance) {
			this.balance = balance;
		}
		public String getExcessinsu() {
			return excessinsu;
		}
		public void setExcessinsu(String excessinsu) {
			this.excessinsu = excessinsu;
		}
	 public String getRarenttypes() {
			return rarenttypes;
		}
	
		public void setRarenttypes(String rarenttypes) {
			this.rarenttypes = rarenttypes;
		}
	
	
	public String getRaextrakm() {
			return raextrakm;
		}
		
		public void setRaextrakm(String raextrakm) {
			this.raextrakm = raextrakm;
		}
		public String getRaexxtakmchg() {
			return raexxtakmchg;
		}
		public void setRaexxtakmchg(String raexxtakmchg) {
			this.raexxtakmchg = raexxtakmchg;
		}
		public String getAdddrname1() {
			return adddrname1;
		}
	public void setAdddrname1(String adddrname1) {
		this.adddrname1 = adddrname1;
	}
	public String getAdddrname2() {
		return adddrname2;
	}
	public void setAdddrname2(String adddrname2) {
		this.adddrname2 = adddrname2;
	}
	public String getAddlicno1() {
		return addlicno1;
	}
	public void setAddlicno1(String addlicno1) {
		this.addlicno1 = addlicno1;
	}
	public String getAddlicno2() {
		return addlicno2;
	}
	public void setAddlicno2(String addlicno2) {
		this.addlicno2 = addlicno2;
	}
	public String getExpdate1() {
		return expdate1;
	}
	public void setExpdate1(String expdate1) {
		this.expdate1 = expdate1;
	}
	public String getExpdate2() {
		return expdate2;
	}
	public void setExpdate2(String expdate2) {
		this.expdate2 = expdate2;
	}
	public String getAdddob1() {
		return adddob1;
	}
	public void setAdddob1(String adddob1) {
		this.adddob1 = adddob1;
	}
	public String getAdddob2() {
		return adddob2;
	}
	public void setAdddob2(String adddob2) {
		this.adddob2 = adddob2;
	}
	
	 public String getRayom() {
			return rayom;
		}
	
		public void setRayom(String rayom) {
			this.rayom = rayom;
		}
		public String getRacolor() {
			return racolor;
		}
		public void setRacolor(String racolor) {
			this.racolor = racolor;
		}
	 
	 public String getRastatus() {
			return rastatus;
		}
		
		public void setRastatus(String rastatus) {
			this.rastatus = rastatus;
		}
	 
	 
	 public String getDocnoval() {
			return docnoval;
		}
		
		public void setDocnoval(String docnoval) {
			this.docnoval = docnoval;
		}
	
	
	public String getRadaily() {
		return radaily;
	}
	
	public String getInkm() {
		return inkm;
	}
	public void setInkm(String inkm) {
		this.inkm = inkm;
	}
	public String getInfuel() {
		return infuel;
	}
	public void setInfuel(String infuel) {
		this.infuel = infuel;
	}
	public String getIndate() {
		return indate;
	}
	public void setIndate(String indate) {
		this.indate = indate;
	}
	public String getIntime() {
		return intime;
	}
	public void setIntime(String intime) {
		this.intime = intime;
	}
	public void setRadaily(String radaily) {
		this.radaily = radaily;
	}
	public String getRaweakly() {
		return raweakly;
	}
	public void setRaweakly(String raweakly) {
		this.raweakly = raweakly;
	}
	public String getRamonthly() {
		return ramonthly;
	}
	public void setRamonthly(String ramonthly) {
		this.ramonthly = ramonthly;
	}
	public String getTariff() {
		return tariff;
	}
	public void setTariff(String tariff) {
		this.tariff = tariff;
	}
	public String getRacdwscdw() {
		return racdwscdw;
	}
	public void setRacdwscdw(String racdwscdw) {
		this.racdwscdw = racdwscdw;
	}
	public String getRaaccessory() {
		return raaccessory;
	}
	public void setRaaccessory(String raaccessory) {
		this.raaccessory = raaccessory;
	}
	public String getRaadditionalcge() {
		return raadditionalcge;
	}
	public void setRaadditionalcge(String raadditionalcge) {
		this.raadditionalcge = raadditionalcge;
	}
	public String getClname() {
			return clname;
		}
		public void setClname(String clname) {
			this.clname = clname;
		}
		public String getCladdress() {
			return claddress;
		}
		public void setCladdress(String claddress) {
			this.claddress = claddress;
		}
		public String getClmobno() {
			return clmobno;
		}
		public void setClmobno(String clmobno) {
			this.clmobno = clmobno;
		}
		public String getClemail() {
			return clemail;
		}
		public void setClemail(String clemail) {
			this.clemail = clemail;
		}
	 
		public String getBarnchval() {
			return barnchval;
		}
		public void setBarnchval(String barnchval) {
			this.barnchval = barnchval;
		}
		public String getMrano() {
			return mrano;
		}
		public void setMrano(String mrano) {
			this.mrano = mrano;
		}
		public String getRentaldoc() {
			return rentaldoc;
		}
		public void setRentaldoc(String rentaldoc) {
			this.rentaldoc = rentaldoc;
		}
		public String getRadrname() {
			return radrname;
		}
		public void setRadrname(String radrname) {
			this.radrname = radrname;
		}
		public String getRadlno() {
			return radlno;
		}
		public void setRadlno(String radlno) {
			this.radlno = radlno;
		}
		public String getPassno() {
			return passno;
		}
		public void setPassno(String passno) {
			this.passno = passno;
		}
		public String getLicexpdate() {
			return licexpdate;
		}
		public void setLicexpdate(String licexpdate) {
			this.licexpdate = licexpdate;
		}
		public String getPassexpdate() {
			return passexpdate;
		}
		public void setPassexpdate(String passexpdate) {
			this.passexpdate = passexpdate;
		}
		public String getDobdate() {
			return dobdate;
		}
		public void setDobdate(String dobdate) {
			this.dobdate = dobdate;
		}
	 
		public String getRavehname() {
		return ravehname;
	}
	public void setRavehname(String ravehname) {
		this.ravehname = ravehname;
	}
	public String getRavehregno() {
		return ravehregno;
	}
	public void setRavehregno(String ravehregno) {
		this.ravehregno = ravehregno;
	}
	public String getRavehmodel() {
		return ravehmodel;
	}
	public void setRavehmodel(String ravehmodel) {
		this.ravehmodel = ravehmodel;
	}
	public String getRavehgroup() {
		return ravehgroup;
	}
	public void setRavehgroup(String ravehgroup) {
		this.ravehgroup = ravehgroup;
	}
	public String getRadateout() {
		return radateout;
	}
	public void setRadateout(String radateout) {
		this.radateout = radateout;
	}
	public String getRatimeout() {
		return ratimeout;
	}
	public void setRatimeout(String ratimeout) {
		this.ratimeout = ratimeout;
	}
	public String getRaklmout() {
		return raklmout;
	}
	public void setRaklmout(String raklmout) {
		this.raklmout = raklmout;
	}
	 
	public String getRafuelout() {
		return rafuelout;
	}
	public void setRafuelout(String rafuelout) {
		this.rafuelout = rafuelout;
	}
	 
	
	
	private int weekendval,weekend;
	 
//===================================================================	 
	 
		
	
			// main
	    
			public String getColdates() {
		return coldates;
	}
	public void setColdates(String coldates) {
		this.coldates = coldates;
	}
	public String getColtimes() {
		return coltimes;
	}
	public void setColtimes(String coltimes) {
		this.coltimes = coltimes;
	}
	public String getColkmins() {
		return colkmins;
	}
	public void setColkmins(String colkmins) {
		this.colkmins = colkmins;
	}
	public String getColfuels() {
		return colfuels;
	}
	public void setColfuels(String colfuels) {
		this.colfuels = colfuels;
	}
			public int getDocno() {
				return docno;
			}
			public void setDocno(int docno) {
				this.docno = docno;
			}
		
	
				public String getJqxRentalDate() {
					return jqxRentalDate;
				}
				public void setJqxRentalDate(String jqxRentalDate) {
					this.jqxRentalDate = jqxRentalDate;
				}
				public String getHidjqxRentalDate() {
					return hidjqxRentalDate;
				}
				public void setHidjqxRentalDate(String hidjqxRentalDate) {
					this.hidjqxRentalDate = hidjqxRentalDate;
				}

	// veh
			
				public String getTxtfleetno() {
					return txtfleetno;
				}
				public void setTxtfleetno(String txtfleetno) {
					this.txtfleetno = txtfleetno;
				}
				
				
				
				
			//client
			
			public String getVehlocation() {
					return vehlocation;
				}
				public void setVehlocation(String vehlocation) {
					this.vehlocation = vehlocation;
				}
			public int getRe_salmanid() {
					return re_salmanid;
				}
				public void setRe_salmanid(int re_salmanid) {
					this.re_salmanid = re_salmanid;
				}
				public String getRe_clcodeno() {
					return re_clcodeno;
				}
				public void setRe_clcodeno(String re_clcodeno) {
					this.re_clcodeno = re_clcodeno;
				}
				public String getRe_clacno() {
					return re_clacno;
				}
				public void setRe_clacno(String re_clacno) {
					this.re_clacno = re_clacno;
				}
			public String getTxtcusid() {
			return txtcusid;
			}
			
			public void setTxtcusid(String txtcusid) {
			this.txtcusid = txtcusid;
			}
			
			
			
			public String getRentaldesc() {
				return rentaldesc;
			}
			public void setRentaldesc(String rentaldesc) {
				this.rentaldesc = rentaldesc;
			}
			
			// chauffer select

			
			
			
			
			public int getAdditional_driver() {
				return additional_driver;
			}
			public void setAdditional_driver(int additional_driver) {
				this.additional_driver = additional_driver;
			}
			public String getAdidrvcharges() {
				return adidrvcharges;
			}
			public void setAdidrvcharges(String adidrvcharges) {
				this.adidrvcharges = adidrvcharges;
			}
			public int getDelivery_chk() {
				return delivery_chk;
			}
			public void setDelivery_chk(int delivery_chk) {
				this.delivery_chk = delivery_chk;
			}
			public int getRadrivercheck() {
				return radrivercheck;
			}
			public void setRadrivercheck(int radrivercheck) {
				this.radrivercheck = radrivercheck;
			}
			public int getDel_chaufferid() {
				return del_chaufferid;
			}
			public void setDel_chaufferid(int del_chaufferid) {
				this.del_chaufferid = del_chaufferid;
			}
			
	//client driver


				public String getClient_driverid() {
				return client_driverid;
				}
				
				public void setClient_driverid(String client_driverid) {
				this.client_driverid = client_driverid;
				}


				// driver grid
				public int getDrivergridlength() {
					return drivergridlength;
				}
				public void setDrivergridlength(int drivergridlength) {
					this.drivergridlength = drivergridlength;
				}
				
				
    //  tariff grid
			
			public int getTariffgridlength() {
			return tariffgridlength;
		}
		
		public void setTariffgridlength(int tariffgridlength) {
			this.tariffgridlength = tariffgridlength;
		}
		
		
 // tariff main
		
		public String getVeh_fleetgrouptariff() {
			return veh_fleetgrouptariff;
		}
		public void setVeh_fleetgrouptariff(String veh_fleetgrouptariff) {
			this.veh_fleetgrouptariff = veh_fleetgrouptariff;
		}
		
		public String getRatariffsystem() {
			return ratariffsystem;
		}
		
		public void setRatariffsystem(String ratariffsystem) {
			this.ratariffsystem = ratariffsystem;
		}
		public String getRatariffdocno1() {
			return ratariffdocno1;
		}
		public void setRatariffdocno1(String ratariffdocno1) {
			this.ratariffdocno1 = ratariffdocno1;
		}
		public String getInvoice() {
			return invoice;
		}
		public void setInvoice(String invoice) {
			this.invoice = invoice;
		}
		
	
	public String getExcessinsur() {
			return excessinsur;
		}
		public void setExcessinsur(String excessinsur) {
			this.excessinsur = excessinsur;
		}
		
		
		// tariff sub
		public String getRe_Km() {
			return re_Km;
		}
		public void setRe_Km(String re_Km) {
			this.re_Km = re_Km;
		}
		public String getRatariff_fuel() {
			return ratariff_fuel;
		}
		public void setRatariff_fuel(String ratariff_fuel) {
			this.ratariff_fuel = ratariff_fuel;
		}
		
		public int getTariffsales_Agentid() {
			return tariffsales_Agentid;
		}
		public void setTariffsales_Agentid(int tariffsales_Agentid) {
			this.tariffsales_Agentid = tariffsales_Agentid;
		}
		public int getTariffrenral_Agentid() {
			return tariffrenral_Agentid;
		}
		public void setTariffrenral_Agentid(int tariffrenral_Agentid) {
			this.tariffrenral_Agentid = tariffrenral_Agentid;
		}
		public int getRatariff_checkoutid() {
			return ratariff_checkoutid;
		}
		public void setRatariff_checkoutid(int ratariff_checkoutid) {
			this.ratariff_checkoutid = ratariff_checkoutid;
		}
		 // out date
		public String getJqxDateOut() {
			return jqxDateOut;
		}
		public void setJqxDateOut(String jqxDateOut) {
			this.jqxDateOut = jqxDateOut;
		}
		public String getHidjqxDateOut() {
			return hidjqxDateOut;
		}
		public void setHidjqxDateOut(String hidjqxDateOut) {
			this.hidjqxDateOut = hidjqxDateOut;
		}
		public String getJqxTimeOut() {
			return jqxTimeOut;
		}
		public void setJqxTimeOut(String jqxTimeOut) {
			this.jqxTimeOut = jqxTimeOut;
		}
		public String getHidjqxTimeOut() {
			return hidjqxTimeOut;
		}
		public void setHidjqxTimeOut(String hidjqxTimeOut) {
			this.hidjqxTimeOut = hidjqxTimeOut;
		}
		
		
		  // due date
		public String getJqxOnDate() {
			return jqxOnDate;
		}
		public void setJqxOnDate(String jqxOnDate) {
			this.jqxOnDate = jqxOnDate;
		}
		public String getHidjqxOnDate() {
			return hidjqxOnDate;
		}
		public void setHidjqxOnDate(String hidjqxOnDate) {
			this.hidjqxOnDate = hidjqxOnDate;
		}
		public String getJqxOnTime() {
			return jqxOnTime;
		}
		public void setJqxOnTime(String jqxOnTime) {
			this.jqxOnTime = jqxOnTime;
		}
		
	public String getHidjqxOnTime() {
			return hidjqxOnTime;
		}
		public void setHidjqxOnTime(String hidjqxOnTime) {
			this.hidjqxOnTime = hidjqxOnTime;
		}
		// payment grid
		public int getPaymentgridlength() {
			return paymentgridlength;
		}
		public void setPaymentgridlength(int paymentgridlength) {
			this.paymentgridlength = paymentgridlength;
		}

	// payment sub
		public String getPayment_Mra() {
			return payment_Mra;
		}
		public void setPayment_Mra(String payment_Mra) {
			this.payment_Mra = payment_Mra;
		}
		public String getPayment_PO() {
			return payment_PO;
		}
		public void setPayment_PO(String payment_PO) {
			this.payment_PO = payment_PO;
		}
		public String getPayment_Conveh() {
			return payment_Conveh;
		}
		public void setPayment_Conveh(String payment_Conveh) {
			this.payment_Conveh = payment_Conveh;
		}
	// delivery driver
		
		
		
		public String getDel_Driver() {
			return del_Driver;
		}
		public void setDel_Driver(String del_Driver) {
			this.del_Driver = del_Driver;
		}
		
		public String getDel_chaufferid2() {  
			return del_chaufferid2;
		}
		
		public void setDel_chaufferid2(String del_chaufferid2) {
			this.del_chaufferid2 = del_chaufferid2;
		}
		public String getDel_KM() {
			return del_KM;
		}
		
	
		public void setDel_KM(String del_KM) {
			this.del_KM = del_KM;
		}
		public String getDel_Fuel() {
			return del_Fuel;
		}
		public void setDel_Fuel(String del_Fuel) {
			this.del_Fuel = del_Fuel;
		}
		public String getJqxDeliveryOut() {
			return jqxDeliveryOut;
		}
		public void setJqxDeliveryOut(String jqxDeliveryOut) {
			this.jqxDeliveryOut = jqxDeliveryOut;
		}
		public String getHidjqxDeliveryOut() {
			return hidjqxDeliveryOut;
		}
		public void setHidjqxDeliveryOut(String hidjqxDeliveryOut) {
			this.hidjqxDeliveryOut = hidjqxDeliveryOut;
		}
		public String getJqxDelTimeOut() {
			return jqxDelTimeOut;
		}
		public void setJqxDelTimeOut(String jqxDelTimeOut) {
			this.jqxDelTimeOut = jqxDelTimeOut;
		}
		public String getHidjqxDelTimeOut() {
			return hidjqxDelTimeOut;
		}
		public void setHidjqxDelTimeOut(String hidjqxDelTimeOut) {
			this.hidjqxDelTimeOut = hidjqxDelTimeOut;
		}
		
	// hidden
		public String getRentaltype() {
			return rentaltype;
		}
		public void setRentaltype(String rentaltype) {
			this.rentaltype = rentaltype;
		}
		
			public String getMode() {
			  return mode;
			}
			
		
			public void setMode(String mode) {
				this.mode = mode;
			}
		
//==----------------------------------------------------------------------------------
			// for reload
			
			public String getDeleted() {
				return deleted;
			}
			public void setDeleted(String deleted) {
				this.deleted = deleted;
			}
			public String getFormdetailcode() {
				return formdetailcode;
			}
			public void setFormdetailcode(String formdetailcode) {
				this.formdetailcode = formdetailcode;
			}
			public String getVehdetails() {
				return vehdetails;
			}
			public void setVehdetails(String vehdetails) {
				this.vehdetails = vehdetails;
			}
			public String getClient_Name() {
				return client_Name;
			}
			public void setClient_Name(String client_Name) {
				this.client_Name = client_Name;
			}
			public String getRe_salman() {
				return re_salman;
			}
			public void setRe_salman(String re_salman) {
				this.re_salman = re_salman;
			}
			public String getRadriverlist() {
				return radriverlist;
			}
			public void setRadriverlist(String radriverlist) {
				this.radriverlist = radriverlist;
			}
			public String getRasales_Agent() {
				return rasales_Agent;
			}
			public void setRasales_Agent(String rasales_Agent) {
				this.rasales_Agent = rasales_Agent;
			}
			public String getRarenral_Agent() {
				return rarenral_Agent;
			}
			public void setRarenral_Agent(String rarenral_Agent) { 
				this.rarenral_Agent = rarenral_Agent;
			}
			public String getRatariff_checkout() {
				return ratariff_checkout;
			}
			public void setRatariff_checkout(String ratariff_checkout) {
				this.ratariff_checkout = ratariff_checkout;
			}
			
			
	      public String getCusaddress() {
				return cusaddress;
			}
			public void setCusaddress(String cusaddress) {
				this.cusaddress = cusaddress;
			}
			
			
			// del value
			public int getDelchkvalue() {
				return delchkvalue;
			}
			public void setDelchkvalue(int delchkvalue) {
				this.delchkvalue = delchkvalue;
			}
		
			
	public int getChaffchkvalue() {
				return chaffchkvalue;
			}
			public void setChaffchkvalue(int chaffchkvalue) {
				this.chaffchkvalue = chaffchkvalue;
			}
			
	public int getAdd_drchk() {
				return add_drchk;
			}
			public void setAdd_drchk(int add_drchk) {
				this.add_drchk = add_drchk;
			}
			
		/////////////	
			
			public String getSystemval() {
				return systemval;
			}
			public void setSystemval(String systemval) {
				this.systemval = systemval;
			}
			public String getInvoval() {
				return invoval;
			}
			public void setInvoval(String invoval) {
				this.invoval = invoval;
			}
			
	        public String getHiddel_Fuel() {
				return hiddel_Fuel;
			}
			public void setHiddel_Fuel(String hiddel_Fuel) {
				this.hiddel_Fuel = hiddel_Fuel;
			}
			
			
			
//----------------------------------------------------------------------------------------------
			
			public int getAdvance_chkval() {
				return advance_chkval;
			}
			public void setAdvance_chkval(int advance_chkval) {
				this.advance_chkval = advance_chkval;
			}
			public int getAdvance_chk() {
				return advance_chk;
			}
			public void setAdvance_chk(int advance_chk) {
				this.advance_chk = advance_chk;
			}
			
		// vah search fuel in hidden
			
			public String getDelcharges() {
				return delcharges;
			}
			public void setDelcharges(String delcharges) {
				this.delcharges = delcharges;
			}
			public String getHidvehfuel() {
				return hidvehfuel;
			}
			public void setHidvehfuel(String hidvehfuel) {
				this.hidvehfuel = hidvehfuel;
			}

	public String getMsg() {
				return msg;
			}
			
			public void setMsg(String msg) {
				this.msg = msg;
			}
			
			
			
			
			
	public String getRentalstatus() {
				return rentalstatus;
			}
			public void setRentalstatus(String rentalstatus) {
				this.rentalstatus = rentalstatus;
			}
			
			
			
			
			
			
	       public String getCompanyname() {
				return companyname;
			}
			public void setCompanyname(String companyname) {
				this.companyname = companyname;
			}
			public String getAddress() {
				return address;
			}
			public void setAddress(String address) {
				this.address = address;
			}
			public String getMobileno() {
				return mobileno;
			}
			public void setMobileno(String mobileno) {
				this.mobileno = mobileno;
			}
			public String getFax() {
				return fax;
			}
			public void setFax(String fax) {
				this.fax = fax;
			}
			public String getLocation() {
				return location;
			}
			public void setLocation(String location) {
				this.location = location;
			}
			
			
			
			
			
			
	        public String getDeldates() {
				return deldates;
			}
			public void setDeldates(String deldates) {
				this.deldates = deldates;
			}
			public String getDeltimes() {
				return deltimes;
			}
			public void setDeltimes(String deltimes) {
				this.deltimes = deltimes;
			}
			public String getDelkmins() {
				return delkmins;
			}
			public void setDelkmins(String delkmins) {
				this.delkmins = delkmins;
			}
			public String getDelfuels() {
				return delfuels;
			}
			public void setDelfuels(String delfuels) {
				this.delfuels = delfuels;
			}
			
			
			public String getBrchName() {
				return brchName;
			}
			public void setBrchName(String brchName) {
				this.brchName = brchName;
			}
			
			
			//-----------------------driven print--------------------------
			 private String lblclname,lblcladdress,lblpertel,lblfaxno,lblclmobno,lblclemail,lbldobdate,lblradlno,lbcardno,lbexpcarddate,drivravehregno;
			 
						 
			
	         public String getLblclname() {
				return lblclname;
			}
			public void setLblclname(String lblclname) {
				this.lblclname = lblclname;
			}
			public String getLblcladdress() {
				return lblcladdress;
			}
			public void setLblcladdress(String lblcladdress) {
				this.lblcladdress = lblcladdress;
			}
			public String getLblpertel() {
				return lblpertel;
			}
			public void setLblpertel(String lblpertel) {
				this.lblpertel = lblpertel;
			}
			public String getLblfaxno() {
				return lblfaxno;
			}
			public void setLblfaxno(String lblfaxno) {
				this.lblfaxno = lblfaxno;
			}
			public String getLblclmobno() {
				return lblclmobno;
			}
			public void setLblclmobno(String lblclmobno) {
				this.lblclmobno = lblclmobno;
			}
			public String getLblclemail() {
				return lblclemail;
			}
			public void setLblclemail(String lblclemail) {
				this.lblclemail = lblclemail;
			}
			public String getLbldobdate() {
				return lbldobdate;
			}
			public void setLbldobdate(String lbldobdate) {
				this.lbldobdate = lbldobdate;
			}
			public String getLblradlno() {
				return lblradlno;
			}
			public void setLblradlno(String lblradlno) {
				this.lblradlno = lblradlno;
			}
			public String getLbcardno() {
				return lbcardno;
			}
			public void setLbcardno(String lbcardno) {
				this.lbcardno = lbcardno;
			}
			public String getLbexpcarddate() {
				return lbexpcarddate;
			}
			public void setLbexpcarddate(String lbexpcarddate) {
				this.lbexpcarddate = lbexpcarddate;
			}
			public String getDrivravehregno() {
				return drivravehregno;
			}
			public void setDrivravehregno(String drivravehregno) {
				this.drivravehregno = drivravehregno;
			}
			
			
			
			
	        public int getWeekendval() {
				return weekendval;
			}
			public void setWeekendval(int weekendval) {
				this.weekendval = weekendval;
			}
			public int getWeekend() {
				return weekend;
			}
			public void setWeekend(int weekend) {
				this.weekend = weekend;
			}
			
			
			
			
			
	      public String getSalikcharge() {
				return salikcharge;
			}
			public void setSalikcharge(String salikcharge) {
				this.salikcharge = salikcharge;
			}
			public String getTrafficcharge() {
				return trafficcharge;
			}
			public void setTrafficcharge(String trafficcharge) {
				this.trafficcharge = trafficcharge;
			}
			public String getTotalsalikandtraffic() {
				return totalsalikandtraffic;
			}
			public void setTotalsalikandtraffic(String totalsalikandtraffic) {
				this.totalsalikandtraffic = totalsalikandtraffic;
			}
			
			
			 
	public String getLdllandno() {
				return ldllandno;
			}
			public void setLdllandno(String ldllandno) { 
				this.ldllandno = ldllandno;
			}
			
			
			private String  lblpai,laldelcharge,lblchafcharge;
			
			
			
			
			
			
	           public String getLblpai() {
				return lblpai;
			}
			public void setLblpai(String lblpai) {
				this.lblpai = lblpai;
			}
			public String getLaldelcharge() {
				return laldelcharge;
			}
			public void setLaldelcharge(String laldelcharge) {
				this.laldelcharge = laldelcharge;
			}
			public String getLblchafcharge() {
				return lblchafcharge;
			}
			public void setLblchafcharge(String lblchafcharge) {
				this.lblchafcharge = lblchafcharge;
			}
			
			
			//yeti
			public String getSecuritycardno() {
				return securitycardno;
			}
			public void setSecuritycardno(String securitycardno) {
				this.securitycardno = securitycardno;
			}
			public String getSecurityexpdate() {
				return securityexpdate;
			}
			public void setSecurityexpdate(String securityexpdate) {
				this.securityexpdate = securityexpdate;
			}
			public String getSecuritypreauthno() {
				return securitypreauthno;
			}
			public void setSecuritypreauthno(String securitypreauthno) {
				this.securitypreauthno = securitypreauthno;
			}
			public String getSecuritypreauthamt() {
				return securitypreauthamt;
			}
			public void setSecuritypreauthamt(String securitypreauthamt) {
				this.securitypreauthamt = securitypreauthamt;
			}
			public String getTarifftotal() {
				return tarifftotal;
			}
			public void setTarifftotal(String tarifftotal) {
				this.tarifftotal = tarifftotal;
			}
			public String getRacdwscdwtotal() {
				return racdwscdwtotal;
			}
			public void setRacdwscdwtotal(String racdwscdwtotal) {
				this.racdwscdwtotal = racdwscdwtotal;
			}
			public String getRaaccessorytotal() {
				return raaccessorytotal;
			}
			public void setRaaccessorytotal(String raaccessorytotal) {
				this.raaccessorytotal = raaccessorytotal;
			}
			public String getLaldelchargetotal() {
				return laldelchargetotal;
			}
			public void setLaldelchargetotal(String laldelchargetotal) {
				this.laldelchargetotal = laldelchargetotal;
			}
			public String getAdvtotalamont() {
				return advtotalamont;
			}
			public void setAdvtotalamont(String advtotalamont) {
				this.advtotalamont = advtotalamont;
			}
			public String getAdvpaidamount() {
				return advpaidamount;
			}
			public void setAdvpaidamount(String advpaidamount) {
				this.advpaidamount = advpaidamount;
			}
			public String getAdvbalance() {
				return advbalance;
			}
			public void setAdvbalance(String advbalance) {
				this.advbalance = advbalance;
			}
			
			
			//Getters And Setters for Cosmo Print
			
			private String lblcosmofleetno;
			private String lblcosmofleetbrand;
			private String lblcosmoissuedat;
			private String lblcosmocheckin;
			private String lblcosmocheckout;
			private String lblcosmokmin;
			private String lblcosmofuelin;
			private String lblcosmocreditcardno;
			private String lblcosmocreditvaliddate;
			private String lblcosmosecurity;
			private String lblcosmoexcessamt;
			private String lblcosmogps;
			private String lblcosmobabyseater;
			private String lblcosmocollectchg;
			private String lblcosmodamagechg;
			private String lblcosmofuelchg;
			private String lblcosmototal;
			private String lblcosmoadvance;
			private String lblcosmokmrestrictdaily;
			private String lblcosmokmrestrictweekly;
			private String lblcosmokmrestrictmonthly;
			private String lblcosmoexkmratedaily;
			private String lblcosmoexkmrateweekly;
			private String lblcosmoexkmratemonthly;
			private String lblcosmodrivername;
				private String lblcosmodriverlicense;
				private String lblcosmodrivervalidupto;
				private String lblcosmodrivermobile;
				private String lblcosmodriverpassport;
				private String lblcosmocooler;
				
				
		        public String getLblcosmocooler() {
					return lblcosmocooler;
				}
				public void setLblcosmocooler(String lblcosmocooler) {
					this.lblcosmocooler = lblcosmocooler;
				}
				public String getLblcosmodriverpassport() {
					return lblcosmodriverpassport;
				}
				public void setLblcosmodriverpassport(String lblcosmodriverpassport) {
					this.lblcosmodriverpassport = lblcosmodriverpassport;
				}
				public String getLblcosmodrivername() {
					return lblcosmodrivername;
				}
				public void setLblcosmodrivername(String lblcosmodrivername) {
					this.lblcosmodrivername = lblcosmodrivername;
				}
				public String getLblcosmodriverlicense() {
					return lblcosmodriverlicense;
				}
				public void setLblcosmodriverlicense(String lblcosmodriverlicense) {
					this.lblcosmodriverlicense = lblcosmodriverlicense;
				}
				public String getLblcosmodrivervalidupto() {
					return lblcosmodrivervalidupto;
				}
				public void setLblcosmodrivervalidupto(String lblcosmodrivervalidupto) {
					this.lblcosmodrivervalidupto = lblcosmodrivervalidupto;
				}
				public String getLblcosmodrivermobile() {
					return lblcosmodrivermobile;
				}
				public void setLblcosmodrivermobile(String lblcosmodrivermobile) {
					this.lblcosmodrivermobile = lblcosmodrivermobile;
				}
			
			
			
	public String getLblcosmobabyseater() {
				return lblcosmobabyseater;
			}
			public void setLblcosmobabyseater(String lblcosmobabyseater) {
				this.lblcosmobabyseater = lblcosmobabyseater;
			}
	public String getLblcosmofleetno() {
				return lblcosmofleetno;
			}
			public void setLblcosmofleetno(String lblcosmofleetno) {
				this.lblcosmofleetno = lblcosmofleetno;
			}
			public String getLblcosmofleetbrand() {
				return lblcosmofleetbrand;
			}
			public void setLblcosmofleetbrand(String lblcosmofleetbrand) {
				this.lblcosmofleetbrand = lblcosmofleetbrand;
			}
			public String getLblcosmoissuedat() {
				return lblcosmoissuedat;
			}
			public void setLblcosmoissuedat(String lblcosmoissuedat) {
				this.lblcosmoissuedat = lblcosmoissuedat;
			}
			public String getLblcosmocheckin() {
				return lblcosmocheckin;
			}
			public void setLblcosmocheckin(String lblcosmocheckin) {
				this.lblcosmocheckin = lblcosmocheckin;
			}
			public String getLblcosmocheckout() {
				return lblcosmocheckout;
			}
			public void setLblcosmocheckout(String lblcosmocheckout) {
				this.lblcosmocheckout = lblcosmocheckout;
			}
			public String getLblcosmokmin() {
				return lblcosmokmin;
			}
			public void setLblcosmokmin(String lblcosmokmin) {
				this.lblcosmokmin = lblcosmokmin;
			}
			public String getLblcosmofuelin() {
				return lblcosmofuelin;
			}
			public void setLblcosmofuelin(String lblcosmofuelin) {
				this.lblcosmofuelin = lblcosmofuelin;
			}
			public String getLblcosmocreditcardno() {
				return lblcosmocreditcardno;
			}
			public void setLblcosmocreditcardno(String lblcosmocreditcardno) {
				this.lblcosmocreditcardno = lblcosmocreditcardno;
			}
			public String getLblcosmocreditvaliddate() {
				return lblcosmocreditvaliddate;
			}
			public void setLblcosmocreditvaliddate(String lblcosmocreditvaliddate) {
				this.lblcosmocreditvaliddate = lblcosmocreditvaliddate;
			}
			public String getLblcosmosecurity() {
				return lblcosmosecurity;
			}
			public void setLblcosmosecurity(String lblcosmosecurity) {
				this.lblcosmosecurity = lblcosmosecurity;
			}
			public String getLblcosmoexcessamt() {
				return lblcosmoexcessamt;
			}
			public void setLblcosmoexcessamt(String lblcosmoexcessamt) {
				this.lblcosmoexcessamt = lblcosmoexcessamt;
			}
			public String getLblcosmogps() {
				return lblcosmogps;
			}
			public void setLblcosmogps(String lblcosmogps) {
				this.lblcosmogps = lblcosmogps;
			}
			public String getLblcosmocollectchg() {
				return lblcosmocollectchg;
			}
			public void setLblcosmocollectchg(String lblcosmocollectchg) {
				this.lblcosmocollectchg = lblcosmocollectchg;
			}
			public String getLblcosmodamagechg() {
				return lblcosmodamagechg;
			}
			public void setLblcosmodamagechg(String lblcosmodamagechg) {
				this.lblcosmodamagechg = lblcosmodamagechg;
			}
			public String getLblcosmofuelchg() {
				return lblcosmofuelchg;
			}
			public void setLblcosmofuelchg(String lblcosmofuelchg) {
				this.lblcosmofuelchg = lblcosmofuelchg;
			}
			public String getLblcosmototal() {
				return lblcosmototal;
			}
			public void setLblcosmototal(String lblcosmototal) {
				this.lblcosmototal = lblcosmototal;
			}
			public String getLblcosmoadvance() {
				return lblcosmoadvance;
			}
			public void setLblcosmoadvance(String lblcosmoadvance) {
				this.lblcosmoadvance = lblcosmoadvance;
			}
			public String getLblcosmokmrestrictdaily() {
				return lblcosmokmrestrictdaily;
			}
			public void setLblcosmokmrestrictdaily(String lblcosmokmrestrictdaily) {
				this.lblcosmokmrestrictdaily = lblcosmokmrestrictdaily;
			}
			public String getLblcosmokmrestrictweekly() {
				return lblcosmokmrestrictweekly;
			}
			public void setLblcosmokmrestrictweekly(String lblcosmokmrestrictweekly) {
				this.lblcosmokmrestrictweekly = lblcosmokmrestrictweekly;
			}
			public String getLblcosmokmrestrictmonthly() {
				return lblcosmokmrestrictmonthly;
			}
			public void setLblcosmokmrestrictmonthly(String lblcosmokmrestrictmonthly) {
				this.lblcosmokmrestrictmonthly = lblcosmokmrestrictmonthly;
			}
			public String getLblcosmoexkmratedaily() {
				return lblcosmoexkmratedaily;
			}
			public void setLblcosmoexkmratedaily(String lblcosmoexkmratedaily) {
				this.lblcosmoexkmratedaily = lblcosmoexkmratedaily;
			}
			public String getLblcosmoexkmrateweekly() {
				return lblcosmoexkmrateweekly;
			}
			public void setLblcosmoexkmrateweekly(String lblcosmoexkmrateweekly) {
				this.lblcosmoexkmrateweekly = lblcosmoexkmrateweekly;
			}
			public String getLblcosmoexkmratemonthly() {
				return lblcosmoexkmratemonthly;
			}
			public void setLblcosmoexkmratemonthly(String lblcosmoexkmratemonthly) {
				this.lblcosmoexkmratemonthly = lblcosmoexkmratemonthly;
			}
			
			private String chkorgregcard;
			private String hidchkorgregcard;
			
			
			
			public String getChkorgregcard() {
				return chkorgregcard;
			}
			public void setChkorgregcard(String chkorgregcard) {
				this.chkorgregcard = chkorgregcard;
			}
			public String getHidchkorgregcard() {
				return hidchkorgregcard;
			}
			public void setHidchkorgregcard(String hidchkorgregcard) {
				this.hidchkorgregcard = hidchkorgregcard;
			}
			
			
			
			private String kmclient;
			private String kmdriver;
			private String kmvehicle;
			private String kmagmtno;
			private String kmmrano;
			private String kmdate;
			private String lblcompname;    
			private String lblcompaddress;
			private String lblprintname;
			private String lblcomptel;
			private String lblcompfax;
			private String lblbranch;
			private String lbllocation;
			private String lbltotalallowedkm;
			private String lblrateperkm;
			private String lbltotalusedkm;
			private String lbltotalexcesskmrate;
			private String lbltotalexcesskm;
			private String lbltotalexcesskmratewords;
			private String lblclstatus;
			
			
			public String getLblclstatus() {
				return lblclstatus;
			}
			public void setLblclstatus(String lblclstatus) {
				this.lblclstatus = lblclstatus;
			}
			public String getLbltotalallowedkm() {
				return lbltotalallowedkm;
			}
			public void setLbltotalallowedkm(String lbltotalallowedkm) {
				this.lbltotalallowedkm = lbltotalallowedkm;
			}
			public String getLblrateperkm() {
				return lblrateperkm;
			}
			public void setLblrateperkm(String lblrateperkm) {
				this.lblrateperkm = lblrateperkm;
			}
			public String getLbltotalusedkm() {
				return lbltotalusedkm;
			}
			public void setLbltotalusedkm(String lbltotalusedkm) {
				this.lbltotalusedkm = lbltotalusedkm;
			}
			public String getLbltotalexcesskmrate() {
				return lbltotalexcesskmrate;
			}
			public void setLbltotalexcesskmrate(String lbltotalexcesskmrate) {
				this.lbltotalexcesskmrate = lbltotalexcesskmrate;
			}
			public String getLbltotalexcesskm() {
				return lbltotalexcesskm;
			}
			public void setLbltotalexcesskm(String lbltotalexcesskm) {
				this.lbltotalexcesskm = lbltotalexcesskm;
			}
			public String getLbltotalexcesskmratewords() {
				return lbltotalexcesskmratewords;
			}
			public void setLbltotalexcesskmratewords(String lbltotalexcesskmratewords) {
				this.lbltotalexcesskmratewords = lbltotalexcesskmratewords;
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
			public String getKmclient() {
				return kmclient;
			}
			public void setKmclient(String kmclient) {
				this.kmclient = kmclient;
			}
			public String getKmdriver() {
				return kmdriver;
			}
			public void setKmdriver(String kmdriver) {
				this.kmdriver = kmdriver;
			}
			public String getKmvehicle() {
				return kmvehicle;
			}
			public void setKmvehicle(String kmvehicle) {
				this.kmvehicle = kmvehicle;
			}
			public String getKmagmtno() {
				return kmagmtno;
			}
			public void setKmagmtno(String kmagmtno) {
				this.kmagmtno = kmagmtno;
			}
			public String getKmmrano() {
				return kmmrano;
			}
			public void setKmmrano(String kmmrano) {
				this.kmmrano = kmmrano;
			}
			public String getKmdate() {
				return kmdate;
			}
			public void setKmdate(String kmdate) {
				this.kmdate = kmdate;
			}
			
			
			//Indigo Print Details
	
			private String lblindigobranchtel;
			private String lblindigobranchmobile;
			private String lblindigocldocno;
			private String lblindigonationality;
			private String lblindigodiscount;
			private String lblindigonettotal;
			private String lblindigorate;
			private String lblindigorentalagent;
			private String lblindigorenttype;
			private String lblindigoaddmobile;
			private String lblindigoaddnationality;
			
			
			public String getLblindigoaddmobile() {
				return lblindigoaddmobile;
			}
			public void setLblindigoaddmobile(String lblindigoaddmobile) {
				this.lblindigoaddmobile = lblindigoaddmobile;
			}
			public String getLblindigoaddnationality() {
				return lblindigoaddnationality;
			}
			public void setLblindigoaddnationality(String lblindigoaddnationality) {
				this.lblindigoaddnationality = lblindigoaddnationality;
			}
			public String getLblindigorenttype() {
				return lblindigorenttype;
			}
			public void setLblindigorenttype(String lblindigorenttype) {
				this.lblindigorenttype = lblindigorenttype;
			}
			
			public String getLblindigorentalagent() {
				return lblindigorentalagent;
			}
			public void setLblindigorentalagent(String lblindigorentalagent) {
				this.lblindigorentalagent = lblindigorentalagent;
			}
			
	public String getLblindigorate() {
		return lblindigorate;
	}

	public void setLblindigorate(String lblindigorate) {
		this.lblindigorate = lblindigorate;
	}

	public String getLblindigodiscount() {
		return lblindigodiscount;
	}

	public void setLblindigodiscount(String lblindigodiscount) {
		this.lblindigodiscount = lblindigodiscount;
	}

	public String getLblindigonettotal() {
		return lblindigonettotal;
	}

	public void setLblindigonettotal(String lblindigonettotal) {
		this.lblindigonettotal = lblindigonettotal;
	}

	public String getLblindigobranchtel() {
		return lblindigobranchtel;
	}

	public void setLblindigobranchtel(String lblindigobranchtel) {
		this.lblindigobranchtel = lblindigobranchtel;
	}

	public String getLblindigobranchmobile() {
		return lblindigobranchmobile;
	}

	public void setLblindigobranchmobile(String lblindigobranchmobile) {
		this.lblindigobranchmobile = lblindigobranchmobile;
	}

	public String getLblindigocldocno() {
		return lblindigocldocno;
	}

	public void setLblindigocldocno(String lblindigocldocno) {
		this.lblindigocldocno = lblindigocldocno;
	}

	public String getLblindigonationality() {
		return lblindigonationality;
	}

	public void setLblindigonationality(String lblindigonationality) {
		this.lblindigonationality = lblindigonationality;
	}
	
	
private String selcartarif,selcarcdw,selcarcdw1,selcarpai,selcaracc,selcarvmd;
	
	
	public String getSelcartarif() {
		return selcartarif;
	}
	public void setSelcartarif(String selcartarif) {
		this.selcartarif = selcartarif;
	}
	public String getSelcarcdw() {
		return selcarcdw;
	}
	public void setSelcarcdw(String selcarcdw) {
		this.selcarcdw = selcarcdw;
	}
	public String getSelcarcdw1() {
		return selcarcdw1;
	}
	public void setSelcarcdw1(String selcarcdw1) {
		this.selcarcdw1 = selcarcdw1;
	}
	public String getSelcarpai() {
		return selcarpai;
	}
	public void setSelcarpai(String selcarpai) {
		this.selcarpai = selcarpai;
	}
	public String getSelcaracc() {
		return selcaracc;
	}
	public void setSelcaracc(String selcaracc) {
		this.selcaracc = selcaracc;
	}
	public String getSelcarvmd() {
		return selcarvmd;
	}
	public void setSelcarvmd(String selcarvmd) {
		this.selcarvmd = selcarvmd;
	}



 //yessure print  
	 private String drivermobno;
	 private String drivercountry;
	 private String vehiclechasisno;
	 private String rentaldetcdw;
	 private String rdsecuritydeposit;
	 
	 
	 
		public String getDrivermobno() {
		return drivermobno;
	}

	public void setDrivermobno(String drivermobno) {
		this.drivermobno = drivermobno;
	}

	public String getDrivercountry() {
		return drivercountry;
	}

	public void setDrivercountry(String drivercountry) {
		this.drivercountry = drivercountry;
	}

	public String getVehiclechasisno() {
		return vehiclechasisno;
	}

	public void setVehiclechasisno(String vehiclechasisno) {
		this.vehiclechasisno = vehiclechasisno;
	}

	public String getRentaldetcdw() {
		return rentaldetcdw;
	}

	public void setRentaldetcdw(String rentaldetcdw) {
		this.rentaldetcdw = rentaldetcdw;
	}

	public String getRdsecuritydeposit() {
		return rdsecuritydeposit;
	}

	public void setRdsecuritydeposit(String rdsecuritydeposit) {
		this.rdsecuritydeposit = rdsecuritydeposit;
	}
	
	
	
	 
	 // yessur print end
	
		private String chkigst;
	private String hidchkigst;

	
	
	public String getChkigst() {
		return chkigst;
	}
	public void setChkigst(String chkigst) {
		this.chkigst = chkigst;
	}
	public String getHidchkigst() {
		return hidchkigst;
	}
	public void setHidchkigst(String hidchkigst) {
		this.hidchkigst = hidchkigst;
	}
		
// classic 
	public String claddress2;
	
	public String clsiclpo,clcreditcard,cladvance,cldesc;
	public String gpsprint,babyseaterprint;
	public String getGpsprint() {
		return gpsprint;
	}
	public void setGpsprint(String gpsprint) {
		this.gpsprint = gpsprint;
	}
	public String getBabyseaterprint() {
		return babyseaterprint;
	}
	public void setBabyseaterprint(String babyseaterprint) {
		this.babyseaterprint = babyseaterprint;
	}
	public String getClsiclpo() {
		return clsiclpo;
	}
	public void setClsiclpo(String clsiclpo) {
		this.clsiclpo = clsiclpo;
	}
	public String getClcreditcard() {
		return clcreditcard;
	}
	public void setClcreditcard(String clcreditcard) {
		this.clcreditcard = clcreditcard;
	}
	public String getCladvance() {
		return cladvance;
	}
	public void setCladvance(String cladvance) {
		this.cladvance = cladvance;
	}
	public String getCldesc() {
		return cldesc;
	}
	public void setCldesc(String cldesc) {
		this.cldesc = cldesc;
	}
	public String getCladdress2() {
		return claddress2;
	}
	public void setCladdress2(String claddress2) {
		this.claddress2 = claddress2;
	}
	public String getRayear() {
		return rayear;
	}

	public void setRayear(String rayear) {
		this.rayear = rayear;
	}
	public String getInspdoc() {
		return inspdoc;
	}

	public void setInspdoc(String inspdoc) {
		this.inspdoc = inspdoc;
	}

	public String getSignpath() {
		return signpath;
	}

	public void setSignpath(String signpath) {
		this.signpath = signpath;
	}
	public String saveAction() throws ParseException, SQLException{
		
	
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();

	
		
		
		
		 Map<String, String[]> requestParams = request.getParameterMap();
	
				
		setHidchkorgregcard(getHidchkorgregcard());
           if(mode.equalsIgnoreCase("A")){
        		java.sql.Date sqlrentalDate = commonDAO.changeStringtoSqlDate(getJqxRentalDate());
        		java.sql.Date sqloutDate = commonDAO.changeStringtoSqlDate(getJqxDateOut());
        		java.sql.Date sqldueDate = commonDAO.changeStringtoSqlDate(getJqxOnDate());
        	   ArrayList<String> ragmttariffarray= new ArrayList<>();
				for(int i=0;i<getTariffgridlength();i++){
				 String temp=requestParams.get("test"+i)[0];
				 ragmttariffarray.add(temp);
				}
			
				ArrayList<String> paymentarray= new ArrayList<>();
				for(int i=0;i<getPaymentgridlength();i++){
				 String temp2=requestParams.get("paytest"+i)[0];
				 paymentarray.add(temp2);
				 
				}
				ArrayList<String> driverarray= new ArrayList<>();
				for(int i=0;i<getDrivergridlength();i++){
				 String temp3=requestParams.get("drvtest"+i)[0];
				 driverarray.add(temp3);
				 
				} 
			//System.out.println("action array"+driverarray);
			int specialuserdoc = getSpecialdiscountuser();
				request.setAttribute("specialuserdoc", specialuserdoc);
				
				
				
			int val=rentalAgmtDAO.insert(sqlrentalDate,getTxtfleetno(),getTxtcusid(),getRe_salmanid(),getRe_clcodeno(),
					getRe_clacno(),getAdditional_driver(),getAdidrvcharges(),getDelivery_chk(),getRadrivercheck(),
					getDel_chaufferid(),driverarray,getRe_Km(),getHidvehfuel(),sqloutDate,getJqxTimeOut(),getTariffsales_Agentid(),
					getTariffrenral_Agentid(),getRatariff_checkoutid(),sqldueDate,getJqxOnTime(),
					ragmttariffarray,getRatariffsystem(),getRatariffdocno1(),getInvoice(),getExcessinsur(),
					paymentarray,getPayment_Mra(),getPayment_PO(),getPayment_Conveh(),getVehlocation(),getVeh_fleetgrouptariff(),getRentaltype(),
					getAdvance_chk(),getMode(),session,getFormdetailcode(),request,getClient_Name(),getDelcharges(),getRentaldesc(),
					getWeekend(),getHidchkorgregcard(),getHidchkigst(),getHidrentalproject());
			int vdocno=(int) request.getAttribute("vocno");
			if(val>0){
				
				//main 
				setRentalproject(getRentalproject());
				setHidrentalproject(getHidrentalproject());
				setDocno(vdocno);
				setMasterdoc_no(val);
				setHidjqxRentalDate(sqlrentalDate.toString());
				//fleet
				setTxtfleetno(getTxtfleetno());
				setVehdetails(getVehdetails());
				
				//client
				setTxtcusid(getTxtcusid());
				setClient_Name(getClient_Name());
				setRe_salman(getRe_salman());
				setCusaddress(getCusaddress());
				setRentaldesc(getRentaldesc());
				//driver
				setAdd_drchk(getAdditional_driver());
				setAdidrvcharges(getAdidrvcharges());
				//
				setDelchkvalue(getDelivery_chk());
				setChaffchkvalue(getRadrivercheck());
						//
				//setRadrivercheck(getRadrivercheck());
				setRadriverlist(getRadriverlist());
				//sub tariff
				
				 setRarenral_Agent(getRarenral_Agent());
				 setRasales_Agent(getRasales_Agent());
				
				//out
				
				setHidjqxDateOut(sqloutDate.toString());
				setHidjqxTimeOut(getJqxTimeOut());
				setRe_Km(getRe_Km());
				setRatariff_fuel(getRatariff_fuel());
				setHidvehfuel(getHidvehfuel());
				//due
				setHidjqxOnDate(sqldueDate.toString());
				setHidjqxOnTime(getJqxOnTime());
				setRatariff_checkout(getRatariff_checkout());
				//tariff main
				
				setSystemval(getRatariffsystem());
				
				
				setRatariffdocno1(getRatariffdocno1());
				
				setInvoval(getInvoice());
				
				
				setExcessinsur(getExcessinsur());
				//payment
				setPayment_Mra(getPayment_Mra());
				setPayment_PO(getPayment_PO());
				setPayment_Conveh(getPayment_Conveh());
				//
				setDel_Driver(getDel_Driver());
				setDel_chaufferid2(getDel_chaufferid2());
				//
				setAdvance_chkval(getAdvance_chk());
				setDelcharges(getDelcharges());
				
				setAdvance_chkval(getAdvance_chk());
				setWeekendval(getWeekend());
				
				
				//
				setRentalstatus("Open");
				
				setHidchkigst(getHidchkigst());
				setMsg("Successfully Saved");
			
				
				
				return "success";
			}
			else{
				setDocno(vdocno);
				setMasterdoc_no(val);
				setHidjqxRentalDate(sqlrentalDate.toString());
				//fleet
				setTxtfleetno(getTxtfleetno());
				setVehdetails(getVehdetails());
				
				//client
				setTxtcusid(getTxtcusid());
				setClient_Name(getClient_Name());
				setRe_salman(getRe_salman());
				setCusaddress(getCusaddress());
				//driver
				setAdd_drchk(getAdditional_driver());
				setAdidrvcharges(getAdidrvcharges());
				//
				setDelchkvalue(getDelivery_chk());
				setChaffchkvalue(getRadrivercheck());
						//
				//setRadrivercheck(getRadrivercheck());
				setRadriverlist(getRadriverlist());
				//sub tariff
				
				 setRarenral_Agent(getRarenral_Agent());
				 setRasales_Agent(getRasales_Agent());
				
				//out
				
				setHidjqxDateOut(sqloutDate.toString());
				setHidjqxTimeOut(getJqxTimeOut());
				setRe_Km(getRe_Km());
				setRatariff_fuel(getRatariff_fuel());
				setHidvehfuel(getHidvehfuel());
				//due
				setHidjqxOnDate(sqldueDate.toString());
				setHidjqxOnTime(getJqxOnTime());
				setRatariff_checkout(getRatariff_checkout());
				//tariff main
				
				setSystemval(getRatariffsystem());
				
				setWeekendval(getWeekend());
				setRatariffdocno1(getRatariffdocno1());
				
				setInvoval(getInvoice());
				
				
				setExcessinsur(getExcessinsur());
				//payment
				setPayment_Mra(getPayment_Mra());
				setPayment_PO(getPayment_PO());
				setPayment_Conveh(getPayment_Conveh());
				//
				setDel_Driver(getDel_Driver());
				setDel_chaufferid2(getDel_chaufferid2());
				//
				setDelcharges(getDelcharges());
				setAdvance_chkval(getAdvance_chk());
				setHidchkigst(getHidchkigst());
				setMsg("Not Saved");
				return "fail";
			}	
			
           }
          
          else if(mode.equalsIgnoreCase("ADD")){
        	  java.sql.Date sqldelDate = commonDAO.changeStringtoSqlDate(getJqxDeliveryOut());	 
        		java.sql.Date sqlrentalDate = commonDAO.changeStringtoSqlDate(getJqxRentalDate());
        	  if(getDelchkvalue()==1)
        	  {
        		
        	
        	  boolean Status=rentalAgmtDAO.update(getWeekend(),getMasterdoc_no(),sqlrentalDate,getTxtfleetno(),getDel_chaufferid2(),getDel_KM(),getDel_Fuel(),sqldelDate,getJqxDelTimeOut(),getVehlocation(),getVeh_fleetgrouptariff(),getMode(),getTxtcusid(),session);
        	  if(Status){
        		  setMasterdoc_no(getMasterdoc_no());
        		  setDel_KM(getDel_KM());
        		  setHiddel_Fuel(getDel_Fuel());
        		  setHidjqxDeliveryOut(sqldelDate.toString());
        		  setHidjqxDelTimeOut(getJqxDelTimeOut());
        		  setMsg("Updated Successfully");
  				  return "success";
  			
  			}
  			else{
  				setMasterdoc_no(getMasterdoc_no());
  				 setDel_KM(getDel_KM());
       		    setHiddel_Fuel(getDel_Fuel());
       		    setHidjqxDeliveryOut(sqldelDate.toString());
       		     setHidjqxDelTimeOut(getJqxDelTimeOut());
  				setMsg("Not Updated");
  				return "fail";
  			}
        	  }
  		}
          else if(mode.equalsIgnoreCase("View")){
        		
  			//String branch=null;
  			RentalAgreementBean=rentalAgmtDAO.getViewDetails(session,getMasterdoc_no());
  			setHidrentalproject(RentalAgreementBean.getHidrentalproject());
  			setRentalproject(RentalAgreementBean.getRentalproject());
  			setHidchkorgregcard(RentalAgreementBean.getHidchkorgregcard());
			setHidchkigst(RentalAgreementBean.getHidchkigst());
//  			System.out.println("From Bean ORGREG : "+RentalAgreementBean.getHidchkorgregcard());

//  			System.out.println("From Action ORGREG : "+getHidchkorgregcard());

  			setCheckbranch(getCheckbranch());
  			setMasterdoc_no(RentalAgreementBean.getMasterdoc_no());
  			setDocno(RentalAgreementBean.getDocno());
			setHidjqxRentalDate(RentalAgreementBean.getJqxRentalDate());
			//fleet
			setTxtfleetno(RentalAgreementBean.getTxtfleetno());
			setVehdetails(RentalAgreementBean.getVehdetails());
			
			//client
			setTxtcusid(RentalAgreementBean.getTxtcusid());
			setClient_Name(RentalAgreementBean.getClient_Name());
			//System.out.println("sftcd:"+getClient_Name());
			setRe_salman(RentalAgreementBean.getRe_salman());
			setCusaddress(RentalAgreementBean.getCusaddress());
			//driver
			setAdd_drchk(RentalAgreementBean.getAdditional_driver());
			setAdidrvcharges(RentalAgreementBean.getAdidrvcharges());
			setDelchkvalue(RentalAgreementBean.getDelivery_chk());
			setChaffchkvalue(RentalAgreementBean.getRadrivercheck());
			setRadriverlist(RentalAgreementBean.getRadriverlist());
			
			//advance
			setAdvance_chkval(RentalAgreementBean.getAdvance_chkval());
			
			
			//sub tariff
			
			
			setRarenral_Agent(RentalAgreementBean.getRarenral_Agent());
			setRasales_Agent(RentalAgreementBean.getRasales_Agent());
			
			setWeekendval(RentalAgreementBean.getWeekendval());	
			//out
			setHidjqxDateOut(RentalAgreementBean.getJqxDateOut());
			//System.out.println("RentalAgreementBean:::"+getHidjqxDateOut());
			setHidjqxTimeOut(RentalAgreementBean.getJqxTimeOut());
			setRe_Km(RentalAgreementBean.getRe_Km());
			setRatariff_fuel(RentalAgreementBean.getRatariff_fuel());
			setHidvehfuel(RentalAgreementBean.getHidvehfuel());
			
			
			//due
			setHidjqxOnDate(RentalAgreementBean.getJqxOnDate());
			setHidjqxOnTime(RentalAgreementBean.getJqxOnTime());
			setRatariff_checkout(RentalAgreementBean.getRatariff_checkout());
			//tariff main
			
			setSystemval(RentalAgreementBean.getRatariffsystem());
			setRatariffdocno1(RentalAgreementBean.getRatariffdocno1());
			
			setInvoval(RentalAgreementBean.getInvoice());
			setExcessinsur(RentalAgreementBean.getExcessinsur());
			//payment
			setPayment_Mra(RentalAgreementBean.getPayment_Mra());
			setPayment_PO(RentalAgreementBean.getPayment_PO());
			setPayment_Conveh(RentalAgreementBean.getPayment_Conveh());
  			//
			setDel_Driver(RentalAgreementBean.getDel_Driver());
			setDel_chaufferid2(RentalAgreementBean.getDel_chaufferid2());
			//
			setVehlocation(RentalAgreementBean.getVehlocation());
			setDelcharges(RentalAgreementBean.getDelcharges());
			setRentalstatus(RentalAgreementBean.getRentalstatus());
  			//System.out.println(cashPaymentBean.getTxtcashpaydocno());
			
			
			setDel_KM(RentalAgreementBean.getDel_KM());
			//
			setHiddel_Fuel(RentalAgreementBean.getDel_Fuel());
			
			setHidjqxDeliveryOut(RentalAgreementBean.getJqxDeliveryOut());
			
			setHidjqxDelTimeOut(RentalAgreementBean.getJqxDelTimeOut());
			
			setRentaldesc(RentalAgreementBean.getRentaldesc());
			
			
			
  			return "success";
  		}
           return "fail";
       	
	}
	

		/*public  JSONArray tariffsearch(){
			
			  JSONArray cellarray1 = new JSONArray();
			  JSONObject cellobj1 = null;
			  try {
				  List <ClsRentalAgreementBean> list= ClsRentalAgreementDAO.list6();
				  for(ClsRentalAgreementBean bean:list){
				  cellobj1 = new JSONObject();
				 				  
				  cellobj1.put("rentaltype",bean.getTarifftype()); 
				
				
				  
				  cellarray1.add(cellobj1);

				 }
				//System.out.println("cellobj"+cellarray1);
			  } catch (SQLException e) {
				  e.printStackTrace();
			  }
			return cellarray1;
		}*/
	/*	public  JSONArray chufferinfo(){
			
			  JSONArray cellarray1 = new JSONArray();
			  JSONObject cellobj1 = null;
			  try {
				  List <ClsRentalAgreementBean> list= ClsRentalAgreementDAO.list7();
				  for(ClsRentalAgreementBean bean:list){
				  cellobj1 = new JSONObject();
				  
				  cellobj1.put("doc_no",bean.getSal_docno());
				  cellobj1.put("sal_code",bean.getChau_id()); 
				  cellobj1.put("sal_name",bean.getChau_name()); 
				  
				  cellarray1.add(cellobj1);

				 }
				//System.out.println("cellobj"+cellarray1);
			  } catch (SQLException e) {
				  e.printStackTrace();
			  }
			return cellarray1;
		}*/
		/*public  JSONArray SalesgentSearch(){
			
			  JSONArray cellarray1 = new JSONArray();
			  JSONObject cellobj1 = null;
			  try {
				  List <ClsRentalAgreementBean> list= ClsRentalAgreementDAO.list1();
				  for(ClsRentalAgreementBean bean:list){
				  cellobj1 = new JSONObject();
				  
				  cellobj1.put("doc_no",bean.getSal_docno());
				  cellobj1.put("sal_code",bean.getChau_id()); 
				  cellobj1.put("sal_name",bean.getChau_name()); 
				  
				  cellarray1.add(cellobj1);

				 }
				//System.out.println("cellobj"+cellarray1);
			  } catch (SQLException e) {
				  e.printStackTrace();
			  }
			return cellarray1;
		}*/
	/*	public  JSONArray RentalgentSearch(){ 
			 
			  JSONArray cellarray1 = new JSONArray();
			  JSONObject cellobj1 = null;
			  try {
				  List <ClsRentalAgreementBean> list= ClsRentalAgreementDAO.list2();
				  for(ClsRentalAgreementBean bean:list){
				  cellobj1 = new JSONObject();
				  
				  cellobj1.put("doc_no",bean.getSal_docno());
				  cellobj1.put("sal_code",bean.getChau_id()); 
				  cellobj1.put("sal_name",bean.getChau_name()); 
				  
				  cellarray1.add(cellobj1);

				 }
				//System.out.println("cellobj"+cellarray1);
			  } catch (SQLException e) {
				  e.printStackTrace();
			  }
			return cellarray1;
		}*/
/*		public  JSONArray checkoutSearch(){
			
			  JSONArray cellarray1 = new JSONArray();
			  JSONObject cellobj1 = null;
			  try {
				  List <ClsRentalAgreementBean> list= ClsRentalAgreementDAO.list3();
				  for(ClsRentalAgreementBean bean:list){
				  cellobj1 = new JSONObject();
				  
				  cellobj1.put("doc_no",bean.getSal_docno());
				  cellobj1.put("sal_code",bean.getChau_id()); 
				  cellobj1.put("sal_name",bean.getChau_name()); 
				  
				  cellarray1.add(cellobj1);

				 }
				//System.out.println("cellobj"+cellarray1);
			  } catch (SQLException e) {
				  e.printStackTrace();
			  }
			return cellarray1;
		}
		*/
/*		public  String payment(){
			
			String cellarray1 = "";  
			
			
			  try {
				  List <ClsRentalAgreementBean> list= ClsRentalAgreementDAO.list4();
				  for(ClsRentalAgreementBean bean:list){
					  		cellarray1+=bean.getPaymentmode()+",";

				 }
				  cellarray1=cellarray1.substring(0, cellarray1.length()-1);
			  } catch (SQLException e) {
				  e.printStackTrace();
			  }
			return cellarray1;
		}*/
		 public String printAction() throws ParseException, SQLException,Exception{
//			System.out.println("========hiiiiiiiiiiii"+getFormdetailcode());
			 Connection conn = null;
			 try{
				 
			  conn = conobj.getMyConnection();	
			  HttpServletRequest request=ServletActionContext.getRequest();
			  HttpServletResponse response = ServletActionContext.getResponse();
			  
			  HttpSession session=request.getSession();
			  int doc=Integer.parseInt(request.getParameter("docno"));
			  if(session.getAttribute("BRANCHID").toString().equalsIgnoreCase("1")){
				  setBranchwisname("Green Car");
			  }else{
				  setBranchwisname("Green Star");
			  }
			  
			  setDocnoval(request.getParameter("docno"));
			  bean=rentalAgmtDAO.getPrint(doc);
			  setInspdoc(bean.getInspdoc());
			  int sigdoc=Integer.parseInt(getInspdoc());
			  String[] path={"",""};
			  if(sigdoc>0){
//			  System.out.println("sigdoc====="+sigdoc);
			  inspbean=inspDAO.getSignature(sigdoc);
			  if(inspbean.getSignature()!=null){
			  path=inspbean.getSignature().split("/attachment");
			  }
			  setSignpath("../../../../attachment"+path[1]);
			  System.out.println("========signature path====="+getSignpath());
			  }
			  setRentaltotals(bean.getRentaltotals());
			  setTotaltot(bean.getTotaltot());
			  setLblauthority(bean.getLblauthority());
			 
			  setVehauth(bean.getVehauth());
			  setLbldesc(bean.getLbldesc());
			  setClsiclpo(bean.getClsiclpo());
			  setCldesc(bean.getCldesc());;
			  setLblindigobranchmobile(bean.getLblindigobranchmobile());
			  setLblindigobranchtel(bean.getLblindigobranchtel());
			  setLblindigocldocno(bean.getLblindigocldocno());
			  setLblindigonationality(bean.getLblindigonationality());
			  setLblindigodiscount(bean.getLblindigodiscount());
			  setLblindigonettotal(bean.getLblindigonettotal());
			  setLblindigorate(bean.getLblindigorate());
			  setLblindigorentalagent(bean.getLblindigorentalagent());
			   setLblindigorenttype(bean.getLblindigorenttype());
			  setLblindigoaddmobile(bean.getLblindigoaddmobile());
			  setLblindigoaddnationality(bean.getLblindigoaddnationality());
			   setLblcompmail(bean.getLblcompmail());
			  setLblcompwebsite(bean.getLblcompwebsite());
			  setLbltel1(bean.getLbltel1());
			  setLbltel2(bean.getLbltel2());
			  setRarentserdue(bean.getRarentserdue());
			  setLblclientrn(bean.getLblclientrn());
			  //del details
//			  System.out.println("dateaaaa:"+bean.getHidjqxDateOut());
			  
			  //----------cp----------//
			  SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			  String currentdate = sdf.format(new Date());
			  
			  setLblcurrentdate(currentdate);
			  
			  setLblnofdays(bean.getLblnofdays());
			  setLblrentaldesc(bean.getLblrentaldesc());
			  setLbluser(bean.getLbluser());
			  setRavehauthregno(bean.getRavehauthregno());
			  //----------cp----------//
 	  
	    	    setSalikcharge(bean.getSalikcharge());
	    	    
	    	  //  salikcharge
	    	    
	    	   setTrafficcharge(bean.getTrafficcharge());
	    	    setTotalsalikandtraffic(bean.getTotalsalikandtraffic());
/*			  setDeldates setDeltimes setDelkmins setDelfuels*/
			  
			  setDeldates(bean.getDeldates());
			  setDeltimes(bean.getDeltimes());
			  setDelkmins(bean.getDelkmins());
			  setDelfuels(bean.getDelfuels());
			  
			  
	    	   setOutdetails(bean.getOutdetails());
	    	  setDeldetailss(bean.getDeldetailss());
			  
			  //col
	
	    	   setColdates(bean.getColdates());
	    	   setColtimes(bean.getColtimes());
	    	   setColkmins(bean.getColkmins());
	    	   setColfuels(bean.getColfuels());
				  
	     	    setIndetails(bean.getIndetails());
			    
		    	 setColdetails(bean.getColdetails());
		    	    
		    	     
	    	   
			  
			  //cl details
			  setClname(bean.getClname());
			  setCladdress(bean.getCladdress());
			  setClemail(bean.getClemail());
//			  System.out.println("emaillll"+bean.getClemail());
			  setClmobno(bean.getClmobno());
			  setLblcldocno(bean.getLblcldocno());
	    	   setLdllandno(bean.getLdllandno());
//	    	   System.out.println("clienttelno"+bean.getLdllandno());
			  
			  // main upper
			  setBarnchval(bean.getBarnchval());
			  setMrano(bean.getMrano());
			  setRentaldoc(bean.getRentaldoc());
		
	    	    
	    	    // dr details
			  
			  setRadrname(bean.getRadrname());
			  setRadlno(bean.getRadlno());
			  setPassno(bean.getPassno());
			  setLicexpdate(bean.getLicexpdate());
			  setPassexpdate(bean.getPassexpdate());
//			  System.out.println("exp"+getPassexpdate());
			  setLblpassissued(bean.getLblpassissued());
			  setDobdate(bean.getDobdate()); 
			  setLblnation(bean.getLblnation());
			  setLblissby(bean.getLblissby());
			  setLblissfromdate(bean.getLblissfromdate());
			  setLblidno(bean.getLblidno());
			  // veh details
			  setRayear(bean.getRayear());
			  setRavehname(bean.getRavehname());
			  setRavehgroup(bean.getRavehgroup());
			  setRavehmodel(bean.getRavehmodel());
			  setRavehregno(bean.getRavehregno());
			  setRadateout(bean.getRadateout());
			  setRatimeout(bean.getRatimeout());
			  setRaklmout(bean.getRaklmout());
			  setRavehplate(bean.getRavehplate());
			  setLblrentaltype(bean.getLblrentaltype());
//			  System.out.println("get"+getLblrentaltype());
			
			  //out
			  setRe_Km(bean.getRe_Km());
			  setHidjqxDateOut(bean.getHidjqxDateOut());
			  setHidjqxTimeOut(bean.getHidjqxTimeOut());
			  setRatariff_fuel(bean.getRatariff_fuel());
//			  System.out.println("dateee"+bean.getHidjqxDateOut());
			  
			setRamonthly(bean.getRamonthly());
			setRaweakly(bean.getRaweakly());
			setRadaily(bean.getRadaily());
			  
			 setLblcosmokmrestrictdaily(bean.getLblcosmokmrestrictdaily());
	           setLblcosmokmrestrictweekly(bean.getLblcosmokmrestrictweekly());
	           setLblcosmokmrestrictmonthly(bean.getLblcosmokmrestrictmonthly());
	           setLblcosmoexkmratedaily(bean.getLblcosmoexkmratedaily());
	           setLblcosmoexkmrateweekly(bean.getLblcosmoexkmrateweekly());
	           setLblcosmoexkmratemonthly(bean.getLblcosmoexkmratemonthly());
			
			  
			  //rental type
//			  System.out.println("===== "+bean.getRadaily()+"===== "+bean.getRaweakly()+"======= "+bean.getRamonthly()); 
			if(bean.getLblrentaltype().equalsIgnoreCase("Monthly")){
				setRamonthly(bean.getLblrentalrate());
				setLblcosmokmrestrictmonthly(bean.getRaextrakm());
				setLblcosmoexkmratemonthly(bean.getRaexxtakmchg());
			}
			else if(bean.getLblrentaltype().equalsIgnoreCase("Daily")){
				setRadaily(bean.getLblrentalrate());
				setLblcosmokmrestrictdaily(bean.getRaextrakm());
				setLblcosmoexkmratedaily(bean.getRaexxtakmchg());
			}
			else if(bean.getLblrentaltype().equalsIgnoreCase("Weekly")){
				setRaweakly(bean.getLblrentalrate());
				setLblcosmokmrestrictweekly(bean.getRaextrakm());
				setLblcosmoexkmrateweekly(bean.getRaexxtakmchg());
			}
			
			
		//	System.out.println("===== after == "+bean.getRadaily()+"===== "+bean.getRaweakly()+"======= "+bean.getRamonthly());
			
			
			  setTariff(bean.getTariff());
			  setRacdwscdw(bean.getRacdwscdw());
			  setRaaccessory(bean.getRaaccessory());
			  setRaadditionalcge(bean.getRaadditionalcge());
			  
			  
			  setInkm(bean.getInkm());
			  setInfuel(bean.getInfuel());
			  setIndate(bean.getIndate());
			  setIntime(bean.getIntime());
			  setRastatus(bean.getRastatus());
//			  System.out.println("getInkm::"+bean.getInkm()+"::"+bean.getInfuel()+"::"+bean.getIndate()+"::"+bean.getIntime()+"::"+bean.getRastatus());
			  
			  setRafuelout(bean.getRafuelout());

			  setRayom(bean.getRayom());
	    	  setRacolor(bean.getRacolor()) ;  
	    	   setAdddrname1(bean.getAdddrname1());
	    	  setAdddrname2(bean.getAdddrname2());
	    	   setAddlicno1(bean.getAddlicno1());
	    	  setAddlicno2(bean.getAddlicno2());
	    	   setExpdate1(bean.getExpdate1());
	    	  setExpdate2(bean.getExpdate2());
	    	  setAdddob1(bean.getAdddob1());
	    	  setAdddob2(bean.getAdddob2());
	    	  
			  setLblvisaexp(bean.getLblvisaexp());
			  setLblvisaissdate(bean.getLblvisaissdate());
	    	  
			   //Extras added in fancy
	    	  
	    	 setLbladdpassno1(bean.getLbladdpassno1());
	    	 setLbladdpassexp1(bean.getLbladdpassexp1());
	    	 setLbladdnation1(bean.getLbladdnation1());
	    	 setLbladdissby1(bean.getLbladdissby1());
	    	 setLbladdpassissued1(bean.getLbladdpassissued1());
	    	 setLbladdissfrom1(bean.getLbladdissfrom1());
	    	 setLbladdid1(bean.getLbladdid1());
	    	  
	    	   setRaextrakm( bean.getRaextrakm());
	    	   setRaexxtakmchg( bean.getRaexxtakmchg());
	    	   setRarenttypes(bean.getRarenttypes());
			 
	    	   setExcessinsu(bean.getExcessinsu()); 
	    	   
	    	   setCompanyname(bean.getCompanyname());
	    	 	  
	    	   setAddress(bean.getAddress());
	    	 
	    	   setMobileno(bean.getMobileno());
	    	  
	    	   setFax(bean.getFax());
	    	   setLocation(bean.getLocation());
	    	 // total  
	    	  
		    	  
	    	   setTotalpaids(bean.getTotalpaid());
	    	    setInvamount(bean.getInvamount());
	    	   setBalance(bean.getBalance());
	    	   
	    	   
	    	   
	    	   
	    	   //dr
	    	    setLblclname(bean.getLblclname());
	    	    setLblcladdress(bean.getLblcladdress());
	    	    setLblclemail(bean.getLblclemail());
	    	    setLblclmobno(bean.getLblclmobno());   
		    	   
	    	     setDrivravehregno(bean.getDrivravehregno());    
	    	     setLblpertel(bean.getLblpertel());
		    	 setLblfaxno(bean.getLblfaxno());
		    	 
		    	 
		    	 setLbldobdate(bean.getLbldobdate());   
		    	 setLblradlno(bean.getLblradlno());
		    	 setLbcardno(bean.getLbcardno());
		    	 setCardtype(bean.getCardtype());
		    	 setLbexpcarddate(bean.getLbexpcarddate());
		    	 
		    	// setLbldobdate    setLblradlno   setLbcardno setLbexpcarddate 	    	   
		    	// System.out.println("=====asdasdas=========="+bean.getLaldelcharge());
		    	 
		    	   setLblpai(bean.getLblpai());
		    	   setLaldelcharge(bean.getLaldelcharge());
		    	   setLblchafcharge(bean.getLblchafcharge());
		    	   
	    	   
		    	    
		    	   setRasupercdw(bean.getRasupercdw());
		    	    setRavmd(bean.getRasupercdw());
		    	    
		    	    setLblpassissdate(bean.getLblpassissdate());
		    	    
		    	    
			    	   
			    	  setDuedate(bean.getDuedate());
			    	  
			    	  setCreatedate(bean.getCreatedate());

				//mm
					setDuetime(bean.getDuetime());

			    	    setRaagent(bean.getRaagent());
			    	   setSalagent(bean.getSalagent());
		    	    //mm
				setSalname(bean.getSalname());
			    	   
			    	   //yetiprint
			    	     //security
			    	   setSecuritycardno(bean.getSecuritycardno());
			    	   setSecurityexpdate(bean.getSecurityexpdate());
			    	   setSecuritypreauthno(bean.getSecuritypreauthno());
			    	   setSecuritypreauthamt(bean.getSecuritypreauthamt()); 
			    	   //totals
			    	   
			    	   setTarifftotal(bean.getTarifftotal());
			    	   setRacdwscdwtotal(bean.getRacdwscdwtotal());
			    	   setRaaccessorytotal(bean.getRaaccessorytotal());
			    	   setLaldelchargetotal(bean.getLaldelchargetotal());
			    	   setAdvtotalamont(bean.getAdvtotalamont());
			    	   setAdvpaidamount(bean.getAdvpaidamount());
			    	   setAdvbalance(bean.getAdvbalance());
			    	   
	    	   
	    	   
	           setUrl(commonDAO.getPrintPath(getFormdetailcode()));
//			   System.out.println("print page="+getUrl());
			   //For Cosmo Print
	           
	           
	           setLblcosmofleetbrand(bean.getLblcosmofleetbrand());
	           setLblcosmofleetno(bean.getLblcosmofleetno());
	           setLblcosmoissuedat(bean.getLblcosmoissuedat());
	           setLblcosmocheckin(bean.getLblcosmocheckin());
	           setLblcosmocheckout(bean.getLblcosmocheckout());
	           setLblcosmokmin(bean.getLblcosmokmin());
	           setLblcosmofuelin(bean.getLblcosmofuelin());
	           setLblcosmocreditcardno(bean.getLblcosmocreditcardno());
	           setLblcosmocreditvaliddate(bean.getLblcosmocreditvaliddate());
	           setLblcosmosecurity(bean.getLblcosmosecurity());
	           setLblcosmoexcessamt(bean.getLblcosmoexcessamt());
	           setLblcosmogps(bean.getLblcosmogps());
	           setLblcosmocollectchg(bean.getLblcosmocollectchg());
	           setLblcosmodamagechg(bean.getLblcosmodamagechg());
	           setLblcosmofuelchg(bean.getLblcosmofuelchg());
	           setLblcosmototal(bean.getLblcosmototal());
	           setLblcosmoadvance(bean.getLblcosmoadvance());
	          
	           setLblcosmobabyseater(bean.getLblcosmobabyseater());
			   setLblcosmodriverlicense(bean.getLblcosmodriverlicense());
	           setLblcosmodrivermobile(bean.getLblcosmodrivermobile());
	           setLblcosmodrivername(bean.getLblcosmodrivername());
	           setLblcosmodrivervalidupto(bean.getLblcosmodrivervalidupto());
	           setLblcosmodriverpassport(bean.getLblcosmodriverpassport());
	           setLblcosmocooler(bean.getLblcosmocooler());
	    	//   System.out.println("=========="+getUrl()+"============"+getFormdetailcode());


			///yessur print
	           
	            setDrivermobno(bean.getDrivermobno());
	            setDrivercountry(bean.getLblnation());
	            setVehiclechasisno(bean.getCh_no());
	            setRdsecuritydeposit(bean.getSecuritypreauthamt());
	            setRentaldetcdw(bean.getRacdwscdw());
	           
	           //yessur print
			
			//For Selcar
	           
	           setSelcaracc(bean.getSelcaracc());
	           setSelcarcdw(bean.getSelcarcdw());
	           setSelcarcdw1(bean.getSelcarcdw1());
	           setSelcarpai(bean.getSelcarpai());
	           setSelcartarif(bean.getSelcartarif());
	           setSelcarvmd(bean.getSelcarvmd());
	           
	           
	           // yes sure
	           
	           setCh_no(bean.getCh_no());


		 //classic print
				
//				System.out.println("RentalAgreementBean.getClsiclpo()=="+bean.getClsiclpo());
				setClsiclpo(bean.getClsiclpo());
				setClcreditcard(bean.getClcreditcard());
				setCladvance(bean.getCladvance());
				setCldesc(bean.getCldesc());
				setGpsprint(bean.getGpsprint());
				setBabyseaterprint(bean.getBabyseaterprint());
				setCladdress2(bean.getCladdress2());
				
				
	        	
				//String dtype=getFormdetailcode();
				
				
				
				//if(commonDAO.getPrintPath(getUrl()).contains(".jrxml")==true){
				if(getUrl().contains(".jrxml")==true){
					 
					
		        	  
		        	          	   
		        	   String reportFileName = "com/operations/agreement/rentalagreement/confident_rentalagreementprint.jrxml";
		        	   
		        		   
		        		   param = new HashMap();
		        		   
//		        		   System.out.println("===== "+bean.getRadaily()+"===== "+bean.getRaweakly()+"======= "+bean.getRamonthly());
		        		  /* String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
		        		   imgpath=imgpath.replace("\\", "\\\\");*/    
		        		   param.put("date",getCreatedate());
		        		  // param.put("createdate",getCreatedate());
		        		   param.put("agmtno", getRentaldoc()+"");
		        		   param.put("hirername", getClname());
		        		   //System.out.println("hirername"+getClient_Name());
		        		   param.put("dname", getRadrname());
		        		   param.put("cartype",getRavehname());
		        		   param.put("regno", getRavehregno());
		        		   param.put("color", getRacolor());
		        		   param.put("model", getRayom());
		        		   param.put("dlicenseno",getRadlno());
		        		   param.put("dissuedby", getLblpassissued());
		        		   param.put("dissuedate", getLblissfromdate());
		        		   param.put("expdate", getLicexpdate());
		        		   param.put("typehire", getLblrentaltype());
		        		   param.put("dailyrate", getRadaily());
		        		   param.put("weeklyrate", getRaweakly());
		        		   param.put("monthlyrate", getRamonthly());
		        		   param.put("passportno", getPassno());
		        		   param.put("nationality", getLblnation());
		        		  if(!bean.getPassno().equalsIgnoreCase(""))
		        		  {
		        		   param.put("issuedate", getLblpassissdate());
		        		   param.put("pexpdate", getPassexpdate());
		        		  }
		        		  else if(!bean.getLblidno().equalsIgnoreCase(""))
		        		  {
		        			  param.put("issuedate", getLblvisaissdate());
			        		  param.put("pexpdate", getLblvisaexp());
		        		  }
		        		  else if(!bean.getPassno().equalsIgnoreCase("") && bean.getLblidno().equalsIgnoreCase("Eidno"))
		        		  {
		        			  param.put("issuedate", getLblpassissdate());
			        		   param.put("pexpdate", getPassexpdate());
		        		  }
		        		   param.put("kmfreedaily", getLblcosmokmrestrictdaily());
		        		   param.put("kmfreeweekly", getLblcosmokmrestrictweekly());
		        		   param.put("kmfreemonthly", getLblcosmokmrestrictmonthly());
		        		   param.put("expreturndate", getDuedate());
		        		   param.put("dob", getDobdate());
		        		   param.put("email", getClemail());
		        		   param.put("phno", getLdllandno());
		        		   param.put("Eidno", getLblidno());
		        		   param.put("dateout", getHidjqxDateOut());
//		        		   System.out.println("dateout"+getHidjqxDateOut());
		        		   param.put("timeout", getHidjqxTimeOut());
		        		   param.put("kmsout", getRe_Km());
		        		   param.put("fuelout", getRatariff_fuel());
		        		   param.put("datein", getIndate());
		        		   param.put("timein", getIntime());
		        		   param.put("kmsin", getInkm());
		        		   param.put("fuelin", getInfuel());
		        		   param.put("cardno", getLbcardno());
		        		   param.put("cardtype", getCardtype());
		        		   param.put("cardexpiry", getLbexpcarddate());
		        		   param.put("platecode", getRavehplate());
//		        		   System.out.println("carddate"+getLbexpcarddate());
		        		   param.put("mobno", getClmobno());
		        		   		   
		        		   
		        		   
		        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));	      	     	 
	     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
	                       generateReportPDF(response, param, jasperReport, conn);
	                       
	                        
				}	   
				}catch (Exception e) {
			       e.printStackTrace();
			       
			   }finally{
        		   conn.close();
        	   }
				
				 
			return("print");
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
		 
		 public String printClosingSummaryAction() throws ParseException, SQLException{
				
				HttpServletRequest request=ServletActionContext.getRequest();
				int docNo=Integer.parseInt(request.getParameter("docno"));
				bean=rentalAgmtDAO.getClosingSummaryPrint(request,docNo);
				setCompanyname(bean.getCompanyname());
				setAddress(bean.getAddress());
				setMobileno(bean.getMobileno());
				setFax(bean.getFax());
				setLocation(bean.getLocation());
				setBranchname(bean.getBranchname());
				setLblclientname(bean.getLblclientname());
				setLblfleetno(bean.getLblfleetno());
				setLblfleetname(bean.getLblfleetname());
				
				setLbldateout(bean.getLbldateout());
				setLbltimeout(bean.getLbltimeout());
				setLblkmout(bean.getLblkmout());
				setLblfuelout(bean.getLblfuelout());
				
				setLbldatein(bean.getLbldatein());
				setLbltimein(bean.getLbltimein());
				setLblkmin(bean.getLblkmin());
				setLblfuelin(bean.getLblfuelin());
				
	setLbldeldate(bean.getLbldeldate());
	setLbldeltime(bean.getLbldeltime());
	setLbldelkm(bean.getLbldelkm());
	setLbldelfuel(bean.getLbldelfuel());
	
	setLblcollectdate(bean.getLblcollectdate());
	setLblcollecttime(bean.getLblcollecttime());
	setLblcollectkm(bean.getLblcollectkm());
	setLblcollectfuel(bean.getLblcollectfuel());
				setLblsumotherdebit(bean.getLblsumotherdebit());
				setLblsumothercredit(bean.getLblsumothercredit());
				
				setLblsumcrvdebit(bean.getLblsumcrvdebit());
				setLblsumcrvcredit(bean.getLblsumcrvcredit());
				
				setLblnetbalance(bean.getLblnetbalance());

				return "print";
			}
		 
		 		 public String printKm() throws SQLException{
			 HttpServletRequest request=ServletActionContext.getRequest();
				int docNo=Integer.parseInt(request.getParameter("docno"));
				bean=rentalAgmtDAO.getKmPrint(request,docNo);
				setKmagmtno(bean.getKmagmtno());
				setKmclient(bean.getKmclient());
				setKmdriver(bean.getKmdriver());
				setKmvehicle(bean.getKmvehicle());
				setKmdate(bean.getKmdate());
				setKmmrano(bean.getKmmrano());
				setLblcompname(bean.getLblcompname());
				setLblcompaddress(bean.getLblcompaddress());
				setLblcomptel(bean.getLblcomptel());
				setLblcompfax(bean.getLblcompfax());
				setLbllocation(bean.getLbllocation());
				setLblbranch(bean.getLblbranch());
				setLblprintname("Km Details");
				setLbltotalallowedkm(bean.getLbltotalallowedkm());
				setLbltotalexcesskm(bean.getLbltotalexcesskm());
				setLbltotalexcesskmrate(bean.getLbltotalexcesskmrate());
//				System.out.println(bean.getLbltotalexcesskm());
//				System.out.println(bean.getLbltotalexcesskmrate());
				setLbltotalusedkm(bean.getLbltotalusedkm());
				setLblrateperkm(bean.getLblrateperkm());
				setLblclstatus(bean.getLblclstatus());
				ClsAmountToWords objamount=new ClsAmountToWords();
				if(Double.parseDouble(bean.getLbltotalexcesskmrate())>0.0){
					setLbltotalexcesskmratewords(objamount.convertAmountToWords(bean.getLbltotalexcesskmrate()));					
				}
				return "print";
		 }
				public String getCh_no() {
					return ch_no;
				}
				public void setCh_no(String ch_no) {
					this.ch_no = ch_no;
				}
				public String getCardtype() {
					return cardtype;
				}
				public void setCardtype(String cardtype) {
					this.cardtype = cardtype;
				}

				public String getVehauth() {
					return vehauth;
				}

				public void setVehauth(String vehauth) {
					this.vehauth = vehauth;
				}

				public String getBranchwisname() {
					return branchwisname;
				}

				public void setBranchwisname(String branchwisname) {
					this.branchwisname = branchwisname;
				}

				

				

				

			

				
		 
		/* public String nooriprintAction() throws ParseException, SQLException{
				
			  HttpServletRequest request=ServletActionContext.getRequest();
			 
			 int doc=Integer.parseInt(request.getParameter("docno"));
			 
			 setDocnoval(request.getParameter("docno"));
			  bean=ClsRentalAgreementDAO.getPrintnoori(doc,request);
			  

	    	   
			  
			  //cl details
			  setClname(bean.getClname());
			  setCladdress(bean.getCladdress());
			  setClemail(bean.getClemail());
			  setClmobno(bean.getClmobno());
			  // main upper
			  setBarnchval(bean.getBarnchval());
			  setMrano(bean.getMrano());
			  setRentaldoc(bean.getRentaldoc());
		
	    	    
	    	    // dr details
			  
			  setRadrname(bean.getRadrname());
			  setRadlno(bean.getRadlno());
			  setPassno(bean.getPassno());
			  setLicexpdate(bean.getLicexpdate());
			  setPassexpdate(bean.getPassexpdate());
			  setDobdate(bean.getDobdate());
			  
			  setLbldrmobno(bean.getLbldrmobno());
			  setLblplaceissue(bean.getLblplaceissue());
			  
			
			  
			  // veh details
			  
			  setRavehname(bean.getRavehname());
			  setRavehgroup(bean.getRavehgroup());
			  setRavehmodel(bean.getRavehmodel());
			  setRavehregno(bean.getRavehregno());
			  setRadateout(bean.getRadateout());
			  setRatimeout(bean.getRatimeout());
			  setRaklmout(bean.getRaklmout());
			  
			  setLbfueltype(bean.getLbfueltype());
			  setLbmodel(bean.getLbmodel());
			
	    	    
			
		
			//  setTariff(bean.getTariff());
			//  setRacdwscdw(bean.getRacdwscdw());
			//  setRaaccessory(bean.getRaaccessory());
			//  setRaadditionalcge(bean.getRaadditionalcge());
			  
			  //-------------------
			  
			  setInkm(bean.getInkm());
			  setInfuel(bean.getInfuel());
			  setIndate(bean.getIndate());
			  setIntime(bean.getIntime());
			  setRastatus(bean.getRastatus());
//new
			  setKmused(bean.getKmused());
			  setNoofdays(bean.getNoofdays());
			  
			  setPertel(bean.getPertel());
			  setFaxno(bean.getFaxno());
			    
			
	    	         
	    	    
			  
			  setRafuelout(bean.getRafuelout());

			  setRayom(bean.getRayom());
	    	  setRacolor(bean.getRacolor()) ;
	    	  
	    	  //------------------------------------------
	    	  
	    	   setAdddrname1(bean.getAdddrname1());
	    	   setAddlicno1(bean.getAddlicno1());
	    	   setExpdate1(bean.getExpdate1());
	    	  setAdddob1(bean.getAdddob1());
	    
	    	  setLbldrmobno1(bean.getLbldrmobno1());
	    	  setLblplaceissue1(bean.getLblplaceissue1());
	    	  setLbpassexpdate1(bean.getLbpassexpdate1());
	    	  setPassno1(bean.getPassno1());
	    	  
	 
	    	  //------------------
	    	  
	    	   setRaextrakm( bean.getRaextrakm());
	    	   setRaexxtakmchg( bean.getRaexxtakmchg());
	    	   setRarenttypes(bean.getRarenttypes());
			 
	    	  // setExcessinsu(bean.getExcessinsu()); 
	    	   setCompanyname(bean.getCompanyname());
	    	   setAddress(bean.getAddress());
	    	   setMobileno(bean.getMobileno());
	    	  
	    	//new 
	    	   setLbmasterdate(bean.getLbmasterdate());
	    	   setLbexpcarddate(bean.getLbexpcarddate());
	    	  
	    	  // setLbmasterdate   setLbexpcarddate
	    	   setLbsecurity(bean.getLbsecurity());
	    	   
	    	   
	   // hide
	    	   
	    	   
	    	   setFirstarray(bean.getFirstarray());
	    	   
	    	   setUrl(ClsCommon.getPrintPath("RAG"));
			 return "print";
			 }	
	*/
}


