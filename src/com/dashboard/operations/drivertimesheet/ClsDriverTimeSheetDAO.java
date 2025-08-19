package com.dashboard.operations.drivertimesheet;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsDriverTimeSheetDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	public int insert(String cmbbranch, String cmbyear, String cmbmonth, ArrayList<String> timesheetarray, HttpSession session, HttpServletRequest request, 
			String mode) throws SQLException {
		
		Connection conn  = null;
		  
		try{
			
			 conn=ClsConnection.getMyConnection();
			 conn.setAutoCommit(false);
			 Statement stmtBDTS = conn.createStatement();
			
			 String branch=session.getAttribute("BRANCHID").toString().trim();
			 String userid=session.getAttribute("USERID").toString().trim();
	        
			 String selecteddrivers="";int docno=0;
        	
			 String sql="select coalesce(max(doc_no)+1,1) doc_no from gl_bdts";
		     ResultSet resultSet = stmtBDTS.executeQuery(sql);
		  
		     while (resultSet.next()) {
		    	  docno=resultSet.getInt("doc_no");
		     }
		     
			 /*Time Sheet Grid Saving*/
		     
				for(int i=0;i< timesheetarray.size();i++){
				CallableStatement stmtBDTS1=null;
				String[] timesheet=timesheetarray.get(i).split("::");
				
				 if(!timesheet[0].equalsIgnoreCase("undefined") && !timesheet[0].equalsIgnoreCase("NaN")){
				 
					 java.sql.Date date=(timesheet[1].trim().equalsIgnoreCase("undefined") || timesheet[1].trim().equalsIgnoreCase("NaN") || timesheet[1].trim().equalsIgnoreCase("") ||  timesheet[1].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(timesheet[1].trim()));
					 
					 if(!(selecteddrivers.contains((timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()))) {
						 if(i==0) {
							 selecteddrivers = (timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString();
						 } else {
							 selecteddrivers += ","+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString();
						 }
					 }
					 
					 String normalTime = (timesheet[3].trim().equalsIgnoreCase("undefined") || timesheet[3].trim().equalsIgnoreCase("NaN") || timesheet[3].trim().equalsIgnoreCase("") || timesheet[3].trim()==null ||timesheet[3].trim().isEmpty()?"0:00":timesheet[3].trim()).toString();
					 String otTime = (timesheet[4].trim().equalsIgnoreCase("undefined") || timesheet[4].trim().equalsIgnoreCase("NaN") || timesheet[4].trim().equalsIgnoreCase("") || timesheet[4].trim()==null ||timesheet[4].trim().isEmpty()?"0:00":timesheet[4].trim()).toString();
					// String hotTime = (timesheet[6].trim().equalsIgnoreCase("undefined") || timesheet[6].trim().equalsIgnoreCase("NaN") || timesheet[6].trim().equalsIgnoreCase("") || timesheet[6].trim()==null ||timesheet[6].trim().isEmpty()?"0:00":timesheet[6].trim()).toString();
					 
					 
					 
					 int normalHourInHour = 0; 
					 int otInHour = 0;
					 int hotInHour = 0;
					 
					 if(!(normalTime.equalsIgnoreCase("null"))) {
						 String[] normalHour=normalTime.split(":");
						 normalHourInHour = (Integer.parseInt(normalHour[0]) * 60)+ Integer.parseInt(normalHour[1]);
						 
						 System.out.println("normal in hour----: "+normalHourInHour);
					 } else {
						 normalTime="00:00";
					 }
					 
					 if(!(otTime.equalsIgnoreCase("null"))) {
						 String[] otHour=otTime.split(":");
						 otInHour = (Integer.parseInt(otHour[0]) * 60)+ Integer.parseInt(otHour[1]);
						 System.out.println("normal out hr --: "+otInHour );
					 } else {
						 otTime="00:00";
					 }
					 
					 /*if(!(hotTime.equalsIgnoreCase("null"))) {
						 String[] hotHour=hotTime.split(":");
						 hotInHour = (Integer.parseInt(hotHour[0]) * 60)+ Integer.parseInt(hotHour[1]);
					 } else {
						 hotTime="00:00";
					 }*/
					 
					 String agreementDocNo = (timesheet[2].trim().equalsIgnoreCase("undefined") || timesheet[2].trim().equalsIgnoreCase("NaN") || timesheet[2].trim().equalsIgnoreCase("") || timesheet[2].trim()==null ||timesheet[2].trim().isEmpty()?"0":timesheet[2].trim()).toString();
					 
					 /*Holidays & Ramdan Deduction Hrs*/
					 String method="0",ramdanDedHrs="0";
					 int ramdanWhrs=0,actualWhrs=0,ramdanDeduction=0,holidayWorked=0;
					 java.sql.Date sqlHolidayDate=null;
					 String sqls1="",whrs="0",weekoff="",checkweekoff="0";
			         String[] weekoffs=null;
			         ArrayList weeklyoffarray=new ArrayList();
					 
					 /*String sqls ="select CONCAT(YEAR('"+date+"'),'-',if(LENGTH(MONTH('"+date+"'))=1,CONCAT('0',MONTH('"+date+"')),MONTH('"+date+"')),'-',if(LENGTH(row+1)=1,CONCAT('0',row+1),row+1))  as holidaysofmonth from ( "
							 + "SELECT @row := @row + 1 as row FROM ( select 0 union all select 1 union all select 3 union all select 4 union all select 5 union all select 6) t1, (select 0 union all select 1 union all "
							 + "select 3 union all select 4 union all select 5 union all select 6) t2,(SELECT @row:=-1) t3 limit 31 ) b where DATE_ADD(DATE_ADD(DATE_ADD(LAST_DAY('"+date+"'),INTERVAL 1 DAY),INTERVAL -1 MONTH), INTERVAL ROW DAY) between "
							 + "DATE_ADD(DATE_ADD(LAST_DAY('"+date+"'),INTERVAL 1 DAY),INTERVAL -1 MONTH) and LAST_DAY('"+date+"') and DAYOFWEEK(DATE_ADD(DATE_ADD(DATE_ADD(LAST_DAY('"+date+"'),INTERVAL 1 DAY),INTERVAL -1 MONTH), INTERVAL ROW DAY))="
							 + "(if(((select c.woff from hr_empm m left join (select max(doc_no) doc_no ,catid,woff,status,timesheet from hr_paycode where revdate<='"+date+"' and status=3 and timesheet=1 group by catid) c on  c.catid=m.pay_catid "
							 + "where m.status=3 and c.status=3 and c.timesheet=1 and m.doc_no="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+")+1)>7,1,"
							 + "((select c.woff from hr_empm m left join (select max(doc_no) doc_no ,catid,woff,status,timesheet from hr_paycode where revdate<='"+date+"' and status=3 and timesheet=1 group by catid) c on  c.catid=m.pay_catid where m.status=3 and c.status=3 "
							 + "and c.timesheet=1 and m.doc_no="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+")+1)))";*/
					 
			         
			         //from lease calculator
					 /*String sqls="select agmt.doc_no,coalesce(req.ddiw,0) ddiw,(coalesce(req.dhpd,0)*60) whrs,df.woff from gl_lagmt agmt left join gl_masterlagm m on (agmt.masterrefno=m.doc_no and agmt.masterreftype='MLA')"
							+" left join gl_masterlagd d on (m.doc_no=d.rdocno and agmt.masterrefsrno=d.sr_no)"
							+" left join gl_almariahleasecalcm calc on (m.reftype='QOT' and m.qotrefno=calc.doc_no)"
							+" left join gl_almariahleasecalcreq req on (calc.doc_no=req.rdocno and d.sr_no=req.sr_no)"
							+" left join gl_driverwoff df on req.ddiw=df.ddiw where  agmt.status=3 and df.status=3 and agmt.doc_no="+agreementDocNo+"";*/
					 
			         //from ltarif
			         String sqls="select agmt.doc_no,coalesce(lt.diw,0) ddiw,(coalesce(lt.hpd,0)*60) whrs,df.woff"
							+" from  gl_lagmt agmt left join gl_ltarif lt on (agmt.doc_no=lt.rdocno)"
							+" left join gl_driverwoff df on lt.diw=df.ddiw where  agmt.status=3 and df.status=3 and agmt.doc_no="+agreementDocNo+"";
			         
					 System.out.println("save Qry------------  : "+sqls);
					 ResultSet resultSets = stmtBDTS.executeQuery(sqls);
					 ;
			    	    
			    	    while(resultSets.next()){
			    	    	weekoff=resultSets.getString("woff");
			    	    	whrs=resultSets.getString("whrs");
			    	    }
			    	    
			    	    
			    	    if(weekoff.trim().contains(",")){
			    	    	checkweekoff="1";
							weekoffs = weekoff.split(",");
						}
			    	    
			    	    
			    	    if(checkweekoff.equalsIgnoreCase("0")){
			    	    	
			    	    	
			    	    	sqls1="select CONCAT('"+cmbyear+"','-','"+cmbmonth+"','-',if(LENGTH((row+1))=1,CONCAT('0',(row+1)),(row+1)))  as holidaysofmonth from ( SELECT @row := @row + 1 as row FROM (select 0 union all select 1 union all select 3 union all "
			    	    		+ "select 4 union all select 5 union all select 6) t1,(select 0 union all select 1 union all select 3 union all select 4 union all "
			    	    		+ "select 5 union all select 6) t2,(SELECT @row:=-1) t3 limit 31 ) b where DATE_ADD('"+cmbyear+"-"+cmbmonth+"-01', INTERVAL ROW DAY) between "
			    	    		+ "'"+cmbyear+"-"+cmbmonth+"-01' and '"+cmbyear+"-"+cmbmonth+"-31' and DAYOFWEEK(DATE_ADD('"+cmbyear+"-"+cmbmonth+"-01', INTERVAL ROW DAY))=(if(("+weekoff+"+1)>7,1,("+weekoff+"+1)))";
			    	    	System.out.println("sqls1 ="+sqls1);
			    	    	ResultSet resultSet3 = stmtBDTS.executeQuery(sqls1);
				    	    
				    	    while(resultSet3.next()){
				    	    	weeklyoffarray.add(resultSet3.getDate("holidaysofmonth"));
				    	    }
			    	    } else if(checkweekoff.equalsIgnoreCase("1")){
			    	    	
			    	    	for(int k=0;k<(weekoff.length()-1);k++){
			    	    	
			    	    		sqls1="select CONCAT('"+cmbyear+"','-','"+cmbmonth+"','-',if(LENGTH((row+1))=1,CONCAT('0',(row+1)),(row+1)))  as holidaysofmonth from ( SELECT @row := @row + 1 as row FROM (select 0 union all select 1 union all select 3 union all "
				    	    		+ "select 4 union all select 5 union all select 6) t1,(select 0 union all select 1 union all select 3 union all select 4 union all "
				    	    		+ "select 5 union all select 6) t2,(SELECT @row:=-1) t3 limit 31 ) b where DATE_ADD('"+cmbyear+"-"+cmbmonth+"-01', INTERVAL ROW DAY) between "
				    	    		+ "'"+cmbyear+"-"+cmbmonth+"-01' and '"+cmbyear+"-"+cmbmonth+"-31' and DAYOFWEEK(DATE_ADD('"+cmbyear+"-"+cmbmonth+"-01', INTERVAL ROW DAY))=(if(("+weekoffs[k]+"+1)>7,1,("+weekoffs[k]+"+1)))";
			    	    		System.out.println("sqls1 ="+sqls1);
				    	    	ResultSet resultSet3 = stmtBDTS.executeQuery(sqls1);
					    	    
					    	    while(resultSet3.next()){
					    	    	weeklyoffarray.add(resultSet3.getDate("holidaysofmonth"));
					    	    }
					    	    
			    	    	}
			    	    }
			    	    
			    	    
			    	    for(int j=0;j<weeklyoffarray.size();j++){
			                sqlHolidayDate=(Date) weeklyoffarray.get(j);
			                if(sqlHolidayDate.compareTo(date) == 0){
								 holidayWorked=1;
								 break;
							 }
							 
							 if(holidayWorked==1){
								 break;
							 }
							 
			           }
					 
			    	    
					 Statement stmtBDTS2 = conn.createStatement();
					 Statement stmtBDTS3 = conn.createStatement();
					 
					 String sql1="select * from gl_setholidayhrsd where status=3 and date='"+date+"'";
					 ResultSet resultSet1 = stmtBDTS.executeQuery(sql1);
					 while (resultSet1.next()) {
						 holidayWorked=1;
						 String sql2="select * from gl_setholidayhrsm where status=3 and '"+date+"' between fromdate and todate and deduction=1";
						 ResultSet resultSet2 = stmtBDTS2.executeQuery(sql2);
						 while (resultSet2.next()) {
							 ramdanDeduction=1;
							 String sql3="select method,round(value,0) ramdanhrsded from gl_config where field_nme='DriverRamdanDedHrs'";
							 ResultSet resultSet3 = stmtBDTS3.executeQuery(sql3);
							 while (resultSet3.next()) {
								 method=resultSet3.getString("method");
								 ramdanDedHrs=resultSet3.getString("ramdanhrsded");
							 }
							 
						 }
				     }
					 
					 /*Ramdan Deduction Hrs*/
					 if(method.equalsIgnoreCase("1") && ramdanDeduction==1){
						 
						 System.out.println(" ------------inside Ramdan Deduction Hrs------------");
						 int rnorm=normalHourInHour;
						 int rnormalsum=0;
						 int rotsum=0;
						 
						 String sql4s="select ((coalesce(sum(normal),0)+coalesce(sum(ot),0))+("+normalHourInHour+")) workedhrs, coalesce(sum(normal),0)+("+normalHourInHour+") normalsum,coalesce(sum(ot),0) otsum from gl_drtimesheethrs where status=3 and date='"+date+"' and drid="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+"";
						 ResultSet resultSet4s = stmtBDTS.executeQuery(sql4s);
						 while (resultSet4s.next()) {
							 normalHourInHour=resultSet4s.getInt("workedhrs");
							 rnormalsum=resultSet4s.getInt("normalsum");
							 rotsum=resultSet4s.getInt("otsum");
						 }
						 
						 String sql4="select (("+whrs+")-("+ramdanDedHrs+")) ramdanwhrs ";
						 ResultSet resultSet4 = stmtBDTS.executeQuery(sql4);
						 while (resultSet4.next()) {
							 ramdanWhrs=resultSet4.getInt("ramdanwhrs");
						 }
						 
						 
						 if(rnormalsum>ramdanWhrs){
							 
							 otInHour=normalHourInHour-(ramdanWhrs+rotsum);
							 int hours = otInHour / 60;
							 int minutes = otInHour % 60;
							 otTime=hours+":"+minutes;
							 
							 normalHourInHour=ramdanWhrs-rnormalsum+rnorm;
							 
						 }else{
							 normalHourInHour=rnorm;
						 }
						 
						 /*if(normalHourInHour>ramdanWhrs){
							 otInHour=normalHourInHour-ramdanWhrs;
							 int hours = otInHour / 60;
							 int minutes = otInHour % 60;
							 otTime=hours+":"+minutes;
						 }*/
						 
					 }
					 /*Ramdan Deduction Hrs Ends*/
					 
					 /*Holiday Hrs*/
					 if(holidayWorked==1 && ramdanDeduction==0) {
						 
						 System.out.println(" ------------Holiday Hrs------------");
						 int otsum1=0;
						 String sql5s="select ((coalesce(sum(normal),0)+coalesce(sum(ot),0))+("+normalHourInHour+")) workedhrs, coalesce(sum(normal),0)+("+normalHourInHour+") normalsum,coalesce(sum(ot),0) otsum from gl_drtimesheethrs where status=3 and date='"+date+"' and drid="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+"";
						 ResultSet resultSet5s = stmtBDTS.executeQuery(sql5s);
						 while (resultSet5s.next()) {
							 normalHourInHour=resultSet5s.getInt("workedhrs");
							 otsum1=resultSet5s.getInt("otsum");
						 }
						 
						 actualWhrs=(int)Double.parseDouble(whrs);
						 
						 otInHour=normalHourInHour-otsum1;
						 int hours = otInHour / 60;
						 int minutes = otInHour % 60;
						 otTime=hours+":"+minutes;
						 normalHourInHour=0;
						 
					 }
					 /*Holiday Hrs*/
					 
					 /*Over Time Hrs*/
					 if(holidayWorked==0 && ramdanDeduction==0) {
						 
						 System.out.println(" ------------Over Time Hrs------------");
						 int norm=normalHourInHour;
						 int normalsum=0;
						 int otsum=0;
						 
						 String sql6s="select ((coalesce(sum(normal),0)+coalesce(sum(ot),0))+("+normalHourInHour+")) workedhrs, coalesce(sum(normal),0)+("+normalHourInHour+") normalsum,coalesce(sum(ot),0) otsum from gl_drtimesheethrs where status=3 and date='"+date+"' and drid="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+"";
//						 System.out.println("--------:n "+sql6s);
						 
						 ResultSet resultSet6s = stmtBDTS.executeQuery(sql6s);
						 while (resultSet6s.next()) {
							 normalHourInHour=resultSet6s.getInt("workedhrs");
							 normalsum=resultSet6s.getInt("normalsum");
							 otsum=resultSet6s.getInt("otsum");
						 }
						 
						 actualWhrs=(int)Double.parseDouble(whrs);
						 
						 
						 if(normalsum>actualWhrs){
							 
							 otInHour=normalHourInHour-(actualWhrs+otsum);
							 int hours = otInHour / 60;
							 int minutes = otInHour % 60;
							 otTime=hours+":"+minutes;
							 
							 normalHourInHour=actualWhrs-normalsum+norm;
							 
						 }else{
							 normalHourInHour=norm;
						 }
						
						 
						 
/*						 if(normalsum>actualWhrs){
							 
							 
							 otInHour=normalHourInHour-actualWhrs;
							 int hours = otInHour / 60;
							 int minutes = otInHour % 60;
							 otTime=hours+":"+minutes;
							 
							 
							 
						 }else{
							 normalHourInHour=norm;
						 }*/
						 
					 }
					 /*Over Time Hrs*/
					 
					
					 stmtBDTS1 = conn.prepareCall("INSERT INTO gl_drtimesheethrs(date, drid, aggno, intime, outtime, normalhrs, othrs, normal, ot, status) VALUES(?,?,?,?,?,?,?,?,?,?)");
						
					 stmtBDTS1.setDate(1,date);
					 stmtBDTS1.setString(2,(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString());
					 stmtBDTS1.setString(3,(timesheet[2].trim().equalsIgnoreCase("undefined") || timesheet[2].trim().equalsIgnoreCase("NaN") || timesheet[2].trim().equalsIgnoreCase("") ||timesheet[2].trim().isEmpty()?"0":timesheet[2].trim()).toString());
					 stmtBDTS1.setString(4,(timesheet[5].trim().equalsIgnoreCase("undefined") || timesheet[5].trim().equalsIgnoreCase("NaN") || timesheet[5].trim().equalsIgnoreCase("") ||timesheet[5].trim().isEmpty()?"0":timesheet[5].trim()).toString());
					 stmtBDTS1.setString(5,(timesheet[6].trim().equalsIgnoreCase("undefined") || timesheet[6].trim().equalsIgnoreCase("NaN") || timesheet[6].trim().equalsIgnoreCase("") ||timesheet[6].trim().isEmpty()?"0":timesheet[6].trim()).toString());
					 stmtBDTS1.setString(6,normalTime);
					 stmtBDTS1.setString(7,otTime);
					 stmtBDTS1.setInt(8,normalHourInHour);
					 stmtBDTS1.setInt(9,otInHour);
					 stmtBDTS1.setString(10,"3");
				     int data = stmtBDTS1.executeUpdate();
					 if(data<=0){
						stmtBDTS.close();
						conn.close();
						return 0;
					 }
					 
					 stmtBDTS2.close();
					 stmtBDTS3.close();
				}
				 
			}
				
			/*Inserting gl_bdts*/
		     String sql2="insert into gl_bdts(doc_no, date, driverIds, brhid, userid) values('"+docno+"',now(),'"+selecteddrivers+"','"+branch+"','"+userid+"')";
		     int data1= stmtBDTS.executeUpdate(sql2);
			 if(data1<=0){
				    stmtBDTS.close();
					conn.close();
					return 0;
				}
			 /*Inserting gl_bdts Ends*/
				 
			 String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+branch+"','BDTS',now(),'"+userid+"','A')";
			 int datas= stmtBDTS.executeUpdate(sqls);
			 if(datas<=0){
				 	stmtBDTS.close();
				    conn.close();
					return 0;
				}
			conn.commit();
			stmtBDTS.close();
			conn.close();
			return docno;
		
	 } catch(Exception e){	
		 	conn.close();
		 	e.printStackTrace();	
		 	return 0;
	 } finally{
		 conn.close();
	 }
	}
	
	public JSONArray driverDetailsSearch(String drid,String drivername,String contact) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtBDTS = conn.createStatement();
			
	    	    String sql = "";
				
	            if(!(drivername.equalsIgnoreCase(""))){
	             sql=sql+" and name like '%"+drivername+"%'";
	            }
	            if(!(contact.equalsIgnoreCase(""))){
	                sql=sql+" and mobno like '%"+contact+"%'";
	            }
	            
				sql = "select doc_no,dr_id,name,mobno from gl_drdetails where dtype='DRV'"+sql;
				
				ResultSet resultSet1 = stmtBDTS.executeQuery(sql);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtBDTS.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public JSONArray agreementDetailsSearch(String clientname,String agmtno,String regno,String fleetno,String date) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtBDTS = conn.createStatement();
		        
		        java.sql.Date sqldate=null;
	    	    String sql = "";
				
	            if(!(clientname.equalsIgnoreCase(""))){
	             sql=sql+" and a.refname like '%"+clientname+"%'";
	            }
	            if(!(agmtno.equalsIgnoreCase(""))){
	                sql=sql+" and r.voc_no like '%"+agmtno+"%'";
	            }
	            if(!(regno.equalsIgnoreCase(""))){
	                sql=sql+" and v.reg_no like '%"+regno+"%'";
	            }
	            if(!(fleetno.equalsIgnoreCase(""))){
	                sql=sql+" and v.fleet_no like '%"+fleetno+"%'";
	            }
	            if(!(date.equalsIgnoreCase("")) && !(date.equalsIgnoreCase("0")) && date!=null){
					sqldate=ClsCommon.changeStringtoSqlDate(date);
					sql=sql+" and r.date ='"+sqldate+"'";
				}
	            
				String sql1 = "select r.doc_no,r.voc_no,r.date,v.reg_no,v.fleet_no, a.refname"
					+" from gl_lagmt r left join gl_vehmaster v on v.fleet_no=if(r.perfleet=0,r.tmpfleet,r.perfleet)"
					+" left join my_acbook a on a.cldocno= r.cldocno and a.dtype='CRM' where r.status=3 "+sql;
				
				ResultSet resultSet1 = stmtBDTS.executeQuery(sql1);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtBDTS.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA1;
	}

	
	public JSONArray timeSheetFillGridLoading(HttpSession session,String fromdate,String todate,String days,String selectedagreement,String selectedagreementid,String selecteddrdocno,
			String fillintime,String fillouttime,String fillnormalhrs,String fillothrs,String gridload) throws SQLException {

		JSONArray jsonArray = new JSONArray();

		if(!(gridload.equalsIgnoreCase("1"))){
			return jsonArray;
		}
		
		Connection conn = null;
		
		try {
			  conn = ClsConnection.getMyConnection();
			    Statement stmtBHTS = conn.createStatement ();


				java.sql.Date stdate=ClsCommon.changeStringtoSqlDate(fromdate);
				java.sql.Date enddate=ClsCommon.changeStringtoSqlDate(todate);

				String sql1="",sql2="",sql3="";
				
				if(!(days.equalsIgnoreCase("0")) && !(days.equalsIgnoreCase(""))){
					if (days.trim().endsWith(",")) {
						days = days.trim().substring(0,days.length() - 1);
					}
					
					sql1+=" and weekday(date) in ("+days+")";
				}
				System.out.println("----:"+selecteddrdocno);
				if(!(selecteddrdocno.equalsIgnoreCase("0")) && !(selecteddrdocno.equalsIgnoreCase(""))){
					sql2="select a.*,b.* from (";
					sql3=" ) a,(select doc_no,dr_id drid,name drname,mobno from gl_drdetails where dtype='DRV' and dr_id in ("+selecteddrdocno+")) b order by a.date,b.drid";
					
				}

				/*for(int i=0;i<2;i++){*/

					String clsql= (""+sql2+"select  date_format(date,'%Y-%m-%d') as date,DAYname(date_format(date,'%Y-%m-%d')) as days,'"+selectedagreement+"' as agmtvoc_no, "
							+ "'"+fillintime+"' as intime,'"+fillouttime+"' as outtime,'"+fillnormalhrs+"' as hrs,'"+fillothrs+"' as othrs,'"+selectedagreementid+"' as agmtdoc_no from ( "
							+ "select  date_add('"+stdate+"', INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) as date "
							+ "from  (select 0 as num union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 "
							+ "union all select 6 union all select 7 union all select 8 union all select 9) n1, "
							+ "(select 0 as num union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 "
							+ "union all select 6 union all select 7 union all select 8 union all select 9) n2, (select 0 as num union all select 1 "
							+ " union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 "
							+ " union all select 8 union all select 9) n3, (select 0 as num union all select 1 union all select 2 union all select 3 "
							+ " union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) n4 "
							+ " ) a where date >='"+stdate+"' and date <='"+enddate+"'"+sql1+" order by date"+sql3+"");

					System.out.println("-------sds-------: "+clsql);
					ResultSet resultSet = stmtBHTS.executeQuery(clsql);

					jsonArray=ClsCommon.convertToJSON(resultSet);

				/*}*/

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return jsonArray;
	}
	
	public JSONArray getTimeSheetData(String driverid,String agmtno,String year,String month,String date,String id) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	    if(!id.equalsIgnoreCase("1")){
	    	return RESULTDATA1;
	    }
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtBDTS = conn.createStatement();
		        
		        java.sql.Date sqldate=null;
	    	    String sql = "";
	    	    if(!(driverid.equalsIgnoreCase(""))){
		             sql=sql+" and ts.drid="+driverid;
		            }
		            if(!(agmtno.equalsIgnoreCase(""))){
		                sql=sql+" and ts.aggno="+agmtno;
		            }
		            if(!(date.equalsIgnoreCase("")) && !(date.equalsIgnoreCase("0")) && date!=null){
						sqldate=ClsCommon.changeStringtoSqlDate(date);
						sql=sql+" and ts.date ='"+sqldate+"'";
					}
	            
				sql = "select ts.date,dr.name drname,lag.voc_no agmtvoc_no,ts.intime,ts.outtime,ts.normalhrs hrs,ts.normal,ts.othrs"
					+" from gl_drtimesheethrs ts left join gl_drdetails dr on (ts.drid=dr.dr_id and dr.dtype='DRV')"
					+" left Join gl_lagmt lag on ts.aggno=lag.doc_no"
					+" where  ts.date between '"+year+"-"+month+"-01' and LAST_DAY('"+year+"-"+month+"-01') and ts.status=3 "+sql;
				
				System.out.println("loading---- -- -"+sql );
				ResultSet resultSet1 = stmtBDTS.executeQuery(sql);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtBDTS.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA1;
	}

}
