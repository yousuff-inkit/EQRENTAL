package com.dashboard.travel.hotelbookingportal;

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
public class ClsHotelBookingPortalAction extends ActionSupport{   
	ClsHotelBookingPortalDAO DAO= new ClsHotelBookingPortalDAO();   
	ClsConnection conobj=new ClsConnection();
	ClsCommon com=new ClsCommon();           
	private String hidclient,hotelid,roomid,txtroom,txtclienttype,hidname,txtclient,txtmob,txtemail,txtpax,txtchild,txtage1,txtage2,txtage3,txtage4,txtage5,txtage6,fromdate,todate,cmblocation,mode,msg;
	public String getHidclient() {
		return hidclient;
	}
	public void setHidclient(String hidclient) {
		this.hidclient = hidclient;
	}
	public String getHidname() {
		return hidname;
	}
	public void setHidname(String hidname) {
		this.hidname = hidname;
	}
	public String getMsg() {
		return msg;  
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	int gridlength;
	
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getHotelid() {
		return hotelid;
	}
	public void setHotelid(String hotelid) { 
		this.hotelid = hotelid;
	}
	public String getRoomid() {
		return roomid;
	}
	public void setRoomid(String roomid) {
		this.roomid = roomid;
	}
	public String getTxtroom() {
		return txtroom;
	}
	public void setTxtroom(String txtroom) {
		this.txtroom = txtroom;
	}
	public String getTxtclienttype() {
		return txtclienttype;
	}
	public void setTxtclienttype(String txtclienttype) {
		this.txtclienttype = txtclienttype;
	}
	
	public String getTxtclient() {
		return txtclient;
	}
	public void setTxtclient(String txtclient) {   
		this.txtclient = txtclient;
	}
	public String getTxtmob() {
		return txtmob;
	}
	public void setTxtmob(String txtmob) {
		this.txtmob = txtmob;
	}
	public String getTxtemail() {
		return txtemail;
	}
	public void setTxtemail(String txtemail) {
		this.txtemail = txtemail;
	}
	public String getTxtpax() {
		return txtpax;
	}
	public void setTxtpax(String txtpax) {
		this.txtpax = txtpax;
	}
	public String getTxtchild() {
		return txtchild;
	}
	public void setTxtchild(String txtchild) {
		this.txtchild = txtchild;
	}
	public String getTxtage1() {
		return txtage1;
	}
	public void setTxtage1(String txtage1) {
		this.txtage1 = txtage1;
	}
	public String getTxtage2() { 
		return txtage2;
	}
	public void setTxtage2(String txtage2) {
		this.txtage2 = txtage2;
	}
	public String getTxtage3() {
		return txtage3;
	}
	public void setTxtage3(String txtage3) {
		this.txtage3 = txtage3;
	}
	public String getTxtage4() {
		return txtage4;
	}
	public void setTxtage4(String txtage4) {
		this.txtage4 = txtage4;
	}
	public String getTxtage5() {
		return txtage5;
	}
	public void setTxtage5(String txtage5) {
		this.txtage5 = txtage5;
	}
	public String getTxtage6() {
		return txtage6;
	}
	public void setTxtage6(String txtage6) {
		this.txtage6 = txtage6;
	}
	public String getFromdate() {
		return fromdate;
	}
	public void setFromdate(String fromdate) {
		this.fromdate = fromdate;
	}
	public String getTodate() {
		return todate;
	}
	public void setTodate(String todate) {
		this.todate = todate;
	}
	public String getCmblocation() {
		return cmblocation;
	}
	public void setCmblocation(String cmblocation) {
		this.cmblocation = cmblocation;
	}
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		java.sql.Date sqlStartDate = null;
		java.sql.Date sqlEndDate = null;
		if(getFromdate()!=null){       
			sqlStartDate=com.changeStringtoSqlDate(getFromdate());
		}
		if(getTodate()!=null){                  
			sqlEndDate=com.changeStringtoSqlDate(getTodate());  
		}
		String mode=getMode();
		String str="";
		//System.out.println(mode);  
        if(mode.equalsIgnoreCase("A")){      
			//System.out.println("in action ====");
			ArrayList<String> termarray= new ArrayList<>();   
			for(int i=0;i<getGridlength();i++){     
				String temp=requestParams.get("test"+i)[0];            
				termarray.add(temp);
			}
			int val=DAO.insert(sqlStartDate,sqlEndDate,getHidclient(),getTxtroom(),getTxtclienttype(),getHidname(),getTxtclient(),getTxtmob(),getTxtemail(),getTxtpax(),getTxtchild(),getTxtage1(),getTxtage2(),getTxtage3(),getTxtage4(),getTxtage5(),getTxtage6(),getCmblocation(),termarray,session,request,mode);       
			if(val>0){ 
				setTxtroom(str);
				setTxtpax(str);
				setTxtchild(str); 
				setTxtage1(str);setTxtage2(str);setTxtage3(str);setTxtage4(str);setTxtage5(str);setTxtage6(str);       
				setMsg("Successfully Saved");            
				return "success";
			}
			else{
			    setMsg("Not Saved");
				return "fail";
			}	
		}    
		return "fail";	    
	}    

}
