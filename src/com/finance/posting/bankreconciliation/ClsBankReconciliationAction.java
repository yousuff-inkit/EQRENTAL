package com.finance.posting.bankreconciliation;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsBankReconciliationAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsBankReconciliationDAO bankReconciliationDAO= new ClsBankReconciliationDAO();
	ClsBankReconciliationBean bankReconciliationBean;

	private int txtbankreconciliationdocno;
	private String mode;
	private String deleted;
	private String msg;
	private String formdetailcode;
	private String jqxBankReconciliationDate;
	private String hidjqxBankReconciliationDate;
	private String cmbbranch;
	private String hidcmbbranch;
	private String cmbcurrency;
	private String hidcmbcurrency;
	private int txtdocno;
	private String txtaccid;
	private String txtaccname;
	private String txtdescription;
	
	private String txtunclrreceipts;
	private String txtunclrpayments;
	private String txtbookbalance;
	private String txtbankbalance;
	
	private int txttrno;
	private String lblformposted;
	
	private String url;
	
	//Bank Reconciliation Grid
	private int gridlength;
	
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
	
	private String lblaccountname;
	private String lblvoucherno;
	private String lblcurrency;
	private String lbldate;
	private String lblunclearedreceipttotal;
	private String lblunclearedpaymenttotal;
	private Double lblbookbalance;
	private Double lblunclearedpayments;
	private Double lblunclearedreceipts;
	private Double lblbankstatements;
	private String lblpreparedby;
	private String lblpreparedon;
	private String lblpreparedat;
	private String lblprintby;

	public String getLblprintby() {
		return lblprintby;
	}

	public void setLblprintby(String lblprintby) {
		this.lblprintby = lblprintby;
	}

	//for hide
	private int firstarray;
	private int secarray;
	private int txtheader;
		
	public int getTxtbankreconciliationdocno() {
		return txtbankreconciliationdocno;
	}

	public void setTxtbankreconciliationdocno(int txtbankreconciliationdocno) {
		this.txtbankreconciliationdocno = txtbankreconciliationdocno;
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

	 private Map<String, Object> param=null;
		
		
		public Map<String, Object> getParam() {
			return param;
		}
		public void setParam(Map<String, Object> param) {
			this.param = param;
		}
		
	
	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getJqxBankReconciliationDate() {
		return jqxBankReconciliationDate;
	}

	public void setJqxBankReconciliationDate(String jqxBankReconciliationDate) {
		this.jqxBankReconciliationDate = jqxBankReconciliationDate;
	}

	public String getHidjqxBankReconciliationDate() {
		return hidjqxBankReconciliationDate;
	}

	public void setHidjqxBankReconciliationDate(String hidjqxBankReconciliationDate) {
		this.hidjqxBankReconciliationDate = hidjqxBankReconciliationDate;
	}

	public String getCmbbranch() {
		return cmbbranch;
	}

	public void setCmbbranch(String cmbbranch) {
		this.cmbbranch = cmbbranch;
	}

	public String getHidcmbbranch() {
		return hidcmbbranch;
	}

	public void setHidcmbbranch(String hidcmbbranch) {
		this.hidcmbbranch = hidcmbbranch;
	}

	public String getCmbcurrency() {
		return cmbcurrency;
	}

	public void setCmbcurrency(String cmbcurrency) {
		this.cmbcurrency = cmbcurrency;
	}

	public String getHidcmbcurrency() {
		return hidcmbcurrency;
	}

	public void setHidcmbcurrency(String hidcmbcurrency) {
		this.hidcmbcurrency = hidcmbcurrency;
	}

	public int getTxtdocno() {
		return txtdocno;
	}

	public void setTxtdocno(int txtdocno) {
		this.txtdocno = txtdocno;
	}

	public String getTxtaccid() {
		return txtaccid;
	}

	public void setTxtaccid(String txtaccid) {
		this.txtaccid = txtaccid;
	}

	public String getTxtaccname() {
		return txtaccname;
	}

	public void setTxtaccname(String txtaccname) {
		this.txtaccname = txtaccname;
	}



	public String getTxtunclrreceipts() {
		return txtunclrreceipts;
	}

	public void setTxtunclrreceipts(String txtunclrreceipts) {
		this.txtunclrreceipts = txtunclrreceipts;
	}

	public String getTxtunclrpayments() {
		return txtunclrpayments;
	}

	public void setTxtunclrpayments(String txtunclrpayments) {
		this.txtunclrpayments = txtunclrpayments;
	}

	public String getTxtbookbalance() {
		return txtbookbalance;
	}

	public void setTxtbookbalance(String txtbookbalance) {
		this.txtbookbalance = txtbookbalance;
	}

	public String getTxtbankbalance() {
		return txtbankbalance;
	}

	public void setTxtbankbalance(String txtbankbalance) {
		this.txtbankbalance = txtbankbalance;
	}

	public String getTxtdescription() {
		return txtdescription;
	}

	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}

	public int getTxttrno() {
		return txttrno;
	}

	public void setTxttrno(int txttrno) {
		this.txttrno = txttrno;
	}

	public String getLblformposted() {
		return lblformposted;
	}

	public void setLblformposted(String lblformposted) {
		this.lblformposted = lblformposted;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
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

	public String getLblaccountname() {
		return lblaccountname;
	}

	public void setLblaccountname(String lblaccountname) {
		this.lblaccountname = lblaccountname;
	}

	public String getLblvoucherno() {
		return lblvoucherno;
	}

	public void setLblvoucherno(String lblvoucherno) {
		this.lblvoucherno = lblvoucherno;
	}

	public String getLblcurrency() {
		return lblcurrency;
	}

	public void setLblcurrency(String lblcurrency) {
		this.lblcurrency = lblcurrency;
	}

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}

	public String getLblunclearedreceipttotal() {
		return lblunclearedreceipttotal;
	}

	public void setLblunclearedreceipttotal(String lblunclearedreceipttotal) {
		this.lblunclearedreceipttotal = lblunclearedreceipttotal;
	}

	public String getLblunclearedpaymenttotal() {
		return lblunclearedpaymenttotal;
	}

	public void setLblunclearedpaymenttotal(String lblunclearedpaymenttotal) {
		this.lblunclearedpaymenttotal = lblunclearedpaymenttotal;
	}

	public Double getLblbookbalance() {
		return lblbookbalance;
	}

	public void setLblbookbalance(Double lblbookbalance) {
		this.lblbookbalance = lblbookbalance;
	}

	public Double getLblunclearedpayments() {
		return lblunclearedpayments;
	}

	public void setLblunclearedpayments(Double lblunclearedpayments) {
		this.lblunclearedpayments = lblunclearedpayments;
	}

	public Double getLblunclearedreceipts() {
		return lblunclearedreceipts;
	}

	public void setLblunclearedreceipts(Double lblunclearedreceipts) {
		this.lblunclearedreceipts = lblunclearedreceipts;
	}

	public Double getLblbankstatements() {
		return lblbankstatements;
	}

	public void setLblbankstatements(Double lblbankstatements) {
		this.lblbankstatements = lblbankstatements;
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


	java.sql.Date bankReconciliationDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
       
		String mode=getMode();
		ClsBankReconciliationBean bean = new ClsBankReconciliationBean();
		
		if(!(getJqxBankReconciliationDate()==null || getJqxBankReconciliationDate().equalsIgnoreCase(""))){
			bankReconciliationDate = commonDAO.changeStringtoSqlDate(getJqxBankReconciliationDate());
		}
		
		if(mode.equalsIgnoreCase("A")){
			/*Bank Reconciliation Grid Saving*/
			ArrayList<String> bankreconciliationarray= new ArrayList<String>();
			ArrayList<String> bankreconcilearray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String[] temp=requestParams.get("test"+i)[0].toString().split("::");
				if(temp[0].trim().equalsIgnoreCase("true")){
					bankreconciliationarray.add("1::"+temp[1]+"::"+temp[3].trim());
				}
				else{
					bankreconcilearray.add("0:: "+temp[1]+":: "+temp[2].trim()+":: "+temp[3].trim()+":: "+temp[4]+":: "+temp[5].trim()+":: "+temp[6].trim()+":: "+temp[7].trim()+":: "+temp[8]+":: "+temp[9].trim()+":: "+temp[10].trim()+":: "+temp[11].trim()+":: "+temp[12].trim()+":: "+temp[13].trim());
				}
			}
			
			/*Bank Reconciliation Grid Saving Ends*/
			
						int val=bankReconciliationDAO.insert(bankReconciliationDate,getTxtdescription(),getCmbbranch(),getCmbcurrency(),getTxtdocno(),getTxtunclrreceipts(),
								getTxtunclrpayments(),getTxtbookbalance(),getTxtbankbalance(),getFormdetailcode(),bankreconciliationarray,bankreconcilearray,session,request);
						if(val>0.0){
							
							setTxtbankreconciliationdocno(val);
							setTxttrno(Integer.parseInt(request.getAttribute("tranno").toString()));
							setData();
							
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setData();
							setMsg("Not Saved");
							return "fail";
						}	
		} else if(mode.equalsIgnoreCase("E")){
			
			/*Bank Reconciliation Grid Saving*/
			ArrayList<String> bankreconciliationarray= new ArrayList<String>();
			ArrayList<String> bankreconcilearray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String[] temp=requestParams.get("test"+i)[0].toString().split("::");
				if(temp[0].trim().equalsIgnoreCase("true")){
					bankreconciliationarray.add("1::"+temp[1]+"::"+temp[3].trim());
				}
				else{
					bankreconcilearray.add("0:: "+temp[1]+":: "+temp[2].trim()+":: "+temp[3].trim()+":: "+temp[4]+":: "+temp[5].trim()+":: "+temp[6].trim()+":: "+temp[7].trim()+":: "+temp[8]+":: "+temp[9].trim()+":: "+temp[10].trim()+":: "+temp[11].trim()+":: "+temp[12].trim()+":: "+temp[13].trim());
				}
			}
			/*Bank Reconciliation Grid Saving Ends*/
			
						boolean Status=bankReconciliationDAO.edit(bankReconciliationDate,getTxtbankreconciliationdocno(),getTxttrno(),getTxtdescription(),getCmbbranch(),getCmbcurrency(),getTxtdocno(),getTxtunclrreceipts(),
								getTxtunclrpayments(),getTxtbookbalance(),getTxtbankbalance(),getFormdetailcode(),bankreconciliationarray,bankreconcilearray,session,request);
						if(Status){
							
							setTxtbankreconciliationdocno(getTxtbankreconciliationdocno());
							setTxttrno(getTxttrno());
							setData();
							
							setMsg("Updated Successfully");
							return "success";
						}
						else{
							setTxtbankreconciliationdocno(getTxtbankreconciliationdocno());
							setTxttrno(getTxttrno());
							setData();
							setMsg("Not Updated");
							return "fail";
						}	
		}
		
		else if(mode.equalsIgnoreCase("View")){
	
			bankReconciliationBean=bankReconciliationDAO.getViewDetails(session,getTxtbankreconciliationdocno());
			
			setJqxBankReconciliationDate(bankReconciliationBean.getJqxBankReconciliationDate());
			setHidcmbbranch(bankReconciliationBean.getHidcmbbranch());
			setHidcmbcurrency(bankReconciliationBean.getHidcmbcurrency());
			
			setTxtdocno(bankReconciliationBean.getTxtdocno());
			setTxtaccid(bankReconciliationBean.getTxtaccid());
			setTxtaccname(bankReconciliationBean.getTxtaccname());
			setTxtdescription(bankReconciliationBean.getTxtdescription());
			
			setTxtunclrreceipts(bankReconciliationBean.getTxtunclrreceipts());
			setTxtunclrpayments(bankReconciliationBean.getTxtunclrpayments());
			setTxtbookbalance(bankReconciliationBean.getTxtbookbalance());
			setTxtbankbalance(bankReconciliationBean.getTxtbankbalance());
			//
			System.out.println("txtunclrpayments==="+bankReconciliationBean.getTxtunclrpayments());
			setTxttrno(bankReconciliationBean.getTxttrno());
			setLblformposted(bankReconciliationBean.getLblformposted());
			return "success";
		}
		return "fail";
	}
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		int docno=Integer.parseInt(request.getParameter("docno"));
		int header=Integer.parseInt(request.getParameter("header"));
		int branch=Integer.parseInt(request.getParameter("branch"));
		bankReconciliationBean=bankReconciliationDAO.getPrint(request,docno,branch,header);
		
		String dtype=request.getParameter("dtype")==null?"0":request.getParameter("dtype").toString();
		//System.out.println("dtype=="+dtype);
		 setUrl(commonDAO.getPrintPath(dtype));
		
		setUrl(commonDAO.getPrintPath("BRCN"));
		setLblcompname(bankReconciliationBean.getLblcompname());
		setLblcompaddress(bankReconciliationBean.getLblcompaddress());
		setLblpobox(bankReconciliationBean.getLblpobox());
		setLblprintname(bankReconciliationBean.getLblprintname());
		setLblcomptel(bankReconciliationBean.getLblcomptel());
		setLblcompfax(bankReconciliationBean.getLblcompfax());
		setLblbranch(bankReconciliationBean.getLblbranch());
		setLbllocation(bankReconciliationBean.getLbllocation());
		setLblservicetax(bankReconciliationBean.getLblservicetax());
		setLblpan(bankReconciliationBean.getLblpan());
		setLblcstno(bankReconciliationBean.getLblcstno());
		setLblaccountname(bankReconciliationBean.getLblaccountname());
		setLblvoucherno(bankReconciliationBean.getLblvoucherno());
		setLblcurrency(bankReconciliationBean.getLblcurrency());
		setLbldate(bankReconciliationBean.getLbldate());
		setLblunclearedreceipttotal(bankReconciliationBean.getLblunclearedreceipttotal());
		setLblunclearedpaymenttotal(bankReconciliationBean.getLblunclearedpaymenttotal());
		setLblbookbalance(bankReconciliationBean.getLblbookbalance());
		setLblunclearedpayments(bankReconciliationBean.getLblunclearedpayments());
		setLblunclearedreceipts(bankReconciliationBean.getLblunclearedreceipts());
		setLblbankstatements(bankReconciliationBean.getLblbankstatements());
		setLblpreparedby(bankReconciliationBean.getLblpreparedby());
		setLblpreparedon(bankReconciliationBean.getLblpreparedon());
		setLblpreparedat(bankReconciliationBean.getLblpreparedat());
		setLblprintby(bankReconciliationBean.getLblprintby());
		
		// for hide
		setFirstarray(bankReconciliationBean.getFirstarray());
		setSecarray(bankReconciliationBean.getSecarray());
		setTxtheader(bankReconciliationBean.getTxtheader());
	
		 
 	   
 	   
    	      
    	   
 	 
		
		   if(commonDAO.getPrintPath(dtype).contains("jrxml")==true)
		   {
			   HttpServletResponse response = ServletActionContext.getResponse();
			    
			    
			    
			    
				 
				 param = new HashMap();
				 Connection conn = null;
				 
				 //String reportFileName = "NIPurchaseOrder";
				 							
				 ClsConnection conobj=new ClsConnection();
				 conn = conobj.getMyConnection();
				   Statement stmtBankReconciliation =conn.createStatement();
				  // String reportFileName = commonDAO.getBIBPrintPath(printPathDtype);
				   
				   
				   
				   String printPathSql="select CONCAT('AS',atype) dtype from my_head where doc_no="+docno+"";
			 	   ResultSet resultSetPrintPath = stmtBankReconciliation.executeQuery(printPathSql);
			    	   String printPathDtype="BIB",unClrChqShow="0",unClrChqShow2="0";
			    	   while(resultSetPrintPath.next()){
			    			printPathDtype=resultSetPrintPath.getString("dtype");
			    		}
			    	   
			    	   if(printPathDtype.equalsIgnoreCase("ASAR")) {
				       	   String unclrChqView="select coalesce(value,0) value from gl_bibd where dtype='ASAR'";
			  	       ResultSet resultSetUnclrChq = stmtBankReconciliation.executeQuery(unclrChqView);
				       	   while(resultSetUnclrChq.next()){
				       		   unClrChqShow=resultSetUnclrChq.getString("value");
				       		}
			    	   }
			    	if(printPathDtype.equalsIgnoreCase("ASAP")) {
				       	   String unclrChqView="select coalesce(value,0) value from gl_bibd where dtype='ASAP'";
			  	       ResultSet resultSetUnclrChq = stmtBankReconciliation.executeQuery(unclrChqView);
				       	   while(resultSetUnclrChq.next()){
				       		   unClrChqShow2=resultSetUnclrChq.getString("value");
				       		}
			    	   }
			    	 String reportFileName = commonDAO.getBIBPrintPath(printPathDtype);
					   
				 try {            
		            // param.put("termsquery",pintbean.getTermQry());
			          
			        // param.put("descQry",pintbean.getDescQry());
			         
			       //  System.out.println("product++++++++++"+productQuery);
			         String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
			        	imgpath=imgpath.replace("\\", "\\\\");    
			          param.put("imghedderpath", imgpath);
			          
			          
			          String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
			        	imgpath2=imgpath2.replace("\\", "\\\\");    
			          param.put("imgfooterpath", imgpath2);
			          //System.out.println("brhid==="+brhid);
			          if(branch==1){
							//System.out.println("brhid2==="+brhid);
							String branch1header = request.getSession().getServletContext().getRealPath("/icons/branch1header.jpg");
							branch1header =branch1header.replace("\\", "\\\\");	
							String branch1footer = request.getSession().getServletContext().getRealPath("/icons/branch1footer.jpg");
							branch1footer =branch1footer.replace("\\", "\\\\");
							param.put("branchheader", branch1header);
							param.put("branchfooter", branch1footer);
							//System.out.println("brhid1==="+brhid);
						}
						
						else if(branch==2){
							String branch2header = request.getSession().getServletContext().getRealPath("/icons/branch2header.jpg");
							branch2header =branch2header.replace("\\", "\\\\");	
							String branch2footer = request.getSession().getServletContext().getRealPath("/icons/branch2footer.jpg");
							branch2footer =branch2footer.replace("\\", "\\\\");
							param.put("branchheader", branch2header);
							param.put("branchfooter", branch2footer);
							//System.out.println("brhid2==="+brhid);
						}
						else if(branch==3){
							String branch3header = request.getSession().getServletContext().getRealPath("/icons/branch3header.jpg");
							branch3header =branch3header.replace("\\", "\\\\");	
							String branch3footer = request.getSession().getServletContext().getRealPath("/icons/branch3footer.jpg");
							branch3footer =branch3footer.replace("\\", "\\\\");
							param.put("branchheader", branch3header);
							param.put("branchfooter", branch3footer);
							//System.out.println("brhid3==="+brhid);
						} 
			      
			            param.put("account", bankReconciliationBean.getLblaccountname());
			            param.put("currency", bankReconciliationBean.getLblcurrency());
			            param.put("printby", bankReconciliationBean.getLblprintby());
			            param.put("preparedon", bankReconciliationBean.getLblpreparedon());
			            param.put("prepareddate", bankReconciliationBean.getLblpreparedat());
			            param.put("doc_no",bankReconciliationBean.getLblvoucherno());
			            param.put("preparedby",bankReconciliationBean.getLblpreparedby());

			            param.put("dateupto", bankReconciliationBean.getLbldate());
			            param.put("bookbalance", bankReconciliationBean.getLblbookbalance());
			            param.put("bankbalance", bankReconciliationBean.getLblbankstatements());
			            param.put("rvbalance", bankReconciliationBean.getLblunclearedreceipts());
			            param.put("pvbalance", bankReconciliationBean.getLblunclearedpayments());

			         // param.put("desc", pintbean.getLbldsc());
			         // param.put("payterm", pintbean.getLblpatms());
			         // param.put("delterm", pintbean.getLbldddtm());
			        //  param.put("netamount", pintbean.getLblnettotal());
			         // param.put("total", pintbean.getLbltotal());
			          //param.put("vatamnt", pintbean.getLbltaxtot());

			         // param.put("amountwords", pintbean.getWordnetamount());
			         // param.put("amountwords", pintbean.getLbltotinword());
			          //System.out.println("amountwords=="+pintbean.getLbltotinword());
			       // System.out.println("desc"+bean.getLbldesc1()+"pay"+bean.getLblpaytems()+"paytrim"+bean.getLblpaytems()+"del"+ bean.getLbldelterms());
			       // String path[]=commDAO.getPrintPath(dtype).split("nipurchaseorder/");
			        setUrl(commonDAO.getPrintPath(dtype));
			        
	             JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/finance/print/epic/" +commonDAO.getPrintPath(dtype)));
	         	 
	              JasperReport jasperReport = JasperCompileManager.compileReport(design);
	             generateReportPDF(response, param, jasperReport, conn);
	       

	   } catch (Exception e) {

	       e.printStackTrace();

	   }
				 
				 finally{
					 conn.close();
				 }
			   
		   }
		  

		
		
		
		return "print";
	}
	private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {
		  byte[] bytes = null;
	    bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
	      resp.reset();
	    resp.resetBuffer();
	    
	    resp.setContentType("application/pdf");
	    resp.setContentLength(bytes.length);
	    ServletOutputStream ouputStream = resp.getOutputStream();
	    ouputStream.write(bytes, 0, bytes.length);
	   
	    ouputStream.flush();
	    ouputStream.close();
	   
	         
	}


		public JSONArray searchDetails(String account,String docNo,String currency,String description,String reconcileDt,String check){
			  JSONArray cellarray = new JSONArray();
			  		  JSONObject cellobj = null;
			  try {
			     cellarray= bankReconciliationDAO.brcnMainSearch(account, docNo, currency, description, reconcileDt, check);
		
			  } catch (SQLException e) {
				  e.printStackTrace();
				  }
			return cellarray;
		}
		
		public void setData(){
			setFormdetailcode(getFormdetailcode());
			setHidcmbbranch(getCmbbranch());
			setHidcmbcurrency(getCmbcurrency());
			setTxtdocno(getTxtdocno());
			setTxtaccid(getTxtaccid());
			setTxtaccname(getTxtaccname());
			setTxtdescription(getTxtdescription());
			setTxtunclrreceipts(getTxtunclrreceipts());
			setTxtunclrpayments(getTxtunclrpayments());
			setTxtbookbalance(getTxtbookbalance());
			setTxtbankbalance(getTxtbankbalance());
			System.out.println(getTxtunclrreceipts()+"=="+getTxtunclrpayments()); 
			if(!(getJqxBankReconciliationDate()==null || getJqxBankReconciliationDate().equalsIgnoreCase(""))){
				setHidjqxBankReconciliationDate(bankReconciliationDate.toString());
			}
		}
}

