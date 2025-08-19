package com.dashboard.operations.vehiclecustodylist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsVehCustodyListDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray getCustodyData(String fromdate,String todate,String agmttype,String agmtno,String cmbagmtbranch,String custatus,String id) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		 Connection conn=null;
			
		try {	
				java.sql.Date sqlfromdate=null,sqltodate=null;
				if(!fromdate.equalsIgnoreCase("")){
					sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
				if(!todate.equalsIgnoreCase("")){
					sqltodate=ClsCommon.changeStringtoSqlDate(todate);
				}
				String sqltest="";
				
				if(sqlfromdate!=null){
					sqltest+=" and cu.date>='"+sqlfromdate+"'";
				}
				if(sqltodate!=null){
					sqltest+=" and cu.date<='"+sqltodate+"'";
				}				
				if(!custatus.equalsIgnoreCase("")){
					if(custatus.equalsIgnoreCase("0")){
						sqltest+=" and cu.odate is null or (cu.odate is not null and (cu.deldate is null and cu.delivery=1))";
					}
					else{
						sqltest+=" and cu.odate is not null and ((cu.delivery=1 and cu.deldate is not null) or cu.delivery=0)";
					}
				}
				
				if(!agmttype.equalsIgnoreCase("")){
					sqltest+=" and cu.rtype='"+agmttype+"'";
				}
				
				if(!agmtno.equalsIgnoreCase("")){
					if(agmttype.equalsIgnoreCase("RAG")){
						sqltest+=" and ragmt.voc_no="+agmtno;
					}
					else if(agmttype.equalsIgnoreCase("LAG")){
						sqltest+=" and lagmt.voc_no="+agmtno;
					}
				}
								
				if(!cmbagmtbranch.equalsIgnoreCase("")){
					if(agmttype.equalsIgnoreCase("RAG")){
						sqltest+=" and ragmt.brhid="+cmbagmtbranch;
					}
					else if(agmttype.equalsIgnoreCase("LAG")){
						sqltest+=" and lagmt.brhid="+cmbagmtbranch;
					}
				}
						
				conn=ClsConnection.getMyConnection();
				Statement stmtRep = conn.createStatement();
				String strSql="select cu.description descin,cu.outdesc descout,if(cu.rtype='RAG',ragmt.voc_no,lagmt.voc_no) agmtno,if(cu.rtype='RAG',ra.branchname,la.branchname) agmtbranch,rb.branchname mainbrch,cu.doc_no, DATE_FORMAT(cu.date,'%d-%m-%Y') date, if(cu.RTYPE='RAG','Rental','Lease') rtype, cu.rdocno, DATE_FORMAT(cu.refdate,'%d-%m-%Y') refdate,cu.fleet_no fleetno,DATE_FORMAT(cu.rodate,'%d-%m-%Y') RDATE, cu.rotime RTIME,round(cu.rokm) rkm, cu.rofuel 'RFUEL',  cu.rbrhid,cu.rlocid, cu.reason st_desc,cu.inbrhid,cu.inlocid,"
							+" DATE_FORMAT(cu.indate,'%d-%m-%Y') indate,cu.intime, round(cu.inkm) inkm,ac.acno,ac.refname  ,opusr.user_name openuser,rl.loc_name,rb.branchname,v.flname fleetname,v.reg_no fleetreg,DATE_FORMAT(cu.cdate,'%d-%m-%Y') cldate,cu.ctime cltime,round(cu.ckm) clkm,DATE_FORMAT(cu.odate,'%d-%m-%Y') odate,cu.otime,round(cu.okm) okm,DATE_FORMAT(cu.deldate,'%d-%m-%Y') deldate,cu.deltime,round(cu.delkm) delkm, s.sal_name coldriver,s1.sal_name deldriver ,"
							+" CASE WHEN cu.ofuel=0.000 THEN 'Level 0/8' WHEN  cu.ofuel=0.125 THEN 'Level 1/8' WHEN cu.ofuel=0.250 THEN 'Level 2/8' WHEN cu.ofuel=0.375 THEN 'Level 3/8' WHEN cu.ofuel=0.500 THEN 'Level 4/8' WHEN cu.ofuel=0.625 THEN  'Level 5/8'  WHEN cu.ofuel=0.750 THEN 'Level 6/8' WHEN cu.ofuel=0.875 THEN 'Level 7/8' WHEN cu.ofuel=1.000 THEN 'Level 8/8'  else '' END  ofuel,"
							+" CASE WHEN cu.infuel=0.000 THEN 'Level 0/8' WHEN  cu.infuel=0.125 THEN 'Level 1/8' WHEN cu.infuel=0.250 THEN 'Level 2/8' WHEN cu.infuel=0.375 THEN 'Level 3/8' WHEN cu.infuel=0.500 THEN 'Level 4/8' WHEN cu.infuel=0.625 THEN  'Level 5/8'  WHEN cu.infuel=0.750 THEN 'Level 6/8' WHEN cu.infuel=0.875 THEN 'Level 7/8' WHEN cu.infuel=1.000 THEN 'Level 8/8'  else '' END  infuel,"
							+" CASE WHEN cu.cfuel=0.000 THEN 'Level 0/8' WHEN  cu.cfuel=0.125 THEN 'Level 1/8' WHEN cu.cfuel=0.250 THEN 'Level 2/8' WHEN cu.cfuel=0.375 THEN 'Level 3/8' WHEN cu.cfuel=0.500 THEN 'Level 4/8' WHEN cu.cfuel=0.625 THEN  'Level 5/8'  WHEN cu.cfuel=0.750 THEN 'Level 6/8' WHEN cu.cfuel=0.875 THEN 'Level 7/8' WHEN cu.cfuel=1.000 THEN 'Level 8/8'  else '' END  clfuel,"
							+" CASE WHEN cu.delfuel=0.000 THEN 'Level 0/8' WHEN  cu.delfuel=0.125 THEN 'Level 1/8' WHEN cu.delfuel=0.250 THEN 'Level 2/8' WHEN cu.delfuel=0.375 THEN 'Level 3/8' WHEN cu.delfuel=0.500 THEN 'Level 4/8' WHEN cu.delfuel=0.625 THEN  'Level 5/8'  WHEN cu.delfuel=0.750 THEN 'Level 6/8' WHEN cu.delfuel=0.875 THEN 'Level 7/8' WHEN cu.delfuel=1.000 THEN 'Level 8/8'  else '' END  delfuel"
							+" from gl_vehcustody cu  left join  my_acbook ac on(ac.cldocno=cu.cldocno and ac.dtype='CRM')"
							+" left join gl_vehmaster v on v.fleet_no=cu.fleet_no"
							+" left join gl_ragmt ragmt on  (cu.rdocno=ragmt.doc_no and cu.rtype='RAG')"
							+" left join gl_lagmt lagmt on (cu.rdocno=lagmt.doc_no and cu.rtype='LAG')"
							+" left join my_locm rl on(rl.doc_no=cu.inlocid)"
							+" left join my_brch rb on(rb.doc_no=cu.inbrhid)"
							+" left join my_brch ra on(ra.doc_no=ragmt.brhid)"
							+" left join my_brch la on(la.doc_no=lagmt.brhid)"
							+" left join my_user opusr on opusr.doc_no=cu.ouserid"
							+" left join my_salesman s on s.doc_no=cu.cdrid and s.sal_type='DRV'"
							+" left join my_salesman s1 on s1.doc_no=cu.deldrid and s1.sal_type='DRV' where cu.status=3"+sqltest;
				System.out.println("==============="+strSql);
				ResultSet resultSet = stmtRep.executeQuery(strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmtRep.close();
		}
		catch(Exception e){
			e.printStackTrace();
		    return RESULTDATA;
		}
		finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	
	public JSONArray getCuExcelData(String fromdate,String todate,String agmttype,String agmtno,String cmbagmtbranch,String custatus,String id) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		 Connection conn=null;
			
		try {	
				java.sql.Date sqlfromdate=null,sqltodate=null;
				if(!fromdate.equalsIgnoreCase("")){
					sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
				if(!todate.equalsIgnoreCase("")){
					sqltodate=ClsCommon.changeStringtoSqlDate(todate);
				}
				String sqltest="";
				
				if(sqlfromdate!=null){
					sqltest+=" and cu.date>='"+sqlfromdate+"'";
				}
				if(sqltodate!=null){
					sqltest+=" and cu.date<='"+sqltodate+"'";
				}				
				if(!custatus.equalsIgnoreCase("")){
					if(custatus.equalsIgnoreCase("0")){
						sqltest+=" and cu.odate is null or (cu.odate is not null and (cu.deldate is null and cu.delivery=1))";
					}
					else{
						sqltest+=" and cu.odate is not null and ((cu.delivery=1 and cu.deldate is not null) or cu.delivery=0)";
					}
				}
				
				if(!agmttype.equalsIgnoreCase("")){
					sqltest+=" and cu.rtype='"+agmttype+"'";
				}
				
				if(!agmtno.equalsIgnoreCase("")){
					if(agmttype.equalsIgnoreCase("RAG")){
						sqltest+=" and ragmt.voc_no="+agmtno;
					}
					else if(agmttype.equalsIgnoreCase("LAG")){
						sqltest+=" and lagmt.voc_no="+agmtno;
					}
				}
								
				if(!cmbagmtbranch.equalsIgnoreCase("")){
					if(agmttype.equalsIgnoreCase("RAG")){
						sqltest+=" and ragmt.brhid="+cmbagmtbranch;
					}
					else if(agmttype.equalsIgnoreCase("LAG")){
						sqltest+=" and lagmt.brhid="+cmbagmtbranch;
					}
				}
						
				conn=ClsConnection.getMyConnection();
				Statement stmtRep = conn.createStatement();
				String strSql="select rb.branchname 'Custody Branch',cu.doc_no 'Custody No',if(cu.rtype='RAG',ragmt.voc_no,lagmt.voc_no) 'Agmt No',if(cu.rtype='RAG',ra.branchname,la.branchname) 'Agmt Branch',if(cu.RTYPE='RAG','Rental','Lease') 'Agmt Type',cu.fleet_no 'Fleet No',v.reg_no 'Reg No',cu.description 'Description In',cu.outdesc 'Description Out',v.flname 'Fleet Name',"
							+" s.sal_name 'Collction driver',DATE_FORMAT(cu.cdate,'%d-%m-%Y') 'Collction Date',cu.ctime 'Collction Time',round(cu.ckm) 'Collction km',CASE WHEN cu.cfuel=0.000 THEN 'Level 0/8' WHEN  cu.cfuel=0.125 THEN 'Level 1/8' WHEN cu.cfuel=0.250 THEN 'Level 2/8' WHEN cu.cfuel=0.375 THEN 'Level 3/8' WHEN cu.cfuel=0.500 THEN 'Level 4/8' WHEN cu.cfuel=0.625 THEN  'Level 5/8'  WHEN cu.cfuel=0.750 THEN 'Level 6/8' WHEN cu.cfuel=0.875 THEN 'Level 7/8' WHEN cu.cfuel=1.000 THEN 'Level 8/8'  else '' END  collection_fuel,"
							+" DATE_FORMAT(cu.indate,'%d-%m-%Y') 'In Date',cu.intime 'In Time', round(cu.inkm) 'In km',CASE WHEN cu.infuel=0.000 THEN 'Level 0/8' WHEN  cu.infuel=0.125 THEN 'Level 1/8' WHEN cu.infuel=0.250 THEN 'Level 2/8' WHEN cu.infuel=0.375 THEN 'Level 3/8' WHEN cu.infuel=0.500 THEN 'Level 4/8' WHEN cu.infuel=0.625 THEN  'Level 5/8'  WHEN cu.infuel=0.750 THEN 'Level 6/8' WHEN cu.infuel=0.875 THEN 'Level 7/8' WHEN cu.infuel=1.000 THEN 'Level 8/8'  else '' END  infuel,"
							+" DATE_FORMAT(cu.odate,'%d-%m-%Y') 'Out Date',cu.otime 'Out time',round(cu.okm) 'Out km',CASE WHEN cu.ofuel=0.000 THEN 'Level 0/8' WHEN  cu.ofuel=0.125 THEN 'Level 1/8' WHEN cu.ofuel=0.250 THEN 'Level 2/8' WHEN cu.ofuel=0.375 THEN 'Level 3/8' WHEN cu.ofuel=0.500 THEN 'Level 4/8' WHEN cu.ofuel=0.625 THEN  'Level 5/8'  WHEN cu.ofuel=0.750 THEN 'Level 6/8' WHEN cu.ofuel=0.875 THEN 'Level 7/8' WHEN cu.ofuel=1.000 THEN 'Level 8/8'  else '' END  out_fuel,"
							+" s1.sal_name 'Delivery Driver',DATE_FORMAT(cu.deldate,'%d-%m-%Y') 'Delivery date',cu.deltime 'Delivery Time',round(cu.delkm) 'Delivery km',CASE WHEN cu.delfuel=0.000 THEN 'Level 0/8' WHEN  cu.delfuel=0.125 THEN 'Level 1/8' WHEN cu.delfuel=0.250 THEN 'Level 2/8' WHEN cu.delfuel=0.375 THEN 'Level 3/8' WHEN cu.delfuel=0.500 THEN 'Level 4/8' WHEN cu.delfuel=0.625 THEN  'Level 5/8'  WHEN cu.delfuel=0.750 THEN 'Level 6/8' WHEN cu.delfuel=0.875 THEN 'Level 7/8' WHEN cu.delfuel=1.000 THEN 'Level 8/8'  else '' END  delivery_fuel"
							+" from gl_vehcustody cu  left join  my_acbook ac on(ac.cldocno=cu.cldocno and ac.dtype='CRM')"
							+" left join gl_vehmaster v on v.fleet_no=cu.fleet_no"
							+" left join gl_ragmt ragmt on  (cu.rdocno=ragmt.doc_no and cu.rtype='RAG')"
							+" left join gl_lagmt lagmt on (cu.rdocno=lagmt.doc_no and cu.rtype='LAG')"
							+" left join my_locm rl on(rl.doc_no=cu.rlocid)"
							+" left join my_brch rb on(rb.doc_no=cu.rbrhid)"
							+" left join my_brch ra on(ra.doc_no=ragmt.brhid)"
							+" left join my_brch la on(la.doc_no=lagmt.brhid)"
							+" left join my_user opusr on opusr.doc_no=cu.ouserid"
							+" left join my_salesman s on s.doc_no=cu.cdrid and s.sal_type='DRV'"
							+" left join my_salesman s1 on s1.doc_no=cu.deldrid and s1.sal_type='DRV' where cu.status=3"+sqltest;
				System.out.println("excel data-----:"+strSql);
				ResultSet resultSet = stmtRep.executeQuery(strSql);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				stmtRep.close();
		}
		catch(Exception e){
			e.printStackTrace();
		    return RESULTDATA;
		}
		finally{
			conn.close();
		}
	    return RESULTDATA;
	}
}
