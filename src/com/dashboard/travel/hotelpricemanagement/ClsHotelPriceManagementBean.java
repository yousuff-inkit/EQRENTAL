package com.dashboard.travel.hotelpricemanagement;

public class ClsHotelPriceManagementBean {    
	private String mode,msg;  
	private int gridlength,instgridlength,hidhotel;     
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