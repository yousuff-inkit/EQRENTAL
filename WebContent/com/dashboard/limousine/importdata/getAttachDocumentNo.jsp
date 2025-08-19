<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
	String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
	String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
	String id=request.getParameter("id")==null?"":request.getParameter("id");
	String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks");
	ClsConnection objconn=new ClsConnection();
	Connection conn=null;
	int docno=0;
	int errorstatus=0;
	try{
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt=conn.createStatement();
		String strgetmaxdoc="select coalesce(max(doc_no),0)+1 maxdocno from gl_limoimportreq";
		ResultSet rsgetmaxdoc=stmt.executeQuery(strgetmaxdoc);
		while(rsgetmaxdoc.next()){
			docno=rsgetmaxdoc.getInt("maxdocno");
		}
		if(branch.equalsIgnoreCase("") || branch.equalsIgnoreCase("a")){
			branch=session.getAttribute("BRANCHID")==null?"":session.getAttribute("BRANCHID").toString();
		}
		String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
		String strinsert="insert into gl_limoimportreq(doc_no, date, brhid, cldocno, userid, remarks,status)values("+
		" "+docno+",CURDATE(),"+branch+","+cldocno+","+userid+",'"+remarks+"',3)";
		int insert=stmt.executeUpdate(strinsert);
		if(insert<=0){
			errorstatus=1;
		}
		if(errorstatus==0){
			conn.commit();
		}
		else{
			docno=0;
		}
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		if(conn!=null){
			conn.close();	
		}
		
	}
	response.getWriter().write(docno+"");
  %>
  