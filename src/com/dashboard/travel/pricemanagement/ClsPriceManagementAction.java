package com.dashboard.travel.pricemanagement;

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
public class ClsPriceManagementAction extends ActionSupport{   
	ClsPriceManagementDAO DAO= new ClsPriceManagementDAO();        
	ClsConnection conobj=new ClsConnection();
	ClsCommon com=new ClsCommon();             
	private String cmbtaxtype,mode,msg,hidcmbtaxtype;     
	private String detail;
	private String detailname;  
	
	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getDetailname() {
		return detailname;
	}

	public void setDetailname(String detailname) {
		this.detailname = detailname;
	}

	private int gridlength,docno;   
	
	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;  
	}

	public String getCmbtaxtype() {
		return cmbtaxtype;
	}

	public void setCmbtaxtype(String cmbtaxtype) {
		this.cmbtaxtype = cmbtaxtype;
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

	public String getHidcmbtaxtype() {
		return hidcmbtaxtype;
	}

	public void setHidcmbtaxtype(String hidcmbtaxtype) {
		this.hidcmbtaxtype = hidcmbtaxtype;
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
			ArrayList<String> termarray= new ArrayList<>();   
			for(int i=0;i<getGridlength();i++){     
				String temp=requestParams.get("test"+i)[0];            
				termarray.add(temp);
			}     
			int val=DAO.insert(getDocno(),getCmbtaxtype(),termarray,session,request,mode);       
			System.out.println("in action ===="+val);
			if(val>0){ 
				 setDetail("Travel");
			    setDetailname("Tour Price Management");
				setHidcmbtaxtype(getCmbtaxtype());     
				setMsg("Successfully Saved");            
				return "success";
			}
			else{   
				setDetail("Travel");
			    setDetailname("Tour Price Management");   
				setHidcmbtaxtype(getCmbtaxtype()); 
			    setMsg("Not Saved");  
				return "fail";
			}	
		}    
		return "fail";	    
	}    

}
