package com.operations.saleofvehicle.vehicledisposal;
import java.io.IOException;
import java.sql.Connection;
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

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.vehicletransactions.vehicleinspection.ClsVehicleInspectionDAO;

@SuppressWarnings("serial")
public class ClsVehicleDisposalAction {
	ClsVehicleDisposalDAO disposalDAO= new ClsVehicleDisposalDAO();
	ClsCommon objcommon =new ClsCommon();
	ClsVehicleDisposalBean bean;
	private String lblcomptrn,lblclienttrn,lbltaxtotal,lblnettaxtotal,lblvat;
	private int docno;
	private int vocno;
	private String date;
	private String hiddate;
	private String client;
	private String clientname;
	private String clientacno;
	private String cmbtype;
	private String hidcmbtype;
	private String description;
	private String msg;
	private String deleted;
	private String mode;
	private int trno;
	private int gridlength;
	private String formdetailcode;
	private String formdetail;
	private String hidbranch;
	private String days;
	private String brchName;
	private String lblclientcode;
	private String lblclientname;
	private String lbldocno;
	private String lbldate;
	private String lbltype;
	private String lbldesc;
	private String url;
	private String lblcompname;
	private String lblprintname;
	private String lblcompfax;
	private String lblcomptel;
	private String lblbranch;
	private String lblcompaddress,lblprintname1;
	private String lblcompemail;
	private String lbltaxamtwrds;
	private String easycmpname;
	
	
	public String getLbltaxamtwrds() {
		return lbltaxamtwrds;
	}
	public void setLbltaxamtwrds(String lbltaxamtwrds) {
		this.lbltaxamtwrds = lbltaxamtwrds;
	}
	public String getLblcompemail() {
		return lblcompemail;
	}
	public void setLblcompemail(String lblcompemail) {
		this.lblcompemail = lblcompemail;
	}
	public String getLblprintname1() {
		return lblprintname1;
	}
	public void setLblprintname1(String lblprintname1) {
		this.lblprintname1 = lblprintname1;
	}



	private String mdoc;
	private String lbladdress1,lbladdress2,lblmobile,lblphone,lbltotal,lblamountwords,lbllocation,lblcheckedby,lblfinaldate;
	private int jvsize;
	private String lbldebittotal;
	private String lblcredittotal;
	
	
	
	public String getLblcomptrn() {
		return lblcomptrn;
	}
	public void setLblcomptrn(String lblcomptrn) {
		this.lblcomptrn = lblcomptrn;
	}
	public String getLblclienttrn() {
		return lblclienttrn;
	}
	public void setLblclienttrn(String lblclienttrn) {
		this.lblclienttrn = lblclienttrn;
	}
	public String getLbltaxtotal() {
		return lbltaxtotal;
	}
	public void setLbltaxtotal(String lbltaxtotal) {
		this.lbltaxtotal = lbltaxtotal;
	}
	public String getLblnettaxtotal() {
		return lblnettaxtotal;
	}
	public void setLblnettaxtotal(String lblnettaxtotal) {
		this.lblnettaxtotal = lblnettaxtotal;
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
public int getJvsize() {
		return jvsize;
	}
	public void setJvsize(int jvsize) {
		this.jvsize = jvsize;
	}

public String getLblcheckedby() {
	return lblcheckedby;
}
public void setLblcheckedby(String lblcheckedby) {
	this.lblcheckedby = lblcheckedby;
}
public String getLblfinaldate() {
	return lblfinaldate;
}
public void setLblfinaldate(String lblfinaldate) {
	this.lblfinaldate = lblfinaldate;
}


public String getLbllocation() {
	return lbllocation;
}
public void setLbllocation(String lbllocation) {
	this.lbllocation = lbllocation;
};
	
	
	public String getLbltotal() {
		return lbltotal;
	}
	public void setLbltotal(String lbltotal) {
		this.lbltotal = lbltotal;
	}
	public String getLblamountwords() {
		return lblamountwords;
	}
	public void setLblamountwords(String lblamountwords) {
		this.lblamountwords = lblamountwords;
	}
	public String getLbladdress1() {
		return lbladdress1;
	}
	public void setLbladdress1(String lbladdress1) {
		this.lbladdress1 = lbladdress1;
	}
	public String getLbladdress2() {
		return lbladdress2;
	}
	public void setLbladdress2(String lbladdress2) {
		this.lbladdress2 = lbladdress2;
	}
	public String getLblmobile() {
		return lblmobile;
	}
	public void setLblmobile(String lblmobile) {
		this.lblmobile = lblmobile;
	}
	public String getLblphone() {
		return lblphone;
	}
	public void setLblphone(String lblphone) {
		this.lblphone = lblphone;
	}
	public String getMdoc() {
		return mdoc;
	}
	public void setMdoc(String mdoc) {
		this.mdoc = mdoc;
	}
	public String getLblcompaddress() {
		return lblcompaddress;
	}
	public void setLblcompaddress(String lblcompaddress) {
		this.lblcompaddress = lblcompaddress;
	}
	public String getLblcompname() {
		return lblcompname;
	}
	public void setLblcompname(String lblcompname) {
		this.lblcompname = lblcompname;
	}
	public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}
	public String getLblcompfax() {
		return lblcompfax;
	}
	public void setLblcompfax(String lblcompfax) {
		this.lblcompfax = lblcompfax;
	}
	public String getLblcomptel() {
		return lblcomptel;
	}
	public void setLblcomptel(String lblcomptel) {
		this.lblcomptel = lblcomptel;
	}
	public String getLblbranch() {
		return lblbranch;
	}
	public void setLblbranch(String lblbranch) {
		this.lblbranch = lblbranch;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getLblclientcode() {
		return lblclientcode;
	}
	public void setLblclientcode(String lblclientcode) {
		this.lblclientcode = lblclientcode;
	}
	public String getLblclientname() {
		return lblclientname;
	}
	public void setLblclientname(String lblclientname) {
		this.lblclientname = lblclientname;
	}
	public String getLbldocno() {
		return lbldocno;
	}
	public void setLbldocno(String lbldocno) {
		this.lbldocno = lbldocno;
	}
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLbltype() {
		return lbltype;
	}
	public void setLbltype(String lbltype) {
		this.lbltype = lbltype;
	}
	public String getLbldesc() {
		return lbldesc;
	}
	public void setLbldesc(String lbldesc) {
		this.lbldesc = lbldesc;
	}
	public int getVocno() {
		return vocno;
	}
	public void setVocno(int vocno) {
		this.vocno = vocno;
	}
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	public String getDays() {
		return days;
	}
	public void setDays(String days) {
		this.days = days;
	}
	public String getHidbranch() {
		return hidbranch;
	}
	public void setHidbranch(String hidbranch) {
		this.hidbranch = hidbranch;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	public int getTrno() {
		return trno;
	}
	public void setTrno(int trno) {
		this.trno = trno;
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
	public String getHiddate() {
		return hiddate;
	}
	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}
	
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getClientname() {
		return clientname;
	}
	public void setClientname(String clientname) {
		this.clientname = clientname;
	}
	public String getClientacno() {
		return clientacno;
	}
	public void setClientacno(String clientacno) {
		this.clientacno = clientacno;
	}
	public String getCmbtype() {
		return cmbtype;
	}
	public void setCmbtype(String cmbtype) {
		this.cmbtype = cmbtype;
	}
	public String getHidcmbtype() {
		return hidcmbtype;
	}
	public void setHidcmbtype(String hidcmbtype) {
		this.hidcmbtype = hidcmbtype;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
     private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	public String getLblvat() {
		return lblvat;
	}
	public void setLblvat(String lblvat) {
		this.lblvat = lblvat;
	}
	
	public void setValues(java.sql.Date sqlStartDate,String branch,int docno,int trno,int vocno){
		setDate(sqlStartDate.toString());
		setClient(getClient());
		setClientacno(getClientacno());
		setClientname(getClientname());
		setDescription(getDescription());
		setHidcmbtype(getCmbtype());
		setDocno(docno);
		setTrno(trno);
		setHidbranch(branch);
		setVocno(vocno);
	}
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		java.sql.Date sqlStartDate = objcommon.changeStringtoSqlDate(getDate());
//		System.out.println("Mode in action:"+mode);
		if(mode.equalsIgnoreCase("A")){
			ArrayList<String> disposalarray= new ArrayList<>();
//			System.out.println("inside tarifsave");
			for(int i=0;i<getGridlength();i++){
				//ClsTarifBean tarifbean=new ClsTarifBean();
//				System.out.println("request =========="+request.getAttribute("test"+i));
				String temp=requestParams.get("test"+i)[0];
				
				disposalarray.add(temp);
//				System.out.println(disposalarray.get(i));
			}
//			System.out.println("Branch in Action: "+getBrchName());
						ClsVehicleDisposalBean bean=disposalDAO.insert(sqlStartDate,getCmbtype(),getDescription(),session,getMode(),disposalarray,
								getFormdetailcode(),getClientacno(),getClient(),getDays(),getBrchName(),request,getMdoc());
						if(bean.getDocno()>0){
							setValues(sqlStartDate,getBrchName(),bean.getDocno(),bean.getTrno(),Integer.parseInt(request.getAttribute("VOCNO").toString()));
							setMsg("Successfully Saved");
//System.out.println("TrNo"+getTrno());
							return "success";
						}
						else{
							setValues(sqlStartDate,getBrchName(),bean.getDocno(),bean.getTrno(),0);
							setMsg("Not Saved");

							return "fail";
						}	
		}
		else if(mode.equalsIgnoreCase("E")){
			ArrayList<String> disposalarray= new ArrayList<>();
//			System.out.println("inside tarifsave");
			for(int i=0;i<getGridlength();i++){
				//ClsTarifBean tarifbean=new ClsTarifBean();
//				System.out.println("request =========="+request.getAttribute("test"+i));
				String temp=requestParams.get("test"+i)[0];
				
				disposalarray.add(temp);
//				System.out.println(disposalarray.get(i));
			}
			boolean Status=disposalDAO.edit(sqlStartDate,getCmbtype(),getDescription(),session,getMode(),getDocno(),getTrno(),disposalarray,getFormdetailcode(),getClientacno(),getClient(),getBrchName());
			if(Status){
				setValues(sqlStartDate,getHidbranch(),getDocno(),getTrno(),getVocno());//System.out.println("brand"+brand);
				setMsg("Updated Successfully");

				return "success";
			}
			else{
				setValues(sqlStartDate,getHidbranch(),getDocno(),getTrno(),getVocno());
				setMsg("Not Updated");

				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			
			//System.out.println(getDocno()+","+getBrand()+","+getDate_brand());
			boolean Status=disposalDAO.delete(sqlStartDate,getCmbtype(),getDescription(),session,getMode(),getDocno(),getTrno(),getFormdetailcode(),getClientacno(),getBrchName());
		if(Status){
			//setBra(getBrand());
			setValues(sqlStartDate,getHidbranch(),getDocno(),getTrno(),getVocno());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");

			return "success";
		}
		else{
			setValues(sqlStartDate,getHidbranch(),getDocno(),getTrno(),getVocno());
			setMsg("Not Deleted");

			return "fail";
		}
		}
		return "fail";
	}
	
	

	public String printAction() throws SQLException{
		System.out.println("in print action");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		request.getSession();
		setUrl(objcommon.getPrintPath("VSI"));
		String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
		String trno=request.getParameter("trno")==null?"0":request.getParameter("trno");
		String dtype=request.getParameter("dtype")==null?"0":request.getParameter("dtype");
		System.out.println("dtype"+dtype);
		bean=disposalDAO.getPrint(docno);
		setEasycmpname(bean.getEasycmpname());
		setLblclientcode(bean.getLblclientcode());
		setLblclientname(bean.getLblclientname());
		
		setLbladdress1(bean.getLbladdress1());
		setLbladdress2(bean.getLbladdress2());
		setLblmobile(bean.getLblmobile());
		setLblphone(bean.getLblphone());
		setLbltotal(bean.getLbltotal());
		setLblamountwords(bean.getLblamountwords());
		setLbllocation(bean.getLbllocation());
		setLblcheckedby(bean.getLblcheckedby());
		setLblfinaldate(bean.getLblfinaldate());
		setLblprintname1("Tax Invoice");
		setLbltaxamtwrds(bean.getLbltaxamtwrds());
		setLbltype(bean.getLbltype());
		setLbldesc(bean.getLbldesc());
		setLbldate(bean.getLbldate());
		setLbldocno(bean.getLbldocno());
		setLblcompname(bean.getLblcompname());
		setLblcompaddress(bean.getLblcompaddress());
		setLblcompemail(bean.getLblcompemail());
		setLblprintname("Tax Vehicle Sales Invoice");
		setLblcompfax(bean.getLblcompfax());
		setLblcomptel(bean.getLblcomptel());
		setLblbranch(bean.getLblbranch());
		ArrayList<String> saleinvprint=disposalDAO.getSaleInvPrint(docno);
		for(int i=0;i<=saleinvprint.size()-1;i++){
//			System.out.println(saleinvprint.get(i));
		}
		request.setAttribute("INVPRINT", saleinvprint);
		ArrayList<String> jvprint=disposalDAO.getJvPrint(trno);
		request.setAttribute("JVPRINT", jvprint);
		//In case of progress showing fleet_no,chassis no along with regno and platecode
		ArrayList<String> saleinvprint2=disposalDAO.getSaleInvPrint2(docno);
		request.setAttribute("INVPRINT2", saleinvprint2);
		ArrayList<String> psaleinvprint=disposalDAO.getPsaleInvPrint(docno);
		request.setAttribute("INVPRINT3", psaleinvprint);
		setJvsize(Integer.parseInt(jvprint.get(jvprint.size()-1).split("::")[0]));
		String strjvprinttotal=disposalDAO.getJvPrinttotal(trno);
		setLbldebittotal(strjvprinttotal.split("::")[0]);
		setLblcredittotal(strjvprinttotal.split("::")[1]);
		setLblcomptrn(bean.getLblcomptrn());
		setLblclienttrn(bean.getLblclienttrn());
		setLbltaxtotal(bean.getLbltaxtotal());
		
		Double tax=Double.parseDouble(bean.getLbltaxtotal());
	
		if(tax>0){
			setLblvat("VAT (5%) :");
		}else{
			setLblvat("VAT (0%) :");
		}
		setLblnettaxtotal(bean.getLblnettaxtotal());
	
	
		if(objcommon.getPrintPath(dtype).contains(".jrxml")==true)
		{
			
			 ClsConnection conobj=new ClsConnection();
	    	   param = new HashMap();
	    	   Connection conn = null;
	    	   conn = conobj.getMyConnection();	   
	    	   
	    	  
	    	   try{
	    		   conn.createStatement();
	    		 
	    		   String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
	    		   imgpath=imgpath.replace("\\", "\\\\");
	    		 /*  String imgfooter=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
	    		   imgfooter=imgfooter.replace("\\", "\\\\");
	    		   */
	    		
	    		   param.put("docno", docno);
	    		   param.put("imgpath", imgpath);
	    		 //  param.put("imgfooter", imgfooter);
	    		   param.put("invno", getLbldocno());
	    		   param.put("date", getLbldate());
	    		   param.put("netamt", getLblnettaxtotal());
	    		   param.put("compname", getLblcompname());
	    		   param.put("compaddress",getLblcompaddress());
	    		   param.put("comptrn", getLblcomptrn());
	    		   param.put("compemail", getLblcompemail());
	    		   param.put("clientname", getLblclientname());
	    		   param.put("clienttrn", getLblclienttrn());
	    		   param.put("total", getLbltotal());
	    		   param.put("taxamt", getLbltaxtotal());
	    		   param.put("remark", getLbldesc());
	    		   param.put("chargeableamtwords", getLblamountwords());
	    		   param.put("vatamtwords", getLbltaxamtwrds());
	    		   param.put("clientaddress", getLbladdress1());
	    		   param.put("comptel", getLblcomptel());
	    		   param.put("compfax", getLblcompfax());
	    		   param.put("compbranch",getLblbranch());
	    		   
	    		   
	    		   
	    		   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(objcommon.getPrintPath(dtype)));	      	     	 
	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
	               generateReportPDF(response, param, jasperReport, conn);
	    	   }catch (Exception e) {
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
		public String getEasycmpname() {
			return easycmpname;
		}
		public void setEasycmpname(String easycmpname) {
			this.easycmpname = easycmpname;
		}
		


	
	
	
	
	}
	


	
