package com.dashboard.workshop.serviceadvisor;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsServiceAdvisorDAO {

	ClsConnection objconn = new ClsConnection();
	ClsCommon objcommon = new ClsCommon();

	public JSONArray getGateInPassData(String fromdate, String todate,
			String branch, String id) throws SQLException {
		JSONArray gatedata = new JSONArray();
		if (!id.equalsIgnoreCase("1")) {
			return gatedata;
		}
		Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			java.sql.Date sqlfromdate = null, sqltodate = null;
			if (!fromdate.equalsIgnoreCase("") && fromdate != null) {
				sqlfromdate = objcommon.changeStringtoSqlDate(fromdate);
			}
			if (!todate.equalsIgnoreCase("") && todate != null) {
				sqltodate = objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest = "";
			if (sqlfromdate != null) {
				sqltest += " and m.date>='" + sqlfromdate + "'";
			}
			if (sqltodate != null) {
				sqltest += " and m.date<='" + sqltodate + "'";
			}
			if (!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")) {
				sqltest += " and m.brhid=" + branch;
			}
			Statement stmt = conn.createStatement();
			/*
			 * String strsql=
			 * "select coalesce(veh.srvc_km,0)+coalesce(veh.lst_srv,0) serviceduekm,m.processstatus,m.doc_no,m.date,m.brhid,br.branchname,"
			 * +
			 * " veh.fleet_no,veh.reg_no,veh.flname,case when m.agmtexist=1 and m.newdriver=0 then dr.name when m.agmtexist=0 and m.newdriver=0 then sal.sal_name else m.drivername end driver,"
			 * +
			 * " m.indate,m.intime,m.inkm,CASE WHEN m.infuel=0.000 THEN 'Level 0/8' WHEN m.infuel=0.125 THEN 'Level 1/8' WHEN m.infuel=0.250 THEN"
			 * +
			 * " 'Level 2/8' WHEN m.infuel=0.375 THEN 'Level 3/8' WHEN m.infuel=0.500 THEN 'Level 4/8' WHEN m.infuel=0.625 THEN 'Level 5/8'  WHEN"
			 * +
			 * " m.infuel=0.750 THEN 'Level 6/8' WHEN m.infuel=0.875 THEN 'Level 7/8' WHEN m.infuel=1.000 THEN 'Level 8/8'  END as infuel,"
			 * +
			 * " sm.technicianid, sm.bayid, tc.name technician, bay.name bay, sm.doc_no smdocno"
			 * +
			 * "  from gl_workgateinpassm m left join gl_vehmaster veh on m.fleet_no=veh.fleet_no left join gl_drdetails dr on (m.driverid=dr.dr_id and dr.dtype='CRM' and m.agmtexist=1) "
			 * +
			 * " left join my_salesman sal on (m.driverid=sal.doc_no and sal.sal_type='DRV' and m.agmtexist=0) "
			 * +
			 * " left join my_brch br on m.brhid=br.doc_no left join gl_worksrvcadvisorm sm on (sm.gateinpassdocno=m.doc_no and m.brhid=)"
			 * +
			 * " left join gl_worktechnician tc on (tc.doc_no = sm.technicianid) left join gl_workbay bay on (bay.doc_no = sm.bayid)"
			 * +" where m.status=3 and m.processstatus in (1,2) "+sqltest+
			 * " order by m.doc_no";
			 */

			String strsql = "select coalesce(veh.srvc_km,0)+coalesce(veh.lst_srv,0) serviceduekm,m.processstatus,m.doc_no,m.date,m.brhid,br.branchname,"
					+ " veh.fleet_no,veh.reg_no,veh.flname,case when m.agmtexist=1 and m.newdriver=0 then dr.name when m.agmtexist=0 and m.newdriver=0 then sal.sal_name else m.drivername end driver,"
					+ " m.indate,m.intime,m.inkm,CASE WHEN m.infuel=0.000 THEN 'Level 0/8' WHEN m.infuel=0.125 THEN 'Level 1/8' WHEN m.infuel=0.250 THEN"
					+ " 'Level 2/8' WHEN m.infuel=0.375 THEN 'Level 3/8' WHEN m.infuel=0.500 THEN 'Level 4/8' WHEN m.infuel=0.625 THEN 'Level 5/8'  WHEN"
					+ " m.infuel=0.750 THEN 'Level 6/8' WHEN m.infuel=0.875 THEN 'Level 7/8' WHEN m.infuel=1.000 THEN 'Level 8/8'  END as infuel,"
					+ " sm.technicianid, sm.bayid, tc.name technician, bay.name bay, sm.doc_no smdocno"
					+ " from gl_workgateinpassm m left join gl_equipmaster veh on m.fleet_no=veh.fleet_no left join gl_drdetails dr on (m.driverid=dr.dr_id and dr.dtype='CRM' and m.agmtexist=1) "
					+ " left join my_salesman sal on (m.driverid=sal.doc_no and sal.sal_type='DRV' and m.agmtexist=0) "
					+ " left join my_brch br on m.brhid=br.doc_no left join (select max(doc_no) srvcmaxdoc,gateinpassdocno,brhid from gl_worksrvcadvisorm group by gateinpassdocno,brhid) sm1 on (sm1.gateinpassdocno=m.doc_no and sm1.brhid=m.brhid) left join gl_worksrvcadvisorm sm on (sm1.srvcmaxdoc=sm.doc_no)"
					+ " left join gl_worktechnician tc on (tc.doc_no = sm.technicianid) left join gl_workbay bay on (bay.doc_no = sm.bayid)"
					+ " where m.status=3 and m.processstatus in (1,2) "
					+ sqltest + " order by m.doc_no";
			ResultSet rs = stmt.executeQuery(strsql);
			gatedata = objcommon.convertToJSON(rs);
			stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return gatedata;
	}

	public JSONArray getGateInPassExcelData(String fromdate, String todate,
			String branch, String id) throws SQLException {
		JSONArray gatedata = new JSONArray();
		if (!id.equalsIgnoreCase("1")) {
			return gatedata;
		}
		Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			java.sql.Date sqlfromdate = null, sqltodate = null;
			if (!fromdate.equalsIgnoreCase("") && fromdate != null) {
				sqlfromdate = objcommon.changeStringtoSqlDate(fromdate);
			}
			if (!todate.equalsIgnoreCase("") && todate != null) {
				sqltodate = objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest = "";
			if (sqlfromdate != null) {
				sqltest += " and m.date>='" + sqlfromdate + "'";
			}
			if (sqltodate != null) {
				sqltest += " and m.date<='" + sqltodate + "'";
			}
			if (!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")) {
				sqltest += " and m.brhid=" + branch;
			}
			Statement stmt = conn.createStatement();
			/*
			 * String strsql=
			 * "select coalesce(veh.srvc_km,0)+coalesce(veh.lst_srv,0) serviceduekm,m.processstatus,m.doc_no,m.date,m.brhid,br.branchname,"
			 * +
			 * " veh.fleet_no,veh.reg_no,veh.flname,case when m.agmtexist=1 and m.newdriver=0 then dr.name when m.agmtexist=0 and m.newdriver=0 then sal.sal_name else m.drivername end driver,"
			 * +
			 * " m.indate,m.intime,m.inkm,CASE WHEN m.infuel=0.000 THEN 'Level 0/8' WHEN m.infuel=0.125 THEN 'Level 1/8' WHEN m.infuel=0.250 THEN"
			 * +
			 * " 'Level 2/8' WHEN m.infuel=0.375 THEN 'Level 3/8' WHEN m.infuel=0.500 THEN 'Level 4/8' WHEN m.infuel=0.625 THEN 'Level 5/8'  WHEN"
			 * +
			 * " m.infuel=0.750 THEN 'Level 6/8' WHEN m.infuel=0.875 THEN 'Level 7/8' WHEN m.infuel=1.000 THEN 'Level 8/8'  END as infuel,"
			 * +
			 * " sm.technicianid, sm.bayid, tc.name technician, bay.name bay, sm.doc_no smdocno"
			 * +
			 * "  from gl_workgateinpassm m left join gl_vehmaster veh on m.fleet_no=veh.fleet_no left join gl_drdetails dr on (m.driverid=dr.dr_id and dr.dtype='CRM' and m.agmtexist=1) "
			 * +
			 * " left join my_salesman sal on (m.driverid=sal.doc_no and sal.sal_type='DRV' and m.agmtexist=0) "
			 * +
			 * " left join my_brch br on m.brhid=br.doc_no left join gl_worksrvcadvisorm sm on (sm.gateinpassdocno=m.doc_no and m.brhid=)"
			 * +
			 * " left join gl_worktechnician tc on (tc.doc_no = sm.technicianid) left join gl_workbay bay on (bay.doc_no = sm.bayid)"
			 * +" where m.status=3 and m.processstatus in (1,2) "+sqltest+
			 * " order by m.doc_no";
			 */

			String strsql = "select br.branchname 'Branch',m.doc_no 'Doc No',date_format(m.date,'%d.%m.%Y') 'Date',veh.fleet_no 'Fleet No',veh.reg_no "
					+ " 'Asset id',veh.flname 'Fleet Name',case when m.agmtexist=1 and m.newdriver=0 then dr.name when m.agmtexist=0 and m.newdriver=0"
					+ " then sal.sal_name else m.drivername end 'Driver',date_format(m.indate,'%d.%m.%Y') 'In Date',m.intime 'In Time',round(m.inkm,0)"
					+ " 'In Km',CASE WHEN m.infuel=0.000 THEN 'Level 0/8' WHEN m.infuel=0.125 THEN 'Level 1/8' WHEN m.infuel=0.250 THEN 'Level 2/8' WHEN"
					+ " m.infuel=0.375 THEN 'Level 3/8' WHEN m.infuel=0.500 THEN 'Level 4/8' WHEN m.infuel=0.625 THEN 'Level 5/8'  WHEN m.infuel=0.750"
					+ " THEN 'Level 6/8' WHEN m.infuel=0.875 THEN 'Level 7/8' WHEN m.infuel=1.000 THEN 'Level 8/8'  END 'End Fuel',"
					+ " round(coalesce(veh.srvc_km,0)+coalesce(veh.lst_srv,0),0) 'Service Due Km' "
					+ "  from gl_workgateinpassm m left join gl_equipmaster veh on m.fleet_no=veh.fleet_no left join gl_drdetails dr on (m.driverid=dr.dr_id and dr.dtype='CRM' and m.agmtexist=1) "
					+ " left join my_salesman sal on (m.driverid=sal.doc_no and sal.sal_type='DRV' and m.agmtexist=0) "
					+ " left join my_brch br on m.brhid=br.doc_no left join (select max(doc_no) srvcmaxdoc,gateinpassdocno,brhid from gl_worksrvcadvisorm group by gateinpassdocno,brhid) sm1 on (sm1.gateinpassdocno=m.doc_no and sm1.brhid=m.brhid) left join gl_worksrvcadvisorm sm on (sm1.srvcmaxdoc=sm.doc_no)"
					+ " left join gl_worktechnician tc on (tc.doc_no = sm.technicianid) left join gl_workbay bay on (bay.doc_no = sm.bayid)"
					+ " where m.status=3 and m.processstatus in (1,2) "
					+ sqltest + " order by m.doc_no";
			System.out.println(strsql);
			ResultSet rs = stmt.executeQuery(strsql);
			gatedata = objcommon.convertToEXCEL(rs);
			stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return gatedata;
	}

	public JSONArray getComplaintData(String brhid, String docno, String id,
			String processstatus) throws SQLException {
		JSONArray complaintdata = new JSONArray();
		if (!id.equalsIgnoreCase("1")) {
			return complaintdata;
		}
		Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			String sqltest = "";
			if (!brhid.equalsIgnoreCase("")) {
				sqltest += " and det.brhid=" + brhid;
			}
			if (!docno.equalsIgnoreCase("")) {
				sqltest += " and det.rdocno=" + docno;
			}
			String strsql = "";
			if (processstatus.equalsIgnoreCase("2")) {
				strsql = "select det.srno complaintdocno,com.compname complaint from gl_workgateinpassd det left join gl_complaint com on det.complaintid=com.doc_no where det.status=3"
						+ sqltest + " order by det.srno";
			} else {
				strsql = "select det.srno complaintdocno,com.compname complaint from gl_workgateinpassd det left join gl_complaint com on det.complaintid=com.doc_no where det.status=3"
						+ sqltest + " order by det.srno";
			}

			ResultSet rs = stmt.executeQuery(strsql);
			complaintdata = objcommon.convertToJSON(rs);
			stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return complaintdata;
	}

	public JSONArray getMaintenanceData(String id, String processstatus,
			String gateinpassdocno, String smdocno) throws SQLException {
		JSONArray maintenancedata = new JSONArray();
		if (!id.equalsIgnoreCase("1")) {
			return maintenancedata;
		}
		Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			String strsql = "";
			if (processstatus.equalsIgnoreCase("2")) {

				strsql = "select maint.docno maintenancedocno, maint.mtype maintenance, maint.name description,maint.date from gl_worksrvcadvisormaint m left"
						+ " join gl_vrepm maint on m.maintenancedocno=maint.docno where m.status=3 and m.gateinpassdocno="
						+ gateinpassdocno + " and m.rdocno=" + smdocno;
			} else {
				strsql = "select docno maintenancedocno, mtype maintenance, name description,date from gl_vrepm where status=3 order by docno";
			}
			System.out.println(strsql);
			ResultSet rs = stmt.executeQuery(strsql);
			maintenancedata = objcommon.convertToJSON(rs);
			stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return maintenancedata;
	}

	public JSONArray getPartsData(String id, String partno, String prdctnme,
			String stock, String unit, String brand, String cat, String subcat)
			throws SQLException {
		JSONArray partsdata = new JSONArray();
		if (!id.equalsIgnoreCase("1")) {
			return partsdata;
		}
		Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			String sqltest = "";
			// System.out.println("++++++++++"+unit);
			if (!(partno.equalsIgnoreCase("undefined"))
					&& !(partno.equalsIgnoreCase(""))
					&& !(partno.equalsIgnoreCase("0"))) {
				sqltest += sqltest + " and a.partno like '%" + partno + "%'";
			}
			if (!(prdctnme.equalsIgnoreCase("undefined"))
					&& !(prdctnme.equalsIgnoreCase(""))
					&& !(prdctnme.equalsIgnoreCase("0"))) {
				sqltest += sqltest + " and a.productname like '%" + prdctnme
						+ "%'";
			}
			if (!(stock.equalsIgnoreCase("undefined"))
					&& !(stock.equalsIgnoreCase(""))
					&& !(stock.equalsIgnoreCase("0"))) {
				sqltest += sqltest + " and a.balqty like '%" + stock + "%'";
			}
			if (!(unit.equalsIgnoreCase("undefined"))
					&& !(unit.equalsIgnoreCase(""))
					&& !(unit.equalsIgnoreCase("0"))) {
				sqltest += sqltest + " and a.unit like '%" + unit + "%'";
			}
			if (!(brand.equalsIgnoreCase(""))) {
				sqltest = sqltest + " and a.brand like '%" + brand + "%'";
			}
			if (!(cat.equalsIgnoreCase(""))) {
				sqltest = sqltest + " and a.category like '%" + cat + "%' ";
			}
			if (!(subcat.equalsIgnoreCase(""))) {
				sqltest = sqltest + " and a.subcategory like '%" + subcat
						+ "%'";
			}

			String strsql = "select * from ( select m.psrno partdocno,m.part_no partno,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,'' qty,sum(i.out_qty)"
					+ " outqty,coalesce(sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)),0) as balqty,sum(i.op_qty) as totqty,i.stockid as stkid,i.cost_price unitprice,"
					+ " bd.brandname brand,c.category,s.subcategory"
					+ " from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ " left join  my_brand bd on m.brandid=bd.doc_no left join my_catm c on(m.catid=c.doc_no) left join my_scatm s on(m.scatid=s.doc_no)"
					+ " left join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno)"
					+ " where m.status=3 group by i.prdid  order by i.date) a where 1=1 "
					+ sqltest + " ";

			System.out.println("--" + strsql);

			ResultSet rs = stmt.executeQuery(strsql);
			partsdata = objcommon.convertToJSON(rs);
			stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return partsdata;
	}

	public JSONArray getPartsData(String id, String processstatus,
			String docno, String smdocno, String brhid) throws SQLException {
		JSONArray partsdata = new JSONArray();
		if (!id.equalsIgnoreCase("1")) {
			return partsdata;
		}
		Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			String sqltest = "";
			// System.out.println("++++++++++"+unit);

			/*
			 * String strsql=
			 * "select * from ( select m.psrno partdocno,m.part_no partno,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,'' qty,sum(i.out_qty)"
			 * +
			 * " outqty,coalesce(sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)),0) as balqty,sum(i.op_qty) as totqty,i.stockid as stkid,i.cost_price unitprice"
			 * +
			 * " from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd"
			 * +
			 * " on m.brandid=bd.doc_no left join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno)"
			 * +
			 * " where m.status=3 group by i.prdid  order by i.date) a where 1=1 "
			 * +sqltest+" ";
			 */
			String strsql = "";
			if (processstatus.equalsIgnoreCase("2")) {
				/*
				 * strsql=
				 * "select * from ( select m.psrno partdocno,m.part_no partno,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,parts.qty,"
				 * +
				 * " sum(i.out_qty) outqty,coalesce(sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)),0) as balqty,sum(i.op_qty) as totqty,i.stockid as"
				 * +
				 * " stkid,i.cost_price unitprice from (select sum(qty) qty,productdocno from gl_worksrvcadvisorparts where gateinpassdocno="
				 * +docno+" and brhid="+brhid+
				 * "  group by productdocno  )  parts left join my_main m on parts.productdocno=m.psrno left join my_unitm u "
				 * +
				 * " on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join my_prddin i "
				 * +
				 * " on (i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno) where m.status=3 group by i.prdid  "
				 * + " order by i.date) a where 1=1";
				 */

				strsql = "select * from ( select m.psrno partdocno,m.part_no partno,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,parts.qty,p.qty balqty,issueqty,coalesce(at.mspecno,0) as specid from "
						+ " gl_worksrvcadvisorm sm left join (select sum(qty) qty,sum(issueqty) issueqty,productdocno,rdocno,brhid from gl_worksrvcadvisorparts  group by productdocno,rdocno  )  parts on (sm.doc_no=parts.rdocno and sm.brhid=parts.brhid) left join my_main m on parts.productdocno=m.psrno left join my_unitm u  on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
						+ "left join (select sum(op_qty-(out_qty+del_qty+rsv_qty)) qty,prdid from my_prddin where op_qty-(out_qty+del_qty+rsv_qty)!=0 and brhid="
						+ brhid
						+ " group by prdid) p on p.prdid=parts.productdocno   where sm.gateinpassdocno="
						+ docno + " and sm.brhid=" + brhid + " ) a ";
				System.out.println("Parts SQL:" + strsql);

				ResultSet rs = stmt.executeQuery(strsql);
				partsdata = objcommon.convertToJSON(rs);
				stmt.close();
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return partsdata;
	}

	public JSONArray getTechnicianData(String id) throws SQLException {
		JSONArray techniciandata = new JSONArray();
		if (!id.equalsIgnoreCase("1")) {
			return techniciandata;
		}
		Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			String strsql = "select doc_no techniciandocno,code techniciancode,name technicianname from gl_worktechnician where status=3 order by doc_no";
			ResultSet rs = stmt.executeQuery(strsql);
			techniciandata = objcommon.convertToJSON(rs);
			stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return techniciandata;
	}

	public JSONArray getBayData(String id, String branch) throws SQLException {
		JSONArray baydata = new JSONArray();
		if (!id.equalsIgnoreCase("1")) {
			return baydata;
		}
		Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			String sqltest = "";
			if (!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")) {
				sqltest += " and bay.brhid=" + branch;
			}
			String strsql = "select bay.doc_no baydocno,br.branchname,bay.code baycode,bay.name bayname from gl_workbay bay left join my_brch br on bay.brhid=br.doc_no where bay.status=3 "
					+ sqltest + " order by bay.doc_no";
			System.out.println("------------- "+strsql);
			ResultSet rs = stmt.executeQuery(strsql);
			baydata = objcommon.convertToJSON(rs);
			stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return baydata;
	}

	public int insert(String hidbay, String hidtechnician,
			String gateinpassdocno, ArrayList<String> partsarray,
			ArrayList<String> maintenancearray, HttpSession session,
			HttpServletRequest request, String mode, String estimatedtime,
			java.sql.Date sqlestdate, int processstatus, int smdocno,
			String branchid) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn = null;
		int docno = 0;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			conn.setAutoCommit(false);
			int errorstatus = 0;
			if (processstatus != 2) {
				String strmaxdocno = "select coalesce(max(doc_no)+1,1) maxdoc from gl_worksrvcadvisorm";
				ResultSet rsmaxdocno = stmt.executeQuery(strmaxdocno);
				while (rsmaxdocno.next()) {
					docno = rsmaxdocno.getInt("maxdoc");
				}
				// String branchid=session.getAttribute("BRANCHID").toString();
				String userid = session.getAttribute("USERID").toString();
				String strmasterinsert = "insert into gl_worksrvcadvisorm(doc_no,brhid,userid,date,technicianid,bayid,gateinpassdocno,status,esttime,estdate)values("
						+ " "
						+ docno
						+ ","
						+ branchid
						+ ","
						+ userid
						+ ",CURDATE(),"
						+ hidtechnician
						+ ","
						+ hidbay
						+ ","
						+ gateinpassdocno
						+ ",3,'"
						+ estimatedtime
						+ "','"
						+ sqlestdate + "')";
				int masterinsert = stmt.executeUpdate(strmasterinsert);
				if (masterinsert <= 0) {
					errorstatus = 1;
				}
				for (int i = 0; i < partsarray.size(); i++) {
					String temp[] = partsarray.get(i).split("::");
					String strinsertparts = "insert into gl_worksrvcadvisorparts(rdocno,gateinpassdocno,productdocno,qty,status,brhid)values("
							+ " "
							+ docno
							+ ","
							+ gateinpassdocno
							+ ","
							+ (temp[0].trim().equalsIgnoreCase("undefined")
									|| temp[0].trim().equalsIgnoreCase("NaN")
									|| temp[0].trim().isEmpty() ? 0 : temp[0]
									.trim()).toString()
							+ ","
							+ " "
							+ (temp[1].trim().equalsIgnoreCase("undefined")
									|| temp[1].trim().equalsIgnoreCase("NaN")
									|| temp[1].trim().isEmpty() ? 0 : temp[1]
									.trim()).toString()
							+ ",3,"
							+ branchid
							+ ")";

					int insertparts = stmt.executeUpdate(strinsertparts);
					if (insertparts <= 0) {
						errorstatus = 1;
						break;
					}
				}

				for (int i = 0; i < maintenancearray.size(); i++) {
					String maintenancedocno = maintenancearray.get(i);
					String strinsertmaintenance = "insert into gl_worksrvcadvisormaint(rdocno,maintenancedocno,gateinpassdocno,status,brhid)values("
							+ " "
							+ docno
							+ ","
							+ maintenancedocno
							+ ","
							+ gateinpassdocno + ",3," + branchid + ")";
					int insertmaintenance = stmt
							.executeUpdate(strinsertmaintenance);
					if (insertmaintenance <= 0) {
						errorstatus = 1;
						break;
					}
				}
				String strupdateprocess = "update gl_workgateinpassm set processstatus=2 where doc_no="
						+ gateinpassdocno + " and brhid=" + branchid;
				int updateprocess = stmt.executeUpdate(strupdateprocess);
				if (updateprocess < 0) {
					errorstatus = 1;
				}

				if (errorstatus != 1) {
					conn.commit();
					return docno;
				}
			} else {
				docno = smdocno;
				String delparts = "delete from gl_worksrvcadvisorparts where gateinpassdocno="
						+ gateinpassdocno
						+ " and rdocno="
						+ smdocno
						+ " and brhid=" + branchid;
				int delpartsstatus = stmt.executeUpdate(delparts);
				System.out.println("\\\\\\\\\\" + delpartsstatus + "---"
						+ delparts);
				for (int i = 0; i < partsarray.size(); i++) {
					String temp[] = partsarray.get(i).split("::");

					String strinsertparts = "insert into gl_worksrvcadvisorparts(rdocno,gateinpassdocno,productdocno,qty,status,brhid)values("
							+ " "
							+ docno
							+ ","
							+ gateinpassdocno
							+ ","
							+ (temp[0].trim().equalsIgnoreCase("undefined")
									|| temp[0].trim().equalsIgnoreCase("NaN")
									|| temp[0].trim().isEmpty() ? 0 : temp[0]
									.trim()).toString()
							+ ","
							+ " "
							+ (temp[1].trim().equalsIgnoreCase("undefined")
									|| temp[1].trim().equalsIgnoreCase("NaN")
									|| temp[1].trim().isEmpty() ? 0 : temp[1]
									.trim()).toString()
							+ ",3,"
							+ branchid
							+ ")";
					int insertparts = stmt.executeUpdate(strinsertparts);
					System.out.println("\\\\\\\\\\" + insertparts);
					if (insertparts <= 0) {
						errorstatus = 1;
						break;
					}
				}
				if (errorstatus != 1) {
					conn.commit();
					return 1;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return 0;
	}

	public ClsServiceAdvisorBean getPrint(String gateinpassdocno)
			throws SQLException {
		ClsServiceAdvisorBean bean = new ClsServiceAdvisorBean();
		try {

			String baytechisql = "select t.name techi,b.name bay ,concat(m.estdate,' ',m.esttime) esttime from gl_worksrvcadvisorm m left join gl_worktechnician t"
					+ " on m.technicianid=t.doc_no left join  gl_workbay b on m.bayid=b.doc_no where m.gateinpassdocno="
					+ gateinpassdocno + " and m.status=3;";

			Connection conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			ResultSet techibay = stmt.executeQuery(baytechisql);
			while (techibay.next()) {
				bean.setBayname(techibay.getString("bay"));
				bean.setTechiname(techibay.getString("techi"));
				bean.setEsttime(techibay.getString("esttime"));
			}

			String partsqry = "select @i:=@i+1 srno,a.* from (select m.doc_no,ma.productname,u.unit_desc,p.qty from gl_worksrvcadvisorm m "
					+ " left join gl_worksrvcadvisorparts p on m.doc_no=p.rdocno left join my_main ma on p.productdocno=ma.doc_no "
					+ " left join my_unitm u on ma.munit=u.doc_no where m.status=3 and m.gateinpassdocno="
					+ gateinpassdocno + ")a,(select @i:=0)r;";
			bean.setPartsqry(partsqry);
			String jobqry = "select @i:=@i+1 srno,a.* from (select job.doc_no,job.rdocno,v.mtype,v.name from "
					+ " gl_worksrvcadvisorm m left join gl_worksrvcadvisormaint job on m.doc_no=job.rdocno "
					+ " left join gl_vrepm v on job.maintenancedocno=v.docno where m.status=3 and m.gateinpassdocno="
					+ gateinpassdocno + ")a,(select @i:=0)r;";
			bean.setJobqry(jobqry);
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
	}

}
