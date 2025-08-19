package com.dashboard.workshop.gateoutpass;


	import java.io.IOException;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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

	import com.common.*;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
import com.operations.commtransactions.invoice.ClsManualInvoiceDAO;
import com.workshop.gateinpass.ClsGateInPassBean;
	public class ClsGateOutPassAction extends ActionSupport{
		ClsConnection ClsConnection=new ClsConnection();
		ClsCommon objcommon=new ClsCommon();
		ClsGateOutPassDAO gatedao=new ClsGateOutPassDAO();
		ClsGateOutPassBean gatebean=new ClsGateOutPassBean();

		private String docno,date,fleetno,fleetdetails,brchName,chkdriver,hidchkdriver,driver,hiddriver,indate,intime,inkm,cmbinfuel,remarks,serviceduekm,hidcmbinfuel,srvckm,ch_no,eng_no,lastsrvckm,cldocno,agmtno,agmtexist,clientdetails;
		private String drivernumber,datetime,outdatetime,client,regno,branch;
		private String partsqry;
		private String jobqry;

		
	public String getPartsqry() {
			return partsqry;
		}
		public void setPartsqry(String partsqry) {
			this.partsqry = partsqry;
		}
		public String getJobqry() {
			return jobqry;
		}
		public void setJobqry(String jobqry) {
			this.jobqry = jobqry;
		}
		public String getBranch() {
			return branch;
		}

		public void setBranch(String branch) {
			this.branch = branch;
		}
	public String getOutdatetime() {
			return outdatetime;
		}
		public void setOutdatetime(String outdatetime) {
			this.outdatetime = outdatetime;
		}
	public String getDatetime() {
			return datetime;
		}
		public void setDatetime(String datetime) {
			this.datetime = datetime;
		}
	public String getDrivernumber() {
			return drivernumber;
		}
		public void setDrivernumber(String drivernumber) {
			this.drivernumber = drivernumber;
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
	public String getDocno() {
			return docno;
		}
		public void setDocno(String docno) {
			this.docno = docno;
		}
		public String getDate() {
			return date;
		}
		public void setDate(String date) {
			this.date = date;
		}
		public String getFleetno() {
			return fleetno;
		}
		public void setFleetno(String fleetno) {
			this.fleetno = fleetno;
		}
		public String getFleetdetails() {
			return fleetdetails;
		}
		public void setFleetdetails(String fleetdetails) {
			this.fleetdetails = fleetdetails;
		}
		public String getBrchName() {
			return brchName;
		}
		public void setBrchName(String brchName) {
			this.brchName = brchName;
		}
		public String getChkdriver() {
			return chkdriver;
		}
		public void setChkdriver(String chkdriver) {
			this.chkdriver = chkdriver;
		}
		public String getHidchkdriver() {
			return hidchkdriver;
		}
		public void setHidchkdriver(String hidchkdriver) {
			this.hidchkdriver = hidchkdriver;
		}
		public String getDriver() {
			return driver;
		}
		public void setDriver(String driver) {
			this.driver = driver;
		}
		public String getHiddriver() {
			return hiddriver;
		}
		public void setHiddriver(String hiddriver) {
			this.hiddriver = hiddriver;
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
		public String getInkm() {
			return inkm;
		}
		public void setInkm(String inkm) {
			this.inkm = inkm;
		}
		public String getCmbinfuel() {
			return cmbinfuel;
		}
		public void setCmbinfuel(String cmbinfuel) {
			this.cmbinfuel = cmbinfuel;
		}
		public String getRemarks() {
			return remarks;
		}
		public void setRemarks(String remarks) {
			this.remarks = remarks;
		}
		public String getServiceduekm() {
			return serviceduekm;
		}
		public void setServiceduekm(String serviceduekm) {
			this.serviceduekm = serviceduekm;
		}
		public String getHidcmbinfuel() {
			return hidcmbinfuel;
		}
		public void setHidcmbinfuel(String hidcmbinfuel) {
			this.hidcmbinfuel = hidcmbinfuel;
		}
		public String getSrvckm() {
			return srvckm;
		}
		public void setSrvckm(String srvckm) {
			this.srvckm = srvckm;
		}
		public String getCh_no() {
			return ch_no;
		}
		public void setCh_no(String ch_no) {
			this.ch_no = ch_no;
		}
		public String getEng_no() {
			return eng_no;
		}
		public void setEng_no(String eng_no) {
			this.eng_no = eng_no;
		}
		public String getLastsrvckm() {
			return lastsrvckm;
		}
		public void setLastsrvckm(String lastsrvckm) {
			this.lastsrvckm = lastsrvckm;
		}
		public String getCldocno() {
			return cldocno;
		}
		public void setCldocno(String cldocno) {
			this.cldocno = cldocno;
		}
		public String getAgmtno() {
			return agmtno;
		}
		public void setAgmtno(String agmtno) {
			this.agmtno = agmtno;
		}
		public String getAgmtexist() {
			return agmtexist;
		}
		public void setAgmtexist(String agmtexist) {
			this.agmtexist = agmtexist;
		}
		public String getClientdetails() {
			return clientdetails;
		}
		public void setClientdetails(String clientdetails) {
			this.clientdetails = clientdetails;
		}
		private String url;
		public String getUrl() {
			return url;
		}

		public void setUrl(String url) {
			this.url = url;
		}

		private Map<String, Object> param=null;
		public Map<String, Object> getParam() {
			return param;
		}

		public void setParam(Map<String, Object> param) {
			this.param = param;
		}

		 



		ClsCommon com=new ClsCommon();
		ClsConnection connection=new ClsConnection();

		public String printAction() throws ParseException, SQLException{
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			String fromdate=request.getParameter("fromdate");
			System.out.println("fromdate...."+fromdate);
			String todate=request.getParameter("todate");
			System.out.println("todate...."+todate);
			String branch=request.getParameter("branch");
			String branchname="",user="";
			ResultSet rs=null;
		    HttpServletResponse response = ServletActionContext.getResponse();
		    java.sql.Date sqlfromdate = null;
		    java.sql.Date sqltodate = null;   
				 param = new HashMap();    
					Connection conn = null;
					Statement stmt =null;
				 try {	
					    conn = ClsConnection.getMyConnection();
						stmt=conn.createStatement();
//					 if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
//							sqlfromdate = cmn.changeStringtoSqlDate(fromdate);
//						}
//					 if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
//							sqltodate = cmn.changeStringtoSqlDate(todate);
//						}
						
						String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
			        	imgpath=imgpath.replace("\\", "\\\\");    
			        	 param.put("img", imgpath);
			         String doc=request.getParameter("docno");
				     String brhid=request.getParameter("brhid").toString();
					 String dtype=request.getParameter("dtype").toString();
					 gatebean=gatedao.getPrint(doc,request,session,brhid);
					 String strSqldetail="select @i:=@i+1 srno,a.* from(select det.description,comp.compname complaint from  gl_workgateinpassd det left join gl_complaint comp on det.complaintid=comp.doc_no where "
								+ "det.status=3 and det.rdocno="+docno+" and det.brhid="+brhid+") a ,(select @i:=0) as i";
					  System.out.println("===== "+strSqldetail);
			          param.put("docno", gatebean.getDocno());
			          param.put("datetime", gatebean.getDatetime());
			          param.put("datetimeout", gatebean.getOutdatetime());
			          param.put("clientname", gatebean.getClient());
			          param.put("branchname", gatebean.getBranch());
			          param.put("driver", gatebean.getDriver());
			          param.put("drivermobile", gatebean.getDrivernumber());
			          param.put("regno", gatebean.getRegno());
			          param.put("serviceduekm", gatebean.getSrvckm());
			          param.put("engno",gatebean.getEng_no());
			          param.put("chassisno",gatebean.getCh_no());
			          param.put("inkm", gatebean.getInkm());
			          param.put("remarks", gatebean.getRemarks());
			          param.put("partsqry", gatebean.getPartsqry());
			  		  param.put("jobtobecarryqry", gatebean.getJobqry());
			          
				       // System.out.println("in...."+user);
				       
		    			           
			                   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/workshop/gateoutpass/gateoutpass2.jrxml"));
		     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
		     	               System.out.println("in....");               
		     	               generateReportPDF(response, param, jasperReport, conn);
		          
		               } catch (Exception e) {      

		                 e.printStackTrace();
		             }
		            	 
		            finally{
				conn.close();
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

