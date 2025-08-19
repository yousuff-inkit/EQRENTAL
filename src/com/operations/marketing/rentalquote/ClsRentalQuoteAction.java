package com.operations.marketing.rentalquote;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
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

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
import com.operations.marketing.rentalcontract.ClsRentalContractBean;
import com.operations.marketing.rentalcontract.ClsRentalContractDAO;

public class ClsRentalQuoteAction extends ActionSupport {
	ClsRentalQuoteDAO dao = new ClsRentalQuoteDAO();
	ClsConnection objconn = new ClsConnection();
	ClsCommon objcommon = new ClsCommon();

	private String docno, url, vocno, cldocno, clientdetails, date,
			contactperson, contactnumber, attention, subject, desc, delcharges,collcharges,vatamt,totalamt,delremark,
			srvcharges,srvdesc,
			mode, deleted, msg, formdetailcode;
	private int gridlength,cptrno;;
	private String chkstatus;

	private String lblclient, lblclientaddress, lblmob, lblemail, lbldate,
			lbltypep;
	private String lblcompname, lblcompaddress, lblcomptel, lblcompfax,
			lblbranch, lbllocation;
	private String lblsalclient;
	private String lblsalmob;
	private String lblcstno, lblservicetax, lblpan, lbltinno;
	private String lblprintname;

	public String getLblprintname() {
		return lblprintname;
	}

	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getLblclient() {
		return lblclient;
	}

	public void setLblclient(String lblclient) {
		this.lblclient = lblclient;
	}

	public String getLblclientaddress() {
		return lblclientaddress;
	}

	public void setLblclientaddress(String lblclientaddress) {
		this.lblclientaddress = lblclientaddress;
	}

	public String getLblmob() {
		return lblmob;
	}

	public void setLblmob(String lblmob) {
		this.lblmob = lblmob;
	}

	public String getLblemail() {
		return lblemail;
	}

	public void setLblemail(String lblemail) {
		this.lblemail = lblemail;
	}

	public String getLbldate() {
		return lbldate;
	}

	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}

	public String getLbltypep() {
		return lbltypep;
	}

	public void setLbltypep(String lbltypep) {
		this.lbltypep = lbltypep;
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

	public String getLblsalclient() {
		return lblsalclient;
	}

	public void setLblsalclient(String lblsalclient) {
		this.lblsalclient = lblsalclient;
	}

	public String getLblsalmob() {
		return lblsalmob;
	}

	public void setLblsalmob(String lblsalmob) {
		this.lblsalmob = lblsalmob;
	}

	public String getLblcstno() {
		return lblcstno;
	}

	public void setLblcstno(String lblcstno) {
		this.lblcstno = lblcstno;
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

	public String getLbltinno() {
		return lbltinno;
	}

	public void setLbltinno(String lbltinno) {
		this.lbltinno = lbltinno;
	}

	public String getChkstatus() {
		return chkstatus;
	}

	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	public int getCptrno() {
		return cptrno;
	}

	public void setCptrno(int cptrno) {
		this.cptrno = cptrno;
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

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getContactperson() {
		return contactperson;
	}

	public void setContactperson(String contactperson) {
		this.contactperson = contactperson;
	}

	public String getContactnumber() {
		return contactnumber;
	}

	public void setContactnumber(String contactnumber) {
		this.contactnumber = contactnumber;
	}

	public String getAttention() {
		return attention;
	}

	public void setAttention(String attention) {
		this.attention = attention;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
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

	public String getDelcharges() {
		return delcharges;
	}

	public void setDelcharges(String delcharges) {
		this.delcharges = delcharges;
	}
	
	public String getCollcharges() {
		return collcharges;
	}
	
	public void setCollcharges(String collcharges) {
		this.collcharges = collcharges;
	}
	
	public String getVatamt() {
		return vatamt;
	}
	
	public void setVatamt(String vatamt) {
		this.vatamt = vatamt;
	}
	
	public String getTotalamt() {
		return totalamt;
	}
	
	public void setTotalamt(String totalamt) {
		this.totalamt = totalamt;
	}
	
	public String getDelremark() {
		return delremark;
	}
	
	public void setDelremark(String delremark) {
		this.delremark = delremark;
	}

	public String getSrvcharges() {
		return srvcharges;
	}
	
	public void setSrvcharges(String srvcharges) {
		this.srvcharges = srvcharges;
	}
	
	public String getSrvdesc() {
		return srvdesc;
	}
	
	public void setSrvdesc(String srvdesc) {
		this.srvdesc = srvdesc;
	}
	
	private Map<String, Object> param = null;

	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	public void setData(String docno, String vocno, java.sql.Date sqldate) {
		setDocno(docno);
		setVocno(vocno);
		setDate(sqldate.toString());
		setCldocno(getCldocno());
		setClientdetails(getClientdetails());
		setCptrno(getCptrno());
		setContactperson(getContactperson());
		setContactnumber(getContactnumber());
		setAttention(getAttention());
		setSubject(getSubject());
		setDesc(getDesc());
		setDelcharges(getDelcharges());
		setCollcharges(getCollcharges());
		setVatamt(getVatamt());
		setTotalamt(getTotalamt());
		setDelremark(getDelremark());
		setSrvcharges(getSrvcharges());
		setSrvdesc(getSrvdesc());
	}

	public String saveAction() throws SQLException {

		ClsRentalQuoteAction masteraction = new ClsRentalQuoteAction();
		HttpServletRequest request = ServletActionContext.getRequest();
		Map<String, String[]> requestParams = request.getParameterMap();
		HttpSession session = request.getSession();

		String mode = getMode();
		masteraction.setCldocno(getCldocno());
		masteraction.setClientdetails(getClientdetails());
		masteraction.setCptrno(getCptrno());
		masteraction.setContactnumber(getContactnumber());
		masteraction.setContactperson(getContactperson());
		masteraction.setAttention(getAttention());
		masteraction.setSubject(getSubject());
		masteraction.setDesc(getDesc());
		masteraction.setFormdetailcode(getFormdetailcode());
		masteraction.setDelcharges(getDelcharges());
		masteraction.setCollcharges(getCollcharges());
		masteraction.setVatamt(getVatamt());
		masteraction.setTotalamt(getTotalamt());
		masteraction.setDelremark(getDelremark());
		masteraction.setSrvcharges(getSrvcharges());
		masteraction.setSrvdesc(getSrvdesc());
		ClsConnection objconn = new ClsConnection();
		ClsCommon objcommon = new ClsCommon();

		if (mode.equalsIgnoreCase("A")) {
			ArrayList<String> quotarray = new ArrayList<>();
			for (int i = 0; i < getGridlength(); i++) {
				String temp2 = requestParams.get("quottest" + i)[0];
				quotarray.add(temp2);
			}
			Connection conn = null;
			try {
				conn = objconn.getMyConnection();
				conn.setAutoCommit(false);
				java.sql.Date sqldate = null;
				if (!getDate().equalsIgnoreCase("")
						&& !getDate().equalsIgnoreCase("undefined")
						&& getDate() != null) {
					sqldate = objcommon.changeStringtoSqlDate(getDate());
				}
				int docno = dao.insert(masteraction, session, request, conn,
						sqldate, quotarray, getFormdetailcode());
				if (docno > 0) {
					setData(docno + "", request.getAttribute("VOCNO")
							.toString(), sqldate);
					setMsg("Successfully Saved");
					conn.commit();
					return "success";
				} else {
					setData("0", "0", sqldate);
					setMsg("Not Saved");
					return "fail";
				}
			} catch (Exception e) {
				e.printStackTrace();
				conn.close();
			} finally {
				conn.close();
			}

		} else if (mode.equalsIgnoreCase("E")) {
			ArrayList<String> quotarray = new ArrayList<>();
			for (int i = 0; i < getGridlength(); i++) {
				String temp2 = requestParams.get("quottest" + i)[0];
				quotarray.add(temp2);
			}
			Connection conn = null;
			try {
				conn = objconn.getMyConnection();
				conn.setAutoCommit(false);
				java.sql.Date sqldate = null;
				if (!getDate().equalsIgnoreCase("")
						&& !getDate().equalsIgnoreCase("undefined")
						&& getDate() != null) {
					sqldate = objcommon.changeStringtoSqlDate(getDate());
				}
				// Checking Quote Approved
				String strsql = "select count(*) itemcount from gl_rentalquotecalc where rdocno="
						+ docno + " and approved=1";
				ResultSet rs = conn.createStatement().executeQuery(strsql);
				int itemcount = 0;
				while (rs.next()) {
					itemcount = rs.getInt("itemcount");
				}
				if (itemcount > 0) {
					setData(getDocno(), getVocno(), sqldate);
					setMsg("Quote Approved,Cannot Edit");
					setChkstatus("2");
					return "fail";
				}
				boolean status = dao.edit(masteraction, session, request, conn,
						sqldate, quotarray, getFormdetailcode(), getDocno());
				if (status) {
					setData(getDocno(), getVocno(), sqldate);
					setMsg("Updated Successfully");
					conn.commit();
					return "success";
				} else {
					setData(getDocno(), getVocno(), sqldate);
					setMsg("Not Updated");
					return "fail";
				}
			} catch (Exception e) {
				e.printStackTrace();
				conn.close();
			} finally {
				conn.close();
			}
		} else if (mode.equalsIgnoreCase("D")) {

			Connection conn = null;
			try {
				conn = objconn.getMyConnection();
				conn.setAutoCommit(false);
				java.sql.Date sqldate = null;
				if (!getDate().equalsIgnoreCase("")
						&& !getDate().equalsIgnoreCase("undefined")
						&& getDate() != null) {
					sqldate = objcommon.changeStringtoSqlDate(getDate());
				}
				boolean status = dao.delete(masteraction, session, request,
						conn, getFormdetailcode(), getDocno());
				if (status) {
					setData(getDocno(), getVocno(), sqldate);
					setMsg("Successfully Deleted");
					conn.commit();
					return "success";
				} else {
					setData(getDocno(), getVocno(), sqldate);
					setMsg("Not Deleted");
					return "fail";
				}
			} catch (Exception e) {
				e.printStackTrace();
				conn.close();
			} finally {
				conn.close();
			}
		} else if (mode.equalsIgnoreCase("view")) {
			ClsRentalQuoteBean bean = dao.getViewDetails(getDocno());
			setDocno(bean.getDocno());
			setVocno(bean.getVocno());
			setDate(bean.getDate());
			setCldocno(bean.getCldocno());
			setClientdetails(bean.getClientdetails());
			setCptrno(bean.getCptrno());
			setContactperson(bean.getContactperson());
			setContactnumber(bean.getContactnumber());
			setAttention(bean.getAttention());
			setSubject(bean.getSubject());
			setDesc(bean.getDesc());
			setDelcharges(bean.getDelcharges());
			setCollcharges(bean.getCollcharges());
			setVatamt(bean.getVatamt());
			setTotalamt(bean.getTotalamt());
			setDelremark(bean.getDelremark());
			setSrvcharges(bean.getSrvcharges());
			setSrvdesc(bean.getSrvdesc());
			return "success";
		}
		return "fail";
	}

	public String printAction() throws ParseException, SQLException {
		HttpServletRequest request = ServletActionContext.getRequest();
		// HttpServletResponse response=ServletActionContext.getResponse();
		int doc = Integer.parseInt(request.getParameter("docno"));
		String ckhval = request.getParameter("ckhval") == null ? "NA" : request
				.getParameter("ckhval");
		ClsRentalQuoteBean pintbean = new ClsRentalQuoteBean();
		pintbean = dao.getPrint(doc, request);

		// cl details

		setLblsalclient(pintbean.getLblsalclient());
		setLblsalmob(pintbean.getLblsalmob());
		setLblclient(pintbean.getLblclient());
		setLblclientaddress(pintbean.getLblclientaddress());
		setLblmob(pintbean.getLblmob());
		setLblemail(pintbean.getLblemail());
		// upper
		setLbldate(pintbean.getLbldate());
		setLbltypep(pintbean.getLbltypep());
		setDocno(pintbean.getDocno());
		setVocno(pintbean.getVocno());
		/* request.setAttribute("details",arraylist); */

		setLblprintname("Quotation");
		setLblbranch(pintbean.getLblbranch());
		setLblcompname(pintbean.getLblcompname());

		setLblcompaddress(pintbean.getLblcompaddress());

		setLblcomptel(pintbean.getLblcomptel());

		setLblcompfax(pintbean.getLblcompfax());
		setLbllocation(pintbean.getLbllocation());

		/*
		 * setFirstarray(pintbean.getFirstarray());
		 * setSecarray(pintbean.getSecarray());
		 * 
		 * 
		 * setGeneralterms(pintbean.getGeneralterms());
		 * setTerms1(pintbean.getTerms1()); setTerms2(pintbean.getTerms2());
		 */
		// bean.setGeneralterms(pintrs.getString("glterms"));

		// bean.setTerms1("General Terms And Conditions" );

		setLblcstno(pintbean.getLblcstno());
		setLblservicetax(pintbean.getLblservicetax());
		setLblpan(pintbean.getLblpan());
		ClsCommon objcommon = new ClsCommon();
		setUrl(objcommon.getPrintPath("QOT"));
		return "print";
	}

	public String printQtAction() throws Exception {
		System.out.println("PRINT ACTION");
		Connection conn = null;
		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			HttpSession session = request.getSession();
			ClsRentalContractBean bean = new ClsRentalContractBean();
			ClsRentalContractDAO DAO = new ClsRentalContractDAO();
			
			String docno = request.getParameter("docno").toString();
			// String brhid=request.getParameter("branch").toString();
			// String mail=request.getAttribute("mail")==null ||
			// request.getAttribute("mail").toString().equalsIgnoreCase("")?"0":request.getAttribute("mail").toString();
			// beans=DAO.printMaster(docno,request);

			if (objcommon.getPrintPath("QOT").contains(".jrxml")) {
				HttpServletResponse response = ServletActionContext
						.getResponse();

				String reportFileName = "";

				param = new HashMap();

				conn = objconn.getMyConnection();
				Statement stmt=conn.createStatement();
				ClsAmountToWords amtobj = new ClsAmountToWords();

				setUrl(objcommon.getPrintPath("QOT"));
				
				
				String imglogo = request.getSession().getServletContext().getRealPath("/icons/cityheader.png");
				imglogo = imglogo.replace("\\", "\\\\");

				String watermark = request.getSession().getServletContext().getRealPath("/icons/draft.png");
				watermark = watermark.replace("\\", "\\\\");

				String username="";
				String userid=session.getAttribute("USERID").toString();
				ResultSet rs=stmt.executeQuery("SELECT user_name FROM my_user WHERE doc_no="+userid);
				while(rs.next()){
					username=rs.getString("user_name");
				}
				
				String amtSql="SELECT m.brhid,m.status,round((d.totalamt+m.totalamt),2)totalamt from gl_rentalquotem m "
+"left join (select round(sum(coalesce(nettotal,0)),2) totalamt,rdocno from gl_rentalquoted group by rdocno) d on d.rdocno=m.doc_no " 
+"where m.doc_no="+docno;
				String totalAmt="";
				String branch="";
				Integer quotStatus=null;
				ResultSet amtrs=stmt.executeQuery(amtSql);
				while(amtrs.next()){
					totalAmt=amtrs.getString("totalamt");
					branch=amtrs.getString("brhid");
					quotStatus=amtrs.getInt("status");
				}
			
				if(branch.equalsIgnoreCase("1")){
					String branch1header = request.getSession().getServletContext().getRealPath("/icons/branch1header.jpg");
					branch1header =branch1header.replace("\\", "\\\\");	
					String branch1footer = request.getSession().getServletContext().getRealPath("/icons/branch1footer.jpg");
					branch1footer =branch1footer.replace("\\", "\\\\");
					param.put("branchheader", branch1header);
					param.put("branchfooter", branch1footer);
				}
				else if(branch.equalsIgnoreCase("2")){
					String branch2header = request.getSession().getServletContext().getRealPath("/icons/branch2header.jpg");
					branch2header =branch2header.replace("\\", "\\\\");	
					String branch2footer = request.getSession().getServletContext().getRealPath("/icons/branch2footer.jpg");
					branch2footer =branch2footer.replace("\\", "\\\\");
					param.put("branchheader", branch2header);
					param.put("branchfooter", branch2footer);
				}
				else if(branch.equalsIgnoreCase("3")){
					String branch3header = request.getSession().getServletContext().getRealPath("/icons/branch3header.jpg");
					branch3header =branch3header.replace("\\", "\\\\");	
					String branch3footer = request.getSession().getServletContext().getRealPath("/icons/branch3footer.jpg");
					branch3footer =branch3footer.replace("\\", "\\\\");
					param.put("branchheader", branch3header);
					param.put("branchfooter", branch3footer);
				}
				
				// String
				// footerimgpath=request.getSession().getServletContext().getRealPath("/icons/cityfooter.jpg");
				// footerimgpath=footerimgpath.replace("\\", "\\\\");
				//param.put("amtobj", amtobj);
				if(quotStatus<3)
					param.put("watermark", watermark);
				param.put("imglogo", imglogo);
				param.put("docno", docno);
				param.put("username", username);
				param.put("amountinword", amtobj.convertAmountToWords(totalAmt));
				param.put("brhid", branch);
                System.out.println("Branch===="+branch);
				// param.put("footerimgpath", footerimgpath);

				JasperDesign design = JRXmlLoader.load(request.getSession()
						.getServletContext().getRealPath(getUrl()));

				JasperReport jasperReport = JasperCompileManager
						.compileReport(design);

				generateReportPDF(response, param, jasperReport, conn);

			}
		} catch (Exception e) {

			e.printStackTrace();

		} finally {
			if (conn != null) {
				conn.close();
			}
		}

		return "print";
	}

	private void generateReportPDF(HttpServletResponse resp, Map parameters,
			JasperReport jasperReport, Connection conn) throws JRException,
			NamingException, SQLException, IOException {
		byte[] bytes = null;
		bytes = JasperRunManager.runReportToPdf(jasperReport, parameters, conn);
		resp.reset();
		resp.resetBuffer();

		resp.setContentType("application/pdf");
		resp.setContentLength(bytes.length);
		ServletOutputStream ouputStream = resp.getOutputStream();
		ouputStream.write(bytes, 0, bytes.length);

		ouputStream.flush();
		ouputStream.close();
	}

}
