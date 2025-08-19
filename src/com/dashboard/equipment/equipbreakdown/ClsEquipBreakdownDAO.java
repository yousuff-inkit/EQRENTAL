package com.dashboard.equipment.equipbreakdown;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEquipBreakdownDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getContractData(String brhid,String fromdate,String todate,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqlfilters="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!brhid.trim().equalsIgnoreCase("") && !brhid.trim().equalsIgnoreCase("a")){
				sqlfilters+=" and m.brhid="+brhid;
			}
			if(!fromdate.trim().equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqlfilters+=" and m.date>='"+sqlfromdate+"'";
			}
			if(!todate.trim().equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqlfilters+=" and m.date<='"+sqltodate+"'";
			}
			
			String strsql="select eq.startdate,eq.starttime,case when eq.clstatus=0 then 'Started' when eq.clstatus=1 then 'Ended' else '' end strstatus,coalesce(eq.clstatus,0) eqclstatus,coalesce(eq.doc_no,0) eqdocno,calc.doc_no calcdocno,m.doc_no,m.voc_no,m.date,m.cldocno,m.hiremode,ac.refname,calc.currentfleetno,veh.flname from gl_rentalcontractm m"+
			" left join gl_rentalquotecalc calc on m.doc_no=calc.contractdocno"+
			" left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM')"+
			" left join gl_equipmaster veh on calc.currentfleetno=veh.fleet_no"+
			" left join (select max(doc_no) maxdocno,calcdocno from eq_breakdown group by calcdocno) eqmax on (eqmax.calcdocno=calc.doc_no)"+
			" left join eq_breakdown eq on eqmax.maxdocno=eq.doc_no"+
			" where m.clstatus=0 and m.status=3"+sqlfilters;
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
