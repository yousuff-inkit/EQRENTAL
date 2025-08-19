package com.workshop.gateinpass;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
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
import com.opensymphony.xwork2.ActionSupport;

public class ClsGateInPassAction extends ActionSupport {

	ClsCommon objcommon = new ClsCommon();
	ClsGateInPassDAO gatedao = new ClsGateInPassDAO();
	ClsGateInPassBean gatebean = new ClsGateInPassBean();

	private int gridlength;
	private String docno, date, fleetno, fleetdetails, brchName, chkdriver,
			hidchkdriver, driver, hiddriver, indate, intime, inkm, cmbinfuel,
			remarks, serviceduekm, hidcmbinfuel, srvckm, ch_no, eng_no,
			lastsrvckm, cldocno, agmtno, agmtexist, clientdetails;
	private String mode, msg, deleted, formdetailcode, drivernumber, datetime,
			client, regno, hidcregtrno;

	public String getHidcregtrno() {
		return hidcregtrno;
	}

	public void setHidcregtrno(String hidcregtrno) {
		this.hidcregtrno = hidcregtrno;
	}

	public String getRegno() {
		return regno;
	}

	public void setRegno(String regno) {
		this.regno = regno;
	}

	public String getDatetime() {
		return datetime;
	}

	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	private String url;

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getDrivernumber() {
		return drivernumber;
	}

	public void setDrivernumber(String drivernumber) {
		this.drivernumber = drivernumber;
	}

	public String getAgmtexist() {
		return agmtexist;
	}

	public void setAgmtexist(String agmtexist) {
		this.agmtexist = agmtexist;
	}

	public String getClientdetails() {
		return clientdetails;
	}

	public void setClientdetails(String clientdetails) {
		this.clientdetails = clientdetails;
	}

	public String getCldocno() {
		return cldocno;
	}

	public void setCldocno(String cldocno) {
		this.cldocno = cldocno;
	}

	public String getAgmtno() {
		return agmtno;
	}

	public void setAgmtno(String agmtno) {
		this.agmtno = agmtno;
	}

	public String getSrvckm() {
		return srvckm;
	}

	public void setSrvckm(String srvckm) {
		this.srvckm = srvckm;
	}

	public String getLastsrvckm() {
		return lastsrvckm;
	}

	public void setLastsrvckm(String lastsrvckm) {
		this.lastsrvckm = lastsrvckm;
	}

	public String getHidcmbinfuel() {
		return hidcmbinfuel;
	}

	public void setHidcmbinfuel(String hidcmbinfuel) {
		this.hidcmbinfuel = hidcmbinfuel;
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

	public String getDocno() {
		return docno;
	}

	public void setDocno(String docno) {
		this.docno = docno;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getFleetno() {
		return fleetno;
	}

	public void setFleetno(String fleetno) {
		this.fleetno = fleetno;
	}

	public String getFleetdetails() {
		return fleetdetails;
	}

	public void setFleetdetails(String fleetdetails) {
		this.fleetdetails = fleetdetails;
	}

	public String getBrchName() {
		return brchName;
	}

	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}

	public String getChkdriver() {
		return chkdriver;
	}

	public void setChkdriver(String chkdriver) {
		this.chkdriver = chkdriver;
	}

	public String getHidchkdriver() {
		return hidchkdriver;
	}

	public void setHidchkdriver(String hidchkdriver) {
		this.hidchkdriver = hidchkdriver;
	}

	public String getDriver() {
		return driver;
	}

	public void setDriver(String driver) {
		this.driver = driver;
	}

	public String getHiddriver() {
		return hiddriver;
	}

	public void setHiddriver(String hiddriver) {
		this.hiddriver = hiddriver;
	}

	public String getIndate() {
		return indate;
	}

	public void setIndate(String indate) {
		this.indate = indate;
	}

	public String getIntime() {
		return intime;
	}

	public void setIntime(String intime) {
		this.intime = intime;
	}

	public String getInkm() {
		return inkm;
	}

	public void setInkm(String inkm) {
		this.inkm = inkm;
	}

	public String getCmbinfuel() {
		return cmbinfuel;
	}

	public void setCmbinfuel(String cmbinfuel) {
		this.cmbinfuel = cmbinfuel;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getServiceduekm() {
		return serviceduekm;
	}

	public void setServiceduekm(String serviceduekm) {
		this.serviceduekm = serviceduekm;
	}

	public String getCh_no() {
		return ch_no;
	}

	public void setCh_no(String ch_no) {
		this.ch_no = ch_no;
	}

	public String getEng_no() {
		return eng_no;
	}

	public void setEng_no(String eng_no) {
		this.eng_no = eng_no;
	}

	private Map<String, Object> param = null;

	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	public void setData(int docno, java.sql.Date sqldate,
			java.sql.Date sqlindate) {
		setDocno(docno + "");
		setDate(sqldate.toString());
		setIndate(sqlindate.toString());
		setFleetno(getFleetno());
		setFleetdetails(getFleetdetails());
		setHidchkdriver(getHidchkdriver());
		setDriver(getDriver());
		setHiddriver(getHiddriver());
		setIntime(getIntime());
		setInkm(getInkm());
		setCmbinfuel(getCmbinfuel());
		setRemarks(getRemarks());
		setServiceduekm(getServiceduekm());
		setHidcmbinfuel(getCmbinfuel());
		setCldocno(getCldocno());
		setAgmtno(getAgmtno());
		setClientdetails(getClientdetails());
		setAgmtexist(getAgmtexist());
		setDrivernumber(getDrivernumber());
	}

	public String saveAction() throws ParseException, SQLException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode = getMode();

		System.out.println("mode--->"+mode);
		
		if (!mode.equalsIgnoreCase("view")) {
			java.sql.Date sqldate = null, sqlindate = null;
			if (getDate() != null && !getDate().equalsIgnoreCase("")) {
				sqldate = objcommon.changeStringtoSqlDate(getDate());
			}
			if (getIndate() != null && !getIndate().equalsIgnoreCase("")) {
				sqlindate = objcommon.changeStringtoSqlDate(getIndate());
			}
			ArrayList<String> complaintarray = new ArrayList<>();
			for (int i = 0; i < getGridlength(); i++) {
				String temp = requestParams.get("test" + i)[0];
				complaintarray.add(temp);
			}

			if (mode.equalsIgnoreCase("A")) {
				int insertval = gatedao.insert(getDrivernumber(), sqldate,
						getFleetno(), getDriver(), getHidchkdriver(),
						getHiddriver(), sqlindate, getIntime(), getInkm(),
						getCmbinfuel(), getRemarks(), getServiceduekm(),
						complaintarray, session, request, mode,
						getFormdetailcode(), getBrchName(), getAgmtno(),
						getCldocno(), getAgmtexist(), getHidcregtrno());
				if (insertval > 0) {
					setData(insertval, sqldate, sqlindate);
					setMsg("Successfully Saved");
					return "success";
				} else {
					setData(0, sqldate, sqlindate);
					setMsg("Not Saved");
					return "fail";
				}
			} else if (mode.equalsIgnoreCase("E")) {
				boolean status = gatedao.edit(getDrivernumber(), sqldate,
						getFleetno(), getDriver(), getHidchkdriver(),
						getHiddriver(), sqlindate, getIntime(), getInkm(),
						getCmbinfuel(), getRemarks(), getServiceduekm(),
						complaintarray, session, request, mode,
						getFormdetailcode(), getBrchName(), getDocno(),
						getAgmtno(), getCldocno(), getAgmtexist());
				if (status) {
					setData(Integer.parseInt(getDocno()), sqldate, sqlindate);
					setMsg("Updated Successfully");
					return "success";
				} else {
					setData(Integer.parseInt(getDocno()), sqldate, sqlindate);
					setMsg("Not Updated");
					return "fail";
				}
			} else if (mode.equalsIgnoreCase("D")) {
				boolean status = gatedao.delete(getDocno(), getBrchName(),
						getMode(), session, request);
				if (status) {
					setData(Integer.parseInt(getDocno()), sqldate, sqlindate);
					setMsg("Successfully Deleted");
					return "success";
				} else {
					setData(Integer.parseInt(getDocno()), sqldate, sqlindate);
					setMsg("Not Deleted");
					return "fail";
				}
			}

		}
		return "fail";
	}

	public String printAction() throws ParseException, SQLException {
		System.out.println("not yet inside jrxml==========");
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		int doc = Integer.parseInt(request.getParameter("docno"));
		String brhid = request.getParameter("brhid").toString();
		String dtype = request.getParameter("dtype").toString();

		setUrl(objcommon.getPrintPath(dtype));

		gatebean = gatedao.getPrint(doc, request, session, brhid);

		// cl details

		/*
		 * setLblprintname("NI Purchase"); setLbldate(gatebean.getLbldate());
		 * setLbltype(gatebean.getLbltype()); setDocvals(gatebean.getDocvals());
		 * setLblacno(gatebean.getLblacno()); //upper
		 * setLblacnoname(gatebean.getLblacnoname());
		 * setLbldeldate(gatebean.getLbldeldate());
		 * setLbldddtm(gatebean.getLbldddtm());
		 * 
		 * setLbldsc(gatebean.getLbldsc()); setLblpatms(gatebean.getLblpatms());
		 * 
		 * setLblnettotal(gatebean.getLblnettotal());
		 * 
		 * 
		 * setLblbranch(gatebean.getLblbranch());
		 * setLblcompname(gatebean.getLblcompname());
		 * 
		 * setLblcompaddress(gatebean.getLblcompaddress());
		 * 
		 * setLblcomptel(gatebean.getLblcomptel());
		 * 
		 * setLblcompfax(gatebean.getLblcompfax());
		 * setLbllocation(gatebean.getLbllocation());
		 * 
		 * 
		 * setLblinvno(gatebean.getLblinvno());
		 * setLblinvdate(gatebean.getLblinvdate());
		 */

		if (objcommon.getPrintPath(dtype).contains("jrxml") == true)

		{
			System.out.println("inside jrxml");
			HttpServletResponse response = ServletActionContext.getResponse();

			param = new HashMap();
			Connection conn = null;

			String reportFileName = "Gate In Pass";

			ClsConnection conobj = new ClsConnection();
			conn = conobj.getMyConnection();

			try {
				/*
				 * param.put("termsquery",gatebean.getTermQry());
				 * 
				 * param.put("descQry",gatebean.getDescQry());
				 */
				// System.out.println("product++++++++++"+productQuery);
				String imgpath = request.getSession().getServletContext()
						.getRealPath("/icons/aitsheader.jpg");
				imgpath = imgpath.replace("\\", "\\\\");
				param.put("imghedderpath", imgpath);
				String imgpath1 = request.getSession().getServletContext()
						.getRealPath("/icons/epic.jpg");
				imgpath1 = imgpath1.replace("\\", "\\\\");
				param.put("img", imgpath1);

				String imgpath2 = request.getSession().getServletContext()
						.getRealPath("/icons/aitsfooter.jpg");
				imgpath2 = imgpath2.replace("\\", "\\\\");
				param.put("imgfooterpath", imgpath2);

				String strSqldetail = "select @i:=@i+1 srno,a.* from(select det.description,comp.compname complaint from  gl_workgateinpassd det left join gl_complaint comp on det.complaintid=comp.doc_no where "
						+ "det.status=3 and det.rdocno="
						+ docno
						+ " and det.brhid="
						+ brhid
						+ ") a ,(select @i:=0) as i";
				System.out.println("===== " + strSqldetail);
				param.put("docno", gatebean.getDocno());
				param.put("datetime", gatebean.getDatetime());
				param.put("clientname", gatebean.getClient());
				param.put("driver", gatebean.getDriver());
				param.put("drivermobile", gatebean.getDrivernumber());
				param.put("regno", gatebean.getRegno());
				param.put("serviceduekm", gatebean.getSrvckm());
				param.put("engno", gatebean.getEng_no());
				param.put("chassisno", gatebean.getCh_no());
				param.put("inkm", gatebean.getInkm());
				param.put("remarks", gatebean.getRemarks());
				param.put("gateinpasssql", strSqldetail);

				// System.out.println("desc"+bean.getLbldesc1()+"pay"+bean.getLblpaytems()+"paytrim"+bean.getLblpaytems()+"del"+
				// bean.getLbldelterms());
				// System.out.println("pathhhhhhhhhhhhhhhhhhh"+commDAO.getPrintPath(dtype));
				JasperDesign design = JRXmlLoader.load(request
						.getSession()
						.getServletContext()
						.getRealPath(
								"com/workshop/gateinpass/"
										+ objcommon.getPrintPath(dtype)));

				JasperReport jasperReport = JasperCompileManager
						.compileReport(design);
				generateReportPDF(response, param, jasperReport, conn);

			} catch (Exception e) {

				e.printStackTrace();

			}

			finally {
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
