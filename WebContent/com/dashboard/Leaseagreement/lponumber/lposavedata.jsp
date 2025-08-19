<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%	
ClsConnection objconn=new ClsConnection();
Connection conn=null;
int val=0;
int errorstatus=0;
try{
	String ra_no=request.getParameter("ra_no")==null?"":request.getParameter("ra_no");
	String lpo=request.getParameter("lpo")==null?"":request.getParameter("lpo");
	String oldlpo=request.getParameter("oldlpo")==null?"":request.getParameter("oldlpo");
	java.sql.Date sqlprocessdate=null;
	String upsql=null;
	int docval=0;
	conn = objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt = conn.createStatement ();
	if(!(lpo.equalsIgnoreCase("")|| lpo.equalsIgnoreCase("NA")))
	{
		upsql="update  gl_lagmt  set po='" +lpo+ "'  where doc_no='"+ra_no+"' ";
		System.out.println("----upsql-1--"+upsql);
		val= stmt.executeUpdate(upsql);
		if(val<=0){
			errorstatus=1;
		}
		upsql="insert into gl_bleasepo(lano, lpono,new_lpono, userid,edate)values('"+ra_no+"','"+oldlpo+"','"+lpo+"','"+session.getAttribute("USERID").toString()+"',now()) ";
		System.out.println("====4====="+upsql);
		val= stmt.executeUpdate(upsql);
		if(val<=0){
			errorstatus=1;
		}
		//upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+branchids+"','BVBR',now(),'"+session.getAttribute("USERID").toString()+"','A')";
	}
	if(errorstatus!=1){
		conn.commit();
	}
}
catch(Exception e){
	conn.close();
	e.printStackTrace();
}
finally{
	conn.close();
}
%>
