<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
	Connection conn = null;

	try{
		ClsConnection connDAO = new ClsConnection();
		ClsCommon commonDAO = new ClsCommon();
		conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		String backDateAllowed="0";
		String date=request.getParameter("date")==null?"":request.getParameter("date");
		String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
		String mode=request.getParameter("mode")==null?"":request.getParameter("mode");
		
		java.sql.Date sqlDate=null;
		java.sql.Date sqlDocumentDate=null;
        
        date.trim();
        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))) {
        	sqlDate = commonDAO.changeStringtoSqlDate(date);
        }
        
        String strSql = "select method,round(coalesce(value,0),2) valuehrs from gl_config where field_nme='mwBackDate'";
		ResultSet rs = stmt.executeQuery(strSql);
		
		String method="",valueHrs="";
		while(rs.next()) {
			method=rs.getString("method");
			valueHrs=rs.getString("valuehrs");
		} 
		
		if(method.equalsIgnoreCase("1")){
			
			if(mode.equalsIgnoreCase("A")) {
				String strSql1 = "select if((24*(DATEDIFF(now(), '"+sqlDate+"')))>"+valueHrs+",1,0) backDateAllowed";
				ResultSet rs1 = stmt.executeQuery(strSql1);
				
				while(rs1.next()) {
					backDateAllowed=rs1.getString("backDateAllowed");
				} 
			} else if(mode.equalsIgnoreCase("E")) {
				// based on document create date  
				
				String strSqls = "select date from gl_vmcostm where status=3 and doc_no='"+docno+"'";
				ResultSet rss = stmt.executeQuery(strSqls);
				
				while(rss.next()) {
					sqlDocumentDate=rss.getDate("date");
				} 
				
				
				String strSql1 = "select if((24*(DATEDIFF('"+sqlDocumentDate+"', '"+sqlDate+"')))>"+valueHrs+",1,0) backDateAllowed";
				ResultSet rs1 = stmt.executeQuery(strSql1);
				
				while(rs1.next()) {
					backDateAllowed=rs1.getString("backDateAllowed");
				} 
				
			}
			
		}
		
		response.getWriter().write(backDateAllowed);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  