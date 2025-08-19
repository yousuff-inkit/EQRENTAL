package com.dashboard.leaseagreement.leaseagmttarifchange;

import java.sql.*;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsLeaseAgmtTarifChangeDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getAgmtData(String branch,String fromdate,String todate,String cldocno,String agmtno,String datetype,String id) throws SQLException{
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
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and agmt.brhid="+branch;
			}
			if(datetype.equalsIgnoreCase("1")){
				if(sqlfromdate!=null){
					sqltest+=" and agmt.date>='"+sqlfromdate+"'";
				}
				if(sqltodate!=null){
					sqltest+=" and agmt.date<='"+sqltodate+"'";
				}
			}
			if(datetype.equalsIgnoreCase("2")){
				if(sqlfromdate!=null){
					sqltest+=" and agmt.outdate>='"+sqlfromdate+"'";
				}
				if(sqltodate!=null){
					sqltest+=" and agmt.outdate<='"+sqltodate+"'";
				}
			}
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and agmt.cldocno="+cldocno;
			}
			if(!agmtno.equalsIgnoreCase("")){
				sqltest+=" and agmt.doc_no="+agmtno;
			}
			
			String strsql="select agmt.clstatus,br.branchname,agmt.doc_no,agmt.voc_no,agmt.brhid,agmt.date,agmt.cldocno,veh.fleet_no perfleet,"+
			" agmt.outdate,ac.refname,veh.reg_no,veh.flname from gl_lagmt agmt left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') "+
			" left join my_brch br on (agmt.brhid=br.doc_no) left join gl_vehmaster veh on (agmt.perfleet=veh.fleet_no or agmt.tmpfleet=veh.fleet_no) "+
			" where agmt.status=3 and agmt.clstatus=0"+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
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
	
	public JSONArray getTarifData(String agmtdocno,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select rate,cdw,pai,cdw1,pai1,gps,babyseater,cooler,kmrest ,exkmrte ,chaufchg ,"+
        	" chaufexchg  from gl_ltarif where rdocno="+agmtdocno;
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
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
	
	public JSONArray getClientData(String id) throws SQLException{
		JSONArray clientdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return clientdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select ac.refname,ac.cldocno,ac.address,ac.per_mob,ac.mail1 from my_acbook ac where ac.dtype='CRM' and ac.status=3";
			ResultSet rs=stmt.executeQuery(strsql);
			clientdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return clientdata;
	}
	
	public JSONArray getAgmtSearchData(String id) throws SQLException{
		JSONArray agmtdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return agmtdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select agmt.doc_no,agmt.voc_no,agmt.date,veh.fleet_no perfleet,agmt.outdate,veh.reg_no,veh.flname from gl_lagmt agmt "+
			" left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on ((agmt.perfleet=veh.fleet_no) or"+
			" (agmt.perfleet=0 and agmt.tmpfleet=veh.fleet_no)) where agmt.status=3 and agmt.clstatus=0";
			ResultSet rs=stmt.executeQuery(strsql);
			agmtdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return agmtdata;
	}
}
