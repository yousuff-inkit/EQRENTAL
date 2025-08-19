package com.dashboard.workshop.vehiclerepairhistory;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsVehicleRepairHistoryDAO {
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	
	public JSONArray vehicleSearchData(String flname,String regno,String flno,String id) throws SQLException{
		
		
		JSONArray RESULTDATA=new JSONArray();
		Connection conn =null;
		String sqltest="";
		if(!(id.equalsIgnoreCase("1"))) {
        	return RESULTDATA;
        }
		if(!flname.equalsIgnoreCase("")){
			sqltest+=" and flname like '%"+flname+"%'";
		}
		if(!regno.equalsIgnoreCase("")){
			sqltest+=" and reg_no like '%"+regno+"%'";
		}
		if(!flno.equalsIgnoreCase("")){
			sqltest+=" and fleet_no like '%"+flno+"%'";
		}
		
        
		try {
			int config=0;
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			String strqry="select doc_no,reg_no regno,fleet_no fleetno,flname name from gl_equipmaster where 1=1"+sqltest;	
			
			System.out.println("veh search="+strqry);
			ResultSet resultSet = stmt.executeQuery(strqry);
			
			RESULTDATA=objcommon.convertToJSON(resultSet);
			
			stmt.close();
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
	
public JSONArray getSpareData(String fromdate,String todate, String vehdocno,String cldocno,String id) throws SQLException{
		
		
		JSONArray RESULTDATA=new JSONArray();
		Connection conn =null;
		String sqltest="";
		if(!(id.equalsIgnoreCase("1"))) {
        	return RESULTDATA;
        }
		java.sql.Date sqlfromdate=null,sqltodate=null;
		if(!fromdate.equalsIgnoreCase("")){
			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		}
		if(!todate.equalsIgnoreCase("")){
			sqltodate=objcommon.changeStringtoSqlDate(todate);
		}
		if(!vehdocno.equalsIgnoreCase("")){
			sqltest+=" and veh.doc_no='"+vehdocno+"'";
		}
		if(!cldocno.equalsIgnoreCase("")){
			sqltest+=" and gate.cldocno='"+cldocno+"'";
		}
		
        
		try {
			
			int config=0;
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			String strsql="select gate.date,gate.doc_no gatedocno,br.branchname branch,veh.doc_no vehdocno,m.psrno partdocno,m.part_no partno,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,parts.qty,"+
					" sum(i.out_qty) outqty,coalesce(sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)),0) as balqty,sum(i.op_qty) as totqty,i.stockid as"+
					" stkid,i.cost_price unitprice from gl_worksrvcadvisorparts parts left join my_main m on parts.productdocno=m.psrno left join my_unitm u on m.munit=u.doc_no "+
					" left join gl_workgateinpassm gate on parts.gateinpassdocno=gate.doc_no left join my_brch br on gate.brhid=br.doc_no left join gl_equipmaster veh on gate.fleet_no=veh.fleet_no "+
					" left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join my_prddin i "+
					" on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno) where m.status=3 and gate.date between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest+"  group by i.prdid  "+
					" order by i.date";	
			
			//System.out.println("spare parts------:"+strsql);
			ResultSet resultSet = stmt.executeQuery(strsql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			
			stmt.close();
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

public JSONArray getSpareExcelData(String fromdate,String todate, String vehdocno,String cldocno,String id) throws SQLException{
	
	
	JSONArray RESULTDATA=new JSONArray();
	Connection conn =null;
	String sqltest="";
	if(!(id.equalsIgnoreCase("1"))) {
    	return RESULTDATA;
    }
	java.sql.Date sqlfromdate=null,sqltodate=null;
	if(!fromdate.equalsIgnoreCase("")){
		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
	}
	if(!todate.equalsIgnoreCase("")){
		sqltodate=objcommon.changeStringtoSqlDate(todate);
	}
	if(!vehdocno.equalsIgnoreCase("")){
		sqltest+=" and veh.doc_no='"+vehdocno+"'";
	}
	if(!cldocno.equalsIgnoreCase("")){
		sqltest+=" and gate.cldocno='"+cldocno+"'";
	}
	
    
	try {
		int config=0;
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		
		String strsql="select br.branchname 'Branch',gate.doc_no 'Doc No',date_format(gate.date,'%d.%m.%Y') 'Date',m.part_no 'Part No',"+
		" m.productname 'Product Name',u.unit 'Unit',parts.qty 'Qty' from gl_worksrvcadvisorparts parts left join my_main m on parts.productdocno=m.psrno left join my_unitm u on m.munit=u.doc_no "+
		" left join gl_workgateinpassm gate on parts.gateinpassdocno=gate.doc_no left join my_brch br on gate.brhid=br.doc_no left join gl_equipmaster veh on gate.fleet_no=veh.fleet_no "+
		" left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join my_prddin i "+
		" on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno) where m.status=3 and gate.date between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest+"  group by i.prdid  "+
		" order by i.date";	
		
		//System.out.println("spare parts excel------:"+strsql);
		ResultSet resultSet = stmt.executeQuery(strsql);
		
		RESULTDATA=objcommon.convertToEXCEL(resultSet);
		
		stmt.close();
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
public JSONArray getMaitenanceData(String fromdate,String todate, String vehdocno,String cldocno,String id) throws SQLException{
	
	
	JSONArray RESULTDATA=new JSONArray();
	Connection conn =null;
	String sqltest="";
	if(!(id.equalsIgnoreCase("1"))) {
    	return RESULTDATA;
    }
	java.sql.Date sqlfromdate=null,sqltodate=null;
	if(!fromdate.equalsIgnoreCase("")){
		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
	}
	if(!todate.equalsIgnoreCase("")){
		sqltodate=objcommon.changeStringtoSqlDate(todate);
	}
	if(!vehdocno.equalsIgnoreCase("")){
		sqltest+=" and veh.doc_no='"+vehdocno+"'";
	}
	if(!cldocno.equalsIgnoreCase("")){
		sqltest+=" and gate.cldocno='"+cldocno+"'";
	}

	
    
	try {
		int config=0;
		conn=objconn.getMyConnection(); 
		Statement stmt=conn.createStatement();
		
		String strsql="select convert(concat(gate.indate,' / ',gate.intime),char(100)) indatetime,convert(concat(gate.outdate,' / ',gate.outtime),char(100)) outdatetime,gate.fleet_no,veh.reg_no,gate.inkm,gate.date,gate.doc_no gatedocno,br.branchname branch,veh.doc_no vehdocno,maint.docno maintenancedocno, maint.mtype  maintenances, maint.name descriptions "
					+" from gl_worksrvcadvisormaint m left join gl_vrepm maint on m.maintenancedocno=maint.docno"
					+" left join gl_workgateinpassm gate on m.gateinpassdocno=gate.doc_no"
					+" left join my_brch br on gate.brhid=br.doc_no"
					+" left join gl_equipmaster veh on gate.fleet_no=veh.fleet_no"
					+" where m.status=3 and gate.date between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest;	
		
		//System.out.println("maintenance------:"+strsql);
		ResultSet resultSet = stmt.executeQuery(strsql);
		
		RESULTDATA=objcommon.convertToJSON(resultSet);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}

	return RESULTDATA;
	}


public JSONArray getMaitenanceExcelData(String fromdate,String todate, String vehdocno,String cldocno,String id) throws SQLException{
	
	
	JSONArray RESULTDATA=new JSONArray();
	Connection conn =null;
	String sqltest="";
	if(!(id.equalsIgnoreCase("1"))) {
    	return RESULTDATA;
    }
	java.sql.Date sqlfromdate=null,sqltodate=null;
	if(!fromdate.equalsIgnoreCase("")){
		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
	}
	if(!todate.equalsIgnoreCase("")){
		sqltodate=objcommon.changeStringtoSqlDate(todate);
	}
	if(!vehdocno.equalsIgnoreCase("")){
		sqltest+=" and veh.doc_no='"+vehdocno+"'";
	}
	if(!cldocno.equalsIgnoreCase("")){
		sqltest+=" and gate.cldocno='"+cldocno+"'";
	}
	
    
	try {
		int config=0;
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		
		String strsql="select br.branchname 'Branch',gate.doc_no 'Doc No',date_format(gate.date,'%d.%m.%Y') 'Date',gate.fleet_no 'Fleet No',veh.reg_no 'Asset id',gate.inkm 'In KM',coalesce(convert(concat(gate.indate,' / ',gate.intime),char(100)),'') 'IN (Date/Time)',coalesce(convert(concat(gate.outdate,' / ',gate.outtime),char(100)),'') 'OUT (Date/Time)',maint.mtype"+
		" 'Maintenance', maint.name 'Description' "
		+" from gl_worksrvcadvisormaint m left join gl_vrepm maint on m.maintenancedocno=maint.docno"
		+" left join gl_workgateinpassm gate on m.gateinpassdocno=gate.doc_no"
		+" left join my_brch br on gate.brhid=br.doc_no"
		+" left join gl_equipmaster veh on gate.fleet_no=veh.fleet_no"
		+" where m.status=3 and gate.date between '"+sqlfromdate+"' and '"+sqltodate+"'"+sqltest;	

		//System.out.println("maintenance------:"+strsql);
		ResultSet resultSet = stmt.executeQuery(strsql);
		
		RESULTDATA=objcommon.convertToEXCEL(resultSet); 
		
		stmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}

	return RESULTDATA;
	}

    public   JSONArray getClientDetails(String id,String clname,String mob) throws SQLException {
	JSONArray RESULTDATA=new JSONArray();
   	if(!id.equalsIgnoreCase("1")){
   		return RESULTDATA;
   	}
   	 
   	String sqltest="";
	   	if(!(clname.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and a.RefName like '%"+clname+"%'";
    	}
    	if(!(mob.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and a.per_mob='%"+mob+"%'";
    	}	
   	
    	Connection conn =null;
		try {
			
			conn = objconn.getMyConnection();
			Statement stmtVeh8 = conn.createStatement ();
			String detailsql= "select distinct a.cldocno,trim(a.RefName) RefName,a.per_mob,trim(a.address) address,a.codeno,a.acno,m.doc_no,trim(m.sal_name) sal_name"
							+" from my_acbook a left join my_salm m on a.sal_id=m.doc_no and m.status<>7  where  a.dtype='CRM'"+sqltest;
			System.out.println("--------client qry-------"+detailsql);
			ResultSet resultSet = stmtVeh8.executeQuery(detailsql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtVeh8.close();
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
}
