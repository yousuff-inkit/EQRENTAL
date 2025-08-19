package com.dashboard.equipment.vehpurchaselist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsvehpurchaselistDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getUtilData(String branch,String fromdate,String id,String todate) throws SQLException{
		if(!id.equalsIgnoreCase("1")){ return new JSONArray();}
		JSONArray data=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null,sqltodate=null; 
			String sqltest="";
			if(!branch.equalsIgnoreCase("")&& !branch.equalsIgnoreCase("a")) {
				sqltest+=" and vo.brhid='"+branch+"'";
			}
					
			 if(!fromdate.equalsIgnoreCase("")){
		     sqlfromdate=objcommon.changeStringtoSqlDate(fromdate); }
			 if(!todate.equalsIgnoreCase("")){
			     sqltodate=objcommon.changeStringtoSqlDate(todate); }
			 
			  
			 String pySql=("  select vo.nettotal,vo.voc_no,vo.doc_no,vo.date,vo.venid, vo.desc1,vo.invno purno,vo.puchdate purdate,h.description vendor,h.account,h.doc_no headdoc "
	        			+ " from gl_vpurdirm vo  left  join my_head h on h.doc_no=vo.venid    where vo.status=3"+sqltest );
			
			//System.out.println("pySql======"+pySql);
			ResultSet rs=stmt.executeQuery(pySql);
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
	public  JSONArray gridsearchrelode(String branch,String fromdate,String id,String todate) throws SQLException {     

	    JSONArray RESULTDATA=new JSONArray();
	    if(!id.equalsIgnoreCase("1")){ return RESULTDATA;}
	           Connection conn = null;
		try {
				 conn = objconn.getMyConnection();
				Statement stmtrelode = conn.createStatement ();
				java.sql.Date sqlfromdate=null,sqltodate=null; 
				String sqltest="";
				if(!branch.equalsIgnoreCase("")&& !branch.equalsIgnoreCase("a")) {
					sqltest+=" and vo.brhid='"+branch+"'";
				}
						
				 if(!fromdate.equalsIgnoreCase("")){
			     sqlfromdate=objcommon.changeStringtoSqlDate(fromdate); }
				 if(!todate.equalsIgnoreCase("")){
				     sqltodate=objcommon.changeStringtoSqlDate(todate); }
				 
				String resql=("select concat(vr.reg_no,' - ',vp.code_name) regno,vo.date,h.description vendor,vo.voc_no,vo.taxamt,vo.nettotal,rq.puch_cost prch_cost,rq.add_cost addicost,rq.brdid,rq.modid,rq.clrid,rq.tot_cost price,rq.chaseno,rq.enginno,rq.fleet_no,"
						+ "  vb.brand_name brand,vm.vtype model,vc.color color from gl_vpurdird rq left join gl_vpurdirm vo on vo.doc_no=rq.rdocno left join gl_vehbrand vb on vb.doc_no=rq.BRDID  "
						+ " left join gl_vehmodel vm on vm.doc_no=rq.MODID "
						+ " left join my_color vc on vc.doc_no=rq.clrid left join my_head h on h.doc_no=vo.venid left join gl_vehmaster vr on vr.fleet_no=rq.fleet_no left join gl_vehplate vp on vp.doc_no=vr.pltid where vo.status=3"+sqltest+" ");
				//System.out.println("================="+resql);
				ResultSet resultSet = stmtrelode.executeQuery(resql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtrelode.close();
				conn.close();

				
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		
	    return RESULTDATA;
	}
	 
}
