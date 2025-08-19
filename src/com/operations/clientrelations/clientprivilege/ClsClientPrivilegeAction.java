package com.operations.clientrelations.clientprivilege;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsClientPrivilegeAction extends ActionSupport {
	ClsCommon ClsCommon=new ClsCommon();
	ClsClientPrivilegeDAO serviceDAO= new ClsClientPrivilegeDAO();
	ClsClientPrivilegeBean bean;

	private int docno;
	private String privilege;
	private String percentage;
	
	
	private String mode;
	private String deleted;
	
	private String msg;
	private String formdetailcode;
	private String formdetail;
	private String chkstatus;
	
	
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
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
	
	
	
	
	
	
	public String getPercentage() {
		return percentage;
	}
	public void setPercentage(String percentage) {
		this.percentage = percentage;
	}
	public String getPrivilege() {
		return privilege;
	}
	public void setPrivilege(String privilege) {
		this.privilege = privilege;
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

	public String saveAction() throws ParseException, SQLException{
		System.out.println("*** ACTION *****");
		
	    HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		
		if(mode.equalsIgnoreCase("A")){
						int val=serviceDAO.insert(getPrivilege(),getPercentage(), session,getMode(),getFormdetailcode());
						System.out.println(val);
						if(val>0){
							
							setPrivilege(getPrivilege());
							setPercentage(getPercentage());
							setMode(getMode());
						    setDocno(val);						    
						    setMsg("Successfully Saved");
							return "success";
						}
						else if(val==-1){
							setPrivilege(getPrivilege());
							setPercentage(getPercentage());
							setDocno(getDocno());
							setMode(getMode());							
							setChkstatus("1");
							setMsg("Privilege Already Exists.");
							return "fail";
						}
						else{
							setPrivilege(getPrivilege());
							setPercentage(getPercentage());
							setMode(getMode());
						    setDocno(val);							
						    setMsg("Not Saved");
							return "fail";
						}	
		}

		else if(mode.equalsIgnoreCase("E")){
				int val=serviceDAO.edit(getPrivilege(),getPercentage(),session,getMode(),getDocno(),getFormdetailcode());
				
				if(val>0){
					
					//session.getAttribute("BranchName");
					setPrivilege(getPrivilege());
					setPercentage(getPercentage());
					setDocno(getDocno());
					setMode(getMode());
					
					setMsg("Updated Successfully");
					return "success";
				}
				else if(val==-1){
					setPrivilege(getPrivilege());
					setPercentage(getPercentage());
					setDocno(getDocno());
					setMode(getMode());
					
					setChkstatus("2");
					setMsg("Privilege Already Exists.");
					return "fail";
				}
				else{
					setPrivilege(getPrivilege());
					setPercentage(getPercentage());
					setDocno(getDocno());
					setMode(getMode());
					
					setMsg("Not Updated");
					return "fail";
				}
			}
	
			else if(mode.equalsIgnoreCase("D")){
				boolean Status=serviceDAO.delete(getPrivilege(),getPercentage(),session,getMode(),getDocno(),getFormdetailcode());
			if(Status){
				setPrivilege(getPrivilege());
				setPercentage(getPercentage());
				setDocno(getDocno());
				setMode(getMode());
				
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				
				setPrivilege(getPrivilege());
				setPercentage(getPercentage());
				setDocno(getDocno());
				setMode(getMode());
				
				setMsg("Not Deleted");
				return "fail";
			}
			}
		return "fail";
	}
}
