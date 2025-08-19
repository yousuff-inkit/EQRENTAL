package com.dashboard.procurment.barcodegeneratorgrn;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;




public class ClsbarcodeGeneratorsgrnAction {

	
	
	private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	ClsConnection connDAO = new ClsConnection();
	
	ClsCommon ClsCommon=new ClsCommon();
	
	public void printbarcode() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		 
		 int doc=Integer.parseInt(request.getParameter("docno"));
		 
		 String cmbtype=request.getParameter("cmbtype").toString();
		 
		
		  //cl details
		 
			HttpServletResponse response = ServletActionContext.getResponse();
			
			 param = new HashMap();
	      Connection conn = null;
			 try {
		          
	          	int trno=0;
				int acno=0;
				int srno=0;
				String sql2="";
	            	 conn = connDAO.getMyConnection();
	   Statement stmt=conn.createStatement();
			  String amount="0",partno="",jdeno="";
	            	 String sql="select (barcode) barcode,bhno part_no,jdeno from my_main where psrno='"+doc+"'";
	            	 ResultSet rs=stmt.executeQuery(sql);
	            	 if(rs.next())
	            	 {
	            		 
	            		 partno=rs.getString("part_no");
	            		 amount=rs.getString("barcode");
	            		 jdeno=rs.getString("jdeno");
	            		 
	            	 }
	            	//	System.out.println("amount=----=="+amount);
	            	 int aa=amount.length();
	            	 int bb=0;
	            	 /*if(aa<12)
	            	 {
	            		bb=12-aa; 
	            	 }
	            	 
	            	   	//System.out.println("bb=----=="+bb);
	            	   	
	            	   	
	            	   	String zero="";
	            	   	
	            	   	for (int k=0;k<bb;k++)
	            	   	{
	            	   		zero=zero+"0";
	            	   	}
	            	   																															
	            	//	System.out.println("zero=----=="+zero);
	            		
	            		amount=amount+zero;
	            		*/
	            		
	            	//	System.out.println("amountzero=----=="+amount);
		         
		         param.put("barcode", amount);
		         param.put("partno", partno);
		         param.put("jdeno", jdeno);
		      
		         JasperDesign design=null;
		     	System.out.println("cmbtype=----=="+cmbtype+"==="+jdeno+"==="+partno);
		         
		         if(cmbtype.equalsIgnoreCase("small"))
		        		 {
		        	  design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/procurment/barcodegeneratorgrn/Barcodesmall.jrxml"));
		        		 }
		         else
		         {
		        	  design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/procurment/barcodegeneratorgrn/Barcodelarge.jrxml"));
		         }
		         
	    	 
	    	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
	                      generateReportPDF(response, param, jasperReport, conn);
	                
	     
	            } catch (Exception e) {

	                e.printStackTrace();
	            }
	           	 
	           finally{
			conn.close();
		}	  	 


		   
		 
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
		
}
