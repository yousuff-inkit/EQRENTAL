<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.ArrayList"%>

<%	
Connection conn = null;
ClsConnection objconn=new ClsConnection();
int returnval=0;
int errorstatus=0;
try{	
	String list=request.getParameter("list").equalsIgnoreCase("")?null:request.getParameter("list");
	String ddiw=request.getParameter("ddiw").equalsIgnoreCase("")?null:request.getParameter("ddiw");
	String dhpd=request.getParameter("dhpd").equalsIgnoreCase("")?null:request.getParameter("dhpd");
	String rateperexhour=request.getParameter("rateperexhour").equalsIgnoreCase("")?null:request.getParameter("rateperexhour");
	String exkmcharge=request.getParameter("exkmcharge").equalsIgnoreCase("")?null:request.getParameter("exkmcharge");
	String totalcostmargin=request.getParameter("totalcostmargin").equalsIgnoreCase("")?null:request.getParameter("totalcostmargin");
	String totalcosttotal=request.getParameter("totalcosttotal").equalsIgnoreCase("")?null:request.getParameter("totalcosttotal");
	String drivercostmargin=request.getParameter("drivercostmargin").equalsIgnoreCase("")?null:request.getParameter("drivercostmargin");
	String drivercosttotal=request.getParameter("drivercosttotal").equalsIgnoreCase("")?null:request.getParameter("drivercosttotal");
	String securitypassmargin=request.getParameter("securitypassmargin").equalsIgnoreCase("")?null:request.getParameter("securitypassmargin");
	String securitypasstotal=request.getParameter("securitypasstotal").equalsIgnoreCase("")?null:request.getParameter("securitypasstotal");
	String accessoriesmargin=request.getParameter("accessoriesmargin").equalsIgnoreCase("")?null:request.getParameter("accessoriesmargin");
	String accessoriestotal=request.getParameter("accessoriestotal").equalsIgnoreCase("")?null:request.getParameter("accessoriestotal");
	String ratepermonth=request.getParameter("ratepermonth").equalsIgnoreCase("")?null:request.getParameter("ratepermonth");
	String salik=request.getParameter("salik").equalsIgnoreCase("")?null:request.getParameter("salik");
	String fuelcost=request.getParameter("fuelcost").equalsIgnoreCase("")?null:request.getParameter("fuelcost");
	String netcostotal=request.getParameter("netcostotal").equalsIgnoreCase("")?null:request.getParameter("netcostotal");
	
	String docno=request.getParameter("docno").equalsIgnoreCase("")?null:request.getParameter("docno");
	String leasereqdocno=request.getParameter("leasereqdocno").equalsIgnoreCase("")?null:request.getParameter("leasereqdocno");
	String srno=request.getParameter("srno").equalsIgnoreCase("")?null:request.getParameter("srno");
	String totalcostpermonth=request.getParameter("totalcostpermonth").equalsIgnoreCase("")?"0.00":request.getParameter("totalcostpermonth");
	String drivercostpermonth=request.getParameter("drivercostpermonth").equalsIgnoreCase("")?"0.00":request.getParameter("drivercostpermonth");
	conn=objconn.getMyConnection();
	Statement stmt = conn.createStatement ();
	conn.setAutoCommit(false);
	ArrayList<String> mainarray= new ArrayList<String>();

	String aa[]=list.split(",");
	for(int i=0;i<aa.length;i++){
		 String bb[]=aa[i].split("::");
		 String temp="";
		 for(int j=0;j<bb.length;j++){
			 temp=temp+bb[j]+"::";
		}
		 mainarray.add(temp);
		// mainarrays.add(mainarray);
	 }
	
	for(int i=0,j=1;i<mainarray.size();i++,j++){
		String[] serarray=mainarray.get(i).split("::");
		double amount=Double.parseDouble(serarray[1].trim().equalsIgnoreCase("undefined") || serarray[1].trim().equalsIgnoreCase("null") || serarray[1].trim().equalsIgnoreCase("NaN")||serarray[1].trim().equalsIgnoreCase("")|| serarray[1].isEmpty()?"0.0":serarray[1].trim());
		double margin=Double.parseDouble(serarray[3].trim().equalsIgnoreCase("undefined") || serarray[3].trim().equalsIgnoreCase("null") || serarray[3].trim().equalsIgnoreCase("NaN")||serarray[3].trim().equalsIgnoreCase("")|| serarray[3].isEmpty()?"0.0":serarray[3].trim());
		double total=Double.parseDouble(serarray[4].trim().equalsIgnoreCase("undefined") || serarray[4].trim().equalsIgnoreCase("null") || serarray[4].trim().equalsIgnoreCase("NaN")||serarray[4].trim().equalsIgnoreCase("")|| serarray[4].isEmpty()?"0.0":serarray[4].trim());
		String strdelete="delete from gl_almariahleasecalcd where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno="+serarray[2];
		int deleteval=stmt.executeUpdate(strdelete);
		String strinsert="INSERT INTO gl_almariahleasecalcd( rdocno, leasereqdocno, srno, detaildocno, amount, status,margin,total)VALUES"
	  	           + " ('"+docno+"',"
	  	           + "'"+leasereqdocno+"',"
	  	           + "'"+srno+"',"
			       + "'"+(serarray[2].trim().equalsIgnoreCase("undefined") || serarray[2].trim().equalsIgnoreCase("null") || serarray[2].trim().equalsIgnoreCase("NaN")||serarray[2].trim().equalsIgnoreCase("")|| serarray[2].isEmpty()?0:serarray[2].trim())+"',"
			       + "'"+(serarray[1].trim().equalsIgnoreCase("undefined") || serarray[1].trim().equalsIgnoreCase("null") || serarray[1].trim().equalsIgnoreCase("NaN")||serarray[1].trim().equalsIgnoreCase("")|| serarray[1].isEmpty()?0:serarray[1].trim())+"',"
			       +"3,"+margin+","+total+")";
		System.out.println(strinsert);
		/* String strupdate="update gl_almariahcalcd set amount="+amount+",margin="+margin+",total="+total+" where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+" and detaildocno="+serarray[2];
		System.out.println(strupdate);
		int updateval=stmt.executeUpdate(strupdate);
		if(updateval<0){
			errorstatus=1;
		} */
		int insertval=stmt.executeUpdate(strinsert);
		if(insertval<=0){
			errorstatus=1;
		}
	}
	System.out.println("update gl_almariahleasecalcreq set  ratepermonth=round("+ratepermonth+",0), exkmcharge="+exkmcharge+", ddiw="+ddiw+", dhpd="+dhpd+", leaseincome="+totalcosttotal+", chuafferincome="+drivercosttotal+", fuelincome="+fuelcost+", salikcharge="+salik+",securitypassincome="+securitypasstotal+", accessories="+accessoriestotal+", rateperexhour="+rateperexhour+",savestatus=1,totalcostpermonth="+totalcostpermonth+",drivercostpermonth="+drivercostpermonth+" where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and sr_no="+srno+"");
	int val=stmt.executeUpdate("update gl_almariahleasecalcreq set  ratepermonth=round("+ratepermonth+",0), exkmcharge="+exkmcharge+", ddiw="+ddiw+", dhpd="+dhpd+", leaseincome="+totalcosttotal+", chuafferincome="+drivercosttotal+", fuelincome="+fuelcost+", salikcharge="+salik+",securitypassincome="+securitypasstotal+", accessories="+accessoriestotal+", rateperexhour="+rateperexhour+",savestatus=1,totalcostpermonth="+totalcostpermonth+",drivercostpermonth="+drivercostpermonth+" where rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and sr_no="+srno+"");
	if(val<0){
		errorstatus=1;
	}
	int val1=stmt.executeUpdate("update gl_almariahleasecalcd set  margin="+totalcostmargin+", total="+totalcosttotal+" where detaildocno=37 and rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+"");
	if(val1<0){
		errorstatus=1;
	}
	int val2=stmt.executeUpdate("update gl_almariahleasecalcd set  margin="+drivercostmargin+", total="+drivercosttotal+" where detaildocno=89 and rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+"");
	if(val2<0){
		errorstatus=1;
	}
	int val3=stmt.executeUpdate("update gl_almariahleasecalcd set  margin="+securitypassmargin+", total="+securitypasstotal+" where detaildocno=92 and rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+"");
	if(val3<0){
		errorstatus=1;
	}
	int val4=stmt.executeUpdate("update gl_almariahleasecalcd set  margin="+accessoriesmargin+", total="+accessoriestotal+" where detaildocno=93 and rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+"");
	if(val4<0){
		errorstatus=1;
	}
	int val5=stmt.executeUpdate("update gl_almariahleasecalcd set  total="+netcostotal+" where detaildocno=94 and rdocno="+docno+" and leasereqdocno="+leasereqdocno+" and srno="+srno+"");
	if(val5<0){
		errorstatus=1;
	}
	System.out.println(val+"//"+val1+"//"+val2+"//"+val3+"//"+val4+"//"+val5);
	if(errorstatus==1){
		returnval=0;
	}
	else{
		conn.commit();
		returnval=1;
	}
stmt.close();


}
catch(Exception e){
	e.printStackTrace();
	returnval=0;	
}
finally{
	conn.close();
}
response.getWriter().write(returnval+"");
  %>