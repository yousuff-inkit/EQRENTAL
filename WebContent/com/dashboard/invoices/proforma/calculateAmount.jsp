<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.dashboard.invoices.proforma.ClsProformaInvDAO"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.*"%>
<%
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
ClsProformaInvDAO objproforma=new ClsProformaInvDAO();
String stragmtarray=request.getParameter("agmtarray")==null?"":request.getParameter("agmtarray");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String uptodate=request.getParameter("uptodate")==null?"":request.getParameter("uptodate");
//System.out.println("Passed Values:"+request.getParameterValues("agmtarray"));
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	ArrayList<String> agmtarray=new ArrayList();
	for(int i=0;i<stragmtarray.split(",").length;i++){
		agmtarray.add(stragmtarray.split(",")[i]);
	}
	java.sql.Date sqluptodate=null;
	if(!uptodate.equalsIgnoreCase("")){
		sqluptodate=objcommon.changeStringtoSqlDate(uptodate);
	}
	int monthcalmethod=0,monthcalvalue=0;
	
	String strmonthlycal="select method,value from gl_config where field_nme='monthlycal'";
	ResultSet rsmonthlycal=stmt.executeQuery(strmonthlycal);
	while(rsmonthlycal.next()){
		monthcalmethod=rsmonthlycal.getInt("method");
		monthcalvalue=rsmonthlycal.getInt("value");
	}
	int tconvmethod=0;
	String strconfig="select (select method from gl_config where field_nme='tconv') conversion";
	ResultSet rsconfig=stmt.executeQuery(strconfig);
	while(rsconfig.next()){
		tconvmethod=rsconfig.getInt("conversion");
	}
	JSONArray dataarray=new JSONArray();
	for(int i=0;i<agmtarray.size();i++){
		int agmtno=Integer.parseInt(agmtarray.get(i));
		java.sql.Date sqlinvdate=null;
		int cldocno=0;
		String strgetdetails="select invdate,cldocno from gl_ragmt where doc_no="+agmtno;
		ResultSet rsgetdetails=stmt.executeQuery(strgetdetails);
		while(rsgetdetails.next()){
			sqlinvdate=rsgetdetails.getDate("invdate");
			cldocno=rsgetdetails.getInt("cldocno");
		}
		long diff=sqluptodate.getTime()-sqlinvdate.getTime();
		
		long daysused=diff/(24*60*60*1000);
		System.out.println("Used Days:"+daysused);
		String datediff=daysused+" Day(s)";
		double dailyrate=0.0,weeklyrate=0.0,fortnightrate=0.0,monthlyrate=0.0,netrate=0.0,takenvalue=0.0;
		String rentaltype="",defaulttarif="";
		int tempconv=0;
		double rentalno=0;
		String sqltest="";
		String strrentaltype="select (select rate from gl_rtarif where rdocno="+agmtno+" and rstatus=1) dailyrate,"+
		" (select rate  from gl_rtarif where rdocno="+agmtno+" and rstatus=2)weeklyrate,"+
		" (select rate  from gl_rtarif where rdocno="+agmtno+" and rstatus=3)monthlyrate,"+
		" (select rate from gl_rtarif where rdocno="+agmtno+" and rstatus=7) netrate,"+
		" (select rentaltype from gl_rtarif where rdocno="+agmtno+" and rstatus=5) rentaltype";
		System.out.println(strrentaltype);
		ResultSet rsrentaltype=stmt.executeQuery(strrentaltype);
		while(rsrentaltype.next()){
			dailyrate=rsrentaltype.getDouble("dailyrate");
			weeklyrate=rsrentaltype.getDouble("weeklyrate");
			netrate=rsrentaltype.getDouble("netrate");
			monthlyrate=rsrentaltype.getDouble("monthlyrate");
			rentaltype=rsrentaltype.getString("rentaltype");
			defaulttarif=rsrentaltype.getString("rentaltype");
		}
		
		if(monthcalmethod==1){
			String strgetmonthcal="SELECT DAY(LAST_DAY('"+sqluptodate+"')) monthdays";
			ResultSet rsgetmonthcal=stmt.executeQuery(strgetmonthcal);
			while(rsgetmonthcal.next()){
				monthcalvalue=rsgetmonthcal.getInt("monthdays");
			}
		}
		
		double drate=0.0,dcdw=0.0,dpai=0.0,dcdw1=0.0,dpai1=0.0,dgps=0.0,dbabyseater=0.0,dcooler=0.0,dkmrest=0.0,dexhrchg=0.0,dexkmrte=0.0,dchaufchg=0.0;
		double rate=0.0,cdw=0.0,pai=0.0,cdw1=0.0,pai1=0.0,gps=0.0,babyseater=0.0,cooler=0.0,kmrest=0.0,exkmrte=0.0,oinschg=0.0,exhrchg=0.0,chaufchg=0.0,chaufexchg=0.0;
		String strdefault="select rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest,exkmrte,oinschg,exhrchg,chaufchg,chaufexchg"+
		" from gl_rtarif where rdocno="+agmtno+" and rstatus=7";
		//System.out.println("Default Query:"+strdefault);
		ResultSet rsdefault=stmt.executeQuery(strdefault);
		while(rsdefault.next()){
			drate=rsdefault.getDouble("rate");
			dcdw=rsdefault.getDouble("cdw");
			dpai=rsdefault.getDouble("pai");
			dcdw1=rsdefault.getDouble("cdw1");
			dpai1=rsdefault.getDouble("pai1");
			dgps=rsdefault.getDouble("gps");
			dbabyseater=rsdefault.getDouble("babyseater");
			dcooler=rsdefault.getDouble("cooler");
			dexhrchg=rsdefault.getDouble("exhrchg");
			dexkmrte=rsdefault.getDouble("exkmrte");
			dchaufchg=rsdefault.getDouble("chaufchg");
		}
		
		if(rentaltype.equalsIgnoreCase("Daily")){
			if(tconvmethod==1){
				if(daysused<=6){
					double value=dailyrate*daysused;
					if(value>weeklyrate && weeklyrate!=0.0){
						takenvalue=weeklyrate;
						rentaltype="Weekly";
						tempconv=0;
					}
					else{
						takenvalue=value;
						rentaltype="Daily";
						tempconv=1;
					}
				}
				else if(daysused>6 && daysused<monthcalvalue){
					double value=(weeklyrate/7)*daysused;
					if(value>monthlyrate && monthlyrate!=0.0){
						takenvalue=monthlyrate;
						rentaltype="Monthly";
						tempconv=0;
					}
					else{
						takenvalue=value;
						rentaltype="Weekly";
						tempconv=1;
					}
				}
				else if(daysused>=monthcalvalue){
					takenvalue=(monthlyrate/monthcalvalue)*daysused;
					rentaltype="Monthly";
					tempconv=1;		
				}
			}
			if(tconvmethod==0){
				takenvalue=dailyrate*daysused;
				rentaltype="Daily";
				tempconv=1;
			}
		}
		
		
		if(rentaltype.equalsIgnoreCase("Weekly")){
			if(tconvmethod==1){
				if(daysused>=monthcalvalue){
					double value=(monthlyrate/monthcalvalue)*daysused;
					takenvalue=value;
					rentaltype="Monthly";
					tempconv=1;
				}
				else if(daysused>7 && daysused<monthcalvalue){
					double value=(weeklyrate/7)*daysused;
					System.out.println("Value:"+value);
					if(value>monthlyrate  && monthlyrate!=0.0){
						takenvalue=monthlyrate;
						rentaltype="Monthly";
						tempconv=0;
					}
					else{
						takenvalue=value;
						rentaltype="Weekly";
						tempconv=1;
					}
				}	
			}
			
			if(daysused<7){
				double value=dailyrate*daysused;
				if(value>weeklyrate  && weeklyrate!=0.0){
					takenvalue=weeklyrate;
					rentaltype="Weekly";
					tempconv=0;
					System.out.println("Check:4");
				}
				else{
					takenvalue=value;
					rentaltype="Daily";
					tempconv=1;
					System.out.println("Check:5");
				}
			}				
		}		
		if(rentaltype.equalsIgnoreCase("Monthly")){
			if(daysused>monthcalvalue){
				double value=(monthlyrate/monthcalvalue)*daysused;
				takenvalue=value;
				rentaltype="Monthly";
				tempconv=1;
			}
			else if(daysused>=7 && daysused<monthcalvalue){
				System.out.println("Inside Monthly 2");
				double value=(weeklyrate/7)*daysused;
				if(value>monthlyrate  && monthlyrate!=0.0){
					takenvalue=monthlyrate;
					rentaltype="Monthly";
					tempconv=0;
				}
				else{
					takenvalue=value;
					rentaltype="Weekly";
					tempconv=1;
				}
			}
			else if(daysused<7){
				System.out.println("Inside Monthly 3");
				double value=dailyrate*daysused;
				if(value>weeklyrate  && weeklyrate!=0.0){
					takenvalue=weeklyrate;
					rentaltype="Weekly";
					tempconv=0;
				}
				else{
					takenvalue=value;
					rentaltype="Daily";
					tempconv=1;
				}
			}
		}
		System.out.println("Rental type:"+rentaltype);
		if(monthcalmethod==0){
			rentalno=monthcalvalue;
		}
		if(rentaltype.equalsIgnoreCase("daily")){
			rentalno=1;
		}
		if(rentaltype.equalsIgnoreCase("weekly")){
			rentalno=7;
		}
		if(rentaltype.equalsIgnoreCase("fortnightly")){
			rentalno=14;
		}
		
		if(defaulttarif.equalsIgnoreCase(rentaltype)){
			sqltest=" and rstatus=7";
		}
		else{
			sqltest=" and rentaltype='"+rentaltype+"'";
		}
		String strsql="";
		if(rentaltype.equalsIgnoreCase("Daily") || rentaltype.equalsIgnoreCase("Weekly") || (monthcalmethod==0 && rentaltype.equalsIgnoreCase("Monthly"))){
			if(tempconv==0){
				strsql="select rate tarif,cdw cdw,pai pai,cdw1 scdw,pai1 spai,gps gps,babyseater babyseater,cooler cooler,chaufchg chaufferchg from gl_rtarif where rdocno="+agmtno+" "+sqltest+"";
				System.out.println("No convertion "+rentaltype+" :"+strsql);
			}
			else{
				System.out.println("Days Used:"+daysused);
				System.out.println("Rental No:"+rentalno);
				System.out.println("Test:"+daysused/rentalno);
				strsql="select "+(daysused/rentalno)+"*rate tarif,"+(daysused/rentalno)+"*cdw cdw,"+(daysused/rentalno)+"*pai pai,"+(daysused/rentalno)+"*cdw1 scdw,"+
				+(daysused/rentalno)+"*pai1 spai,"+(daysused/rentalno)+"*gps gps,"+(daysused/rentalno)+"*babyseater babyseater,"+(daysused/rentalno)+"*cooler cooler,"+
				+(daysused/rentalno)+"*chaufchg chaufferchg from gl_rtarif where rdocno="+agmtno+" "+sqltest+"";
				System.out.println("convertion "+rentaltype+":"+strsql);
			}
			
		
			System.out.println(strsql);
			ResultSet rsnormal=stmt.executeQuery(strsql);
			while(rsnormal.next()){
				rate=rsnormal.getDouble("tarif");
	    		cdw=rsnormal.getDouble("cdw");
	    		pai=rsnormal.getDouble("pai");
	    		cdw1=rsnormal.getDouble("scdw");
	    		pai1=rsnormal.getDouble("spai");
	    		gps=rsnormal.getDouble("gps");
	    		babyseater=rsnormal.getDouble("babyseater");
	    		cooler=rsnormal.getDouble("cooler");
	    		chaufchg=rsnormal.getDouble("chaufferchg");
			}
		}
		if(monthcalmethod==1 && rentaltype.equalsIgnoreCase("Monthly")){
			//Getting months and days
			
			int day=0,month=0,lastday=0;
			String strgetmonths="select a.months,DAY(LAST_DAY('"+sqluptodate+"')) lastday, DATEDIFF('"+sqluptodate+"', DATE_ADD('"+sqlinvdate+"',INTERVAL "+
			" a.months month) ) days from ("+
			" select if(day('"+sqlinvdate+"')>day('"+sqluptodate+"'),PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+sqluptodate+"' ),"+
			" EXTRACT( YEAR_MONTH FROM '"+sqlinvdate+"' ) )-1,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+sqluptodate+"' ),"+
			" EXTRACT( YEAR_MONTH FROM '"+sqlinvdate+"' ) )) months) a";
			ResultSet rsgetmonth=stmt.executeQuery(strgetmonths);
			while(rsgetmonth.next()){
				day=rsgetmonth.getInt("days");
				month=rsgetmonth.getInt("MONTHS");
				lastday=rsgetmonth.getInt("lastday");
			}
			datediff="";
			if(month>0){
				datediff+=month+" Month(s) ";
			}
			if(day>0){
				datediff+=day+" Day(s)";
			}
			String strmonthclose="";
			if(tempconv==1){
				strmonthclose="select (("+month+"*rate)+((coalesce("+day/lastday+",0))*rate)) tarif,(("+month+"*cdw)+((coalesce("+day/lastday+",0))*cdw)) cdw,"+
				"(("+month+"*pai)+((coalesce("+day/lastday+",0))*pai)) pai,(("+month+"*cdw1)+((coalesce("+day/lastday+",0))*cdw1)) scdw,"+
				"(("+month+"*pai1)+((coalesce("+day/lastday+",0))*pai1)) spai,(("+month+"*gps)+((coalesce("+day/lastday+",0))*gps)) gps,"+
				"(("+month+"*babyseater)+((coalesce("+day/lastday+",0))*babyseater)) babyseater,(("+month+"*cooler)+((coalesce("+day/lastday+",0))*cooler)) cooler,"+
				"(("+month+"*chaufchg)+((coalesce("+day/lastday+",0))*chaufchg)) chaufferchg from gl_rtarif where rdocno="+agmtno+" "+sqltest+"";
				System.out.println("convertion "+rentaltype+" :"+strmonthclose);
			}
			else{
				strmonthclose="select rate tarif,cdw cdw,pai pai,cdw1 scdw,pai1 spai,gps gps,babyseater babyseater,cooler cooler,chaufchg chaufferchg"+
				" from gl_rtarif where rdocno="+agmtno+" "+sqltest+"";
				System.out.println("No convertion "+rentaltype+" :"+strmonthclose);
			}
			
			System.out.println("Monthly Query with tempconv0"+strmonthclose);
			ResultSet rsmonthcal=stmt.executeQuery(strmonthclose);
			while(rsmonthcal.next()){
				rate=rsmonthcal.getDouble("tarif");
	    		cdw=rsmonthcal.getDouble("cdw");
	    		pai=rsmonthcal.getDouble("pai");
	    		cdw1=rsmonthcal.getDouble("scdw");
	    		pai1=rsmonthcal.getDouble("spai");
	    		gps=rsmonthcal.getDouble("gps");
	    		babyseater=rsmonthcal.getDouble("babyseater");
	    		cooler=rsmonthcal.getDouble("cooler");
	    		chaufchg=rsmonthcal.getDouble("chaufferchg");	    		
			}
			
		}
		JSONObject objsalik=objproforma.getSalikTraffic(agmtno,sqluptodate,sqlinvdate,cldocno,conn);
		String strfinal="select if("+drate+">0,round("+rate+",0),0) rate,if("+dcdw+">0,round("+cdw+",0),0) cdw,if("+dpai+">0,round("+pai+",0),0) pai,"+
				" if("+dcdw1+">0,round("+cdw1+",0),0) cdw1,if("+dpai1+">0,round("+pai1+",0),0) pai1,if("+dgps+">0,round("+gps+",0),0) gps,if("+dbabyseater+">0,round("+babyseater+",0),0) babyseater,"+
				"if("+dcooler+">0,round("+cooler+",0),0) cooler,if("+dchaufchg+">0,round("+chaufchg+",0),0) chaufchg from gl_rtarif where rdocno="+agmtno+sqltest;
		ResultSet rsfinal=stmt.executeQuery(strfinal);
		while(rsfinal.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("agmtno",agmtno);
			objtemp.put("rent",rsfinal.getString("rate"));
			double insurcharges=rsfinal.getDouble("cdw")+rsfinal.getDouble("pai")+rsfinal.getDouble("cdw1")+rsfinal.getDouble("pai1");
			objtemp.put("insurchg",insurcharges);
			double acccharges=rsfinal.getDouble("gps")+rsfinal.getDouble("babyseater")+rsfinal.getDouble("cooler");
			objtemp.put("accchg",acccharges);
			objtemp.put("salikcount",objsalik.get("salikcount"));
			objtemp.put("salikamt",objsalik.get("salikamt"));
			objtemp.put("saliksrvc",objsalik.get("saliksrvc"));
			objtemp.put("trafficcount",objsalik.get("trafficcount"));
			objtemp.put("trafficamt",objsalik.get("trafficamt"));
			objtemp.put("trafficsrvc",objsalik.get("trafficsrvc"));
			objtemp.put("datediff",datediff);
			dataarray.add(objtemp);
		}
	}
	objdata.put("calcdata",dataarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>