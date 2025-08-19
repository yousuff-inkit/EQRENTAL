<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		java.sql.Date sqlPayrollDate=null;
		
		String payrolldate=request.getParameter("payrolldate");
		String branch=request.getParameter("branch");

	    if(!(payrolldate.equalsIgnoreCase("undefined"))&&!(payrolldate.equalsIgnoreCase(""))&&!(payrolldate.equalsIgnoreCase("0"))){
		     sqlPayrollDate=ClsCommon.changeStringtoSqlDate(payrolldate);
		}
	    
		String strSql = "select doc_no from hr_payroll where status=3 and MONTH(date)=MONTH('"+sqlPayrollDate+"') and YEAR(date)=YEAR('"+sqlPayrollDate+"') and brhid='"+branch+"'";
		//System.out.println("strsql====="+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		
		String docNo="0";
		while(rs.next()) {
			docNo=rs.getString("doc_no");
		} 
		
		response.getWriter().write(docNo);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  