<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon"%>

<%	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;
	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		java.sql.Date sqlDate=null;
		
		String date = request.getParameter("date");
		String accid = (request.getParameter("accid")!="" && request.getParameter("accid")!=null) ? request.getParameter("accid") : "0";
		
		if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
        {
     	   sqlDate = ClsCommon.changeStringtoSqlDate(date);
        }
		
		int configTax=0;
		String sql = "select method from gl_config where field_nme='tax'";
		ResultSet rsConfig = stmt.executeQuery(sql);
		while(rsConfig.next()) {
			configTax=rsConfig.getInt("method");
		} 
		
		int vendorTax=1;
		if(accid != "0"){
			String sql2 = "select tax from my_acbook where dtype='VND' and acno="+accid;
			ResultSet rsVendor = stmt.executeQuery(sql2);
			while(rsVendor.next()) {
				vendorTax=rsVendor.getInt("tax");
			} 
		}

		String taxper="0";
		
		if(configTax==1 && vendorTax==1){
		
		String strSql = "select per from gl_taxmaster where status=3 and per>0 and fromdate<='"+sqlDate+"' and todate>='"+sqlDate+"'";
		
		ResultSet rs = stmt.executeQuery(strSql);
		
		while(rs.next()) {
					taxper=rs.getString("per");
				} 
		
		}
		
		
		response.getWriter().write(taxper);
		
		stmt.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  