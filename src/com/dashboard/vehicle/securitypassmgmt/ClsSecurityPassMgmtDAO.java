package com.dashboard.vehicle.securitypassmgmt;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsSecurityPassMgmtDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray fleetSearch(String id) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        Connection conn = null;
		try {
				conn = objconn.getMyConnection();
				Statement stmtVeh = conn.createStatement ();			
				String sql="select pl.code_name,m.fleet_no,m.flname,m.reg_no from gl_vehmaster m left join  gl_vehplate pl  on pl.doc_no=m.pltid where m.statu=3  order by  m.fleet_no";
//            	System.out.println(""+sql);
            	ResultSet resultSet = stmtVeh.executeQuery(sql);
            	RESULTDATA=objcommon.convertToJSON(resultSet);
     			stmtVeh.close();
     			conn.close();
            }
		catch(Exception e){
			e.printStackTrace();
			conn.close();	
		}
		finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	
	public JSONArray authoritySearch(String id) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        Connection conn = null;
		try {
				conn = objconn.getMyConnection();
				Statement stmtVeh = conn.createStatement ();			
				String sql="select doc_no,name,description from gl_vehpassauth where status=3";
//            	System.out.println(""+sql);
            	ResultSet resultSet = stmtVeh.executeQuery(sql);
            	RESULTDATA=objcommon.convertToJSON(resultSet);
     			stmtVeh.close();
     			conn.close();
            }
		catch(Exception e){
			e.printStackTrace();
			conn.close();	
		}
		finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray driverSearch(String id) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        Connection conn = null;
		try {
				conn = objconn.getMyConnection();
				Statement stmtVeh = conn.createStatement ();			
				String sql="select doc_no,sal_type TYPE,sal_CODE code ,sal_name,lic_no licenseno,lic_exp_dt licenseexpiry from my_salesman where sal_type in ('DRV','STF') and status=3";
//            	System.out.println(""+sql);
            	ResultSet resultSet = stmtVeh.executeQuery(sql);
            	RESULTDATA=objcommon.convertToJSON(resultSet);
     			stmtVeh.close();
     			conn.close();
            }
		catch(Exception e){
			e.printStackTrace();
			conn.close();	
		}
		finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	
	public JSONArray getSecurityPassData(String branch,String periodupto,String documenttype,String id) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        Connection conn = null;
		try {
				conn = objconn.getMyConnection();
				Statement stmtVeh = conn.createStatement ();		
				String sqltest="";
				java.sql.Date sqlperiodupto=null;
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
					sqltest+=" and sec.brhid="+branch;
				}
				if(documenttype.equalsIgnoreCase("2")){
					if(!periodupto.equalsIgnoreCase("")){
						sqlperiodupto=objcommon.changeStringtoSqlDate(periodupto);
						sqltest+=" and sec.expirydate<='"+sqlperiodupto+"'";
					}
				}
				String sql="select veh.reg_no regno,sec.doc_no,sec.autodate date,sec.authid hidauthority,auth.name authority,if(sec.type='VEH','Vehicle','Driver') type,sec.fleet_no hidvehicle,veh.flname "+
				" vehicle,sec.drvid hiddriver,drv.sal_name driver,sec.passno,sec.description,sec.issuedate,sec.expirydate,sec.notes,sec.brhid,"+
				" br.branchname from gl_securitypassmgmt sec left join gl_vehpassauth auth on sec.authid=auth.doc_no left join gl_vehmaster veh on"+
				" (sec.type='VEH' and sec.fleet_no=veh.fleet_no) left join my_salesman drv on (sec.type='DRV' and drv.sal_type=sec.drvtype and "+
				" sec.drvid=drv.doc_no) left join my_brch br on sec.brhid=br.doc_no where sec.status=3"+sqltest;
//            	System.out.println(""+sql);
            	ResultSet resultSet = stmtVeh.executeQuery(sql);
            	RESULTDATA=objcommon.convertToJSON(resultSet);
     			stmtVeh.close();
     			conn.close();
            }
		catch(Exception e){
			e.printStackTrace();
			conn.close();	
		}
		finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	
	public JSONArray getSecurityPassDataExcel(String branch,String periodupto,String documenttype,String id) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        Connection conn = null;
		try {
				conn = objconn.getMyConnection();
				Statement stmtVeh = conn.createStatement ();		
				String sqltest="";
				java.sql.Date sqlperiodupto=null;
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
					sqltest+=" and sec.brhid="+branch;
				}
				if(documenttype.equalsIgnoreCase("2")){
					if(!periodupto.equalsIgnoreCase("")){
						sqlperiodupto=objcommon.changeStringtoSqlDate(periodupto);
						sqltest+=" and sec.expirydate<='"+sqlperiodupto+"'";
					}
				}
				String sql="select sec.doc_no 'Doc No',date_format(sec.autodate,'%d.%m.%Y') date,auth.name 'Authority',coalesce(veh.flname,'')  "+
				" 'Vehicle',veh.reg_no 'Vehicle No',coalesce(drv.sal_name,'') 'Driver',coalesce(sec.passno,'') 'Pass No',coalesce(sec.description,'') 'Description',"+
				" date_format(sec.issuedate,'%d.%m.%Y') 'Issue Date',date_format(sec.expirydate,'%d.%m.%Y') 'Expiry Date',coalesce(sec.notes,'') 'Notes' from gl_securitypassmgmt sec left join gl_vehpassauth auth on sec.authid=auth.doc_no left join gl_vehmaster veh on"+
				" (sec.type='VEH' and sec.fleet_no=veh.fleet_no) left join my_salesman drv on (sec.type='DRV' and drv.sal_type=sec.drvtype and "+
				" sec.drvid=drv.doc_no) left join my_brch br on sec.brhid=br.doc_no where sec.status=3"+sqltest;
//            	System.out.println(""+sql);
            	ResultSet resultSet = stmtVeh.executeQuery(sql);
            	RESULTDATA=objcommon.convertToEXCEL(resultSet);
     			stmtVeh.close();
     			conn.close();
            }
		catch(Exception e){
			e.printStackTrace();
			conn.close();	
		}
		finally{
			conn.close();
		}
        return RESULTDATA;
    }
}
