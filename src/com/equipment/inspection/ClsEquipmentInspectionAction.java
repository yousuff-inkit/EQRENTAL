package com.equipment.inspection;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.naming.NamingException;
import javax.servlet.ServletContext;
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
import com.common.ClsEncrypt;
import com.connection.ClsConnection;
import com.mailwithpdf.EmailProcess;
import com.mailwithpdf.SendEmailAction;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsEquipmentInspectionAction extends ActionSupport {
	ClsEquipmentInspectionDAO inspectionDAO = new ClsEquipmentInspectionDAO();
	ClsEquipmentInspectionBean bean;
	ClsEquipmentInspectionBean beannew;
	ClsEquipmentInspectionBean beansign;
	ClsConnection objconn = new ClsConnection();
	ClsCommon objcommon = new ClsCommon();
	private Map<String, Object> par = null;
	private int docno;
	private String refvoucherno;
	private String brchName;
	private String date;
	private String hiddate;
	private String cmbtype;
	private String hidcmbtype;
	private String cmbreftype;
	private String hidcmbreftype;
	private int rdocno;
	private String amount;
	private String accdate;
	private String hidaccdate;
	private String prcs;
	private String collectdate;
	private String hidcollectdate;
	private String accplace;
	private String accfines;
	private String cmbclaim;
	private String hidcmbclaim;
	private String msg;
	private String mode;
	private String deleted;
	private String formdetail;
	private String formdetailcode;
	private String hidaccidents;
	private String accremarks;
	private String rfleet;
	private int damagegridlength;
	private int maintenancegridlength;
	private int existdamagegridlength;
	private String time;
	private String hidtime;
	private String cmbagmtbranch;
	private String hidcmbagmtbranch;
	private String regno;
	private String client;
	private String lblregno;
	private String lblfleetname;

	public String getLblregno() {
		return lblregno;
	}

	public void setLblregno(String lblregno) {
		this.lblregno = lblregno;
	}

	public String getLblfleetname() {
		return lblfleetname;
	}

	public void setLblfleetname(String lblfleetname) {
		this.lblfleetname = lblfleetname;
	}

	public String getRegno() {
		return regno;
	}

	public void setRegno(String regno) {
		this.regno = regno;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getCmbagmtbranch() {
		return cmbagmtbranch;
	}

	public void setCmbagmtbranch(String cmbagmtbranch) {
		this.cmbagmtbranch = cmbagmtbranch;
	}

	public String getHidcmbagmtbranch() {
		return hidcmbagmtbranch;
	}

	public void setHidcmbagmtbranch(String hidcmbagmtbranch) {
		this.hidcmbagmtbranch = hidcmbagmtbranch;
	}

	// Save File
	private File file;
	private String fileFileName;
	private String fileFileContentType;
	private String message = "";

	// Print

	private String lblcompname;
	private String lblcompaddress;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbldocno;
	private String lbldate;
	private String lbltime;
	private String lbltype;
	private String lblreftype;
	private String lblreffleetno;
	private String lblrefdocno;
	private String lblaccdate;
	private String lblprcs;
	private String lblcoldate;
	private String lblplace;
	private String lblfines;
	private String lblclaim;
	private String lblremarks;
	private String lblamount;
	private String lblaccident;
	private String lblprintname;
	private String lblhidexisting;
	private String lblhidnew;
	private String lblurl;

	public String getBrchName() {
		return brchName;
	}

	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}

	public String getRefvoucherno() {
		return refvoucherno;
	}

	public void setRefvoucherno(String refvoucherno) {
		this.refvoucherno = refvoucherno;
	}

	public String getLblurl() {
		return lblurl;
	}

	public void setLblurl(String lblurl) {
		this.lblurl = lblurl;
	}

	public String getLblhidexisting() {
		return lblhidexisting;
	}

	public void setLblhidexisting(String lblhidexisting) {
		this.lblhidexisting = lblhidexisting;
	}

	public String getLblhidnew() {
		return lblhidnew;
	}

	public void setLblhidnew(String lblhidnew) {
		this.lblhidnew = lblhidnew;
	}

	public String getLblprintname() {
		return lblprintname;
	}

	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}

	public String getLblaccident() {
		return lblaccident;
	}

	public void setLblaccident(String lblaccident) {
		this.lblaccident = lblaccident;
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

	public String getLbltime() {
		return lbltime;
	}

	public void setLbltime(String lbltime) {
		this.lbltime = lbltime;
	}

	public String getLbltype() {
		return lbltype;
	}

	public void setLbltype(String lbltype) {
		this.lbltype = lbltype;
	}

	public String getLblreftype() {
		return lblreftype;
	}

	public void setLblreftype(String lblreftype) {
		this.lblreftype = lblreftype;
	}

	public String getLblreffleetno() {
		return lblreffleetno;
	}

	public void setLblreffleetno(String lblreffleetno) {
		this.lblreffleetno = lblreffleetno;
	}

	public String getLblrefdocno() {
		return lblrefdocno;
	}

	public void setLblrefdocno(String lblrefdocno) {
		this.lblrefdocno = lblrefdocno;
	}

	public String getLblaccdate() {
		return lblaccdate;
	}

	public void setLblaccdate(String lblaccdate) {
		this.lblaccdate = lblaccdate;
	}

	public String getLblprcs() {
		return lblprcs;
	}

	public void setLblprcs(String lblprcs) {
		this.lblprcs = lblprcs;
	}

	public String getLblcoldate() {
		return lblcoldate;
	}

	public void setLblcoldate(String lblcoldate) {
		this.lblcoldate = lblcoldate;
	}

	public String getLblplace() {
		return lblplace;
	}

	public void setLblplace(String lblplace) {
		this.lblplace = lblplace;
	}

	public String getLblfines() {
		return lblfines;
	}

	public void setLblfines(String lblfines) {
		this.lblfines = lblfines;
	}

	public String getLblclaim() {
		return lblclaim;
	}

	public void setLblclaim(String lblclaim) {
		this.lblclaim = lblclaim;
	}

	public String getLblremarks() {
		return lblremarks;
	}

	public void setLblremarks(String lblremarks) {
		this.lblremarks = lblremarks;
	}

	public String getLblamount() {
		return lblamount;
	}

	public void setLblamount(String lblamount) {
		this.lblamount = lblamount;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	public String getFileFileContentType() {
		return fileFileContentType;
	}

	public void setFileFileContentType(String fileFileContentType) {
		this.fileFileContentType = fileFileContentType;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getHidtime() {
		return hidtime;
	}

	public void setHidtime(String hidtime) {
		this.hidtime = hidtime;
	}

	public int getExistdamagegridlength() {
		return existdamagegridlength;
	}

	public void setExistdamagegridlength(int existdamagegridlength) {
		this.existdamagegridlength = existdamagegridlength;
	}

	public int getDamagegridlength() {
		return damagegridlength;
	}

	public void setDamagegridlength(int damagegridlength) {
		this.damagegridlength = damagegridlength;
	}

	public int getMaintenancegridlength() {
		return maintenancegridlength;
	}

	public void setMaintenancegridlength(int maintenancegridlength) {
		this.maintenancegridlength = maintenancegridlength;
	}

	public String getRfleet() {
		return rfleet;
	}

	public void setRfleet(String rfleet) {
		this.rfleet = rfleet;
	}

	public String getAccremarks() {
		return accremarks;
	}

	public void setAccremarks(String accremarks) {
		this.accremarks = accremarks;
	}

	public String getHidaccidents() {
		return hidaccidents;
	}

	public void setHidaccidents(String hidaccidents) {
		this.hidaccidents = hidaccidents;
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

	public String getCmbreftype() {
		return cmbreftype;
	}

	public void setCmbreftype(String cmbreftype) {
		this.cmbreftype = cmbreftype;
	}

	public String getHidcmbreftype() {
		return hidcmbreftype;
	}

	public void setHidcmbreftype(String hidcmbreftype) {
		this.hidcmbreftype = hidcmbreftype;
	}

	public int getRdocno() {
		return rdocno;
	}

	public void setRdocno(int rdocno) {
		this.rdocno = rdocno;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getAccdate() {
		return accdate;
	}

	public void setAccdate(String accdate) {
		this.accdate = accdate;
	}

	public String getHidaccdate() {
		return hidaccdate;
	}

	public void setHidaccdate(String hidaccdate) {
		this.hidaccdate = hidaccdate;
	}

	public String getPrcs() {
		return prcs;
	}

	public void setPrcs(String prcs) {
		this.prcs = prcs;
	}

	public String getCollectdate() {
		return collectdate;
	}

	public void setCollectdate(String collectdate) {
		this.collectdate = collectdate;
	}

	public String getHidcollectdate() {
		return hidcollectdate;
	}

	public void setHidcollectdate(String hidcollectdate) {
		this.hidcollectdate = hidcollectdate;
	}

	public String getAccplace() {
		return accplace;
	}

	public void setAccplace(String accplace) {
		this.accplace = accplace;
	}

	public String getAccfines() {
		return accfines;
	}

	public void setAccfines(String accfines) {
		this.accfines = accfines;
	}

	public String getCmbclaim() {
		return cmbclaim;
	}

	public void setCmbclaim(String cmbclaim) {
		this.cmbclaim = cmbclaim;
	}

	public String getHidcmbclaim() {
		return hidcmbclaim;
	}

	public void setHidcmbclaim(String hidcmbclaim) {
		this.hidcmbclaim = hidcmbclaim;
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

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public String getFormdetail() {
		return formdetail;
	}

	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String saveAction() throws ParseException, SQLException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		session.getAttribute("BranchName");

		String mode = getMode();
		ClsEquipmentInspectionBean bean = new ClsEquipmentInspectionBean();
		java.sql.Date date = null;
		java.sql.Date accdate = null;
		java.sql.Date collectdate = null;

		if ((mode.equalsIgnoreCase("A")) || mode.equalsIgnoreCase("D")) {
			date = objcommon.changeStringtoSqlDate(getDate());
			if (getAccdate() != null) {
				accdate = objcommon.changeStringtoSqlDate(getAccdate());
			}
			if (getCollectdate() != null) {
				collectdate = objcommon.changeStringtoSqlDate(getCollectdate());
			}
		}

		if (mode.equalsIgnoreCase("A")) {
			// System.out.println("Insert Mode");
			ArrayList<String> damagearray = new ArrayList<>();
			ArrayList<String> maintenancearray = new ArrayList<>();
			ArrayList<String> existdamagearray = new ArrayList<>();
			for (int i = 0; i < getDamagegridlength(); i++) {
				String temp = requestParams.get("test" + i)[0];
				damagearray.add(temp);
				// System.out.println(damagearray.get(i));
			}
			for (int i = 0; i < getMaintenancegridlength(); i++) {
				String temp = requestParams.get("testmaint" + i)[0];
				maintenancearray.add(temp);
				// System.out.println(damagearray.get(i));
			}
			for (int i = 0; i < getExistdamagegridlength(); i++) {
				String temp = requestParams.get("testexistdamage" + i)[0];
				existdamagearray.add(temp);
				// System.out.println(damagearray.get(i));
			}
			// System.out.println("Inside Action Mode A");
			int val = inspectionDAO.insert(date, getCmbtype(), getCmbreftype(),
					getRdocno(), accdate, getPrcs(), collectdate,
					getAccplace() == null ? "" : getAccplace(),
					getAccfines() == null ? "0" : getAccfines(),
					getCmbclaim() == null ? "0" : getCmbclaim(),
					getAmount() == null ? "0" : getAmount(),
					getFormdetailcode(), getHidaccidents(), getAccremarks(),
					session, getMode(), getRfleet(), damagearray,
					maintenancearray, existdamagearray, getTime(),
					getRefvoucherno(), getBrchName(), getCmbagmtbranch());
			if (val > 0.0) {
				// System.out.println(val);
				setHidcmbagmtbranch(getCmbagmtbranch());
				setHiddate(date.toString());
				setHidcmbtype(getCmbtype());
				setHidcmbreftype(getCmbreftype());
				setRdocno(getRdocno());
				setHidaccidents(getHidaccidents());
				if (getHidaccidents().equalsIgnoreCase("1")) {
					setHidaccdate(accdate.toString());
					setPrcs(getPrcs());
					setHidcollectdate(collectdate.toString());
					setAccplace(getAccplace());
					setAccfines(getAccfines());
					setHidcmbclaim(getCmbclaim());
					setAmount(getAmount());
					setAccremarks(getAccremarks());
				}

				setRfleet(getRfleet());
				setMode(getMode());
				setHidtime(getTime());
				setDocno(val);
				setRefvoucherno(getRefvoucherno());
				setClient(getClient());
				setRegno(getRegno());
				setMsg("Successfully Saved");

				return "success";
			} else {
				setHidcmbagmtbranch(getCmbagmtbranch());
				setHiddate(date.toString());
				setHidcmbtype(getCmbtype());
				setHidcmbreftype(getCmbreftype());
				setRdocno(getRdocno());
				setHidaccidents(getHidaccidents());
				if (getHidaccidents().equalsIgnoreCase("1")) {
					setHidaccdate(accdate.toString());
					setPrcs(getPrcs());
					setHidcollectdate(collectdate.toString());
					setAccplace(getAccplace());
					setAccfines(getAccfines());
					setHidcmbclaim(getCmbclaim());
					setAmount(getAmount());
					setAccremarks(getAccremarks());
				}
				setRfleet(getRfleet());
				setMode(getMode());
				setDocno(val);
				setClient(getClient());
				setRegno(getRegno());
				setMsg("Not Saved");

				return "fail";
			}
		} else if (mode.equalsIgnoreCase("View")) {

			bean = inspectionDAO.getViewDetails(getDocno());
			setHidcmbagmtbranch(bean.getHidcmbagmtbranch());
			setDate(bean.getDate());
			setHidcmbtype(bean.getHidcmbtype());
			setHidcmbreftype(bean.getHidcmbreftype());
			setRdocno(bean.getRdocno());
			setAccdate(bean.getAccdate());
			setPrcs(bean.getPrcs());
			setCollectdate(bean.getCollectdate());
			setAccplace(bean.getAccplace());
			setAccfines(bean.getAccfines());
			setHidcmbclaim(bean.getHidcmbclaim());
			setAmount(bean.getAmount());
			setHidaccidents(bean.getHidaccidents());
			setAccremarks(bean.getAccremarks());
			setRfleet(bean.getRfleet());
			setClient(bean.getClient());
			setRegno(bean.getRegno());
			return "success";
		} else if (mode.equalsIgnoreCase("D")) {
			// System.out.println("Delete Mode");
			boolean value = inspectionDAO.delete(date, getCmbtype(),
					getCmbreftype(), getRdocno(), accdate, getPrcs(),
					collectdate, getAccplace(), getAccfines(), getCmbclaim(),
					getAmount(), getFormdetailcode(), getHidaccidents(),
					getAccremarks(), session, getMode(), getRfleet(),
					getDocno(), getTime());
			if (value) {
				setHidcmbagmtbranch(getCmbagmtbranch());
				if (date != null) {
					setHiddate(date.toString());
				}

				setHidcmbtype(getCmbtype());
				setHidcmbreftype(getCmbreftype());
				setRdocno(getRdocno());
				if (accdate != null) {
					setHidaccdate(accdate.toString());
				}

				setPrcs(getPrcs());
				if (collectdate != null) {
					setHidcollectdate(collectdate.toString());
				}

				setAccplace(getAccplace());
				setAccfines(getAccfines());
				setHidcmbclaim(getCmbclaim());
				setAmount(getAmount());
				setHidaccidents(getHidaccidents());
				setAccremarks(getAccremarks());
				setRfleet(getRfleet());
				setMode(getMode());
				setDocno(getDocno());
				setHidtime(getTime());
				setClient(getClient());
				setRegno(getRegno());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";

			} else {
				setHidcmbagmtbranch(getCmbagmtbranch());
				setHiddate(date.toString());
				setHidcmbtype(getCmbtype());
				setHidcmbreftype(getCmbreftype());
				setRdocno(getRdocno());
				setHidaccdate(accdate.toString());
				setPrcs(getPrcs());
				setHidcollectdate(collectdate.toString());
				setAccplace(getAccplace());
				setAccfines(getAccfines());
				setHidcmbclaim(getCmbclaim());
				setAmount(getAmount());
				setHidaccidents(getHidaccidents());
				setAccremarks(getAccremarks());
				setRfleet(getRfleet());
				setMode(getMode());
				setDocno(getDocno());
				setClient(getClient());
				setRegno(getRegno());
				setMsg("Not Deleted");
				return "fail";

			}
		}

		return "fail";
	}

	public String saveFile() throws Exception {

		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		// System.out.println(" = =========== "+requestParams);
		// session.getAttribute("Code")==null?"Default":session.getAttribute("Code").toString();
		String code = request.getParameter("formdetailcode");
		String doc = request.getParameter("doc");
		String srno = request.getParameter("srno");
		String fname = code + '-' + doc + '-' + srno;
		String fname2 = fname;
		// System.out.println("CODE==="+code);
		// System.out.println("Code"+getFormdetailcode());
		String dirname = getFormdetailcode() == null ? "Default"
				: getFormdetailcode();
		// System.out.println(dirname);
		String path = "";
		Connection conn = objconn.getMyConnection();
		Statement stmt = conn.createStatement();
		String strSql = "select imgPath from my_comp where doc_no="
				+ session.getAttribute("COMPANYID");
		// System.out.println(strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		String path1 = "";
		while (rs.next()) {
			path1 = rs.getString("imgPath");
			// System.out.println("IMGPATH:"+path);
		}
		path = path1.replace("\\", "/");
		ServletContext context = ((HttpSession) request).getServletContext();
		// String path = context.getRealPath("/");

		File dir = new File(path + "/attachment/" + dirname);
		dir.mkdirs();
		//

		// System.out.println("path==============="+path);
		try {
			File f = this.getFile();
			// System.out.println("File///////////"+getFile());
			// System.out.println("FILE==="+getFileFileName());
			if (this.getFileFileName().endsWith(".exe")) {
				message = "not done";
				return ERROR;
			}
			/*
			 * String aa[]=getFileFileName().split("."); System.out.println(aa);
			 */
			int dotindex = getFileFileName().lastIndexOf(".");
			String efile = getFileFileName().substring(dotindex + 1);
			// System.out.println("EEEE"+efile);
			fname = fname + '.' + efile;
			FileInputStream inputStream = new FileInputStream(f);

			FileOutputStream outputStream = new FileOutputStream(path
					+ "/attachment/" + dirname + "/" + fname);
			// System.out.println("path==============="+path+"========="+outputStream);
			byte[] buf = new byte[1024];
			int length = 0;
			while ((length = inputStream.read(buf)) != -1) {
				outputStream.write(buf, 0, length);
			}
			Statement stmtupdate = conn.createStatement();
			String strupdate = "update eq_vinspd set attach='" + fname
					+ "',path='" + path + "/attachment/" + dirname + "/"
					+ fname + "' where rdocno=" + doc + " and srno=" + srno;
			int val = stmtupdate.executeUpdate(strupdate);
			if (val <= 0) {
				return ERROR;
			}
			inputStream.close();
			outputStream.flush();
			this.setMessage(path + fname);
			stmt.close();
			stmtupdate.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			message = "!!!!";
			conn.close();

		}
		return SUCCESS;
	}

	public String printAction() throws ParseException, SQLException {
		// System.out.println("Inside print Action");
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		String fleetno = request.getParameter("fleetno");
		bean = inspectionDAO.getPrint(getDocno());
		setLblcompname(bean.getLblcompname());
		setLblcompaddress(bean.getLblcompaddress());
		setLblcompfax(bean.getLblcompfax());
		setLblcomptel(bean.getLblcomptel());
		setLblbranch(bean.getLblbranch());
		setLbldocno(bean.getLbldocno());
		setLbldate(bean.getLbldate());
		setLbltime(bean.getLbltime());
		setLbltype(bean.getLbltype());
		setLblreftype(bean.getLblreftype());
		setLblrefdocno(bean.getLblrefdocno());
		setLblreffleetno(bean.getLblreffleetno());
		setLblaccident(bean.getLblaccident());
		setLblaccdate(bean.getLblaccdate());
		setLblprcs(bean.getLblprcs());
		setLblcoldate(bean.getLblcoldate());
		setLblplace(bean.getLblplace());
		setLblfines(bean.getLblfines());
		setLblclaim(bean.getLblclaim());
		setLblcoldate(bean.getLblcoldate());
		setLblremarks(bean.getLblremarks());
		setLblamount(bean.getLblamount());
		setLblfleetname(bean.getLblfleetname());
		setLblregno(bean.getLblregno());
		setLblprintname("Equipment Inspection");
		ArrayList<String> existingdamageprint = inspectionDAO
				.getExistingDamagePrint(getDocno(), fleetno);
		request.setAttribute("EXISTINGDAMAGEPRINT", existingdamageprint);
		if (existingdamageprint.size() > 0) {
			setLblhidexisting("1");
		} else {
			setLblhidexisting("0");
		}
		ArrayList<String> newdamageprint = inspectionDAO.getNewDamagePrint(
				getDocno(), fleetno);
		request.setAttribute("NEWDAMAGEPRINT", newdamageprint);
		if (newdamageprint.size() > 0) {
			setLblhidnew("1");
		} else {
			setLblhidnew("0");
		}
		ArrayList<String> damagepics = inspectionDAO.getNewDamagePrintPics(
				getDocno(), fleetno, request.getParameter("lblurl"));
		request.setAttribute("NEWDAMAGEPRINTPICS", damagepics);

		ArrayList<String> insppics = inspectionDAO.getInspectionPrintPics(
				getDocno(), request.getParameter("lblurl"));
		request.setAttribute("NEWINSPPRINTPICS", insppics);

		return "print";
	}

	public String mobilePrintAction(String insp, HttpServletRequest request,
			String agmtno, String agmtype) throws ParseException, SQLException {
		System.out.println("mobileprint=====");

		String front = "1", left = "1", right = "1", back = "1", interior = "1";
		String fleetno = request.getParameter("fleetno");
		int inspdoc = Integer.parseInt(insp);
		String remail = "", bccemail = "", print = "1", subject = "Equipment Inspection Sheet";
		bean = inspectionDAO.getPrint(inspdoc);
		/* beannew=inspectionDAO.getUser(inspdoc); */
		beansign = inspectionDAO.getSignature(inspdoc);
		setLblcompname(bean.getLblcompname());
		setLblcompaddress(bean.getLblcompaddress());
		setLblcompfax(bean.getLblcompfax());
		setLblcomptel(bean.getLblcomptel());
		setLblbranch(bean.getLblbranch());
		setLbldocno(bean.getLbldocno());
		setLbldate(bean.getLbldate());
		setLbltime(bean.getLbltime());
		setLbltype(bean.getLbltype());
		setLblreftype(bean.getLblreftype());
		setLblrefdocno(bean.getLblrefdocno());
		setLblreffleetno(bean.getLblreffleetno());
		setLblaccident(bean.getLblaccident());
		setLblaccdate(bean.getLblaccdate());
		setLblprcs(bean.getLblprcs());
		setLblcoldate(bean.getLblcoldate());
		setLblplace(bean.getLblplace());
		setLblfines(bean.getLblfines());
		setLblclaim(bean.getLblclaim());
		setLblcoldate(bean.getLblcoldate());
		setLblremarks(bean.getLblremarks());
		setLblamount(bean.getLblamount());
		setLblfleetname(bean.getLblfleetname());
		setLblregno(bean.getLblregno());
		setLblprintname("Equipment Inspection");
		remail = bean.getClientmail();

		System.out.println("client mail addresss=======" + remail);
		par = new HashMap();
		Connection conn = null;

		try {

			conn = objconn.getMyConnection();

			String imgpath = request.getSession().getServletContext()
					.getRealPath("/icons/yessureheader.png");
			imgpath = imgpath.replace("\\", "\\\\");
			// System.out.println("cmplogo====="+imgpath);
			// System.out.println("lbldocno====="+bean.getLbldocno());
			// System.out.println("lbldate====="+bean.getLbldate());
			// System.out.println("lbltime====="+bean.getLbltime());
			// System.out.println("lbltype====="+bean.getLbltype());
			// System.out.println("lblreftype====="+bean.getLblreftype());
			// System.out.println("lblrefdocno====="+bean.getLblrefdocno());
			// System.out.println("lblreffleetno====="+bean.getLblreffleetno());
			// System.out.println("lblregno====="+ bean.getLblregno());
			// System.out.println("lblfleetname====="+bean.getLblfleetname());
			// System.out.println("lblamount====="+bean.getLblamount());
			// System.out.println("username====="+ beannew.getUsername());

			// System.out.println("right====="+beannew.getRight());
			// System.out.println("imgpath====="+imgpath);
			String doc = bean.getLbldocno();
			par.put("imgheader", imgpath);
			/*
			 * par.put("lbldocno",doc ); par.put("lbldate", bean.getLbldate());
			 * par.put("lbltime", bean.getLbltime()); par.put("lbltype",
			 * bean.getLbltype()); par.put("lblreftype", bean.getLblreftype());
			 * par.put("lblrefdocno", bean.getLblrefdocno());
			 * par.put("lblreffleetno", bean.getLblreffleetno());
			 * par.put("lblregno", bean.getLblregno()); par.put("lblfleetname",
			 * bean.getLblfleetname());
			 * 
			 * par.put("lblamount",bean.getLblamount()); par.put("date",
			 * bean.getLbldate()); par.put("time", bean.getLbltime());
			 */
			par.put("orderno", doc);
			par.put("clientid", bean.getLblclientid());
			par.put("client", bean.getLblrefdocno());
			par.put("mob", bean.getLblclntmob());
			par.put("email", bean.getClientmail());
			par.put("address", bean.getLblcompaddress());
			par.put("driver", bean.getLbldriver());
			par.put("address", bean.getLblcompaddress());
			par.put("driver", bean.getLbldriver());
			par.put("drivmob", bean.getLbldrivermob());
			par.put("drivdob", bean.getLbldriverdob());
			par.put("drivdlno", bean.getLbldriverdlno());
			par.put("regno", bean.getLblregno());
			par.put("pltcode", bean.getLblpltcode());
			par.put("outdate", bean.getLbldout());
			par.put("outtime", bean.getLbltout());
			par.put("outkm", bean.getLblkmout());
			par.put("outfuel", bean.getLblfout());
			par.put("outby", bean.getLbloutby());
			par.put("custname", bean.getLblrefdocno());

			/*
			 * interior=beannew.getInterior(); if(interior!=null){
			 * interior=interior.replace("\\", "\\\\"); }
			 * //System.out.println("base====="+base);
			 * par.put("refimgscrnshotintr",interior);
			 * 
			 * back=beannew.getBack(); if(back!=null){ back=back.replace("\\",
			 * "\\\\"); } //System.out.println("base====="+base);
			 * par.put("refimgscrnshotbck",back);
			 * 
			 * front=beannew.getFront(); if(front!=null){
			 * front=front.replace("\\", "\\\\"); }
			 * //System.out.println("base====="+base);
			 * par.put("refimgscrnshotfrnt",front); left=beannew.getLeft();
			 * if(left!=null){ left=left.replace("\\", "\\\\"); }
			 * //System.out.println("left====="+ left);
			 * par.put("refimgscrnshotleft", left); right=beannew.getRight();
			 * if(right!=null){ right=right.replace("\\", "\\\\"); }
			 * //System.out.println("right====="+ right);
			 * par.put("refimgscrnshotright",right );
			 */

			par.put("signdate", bean.getLbldate());
			String sign = beansign.getSignature();
			if (sign != null) {
				sign = sign.replace("\\", "\\\\");
			}
			// System.out.println("signature====="+ sign);
			par.put("signature", sign);
			ArrayList<String> insppicsleft = inspectionDAO
					.getInspectionPrintPicsLeft(inspdoc,
							request.getParameter("lblurl"), agmtno, agmtype);
			int picslistsizeleft = insppicsleft.size();
			// System.out.println(insppics+"===="+picslistsize);
			if (picslistsizeleft < 5) {
				for (int i = 0; i < picslistsizeleft; i++) {
					String temp = insppicsleft.get(i);
					if (temp != null) {
						temp = temp.replace("\\", "\\\\");
					}
					// System.out.println("refimg"+(i+1)+temp);
					par.put("refimgleft" + (i + 1), temp);
				}
			}
			ArrayList<String> insppicsright = inspectionDAO
					.getInspectionPrintPicsRight(inspdoc,
							request.getParameter("lblurl"), agmtno, agmtype);
			int picslistsizeright = insppicsright.size();
			// System.out.println(insppics+"===="+picslistsize);
			if (picslistsizeright < 5) {
				for (int i = 0; i < picslistsizeright; i++) {
					String temp = insppicsright.get(i);
					if (temp != null) {
						temp = temp.replace("\\", "\\\\");
					}
					// System.out.println("refimg"+(i+1)+temp);
					par.put("refimgright" + (i + 1), temp);
				}
			}
			ArrayList<String> insppicsfront = inspectionDAO
					.getInspectionPrintPicsFront(inspdoc,
							request.getParameter("lblurl"), agmtno, agmtype);
			int picslistsizefront = insppicsfront.size();
			// System.out.println(insppics+"===="+picslistsize);
			if (picslistsizefront < 5) {
				for (int i = 0; i < picslistsizefront; i++) {
					String temp = insppicsfront.get(i);
					if (temp != null) {
						temp = temp.replace("\\", "\\\\");
					}
					// System.out.println("refimg"+(i+1)+temp);
					par.put("refimgfrnt" + (i + 1), temp);
				}
			}
			ArrayList<String> insppicsback = inspectionDAO
					.getInspectionPrintPicsBack(inspdoc,
							request.getParameter("lblurl"), agmtno, agmtype);
			int picslistsizeback = insppicsback.size();
			// System.out.println(insppics+"===="+picslistsize);
			if (picslistsizeback < 5) {
				par.put("showdet2", "1");
				for (int i = 0; i < picslistsizeback; i++) {
					String temp = insppicsback.get(i);
					if (temp != null) {
						temp = temp.replace("\\", "\\\\");
					}
					// System.out.println("refimg"+(i+1)+temp);
					par.put("refimgbck" + (i + 1), temp);
				}
			}
			ArrayList<String> insppicsinterior = inspectionDAO
					.getInspectionPrintPicsInterior(inspdoc,
							request.getParameter("lblurl"), agmtno, agmtype);
			int picslistsizeinterior = insppicsinterior.size();
			// System.out.println(insppics+"===="+picslistsize);
			if (picslistsizeinterior < 5) {
				par.put("showdet3", "1");
				for (int i = 0; i < picslistsizeinterior; i++) {
					String temp = insppicsinterior.get(i);
					if (temp != null) {
						temp = temp.replace("\\", "\\\\");
					}
					// System.out.println("refimg"+(i+1)+temp);
					par.put("refimgintr" + (i + 1), temp);
				}
			}
			ArrayList<String> insppicsid = inspectionDAO
					.getInspectionPrintPicsID(inspdoc,
							request.getParameter("lblurl"));
			int picslistsizeid = insppicsid.size();
			// System.out.println(insppics+"===="+picslistsize);
			if (picslistsizeid < 5) {
				for (int i = 0; i < picslistsizeid; i++) {
					String temp = insppicsid.get(i);
					if (temp != null) {
						temp = temp.replace("\\", "\\\\");
					}
					// System.out.println("refimg"+(i+1)+temp);
					par.put("refimgid" + (i + 1), temp);
				}
			}
			if (picslistsizeleft > 0 || picslistsizeright > 0
					|| picslistsizefront > 0) {
				par.put("showdet1", "1");
			}
			// String
			// path[]=commonDAO.getPrintPath("BRV").split("bankreceipt/");
			// setUrl(path[1]);

			JasperDesign design = JRXmlLoader.load(request
					.getSession()
					.getServletContext()
					.getRealPath(
							"com/equipment/inspection/YessureAppPrint.jrxml"));

			JasperReport jasperReport = JasperCompileManager
					.compileReport(design);
			// generateReportPDF(response, par, jasperReport, conn);
			generateReportEmail(par, jasperReport, conn, remail, bccemail,
					print, subject, insp);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}

		return "print";
	}

	public String mobilePrintAction2() throws ParseException, SQLException {
		System.out.println("mobileprint=====");
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		String front = "1", left = "1", right = "1", back = "1", interior = "1";
		String insp = request.getParameter("insp");
		String agmtno = request.getParameter("agmtno");
		String agmtype = request.getParameter("agmtype");
		int inspdoc = Integer.parseInt(insp);
		String remail = "", bccemail = "", print = "1", subject = "Equipment Inspection Sheet";
		bean = inspectionDAO.getPrint(inspdoc);
		/* beannew=inspectionDAO.getUser(inspdoc); */
		beansign = inspectionDAO.getSignature(inspdoc);
		setLblcompname(bean.getLblcompname());
		setLblcompaddress(bean.getLblcompaddress());
		setLblcompfax(bean.getLblcompfax());
		setLblcomptel(bean.getLblcomptel());
		setLblbranch(bean.getLblbranch());
		setLbldocno(bean.getLbldocno());
		setLbldate(bean.getLbldate());
		setLbltime(bean.getLbltime());
		setLbltype(bean.getLbltype());
		setLblreftype(bean.getLblreftype());
		setLblrefdocno(bean.getLblrefdocno());
		setLblreffleetno(bean.getLblreffleetno());
		setLblaccident(bean.getLblaccident());
		setLblaccdate(bean.getLblaccdate());
		setLblprcs(bean.getLblprcs());
		setLblcoldate(bean.getLblcoldate());
		setLblplace(bean.getLblplace());
		setLblfines(bean.getLblfines());
		setLblclaim(bean.getLblclaim());
		setLblcoldate(bean.getLblcoldate());
		setLblremarks(bean.getLblremarks());
		setLblamount(bean.getLblamount());
		setLblfleetname(bean.getLblfleetname());
		setLblregno(bean.getLblregno());
		setLblprintname("Equipment Inspection");
		remail = bean.getClientmail();

		System.out.println("client mail addresss=======" + remail);
		HttpServletResponse response = ServletActionContext.getResponse();
		par = new HashMap();

		Connection conn = null;

		try {

			conn = objconn.getMyConnection();

			String imgpath = request.getSession().getServletContext()
					.getRealPath("/icons/yessureheader.png");
			imgpath = imgpath.replace("\\", "\\\\");
			// System.out.println("cmplogo====="+imgpath);
			// System.out.println("lbldocno====="+bean.getLbldocno());
			// System.out.println("lbldate====="+bean.getLbldate());
			// System.out.println("lbltime====="+bean.getLbltime());
			// System.out.println("lbltype====="+bean.getLbltype());
			// System.out.println("lblreftype====="+bean.getLblreftype());
			// System.out.println("lblrefdocno====="+bean.getLblrefdocno());
			// System.out.println("lblreffleetno====="+bean.getLblreffleetno());
			// System.out.println("lblregno====="+ bean.getLblregno());
			// System.out.println("lblfleetname====="+bean.getLblfleetname());
			// System.out.println("lblamount====="+bean.getLblamount());
			// System.out.println("username====="+ beannew.getUsername());

			// System.out.println("right====="+beannew.getRight());
			// System.out.println("imgpath====="+imgpath);
			String doc = bean.getLbldocno();
			par.put("imgheader", imgpath);
			/*
			 * par.put("lbldocno",doc ); par.put("lbldate", bean.getLbldate());
			 * par.put("lbltime", bean.getLbltime()); par.put("lbltype",
			 * bean.getLbltype()); par.put("lblreftype", bean.getLblreftype());
			 * par.put("lblrefdocno", bean.getLblrefdocno());
			 * par.put("lblreffleetno", bean.getLblreffleetno());
			 * par.put("lblregno", bean.getLblregno()); par.put("lblfleetname",
			 * bean.getLblfleetname());
			 * 
			 * par.put("lblamount",bean.getLblamount()); par.put("date",
			 * bean.getLbldate()); par.put("time", bean.getLbltime());
			 */
			par.put("orderno", doc);
			par.put("clientid", bean.getLblclientid());
			par.put("client", bean.getLblrefdocno());
			par.put("mob", bean.getLblclntmob());
			par.put("email", bean.getClientmail());
			par.put("address", bean.getLblcompaddress());
			par.put("driver", bean.getLbldriver());
			par.put("address", bean.getLblcompaddress());
			par.put("driver", bean.getLbldriver());
			par.put("drivmob", bean.getLbldrivermob());
			par.put("drivdob", bean.getLbldriverdob());
			par.put("drivdlno", bean.getLbldriverdlno());
			par.put("regno", bean.getLblregno());
			par.put("pltcode", bean.getLblpltcode());
			par.put("outdate", bean.getLbldout());
			par.put("outtime", bean.getLbltout());
			par.put("outkm", bean.getLblkmout());
			par.put("outfuel", bean.getLblfout());
			par.put("outby", bean.getLbloutby());
			par.put("custname", bean.getLblrefdocno());

			/*
			 * interior=beannew.getInterior(); if(interior!=null){
			 * interior=interior.replace("\\", "\\\\"); }
			 * //System.out.println("base====="+base);
			 * par.put("refimgscrnshotintr",interior);
			 * 
			 * back=beannew.getBack(); if(back!=null){ back=back.replace("\\",
			 * "\\\\"); } //System.out.println("base====="+base);
			 * par.put("refimgscrnshotbck",back);
			 * 
			 * front=beannew.getFront(); if(front!=null){
			 * front=front.replace("\\", "\\\\"); }
			 * //System.out.println("base====="+base);
			 * par.put("refimgscrnshotfrnt",front); left=beannew.getLeft();
			 * if(left!=null){ left=left.replace("\\", "\\\\"); }
			 * //System.out.println("left====="+ left);
			 * par.put("refimgscrnshotleft", left); right=beannew.getRight();
			 * if(right!=null){ right=right.replace("\\", "\\\\"); }
			 * //System.out.println("right====="+ right);
			 * par.put("refimgscrnshotright",right );
			 */

			par.put("signdate", bean.getLbldate());
			String sign = beansign.getSignature();
			if (sign != null) {
				sign = sign.replace("\\", "\\\\");
			}
			// System.out.println("signature====="+ sign);
			par.put("signature", sign);
			ArrayList<String> insppicsleft = inspectionDAO
					.getInspectionPrintPicsLeft(inspdoc,
							request.getParameter("lblurl"), agmtno, agmtype);
			int picslistsizeleft = insppicsleft.size();
			// System.out.println(insppics+"===="+picslistsize);
			if (picslistsizeleft < 5) {
				for (int i = 0; i < picslistsizeleft; i++) {
					String temp = insppicsleft.get(i);
					if (temp != null) {
						temp = temp.replace("\\", "\\\\");
					}
					// System.out.println("refimg"+(i+1)+temp);
					par.put("refimgleft" + (i + 1), temp);
				}
			}
			ArrayList<String> insppicsright = inspectionDAO
					.getInspectionPrintPicsRight(inspdoc,
							request.getParameter("lblurl"), agmtno, agmtype);
			int picslistsizeright = insppicsright.size();
			// System.out.println(insppics+"===="+picslistsize);
			if (picslistsizeright < 5) {
				for (int i = 0; i < picslistsizeright; i++) {
					String temp = insppicsright.get(i);
					if (temp != null) {
						temp = temp.replace("\\", "\\\\");
					}
					// System.out.println("refimg"+(i+1)+temp);
					par.put("refimgright" + (i + 1), temp);
				}
			}
			ArrayList<String> insppicsfront = inspectionDAO
					.getInspectionPrintPicsFront(inspdoc,
							request.getParameter("lblurl"), agmtno, agmtype);
			int picslistsizefront = insppicsfront.size();
			// System.out.println(insppics+"===="+picslistsize);
			if (picslistsizefront < 5) {
				for (int i = 0; i < picslistsizefront; i++) {
					String temp = insppicsfront.get(i);
					if (temp != null) {
						temp = temp.replace("\\", "\\\\");
					}
					// System.out.println("refimg"+(i+1)+temp);
					par.put("refimgfrnt" + (i + 1), temp);
				}
			}
			ArrayList<String> insppicsback = inspectionDAO
					.getInspectionPrintPicsBack(inspdoc,
							request.getParameter("lblurl"), agmtno, agmtype);
			int picslistsizeback = insppicsback.size();
			// System.out.println(insppics+"===="+picslistsize);
			if (picslistsizeback < 5) {
				par.put("showdet2", "1");
				for (int i = 0; i < picslistsizeback; i++) {
					String temp = insppicsback.get(i);
					if (temp != null) {
						temp = temp.replace("\\", "\\\\");
					}
					// System.out.println("refimg"+(i+1)+temp);
					par.put("refimgbck" + (i + 1), temp);
				}
			}
			ArrayList<String> insppicsinterior = inspectionDAO
					.getInspectionPrintPicsInterior(inspdoc,
							request.getParameter("lblurl"), agmtno, agmtype);
			int picslistsizeinterior = insppicsinterior.size();
			// System.out.println(insppics+"===="+picslistsize);
			if (picslistsizeinterior < 5) {
				par.put("showdet3", "1");
				for (int i = 0; i < picslistsizeinterior; i++) {
					String temp = insppicsinterior.get(i);
					if (temp != null) {
						temp = temp.replace("\\", "\\\\");
					}
					// System.out.println("refimg"+(i+1)+temp);
					par.put("refimgintr" + (i + 1), temp);
				}
			}
			ArrayList<String> insppicsid = inspectionDAO
					.getInspectionPrintPicsID(inspdoc,
							request.getParameter("lblurl"));
			int picslistsizeid = insppicsid.size();
			// System.out.println(insppics+"===="+picslistsize);
			if (picslistsizeid < 5) {
				for (int i = 0; i < picslistsizeid; i++) {
					String temp = insppicsid.get(i);
					if (temp != null) {
						temp = temp.replace("\\", "\\\\");
					}
					// System.out.println("refimg"+(i+1)+temp);
					par.put("refimgid" + (i + 1), temp);
				}
			}
			if (picslistsizeleft > 0 || picslistsizeright > 0
					|| picslistsizefront > 0) {
				par.put("showdet1", "1");
			}
			// String
			// path[]=commonDAO.getPrintPath("BRV").split("bankreceipt/");
			// setUrl(path[1]);

			JasperDesign design = JRXmlLoader.load(request
					.getSession()
					.getServletContext()
					.getRealPath(
							"com/equipment/inspection/YessureAppPrint.jrxml"));

			JasperReport jasperReport = JasperCompileManager
					.compileReport(design);
			generateReportPDF(response, par, jasperReport, conn);
			// generateReportEmail(par,jasperReport,
			// conn,remail,bccemail,print,subject,insp);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
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

	private void generateReportEmail(Map parameters, JasperReport jasperReport,
			Connection conn, String remail, String bccemail, String print,
			String subject, String insp) throws JRException, NamingException,
			SQLException, IOException, AddressException, MessagingException {
		byte[] bytes = null;
		bytes = JasperRunManager.runReportToPdf(jasperReport, parameters, conn);
		EmailProcess ep = new EmailProcess();
		Statement stmtrr = conn.createStatement();

		String fileName = "", path = "", formcode = "EIP", filepath = "", path1 = "";
		String host = "", port = "", userName = "", password = "", recipient = "", message = "please find the attached inspection sheet", docnos = "1";
		String strSql1 = "select imgPath from my_comp";

		ResultSet rs1 = stmtrr.executeQuery(strSql1);
		while (rs1.next()) {
			path1 = rs1.getString("imgPath");
		}
		path = path1.replace("\\", "/");
		String strSql3 = "select mail,mailpass,smtpserver,smtphostport from my_user where user_id='super'";
		ResultSet rs3 = stmtrr.executeQuery(strSql3);
		while (rs3.next()) {
			userName = rs3.getString("mail");
			port = rs3.getString("smtphostport");
			host = rs3.getString("smtpserver");
			password = ClsEncrypt.getInstance().decrypt(
					rs3.getString("mailpass"));
		}
		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
		java.util.Date date = new java.util.Date();
		String currdate = dateFormat.format(date);

		DateFormat dateFormat2 = new SimpleDateFormat("dd_MM_yyyy");
		java.util.Date date2 = new java.util.Date();
		String currdate2 = dateFormat2.format(date2);
		// subject="Fleet status Epic Rent a car "+currdate2+" 8:00";
		subject = subject + "  " + currdate2;
		fileName = "EquipmentInspection" + currdate + ".pdf";
		filepath = path + "/attachment/" + formcode + "/" + fileName;

		File dir = new File(path + "/attachment/" + formcode);
		dir.mkdirs();

		CallableStatement stmtAttach = conn
				.prepareCall("{CALL fileAttach(?,?,?,?,?,?,?,?,?,?)}");

		stmtAttach.registerOutParameter(9, java.sql.Types.INTEGER);
		System.out.println("CALL fileAttach");
		stmtAttach.setString(1, "EIP");
		stmtAttach.setString(2, insp);
		stmtAttach.setString(3, "1");
		stmtAttach.setString(4, "1");
		stmtAttach.setString(5, path + "/attachment/" + formcode + "/"
				+ fileName);
		stmtAttach.setString(6, fileName);
		stmtAttach.setString(7, "print");
		stmtAttach.setString(8, "1");
		stmtAttach.setString(10, "0");

		stmtAttach.executeQuery();
		int no = stmtAttach.getInt("srNo");

		FileOutputStream fos = new FileOutputStream(filepath);
		fos.write(bytes);
		fos.flush();
		fos.close();

		File saveFile = new File(filepath);
		SendEmailAction sendmail = new SendEmailAction();
		// String[] remails=remail.split(",");

		ep.sendEmailwithpdfBCC(host, port, userName, password, remail, "",
				bccemail, subject, message, saveFile, docnos);

	}

}
