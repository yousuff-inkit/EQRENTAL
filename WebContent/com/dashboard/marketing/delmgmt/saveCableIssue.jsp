<%@page import="java.util.ArrayList"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
int errorstatus=0;
String docno=request.getParameter("docno")==null?"":request.getParameter("docno").toString();
String strcablearray[]=request.getParameterValues("cablearray[]")==null?null:request.getParameterValues("cablearray[]");

ArrayList<String> cablearray=new ArrayList();
for(int i=0;i<strcablearray.length;i++){
	cablearray.add(strcablearray[i]);
}
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	conn.setAutoCommit(false);
	String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
	
	//String strdelete="delete from my_cableissue where contractdocno="+docno;
	//int delete=stmt.executeUpdate(strdelete);
	for(int i=0;i<cablearray.size();i++){
		String assetgrpid=cablearray.get(i).split("::")[0].trim();
		String qty=cablearray.get(i).split("::")[1].trim();
		String strinsert="insert into my_cableissue(assetgrpid,contractdocno,edate,userid,qty,status)values("+assetgrpid+","+docno+",now(),"+userid+","+qty+",3)";
		System.out.println(strinsert);
		int insert=stmt.executeUpdate(strinsert);
		if(insert<=0){
			
			errorstatus=1;
			break;
		}
	}
	
	if(errorstatus==0){
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
}
finally{
	conn.close();
}
objdata.put("errorstatus",errorstatus);
response.getWriter().write(objdata+"");
%>