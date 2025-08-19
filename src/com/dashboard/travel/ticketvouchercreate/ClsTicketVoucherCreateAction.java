package com.dashboard.travel.ticketvouchercreate;

import java.sql.*;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.common.ClsEncrypt;
import com.connection.ClsConnection;
import com.ibm.icu.text.DateFormat;
import com.ibm.icu.text.SimpleDateFormat;
import com.mailwithpdf.EmailProcess;
import com.opensymphony.xwork2.ActionSupport;   
import com.dashboard.travel.hotelbookingportal.ClsHotelBookingPortalDAO;
import com.dashboard.travel.hotelbookingportal.ClsHotelBookingPortalBean;
       
@SuppressWarnings("serial")              
public class ClsTicketVoucherCreateAction extends ActionSupport{   
	    ClsTicketVoucherCreateDAO DAO= new ClsTicketVoucherCreateDAO();           
	    ClsConnection conobj=new ClsConnection();
	    ClsCommon com=new ClsCommon();             
		private String  hidcpudoc,hidinvtrno,cmbbranch,hidcmbbranch,mode,msg,ticketno,clid,vndid,bookingdate,issuedate,guestname,airlineid,sector,txtclass,cmbgds,bstaffid,tstaffid,cmbissuetype,cmbtype,cmbtickettype,txtrate,suppamt,taxamt,supptot,servfee,paybackamt,acc_docno,sellingprice,farebasis,cmbregioncode,txtremarks,bookingiatano,ticketingiatano,bookingofficeid,ticketingofficeid,firstofficeid,currentofficeid;
		public String getHidcpudoc() {
			return hidcpudoc;
		}
		public void setHidcpudoc(String hidcpudoc) {
			this.hidcpudoc = hidcpudoc;
		}
		public String getHidinvtrno() {
			return hidinvtrno;
		}
		public void setHidinvtrno(String hidinvtrno) {
			this.hidinvtrno = hidinvtrno;
		}
		public String getCmbbranch() {
			return cmbbranch;
		}

		public void setCmbbranch(String cmbbranch) {
			this.cmbbranch = cmbbranch;
		}

		public String getHidcmbbranch() {
			return hidcmbbranch;
		}

		public void setHidcmbbranch(String hidcmbbranch) {
			this.hidcmbbranch = hidcmbbranch;
		}
		private int docno,masterdocno,hidrowno; 
		private String  prnno,hidgds,bstaff,tstaff,hidissuetype,hidtype,hidtickettype,payacno,paybackacc,hidregioncode,airline,jqxclient,jqxsupplier;   
		public String getPrnno() {      
			return prnno;
		}

		public void setPrnno(String prnno) {
			this.prnno = prnno;
		}

		public String getJqxclient() {
			return jqxclient;
		}

		public void setJqxclient(String jqxclient) {
			this.jqxclient = jqxclient;
		}

		public String getJqxsupplier() {
			return jqxsupplier;
		}

		public void setJqxsupplier(String jqxsupplier) {
			this.jqxsupplier = jqxsupplier;
		}

		public String getHidgds() {
			return hidgds;
		}

		public void setHidgds(String hidgds) {
			this.hidgds = hidgds;
		}

		public String getBstaff() {
			return bstaff;
		}

		public void setBstaff(String bstaff) {
			this.bstaff = bstaff;
		}

		public String getTstaff() {
			return tstaff;
		}

		public void setTstaff(String tstaff) {
			this.tstaff = tstaff;
		}

		public String getHidissuetype() {
			return hidissuetype;
		}

		public void setHidissuetype(String hidissuetype) {
			this.hidissuetype = hidissuetype;
		}

		public String getHidtype() {
			return hidtype;
		}

		public void setHidtype(String hidtype) {
			this.hidtype = hidtype;
		}

		public String getHidtickettype() {
			return hidtickettype;
		}

		public void setHidtickettype(String hidtickettype) {
			this.hidtickettype = hidtickettype;
		}

		public String getPayacno() {
			return payacno;
		}

		public void setPayacno(String payacno) {
			this.payacno = payacno;
		}

		public String getPaybackacc() {
			return paybackacc;
		}

		public void setPaybackacc(String paybackacc) {
			this.paybackacc = paybackacc;
		}

		public String getHidregioncode() {
			return hidregioncode;
		}

		public void setHidregioncode(String hidregioncode) {
			this.hidregioncode = hidregioncode;
		}

		public String getAirline() {
			return airline;
		}

		public void setAirline(String airline) {
			this.airline = airline;
		}

		public int getHidrowno() {
			return hidrowno;
		}

		public void setHidrowno(int hidrowno) {
			this.hidrowno = hidrowno;
		}

		public int getMasterdocno() {      
			return masterdocno;
		}

		public void setMasterdocno(int masterdocno) {
			this.masterdocno = masterdocno;
		}

		public int getDocno() {
			return docno;
		}

		public void setDocno(int docno) {  
			this.docno = docno;
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

		public String getTicketno() {
			return ticketno;
		}
		
		public void setTicketno(String ticketno) {
			this.ticketno = ticketno;
		}

		public String getClid() {
			return clid;
		}

		public void setClid(String clid) {
			this.clid = clid;
		}

		public String getVndid() {
			return vndid;
		}

		public void setVndid(String vndid) {
			this.vndid = vndid;
		}

		public String getBookingdate() {
			return bookingdate;
		}

		public void setBookingdate(String bookingdate) {
			this.bookingdate = bookingdate;
		}

		public String getIssuedate() {
			return issuedate;
		}

		public void setIssuedate(String issuedate) {
			this.issuedate = issuedate;
		}
		
		public String getGuestname() {
			return guestname;
		}

		public void setGuestname(String guestname) {
			this.guestname = guestname;
		}

		public String getAirlineid() {
			return airlineid;
		}

		public void setAirlineid(String airlineid) {
			this.airlineid = airlineid;
		}

		public String getSector() {
			return sector;
		}

		public void setSector(String sector) {
			this.sector = sector;
		}

		public String getTxtclass() {
			return txtclass;
		}

		public void setTxtclass(String txtclass) {
			this.txtclass = txtclass;
		}

		public String getCmbgds() {
			return cmbgds;
		}

		public void setCmbgds(String cmbgds) {
			this.cmbgds = cmbgds;
		}

		public String getBstaffid() {
			return bstaffid;
		}

		public void setBstaffid(String bstaffid) {
			this.bstaffid = bstaffid;
		}

		public String getTstaffid() {
			return tstaffid;
		}
		
		public void setTstaffid(String tstaffid) {
			this.tstaffid = tstaffid;
		}

		public String getCmbissuetype() {
			return cmbissuetype;
		}

		public void setCmbissuetype(String cmbissuetype) {
			this.cmbissuetype = cmbissuetype;
		}

		public String getCmbtype() {
			return cmbtype;
		}

		public void setCmbtype(String cmbtype) {
			this.cmbtype = cmbtype;
		}

		public String getCmbtickettype() {
			return cmbtickettype;
		}

		public void setCmbtickettype(String cmbtickettype) {
			this.cmbtickettype = cmbtickettype;
		}

		public String getTxtrate() {
			return txtrate;
		}

		public void setTxtrate(String txtrate) {
			this.txtrate = txtrate;
		}

		public String getSuppamt() {
			return suppamt;
		}

		public void setSuppamt(String suppamt) {
			this.suppamt = suppamt;
		}

		public String getTaxamt() {
			return taxamt;
		}

		public void setTaxamt(String taxamt) {
			this.taxamt = taxamt;
		}

		public String getSupptot() {
			return supptot;
		}
		
		public void setSupptot(String supptot) {
			this.supptot = supptot;
		}

		public String getServfee() {
			return servfee;
		}

		public void setServfee(String servfee) {
			this.servfee = servfee;
		}

		public String getPaybackamt() {
			return paybackamt;
		}

		public void setPaybackamt(String paybackamt) {
			this.paybackamt = paybackamt;
		}

		public String getAcc_docno() {
			return acc_docno;
		}

		public void setAcc_docno(String acc_docno) {
			this.acc_docno = acc_docno;
		}

		public String getSellingprice() {
			return sellingprice;
		}

		public void setSellingprice(String sellingprice) {
			this.sellingprice = sellingprice;
		}

		public String getFarebasis() {
			return farebasis;
		}

		public void setFarebasis(String farebasis) {
			this.farebasis = farebasis;
		}

		public String getCmbregioncode() {
			return cmbregioncode;
		}

		public void setCmbregioncode(String cmbregioncode) {
			this.cmbregioncode = cmbregioncode;
		}

		public String getTxtremarks() {
			return txtremarks;
		}

		public void setTxtremarks(String txtremarks) {
			this.txtremarks = txtremarks;
		}
		
		public String getBookingiatano() {
			return bookingiatano;
		}

		public void setBookingiatano(String bookingiatano) {
			this.bookingiatano = bookingiatano;
		}

		public String getTicketingiatano() {
			return ticketingiatano;
		}

		public void setTicketingiatano(String ticketingiatano) {
			this.ticketingiatano = ticketingiatano;
		}

		public String getBookingofficeid() {
			return bookingofficeid;
		}

		public void setBookingofficeid(String bookingofficeid) {
			this.bookingofficeid = bookingofficeid;
		}

		public String getTicketingofficeid() {
			return ticketingofficeid;
		}

		public void setTicketingofficeid(String ticketingofficeid) {
			this.ticketingofficeid = ticketingofficeid;
		}

		public String getFirstofficeid() {
			return firstofficeid;
		}

		public void setFirstofficeid(String firstofficeid) {
			this.firstofficeid = firstofficeid;
		}

		public String getCurrentofficeid() {
			return currentofficeid;
		}  

		public void setCurrentofficeid(String currentofficeid) {
			this.currentofficeid = currentofficeid;
		}
		java.sql.Date bookDate;  
		java.sql.Date issueDate;
	public String saveAction() throws ParseException, SQLException{     
		//System.out.println("IN ACTION===="+getMasterdocno()); 
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String str="";
		int detrowno=0;
		detrowno=getHidrowno();  
		//System.out.println(getBookingdate()+"====="+getIssuedate());              
		bookDate = com.changeStringtoSqlDate(getBookingdate());  
		issueDate = com.changeStringtoSqlDate(getIssuedate());   
        if(mode.equalsIgnoreCase("A")){               
			int val=DAO.insert(getMasterdocno(),getDocno(),getTicketno(),getClid(),getVndid(),bookDate,issueDate,getGuestname(),getAirlineid(),getSector(),getTxtclass(),getCmbgds(),getBstaffid(),getTstaffid(),getCmbissuetype(),getCmbtype(),getCmbtickettype(),getTxtrate(),getSuppamt(),getTaxamt(),getSupptot(),getServfee(),getPaybackamt(),getAcc_docno(),getSellingprice(),getFarebasis(),getCmbregioncode(),getTxtremarks(),getBookingiatano(),getTicketingiatano(),getBookingofficeid(),getTicketingofficeid(),getFirstofficeid(),getCurrentofficeid(),getPrnno(),getCmbbranch(),session,request,mode);       
			//System.out.println("in action ===="+val);  
			int vdocno=(int) request.getAttribute("vocno");                       
			if(val>0){    
				setMasterdocno(val);
				setDocno(vdocno);
				setData();
				setMsg("Successfully Saved");              
				return "success";
			}
			else{
				setMasterdocno(val);
				setDocno(vdocno);
				setData();
			    setMsg("Not Saved");  
				return "fail";
			}	   
		}else if(mode.equalsIgnoreCase("E")){                                         
			boolean status=DAO.edit(getHidrowno(),getTicketno(),getClid(),getVndid(),bookDate,issueDate,getGuestname(),getAirlineid(),getSector(),getTxtclass(),getCmbgds(),getBstaffid(),getTstaffid(),getCmbissuetype(),getCmbtype(),getCmbtickettype(),getTxtrate(),getSuppamt(),getTaxamt(),getSupptot(),getServfee(),getPaybackamt(),getAcc_docno(),getSellingprice(),getFarebasis(),getCmbregioncode(),getTxtremarks(),getBookingiatano(),getTicketingiatano(),getBookingofficeid(),getTicketingofficeid(),getFirstofficeid(),getCurrentofficeid(),getPrnno(),getCmbbranch(),session,request,mode);       
			if(status){    
				setMasterdocno(getMasterdocno());    
				setDocno(getDocno());
				setData();
				setMsg("Updated Successfully");              
				return "success";
			}
			else{
				setMasterdocno(getMasterdocno());       
				setDocno(getDocno());
				setData();
			    setMsg("Not Updated");  
				return "fail";
			}	
		}else if(mode.equalsIgnoreCase("D")){                         
			boolean status=DAO.delete(getMasterdocno(),getDocno(),getTicketno(),getClid(),getVndid(),bookDate,issueDate,getGuestname(),getAirlineid(),getSector(),getTxtclass(),getCmbgds(),getBstaffid(),getTstaffid(),getCmbissuetype(),getCmbtype(),getCmbtickettype(),getTxtrate(),getSuppamt(),getTaxamt(),getSupptot(),getServfee(),getPaybackamt(),getAcc_docno(),getSellingprice(),getFarebasis(),getCmbregioncode(),getTxtremarks(),getBookingiatano(),getTicketingiatano(),getBookingofficeid(),getTicketingofficeid(),getFirstofficeid(),getCurrentofficeid(),getPrnno(),getCmbbranch(),session,request,mode);       
			//System.out.println("in action ===="+val);    
			if(status){    
				setData();
				setMsg("Successfully Deleted");                
				return "success";
			}
			else{
				setData();
			    setMsg("Not Deleted");    
				return "fail";
			}	  
		}else if(mode.equalsIgnoreCase("GD")){    
			boolean status=DAO.griddelete(getHidrowno(),getTicketno(),getClid(),getVndid(),bookDate,issueDate,getGuestname(),getAirlineid(),getSector(),getTxtclass(),getCmbgds(),getBstaffid(),getTstaffid(),getCmbissuetype(),getCmbtype(),getCmbtickettype(),getTxtrate(),getSuppamt(),getTaxamt(),getSupptot(),getServfee(),getPaybackamt(),getAcc_docno(),getSellingprice(),getFarebasis(),getCmbregioncode(),getTxtremarks(),getBookingiatano(),getTicketingiatano(),getBookingofficeid(),getTicketingofficeid(),getFirstofficeid(),getCurrentofficeid(),getPrnno(),getCmbbranch(),session,request,mode);       
			//System.out.println("in action ====GD "+status);                
			if(status){ 
				setMasterdocno(getMasterdocno());    
				setDocno(getDocno());    
				setHidrowno(0);    
				setData();
				setMsg("Row Successfully Deleted");                
				return "success";
			}
			else{
				setMasterdocno(getMasterdocno());    
				setDocno(getDocno());
				setHidrowno(0);
				setData();
			    setMsg("Not Deleted");    
				return "fail";
			}	
		}else if(mode.equalsIgnoreCase("VIEW")){                          
        	Connection conn=null; 
			try{ 
				conn=conobj.getMyConnection();  
				Statement stmt=conn.createStatement();
				//System.out.println("VIEW DETAILS-------------->>>"+getHidrowno()); 
				String sqltest="";
				if(!getCmbbranch().equalsIgnoreCase("") && !getCmbbranch().equalsIgnoreCase("0")){                    
					sqltest=" and m.brhid='"+getCmbbranch()+"'";    
				}
				if(detrowno>0){   
					String strsql="select d.prnno,ar.name airline,ticketno, d.cldocno, vnddocno, bookdate, issuedate, guest, airlineid, sector, d.class classes, d.gds gdsid, bstaffid, tstaffid, "
							+ "u1.user_name bstaff,u2.user_name tstaff, issuetype, d.type typeid,d.tickettype tickettypeid,ac.refname customer,acc.refname vendor, round(coalesce(d.rate,0),2) rate, round(coalesce(supamt,0),2) supamt, "
							+ "round(coalesce(taxamt,0),2) taxamt, round(coalesce(suptotal,0),2) suptotal, round(coalesce(servfee,0),2) servfee, round(coalesce(paybackamt,0),2) paybackamt, pdocno, round(coalesce(sprice,0),2) sprice, fbasis, region, d.remarks, biatano, tiatano, bofficeid, tofficeid, fofficeid, cofficeid, "
							+ "h.description account,h.account acno,ty.type,tty.type tickettype,g.name gds,d.invtrno,d.cpudoc from ti_ticketvoucherm m left join ti_ticketvoucherd d on d.rdocno=m.doc_no " 
							+ " left join my_acbook ac on (ac.cldocno=d.cldocno and ac.dtype='CRM') left join my_acbook acc on (acc.cldocno=d.vnddocno and acc.dtype='VND') left join my_user u1 on u1.doc_no=d.bstaffid left join my_user u2 on u2.doc_no=d.tstaffid left join ti_type ty on ty.doc_no=d.type left join ti_tickettype tty on tty.doc_no=d.tickettype left join ti_airline ar on ar.doc_no=d.airlineid left join ti_gds g on g.doc_no=d.gds left join my_head h on (h.doc_no=d.pdocno and h.atype='GL') where m.status<>7 and  d.rowno='"+detrowno+"' "+sqltest+"";  
					//System.out.println("VIEW DETAILS-------------->>>"+strsql);  
					ResultSet rs=stmt.executeQuery(strsql);   
					while(rs.next()){
						setPrnno(rs.getString("prnno"));   
						setJqxclient(rs.getString("customer"));
						setJqxsupplier(rs.getString("vendor"));
						setHidgds(rs.getString("gdsid"));  
						setHidissuetype(rs.getString("issuetype"));
						setHidregioncode(rs.getString("region"));
						setHidtickettype(rs.getString("tickettypeid"));
						setHidtype(rs.getString("typeid"));
						setAirline(rs.getString("airline"));
						setPayacno(rs.getString("acno"));
						setPaybackacc(rs.getString("account"));
						setBstaff(rs.getString("bstaff"));
						setTstaff(rs.getString("tstaff"));
						setTicketno(rs.getString("ticketno"));
						setClid(rs.getString("cldocno"));
						setVndid(rs.getString("vnddocno"));
						setBookingdate(rs.getString("bookdate"));
						setIssuedate(rs.getString("issuedate"));
						setGuestname(rs.getString("guest"));
						setAirlineid(rs.getString("airlineid"));
						setSector(rs.getString("sector"));
						setTxtclass(rs.getString("classes"));
						//setCmbgds(rs.getString("gdsid"));
						setBstaffid(rs.getString("bstaffid"));
						setTstaffid(rs.getString("tstaffid"));
						//setCmbissuetype(rs.getString("issuetype"));
						//setCmbtype(rs.getString("typeid"));
						//setCmbtickettype(rs.getString("tickettypeid"));
						setTxtrate(rs.getString("rate"));
						setSuppamt(rs.getString("supamt"));
						setTaxamt(rs.getString("taxamt"));
						setSupptot(rs.getString("suptotal"));
						setServfee(rs.getString("servfee"));
						setPaybackamt(rs.getString("paybackamt"));
						setAcc_docno(rs.getString("pdocno"));
						setSellingprice(rs.getString("sprice"));
						setFarebasis(rs.getString("fbasis"));
						//setCmbregioncode(rs.getString("region"));
						setTxtremarks(rs.getString("remarks"));
						setBookingiatano(rs.getString("biatano"));
						setTicketingiatano(rs.getString("tiatano"));
						setBookingofficeid(rs.getString("bofficeid"));
						setTicketingofficeid(rs.getString("tofficeid"));
						setFirstofficeid(rs.getString("fofficeid"));   
						setCurrentofficeid(rs.getString("cofficeid"));	 
						setHidcmbbranch(getCmbbranch()); 
						setHidcpudoc(rs.getString("cpudoc"));
						setHidinvtrno(rs.getString("invtrno"));        
				}  
				}else{
					String strsql="select voc_no,doc_no from ti_ticketvoucherm where status<>7 and doc_no='"+getMasterdocno()+"'";          
					//System.out.println("VIEW DETAILS-------------->>>"+strsql);  
					ResultSet rs1=stmt.executeQuery(strsql);  
					while(rs1.next()){
						setMasterdocno(rs1.getInt("doc_no"));       
						setDocno(rs1.getInt("voc_no"));
					}
				}
			}   
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();  
			}
        	return "success";	
		}
		return "fail";	    
	}  
	public void setData() {
		setJqxclient("");
		setJqxsupplier("");
		setAirline("");
		setTicketno("");
		setClid("");
		setVndid("");
		setIssuedate("");
		setGuestname("");
		setAirlineid("");
		setSector("");
		setTxtclass("");
		setCmbgds("");
		setBstaffid("");
		setTstaffid("");
		setCmbissuetype("");
		setCmbtype("");
		setCmbtickettype("");
		setTxtrate("1");
		setSuppamt("");
		setTaxamt("");
		setSupptot("");
		setServfee("");
		setPaybackamt("");
		setAcc_docno("");
		setSellingprice("");
		setFarebasis("");
		setCmbregioncode("");
		setTxtremarks("");
		setBookingiatano("");
		setTicketingiatano("");
		setBookingofficeid("");
		setTicketingofficeid("");
		setFirstofficeid("");   
		setCurrentofficeid("");
		setPrnno("");
		setHidcmbbranch(getCmbbranch()); 
	}
}
