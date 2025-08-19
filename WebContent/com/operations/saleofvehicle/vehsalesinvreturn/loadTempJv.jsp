<%@page import="com.operations.saleofvehicle.vehicledisposal.ClsVehicleDisposalDAO"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>

<%
Connection conn=null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
ClsVehicleDisposalDAO disposaldao=new ClsVehicleDisposalDAO();
String salesprice=request.getParameter("salesprice")==null?"":request.getParameter("salesprice");
String dep_posted=request.getParameter("dep_posted")==null?"":request.getParameter("dep_posted");
String purvalue=request.getParameter("purvalue")==null?"":request.getParameter("purvalue");
String accdep=request.getParameter("accdep")==null?"":request.getParameter("accdep");
String curdep=request.getParameter("curdep")==null?"":request.getParameter("curdep");
String netpl=request.getParameter("netpl")==null?"":request.getParameter("netpl");
String netbook=request.getParameter("netbook")==null?"":request.getParameter("netbook");
String client=request.getParameter("client")==null?"":request.getParameter("client");
String dtype=request.getParameter("dtype")==null?"":request.getParameter("dtype");
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String date=request.getParameter("date")==null?"":request.getParameter("date");
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	java.sql.Date sqldate=null,sqldocdate=null;
	if(!dep_posted.equalsIgnoreCase("")){
		sqldate=objcommon.changeStringtoSqlDate(dep_posted);
	}
	if(!date.equalsIgnoreCase("")){
		sqldocdate=objcommon.changeStringtoSqlDate(date);
	}
	System.out.println("//"+client+"//");
	int docno=disposaldao.getTempJV(Double.parseDouble(purvalue),Double.parseDouble(accdep),Double.parseDouble(curdep),
			Double.parseDouble(salesprice),Double.parseDouble(netpl),session.getAttribute("CURRENCYID").toString(),
			Integer.parseInt(client),Double.parseDouble(netbook),fleetno,dtype,sqldocdate,"A",conn);
	/* CallableStatement stmtDisposal = conn.prepareCall("{call tempsaleJvDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
	stmtDisposal.registerOutParameter(9, java.sql.Types.INTEGER);
	stmtDisposal.registerOutParameter(10, java.sql.Types.INTEGER);
	stmtDisposal.setDouble(1,Double.parseDouble(purvalue));
	stmtDisposal.setDouble(2,Double.parseDouble(accdep));
	stmtDisposal.setDouble(3,Double.parseDouble(curdep));
	stmtDisposal.setDouble(4,Double.parseDouble(salesprice));
	stmtDisposal.setDouble(5,Double.parseDouble(netpl));
	stmtDisposal.setString(6,"A");
	stmtDisposal.setString(7,session.getAttribute("CURRENCYID").toString());
	stmtDisposal.setInt(8,Integer.parseInt(client.trim()));
	stmtDisposal.setDouble(11,Double.parseDouble(netbook));
	stmtDisposal.setString(12, fleetno);
	stmtDisposal.setString(13, dtype);
	stmtDisposal.setDate(14, sqldocdate);
	System.out.println(stmtDisposal);
	stmtDisposal.executeQuery();
	
	int docno=0;
	docno=stmtDisposal.getInt("docno");*/
	if(docno>0){
		conn.commit();
	}
	response.getWriter().print(docno);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
  %>