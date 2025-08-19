package com.dashboard.equipment.equipinvprocessing;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEquipInvProcessingDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getContractData(String brhid,String periodupto,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqlfilters="";
			java.sql.Date sqlperiodupto=null;
			if(!brhid.trim().equalsIgnoreCase("") && !brhid.trim().equalsIgnoreCase("a")){
				sqlfilters+=" and m.brhid="+brhid;
			}
			if(!periodupto.trim().equalsIgnoreCase("")){
				sqlperiodupto=objcommon.changeStringtoSqlDate(periodupto);
			}
			
		/*	String strsql="select sm.sal_name sal,m.description desc1,if(m.delinvno=0,m.delcharges,0.0) delcharges,if(m.collectinvno=0 and m.clstatus=1,m.collcharges,0.0) collectcharges,count(*) equipcount,calc.doc_no calcdocno,m.doc_no,m.voc_no,m.date,m.cldocno,m.hiremode,ac.refname,calc.currentfleetno,veh.flname"+
			" from gl_rentalcontractm m left join gl_rentalquotecalc calc on m.doc_no=calc.contractdocno "+
			" left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') left join my_salm sm on m.salid=sm.doc_no "+
			" left join gl_equipmaster veh on calc.currentfleetno=veh.fleet_no"+
			" where m.status=3 and (m.clstatus=0 or (m.clstatus=1 and m.collectinvno=0 and m.collcharges>0.0)) and calc.invtodate<='"+sqlperiodupto+"' "+sqlfilters+" group by m.doc_no order by m.doc_no";
			*/ 
			String strsql="select sm.sal_name sal,group_concat(veh.reg_no) assetid,m.description desc1,if(m.delinvno=0,m.delcharges,0.0) delcharges,if(m.collectinvno=0 and m.clstatus=1,m.collcharges,0.0) collectcharges,if(m.srvinvno=0,m.srvcharges,0.0) srvcharges,count(*) equipcount,calc.doc_no calcdocno,m.doc_no,m.voc_no,m.date,m.cldocno,m.hiremode,ac.refname,calc.currentfleetno,veh.flname,coalesce(m.srvdesc,'')srvdesc"+
					" from gl_rentalcontractm m left join gl_rentalquotecalc calc on m.doc_no=calc.contractdocno "+
					" left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') left join my_salm sm on m.salid=sm.doc_no "+
					" left join gl_equipmaster veh on calc.currentfleetno=veh.fleet_no  left join eq_contractclosem cm on cm.contractdocno=m.doc_no "+
					" where m.status=3 and (m.clstatus=0 or (m.clstatus=1 and m.collectinvno=0 and m.collcharges>0.0)  or ((m.clstatus=1 and calc.invdate<enddate)) ) and calc.invtodate<='"+sqlperiodupto+"' "+sqlfilters+" group by m.doc_no order by m.doc_no";
					
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
	
	public JSONArray getEquipData(String contractdocno,String periodupto,String brhid,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlperiodupto=null;
			if(!periodupto.equalsIgnoreCase("")){
				sqlperiodupto=objcommon.changeStringtoSqlDate(periodupto);
			}
			int taxconfig=0;
			double vatpercent=0.0;
			String strmisc="select (select method from gl_config where field_nme='tax') tax,"+
			" (select vat_per from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno left join my_brch br on (tax.province=br.province) where tax.status<>7 and '"+sqlperiodupto+"' between tax.fromdate and tax.todate  and br.doc_no="+brhid+") vatpercent";
			ResultSet rsmisc=stmt.executeQuery(strmisc);
			while(rsmisc.next()){
				taxconfig=rsmisc.getInt("tax");
				vatpercent=rsmisc.getDouble("vatpercent");
			}
			String strsql=" select a.*,round(amount*vatpercent/100,2) vatamt, amount+round(amount*vatpercent/100,2) netamount from ("+
			"select calc.doc_no calcdocno,if("+taxconfig+"=1 and ac.tax=1 and "+vatpercent+">0.0,"+vatpercent+",0.0) vatpercent,veh.reg_no assetid,veh.fleet_no,veh.flname,if(coalesce(calc.delenddate,calc.delstartdate)=calc.invdate,calc.invdate,date_add(calc.invdate, interval 1 day)) displayinvdate,calc.invdate invdate,coalesce(if(cd.rdocno is null,null,cm.enddate),calc.invtodate) invtodate ,round(coalesce(d.total,0),2)  rate,round(coalesce(brk.breakamt,0),2) breakamt, agmt.hiremode,datediff(coalesce(if(cd.rdocno is null,null,cm.enddate),calc.invtodate),invdate) daysused, round(datediff(coalesce(if(cd.rdocno is null,null,cm.enddate),calc.invtodate),invdate)*((round(coalesce(d.total,0),2)-coalesce(brk.breakamt,0.0))/(case when agmt.hiremode='Daily' then 1 when agmt.hiremode='Weekly' then 7 when agmt.hiremode='Monthly' then day(last_day(coalesce(if(cd.rdocno is null,null,cm.enddate),calc.invtodate))) else 1 end)),2) amount  "+
			" from gl_rentalquotecalc calc"+
			" left join gl_rentalcontractm agmt on calc.contractdocno=agmt.doc_no "+
			" left join gl_rentalcontractd d on agmt.doc_no=d.rdocno and d.quotedetdocno=calc.detdocno "+
			" left join gl_rentalquoted qotd on qotd.doc_no=calc.detdocno and d.quotedetdocno=qotd.doc_no "+
			" left join gl_tarifd tfd on (calc.grpid=tfd.gid and agmt.hiremode=tfd.renttype)"+
			" left join gl_equipmaster veh on calc.currentfleetno=veh.fleet_no"+
			" left join (select sum(amount) breakamt,enddate,calcdocno from eq_breakdown group by calcdocno) brk on (brk.calcdocno=calc.doc_no and brk.enddate between calc.invdate and calc.invtodate)"+
			" left join my_acbook ac on (ac.cldocno=agmt.cldocno and ac.dtype='CRM')  left join eq_contractclosem cm on cm.contractdocno=agmt.doc_no  left join  eq_contractclosed cd on cm.doc_no=cd.rdocno and calc.doc_no=cd.calcdocno  "+
			" where calc.invtodate<='"+sqlperiodupto+"' and agmt.doc_no="+contractdocno +")a";
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
