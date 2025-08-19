package com.limousine.limobooking;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsLimoBookingAction {
	ClsCommon objcommon=new ClsCommon();
	ClsLimoBookingDAO bookingdao=new ClsLimoBookingDAO();
	private int docno;
	private String vocno;
	private String date;
	private String client;
	private String clientdetails;
	private String hidclient;
	private String guest;
	private String hidguest;
	private String chknewguest;
	private String hidchknewguest;
	private String mode;
	private String msg;
	private String deleted;
	private String guestcontactno;
	private String formdetailcode;
	private String brchName;
	private int transfergridlength;
	private int hoursgridlength;
	private int othersrvcgridlength;
	private int billinggridlength;
	private String description;
	private String txtairport;
	private String txtflightno;
	private String txthotelname;
	private String txtroomno;
	private String cmbloctype;
	private String cmbloc;
	
	
	
	public String getVocno() {
		return vocno;
	}

	public void setVocno(String vocno) {
		this.vocno = vocno;
	}

	public String getCmbloc() {
		return cmbloc;
	}

	public void setCmbloc(String cmbloc) {
		this.cmbloc = cmbloc;
	}
	
	public String getCmbloctype() {
		return cmbloctype;
	}

	public void setCmbloctype(String cmbloctype) {
		this.cmbloctype = cmbloctype;
	}
	
	public String getTxtairport() {
		return txtairport;
	}

	public void setTxtairport(String txtairport) {
		this.txtairport = txtairport;
	}

	public String getTxtflightno() {
		return txtflightno;
	}

	public void setTxtflightno(String txtflightno) {
		this.txtflightno = txtflightno;
	}

	public String getTxthotelname() {
		return txthotelname;
	}

	public void setTxthotelname(String txthotelname) {
		this.txthotelname = txthotelname;
	}

	public String getTxtroomno() {
		return txtroomno;
	}

	public void setTxtroomno(String txtroomno) {
		this.txtroomno = txtroomno;
	}
	
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getTransfergridlength() {
		return transfergridlength;
	}

	public void setTransfergridlength(int transfergridlength) {
		this.transfergridlength = transfergridlength;
	}

	public int getHoursgridlength() {
		return hoursgridlength;
	}

	public void setHoursgridlength(int hoursgridlength) {
		this.hoursgridlength = hoursgridlength;
	}

	public int getOthersrvcgridlength() {
		return othersrvcgridlength;
	}

	public void setOthersrvcgridlength(int othersrvcgridlength) {
		this.othersrvcgridlength = othersrvcgridlength;
	}

	public int getBillinggridlength() {
		return billinggridlength;
	}

	public void setBillinggridlength(int billinggridlength) {
		this.billinggridlength = billinggridlength;
	}

	public String getBrchName() {
		return brchName;
	}

	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getClientdetails() {
		return clientdetails;
	}

	public void setClientdetails(String clientdetails) {
		this.clientdetails = clientdetails;
	}

	public String getHidclient() {
		return hidclient;
	}

	public void setHidclient(String hidclient) {
		this.hidclient = hidclient;
	}

	public String getGuest() {
		return guest;
	}

	public void setGuest(String guest) {
		this.guest = guest;
	}

	public String getHidguest() {
		return hidguest;
	}

	public void setHidguest(String hidguest) {
		this.hidguest = hidguest;
	}

	public String getChknewguest() {
		return chknewguest;
	}

	public void setChknewguest(String chknewguest) {
		this.chknewguest = chknewguest;
	}

	public String getHidchknewguest() {
		return hidchknewguest;
	}

	public void setHidchknewguest(String hidchknewguest) {
		this.hidchknewguest = hidchknewguest;
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

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public String getGuestcontactno() {
		return guestcontactno;
	}

	public void setGuestcontactno(String guestcontactno) {
		this.guestcontactno = guestcontactno;
	}

	public void setValues(int docno,java.sql.Date sqldate,String vocno){
		setDocno(docno);
		setVocno(vocno);
		setDate(sqldate.toString());
		setClient(getClient());
		setHidclient(getHidclient());
		setClientdetails(getClientdetails());
		setGuest(getGuest());
		setHidguest(getHidguest());
		setHidchknewguest(getHidchknewguest());
		setDescription(getDescription());
		setTxtairport(getTxtairport());
		setTxtflightno(getTxtflightno());
		setTxthotelname(getTxthotelname());
		setTxtroomno(getTxtroomno());
		setCmbloctype(getCmbloctype());
		setCmbloc(getCmbloctype());
		
	}
	public String saveAction() throws SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		java.sql.Date sqldate=null;
		if(getDate()!=null){
			sqldate=objcommon.changeStringtoSqlDate(getDate());
		}
		ArrayList<String> transferarray=new ArrayList<>();
		ArrayList<String> hoursarray=new ArrayList<>();
		ArrayList<String> billarray=new ArrayList<>();
		ArrayList<String> newtransferarray=new ArrayList<>();
		ArrayList<String> newhoursarray=new ArrayList<>();
		if(mode.equalsIgnoreCase("A") || mode.equalsIgnoreCase("tarifinsert")){
		if(getTransfergridlength()>0){
			for(int i=0;i<getTransfergridlength();i++){
				String temp=requestParams.get("transfer"+i)[0];
				transferarray.add(temp);
			}
			int transferjobserial=1;
			for(int i=0;i<transferarray.size();i++){
				if(!transferarray.get(i).split("::")[9].equalsIgnoreCase("") && !transferarray.get(i).split("::")[9].equalsIgnoreCase("undefined") && transferarray.get(i).split("::")[9]!=null){
					for(int j=0;j<Integer.parseInt(transferarray.get(i).split("::")[9]);j++){
						String temp[]=transferarray.get(i).split("::");
						newtransferarray.add("T"+transferjobserial+"::"+temp[1]+"::"+temp[2]+"::"+temp[3]+"::"+temp[4]+"::"+temp[5]+"::"+temp[6]+"::"+temp[7]+"::"+temp[8]+"::"+1+"::"+temp[10]+"::"+temp[11]+"::"+temp[12]+"::"+temp[13]+"::"+temp[14]+"::"+temp[15]+"::"+temp[16]+"::"+temp[17]+"::"+temp[18]+"::"+temp[19]+"::"+temp[20]);
						System.out.println("T"+transferjobserial+"::"+temp[1]+"::"+temp[2]+"::"+temp[3]+"::"+temp[4]+"::"+temp[5]+"::"+temp[6]+"::"+temp[7]+"::"+temp[8]+"::"+1+"::"+temp[10]+"::"+temp[11]+"::"+temp[12]+"::"+temp[13]+"::"+temp[14]+"::"+temp[15]+"::"+temp[16]+"::"+temp[17]+"::"+temp[18]+"::"+temp[19]+"::"+temp[20]);
						transferjobserial++;
					}
				}
			}
		}
		if(getHoursgridlength()>0){
			for(int i=0;i<getHoursgridlength();i++){
				String temp=requestParams.get("hours"+i)[0];
				hoursarray.add(temp);
			}
			int hoursjobserial=1;
			for(int i=0;i<hoursarray.size();i++){
				System.out.println(hoursarray.get(i));
				String tempdays=hoursarray.get(i).split("::")[13];
				int days=0;
				if(tempdays.equalsIgnoreCase("") || tempdays.equalsIgnoreCase("undefined") || tempdays==null){
					days=1;
				}
				else if(Integer.parseInt(tempdays)==0 || Integer.parseInt(tempdays)==1){
					days=1;
				}
				else{
					days=Integer.parseInt(tempdays);
				}
				System.out.println("Inside First Loop");
				if(!hoursarray.get(i).split("::")[7].equalsIgnoreCase("") && !hoursarray.get(i).split("::")[7].equalsIgnoreCase("undefined") && hoursarray.get(i).split("::")[7]!=null){
				for(int j=0;j<Integer.parseInt(hoursarray.get(i).split("::")[7]);j++){
					
					String temppickupdate=hoursarray.get(i).split("::")[1];
					if(!temppickupdate.equalsIgnoreCase("") && temppickupdate!=null && !temppickupdate.equalsIgnoreCase("undefined")){
						System.out.println("Inside Second Loop");
						String strpickupdate="";
						System.out.println("days:"+days);
						for(int k=0;k<days;k++){
							System.out.println("Inside Third Loop");
							if(k==0){
								strpickupdate=bookingdao.getLimoDateAdd(temppickupdate,1);
								
							}
							else{
								strpickupdate=bookingdao.getLimoDateAdd(strpickupdate,2);
							}
							String temp[]=hoursarray.get(i).split("::");
							//System.out.println("L"+hoursjobserial+"::"+strpickupdate+"::"+temp[2]+"::"+temp[3]+"::"+temp[4]+"::"+temp[5]+"::"+temp[6]+"::"+"1"+"::"+temp[8]+"::"+temp[9]+"::"+temp[10]+"::"+temp[11]+"::"+temp[12]+"::"+temp[14]+"::"+temp[15]+"::"+temp[16]+"::"+temp[17]+"::"+temp[18]);
							newhoursarray.add("L"+hoursjobserial+"::"+strpickupdate+"::"+temp[2]+"::"+temp[3]+"::"+temp[4]+"::"+temp[5]+"::"+temp[6]+"::"+"1"+"::"+temp[8]+"::"+temp[9]+"::"+temp[10]+"::"+temp[11]+"::"+temp[12]+"::"+temp[14]+"::"+temp[15]+"::"+temp[16]+"::"+temp[17]+"::"+temp[18]);
							hoursjobserial++;
						}
					}	
				}
				}
				
			}
		}
		}
		if(!mode.equalsIgnoreCase("tarifinsert")){
			if(getBillinggridlength()>0){
				for(int i=0;i<getBillinggridlength();i++){
					String temp=requestParams.get("bill"+i)[0];
					billarray.add(temp);
				}
			}
		}
		if(mode.equalsIgnoreCase("A")){
			System.out.println("Inside action");
			int val=bookingdao.insert(sqldate,getHidclient(),getHidguest(),getGuest(),getGuestcontactno(),getHidchknewguest(),session,getMode(),getFormdetailcode(),getBrchName(),getDescription(),getTxtairport(),getTxtflightno(),getTxthotelname(),getTxtroomno(),getCmbloctype());
			if(val>0){
				boolean status=bookingdao.insertTarif(val,newtransferarray,newhoursarray,session,mode);
				if(status){
					int billval=bookingdao.insertBill(val,billarray);
					if(billval>0){
						setValues(val, sqldate,session.getAttribute("LIMOBOOKVOCNO").toString());
						setMsg("Successfully Saved");
						return "success";
					}
					else{
						setValues(val, sqldate,session.getAttribute("LIMOBOOKVOCNO").toString());
						setMsg("Not Saved");
						return "fail";
					}
				}
				else{
					setValues(val, sqldate,session.getAttribute("LIMOBOOKVOCNO").toString());
					setMsg("Not Saved");
					return "fail";
				}
			}
			else{
				setValues(val, sqldate,session.getAttribute("LIMOBOOKVOCNO").toString());
				setMsg("Not Saved");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("E")){
			boolean status=bookingdao.edit(getDocno(),sqldate,getHidclient(),getHidguest(),getGuest(),getGuestcontactno(),getHidchknewguest(),session,getMode(),getFormdetailcode(),getBrchName(),getDescription(),getTxtairport(),getTxtflightno(),getTxthotelname(),getTxtroomno(),getCmbloctype());
			if(status){
				setValues(getDocno(), sqldate,getVocno());
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setValues(getDocno(), sqldate,getVocno());
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			boolean status=bookingdao.delete(getDocno(),sqldate,getHidclient(),getHidguest(),getGuest(),getGuestcontactno(),getHidchknewguest(),session,getMode(),getFormdetailcode(),getBrchName());
			if(status){
				setValues(getDocno(), sqldate,getVocno());
				setMsg("Successfully Deleted");
				return "success";
			}
			else{
				setValues(getDocno(), sqldate,getVocno());
				setMsg("Not Deleted");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("tarifinsert")){
			
			boolean status=bookingdao.insertTarif(getDocno(),newtransferarray,newhoursarray,session,mode);
			if(status){
				setValues(getDocno(), sqldate,getVocno());
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setValues(getDocno(), sqldate,getVocno());
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("srvcinsert")){
			ArrayList<String> srvcarray=new ArrayList<>();
			
			if(getOthersrvcgridlength()>0){
				for(int i=0;i<getOthersrvcgridlength();i++){
					String temp=requestParams.get("srvc"+i)[0];
					srvcarray.add(temp);
				}
			}
			
			boolean status=bookingdao.insertSrvc(getDocno(),srvcarray,billarray);
			if(status){
				setValues(getDocno(), sqldate,getVocno());
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setValues(getDocno(), sqldate,getVocno());
				setMsg("Not Updated");
				return "fail";
			}
		}
		return "fail";
	}

	
}
