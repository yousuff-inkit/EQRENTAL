package com.dashboard.analysis.vehicledetailanalysis;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsVehicleDetailAnalysisDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray getMovData(String id,String fleetno,String fromdate,String todate) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String sqltest="";
			if(fromdate!=null && !fromdate.equalsIgnoreCase("")){
				java.sql.Date sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and mov.date>='"+sqlfromdate+"'";
			}
			if(todate!=null && !todate.equalsIgnoreCase("")){
				java.sql.Date sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and mov.date<='"+sqltodate+"'";
			}
			String strsql="select mov.rdtype reftype,case when mov.rdtype='RAG' then ragmt.voc_no when mov.rdtype='LAG' then lagmt.voc_no else"+
			" mov.rdocno end refno,dout dateout,tout timeout,kmout,CASE WHEN mov.fout=0.000 THEN 'Level 0/8' WHEN mov.fout=0.125 THEN 'Level 1/8' WHEN mov.fout=0.250 THEN 'Level 2/8'"+
			" WHEN mov.fout=0.375 THEN 'Level 3/8' WHEN mov.fout=0.500 THEN 'Level 4/8' WHEN mov.fout=0.625 THEN 'Level 5/8'  WHEN mov.fout=0.750"+
			" THEN 'Level 6/8' WHEN mov.fout=0.875 THEN 'Level 7/8' WHEN mov.fout=1.000 THEN 'Level 8/8'  END fuelout,din datein,tin timein,kmin,CASE WHEN mov.fin=0.000 THEN 'Level 0/8' WHEN mov.fin=0.125 THEN 'Level 1/8' WHEN mov.fin=0.250 THEN 'Level 2/8'"+
			" WHEN mov.fin=0.375 THEN 'Level 3/8' WHEN mov.fin=0.500 THEN 'Level 4/8' WHEN mov.fin=0.625 THEN 'Level 5/8'  WHEN mov.fin=0.750"+
			" THEN 'Level 6/8' WHEN mov.fin=0.875 THEN 'Level 7/8' WHEN mov.fin=1.000 THEN 'Level 8/8'  END fuelin from gl_vmove mov"+
			" left join gl_ragmt ragmt on (mov.rdtype='RAG' and ragmt.doc_no=mov.rdocno)"+
			" left join gl_lagmt lagmt on (mov.rdtype='LAG' and lagmt.doc_no=mov.rdocno)"+
			" where mov.fleet_no="+fleetno+" "+sqltest+" order by mov.doc_no";
			System.out.println(strsql);
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
			conn.close();
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
	
	public JSONArray getAccData(String id,String fleetno,String fromdate,String todate) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String sqltest="";
			if(fromdate!=null && !fromdate.equalsIgnoreCase("")){
				java.sql.Date sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and acdate>='"+sqlfromdate+"'";
			}
			if(todate!=null && !todate.equalsIgnoreCase("")){
				java.sql.Date sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and acdate<='"+sqltodate+"'";
			}
			String strsql="select acdate accdate,polrep prcs,coldate collectdate,place,fine,case when "+
			" claim='1' then 'Own' else 'Third Party' end claim from gl_vinspm where accident=1 and "+
			" rfleet="+fleetno+" and status=3 "+sqltest+" order by doc_no";
			
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
			conn.close();
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
	
	public JSONArray getMaintenanceData(String id,String fleetno,String fromdate,String todate) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String sql="",sql1="";
			if(fromdate!=null && !fromdate.equalsIgnoreCase("")){
				java.sql.Date sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sql+=" and m.date>='"+sqlfromdate+"'";
			}
			if(todate!=null && !todate.equalsIgnoreCase("")){
				java.sql.Date sqltodate=objcommon.changeStringtoSqlDate(todate);
				sql+=" and m.date<='"+sqltodate+"'";
			}
			String dtype="ALL";
			if(!((dtype.equalsIgnoreCase("")) || (dtype.equalsIgnoreCase("0")))){
				if(dtype.equalsIgnoreCase("MRQ")){
					sql1+="'MAINTANENCE REQUIRED' status,";
					sql+=" and m.wostatus=0 and m.apstatus=0 and m.psstatus=0";
				}else if(dtype.equalsIgnoreCase("MWO")){
					sql1+="'WORK ORDER' status,";
					sql+=" and m.wostatus=1 and m.apstatus=0 and m.psstatus=0";
				}else if(dtype.equalsIgnoreCase("MAP")){
					sql1+="'JOB APPROVAL' status,";
					sql+=" and m.wostatus=1 and m.apstatus=1 and m.psstatus=0";
				}else if(dtype.equalsIgnoreCase("MPO")){
					sql1+="'POSTING' status,";
					sql+=" and m.wostatus=1 and m.apstatus=1 and m.psstatus=1";
				}else{
					sql1+="case when m.wostatus=0 and m.apstatus=0 and m.psstatus=0 then 'MAINTANENCE REQUIRED' when m.wostatus=1 and m.apstatus=0 and m.psstatus=0 "
					+ "then 'WORK ORDER' when m.wostatus=1 and m.apstatus=1 and m.psstatus=0 then 'JOB APPROVAL' when m.wostatus=1 and m.apstatus=1 and "
					+ "m.psstatus=1 then 'POSTING' END as 'status',";
				}
			}
  
  sql = "select "+sql1+"m.voc_no docno,m.date,m.fleetno,UCASE(m.mtype) type,v.reg_no,v.flname,g.name garage,b.branchname,CONVERT(CONCAT(m.wostatus,m.apstatus,m.psstatus),CHAR(50)) checks,m.tlabcost labour,m.tpartcost spares,m.tcost total from gl_vmcostm m left join "
  	+ "gl_vehmaster v on m.fleetno=v.fleet_no left join gl_garrage g on m.gargid=g.doc_no left join my_brch b on m.brhid=b.doc_no where m.status=3 and m.dtype='MWO' and m.fleetno="+fleetno+" "+sql+"";
			System.out.println(sql);
			ResultSet rs=conn.createStatement().executeQuery(sql);
			data=objcommon.convertToJSON(rs);
			conn.close();
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
	
	public JSONArray getDeprData(String id,String fleetno,String fromdate,String todate) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String sqltest="";
			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			if(fromdate!=null && !fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(todate!=null && !todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			
			String strsql="select a.fleet_no,a.date,CONVERT(if(a.dramount>0,a.dramount,''),CHAR(100)) debit,CONVERT(if(a.dramount<0,a.dramount*-1,''),CHAR(100)) credit,"
		    		 + "a.ttype,a.acno,v.reg_no,v.flname,p.code_name,t.account,t.description acname,(select round(coalesce(sum(dramount),0),2) from gc_assettran where fleet_no="+fleetno+" and "
		    		 + "date<='"+sqltodate+"') bookvalue from gc_assettran a left join gl_vehmaster v on a.fleet_no=v.fleet_no left join gl_vehplate p on "
		    		 + "v.pltid=p.doc_no left join my_head t on a.acno=t.doc_no where a.fleet_no="+fleetno+" and a.date<='"+sqltodate+"'";
		     
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
			conn.close();
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
	
	public JSONArray getIncomeData(String id,String fleetno,String fromdate,String todate) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String sqltest="";
			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			if(fromdate!=null && !fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and jv.date>='"+sqlfromdate+"'";
			}
			if(todate!=null && !todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and jv.date<='"+sqltodate+"'";
			}
			
			String strsql="select jv.date,head.account,head.description acname,cost.amount from my_costtran cost left join my_jvtran jv on (jv.tranid=cost.tranid) left join my_head head on head.doc_no=cost.acno"+
			" where head.gr_type=5 and cost.jobid="+fleetno+" "+sqltest+" order by jv.tranid";
		     
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
			conn.close();
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
}

