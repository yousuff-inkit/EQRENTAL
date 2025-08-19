package com.dashboard.analysis.vehicledetailreport;

import com.common.ClsCommon;
import com.connection.ClsConnection;



import java.sql.*;

import net.sf.json.JSONArray;
public class ClsVehicleDetailReportDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getVehicleCountData(String branch,String fromdate,String todate,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String strsql="select * from ("+
			" select 'Opening' desc1,'OPN' status,count(*) value from gl_vehmaster where statu=3 and fstatus='L' and prch_dte<'"+sqlfromdate+"' union all"+
			" select 'Total Purchased' desc1,'PUR' status,count(*) value from gl_vehmaster where statu=3 and prch_dte>='"+sqlfromdate+"' and prch_dte<='"+sqltodate+"' union all"+
			" select 'Total Sold' desc1,'SAL' status,count(*) value from gl_vsalem m left join gl_vsaled d on m.doc_no=d.rdocno where status=3 and m.date>='"+sqlfromdate+"' and m.date<='"+sqltodate+"' union all"+
			" select 'Total Available' desc1,'TOT' status,sum(a.value) value from ("+
			" select 'Opening' desc1,'OPN' status,count(*) value from gl_vehmaster where statu=3 and fstatus='L' and prch_dte<'"+sqlfromdate+"' union all"+
			" select 'Total Purchased' desc1,'PUR' status,count(*) value from gl_vehmaster where statu=3 and prch_dte>='"+sqlfromdate+"' and prch_dte<='"+sqltodate+"' union all"+
			" select 'Total Sold' desc1,'SAL' status,count(*)*-1 value from gl_vsalem m left join gl_vsaled d on m.doc_no=d.rdocno where status=3 and m.date>='"+sqlfromdate+"' and m.date<='"+sqltodate+"')a)b";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return data;
		
	}
	
	public JSONArray getVehicleMasterData(String branch,String fromdate,String todate,String id,String status) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			int monthdiff=0;
			String strgetmonthdiff="SELECT TIMESTAMPDIFF(MONTH, '"+sqlfromdate+"', '"+sqltodate+"') MONTHDIFF";
			ResultSet rsmonthdiff=stmt.executeQuery(strgetmonthdiff);
			while(rsmonthdiff.next()){
				monthdiff=rsmonthdiff.getInt("MONTHDIFF");
			}
			java.sql.Date sqltempdate=sqlfromdate;
			String strsql="";
			for(int i=0;i<monthdiff+1;i++){
				if(i==0){
					strsql+="select '"+sqltempdate+"' monthdate,convert(concat(monthname('"+sqltempdate+"'),' ',year('"+sqltempdate+"')),char(100)) monthname,a.opening,a.purchased,a.sold,(a.opening+a.purchased)-a.sold total from ("+
					" select (select count(*) from gl_vehmaster where statu=3 and fstatus='L' and prch_dte<'"+sqltempdate+"') opening,"+
					" (select count(*) from gl_vehmaster veh where statu=3 and month(veh.prch_dte)=month('"+sqltempdate+"') and year(veh.prch_dte)=year('"+sqltempdate+"')) purchased,"+
					" (select count(*) from gl_vsalem m left join gl_vsaled d on m.doc_no=d.rdocno where status=3 and month(m.date)=month('"+sqltempdate+"') and year(m.date)=year('"+sqltempdate+"')) sold) a";
				}
				else{
					strsql+=" union all select '"+sqltempdate+"' monthdate,convert(concat(monthname('"+sqltempdate+"'),' ',year('"+sqltempdate+"')),char(100)) monthname,a.opening,a.purchased,a.sold,(a.opening+a.purchased)-a.sold total from ("+
					" select (select count(*) from gl_vehmaster where statu=3 and fstatus='L' and prch_dte<'"+sqltempdate+"') opening,"+
					" (select count(*) from gl_vehmaster veh where statu=3 and month(veh.prch_dte)=month('"+sqltempdate+"') and year(veh.prch_dte)=year('"+sqltempdate+"')) purchased,"+
					" (select count(*) from gl_vsalem m left join gl_vsaled d on m.doc_no=d.rdocno where status=3 and month(m.date)=month('"+sqltempdate+"') and year(m.date)=year('"+sqltempdate+"')) sold) a";
					
				}
				String straddmonth="select date_add('"+sqltempdate+"',interval 1 month) newdate";
				ResultSet rsaddmonth=stmt.executeQuery(straddmonth);
				while(rsaddmonth.next()){
					sqltempdate=rsaddmonth.getDate("newdate");
				}
			}
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	
	public JSONArray getVehicleMasterExcelData(String branch,String fromdate,String todate,String id,String status) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			int monthdiff=0;
			String strgetmonthdiff="SELECT TIMESTAMPDIFF(MONTH, '"+sqlfromdate+"', '"+sqltodate+"') MONTHDIFF";
			ResultSet rsmonthdiff=stmt.executeQuery(strgetmonthdiff);
			while(rsmonthdiff.next()){
				monthdiff=rsmonthdiff.getInt("MONTHDIFF");
			}
			java.sql.Date sqltempdate=sqlfromdate;
			String strsql="";
			for(int i=0;i<monthdiff+1;i++){
				if(i==0){
					strsql+="select convert(concat(monthname('"+sqltempdate+"'),' ',year('"+sqltempdate+"')),char(100)) 'Month Name',a.opening 'Opening',a.purchased 'Purchased',a.sold 'Sold',(a.opening+a.purchased)-a.sold 'Total' from ("+
					" select (select count(*) from gl_vehmaster where statu=3 and fstatus='L' and prch_dte<'"+sqltempdate+"') opening,"+
					" (select count(*) from gl_vehmaster veh where statu=3 and month(veh.prch_dte)=month('"+sqltempdate+"') and year(veh.prch_dte)=year('"+sqltempdate+"')) purchased,"+
					" (select count(*) from gl_vsalem m left join gl_vsaled d on m.doc_no=d.rdocno where status=3 and month(m.date)=month('"+sqltempdate+"') and year(m.date)=year('"+sqltempdate+"')) sold) a";
				}
				else{
					strsql+=" union all select convert(concat(monthname('"+sqltempdate+"'),' ',year('"+sqltempdate+"')),char(100)) 'Month Name',a.opening 'Opening',a.purchased 'Purchased',a.sold 'Sold',(a.opening+a.purchased)-a.sold 'Total' from ("+
					" select (select count(*) from gl_vehmaster where statu=3 and fstatus='L' and prch_dte<'"+sqltempdate+"') opening,"+
					" (select count(*) from gl_vehmaster veh where statu=3 and month(veh.prch_dte)=month('"+sqltempdate+"') and year(veh.prch_dte)=year('"+sqltempdate+"')) purchased,"+
					" (select count(*) from gl_vsalem m left join gl_vsaled d on m.doc_no=d.rdocno where status=3 and month(m.date)=month('"+sqltempdate+"') and year(m.date)=year('"+sqltempdate+"')) sold) a";
					
				}
				String straddmonth="select date_add('"+sqltempdate+"',interval 1 month) newdate";
				ResultSet rsaddmonth=stmt.executeQuery(straddmonth);
				while(rsaddmonth.next()){
					sqltempdate=rsaddmonth.getDate("newdate");
				}
			}
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToEXCEL(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	public JSONArray getVehicleDetailData(String branch,String fromdate,String todate,String id,String status,String monthdate)throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlmonthdate=null;
			if(!monthdate.equalsIgnoreCase("")){
				sqlmonthdate=objcommon.changeStringtoSqlDate(monthdate);
			}
			String sqltest="";
			System.out.println(sqlmonthdate);
			System.out.println(monthdate);
			if(status.equalsIgnoreCase("opening")){
				sqltest+=" and veh.statu=3 and veh.fstatus='L' and veh.prch_dte<='"+sqlmonthdate+"'";
			}
			else if(status.equalsIgnoreCase("purchased")){
				sqltest+=" and veh.statu=3 and month(veh.prch_dte)=month('"+sqlmonthdate+"') and year(veh.prch_dte)=year('"+sqlmonthdate+"')";
			}
			else if(status.equalsIgnoreCase("sold")){
				sqltest+=" and m.status=3 and month(m.date)=month('"+sqlmonthdate+"') and year(m.date)=year('"+sqlmonthdate+"')";
			}
			String strsql="";
			if(status.equalsIgnoreCase("opening") || status.equalsIgnoreCase("purchased")){
				strsql="select veh.fleet_no,veh.flname,veh.reg_no,veh.prch_dte purchasedate,veh.ch_no chassisno from gl_vehmaster veh where 1=1"+sqltest;
			}
			else if(status.equalsIgnoreCase("sold")){
				strsql="select * from (select convert(fl.date,char(25)) fsdate,veh.fleet_no,veh.flname,veh.reg_no,veh.prch_dte purchasedate,veh.ch_no "+
				" chassisno,m.date saledate from gl_vsalem m left join gl_vsaled d on m.doc_no=d.rdocno left join gl_vehmaster veh on "+
				" d.fleetno=veh.fleet_no left join (select max(doc_no) maxchangedoc,fleetno "+
				" from gl_flchange where changest='FS' group by fleetno) maxfl on (maxfl.fleetno=veh.fleet_no) left join gl_flchange fl "+
				" on (maxfl.maxchangedoc=fl.doc_no) where 1=1"+sqltest+") a  group by a.fleet_no";
			}
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
}
