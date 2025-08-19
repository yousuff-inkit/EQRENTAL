package com.operations.agreement.leaseagmtformasteralmariah;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.text.SimpleDateFormat;
import java.util.Date;

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

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
import com.operations.agreement.leaseagmtformaster.*;;

public class ClsLeaseAgmtForMasterAlmariahAction extends ActionSupport{
	ClsLeaseAgmtForMasterAlmariahDAO leaseAgmtDAO= new ClsLeaseAgmtForMasterAlmariahDAO();
	ClsCommon commonDAO=new ClsCommon();
	ClsConnection conobj=new ClsConnection();
	ClsLeaseAgmtForMasterAlmariahBean LeaseAgreementBean;
	ClsLeaseAgmtForMasterAlmariahBean bean;
	ClsLeaseAgmtForMasterAlmariahBean mainbean;
	
	private String cmbmasterreftype,hidcmbmasterreftype,masterrefno,hidmasterrefno,hidmasterrefsrno,clsiclpo;
	private String lblcurrentdate;
		
				private String lbldeldate;
				private String lbldeltime;
				private String lbldelkm;
				private String lbldelfuel;
				private String lblcollectdate;
				private String lblcollecttime;
				private String lblcollectkm;
				private String lblcollectfuel;
				
				
				public String getHidmasterrefsrno() {
					return hidmasterrefsrno;
				}

				public void setHidmasterrefsrno(String hidmasterrefsrno) {
					this.hidmasterrefsrno = hidmasterrefsrno;
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

	
	public String getLblcurrentdate() {
		return lblcurrentdate;
	}

	public void setLblcurrentdate(String lblcurrentdate) {
		this.lblcurrentdate = lblcurrentdate;
	}
	
	public String getClsiclpo() {
		return clsiclpo;
	}

	public void setClsiclpo(String clsiclpo) {
		this.clsiclpo = clsiclpo;
	}

	public String getCmbmasterreftype() {
		return cmbmasterreftype;
	}

	public void setCmbmasterreftype(String cmbmasterreftype) {
		this.cmbmasterreftype = cmbmasterreftype;
	}

	public String getHidcmbmasterreftype() {
		return hidcmbmasterreftype;
	}

	public void setHidcmbmasterreftype(String hidcmbmasterreftype) {
		this.hidcmbmasterreftype = hidcmbmasterreftype;
	}

	public String getMasterrefno() {
		return masterrefno;
	}

	public void setMasterrefno(String masterrefno) {
		this.masterrefno = masterrefno;
	}

	public String getHidmasterrefno() {
		return hidmasterrefno;
	}

	public void setHidmasterrefno(String hidmasterrefno) {
		this.hidmasterrefno = hidmasterrefno;
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

	public String getLblclstatus() {
		return lblclstatus;
	}

	public void setLblclstatus(String lblclstatus) {
		this.lblclstatus = lblclstatus;
	}

	//  main 
	//-----------------------------------------------------------------------------
	private int docno;
	private String date;
	private String hiddate;
	private int clientid;
	private String salesman;
	private String clientname;
	private int le_salmanid;
	private String le_clcodeno;
	private String le_clacno;
	private String description;
	private String cusaddress;
	private int additional_driver;
	private String add_driverName;
	private int add_drchk;
	private String hidoutdate;
	private String hidouttime;
	private String hidcmbtype;
	private String hiddeloutdate;
	private String hiddelouttime;
	private String hiddelcmbtype; 
	private String mode;
	private String adidrvcharges;
	private String ladriverlist;
	private int ladrivercheck;
	private int chaffchkvalue;
	private String tempfleet;
	private String permanentfleet;
	private String fleetname;
	private int chkdelivery;
	private int delchkvalue;
	private String dateout;
	private String timeout;
	private String kmout;
	private String cmbfuelout;
	private String deldateout;
	private String deltimeout;
	private String delkmout;
	private String cmbdelfuelout;
	private String m1;
	private String m2;
	private String m3;
	private String m4;
	private String m5;
	private String m6;
	private String m7;
	private String m8;
	private String m9;
	private String m10;
	private String amt1;
	private String amt2;
	private String amt3;
	private String amt4;
	private String amt5;
	private int per_value;
	private int per_name;
	private int advance_chk;
	private int invoice;
	private int hidper_value;
	private int hidper_name;
	private int hidadvance_chk;
	private int hidinvoice;
	private int del_chaufferid,newvehdetalslenght;
	private String msg,vehlocation,formdetailcode,delcharges;
	
	 private String excessinsur,deldrvname;
	 
	 
	 private int  deldrvid,masterdoc_no;
	  private int  leaseprojectDoc;
	  
	  private String leasePo,leaseproject; 
	
	 private String url;
	 private String url2;
	// --------------------------------------master down print-------------------------------------------------------------------
	 private String clname,claddress,clmobno,clemail,barnchval,mrano,rentaldoc,radrname,radlno,passno,licexpdate,passexpdate,dobdate,checkbranch;
	 
	 private String excessinsu,trafficcharge,salikcharge;
		private String ravehname,ravehregno,ravehmodel,ravehgroup,radateout,ratimeout,raklmout; 
		 
		 
		 private String radaily,raweakly,ramonthly,tariff,racdwscdw,raaccessory,raadditionalcge,rafuelout,totalpaids,invamount,balance;
		 
		 private String inkm,infuel,indate,intime,docnoval,rastatus,rayom,racolor,adddrname1,adddrname2,addlicno1,addlicno2,expdate1,expdate2,adddob1,adddob2,raextrakm,raexxtakmchg,rarenttypes;
		private String companyname,address,mobileno,fax,location;
	// --------------------------------------------------------------------------------------------------------------------
	
		
		//---------------------------------main print-------------------------------------------------------------------
		
		
		private String txtcustomersname,txtaddress,txtcontact,vehicledetails,vehduration,vehcostpermonth,kmrest,clientnames,lbllessorcompany,termi1,termi2,termi3,termi4,termi5;
		
	//-----------------------------------------------------------------------------------------------------	
		

		//mm

		private String salname,leasestatus;
		

			private String deldates,deltimes,delkmins,delfuels,outdetails,deldetailss;

					//mm

					public String getOutdetails() {
						return outdetails;
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
		


		public String getSalname() {
			return salname;
		}

		public void setSalname(String salname) {
			this.salname = salname;
		}
		public String getLeasestatus() {
					return leasestatus;
				}

				public void setLeasestatus(String leasestatus) {
					this.leasestatus = leasestatus;
				}

		


		public String getTermi1() {
			return termi1;
		}

		public void setTermi1(String termi1) {
			this.termi1 = termi1;
		}

		public String getTermi2() {
			return termi2;
		}

		public void setTermi2(String termi2) {
			this.termi2 = termi2;
		}

		public String getTermi3() {
			return termi3;
		}

		public void setTermi3(String termi3) {
			this.termi3 = termi3;
		}

		public String getTermi4() {
			return termi4;
		}

		public void setTermi4(String termi4) {
			this.termi4 = termi4;
		}

		public String getTermi5() {
			return termi5;
		}

		public void setTermi5(String termi5) {
			this.termi5 = termi5;
		}

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
		
				
				
				
		
		        public String getCheckbranch() {
					return checkbranch;
				}

				public void setCheckbranch(String checkbranch) {
					this.checkbranch = checkbranch;
				}

		      public String getExcessinsu() {
					return excessinsu;
				}

				public void setExcessinsu(String excessinsu) { 
					this.excessinsu = excessinsu;
				}

				public String getTrafficcharge() {
					return trafficcharge;
				}

				public void setTrafficcharge(String trafficcharge) {
					this.trafficcharge = trafficcharge;
				}

				public String getSalikcharge() {
					return salikcharge;
				}

				public void setSalikcharge(String salikcharge) {
					this.salikcharge = salikcharge;
				}

		public int getLeaseprojectDoc() {
					return leaseprojectDoc;
				}

				public void setLeaseprojectDoc(int leaseprojectDoc) {
					this.leaseprojectDoc = leaseprojectDoc;
				}

				public String getLeasePo() {
					return leasePo;
				}

				public void setLeasePo(String leasePo) {
					this.leasePo = leasePo;
				}

				public String getLeaseproject() {
					return leaseproject;
				}

				public void setLeaseproject(String leaseproject) {
					this.leaseproject = leaseproject;
				}

		public int getMasterdoc_no() {
					return masterdoc_no;
				}

				public void setMasterdoc_no(int masterdoc_no) {
					this.masterdoc_no = masterdoc_no;
				}

		public String getUrl() {
					return url;
				}

				public void setUrl(String url) {
					this.url = url;
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

		public int getNewvehdetalslenght() {
			return newvehdetalslenght;
		}

		public void setNewvehdetalslenght(int newvehdetalslenght) {
			this.newvehdetalslenght = newvehdetalslenght;
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
	
	public int getClientid() {
		return clientid;
	}
	public void setClientid(int clientid) {
		this.clientid = clientid;
	}
	
	
	public String getSalesman() {
		return salesman;
	}
	public void setSalesman(String salesman) {
		this.salesman = salesman;
	}
	public String getClientname() {
		return clientname;
	}
	public void setClientname(String clientname) {
		this.clientname = clientname;
	}
	public int getLe_salmanid() {
		return le_salmanid;
	}
	public void setLe_salmanid(int le_salmanid) {
		this.le_salmanid = le_salmanid;
	}
	public String getLe_clcodeno() {
		return le_clcodeno;
	}
	public void setLe_clcodeno(String le_clcodeno) {
		this.le_clcodeno = le_clcodeno;
	}
	public String getLe_clacno() {
		return le_clacno;
	}
	public void setLe_clacno(String le_clacno) {
		this.le_clacno = le_clacno;
	}

	 public String getCusaddress() {
			return cusaddress;
	}
	public void setCusaddress(String cusaddress) {
		this.cusaddress = cusaddress;
	}
	public String getLadriverlist() {
		return ladriverlist;
	}
	public void setLadriverlist(String ladriverlist) {
		this.ladriverlist = ladriverlist;
	}
	
	public int getAdditional_driver() {
		return additional_driver;
	}
	public void setAdditional_driver(int additional_driver) {
		this.additional_driver = additional_driver;
	}
	
	public String getAdd_driverName() {
		return add_driverName;
	}
	public void setAdd_driverName(String add_driverName) {
		this.add_driverName = add_driverName;
	}
	public String getAdidrvcharges() {
		return adidrvcharges;
	}
	public void setAdidrvcharges(String adidrvcharges) {
		this.adidrvcharges = adidrvcharges;
	}
	
	public int getLadrivercheck() {
		return ladrivercheck;
	}
	public void setLadrivercheck(int ladrivercheck) {
		this.ladrivercheck = ladrivercheck;
	}
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getTempfleet() {
		return tempfleet;
	}
	public void setTempfleet(String tempfleet) {
		this.tempfleet = tempfleet;
	}
	public String getPermanentfleet() {
		return permanentfleet;
	}
	public void setPermanentfleet(String permanentfleet) {
		this.permanentfleet = permanentfleet;
	}
	public String getFleetname() {
		return fleetname;
	}
	public void setFleetname(String fleetname) {
		this.fleetname = fleetname;
	}
	public int getChkdelivery() {
		return chkdelivery;
	}
	public void setChkdelivery(int chkdelivery) {
		this.chkdelivery = chkdelivery;
	}
	public String getDateout() {
		return dateout;
	}
	public void setDateout(String dateout) {
		this.dateout = dateout;
	}
	public String getTimeout() {
		return timeout;
	}
	public void setTimeout(String timeout) {
		this.timeout = timeout;
	}
	public String getKmout() {
		return kmout;
	}
	public void setKmout(String kmout) {
		this.kmout = kmout;
	}
	public String getCmbfuelout() {
		return cmbfuelout;
	}
	public void setCmbfuelout(String cmbfuelout) {
		this.cmbfuelout = cmbfuelout;
	}
	public String getDeldateout() {
		return deldateout;
	}
	public void setDeldateout(String deldateout) {
		this.deldateout = deldateout;
	}
	public String getDeltimeout() {
		return deltimeout;
	}
	public void setDeltimeout(String deltimeout) {
		this.deltimeout = deltimeout;
	}
	public String getDelkmout() {
		return delkmout;
	}
	public void setDelkmout(String delkmout) {
		this.delkmout = delkmout;
	}
	public String getCmbdelfuelout() {
		return cmbdelfuelout;
	}
	public void setCmbdelfuelout(String cmbdelfuelout) {
		this.cmbdelfuelout = cmbdelfuelout;
	}
	public String getM1() {
		return m1;
	}
	public void setM1(String m1) {
		this.m1 = m1;
	}
	public String getM2() {
		return m2;
	}
	public void setM2(String m2) {
		this.m2 = m2;
	}
	public String getM3() {
		return m3;
	}
	public void setM3(String m3) {
		this.m3 = m3;
	}
	public String getM4() {
		return m4;
	}
	public void setM4(String m4) {
		this.m4 = m4;
	}
	public String getM5() {
		return m5;
	}
	public void setM5(String m5) {
		this.m5 = m5;
	}
	public String getM6() {
		return m6;
	}
	public void setM6(String m6) {
		this.m6 = m6;
	}
	public String getM7() {
		return m7;
	}
	public void setM7(String m7) {
		this.m7 = m7;
	}
	public String getM8() {
		return m8;
	}
	public void setM8(String m8) {
		this.m8 = m8;
	}
	public String getM9() {
		return m9;
	}
	public void setM9(String m9) {
		this.m9 = m9;
	}
	public String getM10() {
		return m10;
	}
	public void setM10(String m10) {
		this.m10 = m10;
	}
	
	public String getAmt1() {
		return amt1;
	}
	public void setAmt1(String amt1) {
		this.amt1 = amt1;
	}
	public String getAmt2() {
		return amt2;
	}
	public void setAmt2(String amt2) {
		this.amt2 = amt2;
	}
	public String getAmt3() {
		return amt3;
	}
	public void setAmt3(String amt3) {
		this.amt3 = amt3;
	}
	public String getAmt4() {
		return amt4;
	}
	public void setAmt4(String amt4) {
		this.amt4 = amt4;
	}
	public String getAmt5() {
		return amt5;
	}
	public void setAmt5(String amt5) {
		this.amt5 = amt5;
	}
	
	public int getDel_chaufferid() {
		return del_chaufferid;
	}
	public void setDel_chaufferid(int del_chaufferid) {
		this.del_chaufferid = del_chaufferid;
	}
	
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
	
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	public String getHidoutdate() {
		return hidoutdate;
	}
	public void setHidoutdate(String hidoutdate) {
		this.hidoutdate = hidoutdate;
	}
	public String getHidouttime() {
		return hidouttime;
	}
	public void setHidouttime(String hidouttime) {
		this.hidouttime = hidouttime;
	}
	public String getHidcmbtype() {
		return hidcmbtype;
	}
	public void setHidcmbtype(String hidcmbtype) {
		this.hidcmbtype = hidcmbtype;
	}
	public String getHiddeloutdate() {
		return hiddeloutdate;
	}
	public void setHiddeloutdate(String hiddeloutdate) {
		this.hiddeloutdate = hiddeloutdate;
	}
	public String getHiddelouttime() {
		return hiddelouttime;
	}
	public void setHiddelouttime(String hiddelouttime) {
		this.hiddelouttime = hiddelouttime;
	}
	public String getHiddelcmbtype() {
		return hiddelcmbtype;
	}
	public void setHiddelcmbtype(String hiddelcmbtype) {
		this.hiddelcmbtype = hiddelcmbtype;
	}
	
	
		public int getPer_value() {
			return per_value;
		}
		public void setPer_value(int per_value) {
			this.per_value = per_value;
		}
		public int getPer_name() {
			return per_name;
		}
		public void setPer_name(int per_name) {
			this.per_name = per_name;
		}
		public int getAdvance_chk() {
			return advance_chk;
		}
		public void setAdvance_chk(int advance_chk) {
			this.advance_chk = advance_chk;
		}
		public int getInvoice() {
			return invoice;
		}
		public void setInvoice(int invoice) {
			this.invoice = invoice;
		}
		public int getHidper_value() {
			return hidper_value;
		}
		public void setHidper_value(int hidper_value) {
			this.hidper_value = hidper_value;
		}
		public int getHidper_name() {
			return hidper_name;
		}
		public void setHidper_name(int hidper_name) {
			this.hidper_name = hidper_name;
		}
		public int getHidadvance_chk() {
			return hidadvance_chk;
		}
		public void setHidadvance_chk(int hidadvance_chk) {
			this.hidadvance_chk = hidadvance_chk;
		}
		public int getHidinvoice() {
			return hidinvoice;
		}
		public void setHidinvoice(int hidinvoice) {
			this.hidinvoice = hidinvoice;
		}

		
		

//grid


		public String getUrl2() {
			return url2;
		}

		public void setUrl2(String url2) {
			this.url2 = url2;
		}

		public String getDelcharges() {
			return delcharges;
		}
		public void setDelcharges(String delcharges) {
			this.delcharges = delcharges;
		}




		// payment grid
		 private int paymentgridlength;
	
		 public int getPaymentgridlength() {
				return paymentgridlength;
			}
			public void setPaymentgridlength(int paymentgridlength) {
				this.paymentgridlength = paymentgridlength;
			}
			
		//  tariff grid
			private int tariffgridlength;
			
			public int getTariffgridlength() {
				return tariffgridlength;
			}
			
			public void setTariffgridlength(int tariffgridlength) {
				this.tariffgridlength = tariffgridlength;
			}
			
			
			// driver grid
			
			private int drivergridlength;
			
			public int getDrivergridlength() {
				return drivergridlength;
			}
			public void setDrivergridlength(int drivergridlength) {
				this.drivergridlength = drivergridlength;
			}
			
			public String getMode() {
				  return mode;
				}
				
			
				public void setMode(String mode) {
					this.mode = mode;
				}
			

	//---------------------------------------------------------------------------
				
				public String getExcessinsur() {
					return excessinsur;
				}

				public void setExcessinsur(String excessinsur) {
					this.excessinsur = excessinsur;
				}

				public String getVehlocation() {
					return vehlocation;
				}
				public void setVehlocation(String vehlocation) {
					this.vehlocation = vehlocation;
				}	
			
			

	
	

	public String getFormdetailcode() {
					return formdetailcode;
				}
				public void setFormdetailcode(String formdetailcode) {
					this.formdetailcode = formdetailcode;
				}
				
				
			//	----------------------------------------------------------------------------
				
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
				public String getRadaily() {
					return radaily;
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
				public String getRafuelout() {
					return rafuelout;
				}
				public void setRafuelout(String rafuelout) {
					this.rafuelout = rafuelout;
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
				public String getDocnoval() {
					return docnoval;
				}
				public void setDocnoval(String docnoval) {
					this.docnoval = docnoval;
				}
				public String getRastatus() {
					return rastatus;
				}
				public void setRastatus(String rastatus) {
					this.rastatus = rastatus;
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
				public String getRarenttypes() {
					return rarenttypes;
				}
				public void setRarenttypes(String rarenttypes) {
					this.rarenttypes = rarenttypes;
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
				
				
				
				//--------------------------------------------------
				
				

				public String getTxtcustomersname() {
				return txtcustomersname;
			}
			public void setTxtcustomersname(String txtcustomersname) {
				this.txtcustomersname = txtcustomersname;
			}
			public String getTxtaddress() {
				return txtaddress;
			}
			public void setTxtaddress(String txtaddress) {
				this.txtaddress = txtaddress;
			}
			public String getTxtcontact() {
				return txtcontact;
			}
			public void setTxtcontact(String txtcontact) {
				this.txtcontact = txtcontact;
			}	
				
				
			public String getKmrest() {
				return kmrest;
			}
			public void setKmrest(String kmrest) {
				this.kmrest = kmrest;
			}		
				
				
	public String getVehicledetails() {
				return vehicledetails;
			}
			public void setVehicledetails(String vehicledetails) {
				this.vehicledetails = vehicledetails;
			}
			public String getVehduration() {
				return vehduration;
			}
			public void setVehduration(String vehduration) {
				this.vehduration = vehduration;
			}
			public String getVehcostpermonth() {
				return vehcostpermonth;
			}
			public void setVehcostpermonth(String vehcostpermonth) {
				this.vehcostpermonth = vehcostpermonth;
			}
			
			public String getClientnames() {
				return clientnames;
			}

			public void setClientnames(String clientnames) {
				this.clientnames = clientnames;
			}

			public String getLbllessorcompany() {
				return lbllessorcompany;
			}

			public void setLbllessorcompany(String lbllessorcompany) {
				this.lbllessorcompany = lbllessorcompany;
			}
			
			
			
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
			
			
			
			
			

	    public String getDeldrvname() {
				return deldrvname;
			}

			public void setDeldrvname(String deldrvname) {
				this.deldrvname = deldrvname;
			}

			public int getDeldrvid() {
				return deldrvid;
			}

			public void setDeldrvid(int deldrvid) {
				this.deldrvid = deldrvid;
			}
			
			
			
					
	//Getters and setters for Cosmo Print
			
	private String lblcosmoagmtno;
	private String lblcosmoclientname;
	private String lblcosmoclientaddress;
	private String lblcosmoclientmobile;
	private String lblcosmofleetno;
	private String lblcosmoregno;
	private String lblcosmoyom;
	private String lblcosmomodel;
	private String lblcosmocolor;
	private String lblcosmoengine;
	private String lblcosmochassis;
	private String lblcosmobrand;
	private String lblcosmoduration;
	private String lblcosmostartdate;
	private String lblcosmoenddate;
	private String lblcosmoagreedrate;
	private String lblexcessamt;
	private String lblcosmoterm1;
	private String lblcosmoterm2;
	private String lblcosmoterm3;
	private String lblcosmoterm4;
	private String lblcosmoterm5;
	private String lblcosmoterm6;
	private String lblcosmoterm7;
	private String lblcosmoterm8;
	private String lblcosmoterm9;
	private String lblcosmoterm10;
	private String lblcosmoamt1;
	private String lblcosmoamt2;
	private String lblcosmoamt3;
	private String lblcosmoamt4;
	private String lblcosmoamt5;
	private String lblcosmoregdetails;
	private String lblcosmoagreedratewords;
	private String lblcosmoexcessamt;
	
	
	public String getLblcosmoexcessamt() {
		return lblcosmoexcessamt;
	}

	public void setLblcosmoexcessamt(String lblcosmoexcessamt) {
		this.lblcosmoexcessamt = lblcosmoexcessamt;
	}
	
	public String getLblcosmoregdetails() {
		return lblcosmoregdetails;
	}

	public void setLblcosmoregdetails(String lblcosmoregdetails) {
		this.lblcosmoregdetails = lblcosmoregdetails;
	}

	public String getLblcosmoclientaddress() {
		return lblcosmoclientaddress;
	}

	public void setLblcosmoclientaddress(String lblcosmoclientaddress) {
		this.lblcosmoclientaddress = lblcosmoclientaddress;
	}

	public String getLblcosmoagmtno() {
		return lblcosmoagmtno;
	}

	public void setLblcosmoagmtno(String lblcosmoagmtno) {
		this.lblcosmoagmtno = lblcosmoagmtno;
	}

	public String getLblcosmoclientname() {
		return lblcosmoclientname;
	}

	public void setLblcosmoclientname(String lblcosmoclientname) {
		this.lblcosmoclientname = lblcosmoclientname;
	}

	
	public String getLblcosmoclientmobile() {
		return lblcosmoclientmobile;
	}

	public void setLblcosmoclientmobile(String lblcosmoclientmobile) {
		this.lblcosmoclientmobile = lblcosmoclientmobile;
	}

	public String getLblcosmofleetno() {
		return lblcosmofleetno;
	}

	public void setLblcosmofleetno(String lblcosmofleetno) {
		this.lblcosmofleetno = lblcosmofleetno;
	}

	public String getLblcosmoregno() {
		return lblcosmoregno;
	}

	public void setLblcosmoregno(String lblcosmoregno) {
		this.lblcosmoregno = lblcosmoregno;
	}

	public String getLblcosmoyom() {
		return lblcosmoyom;
	}

	public void setLblcosmoyom(String lblcosmoyom) {
		this.lblcosmoyom = lblcosmoyom;
	}

	public String getLblcosmomodel() {
		return lblcosmomodel;
	}

	public void setLblcosmomodel(String lblcosmomodel) {
		this.lblcosmomodel = lblcosmomodel;
	}

	public String getLblcosmocolor() {
		return lblcosmocolor;
	}

	public void setLblcosmocolor(String lblcosmocolor) {
		this.lblcosmocolor = lblcosmocolor;
	}

	public String getLblcosmoengine() {
		return lblcosmoengine;
	}

	public void setLblcosmoengine(String lblcosmoengine) {
		this.lblcosmoengine = lblcosmoengine;
	}

	public String getLblcosmochassis() {
		return lblcosmochassis;
	}

	public void setLblcosmochassis(String lblcosmochassis) {
		this.lblcosmochassis = lblcosmochassis;
	}

	public String getLblcosmobrand() {
		return lblcosmobrand;
	}

	public void setLblcosmobrand(String lblcosmobrand) {
		this.lblcosmobrand = lblcosmobrand;
	}

	public String getLblcosmoduration() {
		return lblcosmoduration;
	}

	public void setLblcosmoduration(String lblcosmoduration) {
		this.lblcosmoduration = lblcosmoduration;
	}

	public String getLblcosmostartdate() {
		return lblcosmostartdate;
	}

	public void setLblcosmostartdate(String lblcosmostartdate) {
		this.lblcosmostartdate = lblcosmostartdate;
	}

	public String getLblcosmoenddate() {
		return lblcosmoenddate;
	}

	public void setLblcosmoenddate(String lblcosmoenddate) {
		this.lblcosmoenddate = lblcosmoenddate;
	}

	public String getLblcosmoagreedrate() {
		return lblcosmoagreedrate;
	}

	public void setLblcosmoagreedrate(String lblcosmoagreedrate) {
		this.lblcosmoagreedrate = lblcosmoagreedrate;
	}

	public String getLblexcessamt() {
		return lblexcessamt;
	}

	public void setLblexcessamt(String lblexcessamt) {
		this.lblexcessamt = lblexcessamt;
	}

	public String getLblcosmoterm1() {
		return lblcosmoterm1;
	}

	public void setLblcosmoterm1(String lblcosmoterm1) {
		this.lblcosmoterm1 = lblcosmoterm1;
	}

	public String getLblcosmoterm2() {
		return lblcosmoterm2;
	}

	public void setLblcosmoterm2(String lblcosmoterm2) {
		this.lblcosmoterm2 = lblcosmoterm2;
	}

	public String getLblcosmoterm3() {
		return lblcosmoterm3;
	}

	public void setLblcosmoterm3(String lblcosmoterm3) {
		this.lblcosmoterm3 = lblcosmoterm3;
	}

	public String getLblcosmoterm4() {
		return lblcosmoterm4;
	}

	public void setLblcosmoterm4(String lblcosmoterm4) {
		this.lblcosmoterm4 = lblcosmoterm4;
	}

	public String getLblcosmoterm5() {
		return lblcosmoterm5;
	}

	public void setLblcosmoterm5(String lblcosmoterm5) {
		this.lblcosmoterm5 = lblcosmoterm5;
	}

	public String getLblcosmoterm6() {
		return lblcosmoterm6;
	}

	public void setLblcosmoterm6(String lblcosmoterm6) {
		this.lblcosmoterm6 = lblcosmoterm6;
	}

	public String getLblcosmoterm7() {
		return lblcosmoterm7;
	}

	public void setLblcosmoterm7(String lblcosmoterm7) {
		this.lblcosmoterm7 = lblcosmoterm7;
	}

	public String getLblcosmoterm8() {
		return lblcosmoterm8;
	}

	public void setLblcosmoterm8(String lblcosmoterm8) {
		this.lblcosmoterm8 = lblcosmoterm8;
	}

	public String getLblcosmoterm9() {
		return lblcosmoterm9;
	}

	public void setLblcosmoterm9(String lblcosmoterm9) {
		this.lblcosmoterm9 = lblcosmoterm9;
	}

	public String getLblcosmoterm10() {
		return lblcosmoterm10;
	}

	public void setLblcosmoterm10(String lblcosmoterm10) {
		this.lblcosmoterm10 = lblcosmoterm10;
	}

	public String getLblcosmoamt1() {
		return lblcosmoamt1;
	}

	public void setLblcosmoamt1(String lblcosmoamt1) {
		this.lblcosmoamt1 = lblcosmoamt1;
	}

	public String getLblcosmoamt2() {
		return lblcosmoamt2;
	}

	public void setLblcosmoamt2(String lblcosmoamt2) {
		this.lblcosmoamt2 = lblcosmoamt2;
	}

	public String getLblcosmoamt3() {
		return lblcosmoamt3;
	}

	public void setLblcosmoamt3(String lblcosmoamt3) {
		this.lblcosmoamt3 = lblcosmoamt3;
	}

	public String getLblcosmoamt4() {
		return lblcosmoamt4;
	}

	public void setLblcosmoamt4(String lblcosmoamt4) {
		this.lblcosmoamt4 = lblcosmoamt4;
	}

	public String getLblcosmoamt5() {
		return lblcosmoamt5;
	}

	public void setLblcosmoamt5(String lblcosmoamt5) {
		this.lblcosmoamt5 = lblcosmoamt5;
	}

	public String getLblcosmoagreedratewords() {
		return lblcosmoagreedratewords;
	}

	public void setLblcosmoagreedratewords(String lblcosmoagreedratewords) {
		this.lblcosmoagreedratewords = lblcosmoagreedratewords;
	}

	private String lblpai;
	
	public String getLblpai() {
		return lblpai;
	}

	public void setLblpai(String lblpai) {
		this.lblpai = lblpai;
	}
	
	
	private Map<String, Object> param = null;
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	public String saveAction() throws ParseException, SQLException{
		
	
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		String formcode="";
		int val=0;
		
			 
	
		
		 Map<String, String[]> requestParams = request.getParameterMap();
		
				
		
           if(mode.equalsIgnoreCase("A")){
        	   
        	   int per_name=getPer_name();
        	   int per_value=getPer_value();
        	   int advance_chk=getAdvance_chk();
        	   int invoice=getInvoice();
        	  
        	   java.sql.Date sqlleaseDate = commonDAO.changeStringtoSqlDate(getDate());
        	   
        	   ArrayList<String> lagmttariffarray= new ArrayList<>();
				for(int i=0;i<getTariffgridlength();i++){
				 String temp=requestParams.get("test"+i)[0];
				 
				 lagmttariffarray.add(temp);
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
				ArrayList<String> vehdetarray= new ArrayList<>();
				for(int i=0;i<getNewvehdetalslenght();i++){
				 String temp4=requestParams.get("vehtest"+i)[0];
				 vehdetarray.add(temp4);
				 
				}
				
				
				
			//System.out.println("action array"+driverarray);
			
				
			val=leaseAgmtDAO.insert(sqlleaseDate,getClientid(),getLe_salmanid(),getDescription(),getLe_clcodeno(),
					getLe_clacno(),getAdditional_driver(),getAdidrvcharges(),getLadrivercheck(),
					getDel_chaufferid(),getChkdelivery(),getTempfleet(),getPermanentfleet(),
					getFleetname(),getDateout(),getTimeout(),getKmout(),getCmbfuelout(),getDeldateout(),getDeltimeout(),getDelkmout(),
					getCmbdelfuelout(),getM1(),getM2(),getM3(),getM4(),getM5(),getM6(),getM7(),getM8(),getM9(),getM10(),getAmt1(),
					getAmt2(),getAmt3(),getAmt4(),getAmt5(),driverarray,lagmttariffarray,paymentarray,mode,session,formcode,per_name,per_value, 
					advance_chk,invoice,getVehlocation(),getFormdetailcode(),getClientname(),request,vehdetarray,getExcessinsur(),
					getLeaseprojectDoc(),getLeasePo(),getCmbmasterreftype(),getHidmasterrefno(),getHidmasterrefsrno());
			int vocno= (int) request.getAttribute("vocno");
			if(val>0){
				reloadData(val);
				setMasterdoc_no(val);
				
				 setDocno(vocno);
				 setHiddate(sqlleaseDate.toString());
					setDelchkvalue(0);
				 
				setMsg("Successfully Saved");
			
				return "success";
			}
			else{
				setHiddate(sqlleaseDate.toString());
				setMasterdoc_no(val);
				
				 setDocno(vocno);
				   reloadData(val);
				   setDelchkvalue(0);
					setMsg("Not Saved");
				return "fail";
			}	
			
           }
          
       else if(mode.equalsIgnoreCase("ADD")){
        	
    	   java.sql.Date sqlleaseDate = commonDAO.changeStringtoSqlDate(getDate());
    	   java.sql.Date sqlDateout = commonDAO.changeStringtoSqlDate(getDateout());
  
    	   ArrayList<String> paymentarray= new ArrayList<>();
			for(int i=0;i<getPaymentgridlength();i++){
			 String temp2=requestParams.get("paytest"+i)[0];
			 paymentarray.add(temp2);
			 
			}
        	  boolean Status=leaseAgmtDAO.update(getMasterdoc_no(),sqlleaseDate,getChkdelivery(),getTempfleet(),getPermanentfleet(),
  					sqlDateout,getTimeout(),getKmout(),getCmbfuelout(),getVehlocation(),mode,session,invoice,paymentarray,getDelcharges(),getDeldrvid(),getClientid());
        	  if(Status){
        		  
        		
        		     setDocno(getDocno());
        		     setMasterdoc_no(getMasterdoc_no());
        			reloadData(val);
        			
        			setChkdelivery(getChkdelivery());
    				setDelchkvalue(getChkdelivery());
    				setTempfleet(getTempfleet());
    				setPermanentfleet(getPermanentfleet());
    				setFleetname(getFleetname());
    				
    				setHiddate(sqlleaseDate.toString());
    				setHidoutdate(sqlDateout.toString());
    				
    				setDeldrvid(getDeldrvid());
    				setDeldrvname(getDeldrvname());
    				
    				
    				setHidouttime(getTimeout());
    				setKmout(getKmout());
    				setCmbfuelout(getCmbfuelout());
    				setHidcmbtype(getCmbfuelout());
        		  setMsg("Updated Successfully");
  				return "success";
  			
  			}
  			else{
  				 setDocno(getDocno());
    		     setMasterdoc_no(getMasterdoc_no());
  				reloadData(val);
  				setChkdelivery(getChkdelivery());
				setDelchkvalue(getChkdelivery());
				setTempfleet(getTempfleet());
				setPermanentfleet(getPermanentfleet());
				setFleetname(getFleetname());
				setHiddate(sqlleaseDate.toString());
				setHidoutdate(sqlDateout.toString());
				setHidouttime(getTimeout());
				setKmout(getKmout());
				setDeldrvid(getDeldrvid());
				setDeldrvname(getDeldrvname());
				setCmbfuelout(getCmbfuelout());
				setHidcmbtype(getCmbfuelout());
  				setMsg("Not Updated.");
  				return "fail";
  			}
        	  }
           
        else if(mode.equalsIgnoreCase("DLY")){
         	
     	   java.sql.Date sqlleaseDate = commonDAO.changeStringtoSqlDate(getDate());
     	   java.sql.Date sqldelDateout = commonDAO.changeStringtoSqlDate(getDeldateout());   
     	   
     
  		
         	
         	  boolean Status=leaseAgmtDAO.delupdate(getMasterdoc_no(),sqlleaseDate,getTempfleet(),getPermanentfleet(),
   					sqldelDateout,getDeltimeout(),getDelkmout(),
   					getCmbdelfuelout(),getVehlocation(),mode,getClientid(),session);
         	  if(Status){
         		 setDocno(getDocno());
    		     setMasterdoc_no(getMasterdoc_no());
         		 	reloadData(val);
         		 	
         		 	 setHiddate(sqlleaseDate.toString());
    				setHiddeloutdate(sqldelDateout.toString());
    			
    				setHiddelouttime(getDeltimeout());
    				setDelkmout(getDelkmout());
    				setCmbdelfuelout(getCmbdelfuelout());
    				setHiddelcmbtype(getCmbdelfuelout());
         		  setMsg("Updated Successfully");
   				return "success";
   			
   			}
   			else{
   			 setDocno(getDocno());
		     setMasterdoc_no(getMasterdoc_no());
   				reloadData(val);
   		 	     setHiddate(sqlleaseDate.toString());
				setHiddeloutdate(sqldelDateout.toString());
			
				setHiddelouttime(getDeltimeout());
				setDelkmout(getDelkmout());
				setCmbdelfuelout(getCmbdelfuelout());
				setHiddelcmbtype(getCmbdelfuelout());
   				setMsg("Not Updated.");
   				return "fail";
   			}
         	  }
           
           else if(mode.equalsIgnoreCase("View")){
       		
     			//String branch=null;
     			
     			LeaseAgreementBean=leaseAgmtDAO.getViewDetails(session,getMasterdoc_no());
     			
     			setCheckbranch(getCheckbranch());
     			setMasterdoc_no(LeaseAgreementBean.getMasterdoc_no());
     			setDocno(LeaseAgreementBean.getDocno());
				setDate(LeaseAgreementBean.getDate());
				setClientid(LeaseAgreementBean.getClientid());
				setClientname(LeaseAgreementBean.getClientName());
				setCusaddress(LeaseAgreementBean.getCusaddress());
				setSalesman(LeaseAgreementBean.getSalesmanName());
				setLe_salmanid(LeaseAgreementBean.getLe_salmanid());
				setDescription(LeaseAgreementBean.getDescription());
				setLe_clcodeno(LeaseAgreementBean.getLe_clcodeno());
				setLe_clacno(LeaseAgreementBean.getLe_clacno());
				setAdditional_driver(LeaseAgreementBean.getAdditional_driver());
				setAdd_drchk(LeaseAgreementBean.getAdditional_driver());
				setAdidrvcharges(LeaseAgreementBean.getAdidrvcharges());
				setLadrivercheck(LeaseAgreementBean.getLadrivercheck());
				setChaffchkvalue(LeaseAgreementBean.getLadrivercheck());
				setDel_chaufferid(LeaseAgreementBean.getDel_chaufferid());
				setChkdelivery(LeaseAgreementBean.getChkdelivery());
				setDelchkvalue(LeaseAgreementBean.getChkdelivery());
				setHidcmbmasterreftype(LeaseAgreementBean.getHidcmbmasterreftype());
				setHidmasterrefno(LeaseAgreementBean.getHidmasterrefno());
				setMasterrefno(LeaseAgreementBean.getMasterrefno());
				
				setDeldrvid(LeaseAgreementBean.getDeldrvid());
				setDeldrvname(LeaseAgreementBean.getDeldrvname());
				
				setLeaseprojectDoc(LeaseAgreementBean.getLeaseprojectDoc());
				setLeasePo(LeaseAgreementBean.getLeasePo());
				setLeaseproject(LeaseAgreementBean.getLeaseproject());
				
				
				setTempfleet(LeaseAgreementBean.getTempfleet());
				setPermanentfleet(LeaseAgreementBean.getPermanentfleet());
				setFleetname(LeaseAgreementBean.getFleetname());
				setDateout(LeaseAgreementBean.getDateout());
				setHidoutdate(LeaseAgreementBean.getDateout());
				setTimeout(LeaseAgreementBean.getTimeout());
				setHidouttime(LeaseAgreementBean.getTimeout());
				setKmout(LeaseAgreementBean.getKmout());
				setCmbfuelout(LeaseAgreementBean.getCmbfuelout());
				setHidcmbtype(LeaseAgreementBean.getCmbfuelout());
				//setDeldateout(LeaseAgreementBean.getDeldateout());
				setHiddeloutdate(LeaseAgreementBean.getDeldateout());
				//setDeltimeout(LeaseAgreementBean.getDeltimeout());
				setHiddelouttime(LeaseAgreementBean.getDeltimeout());
				setDelkmout(LeaseAgreementBean.getDelkmout());
				setCmbdelfuelout(LeaseAgreementBean.getCmbdelfuelout());
				setHiddelcmbtype(LeaseAgreementBean.getCmbdelfuelout());
				setVehlocation(LeaseAgreementBean.getVehlocation());
				
				setDelcharges(LeaseAgreementBean.getDelcharges());
				
				
			
				setM1(LeaseAgreementBean.getM1());
				setM2(LeaseAgreementBean.getM2());
				setAmt1(LeaseAgreementBean.getAmt1());
				setM3(LeaseAgreementBean.getM3());
				setM4(LeaseAgreementBean.getM4());
				setAmt2(LeaseAgreementBean.getAmt2());
				setM5(LeaseAgreementBean.getM5());
				setM6(LeaseAgreementBean.getM6());
				setAmt3(LeaseAgreementBean.getAmt3());
				setM7(LeaseAgreementBean.getM7());
				setM8(LeaseAgreementBean.getM8());
				setAmt4(LeaseAgreementBean.getAmt4());
				setM9(LeaseAgreementBean.getM9());
				setM10(LeaseAgreementBean.getM10());
				setAmt5(LeaseAgreementBean.getAmt5());
				setLadriverlist(LeaseAgreementBean.getAdd_driverName());
				setHidper_value(LeaseAgreementBean.getPer_value());
				setHidper_name(LeaseAgreementBean.getPer_name());
				setHidadvance_chk(LeaseAgreementBean.getAdvance_chk());
				setHidinvoice(LeaseAgreementBean.getInvoice());
				setExcessinsur(LeaseAgreementBean.getExcessinsur());

				//mm
				
				setLeasestatus(LeaseAgreementBean.getLeasestatus());
				
     			//System.out.println(cashPaymentBean.getTxtcashpaydocno());
     			return "success";
     		}       return "fail";
       	
	}
	



/*		public  JSONArray chufferinfo(){
			
			  JSONArray cellarray1 = new JSONArray();
			  JSONObject cellobj1 = null;
			  try {
				  List <ClsLeaseAgreementBean> list= ClsLeaseAgreementDAO.list7();
				  for(ClsLeaseAgreementBean bean:list){
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
		                                  
public void reloadData(int docNo){
			try {
			
				
				setLeaseprojectDoc(getLeaseprojectDoc());
				setLeasePo(getLeasePo());
				setLeaseproject(getLeaseproject());
				setHidmasterrefsrno(getHidmasterrefsrno());
				setClientid(getClientid());
				setLe_salmanid(getLe_salmanid());
				setDescription(getDescription());
				setLe_clcodeno(getLe_clcodeno());
				setLe_clacno(getLe_clacno());
				setAdditional_driver(getAdditional_driver());
				setAdidrvcharges(getAdidrvcharges());
				setLadrivercheck(getLadrivercheck());
				setDel_chaufferid(getDel_chaufferid());
				setChaffchkvalue(getLadrivercheck());
				setExcessinsur(getExcessinsur());
				setM1(getM1());
				setM2(getM2());
				setM3(getM3());
				setM4(getM4());
				setM5(getM5());
				setM6(getM6());
				setM7(getM7());
				setM8(getM8());
				setM9(getM9());
				setM10(getM10());
				setAmt1(getAmt1());
				setAmt2(getAmt2());
				setAmt3(getAmt3());
				setAmt4(getAmt4());
				setAmt5(getAmt5());
				setPer_value(getPer_value());
				setHidper_value(getPer_value());
				setPer_name(getPer_name());
				setHidper_name(getPer_name());
				setAdvance_chk(getAdvance_chk());
				setHidadvance_chk(getAdvance_chk());
				setInvoice(getInvoice());
				setHidinvoice(getInvoice());
				setHidcmbmasterreftype(getCmbmasterreftype());
				setHidmasterrefno(getHidmasterrefno());
				setMasterrefno(getMasterrefno());
				setHidmasterrefno(getHidmasterrefno());
			  } catch (Exception e) {
				  e.printStackTrace();
			  }
			
		}


public String printActions() throws ParseException, SQLException{
	 //System.out.println("---------------123123----------------");
	  HttpServletRequest request=ServletActionContext.getRequest();
	 
	 int doc=Integer.parseInt(request.getParameter("docno"));
	 
	 setDocnoval(request.getParameter("docno"));
	 
	// int docnos=Integer.parseInt(request.getParameter("docno"));
	 
		
	 mainbean=leaseAgmtDAO.getmainPrint(doc);
	 
	  bean=leaseAgmtDAO.getPrint(doc);
	  
	  
	  setExcessinsu(bean.getExcessinsu()); 
	  setTrafficcharge(bean.getTrafficcharge()); 
	  setSalikcharge(bean.getSalikcharge());
	  // current Date
	  SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	  String currentdate = sdf.format(new Date());
	  System.out.println("current date --"+currentdate);
	  setLblcurrentdate(currentdate);
	  
	  //cl details
	  setClname(bean.getClname());
	  setCladdress(bean.getCladdress());
	  setClemail(bean.getClemail());
	  setClmobno(bean.getClmobno());
	  // main upper
	  setBarnchval(bean.getBarnchval());

	  setRentaldoc(bean.getRentaldoc());

	    
	    // dr details
	  
	  setRadrname(bean.getRadrname());
	  setRadlno(bean.getRadlno());
	  setPassno(bean.getPassno());
	  setLicexpdate(bean.getLicexpdate());
	  setPassexpdate(bean.getPassexpdate());
	  setDobdate(bean.getDobdate());
	  // veh details
	  
	  setRavehname(bean.getRavehname());
	  setRavehgroup(bean.getRavehgroup());
	  setRavehmodel(bean.getRavehmodel());
	  setRavehregno(bean.getRavehregno());
	  setRadateout(bean.getRadateout());
	  setRatimeout(bean.getRatimeout());
	  setRaklmout(bean.getRaklmout());
	
	 setDeldates(bean.getDeldates());
	  setDeltimes(bean.getDeltimes());
	  setDelkmins(bean.getDelkmins());
	  setDelfuels(bean.getDelfuels());
	  setOutdetails(bean.getOutdetails());
	  setDeldetailss(bean.getDeldetailss());
	 

	  //rental type
	  
	//  setRadaily(bean.getRadaily());
	//  setRaweakly(bean.getRaweakly());
	//  setRamonthly(bean.getRamonthly());
	  setTariff(bean.getTariff());
	  setRacdwscdw(bean.getRacdwscdw());
	  setRaaccessory(bean.getRaaccessory());
	  setRaadditionalcge(bean.getRaadditionalcge());
	  setLblpai(bean.getLblpai());
	  
	  setInkm(bean.getInkm());
	  setInfuel(bean.getInfuel());
	  setIndate(bean.getIndate());
	  setIntime(bean.getIntime());
	  setRastatus(bean.getRastatus());

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
	  
	  
	   setRaextrakm( bean.getRaextrakm());
	   setRaexxtakmchg( bean.getRaexxtakmchg());

	 
	   
	   setCompanyname(bean.getCompanyname());
 	  
	   setAddress(bean.getAddress());
	 
	   setMobileno(bean.getMobileno());
	  
	   setFax(bean.getFax());
	   setLocation(bean.getLocation());

	   setTotalpaids(bean.getTotalpaids());
	    setInvamount(bean.getInvamount());
	   setBalance(bean.getBalance());
	   
	   
	   setTermi1(bean.getTermi1());
	   setTermi2(bean.getTermi2());
	   setTermi3(bean.getTermi3());
	   setTermi4(bean.getTermi4());
	   setTermi5(bean.getTermi5());
	//mm
	
	  setSalname(bean.getSalname());	   
	   
 
	   setUrl(commonDAO.getPrintPath(getFormdetailcode()));
	   
	   
	   
	   
	   
//	   HttpServletRequest request=ServletActionContext.getRequest();
		 

		// System.out.println("---------------master print-----------------");
		 
		 
		 setTxtcustomersname(mainbean.getTxtcustomersname());
			  
		 setTxtaddress(mainbean.getTxtaddress());
		 setTxtcontact(mainbean.getTxtcontact());
		 
		 
		 
		 setVehicledetails(mainbean.getVehicledetails());
			  
		 setVehduration(mainbean.getVehduration());
		 setVehcostpermonth(mainbean.getVehcostpermonth());
		 
		 setKmrest(mainbean.getKmrest());
		 
		 setLbllessorcompany(mainbean.getLbllessorcompany());
		 
		 setClientnames(mainbean.getClientnames());
		 
		 
 
		 setUrl2(commonDAO.getPrintPath2(getFormdetailcode()));
	   
	   	 //For Cosmo Print
		 setLblcosmoexcessamt(bean.getLblcosmoexcessamt());
		 setLblcosmoagmtno(bean.getLblcosmoagmtno());
		 setLblcosmoagreedrate(bean.getLblcosmoagreedrate());
		 setLblcosmoamt1(bean.getLblcosmoamt1());
		 setLblcosmoamt2(bean.getLblcosmoamt2());
		 setLblcosmoamt3(bean.getLblcosmoamt3());
		 setLblcosmoamt4(bean.getLblcosmoamt4());
		 setLblcosmoamt5(bean.getLblcosmoamt5());
		 setLblcosmobrand(bean.getLblcosmobrand());
		 setLblcosmochassis(bean.getLblcosmochassis());
		 setLblcosmoclientaddress(bean.getLblcosmoclientaddress());
		 setLblcosmoclientmobile(bean.getLblcosmoclientmobile());
		 setLblcosmoclientname(bean.getLblcosmoclientname());
		 setLblcosmocolor(bean.getLblcosmocolor());
		 setLblcosmoduration(bean.getLblcosmoduration());
		 setLblcosmoenddate(bean.getLblcosmoenddate());
		 setLblcosmoengine(bean.getLblcosmoengine());
		 setLblcosmofleetno(bean.getLblcosmofleetno());
		 setLblcosmomodel(bean.getLblcosmomodel());
		 setLblcosmoregno(bean.getLblcosmoregno());
		 setLblcosmostartdate(bean.getLblcosmostartdate());
		 setLblcosmoterm1(bean.getLblcosmoterm1());
		 setLblcosmoterm2(bean.getLblcosmoterm2());
		 setLblcosmoterm3(bean.getLblcosmoterm3());
		 setLblcosmoterm4(bean.getLblcosmoterm4());
		 setLblcosmoterm5(bean.getLblcosmoterm5());
		 setLblcosmoterm6(bean.getLblcosmoterm6());
		 setLblcosmoterm7(bean.getLblcosmoterm7());
		 setLblcosmoterm8(bean.getLblcosmoterm8());
		 setLblcosmoterm9(bean.getLblcosmoterm9());
		 setLblcosmoterm10(bean.getLblcosmoterm10());
		 setLblcosmoamt1(bean.getLblcosmoamt1());
		 setLblcosmoamt2(bean.getLblcosmoamt2());
		 setLblcosmoamt3(bean.getLblcosmoamt3());
		 setLblcosmoamt4(bean.getLblcosmoamt4());
		 setLblcosmoamt5(bean.getLblcosmoamt5());
		 setLblcosmoyom(bean.getLblcosmoyom());
		 setLblcosmoregdetails(bean.getLblcosmoregno()+"-"+bean.getLblcosmoyom()+"-"+bean.getLblcosmomodel());
		 ClsAmountToWords objamount=new ClsAmountToWords();
		 setLblcosmoagreedratewords(objamount.convertAmountToWords(bean.getLblcosmoagreedrate()));
		 
		 HttpServletResponse response = ServletActionContext.getResponse();		 
		 if(commonDAO.getPrintPath(getFormdetailcode()).contains(".jrxml")){
			 System.out.println(".jrxml");
			 param=new HashMap();
			 Connection conn = null;
			 try {
		      
				 conn = conobj.getMyConnection();
			 
			 String imgpath=request.getSession().getServletContext().getRealPath("/icons/easyleaseprintimg.png");
             imgpath=imgpath.replace("\\", "\\\\");
			   
			   String imgheaderpath=request.getSession().getServletContext().getRealPath("/icons/easyleasprintheader.png");
              imgheaderpath=imgheaderpath.replace("\\", "\\\\"); 
              
             
            //  System.out.println(imgheaderpath);
             // System.out.println(footerimgpath1);
             param.put("hedderimage",imgheaderpath);
              param.put("leaseimage",imgpath);
            //  System.out.println(getUrl());
              JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/operations/agreement/leaseagreement/" +commonDAO.getPrintPath(getFormdetailcode())));
               JasperReport jasperReport = JasperCompileManager.compileReport(design);
               generateReportPDF(response, param, jasperReport, conn);
        
			 } catch (Exception e) {

                 e.printStackTrace();

             }
            	 finally{
				conn.close();
			} 
	}
		 
			 
		 
	 return "print";
	 }	

private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {	  byte[] bytes = null;
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

/*public String printmainActions() throws ParseException, SQLException{
	
	 
	 
	 // total  
	  
	  

	  
	      

	 return "mainprint";
	 }	
*/

public String printClosingSummaryAction() throws ParseException, SQLException{
	
	HttpServletRequest request=ServletActionContext.getRequest();
	int docNo=Integer.parseInt(request.getParameter("docno"));
	bean=leaseAgmtDAO.getClosingSummaryPrint(request,docNo);
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
		bean=leaseAgmtDAO.getKmPrint(request,docNo);
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
		setLbltotalusedkm(bean.getLbltotalusedkm());
		setLblrateperkm(bean.getLblrateperkm());
		setLblclstatus(bean.getLblclstatus());
		ClsAmountToWords objamount=new ClsAmountToWords();
		if(Double.parseDouble(bean.getLbltotalexcesskmrate())>0.0){
			setLbltotalexcesskmratewords(objamount.convertAmountToWords(bean.getLbltotalexcesskmrate()));					
		}
		return "print";
}
}































