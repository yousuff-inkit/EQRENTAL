package com.dashboard.travel.refundrequestmanagement;

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
public class ClsRefundRequestManagementAction extends ActionSupport{ 
	ClsRefundRequestManagementDAO DAO=new ClsRefundRequestManagementDAO();
	ClsConnection conobj=new ClsConnection();   
	ClsCommon com=new ClsCommon();             
	private String mode,msg;  
	private int gridlength,rrdocno,cmbbranch,hidcmbbranch,reftype;         
	public int getReftype() {
		return reftype;
	}
	public void setReftype(int reftype) {
		this.reftype = reftype;
	}
	public int getHidcmbbranch() {
		return hidcmbbranch;
	}
	public void setHidcmbbranch(int hidcmbbranch) {
		this.hidcmbbranch = hidcmbbranch;
	}
	public int getCmbbranch() {
		return cmbbranch;
	}
	public void setCmbbranch(int cmbbranch) {
		this.cmbbranch = cmbbranch;
	}
	public int getRrdocno() {
		return rrdocno;
	}
	public void setRrdocno(int rrdocno) {
		this.rrdocno = rrdocno;
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
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {  
		this.gridlength = gridlength;
	}

	public String saveAction() throws ParseException, SQLException{   
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();  
		String mode=getMode();
		String str="";
		System.out.println(mode);  
        if(mode.equalsIgnoreCase("A")){ 
        	//System.out.println(mode+"in action ===="+getGridlength());
			ArrayList<String> termarray= new ArrayList<>();   
			for(int i=0;i<getGridlength();i++){     
				String temp=requestParams.get("test"+i)[0];            
				termarray.add(temp);
			} 
			int val=DAO.insert(getRrdocno(),getCmbbranch(),termarray,session,request,mode);            
			//System.out.println("in action ===="+val);
			if(val>0){  
				//setRrdocno(getRrdocno());
				setHidcmbbranch(getCmbbranch());
				//setReftype(getReftype());
				setMode("VIEW");
				setGridlength(0);      
				setMsg("Successfully Saved");            
				return "success";
			}
			else{   
				//setRrdocno(getRrdocno());
				setHidcmbbranch(getCmbbranch());
				//setReftype(getReftype());
				setMode("VIEW");
			    setMsg("Not Saved");  
				return "fail";
			}	
		}    
		return "fail";	    
	}    

}
