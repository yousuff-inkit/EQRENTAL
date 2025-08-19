package com.equipment.equipcontractclose;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.io.File;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.ResultSet;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
import com.operations.marketing.rentalcontract.ClsRentalContractBean;
import com.operations.marketing.rentalcontract.ClsRentalContractDAO;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

public class ClsEquipContractCloseAction extends ActionSupport {
	ClsEquipContractCloseDAO DAO = new ClsEquipContractCloseDAO();
	ClsCommon com = new ClsCommon();
	ClsEquipContractCloseBean bean = new ClsEquipContractCloseBean();
	ClsConnection conobj = new ClsConnection();

	private String date, docno, contractvocno, contractdocno, contractdetails,
			enddate, endtime, desc, mode, deleted, vocno, msg, formdetailcode,
			hidendtime, url;

	public String getHidendtime() {
		return hidendtime;
	}

	public void setHidendtime(String hidendtime) {
		this.hidendtime = hidendtime;
	}

	private int gridlength;

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
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

	public String getContractvocno() {
		return contractvocno;
	}

	public void setContractvocno(String contractvocno) {
		this.contractvocno = contractvocno;
	}

	public String getContractdocno() {
		return contractdocno;
	}

	public void setContractdocno(String contractdocno) {
		this.contractdocno = contractdocno;
	}

	public String getContractdetails() {
		return contractdetails;
	}

	public void setContractdetails(String contractdetails) {
		this.contractdetails = contractdetails;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
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

	public String getVocno() {
		return vocno;
	}

	public void setVocno(String vocno) {
		this.vocno = vocno;
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

	private Map<String, Object> param = null;

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public void setData(String docno, String vocno, java.sql.Date sqldate,
			java.sql.Date sqlenddate) {
		setDocno(docno);
		setVocno(vocno);
		setDate(sqldate.toString());
		setDesc(getDesc());
		setEnddate(sqlenddate.toString());
		setEndtime(getEndtime());
		setHidendtime(getEndtime());
	}

	public String saveAction() throws SQLException {

		ClsEquipContractCloseAction masteraction = new ClsEquipContractCloseAction();
		HttpServletRequest request = ServletActionContext.getRequest();
		Map<String, String[]> requestParams = request.getParameterMap();
		HttpSession session = request.getSession();

		String mode = getMode();
		masteraction.setContractdocno(getContractdocno());
		masteraction.setContractvocno(getContractvocno());
		masteraction.setContractdetails(getContractdetails());
		masteraction.setDesc(getDesc());
		masteraction.setEndtime(getEndtime());
		masteraction.setFormdetailcode(getFormdetailcode());
		ClsConnection objconn = new ClsConnection();
		ClsCommon objcommon = new ClsCommon();
		java.sql.Date sqldate = null, sqlenddate = null;
		if (!getDate().equalsIgnoreCase("")
				&& !getDate().equalsIgnoreCase("undefined")
				&& getDate() != null) {
			sqldate = objcommon.changeStringtoSqlDate(getDate());
		}
		if (!getEnddate().equalsIgnoreCase("")
				&& !getEnddate().equalsIgnoreCase("undefined")
				&& getEnddate() != null) {
			sqlenddate = objcommon.changeStringtoSqlDate(getEnddate());
		}

		if (mode.equalsIgnoreCase("A")) {
			ArrayList<String> closearray = new ArrayList<>();
			for (int i = 0; i < getGridlength(); i++) {
				String temp2 = requestParams.get("closetest" + i)[0];
				closearray.add(temp2);
			}
			Connection conn = null;
			try {
				conn = objconn.getMyConnection();
				conn.setAutoCommit(false);

				int docno = DAO.insert(masteraction, session, request, conn,
						sqldate, closearray, getFormdetailcode(), sqlenddate);
				if (docno > 0) {
					setData(docno + "", request.getAttribute("VOCNO")
							.toString(), sqldate, sqlenddate);
					setMsg("Successfully Saved");
					conn.commit();
					return "success";
				} else {
					setData("0", "0", sqldate, sqlenddate);
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
				/*
				 * boolean
				 * status=dao.edit(masteraction,session,request,conn,sqldate
				 * ,quotarray
				 * ,getFormdetailcode(),getDocno(),sqllpodate,sqlhirefromdate);
				 * if(status){ setData(getDocno(),getVocno(),
				 * sqldate,sqllpodate,sqlhirefromdate);
				 * setMsg("Updated Successfully"); conn.commit(); return
				 * "success"; } else{
				 * setData(getDocno(),getVocno(),sqldate,sqllpodate
				 * ,sqlhirefromdate); setMsg("Not Updated"); return "fail"; }
				 */
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
				/*
				 * boolean status=dao.delete(masteraction,session,request,conn,
				 * getFormdetailcode(),getDocno()); if(status){
				 * setData(getDocno(),getVocno(),
				 * sqldate,sqllpodate,sqlhirefromdate);
				 * setMsg("Successfully Deleted"); conn.commit(); return
				 * "success"; } else{
				 * setData(getDocno(),getVocno(),sqldate,sqllpodate
				 * ,sqlhirefromdate); setMsg("Not Deleted"); return "fail"; }
				 */
			} catch (Exception e) {
				e.printStackTrace();
				conn.close();
			} finally {
				conn.close();
			}
		} else if (mode.equalsIgnoreCase("view")) {
			/*
			 * ClsEquipContractCloseBean bean=dao.getViewDetails(getDocno());
			 * setDocno(bean.getDocno()); setVocno(bean.getVocno());
			 * setDate(bean.getDate()); setCldocno(bean.getCldocno());
			 * setClientdetails(bean.getClientdetails());
			 * setHidcmbreftype(bean.getHidcmbreftype());
			 * setHidcmbhiremode(bean.getHidcmbhiremode());
			 * setHidrefno(bean.getHidrefno()); setRefno(bean.getRefno());
			 * setSalesman(bean.getSalesman());
			 * setHidsalesman(bean.getHidsalesman()); setLpono(bean.getLpono());
			 * setLpodate(bean.getLpodate());
			 * setHidcmbhiremode(bean.getHidcmbhiremode());
			 * setHirefromdate(bean.getHirefromdate()); setDesc(bean.getDesc());
			 * setDelcharges(bean.getDelcharges());
			 */
			return "success";
		}
		return "fail";
	}

	public String printAction() throws Exception {
	//	System.out.println("PRINT ACTION");
		Connection conn = null;
		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			HttpSession session = request.getSession();
			ClsRentalContractBean bean = new ClsRentalContractBean();
			ClsRentalContractDAO DAO = new ClsRentalContractDAO();

			String docno = request.getParameter("docno").toString();
			String brhid = request.getParameter("branch").toString();
			String closedocno = request.getParameter("closedocno").toString();

			if (com.getPrintPath("RAC").contains(".jrxml")) {
				HttpServletResponse response = ServletActionContext
						.getResponse();

				String reportFileName = "";

				param = new HashMap();

				conn = conobj.getMyConnection();
				Statement stmt=conn.createStatement();
				ClsAmountToWords amtobj = new ClsAmountToWords();
				
				setUrl(com.getPrintPath("RAC"));
				String imglogo = request.getSession().getServletContext()
						.getRealPath("/icons/cityheader.png");
				imglogo = imglogo.replace("\\", "\\\\");

				String headerimgpath = request.getSession().getServletContext()
						.getRealPath("/icons/cityheader.png");
				headerimgpath = headerimgpath.replace("\\", "\\\\");

				String username="";
				String userid=session.getAttribute("USERID").toString();
				ResultSet rs=stmt.executeQuery("SELECT user_name FROM my_user WHERE doc_no="+userid);
				while(rs.next()){
					username=rs.getString("user_name");
				}
				
				String amtSql="SELECT m.brhid,round((d.totalamt+m.totalamt),2)totalamt from gl_rentalcontractm m "
+"left join (select round(sum(coalesce(nettotal,0)),2) totalamt,rdocno from gl_rentalcontractd group by rdocno) d on d.rdocno=m.doc_no " 
+"where m.status=3 and m.doc_no="+docno;
				String totalAmt="";
				String branch="";
				ResultSet amtrs=stmt.executeQuery(amtSql);
				while(amtrs.next()){
					totalAmt=amtrs.getString("totalamt");
					branch=amtrs.getString("brhid");
				}
								
				// String 
				// footerimgpath=request.getSession().getServletContext().getRealPath("/icons/cityfooter.jpg");
				// footerimgpath=footerimgpath.replace("\\", "\\\\");
				//param.put("amtobj", amtobj);
				  
	      	    
	      	   // System.out.println("------------------------branch-----------------------"+branch);
				
				String branchimg=brhid;
			    //System.out.println("------------------------branch-----------------------"+brhid);
				 if((brhid.equalsIgnoreCase("a") || brhid.equalsIgnoreCase("NA") || brhid.equalsIgnoreCase(""))){
		      	    	branchimg=session.getAttribute("BRANCHID").toString().equalsIgnoreCase("a")?"1":session.getAttribute("BRANCHID").toString();
		     		}
				 //System.out.println("------------------------branch aftercondition-----------------------"+branchimg);
				if(branchimg.equalsIgnoreCase("1")){
					String branch1header = request.getSession().getServletContext().getRealPath("/icons/branch1header.jpg");
					branch1header =branch1header.replace("\\", "\\\\");	
					String branch1footer = request.getSession().getServletContext().getRealPath("/icons/branch1footer.jpg");
					branch1footer =branch1footer.replace("\\", "\\\\");
					param.put("branchheader", branch1header);
					param.put("branchfooter", branch1footer);
				}
				else if(branchimg.equalsIgnoreCase("2")){
					String branch2header = request.getSession().getServletContext().getRealPath("/icons/branch2header.jpg");
					branch2header =branch2header.replace("\\", "\\\\");	
					String branch2footer = request.getSession().getServletContext().getRealPath("/icons/branch2footer.jpg");
					branch2footer =branch2footer.replace("\\", "\\\\");
					param.put("branchheader", branch2header);
					param.put("branchfooter", branch2footer);
				}
				else if(branchimg.equalsIgnoreCase("3")){
					String branch3header = request.getSession().getServletContext().getRealPath("/icons/branch3header.jpg");
					branch3header =branch3header.replace("\\", "\\\\");	
					String branch3footer = request.getSession().getServletContext().getRealPath("/icons/branch3footer.jpg");
					branch3footer =branch3footer.replace("\\", "\\\\");
					param.put("branchheader", branch3header);
					param.put("branchfooter", branch3footer);
				}
				
				param.put("imglogo", imglogo);
				param.put("docno", docno);
				param.put("username", username);
				param.put("amountinword", amtobj.convertAmountToWords(totalAmt));
				param.put("brhid", branch);
				param.put("closedocno", closedocno);

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

	// System.out.println("===== "+getUrl());

	private void generateReportEmail(HttpServletResponse resp, Map parameters,
			JasperReport jasperReport, Connection conn, String docno,
			HttpSession session, String brhid, HttpServletRequest request)
			throws JRException, NamingException, SQLException, IOException,
			AddressException, MessagingException {
		try {
			byte[] bytes = null;
			bytes = JasperRunManager.runReportToPdf(jasperReport, parameters,
					conn);
			// Statement stmt=conn.createStatement();
			String fileName = "", path = "", formcode = "ERC", filepath = "";
			// Deleting Existing Internal Attachments

			// int
			// deleteFileEntry=stmt.executeUpdate("delete from my_fileattach where doc_no="+docno+" and dtype='"+formcode+"' and ref_id=999");

			// path=path.replace("\\", "/");

			// fileName = formcode+"-"+docno+"-"+srno+".pdf";
			filepath = path + "\\attachment\\" + formcode + "\\" + fileName;

			File dir = new File(path + "\\attachment\\" + formcode);
			dir.mkdirs();
			JasperPrint print = JasperFillManager.fillReport(jasperReport,
					parameters);
			JasperExportManager.exportReportToPdfFile(print, filepath);

			CallableStatement stmtAttach = conn
					.prepareCall("{CALL fileAttach(?,?,?,?,?,?,?,?,?)}");
			stmtAttach.registerOutParameter(9, java.sql.Types.INTEGER);
			stmtAttach.setString(1, formcode);
			stmtAttach.setString(2, docno);
			stmtAttach.setString(3,
					session.getAttribute("BRANCHID") == null ? brhid : session
							.getAttribute("BRANCHID").toString());
			stmtAttach
					.setString(4, session.getAttribute("USERNAME").toString());
			stmtAttach.setString(5, path + "\\attachment\\" + formcode + "\\"
					+ fileName);
			stmtAttach.setString(6, fileName);
			stmtAttach.setString(7, "");
			stmtAttach.setString(8, "999");
			stmtAttach.executeQuery();
			int no = stmtAttach.getInt("srNo");
			if (no <= 0) {
				System.out.println("Insert Error");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
