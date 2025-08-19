<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
int errorstatus=0;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String str="select coalesce(max(doc_no),0)+1 maxdocno from gl_salikexcel";
	ResultSet rs=stmt.executeQuery(str);
	int maxdocno=0;
	while(rs.next()){
		maxdocno=rs.getInt("maxdocno");
		objdata.put("exceldocno",maxdocno);
	}
	String userid=session.getAttribute("USERID").toString();
	String brhid=session.getAttribute("BRANCHID").toString();
	//stmt.executeUpdate("set identity_insert gl_salikexcel on");
	String strinsert="insert into gl_salikexcel(doc_no,userid,brhid,edate,status)values("+maxdocno+","+userid+","+brhid+",now(),3)";
	System.out.println(strinsert);
	int insert=stmt.executeUpdate(strinsert);
	if(insert<=0){
		errorstatus=1;
	}
	objdata.put("errorstatus",errorstatus);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>
