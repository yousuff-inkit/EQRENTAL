<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>

<%	

Connection conn = null;
try
{
	ClsCommon ClsCommon=new ClsCommon();
	String dtype=session.getAttribute("Code").toString();
   // System.out.println("Dtype="+dtype);
	String brch=session.getAttribute("BRANCHID").toString();
	String dates=request.getParameter("date")==null?"NA":request.getParameter("date").trim();
	ClsConnection ClsConnection=new ClsConnection();
 	  conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	java.sql.Date masterdate = null;
	if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0"))&&!(dates.equalsIgnoreCase("NA")))
	{
		masterdate=ClsCommon.changeStringtoSqlDate(dates);
		
	}
	else{
	 
//Statement stmt=conn.createStatement();
		String chks="select curdate() date";
		ResultSet rs10=stmt.executeQuery(chks); 
		if(rs10.next())
		{
			
			masterdate=rs10.getDate("date");
		}

	}
	String strSq = "select multiCur from win_tbldet where trtype='"+dtype+"'";
	ResultSet rs1 = stmt.executeQuery(strSq);
	int multi = 0;
	while(rs1.next()){
	multi = rs1.getInt("multiCur");
	}
	//String strSql = "select c.doc_no,c.code,c.c_rate from my_brch b inner join my_curr c on(c.doc_no=curId) where c.status <> 7 and b.doc_no='"+brch+"'";
	String strSql = "select c.code,cb.rate,c.doc_no from my_curr c left join (select curid,max(doc_no),rate from my_curbook where '"+masterdate+"' between frmDate and coalesce(toDate,curdate())  group by curid) cb on c.doc_no=cb.curid where c.status<>7 ";
	ResultSet rs = stmt.executeQuery(strSql);
	String curid="";
	String curcode="";
	String currate="";
	while(rs.next()) {
		curid+=rs.getInt("doc_no")+",";
		curcode+=rs.getString("code")+",";
		currate+=rs.getString("rate")+",";
  		} 
	curid=curid.substring(0, curid.length()-1);
	curcode=curcode.substring(0, curcode.length()-1);
	currate=currate.substring(0, currate.length()-1);
	System.out.println(curid+"####"+curcode+"####"+currate+"####"+multi);
	response.getWriter().write(curid+"####"+curcode+"####"+currate+"####"+multi);
	
	
	stmt.close();
	conn.close();
}
catch(Exception e)
{
	conn.close();
}
  %>
  
