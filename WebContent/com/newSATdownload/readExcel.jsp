<%@page import="com.NewSatDownload.SATdownloadWithoutCaptchaAction"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@page import="org.apache.poi.openxml4j.opc.OPCPackage"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.poi.ss.usermodel.Row"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="org.apache.poi.poifs.filesystem.POIFSFileSystem"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="java.io.File"%>
<%@page import="com.NewSatDownload.SATdownloadDAO"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
	String exceldocno=request.getParameter("exceldocno")==null?"":request.getParameter("exceldocno");
	Connection conn=null;
	int errorstatus=0;
	int xsadoc=0;
	JSONObject objdata=new JSONObject();
	try{
		ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		SATdownloadWithoutCaptchaAction action=new SATdownloadWithoutCaptchaAction();
		SATdownloadDAO dao=new SATdownloadDAO();
		xsadoc=dao.downloadExcelSaliks(conn, exceldocno, session);
		if(xsadoc>0){
			String strupdate="update gl_salikexcel set salikdocno="+xsadoc+" where doc_no="+exceldocno;
			int update=conn.createStatement().executeUpdate(strupdate);
			if(update<=0){
				errorstatus=1;
			}
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
	objdata.put("salikdocno",xsadoc);
	response.getWriter().write(objdata+"");
%>