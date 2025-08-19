package com.operations.agreement.masterleaseagmtalmariah;

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

public class ClsMasterLeaseAgmtAlmariahAction {
	ClsMasterLeaseAgmtAlmariahDAO masterdao=new ClsMasterLeaseAgmtAlmariahDAO();
	
	ClsCommon objcommon=new ClsCommon();
	private String date,docno,vocno,po,refno,cldocno,clientdetails,description,startdate,enddate,mode,msg,deleted,brchName,formdetailcode;
	private String cmbreftype,qotrefno,hidqotrefno,hidcmbreftype,projectno,hidprojectno;
	private String url;
	private Map<String, Object> param=null;

	private String lblhpd,lbldiw,lblrateperexhr,lblkmrestrict,lblexcesskm;
	
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

	public String getUrl() {
		return url;	
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getCmbreftype() {
		return cmbreftype;
	}

	public void setCmbreftype(String cmbreftype) {
		this.cmbreftype = cmbreftype;
	}

	public String getQotrefno() {
		return qotrefno;
	}

	public void setQotrefno(String qotrefno) {
		this.qotrefno = qotrefno;
	}

	public String getHidqotrefno() {
		return hidqotrefno;
	}

	public void setHidqotrefno(String hidqotrefno) {
		this.hidqotrefno = hidqotrefno;
	}

	public String getHidcmbreftype() {
		return hidcmbreftype;
	}

	public void setHidcmbreftype(String hidcmbreftype) {
		this.hidcmbreftype = hidcmbreftype;
	}

	public String getProjectno() {
		return projectno;
	}

	public void setProjectno(String projectno) {
		this.projectno = projectno;
	}

	public String getHidprojectno() {
		return hidprojectno;
	}

	public void setHidprojectno(String hidprojectno) {
		this.hidprojectno = hidprojectno;
	}
	private int gridlength;
	
	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getBrchName() {
		return brchName;
	}

	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getDocno() {
		return docno;
	}

	public void setDocno(String docno) {
		this.docno = docno;
	}

	public String getVocno() {
		return vocno;
	}

	public void setVocno(String vocno) {
		this.vocno = vocno;
	}

	public String getPo() {
		return po;
	}

	public void setPo(String po) {
		this.po = po;
	}

	public String getRefno() {
		return refno;
	}

	public void setRefno(String refno) {
		this.refno = refno;
	}

	public String getCldocno() {
		return cldocno;
	}

	public void setCldocno(String cldocno) {
		this.cldocno = cldocno;
	}

	public String getClientdetails() {
		return clientdetails;
	}

	public void setClientdetails(String clientdetails) {
		this.clientdetails = clientdetails;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
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
	
	
	private String transport,vrental,driversrvc,security_pass,fuel;	
	

	public String getTransport() {
		return transport;
	}

	public void setTransport(String transport) {
		this.transport = transport;
	}

	public String getVrental() {
		return vrental;
	}

	public void setVrental(String vrental) {
		this.vrental = vrental;
	}

	public String getDriversrvc() {
		return driversrvc;
	}

	public void setDriversrvc(String driversrvc) {
		this.driversrvc = driversrvc;
	}

	
	public String getSecurity_pass() {
		return security_pass;
	}

	public void setSecurity_pass(String security_pass) {
		this.security_pass = security_pass;
	}

	public String getFuel() {
		return fuel;
	}

	public void setFuel(String fuel) {
		this.fuel = fuel;
	}

	public void setData(String docno,String vocno,java.sql.Date sqldate,java.sql.Date sqlstartdate,java.sql.Date sqlenddate){
		if(sqldate!=null){
			setDate(sqldate.toString());
		}
		if(sqlstartdate!=null){
			setStartdate(sqlstartdate.toString());
		}
		if(sqlenddate!=null){
			setEnddate(sqlenddate.toString());
		}
		
		
		
		
		
		
		
		setCldocno(getCldocno());
		setDocno(docno);
		setVocno(vocno);
		setPo(getPo());
		setRefno(getRefno());
		setCldocno(getCldocno());
		setClientdetails(getClientdetails());
		setHidcmbreftype(getHidcmbreftype());
		setCmbreftype(getHidcmbreftype());
		setHidqotrefno(getHidqotrefno());
		setQotrefno(getQotrefno());
		setProjectno(getProjectno());
		setHidprojectno(getHidprojectno());
	}
	public String saveAction() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		String formcode="";
		int val=0;
		Map<String, String[]> requestParams = request.getParameterMap();
		java.sql.Date sqlstartdate=null;
		java.sql.Date sqlenddate=null;
		java.sql.Date sqldate=null;
		
		if(!getStartdate().equalsIgnoreCase("") && getStartdate()!=null){
			sqlstartdate=objcommon.changeStringtoSqlDate(getStartdate());
		}
		if(!getEnddate().equalsIgnoreCase("") && getEnddate()!=null){
			sqlenddate=objcommon.changeStringtoSqlDate(getEnddate());
		}
		if(!getDate().equalsIgnoreCase("") && getDate()!=null){
			sqldate=objcommon.changeStringtoSqlDate(getDate());
		}
		ArrayList<String> gridarray=new ArrayList<>();
		System.out.println("Gridlength:"+getGridlength());
		for(int i=0;i<getGridlength();i++){
			String temp=requestParams.get("gridarray"+i)[0];
			gridarray.add(temp);
		}
		if(mode.equalsIgnoreCase("A")){
			
			val=masterdao.insert(sqldate,sqlstartdate,sqlenddate,getPo(),getRefno(),getCldocno(),getDescription(),getBrchName(),
					session,mode,getFormdetailcode(),gridarray,request,getCmbreftype(),getHidqotrefno(),getHidprojectno());
			if(val>0){
				setData(val+"", request.getAttribute("vocno").toString(), sqldate, sqlstartdate, sqlenddate);
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setData(val+"", "0", sqldate, sqlstartdate, sqlenddate);
				setMsg("Not Saved");
				return "fail";
			}
		}
		/*else if(mode.equalsIgnoreCase("E")){
			boolean status=masterdao.edit(getDocno(),sqldate,sqlstartdate,sqlenddate,getPo(),getRefno(),getCldocno(),getDescription(),getBrchName(),session,mode,getFormdetailcode(),gridarray,request);
			if(status){
				setData(getDocno(), getVocno(), sqldate, sqlstartdate, sqlenddate);
				setMsg("Successfully Updated");
				return "success";
			}
			else{
				setData(getDocno(), getVocno(), sqldate, sqlstartdate, sqlenddate);
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			boolean status=masterdao.delete(getDocno(),sqldate,sqlstartdate,sqlenddate,getPo(),getRefno(),getCldocno(),getDescription(),getBrchName(),session,mode,getFormdetailcode(),gridarray,request);
			if(status){
				setData(getDocno(), getVocno(), sqldate, sqlstartdate, sqlenddate);
				setMsg("De");
				return "success";
			}
			else{
				setData(getDocno(), getVocno(), sqldate, sqlstartdate, sqlenddate);
				setMsg("Not Updated");
				return "fail";
			}
		}*/
		
		return "fail";
	}
	
	public String printAction() throws ParseException, SQLException{
//		System.out.println("printttttt-----");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		int doc=Integer.parseInt(request.getParameter("docno"));
		String dtype=request.getParameter("formdetailcode");
		
		int dcode=Integer.parseInt(request.getParameter("code")==null?"0":request.getParameter("code"));

		ClsMasterLeaseAgmtAlmariahBean bean=new ClsMasterLeaseAgmtAlmariahBean();
		bean=masterdao.getPrint(doc,request,session);
		setUrl(objcommon.getPrintPath(dtype));
		
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
			 reportFileName="leaseagmtPrintAlmariah01.jrxml";
			  almariahtermsquery="SELECT '1' srno,'Offer in Annexure A is a fixed monthly rate, services shall be "
			 		+ "provided for "+bean.getLblhpd() +"hrs., "+bean.getLbldiw() +" days a week. Extra hours shall be charged at AED "+bean.getLblrateperexhr() +"/hr.' terms UNION ALL "
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
			 reportFileName="leaseagmtPrintAlmariah02.jrxml";
			   almariahtermsquery="SELECT '1' srno,'Offer in Annexure A is a fixed monthly rate, services shall be provided for "+bean.getLblhpd()+ "hrs, "+bean.getLbldiw()+" days a week. Extra hours shall be charged at AED "+bean.getLblrateperexhr()+"/hr.' "
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
			 reportFileName="leaseagmtPrintAlmariah002.jrxml";
			almariahtermsquery="SELECT '1' srno,'Offer in Annexure A is a fixed monthly rate, services shall be provided for "+bean.getLblhpd()+"hrs, "+bean.getLbldiw()+" days a week. "
			 		+ "Extra hours shall be charged at AED "+bean.getLblrateperexhr()+"/hr.' terms UNION ALL SELECT '' srno,'' terms UNION ALL SELECT '2' srno,'This contract is made for staff transportation only; hence, any Traffic violations, and penalties due to illegal "
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
			 reportFileName="leaseagmtPrintAlmariah04.jrxml";
			almariahtermsquery="SELECT '1' srno,'Offer in Annexure A is a fixed monthly rate, based on "+bean.getLblkmrestrict()+" km/mo., any excess KM shall be charged at AED "+bean.getLblexcesskm()+"/km.' "
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
			 reportFileName="leaseagmtPrintAlmariah06.jrxml";
			almariahtermsquery="SELECT '1' srno,'Offer in Annexure A is a fixed monthly rate, based on "+bean.getLblkmrestrict()+" km/mo., any excess KM shall be charged at AED "+bean.getLblexcesskm()+"/km.' terms UNION ALL SELECT '' srno,'' terms UNION ALL SELECT '2' srno,'The Lessee must furnish Al Mariah General Transport (AGT) with Lessee’s driver’s license and passport copy. Further,"
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
			 reportFileName="leaseagmtPrintAlmariah05.jrxml";
			almariahtermsquery="SELECT '1' srno,'Offer in Annexure A is a fixed monthly rate, based on "+bean.getLblkmrestrict()+" km/mo., any excess KM shall be charged at AED "+bean.getLblexcesskm()+"/km.' terms UNION ALL SELECT '' srno,'' terms UNION ALL SELECT '2' srno,'The Lessee must furnish Al Mariah General Transport (AGT) with Lessee’s driver’s license and passport copy. Further, the Lessee must inform AGT of any change of driver"
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
			 reportFileName="leaseagmtPrintAlmariah.jrxml";
		}
		System.out.println("==== "+reportFileName);
		
		
				
				
				String contractQry="select @i:=@i+1 as srno,concat(brd.brand_name,' , ',model.vtype,' , ',coalesce(spec.details,'')) vehicle_description,d.QTY,"
						+" lreq.driver,lreq.fuel,lreq.salik,lreq.security_pass as 'Security Pass',lreq.safety_acsrs as 'Safety Accessories',"
						+" round(d.rate,2) as 'Unit Monthly Rate',round(d.excesskmrate,2) as 'Excess KM Rate',"
						+" d.duration 'Lease Duration' from gl_masterlagm m left join gl_masterlagd d on m.doc_no=d.rdocno"
						+" left join gl_almariahleasecalcm calc on m.qotrefno=calc.doc_no left join gl_lprm reqm on calc.reqdoc=reqm.doc_no"
						+" left join gl_lprd reqd on reqm.doc_no=reqd.rdocno left join gl_vehbrand brd on d.brdid=brd.doc_no"
						+" left join gl_vehmodel model on d.modelid=model.doc_no left join gl_vehspec spec on d.specid=spec.doc_no"
						+" left join gl_almariahleasecalcreq lreq on m.QOTrefNo=lreq.rdocno and d.sr_no=lreq.sr_no"
						+" ,(select @i:=0) r where m.doc_no="+doc+" and d.status=3";
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
				
				param.put("date", bean.getLbldate());
				param.put("licenseno",bean.getLbllicenseno());
				param.put("area", bean.getLblarea());
				param.put("contractperiod", bean.getLblcontractperiod());	
				param.put("companyname", bean.getLblcompanyname());
				param.put("services", bean.getLblservices());
				param.put("terms", bean.getLblterms());
				param.put("startdate", bean.getStartdate());
				System.out.println("strt----"+bean.getStartdate());
				
				//System.out.println("--param--:-"+param);
				JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/operations/agreement/masterleaseagmtalmariah/" +reportFileName));
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
}
