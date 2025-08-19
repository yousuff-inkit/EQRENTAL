package com.dashboard.limousine.importdata;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.limousine.limobooking.ClsLimoBookingDAO;

public class ClsLimoImportDataAction {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsLimoImportDataDAO objimportdata=new ClsLimoImportDataDAO();
	private String mode;
	private String msg;
	private String cmbbranch;
	private String detail;
	private String detailname;
	private String fromdate;
	private String todate;
	private String cldocno;
	private String docno;
	private String bookdocno;
	private String gridarray;
	private String limobookvocno;
	
	
	public String getLimobookvocno() {
		return limobookvocno;
	}
	public void setLimobookvocno(String limobookvocno) {
		this.limobookvocno = limobookvocno;
	}
	public String getGridarray() {
		return gridarray;
	}
	public void setGridarray(String gridarray) {
		this.gridarray = gridarray;
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
	public String getCmbbranch() {
		return cmbbranch;
	}
	public void setCmbbranch(String cmbbranch) {
		this.cmbbranch = cmbbranch;
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
	public String getFromdate() {
		return fromdate;
	}
	public void setFromdate(String fromdate) {
		this.fromdate = fromdate;
	}
	public String getTodate() {
		return todate;
	}
	public void setTodate(String todate) {
		this.todate = todate;
	}
	public String getCldocno() {
		return cldocno;
	}
	public void setCldocno(String cldocno) {
		this.cldocno = cldocno;
	}
	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}
	public String getBookdocno() {
		return bookdocno;
	}
	public void setBookdocno(String bookdocno) {
		this.bookdocno = bookdocno;
	}
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		try{
			int errorstatus=0;
			if(getMode().equalsIgnoreCase("A")){
				ArrayList<String> basetransferarray=new ArrayList();
				for(int i=0;i<getGridarray().split(",").length;i++){
					basetransferarray.add(getGridarray().split(",")[i].trim());
				}
				String createBooking=objimportdata.createLimoBooking(basetransferarray,getDocno(),session,request);
				errorstatus=Integer.parseInt(createBooking.split("::")[0]);
				if(errorstatus==1){
					setDetail("Limo");
					setDetailname("Import Data");
					setMsg("Not Saved");
					setLimobookvocno("0");
					return "fail";
				}
				else{
					setDetail("Limo");
					setDetailname("Import Data");
					setMsg("Saved Successfully");
					setLimobookvocno(createBooking.split("::")[1]);
					return "success";
				}

			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
		}

}
