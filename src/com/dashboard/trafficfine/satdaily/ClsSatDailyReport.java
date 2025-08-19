package com.dashboard.trafficfine.satdaily;

 import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSatDailyReport  { 
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray satDailyReportGridLoading(String fromdate,String todate,String satcatg,String datefilter,String check) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			
			java.sql.Date sdate=ClsCommon.changeStringtoSqlDate(fromdate);
			java.sql.Date edate=ClsCommon.changeStringtoSqlDate(todate);
			
			String sql="";
			
			if(satcatg.equalsIgnoreCase("salik")){
				
				if(datefilter.equalsIgnoreCase("1")) {
					sql+=" and DATE_FORMAT((coalesce(salik_date,date)),'%Y-%m-%d')<='"+edate+"' and DATE_FORMAT((coalesce(salik_date,date)),'%Y-%m-%d')>='"+sdate+"'";
				} else if(datefilter.equalsIgnoreCase("2")) {
					sql+=" and DATE_FORMAT(autodate,'%Y-%m-%d')<='"+edate+"' and DATE_FORMAT(autodate,'%Y-%m-%d')>='"+sdate+"'";
				}
				
				resultSet= stmt.executeQuery ("Select Salik_User username,trans,DATE_FORMAT(salik_date,'%d.%m.%Y') salik_date,salik_time,DATE_FORMAT(sal_date,'%d.%m.%Y') sal_date,regno,source,tagno,location,direction,amount,DATE_FORMAT((coalesce(autodate,date)),'%d.%m.%Y %H:%m:%s') date from gl_salik where 1=1"+sql+"");
			}
			if(satcatg.equalsIgnoreCase("traffic")){
				
				if(datefilter.equalsIgnoreCase("1")) {
					sql+=" and DATE_FORMAT((coalesce(traffic_date,date)),'%Y-%m-%d')<='"+edate+"' and DATE_FORMAT((coalesce(traffic_date,date)),'%Y-%m-%d')>='"+sdate+"'";
				} else if(datefilter.equalsIgnoreCase("2")) {
					sql+=" and DATE_FORMAT(autodate,'%Y-%m-%d')<='"+edate+"' and DATE_FORMAT(autodate,'%Y-%m-%d')>='"+sdate+"'";
				}
				
				String sql2="Select tcno,ticket_no,DATE_FORMAT(traffic_date,'%d.%m.%Y') traffic_date,time,fine_source,amount,regno,Pcolor,licence_no,licence_from,tick_violat,tick_location,DATE_FORMAT((coalesce(autodate,date)),'%d.%m.%Y %H:%m:%s') date,desc1  from gl_traffic where 1=1"+sql+"";
				resultSet= stmt.executeQuery (sql2);
			}
			
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray satDailyReportExcelExport(String fromdate,String todate,String satcatg,String datefilter,String check) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			
			java.sql.Date sdate=ClsCommon.changeStringtoSqlDate(fromdate);
			java.sql.Date edate=ClsCommon.changeStringtoSqlDate(todate);
			
			String sql="";
			
			if(satcatg.equalsIgnoreCase("salik")){
				
				if(datefilter.equalsIgnoreCase("1")) {
					sql+=" and DATE_FORMAT((coalesce(salik_date,date)),'%Y-%m-%d')<='"+edate+"' and DATE_FORMAT((coalesce(salik_date,date)),'%Y-%m-%d')>='"+sdate+"'";
				} else if(datefilter.equalsIgnoreCase("2")) {
					sql+=" and DATE_FORMAT(autodate,'%Y-%m-%d')<='"+edate+"' and DATE_FORMAT(autodate,'%Y-%m-%d')>='"+sdate+"'";
				}
				
				resultSet= stmt.executeQuery ("Select trans 'Transaction',Salik_User 'User Name',DATE_FORMAT((coalesce(autodate,date)),'%d-%m-%Y %H:%m:%s') 'Downloaded Date',salik_date 'Trip Date',salik_time 'Trip Time',sal_date 'Post Date',regno 'Plate',source 'Source',tagno 'Tag',location 'Location',direction 'Direction',amount 'Amount' from gl_salik where 1=1"+sql+"");
			}
			if(satcatg.equalsIgnoreCase("traffic")){
				
				if(datefilter.equalsIgnoreCase("1")) {
					sql+=" and DATE_FORMAT((coalesce(traffic_date,date)),'%Y-%m-%d')<='"+edate+"' and DATE_FORMAT((coalesce(traffic_date,date)),'%Y-%m-%d')>='"+sdate+"'";
				} else if(datefilter.equalsIgnoreCase("2")) {
					sql+=" and DATE_FORMAT(autodate,'%Y-%m-%d')<='"+edate+"' and DATE_FORMAT(autodate,'%Y-%m-%d')>='"+sdate+"'";
				}
				
				String sql2="Select tcno 'TcNo',DATE_FORMAT((coalesce(autodate,date)),'%d-%m-%Y %H:%m:%s') 'Downloaded Date',ticket_no 'Fine No',traffic_date 'Traffic Date',time as 'Time',fine_source 'Fine Source',amount 'Fees',regno 'Plate No',Pcolor 'Plate Category',desc1 'Description'  from gl_traffic where 1=1"+sql+"";
				resultSet= stmt.executeQuery (sql2);
			}
			
			RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}
	
	@SuppressWarnings("resource")
	public JSONArray satDailyReportCountGridLoading(String fromdate,String todate,String satcatg,String datefilter,String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			
			java.sql.Date sdate=ClsCommon.changeStringtoSqlDate(fromdate);
			java.sql.Date edate=ClsCommon.changeStringtoSqlDate(todate);
			
			 if(satcatg.equalsIgnoreCase("traffic")){
				 
				 if(datefilter.equalsIgnoreCase("1")) {
					 String trfsql="select DATE_FORMAT((coalesce(traffic_date,date)),'%d-%m-%Y %H:%m:%s') date,count(*) as datecount,DATE_FORMAT((coalesce(traffic_date,date)),'%d.%m.%Y') hiddate from gl_traffic where DATE_FORMAT((coalesce(traffic_date,date)),'%Y-%m-%d')<='"+edate+"' and DATE_FORMAT((coalesce(traffic_date,date)),'%Y-%m-%d')>='"+sdate+"' group by coalesce(date(traffic_date),date)";				 
					 resultSet= stmt.executeQuery (trfsql);
				 } else if(datefilter.equalsIgnoreCase("2")) {
					 String trfsql="select DATE_FORMAT(autodate,'%d-%m-%Y %H:%m:%s') date,count(*) as datecount,DATE_FORMAT(autodate,'%d.%m.%Y') hiddate from gl_traffic where DATE_FORMAT(autodate,'%Y-%m-%d')<='"+edate+"' and DATE_FORMAT(autodate,'%Y-%m-%d')>='"+sdate+"' group by DATE_FORMAT(autodate,'%Y-%m-%d')";				 
					 resultSet= stmt.executeQuery (trfsql);
				 }
				 
			}
			 if(satcatg.equalsIgnoreCase("salik")){
				 if(datefilter.equalsIgnoreCase("1")) {
					resultSet= stmt.executeQuery ("select DATE_FORMAT((coalesce(salik_date,date)),'%d-%m-%Y %H:%m:%s') date,count(*) as datecount,DATE_FORMAT((coalesce(salik_date,date)),'%d.%m.%Y') hiddate from gl_salik where DATE_FORMAT((coalesce(salik_date,date)),'%Y-%m-%d')<='"+edate+"' and DATE_FORMAT((coalesce(salik_date,date)),'%Y-%m-%d')>='"+sdate+"' group by coalesce(date(salik_date),date)");
				 } else if(datefilter.equalsIgnoreCase("2")) {
					 resultSet= stmt.executeQuery ("select DATE_FORMAT(autodate,'%d-%m-%Y %H:%m:%s') date,count(*) as datecount,DATE_FORMAT(autodate,'%d.%m.%Y') hiddate from gl_salik where DATE_FORMAT(autodate,'%Y-%m-%d')<='"+edate+"' and DATE_FORMAT(autodate,'%Y-%m-%d')>='"+sdate+"' group by DATE_FORMAT(autodate,'%Y-%m-%d')");
				 }
			}
			
			RESULTDATA=ClsCommon.convertToJSON(resultSet);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}
	
	
}
