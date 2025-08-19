<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String bookdocno=request.getParameter("bookdocno")==null?"":request.getParameter("bookdocno");
String docname=request.getParameter("docname")==null?"":request.getParameter("docname");
JSONObject objdata=new JSONObject();
Connection conn=null;
ClsConnection objconn=new ClsConnection();
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select bookdocno,jobname,br.branchname,usr.user_name,date_format(m.logdate,'%d.%m.%Y %H:%i') logdate,coalesce(m.remarks,'') userremarks,coalesce(m.systemremarks,'') systemremarks from gl_limomgmtlog m left join my_brch br on m.brhid=br.doc_no left join my_user usr on m.userid=usr.doc_no where m.bookdocno="+bookdocno+" and m.jobname='"+docname+"'";
	ResultSet rs=stmt.executeQuery(strsql);
	JSONArray logarray=new JSONArray();
	while(rs.next()){
		JSONObject obj=new JSONObject();
		obj.put("branch",rs.getString("branchname"));
		obj.put("user",rs.getString("user_name"));
		obj.put("logdate",rs.getString("logdate"));
		obj.put("userremarks", rs.getString("userremarks"));
		obj.put("systemremarks",rs.getString("systemremarks"));
		logarray.add(obj);
	}
	objdata.put("logdata",logarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>