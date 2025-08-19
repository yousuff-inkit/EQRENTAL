<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
	JSONObject objdata=new JSONObject();
	Connection conn=null;
	try{
		ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		
		int opassetconfig=0;
		String stropasset="select method from gl_config where field_nme='OPAsset'";
		ResultSet rsopasset=stmt.executeQuery(stropasset);
		while(rsopasset.next()){
			opassetconfig=rsopasset.getInt("method");
		}
		
		objdata.put("OPAssetConfig",opassetconfig);
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	response.getWriter().write(objdata+"");
%>