package com.dashboard.accounts.ageingstatement;

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
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimpleXlsReportConfiguration;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import net.sf.jasperreports.engine.JRExporterParameter;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.SQLException;

import javax.servlet.ServletContext;

import java.io.OutputStream;



import org.apache.struts2.ServletActionContext;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.mailwithpdf.SendEmailAction;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")

public class ClsAgeingStatementAction extends ActionSupport{
    
	ClsAgeingStatementDAO ageingStatementDAO= new ClsAgeingStatementDAO();
	ClsAgeingStatementBean ageingStatementBean;
	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblprintname;
	private String lblprintname1;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lblservicetax;
	private String lblpan;
	private String lblcstno;
	private String lblaccountno;
	private String lblaccountname;
	private String lblaccountaddress;
	private String lblaccountemail;
	private String lblaccountmobileno;
	private String lblaccountphone;
	private String lblaccountfax;
	private String lblcreditperiodmin;
	private String lblcreditperiodmax;
	private String lblcreditlimit;
	private String lbllevel1from;
	private String lbllevel1to;
	private String lbllevel2from;
	private String lbllevel2to;
	private String lbllevel3from;
	private String lbllevel3to;
	private String lbllevel4from;
	private String lbllevel4to;
	private String lbllevel5from;
	
private String Lbllogoimgpath,Lblbankdetails,Lblbankbeneficiary,Lblbankaccountno,Lblbeneficiarybank,Lblbankibanno,Lblcompbranchaddress;
	
	public String getLbllogoimgpath() {
		return Lbllogoimgpath;
	}
	public void setLbllogoimgpath(String lbllogoimgpath) {
		Lbllogoimgpath = lbllogoimgpath;
	}
	public String getLblbankdetails() {
		return Lblbankdetails;
	}
	public void setLblbankdetails(String lblbankdetails) {
		Lblbankdetails = lblbankdetails;
	}
	public String getLblbankbeneficiary() {
		return Lblbankbeneficiary;
	}
	public void setLblbankbeneficiary(String lblbankbeneficiary) {
		Lblbankbeneficiary = lblbankbeneficiary;
	}
	public String getLblbankaccountno() {
		return Lblbankaccountno;
	}
	public void setLblbankaccountno(String lblbankaccountno) {
		Lblbankaccountno = lblbankaccountno;
	}
	public String getLblbeneficiarybank() {
		return Lblbeneficiarybank;
	}
	public void setLblbeneficiarybank(String lblbeneficiarybank) {
		Lblbeneficiarybank = lblbeneficiarybank;
	}
	public String getLblbankibanno() {
		return Lblbankibanno;
	}
	public void setLblbankibanno(String lblbankibanno) {
		Lblbankibanno = lblbankibanno;
	}
	public String getLblcompbranchaddress() {
		return Lblcompbranchaddress;
	}
	public void setLblcompbranchaddress(String lblcompbranchaddress) {
		Lblcompbranchaddress = lblcompbranchaddress;
	}
	
	private String lblsumnetamount;
	private String lblsumapplied;
	private String lblsumbalance;
	
	private String lblsumoutnetamount;
	private String lblsumoutapplied;
	private String lblsumoutbalance;
	
    private Double lblnetamount,lbldueamount;
	
	
	
	public Double getLbldueamount() {
		return lbldueamount;
	}
	public void setLbldueamount(Double lbldueamount) {
		this.lbldueamount = lbldueamount;
	}
	public void setLblnetamount(Double lblnetamount) {
		this.lblnetamount = lblnetamount;
	}

	private Map<String, Object> param = null;
	
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

	public String getLblprintname1() {
		return lblprintname1;
	}

	public void setLblprintname1(String lblprintname1) {
		this.lblprintname1 = lblprintname1;
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
	
	public String getLblaccountno() {
		return lblaccountno;
	}

	public void setLblaccountno(String lblaccountno) {
		this.lblaccountno = lblaccountno;
	}

	public String getLblaccountname() {
		return lblaccountname;
	}

	public void setLblaccountname(String lblaccountname) {
		this.lblaccountname = lblaccountname;
	}

	public String getLblaccountaddress() {
		return lblaccountaddress;
	}

	public void setLblaccountaddress(String lblaccountaddress) {
		this.lblaccountaddress = lblaccountaddress;
	}

	public String getLblaccountemail() {
		return lblaccountemail;
	}

	public void setLblaccountemail(String lblaccountemail) {
		this.lblaccountemail = lblaccountemail;
	}

	public String getLblaccountmobileno() {
		return lblaccountmobileno;
	}

	public void setLblaccountmobileno(String lblaccountmobileno) {
		this.lblaccountmobileno = lblaccountmobileno;
	}

	public String getLblaccountphone() {
		return lblaccountphone;
	}

	public void setLblaccountphone(String lblaccountphone) {
		this.lblaccountphone = lblaccountphone;
	}

	public String getLblaccountfax() {
		return lblaccountfax;
	}

	public void setLblaccountfax(String lblaccountfax) {
		this.lblaccountfax = lblaccountfax;
	}

	public String getLblcreditperiodmin() {
		return lblcreditperiodmin;
	}

	public void setLblcreditperiodmin(String lblcreditperiodmin) {
		this.lblcreditperiodmin = lblcreditperiodmin;
	}

	public String getLblcreditperiodmax() {
		return lblcreditperiodmax;
	}

	public void setLblcreditperiodmax(String lblcreditperiodmax) {
		this.lblcreditperiodmax = lblcreditperiodmax;
	}

	public String getLblcreditlimit() {
		return lblcreditlimit;
	}

	public void setLblcreditlimit(String lblcreditlimit) {
		this.lblcreditlimit = lblcreditlimit;
	}

	public String getLbllevel1from() {
		return lbllevel1from;
	}

	public void setLbllevel1from(String lbllevel1from) {
		this.lbllevel1from = lbllevel1from;
	}

	public String getLbllevel1to() {
		return lbllevel1to;
	}

	public void setLbllevel1to(String lbllevel1to) {
		this.lbllevel1to = lbllevel1to;
	}

	public String getLbllevel2from() {
		return lbllevel2from;
	}

	public void setLbllevel2from(String lbllevel2from) {
		this.lbllevel2from = lbllevel2from;
	}

	public String getLbllevel2to() {
		return lbllevel2to;
	}

	public void setLbllevel2to(String lbllevel2to) {
		this.lbllevel2to = lbllevel2to;
	}

	public String getLbllevel3from() {
		return lbllevel3from;
	}

	public void setLbllevel3from(String lbllevel3from) {
		this.lbllevel3from = lbllevel3from;
	}

	public String getLbllevel3to() {
		return lbllevel3to;
	}

	public void setLbllevel3to(String lbllevel3to) {
		this.lbllevel3to = lbllevel3to;
	}

	public String getLbllevel4from() {
		return lbllevel4from;
	}

	public void setLbllevel4from(String lbllevel4from) {
		this.lbllevel4from = lbllevel4from;
	}

	public String getLbllevel4to() {
		return lbllevel4to;
	}

	public void setLbllevel4to(String lbllevel4to) {
		this.lbllevel4to = lbllevel4to;
	}

	public String getLbllevel5from() {
		return lbllevel5from;
	}

	public void setLbllevel5from(String lbllevel5from) {
		this.lbllevel5from = lbllevel5from;
	}

	public String getLblsumnetamount() {
		return lblsumnetamount;
	}

	public void setLblsumnetamount(String lblsumnetamount) {
		this.lblsumnetamount = lblsumnetamount;
	}

	public String getLblsumapplied() {
		return lblsumapplied;
	}

	public void setLblsumapplied(String lblsumapplied) {
		this.lblsumapplied = lblsumapplied;
	}

	public String getLblsumbalance() {
		return lblsumbalance;
	}

	public void setLblsumbalance(String lblsumbalance) {
		this.lblsumbalance = lblsumbalance;
	}

	public String getLblsumoutnetamount() {
		return lblsumoutnetamount;
	}

	public void setLblsumoutnetamount(String lblsumoutnetamount) {
		this.lblsumoutnetamount = lblsumoutnetamount;
	}

	public String getLblsumoutapplied() {
		return lblsumoutapplied;
	}

	public void setLblsumoutapplied(String lblsumoutapplied) {
		this.lblsumoutapplied = lblsumoutapplied;
	}

	public String getLblsumoutbalance() {
		return lblsumoutbalance;
	}

	public void setLblsumoutbalance(String lblsumoutbalance) {
		this.lblsumoutbalance = lblsumoutbalance;
	}

	

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
        java.sql.Date sqlUpToDate = null;
        String header=request.getParameter("header")==null?"0":request.getParameter("header").toString();
//        System.out.println("------------------------IN-----------------------");
       // setLbllogoimgpath(ageingStatementBean.getLbllogoimgpath());
		//setLblcompbranchaddress(ageingStatementBean.getLblcompbranchaddress());
//    	setLblbankdetails(ageingStatementBean.getLblbankdetails());
    	//setLblbankbeneficiary(ageingStatementBean.getLblbankbeneficiary());
    	//setLblbankaccountno(ageingStatementBean.getLblbankaccountno());
    	//setLblbeneficiarybank(ageingStatementBean.getLblbeneficiarybank());
    //	setLblbankibanno(ageingStatementBean.getLblbankibanno());
		try {
			conn = connDAO.getMyConnection();
	        Statement stmtAgeingStatement =conn.createStatement();
	        param = new HashMap();
	        String sqld="",sqld1="",select="",select1="",joins="",casestatement="",sqlUnapplyResult="0";
	        
			String atype = request.getParameter("atype");
			String xlstat=request.getParameter("xlstat")==null?"0":request.getParameter("xlstat").toString();
			int acno=Integer.parseInt(request.getParameter("acno"));
			int level1from=Integer.parseInt(request.getParameter("level1from"));
			int level1to=Integer.parseInt(request.getParameter("level1to"));
			int level2from=Integer.parseInt(request.getParameter("level2from"));
			int level2to=Integer.parseInt(request.getParameter("level2to"));
			int level3from=Integer.parseInt(request.getParameter("level3from"));
			int level3to=Integer.parseInt(request.getParameter("level3to"));
			int level4from=Integer.parseInt(request.getParameter("level4from"));
			int level4to=Integer.parseInt(request.getParameter("level4to"));
			int level5from=Integer.parseInt(request.getParameter("level5from"));
			String branch = request.getParameter("branch");
			String uptoDate = request.getParameter("uptoDate");
			String email = request.getParameter("email");
      	    String print = request.getParameter("print");
      	    String branchimg="1";
      	    param.put("atype", atype);
      	    if(!(branch.equalsIgnoreCase("a") || branch.equalsIgnoreCase("NA") || branch.equalsIgnoreCase(""))){
      	    	branchimg=session.getAttribute("BRANCHID").toString().equalsIgnoreCase("a")?"1":session.getAttribute("BRANCHID").toString();
     		}
     	    System.out.println("branch==="+branch);
      	  if(branchimg.equalsIgnoreCase("1")){
				String branch1header = request.getSession().getServletContext().getRealPath("/icons/branch1header.jpg");
				branch1header =branch1header.replace("\\", "\\\\");	
				String branch1footer = request.getSession().getServletContext().getRealPath("/icons/branch1footer.jpg");
				branch1footer =branch1footer.replace("\\", "\\\\");
				param.put("branchheader", branch1header);
				param.put("branchfooter", branch1footer);
			}
			else if(branchimg.equalsIgnoreCase("2")){
				String branch2header = request.getSession().getServletContext().getRealPath("/icons/branch2header.jpg");
				branch2header =branch2header.replace("\\", "\\\\");	
				String branch2footer = request.getSession().getServletContext().getRealPath("/icons/branch2footer.jpg");
				branch2footer =branch2footer.replace("\\", "\\\\");
				param.put("branchheader", branch2header);
				param.put("branchfooter", branch2footer);
			}
			else if(branchimg.equalsIgnoreCase("3")){
				String branch3header = request.getSession().getServletContext().getRealPath("/icons/branch3header.jpg");
				branch3header =branch3header.replace("\\", "\\\\");	
				String branch3footer = request.getSession().getServletContext().getRealPath("/icons/branch3footer.jpg");
				branch3footer =branch3footer.replace("\\", "\\\\");
				param.put("branchheader", branch3header);
				param.put("branchfooter", branch3footer);
			}
      	    
      	    System.out.println("------------------------branch-----------------------"+branchimg);
			if(!(uptoDate.equalsIgnoreCase("undefined")) && !(uptoDate.equalsIgnoreCase("")) && !(uptoDate.equalsIgnoreCase("0"))){
				sqlUpToDate = commonDAO.changeStringtoSqlDate(uptoDate);
            }
			
			ageingStatementBean=ageingStatementDAO.getPrint(request,atype,acno,branch,uptoDate,level1from,level1to,level2from,level2to,level3from,level3to,level4from,level4to,level5from);
			
			String reportFileName = commonDAO.getBIBPrintPath("BAGS");
			
			
//			System.out.println("===========reportFileName======="+reportFileName);
			
            String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
            imgpath=imgpath.replace("\\", "\\\\");
            
            String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
            imgpathfooter=imgpathfooter.replace("\\", "\\\\");
            
            String path1="",brhiid="",brchaddress="",brchname="",brchtel="",brchfax=""; 
	        if(branch.equalsIgnoreCase("a") || branch.equalsIgnoreCase("NA")){    
	        	brhiid="1";   
    		}else {
    			brhiid=branch;    
    		}
       		String strsql2="select imgpath,branchname,address,tel,fax from my_brch where doc_no='"+brhiid+"'";       
       	    //System.out.println("strsql2--->>>"+strsql2);
	   	    ResultSet rs2=stmtAgeingStatement.executeQuery(strsql2);          
	   	    while(rs2.next()){   
	   	    	 brchname=rs2.getString("branchname");
	   	    	 path1=rs2.getString("imgpath");  
	   	    	 brchaddress=rs2.getString("address");
	   	    	 brchtel=rs2.getString("tel");
	   	    	 brchfax=rs2.getString("fax");
	   	    }
	   	    String imgpal=request.getSession().getServletContext().getRealPath(path1);     
		    imgpal=imgpal.replace("\\", "\\\\");
		    param.put("imgpal", imgpal);    
		    param.put("branchaddress", brchaddress); 
            param.put("brchname",brchname);
            param.put("brchaddress", brchaddress);
            param.put("brchtel",brchtel);
            param.put("brchfax", brchfax);
            
            if(atype.equalsIgnoreCase("AR")){
    			sqld=" and j.id < 0";
    			sqld1=" and j.id > 0";
    			
    			select ="select CONVERT(if(sum(t7)>0,round((sum(t7)),2),'  '),CHAR(50)) netamount,CONVERT(if(sum(l1)>0,round((sum(l1)),2),'  '),CHAR(50)) level1,"
    					+ "CONVERT(if(sum(l2)>0,round((sum(l2)),2),'  '),CHAR(50)) level2,CONVERT(if(sum(l3)>0,round((sum(l3)),2),'  '),CHAR(50)) level3,"  
    					+ "CONVERT(if(sum(l4)>0,round((sum(l4)),2),'  '),CHAR(50)) level4,CONVERT(if(sum(l5)>0,round((sum(l5)),2),'  '),CHAR(50)) level5 from ("
    					+ "select d.acno,d.brhid,d.doc_no,if(d.duedys between "+level1from+" and "+level1to+" and d.bal>0,round((d.bal),2),0) l1,if(d.duedys between "
    					+ ""+level2from+" and "+level2to+" and d.bal>0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+" and d.bal>0,"
    					+ "round((d.bal),2),0) l3,if(d.duedys between "+level4from+" and "+level4to+" and d.bal>0,round((d.bal),2),0) l4,if(d.duedys >="+level5from+" "
    					+ "and d.bal>0,round((d.bal),2),0) l5,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(10)) U6,if(d.bal>0,d.bal,0) t7 from ";
    		 
    			select1 ="select CONVERT(if(sum(t7)>0,round((sum(t7)),2),'  '),CHAR(50)) netamount,CONVERT((if(sum(t7)>0,round((sum(t7)),2)-(if(sum(dueamt)>0,round((sum(dueamt)),2),0)),'')),CHAR(50)) dueamt,CONVERT(if(sum(l1)>0,round((sum(l1)),2),'  '),CHAR(50)) level1,"
    					+ "CONVERT(if(sum(l2)>0,round((sum(l2)),2),'  '),CHAR(50)) level2,CONVERT(if(sum(l3)>0,round((sum(l3)),2),'  '),CHAR(50)) level3,"  
    					+ "CONVERT(if(sum(l4)>0,round((sum(l4)),2),'  '),CHAR(50)) level4,CONVERT(if(sum(l5)>0,round((sum(l5)),2),'  '),CHAR(50)) level5 from ("
    					+ "select d.acno,d.brhid,d.doc_no,if(d.duedys<0 and d.bal>0,round((d.bal),2),0)  dueamt,if(d.duedys between "+level1from+" and "+level1to+" and d.bal>0,round((d.bal),2),0) l1,if(d.duedys between "
    					+ ""+level2from+" and "+level2to+" and d.bal>0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+" and d.bal>0,"
    					+ "round((d.bal),2),0) l3,if(d.duedys between "+level4from+" and "+level4to+" and d.bal>0,round((d.bal),2),0) l4,if(d.duedys >="+level5from+" "
    					+ "and d.bal>0,round((d.bal),2),0) l5,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(10)) U6,if(d.bal>0,d.bal,0) t7 from ";
    			
    			  }
    		else if(atype.equalsIgnoreCase("AP")){
    			sqld=" and j.id > 0";
    			sqld1=" and j.id < 0";
    			
    			select ="select CONVERT(if(sum(t7)<0,round((sum(t7)*-1),2),'  '),CHAR(50)) netamount,CONVERT(if(sum(l1)<0,round((sum(l1)*-1),2),'  '),CHAR(50)) level1,"  
    					+ "CONVERT(if(sum(l2)<0,round((sum(l2)*-1),2),'  '),CHAR(50)) level2,CONVERT(if(sum(l3)<0,round((sum(l3)*-1),2),'  '),CHAR(50)) level3,"  
    					+ "CONVERT(if(sum(l4)<0,round((sum(l4)*-1),2),'  '),CHAR(50)) level4,CONVERT(if(sum(l5)<0,round((sum(l5)*-1),2),'  '),CHAR(50)) level5 from ("
    					+ "select d.acno,d.brhid,d.doc_no,if(d.duedys between "+level1from+" and "+level1to+" and d.bal<0,round((d.bal),2),0) l1,"
    					+ "if(d.duedys between "+level2from+" and "+level2to+"  and d.bal<0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+"  and "
    					+ "d.bal<0,round((d.bal),2),0) l3,if(d.duedys between "+level4from+" and "+level4to+"  and d.bal<0,round((d.bal),2),0) l4,if(d.duedys >="+level5from+"  "
    					+ "and d.bal<0,round((d.bal),2),0) l5,CONVERT(if(d.bal>0,round((d.bal),2),''),CHAR(10)) U6,if(d.bal<0,d.bal,0) t7 from ";
    		
    			select1 ="select CONVERT(if(sum(t7)>0,round((sum(t7)),2),'  '),CHAR(50)) netamount,CONVERT((if(sum(t7)>0,round((sum(t7)),2)-(if(sum(dueamt)>0,round((sum(dueamt)),2),0)),'')),CHAR(50)) dueamt,CONVERT(if(sum(l1)>0,round((sum(l1)),2),'  '),CHAR(50)) level1,"
    					+ "CONVERT(if(sum(l2)>0,round((sum(l2)),2),'  '),CHAR(50)) level2,CONVERT(if(sum(l3)>0,round((sum(l3)),2),'  '),CHAR(50)) level3,"  
    					+ "CONVERT(if(sum(l4)>0,round((sum(l4)),2),'  '),CHAR(50)) level4,CONVERT(if(sum(l5)>0,round((sum(l5)),2),'  '),CHAR(50)) level5 from ("
    					+ "select d.acno,d.brhid,d.doc_no,if(d.duedys<0 and d.bal>0,round((d.bal),2),0)  dueamt,if(d.duedys between "+level1from+" and "+level1to+" and d.bal>0,round((d.bal),2),0) l1,if(d.duedys between "
    					+ ""+level2from+" and "+level2to+" and d.bal>0,round((d.bal),2),0) l2,if(d.duedys between "+level3from+" and "+level3to+" and d.bal>0,"
    					+ "round((d.bal),2),0) l3,if(d.duedys between "+level4from+" and "+level4to+" and d.bal>0,round((d.bal),2),0) l4,if(d.duedys >="+level5from+" "
    					+ "and d.bal>0,round((d.bal),2),0) l5,CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(10)) U6,if(d.bal>0,d.bal,0) t7 from ";
           
    		}
            
            String sqlAgeing = "" ,sqlbrch="", sqlAgeingDue="",sqlDue="";
    		
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqlAgeing+=" and j.brhId="+branch+"";
    			sqlbrch=" and j.brhId="+branch+"";
    			
    		}
    		sqlAgeingDue=select1+" (select j.acno,j.brhid,h.description name,sum(dramount) - coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(coalesce(j.duedate,j.date) as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys\r\n" + 
					"from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where\r\n" + 
					"j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' and j.acno="+acno+""+sqlAgeing+""+sqld1+" group by j.tranid having bal<>0 \r\n" + 
					" union all select j.acno,j.brhid,h.description name,sum(dramount)- coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys\r\n" + 
					" from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"'\r\n" + 
					" group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' and j.acno="+acno+""+sqlAgeing+""+sqld+" group by j.tranid having bal<>0) d left join my_acbook ac on  ac.acno= d.acno and ac.status=3) ag group by acno";		
    		
    		sqlAgeing = select+" (select j.acno,j.brhid,h.description name,sum(dramount) - coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys\r\n" + 
    					"from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where\r\n" + 
    					"j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' and j.acno="+acno+""+sqlAgeing+""+sqld1+" group by j.tranid having bal<>0 \r\n" + 
    					" union all select j.acno,j.brhid,h.description name,sum(dramount)- coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys\r\n" + 
    					" from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"'\r\n" + 
    					" group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' and j.acno="+acno+""+sqlAgeing+""+sqld+" group by j.tranid having bal<>0) d) ag group by acno";	

    		System.out.println(sqlAgeingDue);
    		ResultSet resultSetSqlDue = stmtAgeingStatement.executeQuery(sqlAgeingDue);
    		
    		while(resultSetSqlDue.next()){
    			ageingStatementBean.setLbldueamount(resultSetSqlDue.getDouble("dueamt"));
    		}
    		
    		//System.out.println("ageingsummary=="+sqlAgeingDue);
    		//System.out.println("Dueamount=="+ageingStatementBean.getLbldueamount());
    		joins=commonDAO.getFinanceVocTablesJoins(conn);
    		casestatement=commonDAO.getFinanceVocTablesCase(conn);
    		
    		String sqlUnapply = "select "+casestatement+"a.date,a.transType,a.ref_detail,a.branchname,a.description,round(a.netamount,2) netamount,round(a.applied,2) applied,round(a.balance,2) balance,a.duedys,a.brhid from ("
    					+ "select j.doc_no transNo,coalesce(j.ref_detail,'') ref_detail,j.description,DATE_FORMAT((j.date),'%d-%m-%Y') date,j.dtype transType,round(sum(j.dramount)*j.id,2) netamount,round(coalesce(o.amount,0),2) applied," 
	    				+ "round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) balance,b.branchname,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys,j.brhid from my_jvtran j inner join my_head h "
	    				+ "on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.AP_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on "
	    				+ "j.tranid=o.tranid inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld+" "+sqlbrch+" group by j.tranid having balance<>0 order by j.date,j.doc_no) a"+joins+"";
					
			ResultSet resultSetUnapply = stmtAgeingStatement.executeQuery(sqlUnapply);
    		
    		while(resultSetUnapply.next()){
    			sqlUnapplyResult="1";
    		}
    		
    		if(sqlUnapplyResult.equalsIgnoreCase("0")){
    			sqlUnapply="select null date,null transno,null transType,null ref_detail,null branchname,null description,null netamount,null applied,null balance,null duedys";
    		}
    		String sqlOutStandingpal = "select @running_total:=@running_total + balance as runtot,a.* from "
    				+ "(select "+casestatement+" coalesce(invd.regno,opn.regno) regno ,coalesce(invd.claimno,opn.claimno) claimno,a.date,a.transType,a.ref_detail,a.branchname,a.description,round(a.netamount,2) netamount,round(a.applied,2) applied,round(a.balance,2) balance,a.duedys,a.brhid,coalesce(invd.vtype,opn.flname)  vehtype from ("
					+ "select j.doc_no transNo,coalesce(j.ref_detail,'') ref_detail,j.description, j.date sqldate,DATE_FORMAT((j.date),'%d-%m-%Y') date,j.dtype transType,round(sum(j.dramount)*j.id,2) netamount,round(coalesce(o.amount,0),2) applied," 
    				+ "round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) balance,b.branchname,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys,j.brhid from my_jvtran j inner join my_head h "
    				+ "on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.trANid where j.date<='"+sqlUpToDate+"' group by AP_trid) o on "
    				+ "j.tranid=o.ap_trid inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld1+" "+sqlbrch+"  group by j.tranid having balance<>0 order by j.date,j.doc_no) a"+joins+" "
					+ " left join (select invno,group_concat(invd.regno) regno,group_concat(distinct invd.claimno) claimno,group_concat(concat(brd.brand_name,' ',model.vtype)) vtype from ws_invcalctemp invd  left join ws_jobcard j on j.doc_no=invd.jobdocno left join ws_estm e on e.doc_no=j.refno and j.reftype='EST' left join ws_gateinpass g on g.doc_no=e.gipno left join gl_vehbrand brd on g.brdid=brd.doc_no left join gl_vehmodel model on g.modid=model.doc_no group by invno ) invd on invd.invno=mnt.doc_no  left join ws_opndetails opn on (a.transno=opn.rdocno and a.brhid=opn.brhid and a.transType in ('OPN')) order by a.sqldate,transNo)a,(SELECT @running_total:=0) r";
//    		System.out.println("sqlOutStandingpal==="+sqlOutStandingpal);   
    		String sqlOutStanding = "select "+casestatement+"a.date,a.transType,a.ref_detail,a.branchname,a.description,round(a.netamount,2) netamount,round(a.applied,2) applied,round(a.balance,2) balance,a.duedys,a.brhid from ("
    					+ "select j.doc_no transNo,coalesce(j.ref_detail,'') ref_detail,j.description,DATE_FORMAT((j.date),'%d-%m-%Y') date,j.dtype transType,round(sum(j.dramount)*j.id,2) netamount,round(coalesce(o.amount,0),2) applied," 
	    				+ "round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) balance,b.branchname,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys,j.brhid from my_jvtran j inner join my_head h "
	    				+ "on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.trANid where j.date<='"+sqlUpToDate+"' group by AP_trid) o on "
	    				+ "j.tranid=o.ap_trid inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld1+" "+sqlbrch+" group by j.tranid having balance<>0 order by j.date,j.doc_no) a"+joins+"";
      	//System.out.println("sqlOutStanding==="+sqlOutStanding);  
    		String sqlTotal = "select round(sum(unappliedramount),2) totalunappliedamount,round(sum(unappliedoutamount),2) totalapplied,round(sum(unappliedbalance),2) unappliedbalance,round(sum(applieddramount),2) totaloutamount,"
    				+ "round(sum(appliedoutamount),2) totaloutapplied,round(sum(appliedbalance),2) outstandingbalance,round(coalesce(sum(appliedbalance),0)-coalesce(sum(unappliedbalance),0),2) nettotal from (" +  
    				"select 0 applieddramount,0 appliedoutamount,0 appliedbalance,round(sum(j.dramount)*j.id,2) unappliedramount,"
    				+ "coalesce(o.amount,0) unappliedoutamount,round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) unappliedbalance " +
    				" from my_jvtran j inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount "
    				+ "from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"'" +
    				" group by tranid) o on j.tranid=o.tranid inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld+" "+sqlbrch+" group by j.tranid having unappliedbalance<>0 UNION ALL" +
    				" select round(sum(j.dramount)*j.id,2) applieddramount,coalesce(o.amount,0)*id appliedoutamount,round((sum(dramount) - coalesce(o.amount,0)*id)*j.id,2) appliedbalance,0 unappliedramount,0 unappliedoutamount,0 unappliedbalance from my_jvtran j" +
    				" inner join my_head h on j.acno=h.doc_no left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid) o on j.tranid=o.ap_trid " +
    				" inner join my_brch b on j.brhId=b.doc_no where j.status=3 and h.atype='"+atype+"' and j.acno="+acno+" and j.date<='"+sqlUpToDate+"'"+sqld1+" "+sqlbrch+" group by j.tranid having appliedbalance<>0) a";
    		//System.out.println("sqlTotal==="+sqlTotal);  
    		ResultSet resultSetTotal = stmtAgeingStatement.executeQuery(sqlTotal);
    		
    		while(resultSetTotal.next()){
    			ageingStatementBean.setLblsumnetamount(resultSetTotal.getString("totalunappliedamount"));
    			ageingStatementBean.setLblsumapplied(resultSetTotal.getString("totalapplied"));
    			ageingStatementBean.setLblsumbalance(resultSetTotal.getString("unappliedbalance"));
    			
    			ageingStatementBean.setLblsumoutnetamount(resultSetTotal.getString("totaloutamount"));
    			ageingStatementBean.setLblsumoutapplied(resultSetTotal.getString("totaloutapplied"));
    			ageingStatementBean.setLblsumoutbalance(resultSetTotal.getString("outstandingbalance"));
    			
    			
    			ageingStatementBean.setLblnetamount(resultSetTotal.getDouble("nettotal"));
    		}
            
    		Statement stmtinvoice11 = conn.createStatement ();
			
			String bankinfosql = "select name,beneficiary,account,ibanno,swiftcode,logo,address branchaddress from cm_bankdetails where status=3 and brhid='"+branchimg+"'";
			ResultSet resultsetbank = stmtinvoice11.executeQuery(bankinfosql);
                           // System.out.println("bankdetails==="+bankinfosql);
			while (resultsetbank.next()) {
				ageingStatementBean.setLbllogoimgpath(resultsetbank.getString("logo"));
				ageingStatementBean.setLblbankdetails(resultsetbank.getString("name"));
				ageingStatementBean.setLblbankbeneficiary(resultsetbank.getString("beneficiary"));
				ageingStatementBean.setLblbankaccountno(resultsetbank.getString("account"));
				ageingStatementBean.setLblbeneficiarybank(resultsetbank.getString("swiftcode"));
				ageingStatementBean.setLblbankibanno(resultsetbank.getString("ibanno"));
				ageingStatementBean.setLblcompbranchaddress(resultsetbank.getString("branchaddress"));
			} 
			
			stmtinvoice11.close();
    		
    		String unclearedreceiptssql = "",sqlUnclrAccountStatementResult="0";
	       	Double netunclrdebittotal=0.00;Double netunclrcredittotal=0.00;Double netunclramount=0.00;
	       	   
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
       			unclearedreceiptssql+=" and m.brhId="+branch+"";
       		}
   		
       		unclearedreceiptssql="select a.*,coalesce(round(@i:=@i+amount,2),0) netamountvalue from (SELECT m.doc_no,DATE_FORMAT((m.date),'%d-%m-%Y') date,m.dtype,m.chqno,DATE_FORMAT((m.chqdt),'%d-%m-%Y') chqdt,m.chqname,CONVERT(if(d.amount>0,round((d.amount*1),2),null),CHAR(100)) debit,"  
       		   		+ "CONVERT(if(d.amount<0,round((d.amount*-1),2),' '),CHAR(100)) credit,d.amount FROM my_unclrchqreceiptm m left join my_unclrchqreceiptd d on m.doc_no=d.rdocno where m.status=3 and m.bpvno=0 and d.acno="+acno+""+unclearedreceiptssql+") a,"
       				+ "(select @i:=0) as i";
       		
       		ResultSet resultSetUnclearAgeingStatement = stmtAgeingStatement.executeQuery(unclearedreceiptssql);
       		//System.out.println("uncleadred cheque==="+unclearedreceiptssql);
       		while(resultSetUnclearAgeingStatement.next()){
       			sqlUnclrAccountStatementResult="1";
       			netunclrdebittotal=netunclrdebittotal+resultSetUnclearAgeingStatement.getDouble("debit");
       			netunclrcredittotal=netunclrcredittotal+resultSetUnclearAgeingStatement.getDouble("credit");
       		}
       		
       		netunclramount=netunclrdebittotal-netunclrcredittotal;
       		
       		netunclrdebittotal = commonDAO.Round(netunclrdebittotal, 2);
       		netunclrcredittotal = commonDAO.Round(netunclrcredittotal, 2);
       		netunclramount = commonDAO.Round(netunclramount, 2);
       		
       		String unclearedreceiptssql2 = "",sqlUnclrAccountStatementResult2="0";
       		Double netunclrdebittotalnew=0.00;Double netunclrcredittotalnew=0.00;Double netunclramountnew=0.00;
       		
       		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
       			unclearedreceiptssql2+=" and m.brhId="+branch+"";
       		}
   		
       		unclearedreceiptssql2="select a.*,coalesce(round(@i:=@i+amount,2),0) netamountvalue from (SELECT m.doc_no,DATE_FORMAT((m.date),'%d-%m-%Y') date,"
       			+ " m.dtype,m.chqno,DATE_FORMAT((m.chqdt),'%d-%m-%Y') chqdt,m.chqname,CONVERT(if(d.amount>0,round((d.amount*1),2),null),CHAR(100)) debit,"
       			+" CONVERT(if(d.amount<0,round((d.amount*-1),2),0.00),CHAR(100)) credit,d.amount FROM my_chqbm m "
				+" left join my_chqbd d on (m.tr_no=d.tr_no and m.brhid=d.brhid) left join my_chqdet d1 on m.tr_no=d1.tr_no "
				+" where d1.pdc=1 and d1.status='E' and  m.status=3  and d.acno = "+acno+" "+unclearedreceiptssql2+" ) a, (select @i:=0) as i order by date,doc_no ";
   		 //System.out.println("===sqllaaa=="+unclearedreceiptssql2);
       		ResultSet resultSetUnclearAccountStatement = stmtAgeingStatement.executeQuery(unclearedreceiptssql2);
       		
       		while(resultSetUnclearAccountStatement.next()){
       			sqlUnclrAccountStatementResult2="1";
       			netunclrdebittotalnew=netunclrdebittotalnew+resultSetUnclearAccountStatement.getDouble("debit");
       			netunclrcredittotalnew=netunclrcredittotalnew+resultSetUnclearAccountStatement.getDouble("credit");
       		}
       		
       		netunclramountnew=netunclrdebittotalnew-netunclrcredittotalnew;

       		netunclrdebittotalnew = commonDAO.Round(netunclrdebittotalnew, 2);
       		netunclrcredittotalnew = commonDAO.Round(netunclrcredittotalnew, 2);
       		netunclramountnew = commonDAO.Round(netunclramountnew, 2);
       		
       	    param.put("ageingstatementoutstandingsqlpal", sqlOutStandingpal);   
            param.put("imgpath", imgpath);
            param.put("imgpathfooter",imgpathfooter);
            param.put("compname", ageingStatementBean.getLblcompname());
            param.put("compaddress", ageingStatementBean.getLblcompaddress());
            param.put("comptel", ageingStatementBean.getLblcomptel());
            param.put("compfax", ageingStatementBean.getLblcompfax());
            param.put("compbranch", ageingStatementBean.getLblbranch());
            param.put("location", ageingStatementBean.getLbllocation());
            param.put("printname", ageingStatementBean.getLblprintname());
            param.put("subprintname", ageingStatementBean.getLblprintname1());
            param.put("header", header);
            //param.put("bankname", ageingStatementBean.getLblbankdetails());
            //param.put("IBAN", ageingStatementBean.getLblbankibanno());
            //param.put("branchSwift", ageingStatementBean.getLblbeneficiarybank());
            //param.put("currentaccount", ageingStatementBean.getLblbankaccountno());
            //param.put("bankaddress", ageingStatementBean.getLblcompbranchaddress());
            param.put("branchname", branch);
            
            //Bank details=====
            param.put("bankname",ageingStatementBean.getLblbankdetails());
            param.put("bankAcNo", ageingStatementBean.getLblbankbeneficiary());
            param.put("currentaccount",ageingStatementBean.getLblbankaccountno());
			param.put("IBAN", ageingStatementBean.getLblbankibanno());
			param.put("branchSwift",ageingStatementBean.getLblbeneficiarybank());
			param.put("bankaddress", ageingStatementBean.getLblcompbranchaddress());
            
            // System.out.println("branch==="+branch);
            if(reportFileName.contains("ageingStatementAlfahimPrint.jrxml")){
            	param.put("account", ageingStatementBean.getLblaccountno()+" - "+ageingStatementBean.getLblaccountname());
            } else if(reportFileName.contains("ageingStatementPrintGreenstar.jrxml")) {
            	param.put("account", ageingStatementBean.getLblaccountname()+" - "+ageingStatementBean.getLblaccountaddress());
            }
            else {
            	param.put("account", ageingStatementBean.getLblaccountname()+" - "+ageingStatementBean.getLblaccountaddress()+" - "+ageingStatementBean.getLblaccountmobileno());            	
            }
            param.put("accountno", ageingStatementBean.getLblaccountno());  
            param.put("customername", ageingStatementBean.getLblaccountname());
            param.put("customeraddress", ageingStatementBean.getLblaccountaddress());
            param.put("customeremail", ageingStatementBean.getLblaccountemail());
            param.put("customermobile", ageingStatementBean.getLblaccountmobileno());
            param.put("customerphone", ageingStatementBean.getLblaccountphone());
            param.put("customerfax", ageingStatementBean.getLblaccountfax());
            //param.put("creditperiod", ageingStatementBean.getLblcreditperiodmin()+" (Days)");
            param.put("creditperiod", ageingStatementBean.getLblcreditperiodmax()+" (Days)");
	        param.put("creditlimit", ageingStatementBean.getLblcreditlimit());
	        
	        param.put("currency", ageingStatementBean.getLblcurrencycode());
	        param.put("ageingstatementunapplysql", sqlUnapply);
	        param.put("unappliedtotalamount", ageingStatementBean.getLblsumnetamount());
	        param.put("unappliedtotalapplied", ageingStatementBean.getLblsumapplied());
	        param.put("unappliedtotalbalance", ageingStatementBean.getLblsumbalance());
	        param.put("ageingstatementoutstandingsql", sqlOutStanding);
	        param.put("outstandingtotalamount", ageingStatementBean.getLblsumoutnetamount());
	        param.put("outstandingtotalapplied", ageingStatementBean.getLblsumoutapplied());
	        param.put("outstandingtotalbalance", ageingStatementBean.getLblsumoutbalance());
	        param.put("ageingstatementsummarysql", sqlAgeing);
	        param.put("ageingstatementsummarysqlDue", sqlAgeingDue);
	        param.put("level1", level1from+" - "+level1to);
	        param.put("level2", level2from+" - "+level2to);
	        param.put("level3", level3from+" - "+level3to);
	        param.put("level4", level4from+" - "+level4to);
	        param.put("level5", ">="+level5from+" days");
	        param.put("unclearedreceiptssql", unclearedreceiptssql);
	        param.put("unclearedreceiptssqlnew",unclearedreceiptssql2);
		    param.put("unclearedreceiptscheck", sqlUnclrAccountStatementResult);
		    param.put("unclrdebittotal", String.valueOf(netunclrdebittotal));
		    param.put("unclrcredittotal", String.valueOf(netunclrcredittotal));
		    param.put("unclrnettotal", String.valueOf(netunclramount));
	        param.put("nettotalamount", ageingStatementBean.getLblnetamount());
	        param.put("printby", session.getAttribute("USERNAME"));
	        param.put("debit", netunclrdebittotalnew);
	        param.put("credit", netunclrcredittotalnew);
	        param.put("nettotal", netunclramountnew);
	        param.put("dueamount", ageingStatementBean.getLbldueamount());
	        
	        
//		    System.out.println(imgpal+"==imgpal==reportFileName=="+reportFileName);      
		    
	        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));
  	        JasperReport jasperReport = JasperCompileManager.compileReport(design);
           // generateReportPDF(response, param, jasperReport, conn, email, print, String.valueOf(acno));
          //generateReportPDFaudit(response, param, jasperReport, conn);
			
        	  //generateReportPDF(response, param, jasperReport, conn);
        	      //System.out.println("before xl");
        	   	 if(xlstat.equalsIgnoreCase("1"))
        	   	 { 
        	    //System.out.println("Creating JasperPrint Object For Excel");
        	   	//System.out.println("xlstat=="+xlstat);
        	    JasperPrint jasperPrint = JasperFillManager.fillReport (jasperReport,param,conn); 
        	    byte bytes[] = new byte[20000]; 
        	    //String result = JasperRunManager.runReportToHtmlFile("./usertemplates/test.jasper" , parameters, conn); 
        		
        		JRXlsExporter exporter = new JRXlsExporter(); 
        	    ByteArrayOutputStream xlsReport = new ByteArrayOutputStream(); 
        	    
        	    
        	    exporter.setParameter(JRXlsExporterParameter.JASPER_PRINT, jasperPrint);
        	    exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND,Boolean.TRUE);
        	    exporter.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE); 
        	    exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,Boolean.TRUE);
        	    exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS,Boolean.TRUE);
        	    exporter.setParameter(JRXlsExporterParameter.IS_COLLAPSE_ROW_SPAN,Boolean.TRUE);
        	    exporter.setParameter(JRXlsExporterParameter.IGNORE_PAGE_MARGINS,Boolean.TRUE);
        	    exporter.setParameter(JRXlsExporterParameter.OUTPUT_STREAM, xlsReport); 
        	    exporter.setParameter(JRXlsExporterParameter.MAXIMUM_ROWS_PER_SHEET,30000);
        	    exporter.setParameter(JRXlsExporterParameter.IS_IMAGE_BORDER_FIX_ENABLED, Boolean.TRUE);
        	    exporter.setParameter(JRXlsExporterParameter.IS_IGNORE_GRAPHICS, Boolean.FALSE);
        	    exporter.exportReport(); 
        	   
        	    
        	    String fileName = "InvoiceReport.xls";
        	    response.setHeader("Content-Disposition", "inline; filename="+ fileName);
        	    response.setContentType("application/vnd.ms-excel"); 
        	    //System.out.println("After JasperPrint = 1"); 
        	    response.setContentLength(xlsReport.size()); 
        	    //System.out.println("After JasperPrint = 2"); 
        	    xlsReport.close(); 
        	    //System.out.println("After JasperPrint = 3"); 
               OutputStream outputStream = response.getOutputStream(); 
        	    //System.out.println("After JasperPrint = 4"); 
        	    xlsReport.writeTo(outputStream); 
        	    outputStream.flush(); 
        	    //outputStream.close(); 
        	    //System.out.println("export end");
        	   	 }
        	   else
      {
        		   generateReportPDF(response, param, jasperReport, conn, email, print, String.valueOf(acno));
      	}  
            
            stmtAgeingStatement.close();
            
		} catch (Exception e) {
            e.printStackTrace();
            conn.close();
    	} finally{
    		conn.close();
    	}
	}
	
	public void printAction1() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session=request.getSession();
	    Connection conn = null;
        java.sql.Date sqlUpToDate = null;
        
		try {
			conn = connDAO.getMyConnection();
	        Statement stmtAgeingStatement =conn.createStatement();
	        param = new HashMap();
	        String atype = request.getParameter("atype");
	        //System.out.println("Before xl");
	       
			int acno=Integer.parseInt(request.getParameter("acno"));
			int level1from=Integer.parseInt(request.getParameter("level1from"));
			int level1to=Integer.parseInt(request.getParameter("level1to"));
			int level2from=Integer.parseInt(request.getParameter("level2from"));
			int level2to=Integer.parseInt(request.getParameter("level2to"));
			int level3from=Integer.parseInt(request.getParameter("level3from"));
			int level3to=Integer.parseInt(request.getParameter("level3to"));
			int level4from=Integer.parseInt(request.getParameter("level4from"));
			int level4to=Integer.parseInt(request.getParameter("level4to"));
			int level5from=Integer.parseInt(request.getParameter("level5from"));
			String balance=request.getParameter("balance")==null?"0.0":request.getParameter("balance")==""?"0.0":request.getParameter("balance").toString(); 
      	    String branch = request.getParameter("branch");
			String uptoDate = request.getParameter("uptoDate");
			
			ClsAmountToWords amt=new ClsAmountToWords();
		//	System.out.println("bale======="+balance);
			String amtwrds=amt.convertAmountToWords(balance);
		//	System.out.println("amt+======="+amtwrds);
			if(!(uptoDate.equalsIgnoreCase("undefined")) && !(uptoDate.equalsIgnoreCase("")) && !(uptoDate.equalsIgnoreCase("0"))){
				sqlUpToDate = commonDAO.changeStringtoSqlDate(uptoDate);
            }
			
			ageingStatementBean=ageingStatementDAO.getPrint(request,atype,acno,branch,uptoDate,level1from,level1to,level2from,level2to,level3from,level3to,level4from,level4to,level5from);
						
			String reportFileName = "com/dashboard/accounts/ageingstatement/auditletter.jrxml";
			
			
		//	System.out.println("===========reportFileName======="+reportFileName);
			
            String imgpath=request.getSession().getServletContext().getRealPath("/icons/compheader.jpg");
            imgpath=imgpath.replace("\\", "\\\\");
            
            String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/compfooter.jpg");
            imgpathfooter=imgpathfooter.replace("\\", "\\\\");
            
         
            param.put("imgpath", imgpath);
            param.put("imgpathfooter",imgpathfooter);
            param.put("compname", ageingStatementBean.getLblcompname());
            param.put("address", ageingStatementBean.getLblaccountaddress());
            param.put("customermobile", ageingStatementBean.getLblaccountmobileno());
            param.put("customertel", ageingStatementBean.getLblaccountphone());
            param.put("customerfax", ageingStatementBean.getLblaccountfax());
            param.put("uptodate", uptoDate);
            param.put("clientname",ageingStatementBean.getLblaccountname());
            param.put("amount", balance);
            param.put("amtinwrds",amtwrds);
            
            
            
//            System.out.println("ageing"+ageingStatementBean.getLblaccountaddress()+":"+ageingStatementBean.getLblaccountemail()+":"+ageingStatementBean.getLblaccountmobileno()+":"+ageingStatementBean.getLblaccountphone()+":"+ageingStatementBean.getLblaccountfax()+":"+ageingStatementBean.getLblnetamount());
            
	        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(reportFileName));
  	        JasperReport jasperReport = JasperCompileManager.compileReport(design);
  	      
            stmtAgeingStatement.close();
            
		} catch (Exception e) {
            e.printStackTrace();
            conn.close();
    	} finally{
    		conn.close();
    	}
	}
	
	private void generateReportPDFaudit (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {
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
	
	 private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn, String email, String print, String acno)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {
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
       	
        	 Statement stmtAgeingStatement1 =conn.createStatement();
       	  
        	 String fileName="",path="", formcode="BAGE",filepath=""; 
        	 
        	 String strSql1 = "select imgPath from my_comp";
        	 ResultSet rs1 = stmtAgeingStatement1.executeQuery(strSql1);
     		
        	 while(rs1.next ()) {
     			path=rs1.getString("imgPath");
     		}

     		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
   		    java.util.Date date = new java.util.Date();
   		    String currdate=dateFormat.format(date);
   		
     		fileName = "AgeingStatement["+ageingStatementBean.getLblaccountname()+"]"+currdate+".pdf";
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
			sendmail.SendTomail( saveFile,formcode,email,acno,session.getAttribute("BRANCHID").toString().trim(),session.getAttribute("USERID").toString().trim(),ageingStatementBean.getLblaccountname());
			
         }
              
     }
}