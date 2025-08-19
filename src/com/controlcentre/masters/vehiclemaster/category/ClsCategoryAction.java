package com.controlcentre.masters.vehiclemaster.category;

import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.common.ClsCommon;

@SuppressWarnings("serial")
public class ClsCategoryAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();

	ClsCategoryDAO categoryDAO= new ClsCategoryDAO();
	private int docno;
	private String category;
	private String date_category;
	private String txtcode;
	private String mode;
	private String deleted;
	private Date datehidden;
	 private String msg;
	 private String formdetail;
	 private String formdetailcode;
	 private String chkstatus;
	 
	 
	 public String getChkstatus() {
		return chkstatus;
	}
	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	 public String getDate_category() {
		return date_category;
	}
	public void setDate_category(String date_category) {
		this.date_category = date_category;
	}
	public int  getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public Date getDatehidden() {
		return datehidden;
	}
	public void setDatehidden(Date datehidden) {
		this.datehidden = datehidden;
	}


	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		
		String mode=getMode();
		ClsCategoryBean bean;

		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getDate_category());
//		System.out.println("date"+sqlStartDate);
//		System.out.println(getMode());
		if(mode.equalsIgnoreCase("A")){
		//	System.out.println("date---"+sqlStartDate);
						int val=categoryDAO.insert(sqlStartDate,getCategory(),getMode(),session,getFormdetailcode(),getTxtcode());
						if(val>0){
							setDatehidden(sqlStartDate);
							setCategory(getCategory());
							setDocno(val);
							setTxtcode(getTxtcode());
							//session.setAttribute("SAVED", "SUCCESSFULLY SAVED");
							setMsg("Successfully Saved");
							addActionMessage("Saved Successfully");
//							System.out.println(session.getAttribute("SAVED"));
							return "success";
						}
						else if(val==-1){
							setDatehidden(sqlStartDate);
							setCategory(getCategory());
							setTxtcode(getTxtcode());
							setChkstatus("1");
							setMsg("Category Already Exists");
							//request.setAttribute("SAVED", "Not Saved");
							//addActionError("Not Saved");
							return "fail";
						}
						else{
							setDatehidden(sqlStartDate);
							setCategory(getCategory());
							setTxtcode(getTxtcode());
							setMsg("Not Saved");
							return "fail";
						}
		}
		else if(mode.equalsIgnoreCase("E")){
			int Status=categoryDAO.edit(getDocno(),(Date)sqlStartDate,getCategory(),session,getFormdetailcode(),getTxtcode());
			if(Status>0){
				setDatehidden(sqlStartDate);
				setCategory(getCategory());
				setDocno(getDocno());
				setTxtcode(getTxtcode());
				setMsg("Updated Successfully");
				return "success";
			}
			else if(Status==-1){
				setDatehidden(sqlStartDate);
				setCategory(getCategory());
				setDocno(getDocno());
				setTxtcode(getTxtcode());
				setChkstatus("2");

				setMsg("Category Already Exists");
				return "fail";

			}
			else{
				setDatehidden(sqlStartDate);
				setCategory(getCategory());
				setDocno(getDocno());
				setTxtcode(getTxtcode());
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			int Status=categoryDAO.delete(getDocno(),session,getCategory(),getFormdetailcode());
		if(Status>0){
			setDatehidden(sqlStartDate);
			setCategory(getCategory());
			setDocno(getDocno());
			setTxtcode(getTxtcode());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else if(Status==-2){
			setDatehidden(sqlStartDate);
			setCategory(getCategory());
			setDocno(getDocno());
			setTxtcode(getTxtcode());
			setMsg("References Present in Other Documents");
			return "fail";
		}
		else{
			setDatehidden(sqlStartDate);
			setCategory(getCategory());
			setDocno(getDocno());
			setTxtcode(getTxtcode());
			setMsg("Not Deleted");
			return "fail";
		}
		}
		return "fail";
	}

	public  JSONArray searchDetails(){
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsCategoryBean> list = categoryDAO.list();
			  for(ClsCategoryBean bean:list){
					  cellobj = new JSONObject();
					  cellobj.put("doc_no", bean.getDocno());
					  cellobj.put("name",bean.getCategory());
					  cellobj.put("date",((bean.getDate_category()==null) ? "NA" : bean.getDate_category().toString()));
					  cellobj.put("code",bean.getTxtcode());

					  cellarray.add(cellobj);
			 }
//				 System.out.println("cellobj"+cellarray);
		  } catch (SQLException e) {
		  }
		return cellarray;
	}
	
	public void validate(){
//		System.out.println("validdate");
		if(getDocno()==0){
//			System.out.println("validdate  sucess");
			addActionMessage("Got It");
		}
		else{
//			System.out.println("validdate  else");
			addActionError("Got error");
		}
	}
	public String getTxtcode() {
		return txtcode;
	}
	public void setTxtcode(String txtcode) {
		this.txtcode = txtcode;
	}
}
