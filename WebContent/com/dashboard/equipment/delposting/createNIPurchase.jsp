<%@page import="java.util.ArrayList"%>
<%@page import="com.finance.nipurchase.nipurchase.ClsnipurchaseDAO"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.ibm.icu.text.SimpleDateFormat" %>
<%
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
Connection conn=null;

int errorstatus=0;
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String vendorid=request.getParameter("vendorid")==null?"":request.getParameter("vendorid");
String date=request.getParameter("date")=="" || request.getParameter("date")==null?"":request.getParameter("date");
String invdate=request.getParameter("invdate")=="" || request.getParameter("invdate")==null?"":request.getParameter("invdate");
String desc=request.getParameter("desc")=="" || request.getParameter("desc")==null?"":request.getParameter("desc");
String address=request.getParameter("address")=="" || request.getParameter("address")==null?"":request.getParameter("address");
String invno=request.getParameter("invno")==null || request.getParameter("invno").trim().equalsIgnoreCase("")?"":request.getParameter("invno").toString();
String strarray=request.getParameter("gridarray")==null || request.getParameter("gridarray").trim().equalsIgnoreCase("")?"":request.getParameter("gridarray").toString();
String bill=request.getParameter("bill")=="" || request.getParameter("bill")==null?"0":request.getParameter("bill");
String chkinclusive=request.getParameter("chkinclusive")==null?"":request.getParameter("chkinclusive");

try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	ClsnipurchaseDAO dao=new ClsnipurchaseDAO();
	java.sql.Date sqlStartDate=null,sqlinvdate=null;
	SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");              
	java.util.Date curDate=new java.util.Date();
    java.sql.Date cdate=objcommon.changeStringtoSqlDate(formatter.format(curDate));
    String vendortaxtype="";
    if(chkinclusive.equalsIgnoreCase("1")){
    	vendortaxtype="I";
    }
    else{
    	vendortaxtype="E";
    }
    if(!invdate.equalsIgnoreCase("") && !invdate.equalsIgnoreCase("0")){
    	sqlinvdate=objcommon.changeStringtoSqlDate(invdate);   
    }
    if(!date.equalsIgnoreCase("") && !date.equalsIgnoreCase("0")){   
    	sqlStartDate=objcommon.changeStringtoSqlDate(date);  
    }
    ArrayList<String> gridarray=new ArrayList();
    double netamt=0.0;
    String strvndgetaccount="select ac.acno doc_no,head.atype,head.description from my_account ac left join my_head head on (ac.acno=head.doc_no) where ac.codeno='DELPOSTING'";
	String vndacno="",vndactype="",vndacname="";
	ResultSet rsgetvndaccount=stmt.executeQuery(strvndgetaccount);
	while(rsgetvndaccount.next()){
		vndacno=rsgetvndaccount.getString("doc_no");
		vndactype=rsgetvndaccount.getString("atype");
		vndacname=rsgetvndaccount.getString("description");
	}
    for(int i=0,j=1;i<strarray.split(",").length;i++,j++){
    	String temp[]=strarray.split(",")[i].split("::");
    	if(!temp[6].equalsIgnoreCase("") && temp[6]!=null && temp[6]!="undefined"){
    		netamt+=Double.parseDouble(temp[6]);
    	}
    	String fleetno=temp[0];
    	String driver=temp[1];
    	double amount=Double.parseDouble(temp[2]);
    	double discount=Double.parseDouble(temp[3]);
    	double nettotal=Double.parseDouble(temp[4]);
    	double tax=Double.parseDouble(temp[5]);
    	double grandtotal=Double.parseDouble(temp[6]);
    	String datetime=temp[7];
    	String description=temp[8];
    	
    	double taxpercent=0.0;
    	amount=objcommon.Round(amount, 2);
    	discount=objcommon.Round(discount, 2);
    	nettotal=objcommon.Round(nettotal, 2);
    	tax=objcommon.Round(tax, 2);
    	grandtotal=objcommon.Round(grandtotal, 2);
    	if(tax>0.0){
    		taxpercent=5;
    	}
    	//String description="Fleetno - "+fleetno+" driver - "+driver+" on "+datetime;
    	
    	gridarray.add(j+"::"+1+"::"+description+"::"+amount+"::"+amount+"::"+discount+"::"+nettotal+"::"+nettotal+"::"+0+"::"+0+"::"+""+"::"+vndacno+"::"+taxpercent+"::"+tax+"::"+grandtotal+"::"+j);
    	
    }
    String strgetaccount="select head.doc_no,head.atype,head.description from my_acbook ac left join my_head head on (ac.acno=head.doc_no) where ac.dtype='VND' and ac.cldocno="+vendorid;
	String acno="",actype="",acname="";
	ResultSet rsgetaccount=stmt.executeQuery(strgetaccount);
	while(rsgetaccount.next()){
		acno=rsgetaccount.getString("doc_no");
		actype=rsgetaccount.getString("atype");
		acname=rsgetaccount.getString("description");
	}
	
	session.setAttribute("BRANCHID", branch);
	
    int value=dao.insert(sqlStartDate, cdate, "DIR", 0, actype,acno,acname,"1","1",address,"",desc,session,"A",netamt,gridarray,"CPU",request,sqlinvdate,invno,"",0,Integer.parseInt(bill),1,bill);
    
    if(value>0){
    	String strgetnitrno="select tr_no from my_srvpurm where status=3 and doc_no="+value;
    	int nitrno=0;
    	ResultSet rsgetnitrno=stmt.executeQuery(strgetnitrno);
    	while(rsgetnitrno.next()){
    		nitrno=rsgetnitrno.getInt("tr_no");
    	}
    	conn.setAutoCommit(false);
        	
        String strupdatedel="update eq_deldetails set jvtrno="+nitrno+" where srno="+docno;
        int updatelimo=stmt.executeUpdate(strupdatedel);
    	if(updatelimo<=0){
    		System.out.println("Delivery Posting Update Error");
    		errorstatus=1;
    	}
    	
    	String logsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+branch+"','BDP',now(),'"+session.getAttribute("USERID").toString()+"','A')";
        int insertlog=stmt.executeUpdate(logsql);
    	if(insertlog<=0){
    		System.out.println("biblog Insert Error");
    		errorstatus=1;
    	}
    	
    }
    else{
    	System.out.println("Ni Purchase Create Error");
    	errorstatus=1;
    }
    
    if(errorstatus==0){
    	conn.commit();
    }
    response.getWriter().write(errorstatus+"::"+value);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}

%>