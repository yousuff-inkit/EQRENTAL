package com.operations.agreement.masterleaseagmt;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsMasterLeaseAgmtAction {
	ClsMasterLeaseAgmtDAO masterdao=new ClsMasterLeaseAgmtDAO();
	ClsCommon objcommon=new ClsCommon();
	private String date,docno,vocno,po,refno,cldocno,clientdetails,description,startdate,enddate,mode,msg,deleted,brchName,formdetailcode;
	
	private int gridlength;
	
	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getBrchName() {
		return brchName;
	}

	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getDocno() {
		return docno;
	}

	public void setDocno(String docno) {
		this.docno = docno;
	}

	public String getVocno() {
		return vocno;
	}

	public void setVocno(String vocno) {
		this.vocno = vocno;
	}

	public String getPo() {
		return po;
	}

	public void setPo(String po) {
		this.po = po;
	}

	public String getRefno() {
		return refno;
	}

	public void setRefno(String refno) {
		this.refno = refno;
	}

	public String getCldocno() {
		return cldocno;
	}

	public void setCldocno(String cldocno) {
		this.cldocno = cldocno;
	}

	public String getClientdetails() {
		return clientdetails;
	}

	public void setClientdetails(String clientdetails) {
		this.clientdetails = clientdetails;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
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
	public void setData(String docno,String vocno,java.sql.Date sqldate,java.sql.Date sqlstartdate,java.sql.Date sqlenddate){
		if(sqldate!=null){
			setDate(sqldate.toString());
		}
		if(sqlstartdate!=null){
			setStartdate(sqlstartdate.toString());
		}
		if(sqlenddate!=null){
			setEnddate(sqlenddate.toString());
		}
		setCldocno(getCldocno());
		setDocno(docno);
		setVocno(vocno);
		setPo(getPo());
		setRefno(getRefno());
		setCldocno(getCldocno());
		setClientdetails(getClientdetails());
		
	}
	public String saveAction() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		String formcode="";
		int val=0;
		Map<String, String[]> requestParams = request.getParameterMap();
		java.sql.Date sqlstartdate=null;
		java.sql.Date sqlenddate=null;
		java.sql.Date sqldate=null;
		
		if(!getStartdate().equalsIgnoreCase("") && getStartdate()!=null){
			sqlstartdate=objcommon.changeStringtoSqlDate(getStartdate());
		}
		if(!getEnddate().equalsIgnoreCase("") && getEnddate()!=null){
			sqlenddate=objcommon.changeStringtoSqlDate(getEnddate());
		}
		if(!getDate().equalsIgnoreCase("") && getDate()!=null){
			sqldate=objcommon.changeStringtoSqlDate(getDate());
		}
		ArrayList<String> gridarray=new ArrayList<>();
		System.out.println("Gridlength:"+getGridlength());
		for(int i=0;i<getGridlength();i++){
			String temp=requestParams.get("gridarray"+i)[0];
			gridarray.add(temp);
		}
		if(mode.equalsIgnoreCase("A")){
			
			val=masterdao.insert(sqldate,sqlstartdate,sqlenddate,getPo(),getRefno(),getCldocno(),getDescription(),getBrchName(),session,mode,getFormdetailcode(),gridarray,request);
			if(val>0){
				setData(val+"", request.getAttribute("vocno").toString(), sqldate, sqlstartdate, sqlenddate);
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setData(val+"", "0", sqldate, sqlstartdate, sqlenddate);
				setMsg("Not Saved");
				return "fail";
			}
		}
		/*else if(mode.equalsIgnoreCase("E")){
			boolean status=masterdao.edit(getDocno(),sqldate,sqlstartdate,sqlenddate,getPo(),getRefno(),getCldocno(),getDescription(),getBrchName(),session,mode,getFormdetailcode(),gridarray,request);
			if(status){
				setData(getDocno(), getVocno(), sqldate, sqlstartdate, sqlenddate);
				setMsg("Successfully Updated");
				return "success";
			}
			else{
				setData(getDocno(), getVocno(), sqldate, sqlstartdate, sqlenddate);
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			boolean status=masterdao.delete(getDocno(),sqldate,sqlstartdate,sqlenddate,getPo(),getRefno(),getCldocno(),getDescription(),getBrchName(),session,mode,getFormdetailcode(),gridarray,request);
			if(status){
				setData(getDocno(), getVocno(), sqldate, sqlstartdate, sqlenddate);
				setMsg("De");
				return "success";
			}
			else{
				setData(getDocno(), getVocno(), sqldate, sqlstartdate, sqlenddate);
				setMsg("Not Updated");
				return "fail";
			}
		}*/
		
		return "fail";
	}
}
