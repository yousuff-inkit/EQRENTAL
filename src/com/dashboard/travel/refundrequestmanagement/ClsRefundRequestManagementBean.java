package com.dashboard.travel.refundrequestmanagement;

public class ClsRefundRequestManagementBean {    
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
	
}