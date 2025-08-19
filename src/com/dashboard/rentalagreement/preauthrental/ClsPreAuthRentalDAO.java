package com.dashboard.rentalagreement.preauthrental;

import java.sql.*;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsPreAuthRentalDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getClientCatData(String id)throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select cat_name,doc_no from my_clcatm where status=3";
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
	
	
	public JSONArray getAgmtData(String id,String docno,String date,String fleetno,String regno,String clientname,String clientmobile) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			String sqltest="";
			java.sql.Date sqldate=null;
			if(!docno.equalsIgnoreCase("")){
				sqltest+=" and agmt.voc_no like '%"+docno+"%'";
			}
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
				sqltest+=" and agmt.date='"+sqldate+"'";
			}
			if(!fleetno.equalsIgnoreCase("")){
				sqltest+=" and veh.fleet_no like '%"+fleetno+"%'";
			}
			if(!regno.equalsIgnoreCase("")){
				sqltest+=" and veh.reg_no like '%"+regno+"%'";
			}
			if(!clientmobile.equalsIgnoreCase("")){
				sqltest+=" and ac.per_mob like '%"+clientmobile+"%'";
			}
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+clientname+"%'";
			}
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select agmt.voc_no,agmt.doc_no,agmt.date,ac.refname,ac.per_mob,veh.fleet_no,veh.reg_no from gl_ragmt agmt left join "+
			" my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehmaster veh on agmt.fleet_no=veh.fleet_no where "+
			" agmt.status=3 and agmt.clstatus=0"+sqltest;
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
	
	public JSONArray paymentpreauth(String brnchval,String fromdate,String todate,String cldocno,String status,String fleet,String agmtno,String clientcat,String type,String id) throws SQLException {
		System.out.println("Inside Function");
        JSONArray RESULTDATA=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
        java.sql.Date sqlfromdate = null;
        if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=objcommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
     	
      	
    	String sqltest="";
    	if(!(status.equalsIgnoreCase("")|| status.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and r.clstatus='"+status+"'";
    	}
    	if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and a.cldocno='"+cldocno+"'";
    	}
    	if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and r.fleet_no='"+fleet+"'";
    	}
    	if(!agmtno.equalsIgnoreCase("")){
    		sqltest+=" and r.doc_no="+agmtno;
    	}
    	if(!clientcat.equalsIgnoreCase("")){
    		sqltest+=" and a.catid="+clientcat;
    	}
  /*  	if(!(type.equalsIgnoreCase("") || type.equalsIgnoreCase("NA"))){
    		sqltest=sqltest+" and t.rentaltype='"+type+"'";
    	}*/
    	Connection conn = null;
		try {
				 conn = objconn.getMyConnection();
				Statement stmtVeh = conn.createStatement ();

				
            	if(brnchval.equalsIgnoreCase("a"))
            	{
          
            		String sql ="select  r.voc_no,r.insex,coalesce(insurexcess,0) insurexcess, coalesce(cdwexcess,0) cdwexcess,coalesce(scdwexcess,0) scdwexcess, "
            				+ "r.brhid, r.doc_no,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,r.ddate,r.dtime,t.gid,t.brhid branchname,r.tdocno, "
            				+ "v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,a.contactperson,t.rentaltype from gl_ragmt r "
            				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
            				+ " left join gl_vehgroup g on g.doc_no=v.vgrpid left join gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5  "
            				+ "left join gl_vehbrand br on br.doc_no=v.brdid left join gl_vehmodel mo on  mo.doc_no=v.vmodid  "
            				+ "left join gl_tarifexcess insu on insu.rdocno=r.tdocno and insu.gid=t.gid "
            				+ " where r.status=3 and r.odate between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest +" group by r.doc_no";
            		
            		
            	System.out.println("-------------------"+sql);
        
              
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=objcommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            	}
            	else{	
            		
 
            		String sql ="select  r.voc_no,r.insex,coalesce(insurexcess,0) insurexcess, coalesce(cdwexcess,0) cdwexcess,coalesce(scdwexcess,0) scdwexcess, "
            				+"r.brhid, r.doc_no,r.fleet_no,r.cldocno,r.odate,r.otime,r.okm,r.ddate,r.dtime,t.gid,t.brhid branchname,r.tdocno, "
            				+ "v.reg_no,v.FLNAME vehdetails,a.refname,a.per_mob,a.contactperson,t.rentaltype from gl_ragmt r "
            				+ "left join gl_vehmaster v on r.fleet_no=v.fleet_no left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
            				+ " left join gl_vehgroup g on g.doc_no=v.vgrpid left join gl_rtarif t on t.rdocno=r.doc_no and t.rstatus=5  "
            				+ "left join gl_vehbrand br on br.doc_no=v.brdid left join gl_vehmodel mo on  mo.doc_no=v.vmodid "
            				+ " left join gl_tarifexcess insu on insu.rdocno=r.tdocno and insu.gid=t.gid "
            				+ " where  r.status=3 and  r.odate between '"+sqlfromdate+"' and  '"+sqltodate+"' and r.brhid='"+brnchval+"' "+sqltest+" group by r.doc_no";
            		System.out.println("-------------------"+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            	 RESULTDATA=objcommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				
            	}
            	conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
}
