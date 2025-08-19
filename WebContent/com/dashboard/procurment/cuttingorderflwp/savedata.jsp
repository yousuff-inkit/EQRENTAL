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
<%@page import="com.nisales.outsourcejob.ClsOutSourceJobDAO"%>
<%	
String costtype=request.getParameter("costtype")==null?"0":request.getParameter("costtype");
String costcode=request.getParameter("costcode")==null?"0":request.getParameter("costcode");
String salid=request.getParameter("salid")==null?"0":request.getParameter("salid");
String hiddocs=request.getParameter("hiddocs")==null?"0":request.getParameter("hiddocs");
String lpono=request.getParameter("lpono")==null?"0":request.getParameter("lpono");
String deltime=request.getParameter("deltime")==null?"0":request.getParameter("deltime");
String docdate=request.getParameter("docdate")==null?"0":request.getParameter("docdate");
String list=request.getParameter("gridarray")==null?"0":request.getParameter("gridarray");
String list2=request.getParameter("gridrowarray")==null?"0":request.getParameter("gridrowarray");
String acno=request.getParameter("acno")==null?"0":request.getParameter("acno");
System.out.println("costtype="+costtype+"costcode="+costcode+"salid="+salid+"lpono="+lpono+"deltime="+deltime+"docdate="+docdate+"acno="+acno);
System.out.println("list===="+list);
System.out.println("list2===="+list2);
Connection conn=null;
try{
	ClsConnection ClsConnection =new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	ClsOutSourceJobDAO DAO= new ClsOutSourceJobDAO();
	conn = ClsConnection.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt = conn.createStatement ();
	java.sql.Date sqlDate=null;
    int costtyp=0,costcd=0,sald=0,accno=0;

    ArrayList<String> proday= new ArrayList<String>();
	String aa[]=list.split(",");
		for(int i=0;i<aa.length;i++){
			 String bb[]=aa[i].split("::");
			 String temp="";
			 for(int j=0;j<bb.length;j++){ 
				 temp=temp+bb[j]+"::";
			}
			 proday.add(temp);
		  } 
		/* String aa1[]=list2.split(",");
		for(int i=0;i<aa1.length;i++){
			 String bb2[]=aa1[i].split("::");
			 String temp="";
			 System.out.println("rowarray ="+bb2[0]);
		} */
		
		System.out.println("proday ="+proday);
		
    if(!(docdate.equalsIgnoreCase("undefined"))&&!(docdate.equalsIgnoreCase(""))&&!(docdate.equalsIgnoreCase("0"))){
	     sqlDate=ClsCommon.changeStringtoSqlDate(docdate);
	}
    if(!(costtype.equalsIgnoreCase("undefined"))&&!(costtype.equalsIgnoreCase(""))&&!(costtype.equalsIgnoreCase("0"))){
    	costtyp=Integer.parseInt(costtype);
	}
    if(!(costcode.equalsIgnoreCase("undefined"))&&!(costcode.equalsIgnoreCase(""))&&!(costcode.equalsIgnoreCase("0"))){
    	costcd=Integer.parseInt(costcode);
	}
    if(!(salid.equalsIgnoreCase("undefined"))&&!(salid.equalsIgnoreCase(""))&&!(salid.equalsIgnoreCase("0"))){
    	sald=Integer.parseInt(salid);
	}
    if(!(acno.equalsIgnoreCase("undefined"))&&!(acno.equalsIgnoreCase(""))&&!(acno.equalsIgnoreCase("0"))){
    	accno=Integer.parseInt(acno);
	}
	
	int val= DAO.insert(proday,sqlDate,sqlDate,deltime,sqlDate,costtyp,costcd,sald,accno,lpono,"CUTTING ORDER NO - "+hiddocs,session,request,"OUTJ","A",1,1.0); 
	String vdocno=request.getAttribute("vocno").toString(); 
	if(val>0){
	System.out.println("Created Out Source Job Document No==="+vdocno);
	String aa1[]=list2.split(",");
	for(int i=0;i<aa1.length;i++){
		 String bb2[]=aa1[i].split("::");
		 String temp=bb2[0];
		 if(!(temp.equalsIgnoreCase("") && vdocno.equalsIgnoreCase("0"))){
				String sql="update my_cord m set m.outsourcejob="+vdocno+" where rowno="+temp+"";
				System.out.println("updtdsql ="+sql);
			val= stmt.executeUpdate(sql);
			}
		
		 
	}
	 if(val>0){
		 conn.commit();
	 }
	}else{
		val=0;
	}
	
	response.getWriter().print(val+"::"+vdocno);
	
	stmt.close();
	conn.close();
}
catch(Exception e){
	response.getWriter().print(0);
	conn.close();
	e.printStackTrace();
}
%>
