<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*" %>

<%@page import= "com.common.ClsCommon"%> 
<%@page import="com.finance.nipurchase.nipurchase.ClsnipurchaseDAO"%>
<%@page import="com.dashboard.serviceandmaintenance.workshopinvoice.ClsWorkshopInvoice"%>
<%
Connection conn = null;
ClsCommon commonDAO = new ClsCommon();
ClsConnection ClsConnection=new ClsConnection();
ClsnipurchaseDAO purchaseDAO= new ClsnipurchaseDAO();
ClsWorkshopInvoice invDAO=new ClsWorkshopInvoice();

String invno=request.getParameter("invno");
String invdate=request.getParameter("invdate");
String desc=request.getParameter("desc");
String refno=request.getParameter("refno");
Double totalinv=Double.parseDouble(request.getParameter("totalinv"));
String acno=request.getParameter("acno");

java.sql.Date sqlinvdate=null;
sqlinvdate=commonDAO.changeStringtoSqlDate(invdate);

ArrayList<String> masterarray= new ArrayList<String>();
String nipurchasearray=request.getParameter("nipurchasearray");
String[] temparray=nipurchasearray.split(",");
for(int i=0;i<temparray.length;i++){
 masterarray.add(temparray[i]);
}
// System.out.println("--array --"+masterarray);
int val= purchaseDAO.insert(sqlinvdate,sqlinvdate,"DIR",0,"GL",acno,"CARFARE WORKSHOP", 
		"1","1","","",desc+" : "+refno,session,"A",totalinv,masterarray,"BVWI",
		request,sqlinvdate,invno,invdate,0,1,1,"0");
 // System.out.println("--purchaseDAO --"+masterarray);
 if(val>0){
	String wsdb=invDAO.getDatabase("ws");
	
	int trno=Integer.parseInt(request.getAttribute("trans")+"");
	conn=ClsConnection.getMyConnection();
	Statement stmt=conn.createStatement();
	String str="update "+wsdb+"ws_invm set nipno="+trno+" where doc_no="+invno;
	//System.out.println("--"+str);
	stmt.executeUpdate(str);
}
response.getWriter().write(val+"");

%>