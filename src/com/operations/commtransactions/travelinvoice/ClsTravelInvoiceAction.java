package com.operations.commtransactions.travelinvoice;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.math.BigDecimal;
import java.sql.Connection;
import java.util.Date;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;   
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.common.*;
import com.connection.ClsConnection;
import com.mailwithpdf.EmailProcess;
import com.mailwithpdf.SendEmailAction;
import com.sun.xml.internal.messaging.saaj.packaging.mime.MessagingException;

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

import com.opensymphony.xwork2.ActionSupport;
import com.operations.agreement.rentalagreement.ClsRentalAgreementDAO;


@SuppressWarnings("serial")
public class ClsTravelInvoiceAction extends ActionSupport{
	ClsTravelInvoiceDAO InvoiceDAO= new ClsTravelInvoiceDAO();      
	ClsTravelInvoiceBean pintbean= new ClsTravelInvoiceBean(); 
	ClsCommon cmn=new ClsCommon();
	ClsConnection connDAO=new ClsConnection();
	private int docno,tourgridlenght,masterdoc_no;  
	private String branch,travelDate,hidtravelDate,cmbreftype,refno,cmbclient,txtclientname,txttype,txtremarks;
	public String getBranch() {        
		return branch;
	}
	public void setBranch(String branch) {
		this.branch = branch;
	}
	private String msg,mode,formdetailcode,deleted,hidreftype,hidtype;
	public String getHidreftype() {
		return hidreftype;
	}
	public void setHidreftype(String hidreftype) {
		this.hidreftype = hidreftype;
	}
	public String getHidtype() {
		return hidtype;
	}
	public void setHidtype(String hidtype) {
		this.hidtype = hidtype;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public int getTourgridlenght() {
		return tourgridlenght;
	}
	public void setTourgridlenght(int tourgridlenght) {
		this.tourgridlenght = tourgridlenght;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public String getTravelDate() {
		return travelDate;
	}
	public void setTravelDate(String travelDate) {
		this.travelDate = travelDate;
	}
	public String getHidtravelDate() {
		return hidtravelDate;
	}
	public void setHidtravelDate(String hidtravelDate) {
		this.hidtravelDate = hidtravelDate;
	}
	public String getCmbreftype() {
		return cmbreftype;
	}
	public void setCmbreftype(String cmbreftype) {
		this.cmbreftype = cmbreftype;
	}
	public String getRefno() {
		return refno;
	}
	public void setRefno(String refno) {
		this.refno = refno;
	}
	public String getCmbclient() {
		return cmbclient;
	}
	public void setCmbclient(String cmbclient) {
		this.cmbclient = cmbclient;
	}
	public String getTxtclientname() {
		return txtclientname;
	}
	public void setTxtclientname(String txtclientname) {
		this.txtclientname = txtclientname;
	}
	public String getTxttype() {
		return txttype;
	}
	public void setTxttype(String txttype) {
		this.txttype = txttype;
	}
	public String getTxtremarks() {
		return txtremarks;
	}
	public void setTxtremarks(String txtremarks) {
		this.txtremarks = txtremarks;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
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
	private Map<String, Object> param=null;  
	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		java.sql.Date sqlStartDate = cmn.changeStringtoSqlDate(getTravelDate());   
		String mode=getMode();

		if(mode.equalsIgnoreCase("A")){
			ArrayList<String> accarray= new ArrayList<>();
			/*for(int i=0;i<getEnqgridlenght();i++){
				String temp2=requestParams.get("enqtest"+i)[0];       
			// String temp2=request.getAttribute("enqtest"+i).toString();                         
			   enqarray.add(temp2);
			}*/    
			int val=InvoiceDAO.insert(sqlStartDate,getCmbreftype(),getRefno(),getCmbclient(),getTxtclientname(),getTxttype(),getTxtremarks(),accarray,session,getMode(),getFormdetailcode(),getBranch(),request);            
			int vdocno=(int) request.getAttribute("vocno");
			if(val>0){
				setHidtravelDate(sqlStartDate.toString());   
				setCmbclient(getCmbclient());
				setHidreftype(getCmbreftype());  
				setTxtclientname(getTxtclientname());
				setCmbreftype(getCmbreftype());  
				setRefno(getRefno());
				setTxttype(getTxttype());
				setHidtype(getTxttype());
				setTxtremarks(getTxtremarks());
				setDocno(vdocno);   
				setMasterdoc_no(val);
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setHidtravelDate(sqlStartDate.toString()); 
				setHidtype(getTxttype());
				setHidreftype(getCmbreftype());  
				setCmbclient(getCmbclient());
				setTxtclientname(getTxtclientname());
				setCmbreftype(getCmbreftype());  
				setRefno(getRefno());
				setTxttype(getTxttype());
				setTxtremarks(getTxtremarks());
				setDocno(vdocno);   
				setMasterdoc_no(val);
				setMsg("Not Saved");
				return "fail";
			}
		} else if(mode.equalsIgnoreCase("D")){
			int Status=InvoiceDAO.delete(getMasterdoc_no(),getTxttype(),session,getFormdetailcode(),getBranch(),request);   
			if(Status>0){  
						setCmbclient("");
						setHidreftype("");  
						setTxtclientname("");
						setCmbreftype("");  
						setRefno("");
						setTxttype("");
						setHidtype("");
						setTxtremarks("");
						setDocno(0);   
						setMasterdoc_no(0);   
						setDeleted("DELETED");
						setMsg("Successfully Deleted");     
						return "success";
			}else{
				setMsg("Not Deleted");
				return "fail";
			}
			}else if(mode.equalsIgnoreCase("view")){  
			    setHidtravelDate(sqlStartDate.toString());
		}
	return "fail";	
	}
	
	public String printAction() throws ParseException, SQLException{     
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String docno=request.getParameter("docno");  
		String type=request.getParameter("type")==null ?"":request.getParameter("type");        
		System.out.println("IN action=="+type);
		String branch=request.getParameter("branch");
		String email="",telno="",address="",client="",guest="",receiptno="",trnno="",date="",subtotal="0",vattot="0",total="0",aedamt="";      
		String imgpath="",comp="",tel="",fax="",brch="",location="",cmpname="",printedby="",vocno="0",mainsql="",trnnumber="";      
		Double subtotal2=0.0,vattot2=0.0,total2=0.0,aedamt2=0.0;  
		ResultSet rs=null,rss=null;      
	    HttpServletResponse response = ServletActionContext.getResponse();     
	    java.sql.Date sqlfromdate = null;
	    java.sql.Date sqltodate = null;   
			 param = new HashMap();      
				Connection conn = null;
				Statement stmt =null;
			 try {	
				    conn = connDAO.getMyConnection();      
					stmt=conn.createStatement();
					ClsAmountToWords objamt=new com.common.ClsAmountToWords();
					String sql123="select USER_NAME from my_user where doc_no="+session.getAttribute("USERID").toString()+"";   
					//System.out.println("print main--->>>"+sql123); 
					ResultSet rs123 = stmt.executeQuery(sql123);    
					while(rs123.next()){
						printedby=rs123.getString("USER_NAME");   
					}
					String sql="select c.imgpath,b.branchname,c.company,c.tel,c.fax,l.loc_name location from my_brch b left join my_locm l on l.brhid=b.doc_no left join my_comp c on "
							+ "b.cmpid=c.doc_no where b.doc_no="+branch+" group by brhid";   
					//System.out.println("print main--->>>"+sql); 
					ResultSet resultSet = stmt.executeQuery(sql);    
					while(resultSet.next()){
						comp=resultSet.getString("company");
						tel=resultSet.getString("tel");
						fax=resultSet.getString("fax");
						brch=resultSet.getString("branchname");
						location=resultSet.getString("location");             
					}
					String strsql="";
					if(type.equalsIgnoreCase("")){
						ResultSet rstype=stmt.executeQuery("select types tourtype from tr_invoicem where doc_no="+docno);
						while(rstype.next()){
							type=rstype.getString("tourtype");
						}
					}
					if(type.equalsIgnoreCase("ticket")){
						strsql="select m.voc_no,date_format(m.date,'%d/%m/%Y') date,ac.refname,ac.per_tel telno,ac.address,ac.mail1,coalesce(ac.trnnumber,'') tinno,b.tinno trnnumber,round(sum(coalesce(t.sprice,0)),2) sprice from tr_invoicem m left join ti_ticketvoucherd t on (t.invtrno=m.doc_no and m.types='ticket') left join my_acbook ac on (ac.cldocno=t.cldocno and ac.dtype='crm') left join my_brch b on b.doc_no=m.brhid where m.doc_no='"+docno+"' group by m.doc_no";	
						System.out.println("print ticket--->>>"+strsql);                                   
					    rs=stmt.executeQuery(strsql); 	
					}else if(type.equalsIgnoreCase("hotel")){      
						strsql="select m.voc_no,date_format(m.date,'%d/%m/%Y') date,ac.refname,ac.per_tel telno,ac.address,ac.mail1,coalesce(ac.trnnumber,'') tinno,b.tinno trnnumber,coalesce(t.clvatamt,0) vattot,coalesce(t.sprice,0) sprice,if(inclusive=0,coalesce(t.suptotal,0) + coalesce(t.servfee,0) + coalesce(t.paybackamt,0),coalesce(t.sprice,0)-coalesce(t.clvatamt,0)) subtotal from tr_invoicem m left join ti_hotelvoucherd t on (t.invtrno=m.doc_no and m.types='hotel') left join my_acbook ac on (ac.cldocno=t.cldocno and ac.dtype='crm') left join my_brch b on b.doc_no=m.brhid where m.doc_no='"+docno+"'";	
						System.out.println("print hotel--->>>"+strsql);                                     
					    rs=stmt.executeQuery(strsql); 
					}else if(type.equalsIgnoreCase("tour")){      
						strsql="select m.voc_no,date_format(m.date,'%d/%m/%Y') date,coalesce(t.refname,ac.refname) refname,coalesce(t.mob,ac.per_tel)  telno,coalesce(ac.address,'') address,coalesce(t.mail,ac.mail1) mail1,coalesce(ac.trnnumber,'') tinno,b.tinno trnnumber,round(sum(coalesce(d.total,0)),2) sprice from tr_invoicem m left join tr_servicereqm t on (t.invtrno=m.doc_no and m.types='tour')  left join tr_srtour d on (d.rdocno=t.doc_no) left join my_acbook ac on (ac.cldocno=t.cldocno and ac.dtype='crm') left join my_brch b on b.doc_no=m.brhid where m.doc_no='"+docno+"' group by m.doc_no";	
						System.out.println("print tour--->>>"+strsql);                                     
					    rs=stmt.executeQuery(strsql);    
					}else{}
				    while(rs.next()){    
				    	client=rs.getString("refname");     
				    	vocno=rs.getString("voc_no");
				    	trnno=rs.getString("tinno");
                        date=rs.getString("date");
                        email=rs.getString("mail1");
                        telno=rs.getString("telno");
                        address=rs.getString("address");
                        trnnumber=rs.getString("trnnumber");    
                        if(type.equalsIgnoreCase("ticket") || type.equalsIgnoreCase("tour")){
                            vattot="0.00";
                            subtotal=rs.getString("sprice");
                            aedamt=rs.getString("sprice");
                            total=rs.getString("sprice");      
                        }else if(type.equalsIgnoreCase("hotel")){
                        	vattot2=vattot2 + rs.getDouble("vattot");
                        	subtotal2=subtotal2 + rs.getDouble("subtotal");    
                            aedamt2=aedamt2 + rs.getDouble("sprice");
                            total2=total2 + rs.getDouble("sprice");        
                        }else{}  
                        System.out.println("in loop");
				    }
				    if(type.equalsIgnoreCase("hotel")){
				    	 vattot=vattot2+"";
                         subtotal=subtotal2+"";
                         aedamt=aedamt2+"";
                         total=total2+"";    
				    }
				    String aedamtdesc=objamt.convertAmountToWords(aedamt); 
				    if(type.equalsIgnoreCase("ticket")){
				    	 mainsql="select @i:=@i+1 slno,a.* from(select d.guest name,concat(d.ticketno,' ','Issue Date- ',date_format(d.issuedate,'%d/%m/%Y')) serdet,'Total' partname,round(coalesce(d.sprice,''),2) amount from tr_invoicem m left join ti_ticketvoucherd d on d.invtrno=m.doc_no where m.doc_no='"+docno+"')a,(select @i:=0)c";
				    }else if(type.equalsIgnoreCase("hotel")){        
				    	 mainsql="select @i:=@i+1 slno,a.* from(select d.guest name,if(d.vtype='H',concat(hl.name,' - ',d.roomtype),concat(d.suppconfno,' ','Issue Date- ',date_format(d.issuedate,'%d/%m/%Y'))) serdet,'Total' partname,round(coalesce(d.sprice,''),2) amount from tr_invoicem m left join ti_hotelvoucherd d on d.invtrno=m.doc_no left join tr_hotel hl on d.hotelid=hl.doc_no where m.doc_no='"+docno+"')a,(select @i:=0)c";
				    }else if(type.equalsIgnoreCase("tour")){          
				    	 mainsql="select @i:=@i+1 slno,a.* from(select concat(s.name,' - ',ac.refname) name,concat('Adult -',round(d.adult,0),', Child -',round(d.child,0),', Infant -',round(d.infant,0)) serdet,'Total' partname,round(coalesce(d.total,''),2) amount from tr_invoicem m left join tr_servicereqm t on (t.invtrno=m.doc_no and m.types='tour') left join tr_srtour d on (d.rdocno=t.doc_no) left join tr_tours s on s.doc_no=d.tourid left join my_acbook ac on (ac.cldocno=d.vendorid and ac.dtype='vnd') where m.doc_no='"+docno+"')a,(select @i:=0)c";
					}else{}                 
				    //System.out.println("tourid==="+tourid); 
				    imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");     
			        imgpath=imgpath.replace("\\", "\\\\");      
			        //String user=session.getAttribute("USERNAME").toString();
			       // System.out.println("in...."+user);
			        param.put("img",imgpath);
			        param.put("comp",comp);   
			        param.put("tel",tel);
			        param.put("fax",fax);
			        param.put("brch",brch);
			        param.put("printedby",printedby);
			        param.put("location",location);
			        param.put("customer",client);  
			        param.put("email",email);  
			        param.put("vregno",trnno);   
			        param.put("trnnumber",trnnumber);   
			        param.put("invdate",date);  
			        param.put("invno",vocno);                 
			        param.put("address",address); 
			        param.put("telno",telno);        
			        param.put("sqlstr",mainsql);    
			        param.put("subtotal",subtotal);
			        param.put("total",total);
			        param.put("aedamt",aedamt);
			        param.put("vattot",vattot);
			        param.put("aedamtdesc",aedamtdesc);  
			        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/operations/commtransactions/travelinvoice/travelinvoice.jrxml"));  
  	                JasperReport jasperReport = JasperCompileManager.compileReport(design);   
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
