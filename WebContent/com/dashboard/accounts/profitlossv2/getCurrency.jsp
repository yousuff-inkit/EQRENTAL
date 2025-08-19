<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%	 
    ClsConnection conobj= new ClsConnection();
    ClsCommon com=new ClsCommon();
	String date = request.getParameter("date")==null?"":request.getParameter("date");
	String brhid = request.getParameter("brhid")==null || request.getParameter("brhid").trim().equals("")?"":request.getParameter("brhid");

 	Connection conn = conobj.getMyConnection();
	Statement stmt = conn.createStatement ();
	java.sql.Date sqlDate = null;
	if(!date.equals("") && date!=null) {
		sqlDate = com.changeStringtoSqlDate(date);
	}  
	String strSql = "select doc_no curid,code from my_curr where status=3";  
	
	//System.out.println("===strSql===currency="+strSql);
	
	ResultSet rs = stmt.executeQuery(strSql);
	String currId="",mClose="",currCode="",rate="";
	while(rs.next()) {   
	         	currId+=rs.getString("curid")+",";
	        	currCode+=rs.getString("code")+",";
	}
    //System.out.println("curr code "+currCode);   
	if(!currId.equals("")){
		    currId = currId.substring(0, currId.length()-1);
		    currCode = currCode.substring(0, currCode.length()-1);
   	}  
   
    response.getWriter().write(currId+"####"+currCode);    
	stmt.close();
	conn.close();
  %>