package com.dashboard.project.servicesalelist;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
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

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsServiceSaleListAction {
	ClsConnection ClsConnection = new ClsConnection();
	ClsCommon ClsCommon = new ClsCommon();

	private Map<String, Object> param = null;

	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	public String printAction() throws ParseException, SQLException {

		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();

		String docnos = request.getParameter("docnos");
		String bankdocno = request.getParameter("bankdocno").toString();
		String brhid = request.getParameter("brhid").toString();
		int header = Integer.parseInt(request.getParameter("header"));

		HttpServletResponse response = ServletActionContext.getResponse();

		param = new HashMap();
		Connection conn = null;

		ClsConnection conobj = new ClsConnection();
		conn = conobj.getMyConnection();

		try {
				
			ArrayList<Integer> pdocnos = new ArrayList<Integer>();
			
			if (docnos.contains(":")) {
				String[] inv = new String[] {};
				inv = docnos.split(":");
				for (int i = 0; i < inv.length; i++) {
					pdocnos.add(Integer.parseInt(inv[i]));
				}
			} else {
				pdocnos.add(Integer.parseInt(docnos));
			}
			
			param.put("docnos", pdocnos);
			param.put("headers", header);
			param.put("username", session.getAttribute("USERNAME").toString());
			
			Statement stmt = conn.createStatement();
			String strSql1 = "select name,address,beneficiary,account,ibanno,swiftcode from cm_bankdetails where status=3 and doc_no="
					+ bankdocno + "";
			ResultSet rs1 = stmt.executeQuery(strSql1);
			
			String banknames = "", bankaddress = "", bankbeneficiary = "", bankaccount = "", bankibanno = "",
					bankswiftcode = "";
			while (rs1.next()) {
				banknames = rs1.getString("name");
				bankaddress = rs1.getString("address");
				bankbeneficiary = rs1.getString("beneficiary");
				bankaccount = rs1.getString("account");
				bankibanno = rs1.getString("ibanno");
				bankswiftcode = rs1.getString("swiftcode");
			}

			param.put("bankname", banknames);
			param.put("bankaddress", bankaddress);
			param.put("bankbeneficiary", bankbeneficiary);
			param.put("bankaccountno", bankaccount);
			param.put("bankibanno", bankibanno);
			param.put("bankswiftcode", bankswiftcode);

			
			if(brhid.equalsIgnoreCase("1")){
				String branch1header = request.getSession().getServletContext().getRealPath("/icons/branch1header.jpg");
				if(branch1header!=null) {
					branch1header =branch1header.replace("\\", "\\\\");	
				} 
				String branch1footer = request.getSession().getServletContext().getRealPath("/icons/branch1footer.jpg");
				if(branch1footer!=null) {
					branch1footer =branch1footer.replace("\\", "\\\\");
				}
				param.put("branchheader", branch1header);
				param.put("branchfooter", branch1footer);
			}else if(brhid.equalsIgnoreCase("2")){
				String branch2header = request.getSession().getServletContext().getRealPath("/icons/branch2header.jpg");
				if(branch2header!=null) {
				branch2header =branch2header.replace("\\", "\\\\");	
				}
				String branch2footer = request.getSession().getServletContext().getRealPath("/icons/branch2footer.jpg");
				if(branch2footer!=null) {
				branch2footer =branch2footer.replace("\\", "\\\\");
				}
				param.put("branchheader", branch2header);
				param.put("branchfooter", branch2footer);
			}else if(brhid.equalsIgnoreCase("3")){
				String branch3header = request.getSession().getServletContext().getRealPath("/icons/branch3header.jpg");
				if(branch3header!=null) {
				branch3header =branch3header.replace("\\", "\\\\");	
				}
				String branch3footer = request.getSession().getServletContext().getRealPath("/icons/branch3footer.jpg");
				if(branch3footer!=null) {
				branch3footer =branch3footer.replace("\\", "\\\\");
				}
				param.put("branchheader", branch3header);
				param.put("branchfooter", branch3footer);
			} 

			JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext()
					.getRealPath("com/dashboard/project/servicesalelist/ServiceSale.jrxml"));

			JasperReport jasperReport = JasperCompileManager.compileReport(design);
			generateReportPDF(response, param, jasperReport, conn);

		} catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			conn.close();
		}
		return "print";
	}

	private void generateReportPDF(HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)
			throws JRException, NamingException, SQLException, IOException {
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
