 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsEncrypt" %>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>

<%        
//System.out.println("Location innnnnnnnn====");
      

	 String cldocno=request.getParameter("cldoc")==null?"0":request.getParameter("cldoc");
	 String psrno=request.getParameter("psrno")==null?"0":request.getParameter("psrno");
 
	   
		String sellprice="",date="",sqltest="";


 	Connection conn = null;
try{	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0,method=0;
	String brhid = session.getAttribute("BRANCHID").toString(); 
	//System.out.println("brnch===="+brhid);
	
	String strSql2 ="select method from gl_prdconfig where field_nme like 'vataddoramount'";
	ResultSet rs2 = stmt.executeQuery(strSql2);
	while (rs2.next()){
		method=rs2.getInt("method");
	}
	if(method>0){
		sqltest=",round((d.nettaxamount/d.qty),2)sp";
	}else{
		sqltest=",round((d.nettotal/d.qty),2)sp";
	}
	
	String strSql = "select date_format(m.date,'%d.%m.%Y')date"+sqltest+" from my_invm m left join my_invd d on m.doc_no=d.rdocno where m.cldocno="+cldocno+" and d.psrno="+psrno+"";
	
	System.out.println("--selldetails--"+strSql);
	
	ResultSet rs = stmt.executeQuery(strSql);
	int userid=0;
	while(rs.next ()) {
		date=rs.getString("date");
		sellprice=rs.getString("sp");
		 
	}
	
	
	
	
	
	stmt.close();
	conn.close();

	response.getWriter().print(date+"::"+sellprice);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>