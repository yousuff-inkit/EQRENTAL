package com.dashboard.marketing.delmgmt;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsDelMgmtDAO {
	
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getDelMgmtData(String id, String brhid, String fromdate,String todate) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			java.sql.Date sqlfromdate = null, sqltodate = null;
			String sqltest="";
			if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")){
				sqltest+=" and m.brhid="+brhid;
			}
			if (!fromdate.trim().equalsIgnoreCase("")) {
				sqlfromdate = objcommon.changeStringtoSqlDate(fromdate);
				sqltest += " and m.date>='" + sqlfromdate + "'";
			}
			if (!todate.trim().equalsIgnoreCase("")) {
				sqltodate = objcommon.changeStringtoSqlDate(todate);
				sqltest += " and m.date<='" + sqltodate + "'";
			}
			String strsql="select * from (select ac.cldocno,h.account,'DEL' doctype,eq.reg_no assetid,case when calc.delmode=1 then 'Delivery Started' when calc.delmode=2 then 'Delivery Ended' else '' end delstatus,calc.doneby,calc.delfleetno,calc.delmode,calc.doc_no calcdocno,eq.fleet_no,eq.flname,m.doc_no,br.branchname,m.date,m.voc_no,m.reftype,m.refno,m.hirefromdate,m.delcharges,coalesce(ac.refname,'') clientname,"+
			" m.description,calc.deldocno,m.brhid,coalesce(sal_name,'')salesman from gl_rentalcontractm m"+
			" left join gl_rentalquotecalc calc on m.doc_no=calc.contractdocno"+
			" left join gl_rentalquotem qot on m.reftype='QOT' and m.refno=qot.doc_no"+
			" left join my_Acbook ac on qot.cldocno=ac.cldocno and ac.dtype='CRM' left join my_head h on h.doc_no=ac.acno"+
			" left join my_brch br on m.brhid=br.doc_no"+
			" left join my_salm sm on sm.doc_no=m.salid"+
			" left join gl_equipmaster eq on calc.fleet_no=eq.fleet_no "+
			" left join eq_vehpickup pik on pik.calcdocno=calc.doc_no where m.status=3 and pik.calcdocno is null and calc.contractenddate is null and m.clstatus=0 "+sqltest+" union all"+
			" select ac.cldocno,h.account,'PIK' doctype,eq.reg_no assetid,case when calc.delmode=1 then 'Delivery Started' when calc.delmode=2 then 'Delivery Ended' else '' end delstatus,"+
			" calc.doneby,calc.delfleetno,calc.delmode,calc.doc_no calcdocno,eq.fleet_no,eq.flname,m.doc_no,br.branchname,m.date,m.voc_no,"+
			" m.reftype,m.refno,m.hirefromdate,m.delcharges,coalesce(ac.refname,'') clientname,"+
			" m.description,calc.deldocno,pik.brhid,coalesce(sal_name,'')salesman from eq_vehpickup pik"+
			" left join gl_rentalcontractm m on pik.agmtno=m.doc_no"+
			" left join gl_rentalquotecalc calc on pik.calcdocno=calc.doc_no"+
			" left join gl_rentalquotem qot on m.reftype='QOT' and m.refno=qot.doc_no"+
			" left join my_Acbook ac on qot.cldocno=ac.cldocno and ac.dtype='CRM' left join my_head h on h.doc_no=ac.acno"+
			" left join my_brch br on m.brhid=br.doc_no"+
			" left join my_salm sm on sm.doc_no=m.salid"+
			" left join gl_equipmaster eq on calc.fleet_no=eq.fleet_no where m.status=3 and pik.status=3 and calc.contractenddate is null and calc.delpickupdocno=0 "+sqltest+") base order by base.date desc,base.doc_no desc";

			//System.out.println(strsql);   
			ResultSet rs=conn.createStatement().executeQuery(strsql);
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
