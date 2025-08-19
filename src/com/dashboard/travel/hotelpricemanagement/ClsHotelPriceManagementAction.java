package com.dashboard.travel.hotelpricemanagement;

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
public class ClsHotelPriceManagementAction extends ActionSupport{   
	ClsHotelPriceManagementDAO DAO= new ClsHotelPriceManagementDAO();        
	ClsConnection conobj=new ClsConnection();
	ClsCommon com=new ClsCommon();             
	private String mode,msg;     
	private String detail;
	private String detailname;  
	private int gridlength,docno,instgridlength,hidhotel;  
	
	public int getHidhotel() {
		return hidhotel;
	}

	public void setHidhotel(int hidhotel) {
		this.hidhotel = hidhotel;
	}

	public int getInstgridlength() {
		return instgridlength;
	}

	public void setInstgridlength(int instgridlength) {
		this.instgridlength = instgridlength;
	}

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
			ArrayList<String> instarray= new ArrayList<>();   
			for(int i=0;i<getInstgridlength();i++){        
				String temp2=requestParams.get("inst"+i)[0];            
				instarray.add(temp2);     
			} 
			int val=DAO.insert(getDocno(),getHidhotel(),termarray,instarray,session,request,mode);       
			System.out.println("in action ===="+val);
			if(val>0){ 
				 setDetail("Travel");      
			    setDetailname("Hotel Price Management");
				setMsg("Successfully Saved");            
				return "success";
			}
			else{   
				setDetail("Travel");
			    setDetailname("Hotel Price Management");   
			    setMsg("Not Saved");  
				return "fail";
			}	
		}    
		return "fail";	    
	}    

}
