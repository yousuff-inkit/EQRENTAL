<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
String client=request.getParameter("client")==null?"":request.getParameter("client");
String location=request.getParameter("location")==null?"":request.getParameter("location");
String amount=request.getParameter("amount")==null?"":request.getParameter("amount");
ClsConnection objconn=new ClsConnection();
int errorstatus=0;
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	//Checking if client and location exists
	String strchecking="select doc_no from gl_limoparkingfee where status=3 and cldocno="+client+" and locationdocno="+location;
	System.out.println(strchecking);
	ResultSet rschecking=stmt.executeQuery(strchecking);
	int docno=0;
	while(rschecking.next()){
		docno=rschecking.getInt("doc_no");
	}
	String mode="";
	String brhid=session.getAttribute("BRANCHID")==null?"":session.getAttribute("BRANCHID").toString();
	String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
	
	if(docno>0){
		
		//Document Exists,Update It
		mode="E";
		String strupdate="update gl_limoparkingfee set cldocno="+client+",locationdocno="+location+",amount="+amount+" where doc_no="+docno;
		System.out.println(strupdate);
		int update=stmt.executeUpdate(strupdate);
		if(update<=0){
			System.out.println("Update Error");
			errorstatus=1;
		}
	}
	else{
		mode="A";
		String strmaxdocno="select max(coalesce(doc_no,0))+1 maxdocno from gl_limoparkingfee";
		System.out.println(strmaxdocno);
		ResultSet rsmaxdocno=stmt.executeQuery(strmaxdocno);
		while(rsmaxdocno.next()){
			docno=rsmaxdocno.getInt("maxdocno");
		}
		String strinsert="insert into gl_limoparkingfee(doc_no,cldocno, locationdocno, amount, date, brhid, userid, status)values("+docno+","+client+","+location+","+amount+",CURDATE(),"+brhid+","+userid+",3)";
		System.out.println(strmaxdocno);
		int insert=stmt.executeUpdate(strinsert);
		if(insert<=0){
			System.out.println("Insert Error");
			errorstatus=1;
		}
	}
	
	PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
	stmtlog.setInt(1,docno);
	stmtlog.setInt(2,Integer.parseInt(brhid));
	stmtlog.setString(3,"BLPF");
	stmtlog.setInt(4, Integer.parseInt(userid));
	stmtlog.setInt(5, 0);
	stmtlog.setInt(6, 0);
	stmtlog.setString(7,mode);
	int log=stmtlog.executeUpdate();
	if(log<=0){
		System.out.println("Log Error");
		errorstatus=1;
	}
	if(errorstatus==0){
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>