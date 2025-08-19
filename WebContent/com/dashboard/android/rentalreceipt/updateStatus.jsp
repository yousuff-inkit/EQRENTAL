<%@page import="java.util.*"%>
<%@page import="java.sql.Date"%>

<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.operations.commtransactions.rentalreceipts.ClsRentalReceiptsDAO"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.Statement"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="org.apache.struts2.ServletActionContext"%>
<%@page import="java.text.DateFormat" %>
<%@page import="java.text.SimpleDateFormat" %>
<%
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

int doc=Integer.parseInt(request.getParameter("doc").toString());
int brno=Integer.parseInt(request.getParameter("brno").toString());
String dat1=request.getParameter("date1");
String type=request.getParameter("type");
String ctype=request.getParameter("ctype");
String chkno=request.getParameter("chkno");
String chkdate1=request.getParameter("chkdate");
String amount1=request.getParameter("amount");
double amount=Double.parseDouble(amount1);
String desc=request.getParameter("desc");
String cldocno1=request.getParameter("cldocno");
int cldocno=Integer.parseInt(cldocno1);
String txtdoc1=request.getParameter("txtdoc");
int txtdoc=Integer.parseInt(txtdoc1);
String txtacno1=request.getParameter("txtacno");
int txtacno=Integer.parseInt(txtacno1);

java.sql.Date date1 = null;
java.sql.Date chkdate = null;

if(!(dat1.equalsIgnoreCase("undefined")) && !(dat1.equalsIgnoreCase("")) && !(dat1.equalsIgnoreCase("0"))){
	date1 = ClsCommon.changeStringtoSqlDate2(dat1);
}
if(!(chkdate1.equalsIgnoreCase("undefined")) && !(chkdate1.equalsIgnoreCase("")) && !(chkdate1.equalsIgnoreCase("0"))){
	chkdate = ClsCommon.changeStringtoSqlDate2(chkdate1);
}
  Connection conn=null;
String tempstatus="";


 try
{
	 
	conn=ClsConnection.getMyConnection();
	Statement stmtRRV=null;
	ClsRentalReceiptsDAO objstatus=new ClsRentalReceiptsDAO();
	ArrayList<String> ap= new ArrayList<String>();
	int val=objstatus.insert(conn,date1,"RRV",type,txtdoc,ctype,chkno,chkdate,desc,0,"",cldocno,txtacno,null,"0","1",amount,0,0,0,amount,desc,desc,0,ap,session,request);
	
	if(val>0)
	{
		stmtRRV = conn.createStatement();
		int trno=Integer.parseInt(request.getAttribute("transactionno").toString().trim());
		String sql=("update an_rentalreceipt set rrv_trno="+trno+" where branch_no="+brno+" and doc_no="+doc+"");
	    int data = stmtRRV.executeUpdate(sql);
	      if(data>0)
	      {
	    	  
	    	  tempstatus="1";
	  		stmtRRV.close();
	  		conn.close();
	      }
	      else
	      {
	    	  stmtRRV.close();
		  	  conn.close();
	      }
	}
	response.getWriter().write(tempstatus+"::"+val);
	
}catch(Exception e){
    e.printStackTrace();
    conn.close();
 } 

	
  %>