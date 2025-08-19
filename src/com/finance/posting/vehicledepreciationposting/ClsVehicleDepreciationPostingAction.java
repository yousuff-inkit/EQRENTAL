package com.finance.posting.vehicledepreciationposting;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsVehicleDepreciationPostingAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsVehicleDepreciationPostingDAO vehicleDepreciationPostingDAO= new ClsVehicleDepreciationPostingDAO();
	ClsVehicleDepreciationPostingBean vehicleDepreciationPostingBean;

	private String formdetailcode,vehdetposting,vehdetarray;
	private String mode;
	private String deleted;
	private String msg;
	private String brchName;
	
	private String jqxVehDepreciationPostingDate;
	private String hidjqxVehDepreciationPostingDate;
	private int txtjvno;
	private double txtdeprtotal;
	private double txtdrtotal;
	private double txtcrtotal;
	private int txttrno;
	
	//Vehicle Details Grid 
	private int gridlength;
	
	//Account Details Grid
	private int journalgridlength;
	
	private String url;
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblpobox;
	private String lblprintname;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lblservicetax;
	private String lblpan;
	private String lblcstno;
	
	private String lblvoucherno;
	private String lbldate;
	private String lblnetamount;
	private String lblnetamountwords;
	private String lbldebittotal;
	private String lblcredittotal;
	private String lbldepreciationtotal;
	private String lblpreparedby;
	private String lblpreparedon;
	private String lblpreparedat;

	//for hide
	private int firstarray;
	private int secarray;
	private int txtheader;
	
	public String getVehdetarray() {
		return vehdetarray;
	}

	public void setVehdetarray(String vehdetarray) {
		this.vehdetarray = vehdetarray;
	}

	public String getVehdetposting() {
		return vehdetposting;
	}

	public void setVehdetposting(String vehdetposting) {
		this.vehdetposting = vehdetposting;
	}
	
	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
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

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getBrchName() {
		return brchName;
	}

	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}

	public String getJqxVehDepreciationPostingDate() {
		return jqxVehDepreciationPostingDate;
	}

	public void setJqxVehDepreciationPostingDate(
			String jqxVehDepreciationPostingDate) {
		this.jqxVehDepreciationPostingDate = jqxVehDepreciationPostingDate;
	}

	public String getHidjqxVehDepreciationPostingDate() {
		return hidjqxVehDepreciationPostingDate;
	}

	public void setHidjqxVehDepreciationPostingDate(
			String hidjqxVehDepreciationPostingDate) {
		this.hidjqxVehDepreciationPostingDate = hidjqxVehDepreciationPostingDate;
	}

	public int getTxtjvno() {
		return txtjvno;
	}

	public void setTxtjvno(int txtjvno) {
		this.txtjvno = txtjvno;
	}

	public double getTxtdeprtotal() {
		return txtdeprtotal;
	}

	public void setTxtdeprtotal(double txtdeprtotal) {
		this.txtdeprtotal = txtdeprtotal;
	}

	public double getTxtdrtotal() {
		return txtdrtotal;
	}

	public void setTxtdrtotal(double txtdrtotal) {
		this.txtdrtotal = txtdrtotal;
	}

	public double getTxtcrtotal() {
		return txtcrtotal;
	}

	public void setTxtcrtotal(double txtcrtotal) {
		this.txtcrtotal = txtcrtotal;
	}

	public int getTxttrno() {
		return txttrno;
	}

	public void setTxttrno(int txttrno) {
		this.txttrno = txttrno;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	public int getJournalgridlength() {
		return journalgridlength;
	}

	public void setJournalgridlength(int journalgridlength) {
		this.journalgridlength = journalgridlength;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getLblcompname() {
		return lblcompname;
	}

	public void setLblcompname(String lblcompname) {
		this.lblcompname = lblcompname;
	}

	public String getLblcompaddress() {
		return lblcompaddress;
	}

	public void setLblcompaddress(String lblcompaddress) {
		this.lblcompaddress = lblcompaddress;
	}

	public String getLblpobox() {
		return lblpobox;
	}

	public void setLblpobox(String lblpobox) {
		this.lblpobox = lblpobox;
	}

	public String getLblprintname() {
		return lblprintname;
	}

	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}

	public String getLblcomptel() {
		return lblcomptel;
	}

	public void setLblcomptel(String lblcomptel) {
		this.lblcomptel = lblcomptel;
	}

	public String getLblcompfax() {
		return lblcompfax;
	}

	public void setLblcompfax(String lblcompfax) {
		this.lblcompfax = lblcompfax;
	}

	public String getLblbranch() {
		return lblbranch;
	}

	public void setLblbranch(String lblbranch) {
		this.lblbranch = lblbranch;
	}

	public String getLbllocation() {
		return lbllocation;
	}

	public void setLbllocation(String lbllocation) {
		this.lbllocation = lbllocation;
	}

	public String getLblservicetax() {
		return lblservicetax;
	}

	public void setLblservicetax(String lblservicetax) {
		this.lblservicetax = lblservicetax;
	}

	public String getLblpan() {
		return lblpan;
	}

	public void setLblpan(String lblpan) {
		this.lblpan = lblpan;
	}

	public String getLblcstno() {
		return lblcstno;
	}

	public void setLblcstno(String lblcstno) {
		this.lblcstno = lblcstno;
	}

	public String getLblvoucherno() {
		return lblvoucherno;
	}

	public void setLblvoucherno(String lblvoucherno) {
		this.lblvoucherno = lblvoucherno;
	}

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}

	public String getLblnetamount() {
		return lblnetamount;
	}

	public void setLblnetamount(String lblnetamount) {
		this.lblnetamount = lblnetamount;
	}

	public String getLblnetamountwords() {
		return lblnetamountwords;
	}

	public void setLblnetamountwords(String lblnetamountwords) {
		this.lblnetamountwords = lblnetamountwords;
	}

	public String getLbldebittotal() {
		return lbldebittotal;
	}

	public void setLbldebittotal(String lbldebittotal) {
		this.lbldebittotal = lbldebittotal;
	}

	public String getLblcredittotal() {
		return lblcredittotal;
	}

	public void setLblcredittotal(String lblcredittotal) {
		this.lblcredittotal = lblcredittotal;
	}

	public String getLbldepreciationtotal() {
		return lbldepreciationtotal;
	}

	public void setLbldepreciationtotal(String lbldepreciationtotal) {
		this.lbldepreciationtotal = lbldepreciationtotal;
	}

	public String getLblpreparedby() {
		return lblpreparedby;
	}

	public void setLblpreparedby(String lblpreparedby) {
		this.lblpreparedby = lblpreparedby;
	}

	public String getLblpreparedon() {
		return lblpreparedon;
	}

	public void setLblpreparedon(String lblpreparedon) {
		this.lblpreparedon = lblpreparedon;
	}

	public String getLblpreparedat() {
		return lblpreparedat;
	}

	public void setLblpreparedat(String lblpreparedat) {
		this.lblpreparedat = lblpreparedat;
	}

	public int getFirstarray() {
		return firstarray;
	}

	public void setFirstarray(int firstarray) {
		this.firstarray = firstarray;
	}

	public int getSecarray() {
		return secarray;
	}

	public void setSecarray(int secarray) {
		this.secarray = secarray;
	}

	public int getTxtheader() {
		return txtheader;
	}

	public void setTxtheader(int txtheader) {
		this.txtheader = txtheader;
	}
	
	java.sql.Date vehDepreciationDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsVehicleDepreciationPostingBean bean = new ClsVehicleDepreciationPostingBean();
		vehDepreciationDate = commonDAO.changeStringtoSqlDate(getJqxVehDepreciationPostingDate());
		
		if(mode.equalsIgnoreCase("A")){
			
			/*Vehicle Details Grid*/
			ArrayList<String> vehicledetailsarray= new ArrayList<>();
			    if(getGridlength()>0){
				String temp[]=requestParams.get("vehdetarray");
				System.out.println("========vehiclearray========="+temp.toString());
				
				String tmp=temp[0];
				String tmp2[]=tmp.split(",");
				for(int i=0;i<getGridlength();i++){			
					vehicledetailsarray.add(tmp2[i]);
				} 
			    }
			
			/*Vehicle Details Grid Ends*/
			
			/*Journal Voucher Grid*/
			ArrayList<String> journalvouchersarray= new ArrayList<>();
			for(int i=0;i<getJournalgridlength();i++){
				ClsVehicleDepreciationPostingBean vehicleDepreciationPostingBean=new ClsVehicleDepreciationPostingBean();
				String temp1=requestParams.get("journal"+i)[0];
				journalvouchersarray.add(temp1);
			}
			/*Journal Voucher Grid Ends*/
			
						int val=vehicleDepreciationPostingDAO.insert(getFormdetailcode(),getBrchName(),vehDepreciationDate,getTxtdeprtotal(),vehicledetailsarray,journalvouchersarray,session,request,mode);
						if(val>0.0){
							setTxtjvno(val);
							setHidjqxVehDepreciationPostingDate(vehDepreciationDate.toString());
							setTxttrno(Integer.parseInt(request.getAttribute("tranno").toString()));
							setData();
							
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setData();
							setHidjqxVehDepreciationPostingDate(vehDepreciationDate.toString());
							
							setMsg("Not Saved");
							return "fail";
						}	
		}
		return "fail";
	}
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int header=Integer.parseInt(request.getParameter("header"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		vehicleDepreciationPostingBean=vehicleDepreciationPostingDAO.getPrint(request,docno,branch,header);
		
		setUrl(commonDAO.getPrintPath("VDP"));
		setLblcompname(vehicleDepreciationPostingBean.getLblcompname());
		setLblcompaddress(vehicleDepreciationPostingBean.getLblcompaddress());
		setLblpobox(vehicleDepreciationPostingBean.getLblpobox());
		setLblprintname(vehicleDepreciationPostingBean.getLblprintname());
		setLblcomptel(vehicleDepreciationPostingBean.getLblcomptel());
		setLblcompfax(vehicleDepreciationPostingBean.getLblcompfax());
		setLblbranch(vehicleDepreciationPostingBean.getLblbranch());
		setLbllocation(vehicleDepreciationPostingBean.getLbllocation());
		setLblservicetax(vehicleDepreciationPostingBean.getLblservicetax());
		setLblpan(vehicleDepreciationPostingBean.getLblpan());
		setLblcstno(vehicleDepreciationPostingBean.getLblcstno());
		setLblvoucherno(vehicleDepreciationPostingBean.getLblvoucherno());
		setLbldate(vehicleDepreciationPostingBean.getLbldate());
		setLblnetamount(vehicleDepreciationPostingBean.getLblnetamount());
		setLblnetamountwords(vehicleDepreciationPostingBean.getLblnetamountwords());
		setLbldebittotal(vehicleDepreciationPostingBean.getLbldebittotal());
		setLblcredittotal(vehicleDepreciationPostingBean.getLblcredittotal());
		setLbldepreciationtotal(vehicleDepreciationPostingBean.getLbldepreciationtotal());
		setLblpreparedby(vehicleDepreciationPostingBean.getLblpreparedby());
		setLblpreparedon(vehicleDepreciationPostingBean.getLblpreparedon());
		setLblpreparedat(vehicleDepreciationPostingBean.getLblpreparedat());
		
		// for hide
		setFirstarray(vehicleDepreciationPostingBean.getFirstarray());
		setSecarray(vehicleDepreciationPostingBean.getSecarray());
		setTxtheader(vehicleDepreciationPostingBean.getTxtheader());
	
		return "print";
	}
	
	public void setData(){
		setTxtdeprtotal(getTxtdeprtotal());
		setTxtdrtotal(getTxtdrtotal());
		setTxtcrtotal(getTxtcrtotal());
	}

	
	
}


