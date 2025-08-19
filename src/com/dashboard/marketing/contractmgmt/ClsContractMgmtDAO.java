package com.dashboard.marketing.contractmgmt;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsContractMgmtDAO {

	ClsConnection objconn = new ClsConnection();
	ClsCommon objcommon = new ClsCommon();

	public JSONArray getContractData(String id, String branch, String fromdate, String todate) throws SQLException {
		JSONArray data = new JSONArray();
		if (!id.equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			String sqlfilters = "";
			java.sql.Date sqlfromdate = null, sqltodate = null;
			if (!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")) {
				sqlfilters += " and m.brhid=" + branch;
			}
			if (!fromdate.trim().equalsIgnoreCase("")) {
				sqlfromdate = objcommon.changeStringtoSqlDate(fromdate);
				sqlfilters += " and m.date>='" + sqlfromdate + "'";
			}
			if (!todate.trim().equalsIgnoreCase("")) {
				sqltodate = objcommon.changeStringtoSqlDate(todate);
				sqlfilters += " and m.date<='" + sqltodate + "'";
			}
			Statement stmt = conn.createStatement();

			String strsql = "select m.date,m.voc_no,br.branchname,m.reftype,m.refno,coalesce(ac.refname,'') clientname,m.lpono,m.lpodate, "
					+ "m.description,coalesce(sal_name,'')salesman,coalesce(d.totalamt,0)totalamt,group_concat(coalesce(eq.reg_no,''))assetid,m.brhid,m.doc_no "
					+ "from gl_rentalcontractm m "
					+ "left join (select sum(nettotal)totalamt,rdocno from gl_rentalcontractd group by rdocno) d on d.rdocno=m.doc_no "
					+ "left join gl_rentalquotecalc calc on m.doc_no=calc.contractdocno "
					+ "left join gl_equipmaster eq on calc.fleet_no=eq.fleet_no "
					+ "left join my_acbook ac on m.cldocno=ac.cldocno and ac.dtype='CRM' "
					+ "left join my_brch br on m.brhid=br.doc_no " + "left join my_salm sm on sm.doc_no=m.salid "
					+ "where m.status=3" + sqlfilters + " group by m.doc_no order by m.date desc,m.doc_no desc";

			ResultSet rs = stmt.executeQuery(strsql);
			data = objcommon.convertToJSON(rs);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return data;
	}

	public JSONArray getContractDetailData(String docno, String id) throws SQLException {
		JSONArray data = new JSONArray();
		if (!id.equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();

			String strsql = "select d.quotedetdocno detaildocno,round(sum(calc.approved)-qotd.outqty+d.qty,2) quoteqty,d.qty,round(coalesce(d.subtotal/d.qty,0),2) rate,subcat.code,subcat.doc_no subcatid,d.hiremode,round(coalesce(d.subtotal,0),2) subtotal,d.equipdesc flname,d.grpid,d.tarifdocno, d.discount, d.maxdiscount, d.total, d.vatperc, d.vatamt, d.nettotal from gl_rentalcontractm m left join gl_rentalcontractd d on m.doc_no=d.rdocno"
					+ " left join gl_tarifd td on (td.gid=d.grpid and td.doc_no=d.tarifdocno and"
					+ " td.renttype=m.hiremode) left join gl_vehsubcategory subcat on d.code=subcat.doc_no left join gl_rentalquoted qotd on d.quotedetdocno=qotd.doc_no left join gl_rentalquotecalc calc on"
					+ " (qotd.doc_no=calc.detdocno and calc.approved=1 and calc.contractdocno=m.doc_no)where m.doc_no="
					+ docno + " and m.status=3 GROUP BY d.doc_no";

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
