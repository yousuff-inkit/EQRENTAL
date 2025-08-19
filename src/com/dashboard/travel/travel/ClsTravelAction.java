package com.dashboard.travel.travel;

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

public class ClsTravelAction {
	ClsCommon cmn=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();  
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
	
	public String printAction() throws ParseException, SQLException{     
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String docno=request.getParameter("docno");  
		//System.out.println("IN action=="+docno);
		String branch=request.getParameter("branch");
		String refdate="",telno="",address="",client="",guest="",receiptno="",trnno="",date="",amount="",cardno="",gstphno="",bookedby="",bphno="",bookrefno="",tourid=""; 
		String imgpath="",comp="",tel="",fax="",brch="",location="",cmpname="",dloc="",ploc="",loctype="",refno="",rname="",printedby="",refon="",vocno="0";      
		ResultSet rs=null,rss=null;      
	    HttpServletResponse response = ServletActionContext.getResponse();
	    java.sql.Date sqlfromdate = null;
	    java.sql.Date sqltodate = null;   
			 param = new HashMap();    
				Connection conn = null;
				Statement stmt =null;
			 try {	
				    conn = ClsConnection.getMyConnection();    
					stmt=conn.createStatement();
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
						//location=resultSet.getString("location");         
					}
					String strsql="select inv.voc_no,if(tr.loctype='F','Flight No',if(tr.loctype='H','Room No','')) refon,round(g.amount,2) amount,g.aggno,g.srno,g.receiptno,g.cardno,date_format(g.date,'%d-%m-%Y') refdate,if(tr.loctype='F','Flight',if(tr.loctype='H','Hotel','')) loctype,tr.rname,tr.refno,coalesce(gl.location,'') ploc,coalesce(gls.location,'') dloc,coalesce(tr.tourid,0) tourid,ser.refname,coalesce(ac.trnnumber,'') trnnumber,"
							+ " ser.voc_no bookrefno,coalesce(lg.guest,ser.refname) guest,coalesce(lg.guestcontactno,ser.mob) gstphno,u.user_name bookedby,date_format(ser.date,'%d-%m-%Y') date,ac.address,ac.per_mob telno,lm.loc_name location from tr_srtour tr left join gl_cordinates gl on gl.doc_no=tr.plocid left join gl_cordinates gls on gls.doc_no=tr.dlocid "
							+ " left join tr_servicereqm ser on ser.doc_no=tr.rdocno left join tr_invoicem inv on (inv.doc_no=ser.invtrno and inv.types='tour')  left join my_locm lm on lm.doc_no=ser.locid left join my_acbook ac on ac.doc_no=ser.cldocno and ac.dtype='crm' "
							+ " left join (select coalesce(round(sum(amount),2),0) amount,aggno,srno,group_concat(srno) receiptno,coalesce(group_concat(refno),'') cardno,max(date) date,rtype  from gl_rentreceipt group by aggno) g on g.aggno=tr.rdocno and g.rtype='Service Request' left join gl_limobookm l on l.doc_no=ser.limodocno "
							+ " left join gl_limoguest lg on lg.doc_no=l.guestno left join my_user u on u.doc_no=l.userid or u.doc_no=ser.userid where tr.rdocno='"+docno+"'";	
					System.out.println("print query1--->>>"+strsql);                          
				    rs=stmt.executeQuery(strsql);      
				    while(rs.next()){ 
				    	tourid+=rs.getString("tourid")+",";   
				    	client=rs.getString("refname");
				    	receiptno=rs.getString("receiptno");
				    	trnno=rs.getString("trnnumber");
                        date=rs.getString("date");
                        amount=rs.getString("amount");
                        cardno=rs.getString("cardno");
                        bookrefno=rs.getString("bookrefno");    
                        guest=rs.getString("guest");
                        gstphno=rs.getString("gstphno");
                        bookedby=rs.getString("bookedby");  
                        telno=rs.getString("telno");
                        address=rs.getString("address");
                        refdate=rs.getString("refdate");  
                        loctype=rs.getString("loctype");
                        rname=rs.getString("rname");
                        refno=rs.getString("refno");
                        ploc=rs.getString("ploc");
                        dloc=rs.getString("dloc");
                        refon=rs.getString("refon");
                        location=rs.getString("location"); 
                        vocno=rs.getString("voc_no");                        
				    }
				    tourid+="0";   
				    //System.out.println("tourid==="+tourid); 
				    imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
			        imgpath=imgpath.replace("\\", "\\\\");      
			        //String user=session.getAttribute("USERNAME").toString();
			       // System.out.println("in...."+user);
			        param.put("img",imgpath); 
			        param.put("printedby",printedby);          
			        param.put("comp",comp);   
			        param.put("tel",tel);
			        param.put("fax",fax);
			        param.put("brch",brch);
			        param.put("location",location);
			        param.put("rdocno",docno);   
			        param.put("client",client);  
			        param.put("guest",guest);  
			        param.put("receiptno",receiptno);  
			        param.put("trnno",trnno);  
			        param.put("date",date);  
			        param.put("amount",amount);  
			        param.put("cardno",cardno);  
			        param.put("bookrefno",bookrefno);  
			        param.put("gstphno",gstphno);  
			        param.put("bookedby",bookedby);     
			        param.put("bphno",bphno);   
			        param.put("tourid",tourid);  
			        param.put("refdate",refdate);      
			        param.put("serdocno",vocno);                 
			        param.put("address",address); 
			        param.put("telno",telno); 
			        param.put("pickuploc",ploc); 
			        param.put("dropoffloc",dloc); 
			        param.put("reftype",rname); 
			        param.put("refno",refno);
			        param.put("refon",refon); 
			        param.put("loctype",loctype);       
			        
			        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/travel/travel/voucherreciept.jrxml"));  
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
	public String printActionXO() throws ParseException, SQLException{        
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String docno=request.getParameter("docno");  
		System.out.println("IN action=="+docno);
		String branch=request.getParameter("branch");
		String printname="",remarks="",client="",guest="",receiptno="",trnno="",date="",amount="",cardno="",gstphno="",bookedby="",bphno="",bookrefno="",tourid="",printedby=""; 
		String imgpath="",comp="",tel="",fax="",brch="",location="",cmpname="",dloc="",ploc="",loctype="",refno="",rname="",refon="",vocno="0";  
		ResultSet rss=null; 
		int conmeth=0;
	    HttpServletResponse response = ServletActionContext.getResponse();
	    java.sql.Date sqlfromdate = null;   
	    java.sql.Date sqltodate = null;   
			 param = new HashMap();    
				Connection conn = null;
				Statement stmt =null;
			 try {	
				    conn = ClsConnection.getMyConnection();    
					stmt=conn.createStatement();
					String sql123="select USER_NAME from my_user where doc_no="+session.getAttribute("USERID").toString()+"";   
					//System.out.println("print main--->>>"+sql123); 
					ResultSet rs123 = stmt.executeQuery(sql123);    
					while(rs123.next()){
						printedby=rs123.getString("USER_NAME");   
					}
					String sql555="select coalesce(method,0) method  from gl_config where field_nme='lammo tourism'";   
					//System.out.println("print main--->>>"+sql123); 
					ResultSet rs555 = stmt.executeQuery(sql555);    
					while(rs555.next()){
						conmeth=rs555.getInt("method");          
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
						   
					}
					int i=0;
					String strsql="select coalesce(ac.cldocno,0) cldocno from tr_srtour tr left join my_acbook ac on ac.doc_no=tr.vendorid and ac.dtype='vnd'  where tr.rdocno='"+docno+"' group by tr.vendorid";     
					System.out.println("print query1--->>>"+strsql);                  
					ResultSet resultSet1=stmt.executeQuery(strsql);      
				    while(resultSet1.next()){                       
				     client=resultSet1.getString("cldocno");
				     param.put("vendor"+i+"",client);
				     i++;           
				    } 
				    String strsql4="select group_concat(remarks) remarks from tr_srtour where rdocno='"+docno+"';";     
					System.out.println("print query1--->>>"+strsql4);                     
					ResultSet resultSet14=stmt.executeQuery(strsql4);      
				    while(resultSet14.next()){                       
				    	remarks=resultSet14.getString("remarks");
				    }
				    String strsqls="select ser.voc_no,if(tr.loctype='F','Flight No',if(tr.loctype='H','Room No','')) refon,if(tr.loctype='F','Flight',if(tr.loctype='H','Hotel','')) loctype,tr.rname,tr.refno,coalesce(gl.location,'') ploc,coalesce(gls.location,'') dloc,coalesce(tr.tourid,0) tourid,ser.refname,coalesce(ac.trnnumber,'') trnnumber,format(coalesce(round(g.amount,2),0),2) amount,coalesce(g.refno,'') cardno, "
							+ " date_format(g.date,'%d-%m-%Y') date,g.srno receiptno,ser.voc_no bookrefno,lg.guest,lg.guestcontactno gstphno,u.user_name bookedby,date_format(ser.date,'%d-%m-%Y') refdate,ac.address,ac.per_mob telno,lm.loc_name location from tr_srtour tr left join gl_cordinates gl on gl.doc_no=tr.plocid left join gl_cordinates gls on gls.doc_no=tr.dlocid "
							+ " left join tr_servicereqm ser on ser.doc_no=tr.rdocno left join my_locm lm on lm.doc_no=ser.locid left join my_acbook ac on ac.doc_no=ser.cldocno and ac.dtype='crm' "
							+ " left join gl_rentreceipt g on g.aggno=tr.rdocno and g.rtype='Service Request' left join gl_limobookm l on l.doc_no=ser.limodocno "
							+ " left join gl_limoguest lg on lg.doc_no=l.guestno left join my_user u on u.doc_no=l.userid where tr.rdocno='"+docno+"'";	       
					System.out.println("print query--->>>"+strsqls);                    
					ResultSet rs=stmt.executeQuery(strsqls);      
				    while(rs.next()){ 
                        bookrefno=rs.getString("bookrefno");
                        guest=rs.getString("guest");
                        gstphno=rs.getString("gstphno");
                        bookedby=rs.getString("bookedby");  
                        loctype=rs.getString("loctype");   
                        rname=rs.getString("rname");
                        refno=rs.getString("refno");
                        refon=rs.getString("refon");
                        ploc=rs.getString("ploc");
                        dloc=rs.getString("dloc");
                        location=rs.getString("location");  
                        vocno=rs.getString("voc_no");           
				    }
				    imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
			        imgpath=imgpath.replace("\\", "\\\\");  
			        if(conmeth==1){
			        	printname="Purchase";
			        }else{
			        	printname="Purchase Order";  
			        }
			        param.put("printname",printname);  
			        param.put("guest",guest);  
			        param.put("bookrefno",bookrefno);  
			        param.put("gstphno",gstphno);  
			        param.put("bookedby",bookedby); 
			        param.put("pickuploc",ploc); 
			        param.put("dropoffloc",dloc); 
			        param.put("reftype",rname); 
			        param.put("refon",refon);   
			        param.put("refno",refno);
			        param.put("loctype",loctype); 
			        param.put("printedby",printedby);   
			        param.put("img",imgpath);  
			        param.put("comp",comp);   
			        param.put("tel",tel);
			        param.put("fax",fax);
			        param.put("brch",brch);
			        param.put("location",location);   
			        param.put("rdocno",docno);   
			        param.put("remarks",remarks);
			        param.put("serdocno",vocno);  
			        //param.put("client",client);  
			        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/travel/travel/XOprint.jrxml"));  
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
	public String emailAction(String docno,String branch,String amendment) throws ParseException, SQLException{        
		HttpServletRequest request=ServletActionContext.getRequest();    
		HttpSession session=request.getSession();
		System.out.println("IN action=="+docno);
		String remarks="",ipath="",remail="",bccemail="",tstemail="",tstemail2="";    
		String printname="",client="",guest="",receiptno="",trnno="",date="",amount="",cardno="",gstphno="",bookedby="",bphno="",bookrefno="",tourid="",printedby=""; 
		String imgpath="",comp="",tel="",fax="",brch="",location="",cmpname="",print="0",ccemail="",dloc="",ploc="",loctype="",refno="",rname="",refon="",vocno="0"; 
		ResultSet rs=null,rss=null;    
		int conmeth=0,lamvndid=0;
	    HttpServletResponse response = ServletActionContext.getResponse();
	    java.sql.Date sqlfromdate = null;
	    java.sql.Date sqltodate = null;   
			 param = new HashMap();    
				Connection conn = null;
				Statement stmt =null,stmt2=null;
			 try {	
				    conn = ClsConnection.getMyConnection();    
					stmt=conn.createStatement();
					stmt2=conn.createStatement();
					String strMltple = "select coalesce(vendorid,0) vndid FROM tr_srtour where rdocno='"+docno+"' group by vendorid";                        
		      		System.out.println("==strMltple===="+strMltple);
		      		ResultSet rsMltple= stmt2.executeQuery(strMltple);    
		      		while(rsMltple.next ()) {  
		      			lamvndid=rsMltple.getInt("vndid");         
					
					String strSql10 = "select toemail,coalesce(email,'') email,coalesce(emailbcc,'') emailbcc FROM gl_emailmsg where dtype='TRVL'";   
		      		 //System.out.println("==strSql10===="+strSql10);
		      		 ResultSet rse = stmt.executeQuery(strSql10);
		      		 while(rse.next ()) {
		      				ccemail=rse.getString("email");
		      				bccemail=rse.getString("emailbcc");
		      		 }
		      		String sql555="select coalesce(method,0) method  from gl_config where field_nme='lammo tourism'";   
					//System.out.println("print main--->>>"+sql123); 
					ResultSet rs555 = stmt.executeQuery(sql555);    
					while(rs555.next()){
						conmeth=rs555.getInt("method");          
					}
		      		/*String strSql11 = "select vendorid,mail1 from tr_srtour t left join my_acbook ac on ac.cldocno=t.vendorid and dtype='vnd' where rdocno='"+docno+"' limit 1";*/   
					String strSql11="select vendorid,coalesce(mail1,'') mail1,coalesce(vc.email,'') cmail from tr_srtour t left join my_acbook ac on ac.cldocno=t.vendorid and dtype='vnd' left join (select group_concat(y.email) email,y.cldocno from my_vndcontact y left join my_activity act on(act.doc_no=y.actvty_id) where act.ay_name='Reservation' group by y.cldocno) vc on (vc.cldocno=t.vendorid )  where t.rdocno='"+docno+"' and t.vendorid='"+lamvndid+"'  group by t.vendorid";
		      		 System.out.println("==mailsend===="+strSql11);    
		      		 ResultSet rs11 = stmt.executeQuery(strSql11);   
		      		 while(rs11.next ()) {
		      			    if(!rs11.getString("mail1").equalsIgnoreCase("")){      
		      			    	remail=remail+rs11.getString("mail1")+",";
		      			    }
		      			    if(!rs11.getString("cmail").equalsIgnoreCase("")){     
		      			    	tstemail=tstemail+rs11.getString("cmail")+",";
		      			    }
		      		 }
		      		 if(!(tstemail.equalsIgnoreCase(""))){
		      			remail=remail+tstemail;
		      		 }
		      		remail=remail.substring(0, remail.length() - 1);  
		      		System.out.println("==remaillast===="+remail);
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
						
					}
					int i=0;
					String strsql="select coalesce(ac.cldocno,0) cldocno from tr_srtour tr left join my_acbook ac on ac.doc_no=tr.vendorid and ac.dtype='vnd'  where tr.rdocno='"+docno+"'  and tr.vendorid='"+lamvndid+"' group by tr.vendorid";     
					System.out.println("print query1--->>>"+strsql);                  
				    rs=stmt.executeQuery(strsql);      
				    while(rs.next()){                    
				     client=rs.getString("cldocno");
				     param.put("vendor"+i+"",client);
				     i++;           
				    }  
				    String strsql4="select group_concat(remarks) remarks from tr_srtour where rdocno='"+docno+"'  and vendorid='"+lamvndid+"'";     
					System.out.println("print query1--->>>"+strsql4);                     
					ResultSet resultSet14=stmt.executeQuery(strsql4);      
				    while(resultSet14.next()){                       
				    	remarks=resultSet14.getString("remarks");
				    }
				    String strsqls="select ser.voc_no,if(tr.loctype='F','Flight No',if(tr.loctype='H','Room No','')) refon,if(tr.loctype='F','Flight',if(tr.loctype='H','Hotel','')) loctype,tr.rname,tr.refno,coalesce(gl.location,'') ploc,coalesce(gls.location,'') dloc,coalesce(tr.tourid,0) tourid,ser.refname,coalesce(ac.trnnumber,'') trnnumber,format(coalesce(round(g.amount,2),0),2) amount,coalesce(g.refno,'') cardno, "
							+ " date_format(g.date,'%d-%m-%Y') date,g.srno receiptno,ser.voc_no bookrefno,lg.guest,lg.guestcontactno gstphno,u.user_name bookedby,date_format(ser.date,'%d-%m-%Y') refdate,ac.address,ac.per_mob telno,lm.loc_name location from tr_srtour tr left join gl_cordinates gl on gl.doc_no=tr.plocid left join gl_cordinates gls on gls.doc_no=tr.dlocid "
							+ " left join tr_servicereqm ser on ser.doc_no=tr.rdocno left join my_locm lm on lm.doc_no=ser.locid left join my_acbook ac on ac.doc_no=ser.cldocno and ac.dtype='crm' "
							+ " left join gl_rentreceipt g on g.aggno=tr.rdocno and g.rtype='Service Request' left join gl_limobookm l on l.doc_no=ser.limodocno "
							+ " left join gl_limoguest lg on lg.doc_no=l.guestno left join my_user u on u.doc_no=l.userid where tr.rdocno='"+docno+"'  and tr.vendorid='"+lamvndid+"'";	
					System.out.println("print query--->>>"+strsqls);                    
					ResultSet rsss=stmt.executeQuery(strsqls);      
				    while(rsss.next()){ 
                        bookrefno=rsss.getString("bookrefno");
                        guest=rsss.getString("guest");
                        gstphno=rsss.getString("gstphno");
                        bookedby=rsss.getString("bookedby");  
                        loctype=rsss.getString("loctype");   
                        rname=rsss.getString("rname");
                        refno=rsss.getString("refno"); 
                        refon=rsss.getString("refon");
                        ploc=rsss.getString("ploc");
                        dloc=rsss.getString("dloc");
                        location=rsss.getString("location");
                        vocno=rsss.getString("voc_no");                                                 
				    }
				    imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");  
			        imgpath=imgpath.replace("\\", "\\\\");   
			        if(conmeth==1){
			        	printname="Purchase";
			        }else{
			        	printname="Purchase Order";  
			        }
			        param.put("printname",printname); 
			        param.put("img",imgpath);  
			        param.put("guest",guest);  
			        param.put("bookrefno",bookrefno);  
			        param.put("gstphno",gstphno);  
			        param.put("bookedby",bookedby); 
			        param.put("pickuploc",ploc); 
			        param.put("dropoffloc",dloc); 
			        param.put("reftype",rname); 
			        param.put("refno",refno);   
			        param.put("refon",refon); 
			        param.put("loctype",loctype);    
			        param.put("printedby",printedby);   
			        param.put("comp",comp);   
			        param.put("tel",tel);
			        param.put("fax",fax);
			        param.put("brch",brch);
			        param.put("location",location);   
			        param.put("rdocno",docno);  
			        param.put("remarks",remarks);  
			        param.put("serdocno",vocno);     
			        //param.put("client",client);  
			        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/travel/travel/XOprint.jrxml"));  
  	                JasperReport jasperReport = JasperCompileManager.compileReport(design);
  	                generateReportEmail(param, jasperReport, conn, remail, ccemail, bccemail, print, session, docno, amendment); 
  	                remail="";
  	                tstemail="";  
		      		}   
	               } catch (Exception e) {          
	                 e.printStackTrace();
	             }
	            finally{
			conn.close();   
		}	  	
	return "print";   
	}
	private void generateReportEmail(Map parameters, JasperReport jasperReport, Connection conn, String remail, String ccemail,String bccemail, String print,HttpSession session,String docno,String amendment)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {
		  byte[] bytes = null;
      bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
      EmailProcess ep=new EmailProcess();   
  	Statement stmtrr=conn.createStatement();
  	  
  	String fileName="",path="", formcode="TRVL",filepath=""; 
  	String host="", port="", userName="", password="", recipient="",subject="", message="",docnos="1";
  	String strSql1 = "select imgPath from my_comp";

		ResultSet rs1 = stmtrr.executeQuery(strSql1);
		while(rs1.next ()) {
			path=rs1.getString("imgPath");
		}
		
		String strSql2 = "select concat(subject,'-',(select concat(' Booking no : ',rq.voc_no , ', ',coalesce(trs.name,''),'---',coalesce(tr.date,''))details from tr_servicereqm rq left join gl_limobookm l on l.doc_no=rq.limodocno left join tr_srtour tr on rq.doc_no=tr.rdocno left join tr_tours trs on tr.tourid=trs.doc_no where rq.doc_no="+docno+" limit 1)) subject,msg from gl_emailmsg where dtype='TRVL'";          
		System.out.println("msgggg--->>>"+strSql2);     
		ResultSet rs2 = stmtrr.executeQuery(strSql2);   
		while(rs2.next ()) {
			if(amendment.equalsIgnoreCase("1")){
				subject="Amended "+rs2.getString("subject");   
			}else{
				subject=rs2.getString("subject");				
			}
			message=rs2.getString("msg");     
		}
	/*	userName="gatewayerp55@gmail.com";
		port="587";
		host="smtp.gmail.com";
		password="gwsupport#321";*/
		String strSql3 = "select email,mailpass,smtpserver,smtphostport from my_user where doc_no='"+session.getAttribute("USERID").toString()+"'";    
		System.out.println("sql--->>>"+strSql3);   
		ResultSet rs3 = stmtrr.executeQuery(strSql3);
		while(rs3.next ()) {   
			userName=rs3.getString("email");    
			port=rs3.getString("smtphostport");
			host=rs3.getString("smtpserver");
			password=ClsEncrypt.getInstance().decrypt(rs3.getString("mailpass"));
		}
			  
		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
		java.util.Date date = new java.util.Date();
		String currdate=dateFormat.format(date);
		
		fileName = "XOdetails"+currdate+".pdf";
		filepath=path+ "/Attachment/"+formcode+"/"+fileName;

		File dir = new File(path+ "/attachment/"+formcode); 
		dir.mkdirs();
		    
		FileOutputStream fos = new FileOutputStream(filepath);
  	    fos.write(bytes);
  	    fos.flush();
  	    fos.close();
  	
     	File saveFile=new File(filepath);
		SendEmailAction sendmail= new SendEmailAction();
		//String[] remails=remail.split(",");
		
			try {
				ep.sendEmailwithpdfBCC(host, port, userName, password,remail, ccemail,bccemail,subject, message, saveFile,docnos);     
			} catch (javax.mail.MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();  
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
