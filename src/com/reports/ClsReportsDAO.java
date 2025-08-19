package com.reports;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.sql.*;
import java.util.ArrayList;
import java.util.Map;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.login.ClsLogin;

public class ClsReportsDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONObject getChartCountData(Connection conn){
		JSONObject data=new JSONObject();      
		try{
			java.sql.Date sqlfromdate=null,sqltodate=null;
			Statement stmt=conn.createStatement();
			String strgetrequire="select (select CURDATE()) todate,(select date_sub(CURDATE(),interval 12 month)) fromdate";
			ResultSet rsgetrequire=stmt.executeQuery(strgetrequire);
			while(rsgetrequire.next()){
				sqlfromdate=rsgetrequire.getDate("fromdate");
				sqltodate=rsgetrequire.getDate("todate");
			}
			ArrayList<String> monthsarray=new ArrayList<>();
			ArrayList<String> monthsvaluesarray=new ArrayList<>();
			ArrayList<String> charttourarray = new ArrayList<>();
			ArrayList<String> charthotelarray = new ArrayList<>();
			ArrayList<String> chartticketarray = new ArrayList<>();
			ArrayList<String> charttourvaluearray = new ArrayList<>();
			ArrayList<String> chartticketvaluearray = new ArrayList<>();
			ArrayList<String> charthotelvaluearray = new ArrayList<>();
			ArrayList<String> chartvisavaluearray = new ArrayList<>();
			ArrayList<String> chartothervaluearray = new ArrayList<>();
			
			for(int monthindex=0;monthindex<=12;monthindex++){
				String strgetmonthdate="select date_format(date_add('"+sqlfromdate+"',interval "+monthindex+" month),'%b %Y') displaydate,"+
				" date_add('"+sqlfromdate+"',interval "+monthindex+" month) basedate,"+
				" month(date_add('"+sqlfromdate+"',interval "+monthindex+" month)) basemonth,"+
				" year(date_add('"+sqlfromdate+"',interval "+monthindex+" month)) baseyear";
				//System.out.println(strgetmonthdate);
				int basemonth=0,baseyear=0;
				ResultSet rsgetmonthdate=stmt.executeQuery(strgetmonthdate);
				java.sql.Date sqlbasedate=null;
				while(rsgetmonthdate.next()){
					sqlbasedate=rsgetmonthdate.getDate("basedate");
					monthsarray.add(rsgetmonthdate.getString("displaydate"));
					monthsvaluesarray.add(rsgetmonthdate.getDate("basedate").toString());
					basemonth=rsgetmonthdate.getInt("basemonth");
					baseyear=rsgetmonthdate.getInt("baseyear");
				}
				
				String strchartcount="select coalesce((select count(*) from tr_servicereqm m where  m.status=3 and "+
				" month(m.date)="+basemonth+" and year(m.date)="+baseyear+" group by year(m.date),month(m.date) order by m.date),0) charttourcount,"+
				" coalesce((select count(*) from ti_hotelvoucherm m left join ti_hotelvoucherd d on (m.doc_no=d.rdocno) where  "+
				"  m.status=3 and month(d.issuedate)="+basemonth+" and year(d.issuedate)="+baseyear+" group by year(d.issuedate),month(d.issuedate) order by d.issuedate),0) charthotelcount,"+
				" coalesce((select count(*) from ti_ticketvoucherm m left join ti_ticketvoucherd d on (m.doc_no=d.rdocno) where  "+
				"  m.status=3 and month(d.bookdate)="+basemonth+" and year(d.bookdate)="+baseyear+" group by year(d.bookdate),month(d.bookdate) order by d.bookdate),0) chartticketcount,"+
				" coalesce((select round(sum(sr.total),2) from tr_invoicem inv left join tr_servicereqm ser on (ser.invtrno=inv.doc_no and inv.types='tour') left join tr_srtour sr on"+
				" (sr.rdocno=ser.doc_no) where inv.status=3 and inv.types='tour' and month(inv.date)="+basemonth+" and year(inv.date)="+baseyear+" group by"+
				" year(inv.date),month(inv.date) order by inv.date),0) charttourvalue,"+
				
				" coalesce((select round(sum(tkt.sprice),2) from tr_invoicem inv left join ti_ticketvoucherd tkt on (tkt.invtrno=inv.doc_no and inv.types='ticket') where"+
				" inv.status=3 and inv.types='ticket' and month(inv.date)="+basemonth+" and year(inv.date)="+baseyear+" group by"+
				" year(inv.date),month(inv.date) order by inv.date),0) chartticketvalue,"+
				
				" coalesce((select round(sum(hl.sprice),2) from tr_invoicem inv left join ti_hotelvoucherd hl on (hl.invtrno=inv.doc_no and inv.types='hotel') where"+
				" inv.status=3 and inv.types='hotel' and hl.vtype='H' and month(inv.date)="+basemonth+" and year(inv.date)="+baseyear+" group by"+
				" year(inv.date),month(inv.date) order by inv.date),0) charthotelvalue,"+
				
				" coalesce((select round(sum(hl.sprice),2) from tr_invoicem inv left join ti_hotelvoucherd hl on (hl.invtrno=inv.doc_no and inv.types='hotel') where"+
				" inv.status=3 and inv.types='hotel' and hl.vtype='V' and month(inv.date)="+basemonth+" and year(inv.date)="+baseyear+" group by"+
				" year(inv.date),month(inv.date) order by inv.date),0) chartvisavalue,"+
				
				" coalesce((select round(sum(hl.sprice),2) from tr_invoicem inv left join ti_hotelvoucherd hl on (hl.invtrno=inv.doc_no and inv.types='hotel') where"+
				" inv.status=3 and inv.types='hotel' and hl.vtype='O' and month(inv.date)="+basemonth+" and year(inv.date)="+baseyear+" group by"+
				" year(inv.date),month(inv.date) order by inv.date),0) chartothervalue";
				//System.out.println(strchartcount);
				int charttourcount=0,charthotelcount=0,chartticketcount=0;
				double charttourvalue=0.0,chartticketvalue=0.0,charthotelvalue=0.0,chartvisavalue=0.0,chartothervalue=0.0;
				ResultSet rschartcount=stmt.executeQuery(strchartcount);
				while(rschartcount.next()){
					charttourcount=rschartcount.getInt("charttourcount");
					charthotelcount=rschartcount.getInt("charthotelcount");
					chartticketcount=rschartcount.getInt("chartticketcount");
					charttourvalue=rschartcount.getDouble("charttourvalue");
					chartticketvalue=rschartcount.getDouble("chartticketvalue");
					charthotelvalue=rschartcount.getDouble("charthotelvalue");
					chartvisavalue=rschartcount.getDouble("chartvisavalue");
					chartothervalue=rschartcount.getDouble("chartothervalue");
				}
				charttourarray.add(charttourcount+"");
				charthotelarray.add(charthotelcount+"");
				chartticketarray.add(chartticketcount+"");
				charttourvaluearray.add(charttourvalue+"");
				chartticketvaluearray.add(chartticketvalue+"");
				charthotelvaluearray.add(charthotelvalue+"");
				chartvisavaluearray.add(chartvisavalue+"");
				chartothervaluearray.add(chartothervalue+"");
			}
			data.put("labelsvalues", monthsvaluesarray);   
			data.put("labels", monthsarray);
			data.put("charttourcount", charttourarray);
			data.put("charthotelcount",charthotelarray);
			data.put("chartticketcount",chartticketarray);
			data.put("chartcounttitle", "Travel Analytics of "+monthsarray.get(0)+" - "+monthsarray.get(monthsarray.size()-1));
			data.put("charttourvalue",charttourvaluearray);
			data.put("chartticketvalue",chartticketvaluearray);
			data.put("charthotelvalue",charthotelvaluearray);
			data.put("chartvisavalue",chartvisavaluearray);
			data.put("chartothervalue",chartothervaluearray);
			data.put("chartvaluetitle", "Invoice Analytics of "+monthsarray.get(0)+" - "+monthsarray.get(monthsarray.size()-1));
			//System.out.println(data);
		}
		catch(Exception e){  
			e.printStackTrace();
		}
		return data;
	}
	
	public JSONObject getCharttourData(Connection conn){              
		JSONObject data=new JSONObject();      
		try{
			java.sql.Date sqlfromdate=null,sqltodate=null;
			Statement stmt=conn.createStatement();
			ArrayList<String> monthsarray=new ArrayList<>();
			ArrayList<String> monthsvaluesarray=new ArrayList<>();
			ArrayList<String> locationcountarray=new ArrayList<>();
			ArrayList<String> locationvaluearray=new ArrayList<>();
			ArrayList<String> locationdataarray=new ArrayList<>();
			String strgetrequire="select (select CURDATE()) todate,(select date_sub(CURDATE(),interval 6 month)) fromdate";
			ResultSet rsgetrequire=stmt.executeQuery(strgetrequire);
			while(rsgetrequire.next()){
				sqlfromdate=rsgetrequire.getDate("fromdate");
				sqltodate=rsgetrequire.getDate("todate");
			}
			String strloc="select doc_no,loc_name from my_locm where status=3";                          
			ResultSet rsloc=stmt.executeQuery(strloc);
			while(rsloc.next()){
				locationcountarray.add(rsloc.getString("doc_no"));
				locationvaluearray.add(rsloc.getString("loc_name"));            
			}
			JSONArray locarray=new JSONArray();
			for(int monthindex=0;monthindex<6;monthindex++){
				String strgetmonthdate="select date_format(date_add('"+sqlfromdate+"',interval "+monthindex+" month),'%b %Y') displaydate,"+
				" date_add('"+sqlfromdate+"',interval "+monthindex+" month) basedate,"+
				" month(date_add('"+sqlfromdate+"',interval "+monthindex+" month)) basemonth,"+
				" year(date_add('"+sqlfromdate+"',interval "+monthindex+" month)) baseyear";
				//System.out.println(strgetmonthdate);
				ResultSet rsgetmonthdate=stmt.executeQuery(strgetmonthdate);
				while(rsgetmonthdate.next()){
					monthsarray.add(rsgetmonthdate.getString("displaydate"));
					monthsvaluesarray.add(rsgetmonthdate.getDate("basedate").toString());  					
				}
			}
			for(int i=0;i<locationcountarray.size();i++){
				String temploc=locationcountarray.get(i);
				locationdataarray=new ArrayList<>();
				for(int monthindex=0;monthindex<=12;monthindex++){
					String strgetmonthdate="select date_format(date_add('"+sqlfromdate+"',interval "+monthindex+" month),'%b %Y') displaydate,"+
					" date_add('"+sqlfromdate+"',interval "+monthindex+" month) basedate,"+
					" month(date_add('"+sqlfromdate+"',interval "+monthindex+" month)) basemonth,"+
					" year(date_add('"+sqlfromdate+"',interval "+monthindex+" month)) baseyear";
					//System.out.println(strgetmonthdate);
					int basemonth=0,baseyear=0;
					ResultSet rsgetmonthdate=stmt.executeQuery(strgetmonthdate);
					java.sql.Date sqlbasedate=null;
					while(rsgetmonthdate.next()){
						sqlbasedate=rsgetmonthdate.getDate("basedate");
						basemonth=rsgetmonthdate.getInt("basemonth");
						baseyear=rsgetmonthdate.getInt("baseyear");                   
					}
					double locvalue=0.0;
					String strchartcount="select round(sum(coalesce(sr.total,0)),2) value from tr_servicereqm m left join tr_srtour sr on sr.rdocno=m.doc_no where m.status=3 and month(m.date)="+basemonth+" and year(m.date)="+baseyear+" and m.locid="+temploc+" group by year(m.date),month(m.date) order by m.date";
					//System.out.println("strTourSql======"+strchartcount);         
					ResultSet rschartcount=stmt.executeQuery(strchartcount);
					while(rschartcount.next()){  
						locvalue=rschartcount.getDouble("value");
					}
					locationdataarray.add(locvalue+"");
				}
				JSONObject objloc=new JSONObject();
				objloc.put("label",locationvaluearray.get(i));
				objloc.put("data",locationdataarray);
				locarray.add(objloc);
			}	
			data.put("labelsvalues", monthsvaluesarray);     
			data.put("labels", monthsarray);
			data.put("locdata",locarray);
			data.put("charttourtitle", "Travel Location Wise Analytics of "+monthsarray.get(0)+" - "+monthsarray.get(monthsarray.size()-1));      
			//System.out.println(data);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return data;
	}
}
