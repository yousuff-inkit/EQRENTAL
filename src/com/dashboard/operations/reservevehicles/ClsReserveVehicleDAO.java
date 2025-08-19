package com.dashboard.operations.reservevehicles;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsReserveVehicleDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();

	public   JSONArray vehSearch(String branch,String fleetno,String regno,String flname,String color,String group,String id,String masterrefno) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
	   	if(!id.equalsIgnoreCase("1")){
	   		return RESULTDATA;
	   	}
	   	 
	   	String sqltest="";
	    	
	    	if((!(fleetno.equalsIgnoreCase(""))) && (!(fleetno.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and v.fleet_no like '%"+fleetno+"%'";
	    	}
	    	if((!(regno.equalsIgnoreCase(""))) && (!(regno.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and v.reg_no like '%"+regno+"%'  ";
	    	}
	    	if((!(flname.equalsIgnoreCase(""))) && (!(flname.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and v.FLNAME like '%"+flname+"%'";
	    	}
	    	if((!(color.equalsIgnoreCase(""))) && (!(color.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and c.color like '%"+color+"%'";
	    	}
	    	if((!(group.equalsIgnoreCase(""))) && (!(group.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and g.gname like '%"+group+"%'";
	    	}
	   
	    	Connection conn =null;
			try {
				
				conn = objconn.getMyConnection();
				Statement stmtVeh8 = conn.createStatement ();
				String brdid="",modelid="";
				if(!masterrefno.equalsIgnoreCase("")){
					String strgetbrand="select brdid,modelid from gl_masterlagd where rdocno="+masterrefno+" and status=3";
					System.out.println(strgetbrand);
					ResultSet rsgetbrand=stmtVeh8.executeQuery(strgetbrand);
					int i=0;
					while(rsgetbrand.next()){
						if(i==0){
							brdid=rsgetbrand.getString("brdid");
							modelid=rsgetbrand.getString("modelid");
						}
						else{
							brdid=","+rsgetbrand.getString("brdid");
							modelid=","+rsgetbrand.getString("modelid");
						}
					}
					if(!brdid.equalsIgnoreCase("")){
						sqltest+=" and v.brdid in ("+brdid+")";
					}
					if(!modelid.equalsIgnoreCase("")){
						sqltest+=" and v.vmodid in ("+modelid+")";
					}
					
				}
				String vehsql= "select  plate.code_name platecode,v.doc_no vdocno,v.reg_no,v.fleet_no,v.FLNAME,v.a_loc,m.fleet_no,m.kmin,m.fin,c.doc_no,c.color,g.gname,g.gid from gl_vehmaster v 	 "
				+ "left join gl_vmove m on v.fleet_no=m.fleet_no  left join my_color c  on v.clrid=c.doc_no left join gl_vehgroup g on g.doc_no=v.vgrpid  left join gl_vehplate plate on v.pltid=plate.doc_no "
				+ "	where  ins_exp >=current_date and v.statu <> 7 and "
				+ "	m.doc_no=(select (max(doc_no)) from gl_vmove where fleet_no=v.fleet_no) and  "
				+ " fstatus in ('L','N') and v.status='IN' and v.tran_code='RR' and v.renttype in ('A','L') "+sqltest ;
				System.out.println("--------lease-------"+vehsql);
				ResultSet resultSet = stmtVeh8.executeQuery(vehsql);
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
	public   JSONArray getDetailData(String id,String cldocno,String uptodate) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
	   	if(!id.equalsIgnoreCase("1")){
	   		return RESULTDATA;
	   	}
	   	
	   	java.sql.Date sqluptodate=null;
	   	String sqltest="";
	   	if(!(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("undefined")))
    	{
	   		sqluptodate = objcommon.changeStringtoSqlDate(uptodate);
	   		sqltest=sqltest+" and mm.date<='"+sqluptodate+"'";
    	}
    	if(!(cldocno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and ac.cldocno="+cldocno+"";
    	}	
	   	
	    	Connection conn =null;
			try {
				
				conn = objconn.getMyConnection();
				Statement stmtVeh8 = conn.createStatement ();
				String detailsql= "select ac.refname,mm.po,mm.voc_no,mm.doc_no,md.doc_no detdocno,vb.brand_name brand,vm.vtype model,vs.name spec,mm.date,mm.refno,md.duration,md.outqty,md.qty,md.qty-md.outqty balqty"
							+" from gl_masterlagm mm left join gl_masterlagd md on mm.doc_no=md.rdocno"
							+" left join gl_vehbrand vb on md.brdid=vb.doc_no"
							+" left join gl_vehmodel vm on md.modelid=vm.doc_no"
							+" left join gl_vehspec vs on md.specid=vs.doc_no"
							+" left join my_acbook ac on (mm.cldocno=ac.cldocno and dtype='CRM')"
							+" Where md.outqty<md.qty"+sqltest;
				System.out.println("--------detail qry-------"+detailsql);
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
