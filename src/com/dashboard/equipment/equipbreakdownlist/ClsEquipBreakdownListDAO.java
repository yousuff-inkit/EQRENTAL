package com.dashboard.equipment.equipbreakdownlist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEquipBreakdownListDAO {

	ClsConnection objconn = new ClsConnection();  
	ClsCommon objcommon = new ClsCommon();

	public JSONArray getEquipBreakdownData(String brhid, String fromdate,
			String todate, String id) throws SQLException {
		JSONArray data = new JSONArray();
		if (!id.equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			String sqlfilters = "";
			java.sql.Date sqlfromdate = null, sqltodate = null;
			if (!brhid.trim().equalsIgnoreCase("")
					&& !brhid.trim().equalsIgnoreCase("a")) {
				sqlfilters += " and m.brhid=" + brhid;
			}
			if (!fromdate.trim().equalsIgnoreCase("")) {
				sqlfromdate = objcommon.changeStringtoSqlDate(fromdate);
				sqlfilters += " and bd.date>='" + sqlfromdate + "'";
			}
			if (!todate.trim().equalsIgnoreCase("")) {
				sqltodate = objcommon.changeStringtoSqlDate(todate);
				sqlfilters += " and bd.date<='" + sqltodate + "'";
			}
			
			String strsql = "select m.voc_no,m.date,calc.currentfleetno,veh.flname ,ac.refname,m.hiremode,"
					+ "case when eq.clstatus=0 then 'Started' when eq.clstatus=1 then 'Ended' else '' end strstatus,"
					+ "bd.startdate,bd.starttime,coalesce(bd.startremarks,'')startremarks,bd.enddate,bd.endtime,coalesce(bd.endremarks,'')endremarks,bd.amount "
					+ "from gl_rentalcontractm m "
					+ "inner join eq_breakdown bd on bd.contractdocno=m.doc_no and m.brhid=bd.brhid "
					+ "left join gl_rentalquotecalc calc on m.doc_no=calc.contractdocno "
					+ "left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') "
					+ "left join gl_equipmaster veh on calc.currentfleetno=veh.fleet_no "
					+ "left join (select max(doc_no) maxdocno,calcdocno from eq_breakdown group by calcdocno) eqmax on (eqmax.calcdocno=calc.doc_no) "
					+ "left join eq_breakdown eq on eqmax.maxdocno=eq.doc_no "
					+ "where m.clstatus=0 and m.status=3 "+sqlfilters;

			//System.out.println(strsql);

			ResultSet rs = stmt.executeQuery(strsql);
			data = objcommon.convertToJSON(rs);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return data;
	}

}
