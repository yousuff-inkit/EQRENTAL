package com.controlcentre.masters.vehiclemaster.category;

import java.util.*;

public class ClsCategoryBean {
	
	 private String category;
	 private String txtcode;
	 private Date date_category;
	 private double docno;
	public Date getDate_category() {
		return date_category;
	}
	public void setDate_category(Date date_category) {
		this.date_category = date_category;
	}
	public double  getDocno() {
		return docno;
	}
	public void setDocno(double d) {
		this.docno = d;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTxtcode() {
		return txtcode;
	}
	public void setTxtcode(String txtcode) {
		this.txtcode = txtcode;
	}
	
	}
