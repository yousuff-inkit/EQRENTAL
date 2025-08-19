
 <%@page import="java.io.IOException"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="sun.misc.BASE64Encoder"%>
 <%@page import="java.io.File"%>
 <%@page import="java.io.FileOutputStream"%>
 <%@page import="java.io.Reader"%> 
 <%@page import="java.util.Random"%>
 <%@page import="javax.servlet.http.HttpServlet"%>
 <%@page import="javax.servlet.http.HttpServletRequest"%>
 <%@page import="javax.servlet.http.HttpServletResponse"%>
 <%@page import=" sun.misc.BASE64Decoder"%> 
 <%@page import="java.sql.Connection"%>
 <%@page import="com.connection.ClsConnection"%>
 <%@page import="java.sql.Statement"%>
 <%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="com.operations.vehicletransactions.vehicleinspection.ClsVehicleInspectionAction"%>
 
 <%
 
 System.out.println("in sign save");
 ClsConnection ClsConnection=new ClsConnection();
 ClsVehicleInspectionAction vehaction= new ClsVehicleInspectionAction();
 
 StringBuffer buffer = new StringBuffer(); 
 Reader reader = request.getReader(); 
 int current; 
 while((current = reader.read()) >= 0)
  buffer.append((char) current);
 
  String data = new String(buffer); 
  //System.out.println("string data--in signature"+data);
  data = data.substring(data.indexOf(",") + 1);
  //System.out.println("string data--in signature after"+data);
  String code=request.getParameter("formname");
  String doc=request.getParameter("docno");
  String desc=request.getParameter("descpt");
  String reftypid=request.getParameter("reftypid");
  String userid=request.getParameter("userid");
  System.out.println("===userid====="+userid);
  String location=request.getParameter("location");
  String insp=request.getParameter("inspection");
  System.out.println("===location====="+location);
  String agmtno=request.getParameter("agmtno");
  System.out.println("===savesignagmtno====="+agmtno);
  String agmtype=request.getParameter("agmtype");
  System.out.println("===savesignagmtype====="+agmtype);
  String srno="0";
  Connection conn =null;
 //System.out.println("===reftypid====="+reftypid);
 try{
  conn = ClsConnection.getMyConnection();
 
 /* String code="VOP";
 String doc="1";
 String srno="2"; */

 Statement stmt1 = conn.createStatement();
	String strSql1 = "select coalesce(max(sr_no)+1,1) srno from my_fileattach where doc_no="+insp+" and dtype='VIP'";

	System.out.println("==strsql1=="+strSql1);
	ResultSet rs1 = stmt1.executeQuery(strSql1);
	while(rs1.next()) {
		srno=rs1.getString("srno");
	}
 
  String fname="VIP"+'-'+insp+'-'+srno;
  String fname2=fname+".png";
 //System.out.println("CODE==="+code);
//  	System.out.println("Code"+getFormdetailcode());
  String dirname ="";
  //System.out.println(dirname);
  String path ="";
  
  Statement stmt = conn.createStatement ();
  String strSql = "select imgPath from my_comp where doc_no=1";
  //session.getAttribute("COMPANYID");
  //System.out.println("====strSql======="+strSql);
  ResultSet rs = stmt.executeQuery(strSql);
  String path1="";
  while(rs.next ()) {
  	path1=rs.getString("imgPath");
//  	System.out.println("IMGPATH:"+path);
  }
  path=path1.replace("\\", "/");
 
  //ServletContext context = request.getServletContext();
  //String path = context.getRealPath("/");

  File dir = new File(path+ "/attachment/VIP");
  	dir.mkdirs();
  	
  	conn.setAutoCommit(false);
	CallableStatement stmtAttach = conn.prepareCall("{ CALL fileAttachApp(?,?,?,?,?,?,?,?,?)}");
	
	stmtAttach.registerOutParameter(9, java.sql.Types.INTEGER);
	
	System.out.println("CALL fileAttach");
	
	stmtAttach.setString(1,insp);
	stmtAttach.setString(2,"1");
	stmtAttach.setString(3,"1");
	stmtAttach.setString(4,path+"//attachment//VIP//"+fname2);
	stmtAttach.setString(5,fname2);
	stmtAttach.setString(6,desc);
	stmtAttach.setString(7,reftypid);
	stmtAttach.setString(8,"VIP");
	stmtAttach.executeUpdate();
	int no=stmtAttach.getInt("srNo");
	 Statement stmt3 = conn.createStatement ();
String check=path+"//attachment//VIP//"+ fname2;
String strl="",docn="";
//System.out.println("CODE==="+code);
if(code.equalsIgnoreCase("APP")){
	System.out.println("inside app==="+code);
 strl="insert into an_signdetails(signature,rdocno,fileatchsrno,location,userid,date) values('"+check+"','"+insp+"','"+srno+"','"+location+"','"+userid+"',now())";
 stmt3.executeUpdate(strl);
}
if(code.equalsIgnoreCase("APR")){
	//System.out.println("inside appagmt==="+code);
	String sql="select (coalesce(max(row_no),0)) srNo from an_signdetails";
	ResultSet rss=stmt3.executeQuery(sql);
	while(rss.next ()) {
	  	docn=rss.getString("srNo");
	  }
	strl="update an_signdetails set signatureAgmt='"+check+"' where row_no='"+docn+"' ";
	System.out.println("update============"+strl);
	stmt3.executeUpdate(strl);
}
//System.out.println("sign val============"+strl);

//System.out.println("sign val============"+val);
	if(no>0){
		conn.commit();
	}
  	
  	
  
       
			String imageString = data;  
			byte byteArray[] = new byte[1000000];
			FileOutputStream fos = new FileOutputStream(path +"/attachment/VIP/"+ fname2); 
			byteArray = Base64.decodeBase64(imageString);
			fos.write(byteArray);
			fos.flush();
			fos.close();
			vehaction.mobilePrintAction(insp,request,agmtno,agmtype);
		 }
		  catch(Exception e){
			  e.printStackTrace();
		  }
		  finally{
			  conn.close(); 
		  }
  
%>
