package com.dashboard.vehicle.residualvaluecheck;

import java.sql.*;

import net.sf.json.JSONArray;

import com.common.*;
import com.connection.*;
public class ClsResidualValueDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getDeFleetData(String id,String fromdate,String todate,String branch,String fleetno) throws SQLException
	{
		JSONArray defleetdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return defleetdata;
		}
		
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String sqltest="";
			if(!fromdate.equalsIgnoreCase("") && todate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			if(sqlfromdate!=null){
				sqltest+=" and v.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and v.date<='"+sqltodate+"'";
			}
			
			if(!fleetno.equalsIgnoreCase("")){
				sqltest+=" and v.fleet_no="+fleetno;
			}
			/*String strsql="select ret.salesprice,ret.date defleetdate,veh.fleet_no,veh.reg_no,veh.flname,veh.prch_cost purcost,veh.residual_val residualval,veh.eng_no engineno,veh.ch_no chassisno,veh.vin from gl_vehreturn ret left join gl_vehmaster veh on (ret.fleetno=veh.fleet_no and ret.defleetstatus=1) where ret.status=3 and ret.defleetstatus=1"+sqltest;*/
			String strsql="select l.brhid,l.larefdocno leaseappno,l.larefdocno,v.fleet_no,v.flname,concat(v.reg_no,-v.pltid) regno,v.prch_cost purval,v.residual_val resval,l.voc_no lano,ac.refname client"
					+ " ,l.outdate,l.date,CONVERT(round(lreq.prchcost,2),CHAR(100)) leaseapp,lreq.residalvalue leaseappres,l.outdate"
					+ " , if(l.per_name=1,DATE_ADD(l.outdate,INTERVAL l.per_value YEAR),DATE_ADD(l.outdate,INTERVAL l.per_value MONTH)) AS 'enddate'"
					+ "  from gl_vehmaster v"
					+ " left join gl_lagmt l on v.fleet_no=l.perfleet "
					+ " left join gl_blaf b on l.blafsrno=b.srno "
					+ " left join gl_leasecalcreq lreq on b.rdocno=lreq.srno "
					+ "left join my_acbook ac on l.cldocno=ac.cldocno where 1=1"+sqltest;
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			defleetdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		
		return defleetdata;
	}

	public JSONArray getDeFleetExcelData(String id,String fromdate,String todate,String branch,String fleetno) throws SQLException
	{
		JSONArray defleetdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return defleetdata;
		}
		
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String sqltest="";
			if(!fromdate.equalsIgnoreCase("") && todate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			if(sqlfromdate!=null){
				sqltest+=" and v.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and v.date<='"+sqltodate+"'";
			}
			
			if(!fleetno.equalsIgnoreCase("")){
				sqltest+=" and v.fleet_no="+fleetno;
			}
			/*String strsql="select ret.salesprice,ret.date defleetdate,veh.fleet_no,veh.reg_no,veh.flname,veh.prch_cost purcost,veh.residual_val residualval,veh.eng_no engineno,veh.ch_no chassisno,veh.vin from gl_vehreturn ret left join gl_vehmaster veh on (ret.fleetno=veh.fleet_no and ret.defleetstatus=1) where ret.status=3 and ret.defleetstatus=1"+sqltest;*/
			String strsql="select v.fleet_no Fleet_no,v.flname Fleet_Name,concat(v.reg_no,-v.pltid) Regno,l.voc_no LA_NO,ac.refname Client,l.outdate LA_Outdate,l.date LA_Startdate,if(l.per_name=1,DATE_ADD(l.outdate,INTERVAL l.per_value YEAR),DATE_ADD(l.outdate,INTERVAL l.per_value MONTH)) AS 'LA_Enddate',"
					+ " v.prch_cost Purch_Value,v.residual_val RESIDUAL_Value,l.larefdocno Applicat_No,CONVERT(round(lreq.prchcost,2),CHAR(100)) Applicat_Purch_Value"
					+ " ,lreq.residalvalue Applicat_Residual_Value"
					+ "  from gl_vehmaster v"
					+ " left join gl_lagmt l on v.fleet_no=l.perfleet "
					+ " left join gl_blaf b on l.blafsrno=b.srno "
					+ " left join gl_leasecalcreq lreq on b.rdocno=lreq.srno "
					+ "left join my_acbook ac on l.cldocno=ac.cldocno where 1=1"+sqltest;
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			defleetdata=objcommon.convertToEXCEL(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		
		return defleetdata;
	}
	
}
