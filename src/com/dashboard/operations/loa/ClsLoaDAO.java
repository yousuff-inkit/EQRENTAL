package com.dashboard.operations.loa;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsLoaDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	
	
public JSONArray FirstListGridLoading(String check) throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
		if(!check.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		try {
			
			    conn = ClsConnection.getMyConnection();
			    Statement stmtStaff = conn.createStatement();
			  /*  if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}*/
			    String sql1="";
		       /* String sql="select ath.doc_no,ath.date,ath.name,ath.description,ath.enddate,ath.qty,(ath.qty-psd.dqty)vhqty,ps.vqty,ps.type,psd.dqty,psd.type2,((ath.qty-psd.dqty)-ps.vqty)vavail,(ath.qty-psd.dqty)davail from gl_vehpassauth ath " 
                           + "left join (select authid,count(type)vqty,type from gl_securitypassmgmt group by authid,type) ps on ath.doc_no=ps.authid and ps.type='veh' "
                           + "left join (select authid authid2,count(type) dqty,type type2 from gl_securitypassmgmt group by authid2,type2) psd "
                           + "on ath.doc_no=psd.authid2 and psd.type2='drv' where ath.status<>7";*/
		        
		        String sql="select ath.doc_no,ath.date,ath.name,ath.description,ath.enddate,ath.qty,ps.vqty,ps.type,psd.dqty,psd.type2,(ath.qty-(ps.vqty+psd.dqty))avail from gl_vehpassauth ath " 
                        + "left join (select authid,count(type)vqty,type from gl_securitypassmgmt where status<>7 group by authid,type) ps on ath.doc_no=ps.authid and ps.type='veh' "
                        + "left join (select authid authid2,count(type) dqty,type type2 from gl_securitypassmgmt where status<>7 group by authid2,type2) psd "
                        + "on ath.doc_no=psd.authid2 and psd.type2='drv' where ath.status<>7";
//		        System.out.println("Fist========="+sql);
		        ResultSet resultSet = stmtStaff.executeQuery(sql);
         
		        RESULTDATA=ClsCommon.convertToJSON(resultSet);
		    
		    stmtStaff.close();
		    conn.close();
	       }
		catch(Exception e){
		  e.printStackTrace();
		  conn.close();
	  }finally{
		  conn.close();
	  }
		return RESULTDATA;
	}

public JSONArray FirstListGridExcelLoading(String check) throws SQLException{
	
	JSONArray RESULTDATA=new JSONArray();
	Connection conn = null;
	java.sql.Date sqlFromDate = null;
    java.sql.Date sqlToDate = null;
	if(!check.equalsIgnoreCase("1")){
		return RESULTDATA;
	}
	try {
		
		    conn = ClsConnection.getMyConnection();
		    Statement stmtStaff = conn.createStatement();
		  /*  if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
				sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
            }
			
			if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
				sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
			}*/
		    String sql1="";
	        /*String sql="select ath.doc_no 'DOCNO',ath.date 'DATE',ath.name 'NAME',ath.description 'DESCRIPTION',ath.enddate 'LOA EXPIRY DATE',ath.qty 'SLOTS FOR PERSONS',psd.dqty 'USED SLOTS',(ath.qty-psd.dqty) 'AVAILABLE SLOTS',(ath.qty-psd.dqty) 'SLOTS FOR VEHICLES',ps.vqty 'USED SLOTS2',((ath.qty-psd.dqty)-ps.vqty) 'AVAILABLE SLOTS2' from gl_vehpassauth ath " 
                       + "left join (select authid,count(type)vqty,type from gl_securitypassmgmt group by authid,type) ps on ath.doc_no=ps.authid and ps.type='veh' "
                       + "left join (select authid authid2,count(type) dqty,type type2 from gl_securitypassmgmt group by authid2,type2) psd "
                       + "on ath.doc_no=psd.authid2 and psd.type2='drv' where ath.status<>7";
	       System.out.println("Fistexcel========="+sql);*/
		    
		    String sql="select ath.doc_no 'DOCNO',ath.date 'DATE',ath.name 'NAME',ath.description 'DESCRIPTION',ath.enddate 'LOA EXPIRY DATE',ath.qty 'TOTAL SLOTS',psd.dqty 'DRIVER USED SLOTS',ps.vqty 'VEHICLE USED SLOTS',(ath.qty-(ps.vqty+psd.dqty)) 'AVAILABLE SLOTS' from gl_vehpassauth ath " 
                    + "left join (select authid,count(type)vqty,type from gl_securitypassmgmt where status<>7 group by authid,type) ps on ath.doc_no=ps.authid and ps.type='veh' "
                    + "left join (select authid authid2,count(type) dqty,type type2 from gl_securitypassmgmt where status<>7 group by authid2,type2) psd "
                    + "on ath.doc_no=psd.authid2 and psd.type2='drv' where ath.status<>7";
//	       System.out.println("Fistexcel========="+sql);
	        ResultSet resultSet = stmtStaff.executeQuery(sql);
     
	        RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
	    
	    stmtStaff.close();
	    conn.close();
       }catch(Exception e){
	  e.printStackTrace();
	  conn.close();
  }finally{
	  conn.close();
  }
	return RESULTDATA;
}

public JSONArray DetailGridLoading(String check,String docno,String type) throws SQLException{
    //System.out.println("det=========1");
	JSONArray RESULTDATA=new JSONArray();
	Connection conn = null;
	java.sql.Date sqlFromDate = null;
    java.sql.Date sqlToDate = null;
    //System.out.println("check=========1"+check);
	if(!check.equalsIgnoreCase("1")){
		return RESULTDATA;
	}
	try {
	      // System.out.println("det=========2");
		    conn = ClsConnection.getMyConnection();
		    Statement stmtStaff = conn.createStatement();
		  /*  if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
				sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
            }
			
			if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
				sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
			}*/
	       /* String sql="select  veh.reg_no regno,veh.flname  vehicle,drv.sal_name driver,sec.type,sec.fleet_no,sec.drvid,sec.passno,sec.description from gl_securitypassmgmt sec left join gl_vehmaster veh on (sec.type='VEH' and sec.fleet_no=veh.fleet_no) "
                      + "left join my_salesman drv on (sec.type='DRV' and drv.sal_type in('DRV','STF')  and  sec.drvid=drv.doc_no) where sec.authid="+docno+" and type='"+type+"' ";
*/	      
		    String sql="select  sec.doc_no,sec.autodate date,veh.reg_no regno,veh.flname  vehicle,drv.sal_name driver,if(sec.type='VEH','Vehicle','Driver') type,sec.fleet_no,sec.drvid,sec.passno,sec.description,sec.issuedate,sec.expirydate, "
		    		  + "sec.notes from gl_securitypassmgmt sec left join gl_vehmaster veh on (sec.type='VEH' and sec.fleet_no=veh.fleet_no) "
		    		  + "left join my_salesman drv on (sec.type='DRV' and drv.sal_type=sec.drvtype and  sec.drvid=drv.doc_no) where sec.authid="+docno+" and type='"+type+"' and sec.status<>7 ";
		    
		    
//		    System.out.println("det========="+sql);
	        ResultSet resultSet = stmtStaff.executeQuery(sql);
     
	        RESULTDATA=ClsCommon.convertToJSON(resultSet);
	    
	    stmtStaff.close();
	    conn.close();
       }catch(Exception e){
	  e.printStackTrace();
	  conn.close();
  }finally{
	  conn.close();
  }
	return RESULTDATA;
}

public JSONArray DetailGridExcelLoading(String check,String docno,String type) throws SQLException{
	
	JSONArray RESULTDATA=new JSONArray();
	Connection conn = null;
	java.sql.Date sqlFromDate = null;
    java.sql.Date sqlToDate = null;
	if(!check.equalsIgnoreCase("1")){
		return RESULTDATA;
	}
	try {
		
		    conn = ClsConnection.getMyConnection();
		    Statement stmtStaff = conn.createStatement();
		  /*  if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
				sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
            }
			
			if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
				sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
			}*/
		    String sql1="";
	        String sql="select  sec.doc_no 'DOC NO',sec.autodate 'DATE',sec.type 'TYPE',sec.fleet_no 'FLEET NO',veh.reg_no 'REG NO',veh.flname 'VEHICLE',drv.sal_name 'DRIVER',sec.passno 'PASS NO',sec.description 'DESCRIPTION',sec.issuedate 'ISSUE DATE',sec.expirydate 'EXPIRY DATE',sec.notes 'NOTES' from gl_securitypassmgmt sec left join gl_vehmaster veh on (sec.type='VEH' and sec.fleet_no=veh.fleet_no) "
                      + "left join my_salesman drv on ( sec.type='DRV' and drv.sal_type=sec.drvtype and  sec.drvid=drv.doc_no) where sec.authid="+docno+" and type='"+type+"' and sec.status<>7 ";
//	       System.out.println("Detexcel========="+sql);
	        ResultSet resultSet = stmtStaff.executeQuery(sql);
     
	        RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
	    
	    stmtStaff.close();
	    conn.close();
       }catch(Exception e){
	  e.printStackTrace();
	  conn.close();
  }finally{
	  conn.close();
  }
	return RESULTDATA;
}
}
