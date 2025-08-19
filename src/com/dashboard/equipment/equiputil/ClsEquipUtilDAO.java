package com.dashboard.equipment.equiputil;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEquipUtilDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getUtilData(String branch,String date,String id,String grpby) throws SQLException{
		if(!id.equalsIgnoreCase("1")){ return new JSONArray();}
		JSONArray data=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqldate=null;
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
			}
			String strgroupby="";
			if(grpby.equalsIgnoreCase("")){
				strgroupby+=" group by model.doc_no";
			}
			else if(grpby.equalsIgnoreCase("CAT")){
				strgroupby+=" group by cat.doc_no";
			}
			else if(grpby.equalsIgnoreCase("SUBCAT")){
				strgroupby+=" group by subcat.doc_no";
			}
			String strsql="select case when '"+grpby+"'='' then model.vtype when '"+grpby+"'='CAT' then cat.name when '"+grpby+"'='SUBCAT' then subcat.name else '' end refname, round(coalesce(sum(coalesce(d.total,0))/sum(onhire),0),2) minrent,round(sum(coalesce(d.total,0)),2) fullrevenue,round(coalesce(sum(coalesce(d.total,0))/sum(onhire),0.0),2) currentrevenue ,count(*) total,veh.fleet_no,veh.flname,veh.catid,veh.subcatid,cat.name catname,subcat.name subcatname,sum(onhire) onhire,"+
			" sum(repair) repair,sum(ready) ready,sum(insp) insp,sum(repair)+sum(pickup)+sum(insp) unavailable,sum(pickup) offhire from eq_equiputil util"+
			" left join gl_equipmaster veh on util.fleet_no=veh.fleet_no"+
			" left join gl_vehmodel model on veh.vmodid=model.doc_no"+
			" left join gl_vehcategory cat on veh.catid=cat.doc_no"+
			" left join gl_vehsubcategory subcat on veh.subcatid=subcat.doc_no "+
			" left join (select max(doc_no) maxdocno,fleet_no from gl_rentalquotecalc where contractenddate is null group by fleet_no) maxcalc on veh.fleet_no=maxcalc.fleet_no"+
			" left join gl_rentalquotecalc calc on calc.doc_no=maxcalc.maxdocno "+
			" left join gl_rentalcontractd d on calc.detdocno=d.quotedetdocno"+
			" where veh.fstatus='L' and veh.statu=3 and util.date='"+sqldate+"' "+strgroupby;
			System.out.println(strsql);
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
