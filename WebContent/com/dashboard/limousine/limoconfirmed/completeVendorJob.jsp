<%@page import="java.util.ArrayList"%>
<%@page import="com.dashboard.limousine.jobclose.ClsLimoJobCloseDAO"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String bookdocno=request.getParameter("bookdocno")==null?"":request.getParameter("bookdocno");
String docname=request.getParameter("docname")==null?"":request.getParameter("docname");
int errorstatus=0;
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt=conn.createStatement();
	ArrayList<String> calcarray=new ArrayList();
	int jobdocno=0;
	String jobtype="",strgetjobdocno="",starttime="",endtime="";
	if(docname.charAt(0)=='T'){
		jobtype="Transfer";
		strgetjobdocno="select doc_no from gl_limobooktransfer where bookdocno="+bookdocno+" and docname='"+docname+"' and status=3";
	}
	else if(docname.charAt(0)=='L'){
		jobtype="Limo";
		strgetjobdocno="select doc_no from gl_limobookhours where bookdocno="+bookdocno+" and docname='"+docname+"' and status=3";
	}
	ResultSet rsgetjob=stmt.executeQuery(strgetjobdocno);
	while(rsgetjob.next()){
		jobdocno=rsgetjob.getInt("doc_no");
	}
	String strdelete="delete from gl_limojobclosecalc where bookdocno="+bookdocno+" and jobdocno="+jobdocno+" and jobtype='"+jobtype+"'";
	int deleteval=stmt.executeUpdate(strdelete);
	String strinsert="";
	int guestno=0;
	int pickuplocid=0,dropofflocid=0;
	double kmrestrict=0.0,tarif=0.0,exkmrate=0.0,extimerate=0.0,exhourrate=0.0,nighttarif=0.0,nightexhourrate=0.0,totalhours=0.0,
			transferextrahours=0.0,totalkm=0.0,extrakm=0.0,extrakmamt=0.0,extrahouramt=0.0,extranighthouramt=0.0,limoexcesshours=0.0,limoexcessdayhours=0.0,limoexcessnighthours=0.0,limonighttarifamt=0.0;
	String timerestrict="",nightstarttime="",nightendtime="",timeafteraddhours="",timeafteraddmins="";
	int blockhrs=0,nightstartmethod=0,nightendmethod=0;
	String strtarif="",strnighttarif="",strtotalhours="",strtransferaddhours="",strtransferaddmins="",strtransferextrahours="",strmaster="",
			strlimoaddhours="",limotimeafteraddhours="",strlimocheckexcesshrs="",strlimo="",strnightlimohours="";
	java.sql.Date sqlstartdate=null,sqlenddate=null;
	int cldocno=0;
	int brhid=0;
	strmaster="select guestno,cldocno,brhid from gl_limobookm where status=3 and doc_no="+bookdocno;
	System.out.println("Master Query: "+strmaster);
	ResultSet rsmaster=stmt.executeQuery(strmaster);
	while(rsmaster.next()){
		guestno=rsmaster.getInt("guestno");
		cldocno=rsmaster.getInt("cldocno");
		brhid=rsmaster.getInt("brhid");
	}
	
	if(jobtype.equalsIgnoreCase("Transfer")){
		//Getting Pickup Location and Dropoff Location
		String strgetlocation="select pickuplocid pickuplocid,dropfflocid dropofflocid,coalesce(triptype,'') triptype from gl_limobooktransfer where bookdocno="+bookdocno+" and doc_no="+jobdocno;
		String triptype="";
		ResultSet rslocation=stmt.executeQuery(strgetlocation);
		while(rslocation.next()){
			pickuplocid=rslocation.getInt("pickuplocid");
			dropofflocid=rslocation.getInt("dropofflocid");
			triptype=rslocation.getString("triptype");
		}
		
		//strtarif="select estdist kmrestrict,esttime timerestrict,tarif,exdistrate exkmrate,extimerate from gl_limotariftransfer where doc_no="+tarifdetaildocno;
		/* strtarif="select estdist kmrestrict,esttime timerestrict,tarif,exdistrate exkmrate,extimerate from gl_limotariftransfer where "+
		" gid="+tarifdetaildocno+" and tarifdocno="+tarifdocno+" and pickuplocid="+pickuplocid+" and dropofflocid="+dropofflocid; */
		strtarif="select pickupdate,pickuptime,estdist kmrestrict,esttime timerestrict,tarif,exdistrate exkmrate,extimerate from gl_limobooktransfer where bookdocno="+bookdocno+" and doc_no="+jobdocno;
		System.out.println(strtarif);
		
		
	}
	else if(jobtype.equalsIgnoreCase("Limo")){
		strtarif="select pickupdate,pickuptime,blockhrs,tarif,exhrrate,nighttarif,nightexhrrate from gl_limobookhours where bookdocno="+bookdocno+" and doc_no="+jobdocno;
	}
	System.out.println(strtarif);
	ResultSet rstarif=stmt.executeQuery(strtarif);
	while(rstarif.next()){
		if(jobtype.equalsIgnoreCase("Transfer")){
			sqlstartdate=rstarif.getDate("pickupdate");
			starttime=rstarif.getString("pickuptime");
			kmrestrict=rstarif.getDouble("kmrestrict");
			timerestrict=rstarif.getString("timerestrict");
			tarif=rstarif.getDouble("tarif");
			exkmrate=rstarif.getDouble("exkmrate");
			extimerate=rstarif.getDouble("extimerate");
		}
		else if(jobtype.equalsIgnoreCase("Limo")){
			sqlstartdate=rstarif.getDate("pickupdate");
			starttime=rstarif.getString("pickuptime");
			blockhrs=rstarif.getInt("blockhrs");
			tarif=rstarif.getDouble("tarif");
			exhourrate=rstarif.getDouble("exhrrate");
			nighttarif=rstarif.getDouble("nighttarif");
			nightexhourrate=rstarif.getDouble("nightexhrrate");
		}
	}

	//Getting Night start and end from gl_config
	sqlenddate=sqlstartdate;
	endtime=starttime;
	strnighttarif="select (select method from gl_config where field_nme='nightendtime') nightendmethod,"+
		" (select description from gl_config where field_nme='nightendtime') nightendvalue,"+
		" (select method from gl_config where field_nme='nightstarttime') nightstartmethod,"+
		" (select description from gl_config where field_nme='nightstarttime')nightstartvalue";
	ResultSet rsnighttarif=stmt.executeQuery(strnighttarif);
	while(rsnighttarif.next()){
		nightstartmethod=rsnighttarif.getInt("nightstartmethod");
		nightstarttime=rsnighttarif.getString("nightstartvalue");
		nightendmethod=rsnighttarif.getInt("nightendmethod");
		nightendtime=rsnighttarif.getString("nightendvalue");
	}
	
	strtotalhours="select timestampdiff(minute,concat('"+sqlstartdate+"',' ','"+starttime+"'),concat('"+sqlenddate+"',' ','"+endtime+"'))/60 totalhours";
	ResultSet rstotalhours=stmt.executeQuery(strtotalhours);
	while(rstotalhours.next()){
		totalhours=rstotalhours.getDouble("totalhours");
	}
	
	if(jobtype.equalsIgnoreCase("Transfer")){
		
		//To subtract the time restrict;here we add the time restrict with the startdate and time
		System.out.println("Time Restrict:"+timerestrict);
		strtransferaddhours="select DATE_FORMAT(TIMESTAMPADD(HOUR,"+timerestrict.split(":")[0]+",concat('"+sqlstartdate+"',' ','"+starttime+"')), '%H:%i') timeafteraddhours";
		System.out.println(strtransferaddhours);
		ResultSet rstimeafteraddhours=stmt.executeQuery(strtransferaddhours);
		while(rstimeafteraddhours.next()){
			timeafteraddhours=rstimeafteraddhours.getString("timeafteraddhours");
		}
		
		strtransferaddmins="select DATE_FORMAT(TIMESTAMPADD(MINUTE,"+timerestrict.split(":")[1]+",concat('"+sqlstartdate+"',' ','"+timeafteraddhours+"')), '%H:%i') timeafteraddmins";
		System.out.println(strtransferaddmins);
		ResultSet rstimeafteraddmins=stmt.executeQuery(strtransferaddmins);
		while(rstimeafteraddmins.next()){
			timeafteraddmins=rstimeafteraddmins.getString("timeafteraddmins");
		}
		
		strtransferextrahours="select TIMESTAMPDIFF(MINUTE,concat('"+sqlstartdate+"',' ','"+timeafteraddmins+"'),concat('"+sqlenddate+"',' ','"+endtime+"'))/60 transferextrahours";
		System.out.println(strtransferextrahours);
		ResultSet rstransferextrahours=stmt.executeQuery(strtransferextrahours);
		while(rstransferextrahours.next()){
			transferextrahours=rstransferextrahours.getDouble("transferextrahours");
		}
	}
	else if(jobtype.equalsIgnoreCase("Limo")){
		
		//To subtract the time restrict,here we add the block hours whith the start date and time.
		
		strlimoaddhours="select date(TIMESTAMPADD(HOUR,"+blockhrs+",concat('"+sqlstartdate+"',' ','"+starttime+"'))) limotimeafteradddate,DATE_FORMAT(TIMESTAMPADD(HOUR,"+blockhrs+",concat('"+sqlstartdate+"',' ','"+starttime+"')), '%H:%i') limotimeafteraddhours";
		System.out.println("Block Hours Query: "+strlimoaddhours);
		java.sql.Date limotimeafteradddate=null;
		ResultSet rslimoafteraddhours=stmt.executeQuery(strlimoaddhours);
		while(rslimoafteraddhours.next()){
			limotimeafteraddhours=rslimoafteraddhours.getString("limotimeafteraddhours");
			limotimeafteradddate=rslimoafteraddhours.getDate("limotimeafteradddate");
		}
		
		//Checking end time is less than time after adding block hours and therby finding excess hours.
		
		strlimocheckexcesshrs="select if(endtime<blocktime,0,timestampdiff(minute,blocktime,endtime)/60) limoexcesshrs from ("+
		" select timestamp(concat('"+sqlenddate+"',' ','"+endtime+"')) endtime,timestamp(concat('"+limotimeafteradddate+"',' ','"+limotimeafteraddhours+"')) blocktime)m";
		ResultSet rslimocheckblockhrs=stmt.executeQuery(strlimocheckexcesshrs);
		System.out.println("Total Limo Excess Hours Query: "+strlimocheckexcesshrs);
		while(rslimocheckblockhrs.next()){
			limoexcesshours=rslimocheckblockhrs.getDouble("limoexcesshrs");
		}
		//Getting Night Hours
		//1.Check End time is greater than night starttime then nighthours=endtime-nightstarttime
		//2.Check end time is greater than night nightendtime then nighthours=nightendtime-nightstarttime
		//3.Check end time is less than night starttime then nighthours=0;
		//4.Day hours=totalexcesshours-nighthours.
		if(sqlstartdate.compareTo(sqlenddate)==0){
			strnightlimohours="select case when (endtime>=nightstarttime and endtime<=nightendtime) then timestampdiff(minute,nightstarttime,endtime)/60"+
			" when (endtime>=nightstarttime and endtime>nightendtime) then timestampdiff(minute,nightstarttime,nightendtime)/60"+
			" when endtime<nightstarttime then 0 else 0 end nighthours from (select concat('"+sqlenddate+"',' ','"+endtime+"') endtime,"+
			" concat('"+sqlstartdate+"',' ','"+nightstarttime+"') nightstarttime,concat(date_add('"+sqlenddate+"',interval 1 day),' ','"+nightendtime+"') nightendtime)m";
		}
		else if(sqlstartdate.compareTo(sqlenddate)>0){
			strnightlimohours="select case when (endtime>=nightstarttime and endtime<=nightendtime) then timestampdiff(minute,nightstarttime,endtime)/60"+
			" when (endtime>=nightstarttime and endtime>nightendtime) then timestampdiff(minute,nightstarttime,nightendtime)/60"+
			" when endtime<nightstarttime then 0 else 0 end nighthours from (select concat('"+sqlenddate+"',' ','"+endtime+"') endtime,"+
			" concat('"+sqlstartdate+"',' ','"+nightstarttime+"') nightstarttime,concat('"+sqlenddate+"',' ','"+nightendtime+"') nightendtime)m";
		}
		else{
			System.out.println("else condition");

		}
			System.out.println("Night Checking"+strnightlimohours);
			ResultSet rsnightlimohours=stmt.executeQuery(strnightlimohours);
			while(rsnightlimohours.next()){
				limoexcessnighthours=rsnightlimohours.getDouble("nighthours");
			}	
			limoexcessnighthours=limoexcessnighthours<0?limoexcessnighthours*-1:limoexcessnighthours;
		
		limoexcessdayhours=limoexcesshours-limoexcessnighthours;
		
	}
	
	//Calculating Total kms and charges
	double endkm=0,startkm=0;
	
	totalkm=endkm-startkm;
	extrakm=totalkm-kmrestrict;
	if(extrakm>0){
		extrakmamt=extrakm*exkmrate;
	}
		
	//Calculating extra hour charge.
	if(jobtype.equalsIgnoreCase("Transfer")){
		if(transferextrahours>0){
			extrahouramt=transferextrahours*extimerate;
		}
	}
	else if(jobtype.equalsIgnoreCase("Limo")){
		if(limoexcessdayhours>0){
			extrahouramt=limoexcessdayhours*exhourrate;
		}
		if(limoexcessnighthours>0){
			extranighthouramt=limoexcessnighthours*nightexhourrate;
			limonighttarifamt=nighttarif;
		}
	}
	

	if(jobtype.equalsIgnoreCase("Transfer")){
		double tot=0.0;
		//+"+extrakmamt+"+"+extrahouramt+"+"+fuelchg+"+"+parkingchg+"+"+otherchg+"+"+greetchg+"+"+vipchg+"+"+boquechg+"
		String strtot="select "+tarif+" total";
		ResultSet rstotal=stmt.executeQuery(strtot);
		while(rstotal.next()){
			tot=rstotal.getDouble("total");
		}
		System.out.println("Tot: "+tot);
		calcarray.add(bookdocno+"::"+jobdocno+"::"+jobtype+"::"+tot+"::"+docname);
		//strinsert="insert into gl_limojobclosecalc(bookdocno,jobdocno,jobtype,jobname,guestno,total,tarif,exkmchg,exhrchg,fuelchg,parkingchg,otherchg,greetchg,vipchg,boquechg,status,startdate,starttime,startkm,closedate,closetime,closekm)values("+bookdocno+","+jobdocno+",'"+jobtype+"','"+jobname+"',"+guestno+","+tot+","+tarif+","+extrakmamt+","+extrahouramt+","+fuelchg+","+parkingchg+","+otherchg+","+greetchg+","+vipchg+","+boquechg+",3,'"+sqlstartdate+"','"+starttime+"',"+startkm+",'"+sqlenddate+"','"+endtime+"',"+endkm+")";
		strinsert="insert into gl_limojobclosecalc(bookdocno,jobdocno,jobtype,jobname,guestno,total,tarif,exkmchg,exhrchg,fuelchg,parkingchg,otherchg,greetchg,vipchg,boquechg,status,startdate,starttime,startkm,closedate,closetime,closekm)values("+bookdocno+","+jobdocno+",'"+jobtype+"','"+docname+"',"+guestno+","+tot+","+tarif+","+extrakmamt+","+extrahouramt+","+0.0+","+0.0+","+0.0+","+0.0+","+0.0+","+0.0+",3,'"+sqlstartdate+"','"+starttime+"',"+startkm+",'"+sqlenddate+"','"+endtime+"',"+endkm+")";
	}
	else if(jobtype.equalsIgnoreCase("Limo")){
		double tot=0.0;
		//String strtot="select "+tarif+"+"+extrahouramt+"+"+extranighthouramt+"+"+limonighttarifamt+"+"+fuelchg+"+"+parkingchg+"+"+otherchg+"+"+greetchg+"+"+vipchg+"+"+boquechg+" total";
		String strtot="select "+tarif+"+"+extrahouramt+"+"+extranighthouramt+"+"+limonighttarifamt+"+"+0.0+"+"+0.0+"+"+0.0+"+"+0.0+"+"+0.0+"+"+0.0+" total";
		ResultSet rstotal=stmt.executeQuery(strtot);
		while(rstotal.next()){
			tot=rstotal.getDouble("total");
		}
		calcarray.add(bookdocno+"::"+jobdocno+"::"+jobtype+"::"+tot+"::"+docname);
		strinsert="insert into gl_limojobclosecalc(bookdocno,jobdocno,jobtype,jobname,guestno,total,tarif,nighttarif,exhrchg,exnighthrchg,fuelchg,parkingchg,otherchg,greetchg,vipchg,boquechg,status,startdate,starttime,startkm,closedate,closetime,closekm)values("+bookdocno+","+jobdocno+",'"+jobtype+"','"+docname+"',"+guestno+","+tot+","+tarif+","+limonighttarifamt+","+extrahouramt+","+extranighthouramt+","+0.0+","+0.0+","+0.0+","+0.0+","+0.0+","+0.0+",3,'"+sqlstartdate+"','"+starttime+"',"+startkm+",'"+sqlenddate+"','"+endtime+"',"+endkm+")";
	}
	int insert=stmt.executeUpdate(strinsert);
	if(insert<=0){
		errorstatus=1;
	}
	ClsLimoJobCloseDAO closedao=new ClsLimoJobCloseDAO();
	
	int close=closedao.insert(calcarray, "A", brhid+"", session);
	if(close<=0){
		errorstatus=1;
	}
	String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
	String username=session.getAttribute("USERNAME")==null?"0":session.getAttribute("USERNAME").toString();
	String systemnote="Completion of "+bookdocno+" - "+docname+" by "+username;
	String strinsertlog="insert into gl_limomgmtlog(bookdocno, jobname, brhid, userid, logdate,systemremarks)values("+
	""+bookdocno+",'"+docname+"',"+brhid+","+userid+",now(),'"+systemnote+"')";
	int insertlog=stmt.executeUpdate(strinsertlog);
	if(insertlog<=0){
		errorstatus=1;
	}
	if(errorstatus==0){
		conn.commit();
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"");
%>