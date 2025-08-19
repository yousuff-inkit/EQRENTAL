package com.dashboard.vehicle.readytorent;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
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
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.humanresource.setup.employeemaster.ClsEmployeeMasterDAO;
import com.mailwithpdf.EmailProcess;
import com.mailwithpdf.SendEmailAction;

public class ClsReadyToRentAction {
	
	ClsCommon ClsCommon=new ClsCommon();
	
	private Map<String, Object> param=null;
	private String lease,rental,availableveh,unrentable,notreleased,nonrevmov,custody,accidentrepair,maintenance,service,delivery,totalnonrevanue1,totalnonrevanue2,totalonhire1,totalonhire2,totalfleetavailable,forsale,grandtotal,replacement;
	
	
	public String getReplacement() {
		return replacement;
	}
	public void setReplacement(String replacement) {
		this.replacement = replacement;
	}
	public String getLease() {
		return lease;
	}
	public void setLease(String lease) {
		this.lease = lease;
	}
	public String getRental() {
		return rental;
	}
	public void setRental(String rental) {
		this.rental = rental;
	}
	public String getAvailableveh() {
		return availableveh;
	}
	public void setAvailableveh(String availableveh) {
		this.availableveh = availableveh;
	}
	public String getUnrentable() {
		return unrentable;
	}
	public void setUnrentable(String unrentable) {
		this.unrentable = unrentable;
	}
	public String getNotreleased() {
		return notreleased;
	}
	public void setNotreleased(String notreleased) {
		this.notreleased = notreleased;
	}
	public String getNonrevmov() {
		return nonrevmov;
	}
	public void setNonrevmov(String nonrevmov) {
		this.nonrevmov = nonrevmov;
	}
	public String getCustody() {
		return custody;
	}
	public void setCustody(String custody) {
		this.custody = custody;
	}
	public String getAccidentrepair() {
		return accidentrepair;
	}
	public void setAccidentrepair(String accidentrepair) {
		this.accidentrepair = accidentrepair;
	}
	public String getMaintenance() {
		return maintenance;
	}
	public void setMaintenance(String maintenance) {
		this.maintenance = maintenance;
	}
	public String getService() {
		return service;
	}
	public void setService(String service) {
		this.service = service;
	}
	public String getDelivery() {
		return delivery;
	}
	public void setDelivery(String delivery) {
		this.delivery = delivery;
	}
	public String getTotalnonrevanue1() {
		return totalnonrevanue1;
	}
	public void setTotalnonrevanue1(String totalnonrevanue1) {
		this.totalnonrevanue1 = totalnonrevanue1;
	}
	public String getTotalnonrevanue2() {
		return totalnonrevanue2;
	}
	public void setTotalnonrevanue2(String totalnonrevanue2) {
		this.totalnonrevanue2 = totalnonrevanue2;
	}
	public String getTotalonhire1() {
		return totalonhire1;
	}
	public void setTotalonhire1(String totalonhire1) {
		this.totalonhire1 = totalonhire1;
	}
	public String getTotalonhire2() {
		return totalonhire2;
	}
	public void setTotalonhire2(String totalonhire2) {
		this.totalonhire2 = totalonhire2;
	}
	public String getTotalfleetavailable() {
		return totalfleetavailable;
	}
	public void setTotalfleetavailable(String totalfleetavailable) {
		this.totalfleetavailable = totalfleetavailable;
	}
	public String getForsale() {
		return forsale;
	}
	public void setForsale(String forsale) {
		this.forsale = forsale;
	}
	public String getGrandtotal() {
		return grandtotal;
	}
	public void setGrandtotal(String grandtotal) {
		this.grandtotal = grandtotal;
	}
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	
	
	public String printAction() throws ParseException, SQLException{
//		System.out.println("inside print action ");
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpServletResponse response=ServletActionContext.getResponse();
			HttpSession session=request.getSession();
			String brhid=request.getParameter("brhid");
			String company=request.getParameter("company");
			String print=request.getParameter("print");
			String email="";
			String contextPath=request.getContextPath();
			
//			System.out.println("context path"+contextPath);
			
			//if(ClsCommon.getPrintPath(dtype).contains(".jrxml")==true){
//				System.out.println("print jrxml----------------------------");
				 ClsConnection conobj=new ClsConnection();
	        	   param = new HashMap();
	        	   Connection conn = null;
	        	   conn = conobj.getMyConnection();
	        	   
	        	   ClsReadyToRentDAO pdao=new ClsReadyToRentDAO();
	        	   ClsReadyToRentBean printbean=new ClsReadyToRentBean();
	        	   
	        	   printbean=pdao.getPrint(brhid);
	        	   String reportFileName = "Fleet Status";
	        	   String photopath="1";
	        	   try{
	        		   
	        		  Statement stmte = conn.createStatement();
	      			  String strSql10 = "select email FROM gl_emailmsg where dtype='RTR'";
//	      			  System.out.println("==strSql10===="+strSql10);
	      			  ResultSet rse = stmte.executeQuery(strSql10);
	      			  while(rse.next ()) {
	      				email=rse.getString("email");  
	      			  }
	        		   
	        		   String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
	        		   System.out.println("real path"+imgpath);
	        		   imgpath=imgpath.replace("\\", "\\\\");
	        		   
	        		   param.put("complogo", imgpath);
	        		   
	        		   param.put("lease", printbean.getLease());
	        		   param.put("rental", printbean.getRental());
	        		   param.put("availableveh", printbean.getAvailableveh());
	        		   param.put("unrentable", printbean.getUnrentable());
	        		   param.put("notreleased", printbean.getNotreleased());
	        		   param.put("nonrevmov", printbean.getNonrevmov());
	        		   param.put("custody", printbean.getCustody());
	        		   param.put("accidentrepair", printbean.getAccidentrepair());
	        		   param.put("maintenance", printbean.getMaintenance());
	        		   param.put("service", printbean.getService());
	        		   param.put("delivery", printbean.getDelivery());
	        		   param.put("totalnonrevanue1", printbean.getTotalnonrevanue1());
	        		   param.put("totalonhire1", printbean.getTotalonhire1());
	        		   param.put("totalfleetavailable", printbean.getTotalfleetavailable());
	        		   param.put("forsale", printbean.getForsale());
	        		   param.put("grandtotal", printbean.getGrandtotal());
	        		   param.put("replacement", printbean.getReplacement());
	        		   param.put("blocked", printbean.getBlocked());
	        		   param.put("others", printbean.getOthers());
	        		   param.put("company", company);
	        		   
	        		   param.put("leaseper", printbean.getLeaseper());
	        		   param.put("rentalper", printbean.getRentalper());
	        		   param.put("availablevehper", printbean.getAvailablevehper());
	        		   param.put("unrentableper", printbean.getUnrentableper());
	        		   param.put("notreleasedper", printbean.getNotreleasedper());
	        		   param.put("nonrevmovper", printbean.getNonrevmovper());
	        		   param.put("custodyper", printbean.getCustodyper());
	        		   param.put("accidentrepairper", printbean.getAccidentrepairper());
	        		   param.put("maintenanceper", printbean.getMaintenanceper());
	        		   param.put("serviceper", printbean.getServiceper());
	        		   param.put("deliveryper", printbean.getDeliveryper());
	        		   param.put("replacementper",printbean.getReplacementper()); 
	        		   param.put("blockedper", printbean.getBlockedper());
	        		   param.put("othersper", printbean.getOthersper());
	        		   param.put("totalnonrevanue1per", printbean.getTotalnonrevanue1per());
	        		   param.put("totalonhire2per", printbean.getTotalonhire2per());
	        		   param.put("totalnonrevanue2per", printbean.getTotalnonrevanue2per());
	        		   param.put("totalonhire1per", printbean.getTotalonhire1per());
	        		   param.put("totalfleetavailableper", printbean.getTotalfleetavailableper());
	        		   param.put("forsaleper", printbean.getForsaleper());
	        		   param.put("grandtotalper", printbean.getGrandtotalper());
	        	
	        		   String reportFilepath = ClsCommon.getBIBPrintPath("FLS");    
	        			  
	        		   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFilepath));	      	     	 
    	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
                       generateReportPDF(response, param, jasperReport, conn,email,print);
	        	   }catch (Exception e) {
				       e.printStackTrace();
				   }
	        	   finally{
	        		   conn.close();
	        	   }
			 //}
		 return "print";
	}
	
	private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn, String email, String print)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {
		  byte[] bytes = null;
      bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
      resp.reset();
      resp.resetBuffer();
      
      resp.setContentType("application/pdf");
      resp.setContentLength(bytes.length);
      ServletOutputStream ouputStream = resp.getOutputStream();
      
      if(print.equalsIgnoreCase("1")) {
      
	          ouputStream.write(bytes, 0, bytes.length);
	          ouputStream.flush();
	          ouputStream.close();
      } else {
    	
    	Statement stmtrr=conn.createStatement();
    	  
    	String fileName="",path="", formcode="RTR",filepath=""; 
    	String strSql1 = "select imgPath from my_comp";

  		ResultSet rs1 = stmtrr.executeQuery(strSql1);
  		while(rs1.next ()) {
  			path=rs1.getString("imgPath");
  		}

  		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
		java.util.Date date = new java.util.Date();
		String currdate=dateFormat.format(date);
		
  		fileName = "FleetStatus"+currdate+".pdf";
  		filepath=path+ "/attachment/"+formcode+"/"+fileName;

  		File dir = new File(path+ "/attachment/"+formcode);
  		dir.mkdirs();
  		
  		FileOutputStream fos = new FileOutputStream(filepath);
    	fos.write(bytes);
    	fos.flush();
    	fos.close();
    	
    	File saveFile=new File(filepath);
			SendEmailAction sendmail= new SendEmailAction();
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();  
			sendmail.SendTomail( saveFile,formcode,email,"1",session.getAttribute("BRANCHID").toString().trim(),session.getAttribute("USERID").toString().trim(),"1");
			
      }
           
  }
	
	
	
	public void emailAction() throws ParseException, SQLException{
//		System.out.println("inside print action ");
			String brhid="1";
			// String company="Epic Rent a car";
			String print="0";
			String contextPath="/CarRental";
			
				 ClsConnection conobj=new ClsConnection();
	        	   param = new HashMap();
	        	   Connection conn = null;
	        	   conn = conobj.getMyConnection();
	        	   
	        	   ClsReadyToRentDAO pdao=new ClsReadyToRentDAO();
	        	   ClsReadyToRentBean printbean=new ClsReadyToRentBean();
	        	   
	        	   printbean=pdao.getPrint(brhid);
	        	   String reportFileName = "Fleet Status";
	        	   String photopath="1";
	        	   try{
	        		   String ipath="",remail="",bccemail="";
	        		   String company="";
	        		   Statement stmt=conn.createStatement();
	        		   ResultSet rs=stmt.executeQuery("select company,imgPath from my_comp");
	        		   while(rs.next()){
	        			   ipath=rs.getString("imgPath");
	        			   company=rs.getString("company");
	        		   }
	        		   String subject="";
	        		   Statement stmte = conn.createStatement();
		      		   String strSql10 = "select subject,email,emailbcc FROM gl_emailmsg where dtype='RTR'";
		      		   // System.out.println("==strSql10===="+strSql10);
		      		   ResultSet rse = stmte.executeQuery(strSql10);
		      			  while(rse.next ()) {
		      				remail=rse.getString("email");
		      				bccemail=rse.getString("emailbcc");
		      				subject=rse.getString("subject");
		      			  }
	        		   
	        		   String imgpath=ipath+"/icons/epic.jpg";
	        		   imgpath=imgpath.replace("\\", "\\\\");
	        		   
	        		   param.put("complogo", imgpath);
	        		   
	        		   param.put("lease", printbean.getLease());
	        		   param.put("rental", printbean.getRental());
	        		   param.put("availableveh", printbean.getAvailableveh());
	        		   param.put("unrentable", printbean.getUnrentable());
	        		   param.put("notreleased", printbean.getNotreleased());
	        		   param.put("nonrevmov", printbean.getNonrevmov());
	        		   param.put("custody", printbean.getCustody());
	        		   param.put("accidentrepair", printbean.getAccidentrepair());
	        		   param.put("maintenance", printbean.getMaintenance());
	        		   param.put("service", printbean.getService());
	        		   param.put("delivery", printbean.getDelivery());
	        		   param.put("totalnonrevanue1", printbean.getTotalnonrevanue1());
	        		   param.put("totalonhire1", printbean.getTotalonhire1());
	        		   param.put("totalfleetavailable", printbean.getTotalfleetavailable());
	        		   param.put("forsale", printbean.getForsale());
	        		   param.put("grandtotal", printbean.getGrandtotal());
	        		   param.put("replacement", printbean.getReplacement());
	        		   param.put("blocked", printbean.getBlocked());
	        		   param.put("others", printbean.getOthers());
	        		   param.put("company", company);
	        		   
	        		   param.put("leaseper", printbean.getLeaseper());
	        		   param.put("rentalper", printbean.getRentalper());
	        		   param.put("availablevehper", printbean.getAvailablevehper());
	        		   param.put("unrentableper", printbean.getUnrentableper());
	        		   param.put("notreleasedper", printbean.getNotreleasedper());
	        		   param.put("nonrevmovper", printbean.getNonrevmovper());
	        		   param.put("custodyper", printbean.getCustodyper());
	        		   param.put("accidentrepairper", printbean.getAccidentrepairper());
	        		   param.put("maintenanceper", printbean.getMaintenanceper());
	        		   param.put("serviceper", printbean.getServiceper());
	        		   param.put("deliveryper", printbean.getDeliveryper());
	        		   param.put("replacementper",printbean.getReplacementper());
	        		   param.put("blockedper", printbean.getBlockedper());
	        		   param.put("othersper", printbean.getOthersper());
	        		   param.put("totalnonrevanue1per", printbean.getTotalnonrevanue1per());
	        		   param.put("totalonhire2per", printbean.getTotalonhire1per());
	        		   param.put("totalnonrevanue2per", printbean.getTotalnonrevanue2per());
	        		   param.put("totalonhire1per", printbean.getTotalonhire1per());
	        		   param.put("totalfleetavailableper", printbean.getTotalfleetavailableper());
	        		   param.put("forsaleper", printbean.getForsaleper());
	        		   param.put("grandtotalper", printbean.getGrandtotalper());
	        		   String reportFilepath = ClsCommon.getBIBPrintPath("FLS");    
	        		   JasperDesign design = JRXmlLoader.load(ipath+"/"+reportFilepath);	             	       	 
    	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
                       generateReportEmail(param, jasperReport, conn,remail,bccemail,print,subject);   
	        	   }catch (Exception e) {
				       e.printStackTrace();
				   }
	        	   finally{
	        		   conn.close();
	        	   }
			 //}
	}
	
	
	
	private void generateReportEmail (Map parameters, JasperReport jasperReport, Connection conn, String remail,String bccemail, String print, String subject)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {
		  byte[] bytes = null;
        bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
        EmailProcess ep=new EmailProcess();
    	Statement stmtrr=conn.createStatement();
    	  
    	String fileName="",path="", formcode="RTR",filepath=""; 
    	String host="", port="", userName="", password="", recipient="", message="",docnos="1";
    	String strSql1 = "select imgPath from my_comp";

  		ResultSet rs1 = stmtrr.executeQuery(strSql1);
  		while(rs1.next ()) {
  			path=rs1.getString("imgPath");
  		}
  		
  		  /*Statement stmt10 = conn.createStatement();
		  String strSql10 = "select msg,subject FROM gl_emailmsg where dtype='"+formcode+"' ";
		  System.out.println("==strSql10===="+strSql10);
		  ResultSet rs10 = stmt10.executeQuery(strSql10);
		  while(rs10.next ()) {
	
			  message=rs10.getString("msg");
			  subject=rs10.getString("subject");
		  }*/
  		
		/*Statement stmt1 = conn.createStatement();
	    String strSql1 = "select email,mailpass,smtpServer,smtpHostport FROM my_user where doc_no='"+session.getAttribute("USERID").toString()+"'";
		System.out.println("==strSql1===="+strSql1);
		ResultSet rs1 = stmt1.executeQuery(strSql1);
		while(rs1.next ()) {*/
	  		/*password=rs1.getString("mailpass");
			password=ClsEncrypt.getInstance().decrypt(password);*/

/*  		userName="reports@epicrentacar.com";
			port="587";
			host="secure.emailsrvr.com";
			password="Gateway#2018";
*/
  		//Updated on request from EPIC on 26-11-2019
		

		/*
  		userName="reports@epicrac.com";
		port="587";
		host="smtp.domain.com";
		password="S9$d6irWRvEk7@Y"; */
		
		
		userName="gatewayerp55@gmail.com";
		port="587";
		host="smtp.gmail.com";
		password="gwsupport#321"; 
		message="Please find the attached vehicle status report";
		//}
  		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
		java.util.Date date = new java.util.Date();
		String currdate=dateFormat.format(date);
		
		
		DateFormat dateFormat2 = new SimpleDateFormat("dd_MM_yyyy");
		java.util.Date date2 = new java.util.Date();
		String currdate2=dateFormat2.format(date2);
		//subject="Fleet status Epic Rent a car "+currdate2+" 8:00";
		subject=subject+"  "+currdate2;
  		fileName = "FleetStatus"+currdate+".pdf";
  		filepath=path+ "/attachment/"+formcode+"/"+fileName;

  		File dir = new File(path+ "/attachment/"+formcode); 
  		dir.mkdirs();
  		
  		FileOutputStream fos = new FileOutputStream(filepath);
    	fos.write(bytes);
    	fos.flush();  
    	fos.close();
    	
    	File saveFile=new File(filepath);
		SendEmailAction sendmail= new SendEmailAction();
		//String[] remails=remail.split(",");
		
			ep.sendEmailwithpdfBCC(host, port, userName, password,remail, "",bccemail,subject, message, saveFile,docnos);
           
  }
	
}
