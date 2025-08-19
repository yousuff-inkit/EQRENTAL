package com.dashboard.travel.hotelvouchercreate;

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
public class ClsHotelVoucherCreateAction extends ActionSupport{   
	    ClsHotelVoucherCreateDAO DAO= new ClsHotelVoucherCreateDAO();           
	    ClsConnection conobj=new ClsConnection();
	    ClsCommon com=new ClsCommon();                 
	    private String hidcpudoc,hidinvtrno,clvatamt,hidchkval,cmbbranch,hidcmbbranch,mode,msg,suppconfno,clid,vndid,issuedate,txtrate,cmbvtype, hidcmbvtype, guestname, nonvatamt, vatamt,taxamt,supptot,servfee,paybackamt,acc_docno,sellingprice;
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
		public String getClvatamt() { 
			return clvatamt;
		}
		public void setClvatamt(String clvatamt) {
			this.clvatamt = clvatamt;
		}
		public String getHidchkval() {
			return hidchkval;
		}
		public void setHidchkval(String hidchkval) {
			this.hidchkval = hidchkval;
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
		public String getCmbvtype() {
			return cmbvtype;
		}
		public void setCmbvtype(String cmbvtype) { 
			this.cmbvtype = cmbvtype;
		}
		public String getHidcmbvtype() {
			return hidcmbvtype;
		}
		public void setHidcmbvtype(String hidcmbvtype) {
			this.hidcmbvtype = hidcmbvtype;
		}
		public String getGuestname() {
			return guestname;
		}
		public void setGuestname(String guestname) {
			this.guestname = guestname;
		}
		public String getNonvatamt() {
			return nonvatamt;
		}
		public void setNonvatamt(String nonvatamt) {
			this.nonvatamt = nonvatamt;
		}
		public String getVatamt() {
			return vatamt;
		}
		public void setVatamt(String vatamt) {
			this.vatamt = vatamt;
		}
		private int docno,masterdocno,hidrowno;  
		private String isstaffid,isstaff,countryid,cityid,hotelid,roomtypeid,payacno,paybackacc,jqxclient,jqxsupplier,jqxcountry,jqxcity,jqxhotel,jqxrtype,cmbmealplan,hidcmbmealplan;

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
		public String getSuppconfno() {
			return suppconfno;
		}
		public void setSuppconfno(String suppconfno) {
			this.suppconfno = suppconfno;
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
		public String getIssuedate() {
			return issuedate;
		}
		public void setIssuedate(String issuedate) {
			this.issuedate = issuedate;
		}
		public String getTxtrate() {
			return txtrate;
		}
		public void setTxtrate(String txtrate) {
			this.txtrate = txtrate;
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
		public int getDocno() {
			return docno;
		}
		public void setDocno(int docno) {
			this.docno = docno;
		}
		public int getMasterdocno() {
			return masterdocno;
		}
		public void setMasterdocno(int masterdocno) {
			this.masterdocno = masterdocno;
		}
		public int getHidrowno() {
			return hidrowno;
		}
		public void setHidrowno(int hidrowno) {
			this.hidrowno = hidrowno;
		}
		public String getIsstaffid() {
			return isstaffid;
		}
		public void setIsstaffid(String isstaffid) {
			this.isstaffid = isstaffid;
		}
		public String getIsstaff() {
			return isstaff;
		}
		public void setIsstaff(String isstaff) {
			this.isstaff = isstaff;
		}
		public String getCountryid() {
			return countryid;
		}
		public void setCountryid(String countryid) {
			this.countryid = countryid;
		}
		public String getCityid() {
			return cityid;
		}
		public void setCityid(String cityid) {
			this.cityid = cityid;
		}
		public String getHotelid() {
			return hotelid;
		}
		public void setHotelid(String hotelid) {
			this.hotelid = hotelid;
		}
		public String getRoomtypeid() {
			return roomtypeid;
		}
		public void setRoomtypeid(String roomtypeid) {  
			this.roomtypeid = roomtypeid;
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
		public String getJqxcountry() {
			return jqxcountry;
		}
		public void setJqxcountry(String jqxcountry) {
			this.jqxcountry = jqxcountry;
		}
		public String getJqxcity() {
			return jqxcity;
		}
		public void setJqxcity(String jqxcity) {
			this.jqxcity = jqxcity;
		}
		public String getJqxhotel() {
			return jqxhotel;
		}
		public void setJqxhotel(String jqxhotel) {
			this.jqxhotel = jqxhotel;
		}
		public String getJqxrtype() {
			return jqxrtype;
		}
		public void setJqxrtype(String jqxrtype) {
			this.jqxrtype = jqxrtype;
		}
		public String getCmbmealplan() {
			return cmbmealplan;
		}
		public void setCmbmealplan(String cmbmealplan) {
			this.cmbmealplan = cmbmealplan;
		}
		public String getHidcmbmealplan() {
			return hidcmbmealplan;
		}
		public void setHidcmbmealplan(String hidcmbmealplan) {
			this.hidcmbmealplan = hidcmbmealplan;
		}
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
		//System.out.println("====="+getIssuedate());              
		issueDate = com.changeStringtoSqlDate(getIssuedate());           
        if(mode.equalsIgnoreCase("A")){               
			int val=DAO.insert(getMasterdocno(),getDocno(),getSuppconfno(),getClid(),getVndid(),issueDate,getIsstaffid(),getCountryid(),getCityid(),getHotelid(),getRoomtypeid(),getCmbmealplan(),getTxtrate(),getTaxamt(),getSupptot(),getServfee(),getPaybackamt(),getAcc_docno(),getSellingprice(),getNonvatamt(),getVatamt(),getGuestname(),getCmbvtype(),getCmbbranch(),getClvatamt(),getHidchkval(),session,request,mode);          
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
			boolean status=DAO.edit(getHidrowno(),getSuppconfno(),getClid(),getVndid(),issueDate,getIsstaffid(),getCountryid(),getCityid(),getHotelid(),getRoomtypeid(),getCmbmealplan(),getTxtrate(),getTaxamt(),getSupptot(),getServfee(),getPaybackamt(),getAcc_docno(),getSellingprice(),getNonvatamt(),getVatamt(),getGuestname(),getCmbvtype(),getCmbbranch(),getClvatamt(),getHidchkval(),session,request,mode);       
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
			boolean status=DAO.delete(getMasterdocno(),getDocno(),getSuppconfno(),getClid(),getVndid(),issueDate,getIsstaffid(),getCountryid(),getCityid(),getHotelid(),getRoomtypeid(),getCmbmealplan(),getTxtrate(),getTaxamt(),getSupptot(),getServfee(),getPaybackamt(),getAcc_docno(),getSellingprice(),getNonvatamt(),getVatamt(),getGuestname(),getCmbvtype(),getCmbbranch(),getClvatamt(),getHidchkval(),session,request,mode);       
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
			boolean status=DAO.griddelete(getHidrowno(),getSuppconfno(),getClid(),getVndid(),issueDate,getIsstaffid(),getCountryid(),getCityid(),getHotelid(),getRoomtypeid(),getCmbmealplan(),getTxtrate(),getTaxamt(),getSupptot(),getServfee(),getPaybackamt(),getAcc_docno(),getSellingprice(),getNonvatamt(),getVatamt(),getGuestname(),getCmbvtype(),getCmbbranch(),getClvatamt(),getHidchkval(),session,request,mode);       
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
					String strsql="select coalesce(d.inclusive,0) inclusive,d.vtype,round(coalesce(d.clvatamt,0),2) clvatamt,round(coalesce(d.nonvatamt,0),2) nonvatamt,round(coalesce(d.vatamt,0),2) vatamt,d.guest,suppconfno, d.cldocno, vnddocno, isstaffid, issuedate, countryid, cityid, hotelid, d.roomtype, d.mealplan, "
							+ "u1.user_name isstaff,ac.refname customer,acc.refname vendor, round(coalesce(d.rate,0),2) rate, round(coalesce(supamt,0),2) supamt, "  
							+ "round(coalesce(taxamt,0),2) taxamt, round(coalesce(suptotal,0),2) suptotal, round(coalesce(servfee,0),2 ) servfee, round(coalesce(paybackamt,0),2) paybackamt, pdocno, round(coalesce(sprice,0),2) sprice,cn.country_name country,cy.city_name city,ht.name hotel, "
							+ "h.description account,h.account acno,d.cpudoc,d.invtrno from ti_hotelvoucherm m left join ti_hotelvoucherd d on d.rdocno=m.doc_no "
                            + " left join my_acbook ac on (ac.cldocno=d.cldocno and ac.dtype='CRM') left join my_acbook acc on (acc.cldocno=d.vnddocno and acc.dtype='VND') left join my_user u1 on u1.doc_no=d.isstaffid left join my_acountry cn on cn.doc_no=d.countryid left join my_acity cy on cy.doc_no=d.cityid left join tr_hotel ht on ht.doc_no=d.hotelid left join my_head h on (h.doc_no=d.pdocno and h.atype='GL') where m.status<>7 and  d.rowno='"+detrowno+"' "+sqltest+"";
					System.out.println("VIEW DETAILS-------------->>>"+strsql);       
					ResultSet rs=stmt.executeQuery(strsql);  
					while(rs.next()){
						setSuppconfno(rs.getString("suppconfno"));  
						setJqxclient(rs.getString("customer"));   
						setJqxsupplier(rs.getString("vendor"));
						setPayacno(rs.getString("acno"));
						setPaybackacc(rs.getString("account"));
						setClid(rs.getString("cldocno"));
						setVndid(rs.getString("vnddocno"));
						setIssuedate(rs.getString("issuedate"));
						setTxtrate(rs.getString("rate"));
						setTaxamt(rs.getString("taxamt"));
						setSupptot(rs.getString("suptotal"));
						setServfee(rs.getString("servfee"));
						setPaybackamt(rs.getString("paybackamt"));
						setAcc_docno(rs.getString("pdocno"));
						setSellingprice(rs.getString("sprice"));  
						setJqxcity(rs.getString("city"));
						setJqxcountry(rs.getString("country"));
				        setJqxhotel(rs.getString("hotel"));
						setJqxrtype(rs.getString("roomtype"));
						setCityid(rs.getString("cityid"));
						setHidcmbmealplan(rs.getString("mealplan"));
						setCountryid(rs.getString("countryid"));
						setHotelid(rs.getString("hotelid"));
						setRoomtypeid(rs.getString("roomtype"));   
						setHidcmbvtype(rs.getString("vtype"));  
						setVatamt(rs.getString("vatamt"));
						setNonvatamt(rs.getString("nonvatamt")); 
						setGuestname(rs.getString("guest"));
						setHidcmbbranch(getCmbbranch()); 
						setClvatamt(rs.getString("clvatamt"));
						setHidchkval(rs.getString("inclusive")); 
						setHidcpudoc(rs.getString("cpudoc"));
						setHidinvtrno(rs.getString("invtrno"));    
				}  
				}else{
					String strsql="select voc_no,doc_no from ti_hotelvoucherm where status<>7 and doc_no='"+getMasterdocno()+"'";          
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
		setSuppconfno("");
		setClid("");
		setVndid("");
		setIssuedate("");
		setTxtrate("1");
		setTaxamt("");
		setSupptot("");
		setServfee("");
		setPaybackamt("");
		setAcc_docno("");
		setSellingprice("");
		setJqxcity("");
		setJqxcountry("");
        setJqxhotel("");
		setJqxrtype("");
		setCityid("");
		setCmbmealplan("");
		setHidcmbmealplan("");
		setCountryid("");
		setHotelid("");
		setRoomtypeid("");
		setVatamt("");
		setNonvatamt("");
		setCmbvtype("");
		setHidcmbvtype("H"); 
		setGuestname("");
		setHidcmbbranch(getCmbbranch());  
		setClvatamt("");
		setHidchkval("0");   
	}
}
