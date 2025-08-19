package com.dashboard.equipment.equipurchaselist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEquipurchaselistDAO {

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
			 
			      
			
			String pySql=("select  vo.nettotal,ck.code,round(vo.nettotal,2) nettotal,round(vo.taxamt,2) taxamt,om.voc_no refvocno,vo.reftype,vo.curid,vo.rate,vo.refdocno,vo.voc_no,vo.doc_no,vo.date,vo.billtype,vo.venid, vo.desc1,vo.invno purno,vo.puchdate purdate,h.description vendor,h.account,h.doc_no headdoc "
        			+ " from eq_vpurdirm vo  left join eq_vpom om on om.doc_no=vo.refdocno and vo.reftype='EPO' left  join my_head h on h.doc_no=vo.venid left join my_curr ck on ck.doc_no=vo.curid where vo.status=3  "+sqltest );
 
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
			    	 
				      
				 String resql=("select evm.flname equname, evm.srno, evm.reg_no assetid,vo.date,h.description vendor,vo.voc_no,rq.tax_perc taxperc,rq.tax_amt taxamt,rq.net_total nettotal,round(rq.net_total*vo.rate,2) nettot,vo.rate,vo.curid,ck.code,rq.puch_cost prch_cost,rq.add_cost addicost,rq.brdid,rq.modid,rq.clrid,rq.tot_cost price,round(rq.tot_cost*vo.rate,2) bprice,rq.chaseno,rq.enginno,rq.fleet_no,"
							+ "  vb.brand_name brand,vm.vtype model,vc.color color from eq_vpurdirm vo  left join eq_vpurdird rq on rq.rdocno=vo.doc_no left join gl_vehbrand vb on vb.doc_no=rq.BRDID  "
							+ " left join gl_vehmodel vm on vm.doc_no=rq.MODID "
							+ " left join my_color vc on vc.doc_no=rq.clrid left join my_head h on h.doc_no=vo.venid left join gl_equipmaster evm on evm.fleet_no=rq.fleet_no left join my_curr ck on ck.doc_no=vo.curid where vo.status=3  "+sqltest+"");
				
			    System.out.println("========174========="+resql);
				ResultSet resultSet = stmtrelode.executeQuery(resql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtrelode.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}finally {
			conn.close();
		}
	    return RESULTDATA;
	}
	 
}
