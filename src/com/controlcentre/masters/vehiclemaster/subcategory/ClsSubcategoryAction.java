package com.controlcentre.masters.vehiclemaster.subcategory;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.common.ClsCommon;
import com.controlcentre.masters.vehiclemaster.platecode.ClsPlateCodeBean;

@SuppressWarnings("serial")
public class ClsSubcategoryAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	ClsSubcategoryDAO subcategoryDAO= new ClsSubcategoryDAO();
	ClsSubcategoryBean bean;
private int docno;
private String mode;
private String deleted;
private String name; 
private String subcategorydate; 

private String catname;
private String catid;
private String code;

private String msg;
private String formdetailcode;
private String formdetail;
private String chkstatus;

public String getSubcategorydate() {
	return subcategorydate;
}
public void setSubcategorydate(String Subcategorydate) {
	this.subcategorydate = Subcategorydate;
}
public String getChkstatus() {
	return chkstatus;
}
public void setChkstatus(String chkstatus) {
	this.chkstatus = chkstatus;
}
public String getFormdetailcode() {
	return formdetailcode;
}
public void setFormdetailcode(String formdetailcode) {
	this.formdetailcode = formdetailcode;
}
public String getFormdetail() {
	return formdetail;
}
public void setFormdetail(String formdetail) {
	this.formdetail = formdetail;
}
public String getMsg() {
	return msg;
}
public void setMsg(String msg) {
	this.msg = msg;
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
public String getCatname() {
	return catname;
}
public void setCatname(String catname) {
	this.catname = catname;
}
public String getCatid() {
	return catid;
}
public void setCatid(String catid) {
	this.catid = catid;
}
public String saveAction() throws ParseException, SQLException{
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
//	System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getSubcategorydate());

	session.getAttribute("BranchName");
//	System.out.println("sessoin"+session.getAttribute("BRANCHSELECTED"));
//	System.out.println("sessoin"+session.getAttribute("COMPANYNAME"));
	//System.out.println("request==="+request.getAttribute("BranchName"));
	
	String mode=getMode();
	ClsSubcategoryBean subcategorybean=new ClsSubcategoryBean();
//	String startDate=getDate_brand();
//	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
//	java.util.Date date = sdf1.parse(startDate);
//	java.sql.Date sqlStartDate = new java.sql.Date(date.getTime()); 
	
//	Date trail=getDate_plateCode();
	java.sql.Date sqlStartDate=null;
	if((mode.equalsIgnoreCase("A"))||(mode.equalsIgnoreCase("E"))){
		sqlStartDate = ClsCommon.changeStringtoSqlDate(getSubcategorydate());

	}
//	System.out.println(sqlStartDate);
	if(mode.equalsIgnoreCase("A")){
					int val=subcategoryDAO.insert(getName(),getCatname(),sqlStartDate,session,getMode(),getFormdetailcode(),getCode());
					if(val>0.0){
						setName(getName());
						setCatid(getCatname());
						setCatname(getCatname());
						setSubcategorydate(sqlStartDate.toString());
						setMode(getMode());
//						System.out.println(val); 
						setDocno(val);
						setMsg("Successfully Saved");
						return "success";
					}
					else if(val==-1){
						setName(getName());
						setCatid(getCatname());
						setCatname(getCatname());
						setSubcategorydate(sqlStartDate.toString());
						setMode(getMode());
//						System.out.println(val);
						//setDocno(val);
						setChkstatus("1");
						setMsg("Subcategory Already Exists");
						return "fail";
					}
					else{
						setName(getName());
						setCatid(getCatname());
						setCatname(getCatname());
						setSubcategorydate(sqlStartDate.toString());
						setMode(getMode());
//						System.out.println(val);
						setDocno(val);
						setMsg("Not Saved");
						return "fail";
					}
	}


	else if(mode.equalsIgnoreCase("E")){
			int Status=subcategoryDAO.edit(getName(),getDocno(),sqlStartDate,getCatname(),getMode(),session,getFormdetailcode(),getCode());
			if(Status>0){
				
				setName(getName());
				setSubcategorydate(getSubcategorydate());
				setDocno(getDocno());
				setCatid(getCatname());
				setCatname(getCatname());

//				System.out.println("Action"+getBrandid());
				setMode(getMode());
				setMsg("Updated Successfully");

				return "success";
			}
			else if(Status==-1){
				setName(getName());
				setSubcategorydate(getSubcategorydate());
				setDocno(getDocno());
				setCatid(getCatname());
				setCatname(getCatname());

//				System.out.println("Action"+getBrandid());
				//setMode(getMode());
				setChkstatus("2");
				setMsg("Subcategory Already Exists");
				return "fail";
			}
			else{
				setName(getName());
				setSubcategorydate(getSubcategorydate());
				setDocno(getDocno());
				setCatid(getCatname());
				setCatname(getCatname());

//				System.out.println("Action"+getBrandid());
				setMode(getMode());
				setMsg("Not Updated");

				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
//			System.out.println(getDocno()+","+getBrandid()+","+getSubcategorydate());
			int Status=subcategoryDAO.delete(getName(),getDocno(),sqlStartDate,getCatname(),getMode(),session,getFormdetailcode(),getCode());
		if(Status>0){
			setName(getName());
			setSubcategorydate(getSubcategorydate());
			setDocno(getDocno());
			setCatid(getCatname());
			setCatname(getCatname());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");

			return "success";
		}
		else if(Status==-2){
			setName(getName());
			setSubcategorydate(getSubcategorydate());
			setDocno(getDocno());
			setCatid(getCatname());
			setCatname(getCatname());
			setMsg("References Present in Other Documents");
			return "fail";
		}
		else{
			setName(getName());
			setSubcategorydate(getSubcategorydate());
			setDocno(getDocno());
			setCatid(getCatname());
			setCatname(getCatname());
			setMsg("Not Deleted");

			return "fail";
		}
		}
		return "fail";
	}

	public String getDeleted() {
	return deleted;
}
public void setDeleted(String deleted) {
	this.deleted = deleted;
}
	public  JSONArray searchDetails(){
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsSubcategoryBean> list= subcategoryDAO.list();
			  for(ClsSubcategoryBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("doc_no", bean.getDocno());
			  cellobj.put("name",bean.getName());
			  cellobj.put("date",((bean.getSubcategorydate()==null) ? "NA" : bean.getSubcategorydate().toString()));
			  cellobj.put("catname",bean.getCatname());
			  cellobj.put("catid",bean.getCatid());
			  cellobj.put("code",bean.getCode());

			  cellarray.add(cellobj);

			 }
//				 System.out.println("cellobj"+cellarray);
		  } catch (SQLException e) {
		  }
		return cellarray;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
