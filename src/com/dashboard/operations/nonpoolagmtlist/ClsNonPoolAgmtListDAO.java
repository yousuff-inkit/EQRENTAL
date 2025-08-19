package com.dashboard.operations.nonpoolagmtlist;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;
public class ClsNonPoolAgmtListDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getNonPoolAgmtListData(String branch,String fromdate,String todate,String cldocno,String status,String fleet,
			String group,String brand,String model,String id,String chkoverdue) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			if(sqlfromdate!=null){
				sqltest+=" and non.edate>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and non.edate<='"+sqltodate+"'";
			}
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno="+cldocno+"";
			}
			if(!status.equalsIgnoreCase("")){
				sqltest+=" and non.clstatus="+status+"";
			}
			if(!fleet.equalsIgnoreCase("")){
				sqltest+=" and veh.fleet_no="+fleet;
			}
			if(!group.equalsIgnoreCase("")){
				sqltest+=" and veh.vgrpid="+group;
			}
			if(!model.equalsIgnoreCase("")){
				sqltest+=" and model.doc_no="+model;
			}
			if(!brand.equalsIgnoreCase("")){
				sqltest+=" and brd.doc_no="+brand;
			}
			if(chkoverdue.equalsIgnoreCase("1")){
				sqltest+=" and (non.clstatus=0 and CURDATE()>non.date_due)";
			}
			strsql="select non.doc_no,non.voc_no,non.edate date,br.branchname branch,br.doc_no brhid,veh.fleet_no,veh.flname,veh.reg_no,"+
			" auth.authname authority,plate.code_name platecode,ac.cldocno,ac.refname,ac.contactperson,ac.per_mob,non.dout,non.tout,non.date_due,"+
			" non.time_due,non.din,non.tin,if(non.clstatus=0 and CURDATE()>non.date_due,1,0) overduestatus,round(nontarif.rate,2) rate from gl_nonpoolveh non left join my_brch "+
			" br on non.branch=br.doc_no left join my_acbook ac on non.acc_no=ac.acno left join gl_vehmaster veh on non.fleet_no=veh.fleet_no left "+
			" join gl_vehauth auth on veh.authid=auth.doc_no left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on "+
			" veh.vmodid=model.doc_no left join gl_vehplate plate on veh.pltid=plate.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no "+
			" left join gl_ntarif nontarif on (non.doc_no=nontarif.rdocno and non.branch=nontarif.brhid) where non.status=3"+sqltest;
			
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray getNonPoolAgmtListDataExcel(String branch,String fromdate,String todate,String cldocno,String status,String fleet,
			String group,String brand,String model,String id,String chkoverdue) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			if(sqlfromdate!=null){
				sqltest+=" and non.edate>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and non.edate<='"+sqltodate+"'";
			}
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno="+cldocno+"";
			}
			if(!status.equalsIgnoreCase("")){
				sqltest+=" and non.clstatus="+status+"";
			}
			if(!fleet.equalsIgnoreCase("")){
				sqltest+=" and veh.fleet_no="+fleet;
			}
			if(!group.equalsIgnoreCase("")){
				sqltest+=" and veh.vgrpid="+group;
			}
			if(!model.equalsIgnoreCase("")){
				sqltest+=" and model.doc_no="+model;
			}
			if(!brand.equalsIgnoreCase("")){
				sqltest+=" and brd.doc_no="+brand;
			}
			if(chkoverdue.equalsIgnoreCase("1")){
				sqltest+=" and (non.clstatus=0 and CURDATE()>non.date_due)";
			}
			strsql="select non.voc_no 'Doc No',date_format(non.edate,'%d.%m.%Y') 'Date',br.branchname 'Branch',veh.fleet_no 'Fleet No',veh.flname 'Fleet Name',veh.reg_no 'Reg No',"+
			" auth.authname 'Authority',plate.code_name 'Plate Code',ac.cldocno 'Vendor #',ac.refname 'Vendor Name',coalesce(ac.contactperson,'') 'Contact Person',coalesce(ac.per_mob,'') 'Mobile',round(nontarif.rate,2) 'Rate',date_format(non.dout,'%d.%m.%Y') 'Out Date',non.tout 'Out Time',date_format(non.date_due,'%d.%m.%Y') 'Due Date',"+
			" non.time_due 'Due Time',date_format(non.din,'%d.%m.%Y') 'In Date',non.tin 'In Time' from gl_nonpoolveh non left join my_brch "+
			" br on non.branch=br.doc_no left join my_acbook ac on non.acc_no=ac.acno left join gl_vehmaster veh on non.fleet_no=veh.fleet_no left "+
			" join gl_vehauth auth on veh.authid=auth.doc_no left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on "+
			" veh.vmodid=model.doc_no left join gl_vehplate plate on veh.pltid=plate.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no "+
			" left join gl_ntarif nontarif on (non.doc_no=nontarif.rdocno and non.branch=nontarif.brhid) where non.status=3"+sqltest;
			
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToEXCEL(rs);
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return data;
	}
	public JSONArray getVendorData(String id) throws SQLException {
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			ResultSet resultSet = stmt.executeQuery ("select head.description,head.doc_no,ac.address,ac.com_mob,ac.per_mob,ac.cldocno,ac.refname from "+
			" my_head head left join my_acbook ac on head.doc_no=ac.acno where head.atype='AP' and ac.status=3");
			data=objcommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return data;
    }
	
	public JSONArray getBrandData(String id) throws SQLException {
        JSONArray data=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return data;
        }
        Connection conn = null;
        try {
			conn = objconn.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			String sql="select brand_name,doc_no from gl_vehbrand where status=3";
		 	ResultSet resultSet = stmtVeh.executeQuery(sql);
        	data=objcommon.convertToJSON(resultSet);
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
	    return data;
    }
	
	public JSONArray getFleetData(String id) throws SQLException {
        JSONArray data=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return data;
        }
        Connection conn =null;
        try {
			 conn = objconn.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			String sql="select fleet_no,flname,reg_no from gl_vehmaster where statu=3";
		 	ResultSet resultSet = stmtVeh.executeQuery(sql);
		 	data=objcommon.convertToJSON(resultSet);
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
        return data;
    }
	
	public JSONArray getGroupData(String id) throws SQLException {
		JSONArray data=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return data;
        }
        Connection conn = null;
        try {
			conn = objconn.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			String sql="select gname,doc_no from gl_vehgroup where status=3";
		 	ResultSet resultSet = stmtVeh.executeQuery(sql);
        	data=objcommon.convertToJSON(resultSet);
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
        return data;
    }
    public JSONArray getModelData(String id) throws SQLException {
    	JSONArray data=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return data;
        }
        Connection conn =null;
        try {
			 conn = objconn.getMyConnection();
			Statement stmtVeh = conn.createStatement ();
			String sql="select vtype,doc_no from gl_vehmodel where status=3";
		 	ResultSet resultSet = stmtVeh.executeQuery(sql);
        	data=objcommon.convertToJSON(resultSet);
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
        return data;
    }
}
