package com.operations.commtransactions.refundrequest;

import java.util.*;

public class ClsRefundRequestBean {       
	private int docno,tourgridlenght,masterdoc_no;  
	private String brchName,travelDate,hidtravelDate,cmbreftype,refdocno,txtremarks,refno,txtclientname;
	public String getRefno() {
		return refno;
	}
	public void setRefno(String refno) {
		this.refno = refno;
	}
	public String getTxtclientname() {
		return txtclientname;
	}
	public void setTxtclientname(String txtclientname) {
		this.txtclientname = txtclientname;
	}
	private String msg,mode,formdetailcode,deleted,hidreftype;  
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	public String getRefdocno() {
		return refdocno;
	}
	public void setRefdocno(String refdocno) {
		this.refdocno = refdocno;
	}
	public String getHidreftype() {
		return hidreftype;
	}
	public void setHidreftype(String hidreftype) {
		this.hidreftype = hidreftype;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public int getTourgridlenght() {
		return tourgridlenght;
	}
	public void setTourgridlenght(int tourgridlenght) {
		this.tourgridlenght = tourgridlenght;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public String getTravelDate() {
		return travelDate;
	}
	public void setTravelDate(String travelDate) {
		this.travelDate = travelDate;
	}
	public String getHidtravelDate() {
		return hidtravelDate;
	}
	public void setHidtravelDate(String hidtravelDate) {
		this.hidtravelDate = hidtravelDate;
	}
	public String getCmbreftype() {
		return cmbreftype;
	}
	public void setCmbreftype(String cmbreftype) {
		this.cmbreftype = cmbreftype;
	}
	public String getTxtremarks() {
		return txtremarks;
	}
	public void setTxtremarks(String txtremarks) {
		this.txtremarks = txtremarks;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}   
}