<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>   
<%@page import="com.finance.nipurchase.nipurchase.ClsnipurchaseDAO" %>       
<%@page import="com.ibm.icu.text.SimpleDateFormat" %>        
<%	
ClsConnection ClsConnection=new ClsConnection();  
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;  
    
	try{
	 	conn = ClsConnection.getMyConnection();              
		Statement stmt = conn.createStatement(); 
		int docno=request.getParameter("docno")=="" || request.getParameter("docno")==null?0:Integer.parseInt(request.getParameter("docno").trim().toString());
		String brhid=request.getParameter("brhid")=="" || request.getParameter("brhid")==null?"0":request.getParameter("brhid");
		String bill=request.getParameter("bill")=="" || request.getParameter("bill")==null?"0":request.getParameter("bill");
		String date=request.getParameter("date")=="" || request.getParameter("date")==null?"0":request.getParameter("date");
		String invdate=request.getParameter("invdate")=="" || request.getParameter("invdate")==null?"0":request.getParameter("invdate");
		String desc=request.getParameter("desc")=="" || request.getParameter("desc")==null?"0":request.getParameter("desc");
		String netamt=request.getParameter("netamt")=="" || request.getParameter("netamt")==null?"0":request.getParameter("netamt");
	    String acctype=request.getParameter("acctype")==null || request.getParameter("acctype").trim().equalsIgnoreCase("")?"0":request.getParameter("acctype").toString();
	    String invno=request.getParameter("invno")==null || request.getParameter("invno").trim().equalsIgnoreCase("")?"0":request.getParameter("invno").toString();
	    String puraccname=request.getParameter("puraccname")==null || request.getParameter("puraccname").trim().equalsIgnoreCase("")?"0":request.getParameter("puraccname").toString();
	    String accdoc=request.getParameter("accdoc")==null || request.getParameter("accdoc").trim().equalsIgnoreCase("")?"0":request.getParameter("accdoc").toString();
	    String queryarray=request.getParameter("gridarray")==null || request.getParameter("gridarray").trim().equalsIgnoreCase("")?"0":request.getParameter("gridarray").toString();
		int dat=0,vocno=0;       
		ArrayList<String> gridarray=new ArrayList<String>();
		 if(queryarray.length()>0){
			String temparray[]=queryarray.split(",");  
			for(int i=0;i<temparray.length;i++){
				gridarray.add(temparray[i]);
			}            
		}
		session.setAttribute("BRANCHID",brhid);  
		ClsnipurchaseDAO DAO=new ClsnipurchaseDAO();         
		java.sql.Date sqlStartDate=null;
		java.sql.Date sqlinvdate=null;
		SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");              
		java.util.Date curDate=new java.util.Date();
	    java.sql.Date cdate=ClsCommon.changeStringtoSqlDate(formatter.format(curDate));
	    if(!invdate.equalsIgnoreCase("") && !invdate.equalsIgnoreCase("0")){
	    	sqlinvdate=ClsCommon.changeStringtoSqlDate(invdate);   
	    }
	    if(!date.equalsIgnoreCase("") && !date.equalsIgnoreCase("0")){   
	    	sqlStartDate=ClsCommon.changeStringtoSqlDate(date);  
	    } 
	    System.out.println("in=="+bill); 
	    System.out.println("gridarray=="+gridarray);      
	    dat=DAO.insert(sqlStartDate, cdate, "NPO", docno, acctype,accdoc,  puraccname,  "1",  "1","","",desc,session,"A",Double.parseDouble(netamt),gridarray, "CPU",request,  sqlinvdate,  invno, "", 0,  Integer.parseInt(bill), 1, bill);
	    //System.out.println("val--->>>"+dat); 
	    vocno=Integer.parseInt(request.getAttribute("vocno").toString());
		response.getWriter().print(dat+"###"+vocno);                   
 	stmt.close();   
 	conn.close();           
	}catch(Exception e){
	 	e.printStackTrace();  
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
