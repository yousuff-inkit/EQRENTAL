<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
ClsConnection objconn=new ClsConnection();
conn=objconn.getMyConnection();
try{
	
	int vehsaleinvfuturedate=0;
	String strsql="select method from gl_config where field_nme='vehSaleInvFutureDate'";
	ResultSet rs=conn.createStatement().executeQuery(strsql);
	while(rs.next()){
		vehsaleinvfuturedate=rs.getInt("method");
	}
	objdata.put("vehsaleinvfuturedate",vehsaleinvfuturedate);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>