package com.operations.marketing.leasecalculatoralmariah;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
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
import com.operations.marketing.leasecalculator.ClsLeaseCalculatorBean;
import com.operations.marketing.leasecalculator.ClsLeaseCalculatorDAO;

public class ClsLeaseCalcAlMariahAction {

	ClsCommon objcommon=new ClsCommon();
	ClsLeaseCalcAlMariahDAO calcdao=new ClsLeaseCalcAlMariahDAO();
	private int docno;
	private int vocno;
	private String date;
	private String hiddate;
	private String leasereqdoc;
	private String hidleasereqdoc;
	private int reqgridlength;
	private String mode;
	private String msg;
	private String deleted;
	private String brchName;
	private String formdetailcode;
	private String url;
	private String submitstatus;
	private String leasereqclient;
	private String clientmob;
	
	private String lblclient,docvals,lblclientaddress,lbldate,lblmob,lblemail,terms1,generalterms,terms2,firstarray,secarray,lbldocno;
	private String lblleasereqdocno;
	private String lblcompname;
	private String lblcompaddress;
	private String lblcomptel;
	private String lblcompfax;
	private String lblprintname;
	private String lblbranch;
	private String lbllocation;
	private String lblcomptrn;
	private Map<String, Object> param=null;
	private String lblhpd,lbldiw,lblrateperexhr,lblkmrestrict,lblexcesskm,lblservices,lblcontractperiod;
	
	
	
	
	public String getLblservices() {
		return lblservices;
	}
	public void setLblservices(String lblservices) {
		this.lblservices = lblservices;
	}
	public String getLblhpd() {
		return lblhpd;
	}
	public void setLblhpd(String lblhpd) {
		this.lblhpd = lblhpd;
	}
	public String getLbldiw() {
		return lbldiw;
	}
	public void setLbldiw(String lbldiw) {
		this.lbldiw = lbldiw;
	}
	public String getLblrateperexhr() {
		return lblrateperexhr;
	}
	public void setLblrateperexhr(String lblrateperexhr) {
		this.lblrateperexhr = lblrateperexhr;
	}
	public String getLblkmrestrict() {
		return lblkmrestrict;
	}
	public void setLblkmrestrict(String lblkmrestrict) {
		this.lblkmrestrict = lblkmrestrict;
	}
	public String getLblexcesskm() {
		return lblexcesskm;
	}
	public void setLblexcesskm(String lblexcesskm) {
		this.lblexcesskm = lblexcesskm;
	}
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	public String getLbldocno() {
		return lbldocno;
	}
	public void setLbldocno(String lbldocno) {
		this.lbldocno = lbldocno;
	}
	public String getLblcomptrn() {
		return lblcomptrn;
	}
	public void setLblcomptrn(String lblcomptrn) {
		this.lblcomptrn = lblcomptrn;
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
	public String getLblleasereqdocno() {
		return lblleasereqdocno;
	}
	public void setLblleasereqdocno(String lblleasereqdocno) {
		this.lblleasereqdocno = lblleasereqdocno;
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
	public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}
	public String getLblclient() {
		return lblclient;
	}
	public void setLblclient(String lblclient) {
		this.lblclient = lblclient;
	}
	public String getDocvals() {
		return docvals;
	}
	public void setDocvals(String docvals) {
		this.docvals = docvals;
	}
	public String getLblclientaddress() {
		return lblclientaddress;
	}
	public void setLblclientaddress(String lblclientaddress) {
		this.lblclientaddress = lblclientaddress;
	}
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLblmob() {
		return lblmob;
	}
	public void setLblmob(String lblmob) {
		this.lblmob = lblmob;
	}
	public String getLblemail() {
		return lblemail;
	}
	public void setLblemail(String lblemail) {
		this.lblemail = lblemail;
	}
	public String getTerms1() {
		return terms1;
	}
	public void setTerms1(String terms1) {
		this.terms1 = terms1;
	}
	public String getGeneralterms() {
		return generalterms;
	}
	public void setGeneralterms(String generalterms) {
		this.generalterms = generalterms;
	}
	public String getTerms2() {
		return terms2;
	}
	public void setTerms2(String terms2) {
		this.terms2 = terms2;
	}
	public String getFirstarray() {
		return firstarray;
	}
	public void setFirstarray(String firstarray) {
		this.firstarray = firstarray;
	}
	public String getSecarray() {
		return secarray;
	}
	public void setSecarray(String secarray) {
		this.secarray = secarray;
	}
	public String getLeasereqclient() {
		return leasereqclient;
	}
	public void setLeasereqclient(String leasereqclient) {
		this.leasereqclient = leasereqclient;
	}
	public String getClientmob() {
		return clientmob;
	}
	public void setClientmob(String clientmob) {
		this.clientmob = clientmob;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public int getVocno() {
		return vocno;
	}
	public void setVocno(int vocno) {
		this.vocno = vocno;
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

	public String getLeasereqdoc() {
		return leasereqdoc;
	}

	public void setLeasereqdoc(String leasereqdoc) {
		this.leasereqdoc = leasereqdoc;
	}

	public String getHidleasereqdoc() {
		return hidleasereqdoc;
	}

	public void setHidleasereqdoc(String hidleasereqdoc) {
		this.hidleasereqdoc = hidleasereqdoc;
	}

	public int getReqgridlength() {
		return reqgridlength;
	}

	public void setReqgridlength(int reqgridlength) {
		this.reqgridlength = reqgridlength;
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

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public String getBrchName() {
		return brchName;
	}

	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getSubmitstatus() {
		return submitstatus;
	}

	public void setSubmitstatus(String submitstatus) {
		this.submitstatus = submitstatus;
	}

	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		Map<String, String[]> requestParams = request.getParameterMap();
		java.sql.Date sqldate=null;
		if(!getDate().equalsIgnoreCase("") && getDate()!=null){
			sqldate=objcommon.changeStringtoSqlDate(getDate());
		}
		if(mode.equalsIgnoreCase("A")){
			ArrayList<String> reqarray=new ArrayList<>();
			for(int i=0;i<getReqgridlength();i++){
				String temp=requestParams.get("testreq"+i)[0];
				reqarray.add(temp);
			}
			
			
			int val=calcdao.insert(sqldate,getHidleasereqdoc(),reqarray,session,getBrchName(),getMode(),getFormdetailcode());
			if(val>0){
				setDocno(val);
				setDate(sqldate.toString());
				setLeasereqdoc(getLeasereqdoc());
				setHidleasereqdoc(getHidleasereqdoc());
				setLeasereqclient(getLeasereqclient());
				setClientmob(getClientmob());
				setSubmitstatus("1");
				setMsg("Successfully Saved");
				
				return "success";
			}
			else{
				setDocno(val);
				setDate(sqldate.toString());
				setLeasereqdoc(getLeasereqdoc());
				setHidleasereqdoc(getHidleasereqdoc());
				setMsg("Not Saved");
				setSubmitstatus("1");
				return "fail";
			}
		}
		
		return "fail";
	}
	public String printActionNormal() throws SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		ClsLeaseCalcAlMariahBean bean=new ClsLeaseCalcAlMariahBean();
		String docno=request.getParameter("docno");
		ClsLeaseCalcAlMariahDAO calcdao=new ClsLeaseCalcAlMariahDAO();
		bean=calcdao.getPrintNormal(docno,request);
		
		setUrl(objcommon.getPrintPath("LEC"));
		setLbldate(bean.getLbldate());
		setLbldocno(bean.getLbldocno());
		setLblleasereqdocno(bean.getLblleasereqdocno());
		setLblprintname("Lease Calculator");
		setLblcompaddress(bean.getLblcompaddress());
		setLblcompfax(bean.getLblcompfax());
		setLblcompname(bean.getLblcompname());
		setLblcomptel(bean.getLblcomptel());
		setLblclient(bean.getLblclient());
		setLblclientaddress(bean.getLblclientaddress());
		setLblmob(bean.getLblmob());
		setLblbranch(bean.getLblbranch());
		setLbllocation(bean.getLbllocation());
		setLblcomptrn(bean.getLblcomptrn());
		return "print";
	}
	public String printAction() throws ParseException, SQLException{
		
			
		  System.out.println("------------------------------------------inside print action");
		  HttpServletRequest request=ServletActionContext.getRequest();
		 // HttpServletResponse response=ServletActionContext.getResponse();
		  
		  int doc=Integer.parseInt(request.getParameter("docno"));
		  String ckhval=request.getParameter("ckhval")==null?"NA":request.getParameter("ckhval");
		  String dtype=request.getParameter("formdetailcode")==null?"NA":request.getParameter("formdetailcode");
		  int dcode=Integer.parseInt(request.getParameter("code")==null?"0":request.getParameter("code"));
		  
		  ClsLeaseCalcAlMariahBean pintbean = new ClsLeaseCalcAlMariahBean();
		  pintbean=calcdao.getPrintQot(doc,request);

		  //cl details
	    setLblclient(pintbean.getLblclient());
	    setLblclientaddress(pintbean.getLblclientaddress());
	    setLblmob(pintbean.getLblmob());
	    setLblemail(pintbean.getLblemail());
	    //upper
	    setLbldate(pintbean.getLbldate());
		 
	/*	request.setAttribute("details",arraylist); */
		
		
	    setLblprintname("Quotation");
	    setLblbranch(pintbean.getLblbranch());
	    setLblcompname(pintbean.getLblcompname());
	    setLblcompaddress(pintbean.getLblcompaddress());
	    setLblcomptel(pintbean.getLblcomptel());
	    setLblcompfax(pintbean.getLblcompfax());
	    setLbllocation(pintbean.getLbllocation());
	    setLblcomptrn(pintbean.getLblcomptrn());


	   //setFirstarray(pintbean.getFirstarray());
	   //setSecarray(pintbean.getSecarray());
	   
	   setDocvals(pintbean.getDocvals());
	   setGeneralterms(pintbean.getGeneralterms());
	   setTerms1(pintbean.getTerms1());
	   setTerms2(pintbean.getTerms2());
	   
	   
		  /* if(ckhval.equalsIgnoreCase("test"))
		   {
			   
		
			 // Calendar now = Calendar.getInstance();
			 Calendar now = GregorianCalendar.getInstance();
			 
			SimpleDateFormat df = new SimpleDateFormat("HH");
			String formattedDate = df.format(new Date());
			//System.out.println(formattedDate);
			 
			 String currdate=""+now.get(Calendar.DATE)+"."+(now.get(Calendar.MONTH) + 1)+" "+ formattedDate+"."+now.get(Calendar.MINUTE)+"."+now.get(Calendar.SECOND)+" ";

				     
			 return "success"; 
		   }
		   else
		   {
			   setUrl(objcommon.getPrintPath("QOT"));
			  return "print";   
		   }*/
	   
	   if(objcommon.getPrintPath(dtype).contains("jrxml")){
			System.out.println("printaction");
			HttpServletResponse response = ServletActionContext.getResponse();
			param = new HashMap();
			Connection conn = null;
			ClsConnection conobj=new ClsConnection();
			conn = conobj.getMyConnection();
			try
		       {
				String reportFileName="";
				String almariahtermsquery="";
		
		if(dcode==1)
		{
			//System.out.println("code......."+dcode);
			 reportFileName="leaseCalcPrintAlmariah01.jrxml";
			  almariahtermsquery="SELECT '1' srno,'Offer in Annexure A is a fixed monthly rate, services shall be "
			 		+ "provided for "+pintbean.getLblhpd() +"hrs., "+pintbean.getLbldiw() +" days a week. Extra hours shall be charged at AED "+pintbean.getLblrateperexhr() +"/hr.' terms UNION ALL "
			 		+ "SELECT '' srno,'' terms UNION ALL SELECT '2' srno,'This contract is made for staff transportation only; "
			 		+ "hence, any Traffic violations, and penalties due to illegal transportation of goods or individuals shall be"
			 		+ " accounted to the LESSEE.' terms UNION ALL SELECT '' srno,'' terms UNION ALL SELECT '3' srno,'Driver’s food "
			 		+ "and accommodation shall be provided by the LESSEE.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT "
			 		+ "'4' srno,'The LESSOR’s driver cannot be utilized for any vehicle other than the LESSOR’s owned vehicle/s.' "
			 		+ "terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '5' srno,'A replacement vehicle shall be provided by"
			 		+ " the LESSOR in case of Emergency, breakdown and/or at the time of     Maintenance Service for the bus. "
			 		+ "A replacement driver shall be provided by the LESSOR in case of emergency, vacation or sick leave. ' terms "
			 		+ "UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '6' srno, 'Al Mariah General Transport shall take charge "
			 		+ "of maintenance and repair costs, security passes, buses and passenger insurance as per UAE Law.' terms UNION"
			 		+ " ALL SELECT ''srno,'' terms UNION ALL SELECT '7' srno, 'Workshop and Service Facility is available in both "
			 		+ "Musaffah and Western Region to support Lessor operation.' terms UNION ALL SELECT ''srno,'' terms UNION ALL "
			 		+ "SELECT '8' srno, 'Fuel shall be provided by the Lessor.' terms UNION ALL SELECT ''srno,'' terms UNION ALL "
			 		+ "SELECT '9' srno, 'Security passes shall be issued to the vehicle/driver, if required, within 10 working days from receiving the Lessee’s Letter of Assistance.' terms"
			 		+ " UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '10' srno, 'All vehicles carry a Full Comprehensive Insurance.' terms UNION ALL "
			 		+ "SELECT ''srno,'' terms UNION ALL SELECT '11' srno, 'Contract ceases only when vehicle is handed over by The Lessee to the Lessor.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '12' srno, 'Provision & Installation of Site/HSE accessories shall be an additional cost to the LESSEE and shall be invoiced as actuals.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '13' srno, 'Upon completion of the contract services, LESSEE must issue a "
			 		+ "Project Completion Certificate to the LESSOR, upon which the LESSOR shall issue a Clearance Certificate to the LESSEE.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '14' srno, 'The Lessee is responsible to"
			 		+ " provide the Lessor a Letter of Assistance to process security passes, if required. The Lessor will not be accountable of the lessee’s interruption "
			 		+ "of operation in an event that the latter fails to provide LOA.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '15' srno, 'The Lessor shall "
			 		+ "reserve the right to impose Taxes on the services provided as per UAE LAW.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '16' srno, 'In any case, wherein the LESSEE’s "
			 		+ "LPO or Contract is in conflict with the contents, terms & conditions of the LESSOR’s contract, the LESSOR’s contract shall take precedence over that of the "
			 		+ "LESSEE’s LPO or Contract. ' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '17' srno, 'Any dispute shall be settled in the Courts of Abu Dhabi, UAE. ' terms UNION ALL SELECT ''srno,'' terms;";
			 		
			 param.put("almariahtermsquery", almariahtermsquery);
		}
		else if(dcode==2)
		{
			 reportFileName="leaseCalcPrintAlmariah02.jrxml";
			   almariahtermsquery="SELECT '1' srno,'Offer in Annexure A is a fixed monthly rate, services shall be provided for "+pintbean.getLblhpd()+ "hrs, "+pintbean.getLbldiw()+" days a week. Extra hours shall be charged at AED "+pintbean.getLblrateperexhr()+"/hr.' "
			 		+ "terms UNION ALL SELECT '' srno,'' terms UNION ALL SELECT '2' srno,'This contract is made for staff transportation only; hence, any Traffic violations, and penalties due to illegal transportation of goods or "
			 		+ "individuals shall be accounted to the LESSEE.' terms UNION ALL SELECT '' srno,'' terms UNION ALL SELECT '3' srno,'Driver’s food and accommodation shall be provided by the LESSEE.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '4' srno,'The LESSOR’s driver cannot be utilized for any vehicle other than the LESSOR’s owned vehicle/s.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '5' srno,"
			 		+ "'A replacement vehicle shall be provided by the LESSOR in case of Emergency, breakdown and/or at the time of     Maintenance Service for the bus. A replacement driver shall be provided by the LESSOR in case of emergency, vacation or sick leave. ' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '6' srno, 'Al Mariah General Transport shall take charge of maintenance and repair costs, security passes, buses and passenger insurance as per UAE Law.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '7' srno, 'Workshop and Service Facility is available in both Musaffah and Western Region to support Lessor operation.'"
			 		+ " terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '8' srno, 'Fuel shall be provided by the Lessee.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '9' srno, 'Security passes shall be issued to the vehicle/driver, if required, within 10 working days from receiving the Lessee’s Letter of Assistance.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '10' srno, 'All vehicles carry a Full Comprehensive Insurance.'"
			 		+ " terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '11' srno, 'Contract ceases only when vehicle is handed over by The Lessee to the Lessor.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '12' srno, 'Provision & Installation of Site/HSE accessories shall be an additional cost to the LESSEE and shall be invoiced as actuals.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '13' srno, 'Upon completion of the contract services, LESSEE must issue a Project Completion Certificate to the LESSOR, upon which the LESSOR shall issue a "
			 		+ "Clearance Certificate to the LESSEE.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '14' srno, 'The Lessee is responsible to provide the Lessor a Letter of Assistance to process security passes, if required. The Lessor will not be accountable of the "
			 		+ "lessee’s interruption of operation in an event that the latter fails to provide LOA.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '15' srno, 'The Lessor shall reserve the right to impose Taxes on the services provided as per UAE LAW.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '16' srno, 'In any case, wherein the LESSEE’s LPO or Contract is in conflict with the contents, terms & conditions of the LESSOR’s contract, the LESSOR’s contract shall take precedence over that of the LESSEE’s LPO or Contract. ' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '17' srno, 'Any dispute shall be settled in the Courts of Abu Dhabi, UAE. ' terms UNION ALL SELECT ''srno,'' terms;";
			
			 param.put("almariahtermsquery", almariahtermsquery);
		}
		else if(dcode==3)
		{
			 reportFileName="leaseCalcPrintAlmariah03.jrxml";
			almariahtermsquery="SELECT '1' srno,'Offer in Annexure A is a fixed monthly rate, services shall be provided for "+pintbean.getLblhpd()+"hrs, "+pintbean.getLbldiw()+" days a week. "
			 		+ "Extra hours shall be charged at AED "+pintbean.getLblrateperexhr()+"/hr.' terms UNION ALL SELECT '' srno,'' terms UNION ALL SELECT '2' srno,'This contract is made for staff transportation only; hence, any Traffic violations, and penalties due to illegal "
			 		+ "transportation of goods or individuals shall be accounted to the LESSEE' terms UNION ALL SELECT '' srno,'' terms UNION ALL SELECT '3' srno,'Driver’s food and accommodation shall be provided by the LESSEE.' terms UNION ALL "
			 		+ "SELECT ''srno,'' terms UNION ALL SELECT '4' srno,'The LESSOR’s driver cannot be utilized for any vehicle other than the LESSOR’s owned vehicle/s.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT "
			 		+ "'5' srno,'A replacement vehicle shall be provided by the LESSOR in case of Emergency, breakdown and/or at the time of Maintenance Service for the bus. A replacement driver shall be provided by the LESSOR in case of emergency, vacation or sick leave.'"
			 		+ " terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '6' srno, 'Al Mariah General Transport shall take charge of maintenance and repair costs, security passes, buses and passenger insurance as per UAE Law.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT "
			 		+ "'7' srno, 'Workshop and Service Facility is available in both Musaffah and Western Region to support Lessor operation.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '8' srno, 'Fuel shall be provided by the Lessee.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '9' srno, 'All vehicles carry a Full Comprehensive Insurance.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '10' srno, 'Contract ceases only when vehicle is handed over by The Lessee to the Lessor.'"
			 		+ " terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '11' srno, 'Provision & Installation of Site/HSE accessories shall be an additional cost to the LESSEE and shall be invoiced as actuals.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '12' srno, 'Upon completion of the contract services, LESSEE must issue a Project Completion "
			 		+ "Certificate to the LESSOR, upon which the LESSOR shall issue a Clearance Certificate to the LESSEE.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '13' srno, 'The Lessee is responsible to provide the Lessor a Letter of Assistance to process security passes, if required. The Lessor will not be accountable of the lessee’s interruption of operation in an event that the latter fails to provide LOA.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '14' srno, "
			 		+ "'The Lessor shall reserve the right to impose Taxes on the services provided as per UAE LAW.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '15' srno, 'In any case, wherein the LESSEE’s LPO or Contract is in conflict with the contents, terms & conditions of the LESSOR’s contract, the LESSOR’s contract shall take precedence over that of the LESSEE’s LPO or Contract.' "
			 		+ "terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '16' srno, 'Any dispute shall be settled in the Courts of Abu Dhabi, UAE. ' terms UNION ALL SELECT ''srno,'' terms;";
			 param.put("almariahtermsquery", almariahtermsquery);
		}
		else if(dcode==4)
		{
			 reportFileName="leaseCalcPrintAlmariah04.jrxml";
			almariahtermsquery="SELECT '1' srno,'Offer in Annexure A is a fixed monthly rate, based on "+pintbean.getLblkmrestrict()+" km/mo., any excess KM shall be charged at AED "+pintbean.getLblexcesskm()+"/km.' "
			 		+ "terms UNION ALL SELECT '' srno,'' terms UNION ALL SELECT '2' srno,'The Lessee must furnish Al Mariah General Transport (AGT) with Lessee’s driver’s license and "
			 		+ "passport copy. Further, the Lessee must inform AGT of any change of driver. AGT reserves the right to collect fines and penalties incurred by The Lessee’s driver or the "
			 		+ "company or lessee during or after the contract period, or until the issue is closed.' terms UNION ALL SELECT '' srno,'' terms UNION ALL SELECT '3' srno,'The Lessee "
			 		+ "must submit the Police Report in case of accidents and excess insurance amount shall be charged to The Lessee, if any. If, however, in the event that Lessee fails to provide the police report, "
			 		+ "Lessee shall bear full responsibilities of the fines and relevant cost of accident repairs.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '4' srno,'In case of repair requirement due to vehicle engine malfunction, The Lessee’s driver is required to bring "
			 		+ "the vehicle to Al Mariah General Transport workshop with Maintenance Request Form.  For any vehicle found to have damages, a police report is required to commence the repair. Without police report, The Lessee driver shall bear the cost of repair' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '5' srno,'In case, whereby vehicle is confiscated by UAE Authorities due to The Lessee’s driver’s fault, (as possessing illegal alcohol or intoxicated, etc.), costs involved, if any, shall be invoiced to The Lessee. ' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '6' srno, 'The Lessor shall provide replacement in case of emergency or breakdown.' terms UNION ALL SELECT ''srno,'' "
			 		+ "terms UNION ALL SELECT '7' srno, 'Provision & Installation of Site/HSE accessories shall be an additional cost to the Lessee and shall be invoiced as actuals.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '8' srno, 'Vehicle washing is not part of the monthly rate.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '9' srno, 'Fuel to be provided by Lessee.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '10' srno, 'Salik Cost and salik account processing shall be charged to the Lessee as actuals, and a rate of AED 5 per usage.' "
			 		+ "terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '11' srno, 'Rate includes full Insurance coverage for Passenger, driver, Third Party.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '12' srno, 'Traffic fines shall incur a service charge of AED 50 if fines are paid by the Lessor.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '13' srno, 'Lease Expiry: Contract ceases only when vehicle is handed over by The Lessee to the Lessor.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '14' srno, 'The Lessee is responsible to provide the Lessor a Letter "
			 		+ "of Assistance to process security passes. The Lessor will not be accountable of the lessee’s operation in an event that the latter fails to provide LOA.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '15' srno, 'The Lessor shall reserve the right to impose Taxes on the services "
			 		+ "provided as per UAE LAW.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '16' srno, 'In any case, wherein The Lessee’s LPO or Contract is in conflict with the contents, terms & conditions of Al Mariah General Transport’s (AGT) contract, AGT’s contract shall take precedence over that of the "
			 		+ "Lessee’s LPO or Contract. ' terms UNION ALL SELECT ''srno,'' terms;";
			 param.put("almariahtermsquery", almariahtermsquery);
		}
		else if(dcode==5)
		{
			 reportFileName="leaseCalcPrintAlmariah05.jrxml";
			almariahtermsquery="SELECT '1' srno,'Offer in Annexure A is a fixed monthly rate, based on "+pintbean.getLblkmrestrict()+" km/mo., any excess KM shall be charged at AED "+pintbean.getLblexcesskm()+"/km.' terms UNION ALL SELECT '' srno,'' terms UNION ALL SELECT '2' srno,'The Lessee must furnish Al Mariah General Transport (AGT) with Lessee’s driver’s license and passport copy. Further,"
			 		+ " the Lessee must inform AGT of any change of driver. AGT reserves the right to collect fines and penalties incurred by The Lessee’s driver or the company or lessee during or after the contract period, or until the issue is closed.' terms UNION ALL SELECT '' srno,'' terms UNION ALL SELECT '3' srno,'The Lessee must submit the Police Report in case of accidents and"
			 		+ " excess insurance amount shall be charged to The Lessee, if any. If, however, in the event that Lessee fails to provide the police report, Lessee shall bear full responsibilities of the fines and relevant cost of accident repairs.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '4' srno,'In case of repair requirement due to vehicle engine malfunction, The Lessee’s driver is required to bring the vehicle to Al Mariah General Transport workshop with Maintenance Request Form.  "
			 		+ "For any vehicle found to have damages, a police report is required to commence the repair. Without police report, The Lessee driver shall bear the cost of repair' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '5' srno,'In case, whereby vehicle is confiscated by UAE Authorities due to The Lessee’s driver’s fault, (as possessing illegal alcohol or intoxicated, etc.), costs involved, if any, shall be invoiced to The Lessee. ' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '6' srno, 'The Lessor shall provide "
			 		+ "replacement in case of emergency or breakdown.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '7' srno, 'Provision & Installation of Site/HSE accessories shall be an additional cost to the Lessee and shall be invoiced as actuals.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '8' srno, 'Vehicle washing is not part of the monthly rate.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '9' srno, 'Fuel to be provided by Lessee.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '10' srno, 'Salik Cost and salik account processing shall be charged to the Lessee as actuals, and a rate of AED 5 per usage.' terms UNION ALL SELECT ''srno,'' "
			 		+ "terms UNION ALL SELECT '11' srno, 'Rate includes full Insurance coverage for Passenger, driver, Third Party.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '12' srno, 'Traffic fines shall incur a service charge of AED 50 if fines are paid by the Lessor.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '13' srno, 'Lease Expiry: Contract ceases only when vehicle is handed over by The Lessee to the Lessor.' "
			 		+ "terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '14' srno, 'The Lessee is responsible to provide the Lessor a Letter of Assistance to process security passes. The Lessor will not be accountable of the lessee’s operation in an event that the latter fails to provide LOA.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '15' srno, 'The Lessor shall reserve the right to impose Taxes on the services provided as per UAE LAW.' "
			 		+ "terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '16' srno, 'In any case, wherein The Lessee’s LPO or Contract is in conflict with the contents, terms & conditions of Al Mariah General Transport’s (AGT) contract, AGT’s contract shall take precedence over that of the Lessee’s LPO or Contract. ' terms UNION ALL SELECT ''srno,'' terms;";
			 param.put("almariahtermsquery", almariahtermsquery);
		}
		else if(dcode==6)
		{
			 reportFileName="leaseCalcPrintAlmariah06.jrxml";
			almariahtermsquery="SELECT '1' srno,'Offer in Annexure A is a fixed monthly rate, based on "+pintbean.getLblkmrestrict()+" km/mo., any excess KM shall be charged at AED "+pintbean.getLblexcesskm()+"/km.' terms UNION ALL SELECT '' srno,'' terms UNION ALL SELECT '2' srno,'The Lessee must furnish Al Mariah General Transport (AGT) with Lessee’s driver’s license and passport copy. Further, the Lessee must inform AGT of any change of driver"
			 		+ " AGT reserves the right to collect fines and penalties incurred by The Lessee’s driver or the company or lessee during or after "
			 		+ "the contract period, or until the issue is closed.' terms UNION ALL SELECT '' srno,'' terms UNION ALL SELECT '3' srno,'The Lessee must submit the Police Report in case of accidents and excess insurance amount shall be charged to The Lessee, if any. If, however, in the event that Lessee fails to provide the police report, Lessee shall bear full responsibilities of "
			 		+ "the fines and relevant cost of accident repairs.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '4' srno,'In case of repair requirement due to vehicle engine malfunction, The Lessee’s driver is required to bring the vehicle to Al Mariah General Transport workshop with Maintenance Request Form.  For any vehicle found to have damages, a police report is required to commence the repair. "
			 		+ "Without police report, The Lessee driver shall bear the cost of repair' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '5' srno,'In case, whereby vehicle is confiscated by UAE Authorities due to The Lessee’s driver’s fault, (as possessing illegal alcohol or intoxicated, etc.), costs involved, if any, shall be invoiced to The Lessee. ' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '6' srno, "
			 		+ "'The Lessor shall provide replacement in case of emergency or breakdown' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '7' srno, 'Provision & Installation of Site/HSE accessories shall be an additional cost to the Lessee and shall be invoiced as actuals.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '8' srno, 'Vehicle washing is not part of the monthly rate.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '9' srno, 'Fuel to be provided by Lessee.'"
			 		+ " terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '10' srno, 'Salik Cost and salik account processing shall be charged to the Lessee as actuals, and a rate of AED 5 per usage.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '11' srno, 'Rate includes full Insurance coverage for Passenger, driver, Third Party.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '12' srno, 'Traffic fines shall incur a service charge of AED 50 if fines are paid by the Lessor.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '13' srno, "
			 		+ "'Lease Expiry: Contract ceases only when vehicle is handed over by The Lessee to the Lessor.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '14' srno, 'The Lessee is responsible to provide the Lessor a Letter of Assistance to process security passes. The Lessor will not be accountable of the lessee’s operation in an event that the latter fails to provide LOA.' terms UNION ALL SELECT ''srno,'' terms UNION ALL SELECT '15' srno, 'The Lessor shall reserve the right to impose Taxes on the services provided as per UAE LAW.' terms UNION ALL SELECT ''srno,'' terms UNION ALL "
			 		+ "SELECT '16' srno, 'In any case, wherein The Lessee’s LPO or Contract is in conflict with the contents, terms & conditions of Al Mariah General Transport’s (AGT) contract, AGT’s contract shall take precedence over that of the Lessee’s LPO or Contract. ' terms UNION ALL SELECT ''srno,'' terms;";
			 param.put("almariahtermsquery", almariahtermsquery);
		}
		else
		{
			 reportFileName="leaseCalcPrintAlmariah.jrxml";
		}
		System.out.println("==== "+reportFileName);
		
		
				
				
				String contractQry="select @i:=@i+1 as srno,concat(brd.brand_name,' , ',model.vtype) vehicle_description,lprd.QTY,"
								+" crq.driver,crq.fuel,crq.salik,crq.security_pass as 'Security Pass',crq.safety_acsrs as 'Safety Accessories',"
								+" round(crq.ratepermonth,2) as 'Unit Monthly Rate',round(crq.exkmcharge,2) as 'Excess KM Rate', crq.leasemonths 'Lease Duration'"
								+" from gl_almariahleasecalcm m left join gl_almariahleasecalcreq crq on m.doc_no=crq.rdocno"
								+" left join gl_lprm  lpr on m.reqdoc=lpr.doc_no"
								+" left join gl_lprd lprd on lpr.doc_no=lprd.rdocno"
								+" left join gl_vehbrand brd on lprd.brdid=brd.doc_no"
								+" left join gl_vehmodel model on lprd.modid=model.doc_no ,(select @i:=0) r where m.doc_no="+doc+" and m.status=3";
				param.put("contractquery", contractQry);
				System.out.println("Contract:"+contractQry);
				String termsquery="select distinct @s:=@s+1 sr_no,termsheader terms,m.doc_no, 0 priorno from (select distinct  tr.rdocno, termsid"
						+" from my_trterms tr where  tr.dtype='MLA' and tr.brhid=1 and tr.rdocno=1 and tr.status=3 ) tr"
						+" inner join my_termsm m on(tr.termsid=m.voc_no), (SELECT @s:= 0) AS s where  m.status=3";
				param.put("termsquery", termsquery);
				
				System.out.println("-----......------.....term.... "+termsquery);
				String headerimgpath=request.getSession().getServletContext().getRealPath("/icons/almariah3.jpg");
				headerimgpath=headerimgpath.replace("\\", "\\\\");
				param.put("printheader", headerimgpath);
				
				String footerimgpath=request.getSession().getServletContext().getRealPath("/icons/almariahFooter.jpg");
				footerimgpath=footerimgpath.replace("\\", "\\\\");
				param.put("printfooter", footerimgpath);
				
				param.put("date", pintbean.getLbldate());
				param.put("contractperiod", pintbean.getLblcontractperiod());	
				param.put("companyname", pintbean.getLblcompname());
				param.put("services", pintbean.getLblservices());
				
				JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/operations/marketing/leasecalculatoralmariah/"+reportFileName));
				JasperReport jasperReport = JasperCompileManager.compileReport(design);
				generateReportPDF(response, param, jasperReport, conn);
			}
			catch (Exception e) {
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
	
	public String getLblcontractperiod() {
		return lblcontractperiod;
	}
	public void setLblcontractperiod(String lblcontractperiod) {
		this.lblcontractperiod = lblcontractperiod;
	}
	
}
