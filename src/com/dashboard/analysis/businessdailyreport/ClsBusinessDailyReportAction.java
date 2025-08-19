package com.dashboard.analysis.businessdailyreport;

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

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.email.SendEmailAction;
import com.opensymphony.xwork2.ActionSupport;

public class ClsBusinessDailyReportAction extends ActionSupport{

	ClsBusinessDailyReportDAO businessDailyReportDAO= new ClsBusinessDailyReportDAO();
	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	
	private Map<String, Object> param = null;
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	
	public void printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session=request.getSession();
	    Connection conn = null;
	    java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		try {
			conn = connDAO.getMyConnection();
	        Statement stmtClient =conn.createStatement();
	        ClsBusinessDailyReportDAO busdao= new  ClsBusinessDailyReportDAO();
	        param = new HashMap();
	        String sqld="",sqld1="",condition="",joins="",casestatement="",sqlUnapplyResult="0",sqlOutStandingResult="0",sqlAgeingResult="0",sqlSecurityResult="0";
	        
			
			String fromdate = request.getParameter("fromDate");
			//System.out.println("fromdate========"+fromdate);
			String todate = request.getParameter("toDate");
			//System.out.println("todate=========="+todate);
      	    String print = request.getParameter("print");
      	    //System.out.println("print=========="+print);
      	    String description = request.getParameter("desc");
      	    //System.out.println("description=========="+description);
      	    String branch = request.getParameter("brch");
      	   // System.out.println("branch============="+branch);
      	   
			if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
				sqlFromDate = commonDAO.changeStringtoSqlDate(fromdate);
            }
			
			if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
				sqlToDate = commonDAO.changeStringtoSqlDate(todate);
            }
			String detailquery=busdao.getPrint(description,branch,fromdate,todate);
			//System.out.println("detailquery============="+detailquery);
			/*paymentFollowUpBean=businessDailyReportDAO.getPrint(request,fromdate,todate);
			
			String reportFileName = commonDAO.getBIBPrintPath("BCPF");
			System.out.println("report file name "+reportFileName);
            String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
            imgpath=imgpath.replace("\\", "\\\\");
            String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
            imgpathfooter=imgpathfooter.replace("\\", "\\\\");*/
            
			String strbranch="select doc_no,branchname from my_brch where status=3";
			ResultSet rsbranch=stmtClient.executeQuery(strbranch);
			String branchname="";
			int y=0;
			String branchcount="0";
			while(rsbranch.next()){
				branchcount=branchcount+1;
				
			}
			 
	      	    //System.out.println(sqlFromDate+"====="+sqlToDate+"branchcount============="+branchcount);
           
            param.put("fromdate",fromdate);
            param.put("todate", todate);
            param.put("sqlfromdate",sqlFromDate);
            param.put("sqltodate", sqlToDate);
            param.put("branchcount", branchcount);
            param.put("description", description);
            param.put("detailquery", detailquery);
           
	        
	        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/analysis/businessdailyreport/Business.jrxml"));
  	        JasperReport jasperReport = JasperCompileManager.compileReport(design);
            generateReportPDF(response, param, jasperReport, conn);
			
            stmtClient.close();
            
		} catch (Exception e) {
            e.printStackTrace();
            conn.close();
    	} finally{
    		conn.close();
    	}
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
