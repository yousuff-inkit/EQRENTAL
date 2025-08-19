<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%
String strtarifarray=request.getParameter("tarifarray")==null?"":request.getParameter("tarifarray");
String agmtdocno=request.getParameter("agmtdocno")==null?"":request.getParameter("agmtdocno");
ArrayList<String> tarifarray=new ArrayList();
Connection conn=null;
int errorstaus=0;
ClsConnection objconn=new ClsConnection();
try{
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	String oldtarif="";
	int branch=0;
	String stroldtarif="select brhid, rate, cdw, pai, cdw1, pai1, gps, babyseater, cooler, kmrest, exkmrte, chaufchg, chaufexchg from gl_ltarif where rdocno="+agmtdocno;
	System.out.println(stroldtarif);
	ResultSet rsoldtarif=stmt.executeQuery(stroldtarif);
	while(rsoldtarif.next()){
		branch=rsoldtarif.getInt("brhid");
		oldtarif=rsoldtarif.getString("rate")+"::"+rsoldtarif.getString("cdw")+"::"+rsoldtarif.getString("pai")+"::"+rsoldtarif.getString("cdw1")+"::"+rsoldtarif.getString("pai1")+"::"+rsoldtarif.getString("gps")+"::"+rsoldtarif.getString("babyseater")+"::"+rsoldtarif.getString("cooler")+"::"+rsoldtarif.getString("kmrest")+"::"+rsoldtarif.getString("exkmrte")+"::"+rsoldtarif.getString("chaufchg")+"::"+rsoldtarif.getString("chaufexchg");
	}
	int maxdocno=0;
	String strgetmaxdocno="select coalesce(max(doc_no),0)+1 maxdocno from gl_ltarifchange";
	System.out.println(strgetmaxdocno);
	ResultSet rsmaxdocno=stmt.executeQuery(strgetmaxdocno);
	while(rsmaxdocno.next()){
		maxdocno=rsmaxdocno.getInt("maxdocno");
	}
	tarifarray.add(0,oldtarif);
	tarifarray.add(1,strtarifarray);
	
	for(int i=0;i<tarifarray.size();i++){
		String tariff[]=tarifarray.get(i).split("::");
		String strinserttarif="insert into gl_ltarifchange(doc_no,rdocno, brhid, rate, cdw, pai, cdw1, pai1, gps, babyseater, cooler, kmrest, exkmrte, chaufchg, chaufexchg, rstatus) values"+
		 " ("+maxdocno+","+agmtdocno+","+branch+",'"+(tariff[0].equalsIgnoreCase("undefined") || tariff[0].equalsIgnoreCase("") || tariff[0].trim().equalsIgnoreCase("NaN")|| tariff[0].isEmpty()?0:tariff[0].trim())+"',"
		+ "'"+(tariff[1].trim().equalsIgnoreCase("undefined")  || tariff[1].trim().equalsIgnoreCase("") || tariff[1].trim().equalsIgnoreCase("NaN")|| tariff[1].isEmpty()?0:tariff[1].trim())+"',"
       + "'"+(tariff[2].trim().equalsIgnoreCase("undefined") || tariff[2].trim().equalsIgnoreCase("") || tariff[2].trim().equalsIgnoreCase("NaN")|| tariff[2].isEmpty()?0:tariff[2].trim())+"',"
       + "'"+(tariff[3].trim().equalsIgnoreCase("undefined") || tariff[3].trim().equalsIgnoreCase("") || tariff[3].trim().equalsIgnoreCase("NaN")|| tariff[3].isEmpty()?0:tariff[3].trim())+"',"
       + "'"+(tariff[4].trim().equalsIgnoreCase("undefined") || tariff[4].trim().equalsIgnoreCase("")|| tariff[4].trim().equalsIgnoreCase("NaN") || tariff[4].isEmpty()?0:tariff[4].trim())+"',"
       + "'"+(tariff[5].trim().equalsIgnoreCase("undefined") || tariff[5].trim().equalsIgnoreCase("") || tariff[5].trim().equalsIgnoreCase("NaN")|| tariff[5].isEmpty()?0:tariff[5].trim())+"',"
       + "'"+(tariff[6].trim().equalsIgnoreCase("undefined") || tariff[6].trim().equalsIgnoreCase("") || tariff[6].trim().equalsIgnoreCase("NaN")|| tariff[6].isEmpty()?0:tariff[6].trim())+"',"
       + "'"+(tariff[7].trim().equalsIgnoreCase("undefined") || tariff[7].trim().equalsIgnoreCase("") || tariff[7].trim().equalsIgnoreCase("NaN")|| tariff[7].isEmpty()?0:tariff[7].trim())+"',"
       + "'"+(tariff[8].trim().equalsIgnoreCase("undefined") || tariff[8].trim().equalsIgnoreCase("") || tariff[8].trim().equalsIgnoreCase("NaN")|| tariff[8].isEmpty()?0:tariff[8].trim())+"',"
       + "'"+(tariff[9].trim().equalsIgnoreCase("undefined") || tariff[9].trim().equalsIgnoreCase("") || tariff[9].trim().equalsIgnoreCase("NaN")|| tariff[9].isEmpty()?0:tariff[9].trim())+"',"
       + "'"+(tariff[10].trim().equalsIgnoreCase("undefined") || tariff[10].trim().equalsIgnoreCase("")|| tariff[10].trim().equalsIgnoreCase("NaN")|| tariff[10].isEmpty()?0:tariff[10].trim())+"',"
       + "'"+(tariff[11].trim().equalsIgnoreCase("undefined") || tariff[11].trim().equalsIgnoreCase("")|| tariff[11].trim().equalsIgnoreCase("NaN")|| tariff[11].isEmpty()?0:tariff[11].trim())+"',0)";
		System.out.println(strinserttarif);
		int val=stmt.executeUpdate(strinserttarif);
		if(val<=0){
			errorstaus=1;
		}
	}
	String tariff[]=strtarifarray.split("::");
	String strupdatetariff="update gl_ltarif set rate="+(tariff[0].equalsIgnoreCase("undefined") || tariff[0].equalsIgnoreCase("") || tariff[0].trim().equalsIgnoreCase("NaN")|| tariff[0].isEmpty()?0:tariff[0].trim())+","+
	" cdw="+(tariff[1].equalsIgnoreCase("undefined") || tariff[1].equalsIgnoreCase("") || tariff[1].trim().equalsIgnoreCase("NaN")|| tariff[1].isEmpty()?0:tariff[1].trim())+","+
	" pai="+(tariff[2].equalsIgnoreCase("undefined") || tariff[2].equalsIgnoreCase("") || tariff[2].trim().equalsIgnoreCase("NaN")|| tariff[2].isEmpty()?0:tariff[2].trim())+","+
	" cdw1="+(tariff[3].equalsIgnoreCase("undefined") || tariff[3].equalsIgnoreCase("") || tariff[3].trim().equalsIgnoreCase("NaN")|| tariff[3].isEmpty()?0:tariff[3].trim())+","+
	" pai1="+(tariff[4].equalsIgnoreCase("undefined") || tariff[4].equalsIgnoreCase("") || tariff[4].trim().equalsIgnoreCase("NaN")|| tariff[4].isEmpty()?0:tariff[4].trim())+","+
	" gps="+(tariff[5].equalsIgnoreCase("undefined") || tariff[5].equalsIgnoreCase("") || tariff[5].trim().equalsIgnoreCase("NaN")|| tariff[5].isEmpty()?0:tariff[5].trim())+","+
	" babyseater="+(tariff[6].equalsIgnoreCase("undefined") || tariff[6].equalsIgnoreCase("") || tariff[6].trim().equalsIgnoreCase("NaN")|| tariff[6].isEmpty()?0:tariff[6].trim())+","+
	" cooler="+(tariff[7].equalsIgnoreCase("undefined") || tariff[7].equalsIgnoreCase("") || tariff[7].trim().equalsIgnoreCase("NaN")|| tariff[7].isEmpty()?0:tariff[7].trim())+","+
	" kmrest="+(tariff[8].equalsIgnoreCase("undefined") || tariff[8].equalsIgnoreCase("") || tariff[8].trim().equalsIgnoreCase("NaN")|| tariff[8].isEmpty()?0:tariff[8].trim())+","+
	" exkmrte="+(tariff[9].equalsIgnoreCase("undefined") || tariff[9].equalsIgnoreCase("") || tariff[9].trim().equalsIgnoreCase("NaN")|| tariff[9].isEmpty()?0:tariff[9].trim())+","+
	" chaufchg="+(tariff[10].equalsIgnoreCase("undefined") || tariff[10].equalsIgnoreCase("") || tariff[10].trim().equalsIgnoreCase("NaN")|| tariff[10].isEmpty()?0:tariff[10].trim())+","+
	" chaufexchg="+(tariff[11].equalsIgnoreCase("undefined") || tariff[11].equalsIgnoreCase("") || tariff[11].trim().equalsIgnoreCase("NaN")|| tariff[11].isEmpty()?0:tariff[11].trim())+" where rdocno="+agmtdocno;
	System.out.println(strupdatetariff);
	int updateval=stmt.executeUpdate(strupdatetariff);
	if(updateval<0){
		errorstaus=1;
	}
	String strinsertlog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY)values("+maxdocno+","+branch+",'BLTC',now(),"+session.getAttribute("USERID").toString()+",'A')";
	int logval=stmt.executeUpdate(strinsertlog);
	if(logval<=0){
		errorstaus=1;
	}
	if(errorstaus==0){
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
	errorstaus=1;
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(errorstaus+"");
%>