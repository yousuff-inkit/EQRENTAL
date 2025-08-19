package com.dashboard.workshop.gateinpasslist;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;
public class ClsGateInPassListDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getGateInPassData(String fromdate,String todate,String id)throws SQLException
	{
		JSONArray gatedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return gatedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(sqlfromdate!=null){
				sqltest+=" and m.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and m.date<='"+sqltodate+"'";
			}
			Statement stmt=conn.createStatement();
			String strsql="select coalesce(veh.srvc_km,0)+coalesce(veh.lst_srv,0) serviceduekm,m.doc_no,m.date,m.brhid,br.branchname,veh.fleet_no,veh.reg_no,veh.flname,case when m.agmtexist=1 and m.newdriver=0 then dr.name when m.agmtexist=0 and m.newdriver=0 then sal.sal_name else m.drivername end driver,"+
			" m.indate,m.intime,m.inkm,CASE WHEN m.infuel=0.000 THEN 'Level 0/8' WHEN m.infuel=0.125 THEN 'Level 1/8' WHEN m.infuel=0.250 THEN"+
			" 'Level 2/8' WHEN m.infuel=0.375 THEN 'Level 3/8' WHEN m.infuel=0.500 THEN 'Level 4/8' WHEN m.infuel=0.625 THEN 'Level 5/8'  WHEN"+
			" m.infuel=0.750 THEN 'Level 6/8' WHEN m.infuel=0.875 THEN 'Level 7/8' WHEN m.infuel=1.000 THEN 'Level 8/8'  END as infuel"+
			"  from gl_workgateinpassm m left join gl_equipmaster veh on m.fleet_no=veh.fleet_no left join gl_drdetails dr on (m.driverid=dr.dr_id and dr.dtype='CRM' and m.agmtexist=1) left join my_salesman sal on (m.driverid=sal.doc_no and sal.sal_type='DRV' and m.agmtexist=0) left join my_brch br on m.brhid=br.doc_no where m.status=3"+sqltest+" order by m.doc_no";
			ResultSet rs=stmt.executeQuery(strsql);
			gatedata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return gatedata;
	}
	
	public JSONArray getGateInPassExcelData(String fromdate,String todate,String id)throws SQLException
	{
		JSONArray gatedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return gatedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(sqlfromdate!=null){
				sqltest+=" and m.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and m.date<='"+sqltodate+"'";
			}
			Statement stmt=conn.createStatement();
			String strsql="select br.branchname 'Branch',m.doc_no 'Doc No',date_format(m.date,'%d.%m.%Y') 'Date',veh.fleet_no 'Fleet No',"+
			" veh.reg_no 'Asset id',veh.flname 'Fleet Name',case when m.agmtexist=1 and m.newdriver=0 then dr.name when m.agmtexist=0 and "+
			" m.newdriver=0 then sal.sal_name else m.drivername end 'Driver',date_format(m.indate,'%d.%m.%Y') 'In Date',m.intime 'In Time',"+
			" round(m.inkm,2) 'In Km',CASE WHEN m.infuel=0.000 THEN 'Level 0/8' WHEN m.infuel=0.125 THEN 'Level 1/8' WHEN m.infuel=0.250 THEN "+
			" 'Level 2/8' WHEN m.infuel=0.375 THEN 'Level 3/8' WHEN m.infuel=0.500 THEN 'Level 4/8' WHEN m.infuel=0.625 THEN 'Level 5/8'  WHEN "+
			" m.infuel=0.750 THEN 'Level 6/8' WHEN m.infuel=0.875 THEN 'Level 7/8' WHEN m.infuel=1.000 THEN 'Level 8/8'  END 'In Fuel',"+
			" round(coalesce(veh.srvc_km,0)+coalesce(veh.lst_srv,0),0) 'Service Due Km'"+
			"  from gl_workgateinpassm m left join gl_equipmaster veh on m.fleet_no=veh.fleet_no left join gl_drdetails dr on (m.driverid=dr.dr_id and dr.dtype='CRM' and m.agmtexist=1) left join my_salesman sal on (m.driverid=sal.doc_no and sal.sal_type='DRV' and m.agmtexist=0) left join my_brch br on m.brhid=br.doc_no where m.status=3"+sqltest+" order by m.doc_no";
			System.out.println("Excel Query:"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			gatedata=objcommon.convertToEXCEL(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return gatedata;
	}
}
