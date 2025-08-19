<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	/* String dtype=session.getAttribute("Code").toString();
  String clientid=request.getParameter("clientid").trim().toString(); */
	String brch=session.getAttribute("BRANCHID").toString();
	String strSql ="";	ClsConnection ClsConnection=new ClsConnection();
 	Connection conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	
	
	
/* 	if(!(clientid.equals("")||clientid.equals("0"))){
		strSql="select pg.pricegroup,pg.code,pg.doc_no from my_acbook ac inner join my_pricegroup pg on(ac.pricegroup=pg.doc_no and ac.dtype='CRM') where ac.doc_no="+clientid+" and pg.status=3";
	}
	else{ */
		strSql = "select pg.billtype code,pg.sr_no doc_no from my_billtype pg where pg.status=3 and pg.type='PUR' order by seqno";
	/* } */
	
	System.out.println("===strSql===="+strSql);
	
	ResultSet rs = stmt.executeQuery(strSql);
	String pgid="";
	String pgcode="";
	String pgname="";
	while(rs.next()) {
		pgid+=rs.getInt("pg.doc_no")+",";
		pgcode+=rs.getString("pg.code")+",";
		
  		} 
	pgid=pgid.substring(0, pgid.length()-1);
	pgcode=pgcode.substring(0, pgcode.length()-1);
	
	//System.out.println(curid+"####"+curcode+"####"+currate+"####"+multi);
	response.getWriter().write(pgid+"####"+pgcode);
	
	
	stmt.close();
	conn.close();
  %>
  
