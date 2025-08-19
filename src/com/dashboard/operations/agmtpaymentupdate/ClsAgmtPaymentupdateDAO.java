package com.dashboard.operations.agmtpaymentupdate;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAgmtPaymentupdateDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getPaymentData(String agmtno,String amount,String id) throws SQLException{
    	JSONArray chequedata=new JSONArray();
    	if(!id.equalsIgnoreCase("1")){
    		return chequedata;
    	}
    	Connection conn=null;
    	try{
    		conn=objconn.getMyConnection();
    		Statement stmt=conn.createStatement();
    		java.sql.Date sqlfromdate=null,sqltodate=null;
    		
    		String strsql="select if(calc.markstatus>0 or uncl.bpvno>0,1,0) invstatus,agmt.date,ac.cldocno,ac.refname,agmt.voc_no agmtvocno,agmt.doc_no agmtno,calc.srno detaildocno,calc.date chequedate,calc.amount,calc.bpvno,"+
    		" calc.chequeno from gl_leasepytcalc calc left join gl_lagmt agmt on (calc.rdocno=agmt.doc_no) left join my_acbook ac on "+
    		" (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join my_unclrchqreceiptm uncl on "+
    		" (calc.bpvno=uncl.doc_no and agmt.brhid=uncl.brhid)where calc.rdocno="+agmtno+" and calc.status=3";
    		System.out.println(strsql);
    		ResultSet rs=stmt.executeQuery(strsql);
    		chequedata=objcommon.convertToJSON(rs);
    		stmt.close();
    	}
    	catch(Exception e){
    		e.printStackTrace();
    	}
    	finally{
    		conn.close();
    	}
    	return chequedata;
    }
	
	
	public JSONArray getAgmtData(String fromdate,String todate,String agmttype,String agmtno,String branch,String id) throws SQLException{
    	JSONArray chequedata=new JSONArray();
    	if(!id.equalsIgnoreCase("1")){
    		return chequedata;
    	}
    	Connection conn=null;
    	try{
    		conn=objconn.getMyConnection();
    		Statement stmt=conn.createStatement();
    		java.sql.Date sqlfromdate=null,sqltodate=null;
    		if(!fromdate.equalsIgnoreCase("")){
    			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
    		}
    		if(!todate.equalsIgnoreCase("")){
    			sqltodate=objcommon.changeStringtoSqlDate(todate);
    		}
    		String sqltest="";
    		if(fromdate!=null){
    			sqltest+=" and agmt.date>='"+sqlfromdate+"'";
    		}
    		if(todate!=null){
    			sqltest+=" and agmt.date<='"+sqltodate+"'";
    		}
    		if(!agmtno.equalsIgnoreCase("")){
    			sqltest+=" and agmt.doc_no="+agmtno+"";
    		}
    		if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
    			sqltest+=" and agmt.brhid="+branch;
    		}
    		String strsql="select agmt.doc_no agmtno,agmt.voc_no agmtvocno,ac.refname,ac.cldocno,agmt.date,calc.amount,veh.flname,veh.fleet_no,veh.reg_no from "+
    		" gl_lagmt agmt left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') left join"+
    		" (select sum(amount) amount,rdocno from gl_leasepytcalc where status=3 group by rdocno) calc on (agmt.doc_no=calc.rdocno) left join gl_vehmaster "+
    		" veh on (agmt.perfleet=veh.fleet_no or agmt.tmpfleet=veh.fleet_no) where agmt.status=3 and agmt.clstatus=0 "+sqltest+" "+
    		" group by agmt.doc_no";
    		System.out.println("Default Agmt Query: "+strsql);
    		ResultSet rs=stmt.executeQuery(strsql);
    		chequedata=objcommon.convertToJSON(rs);
    		stmt.close();
    	}
    	catch(Exception e){
    		e.printStackTrace();
    	}
    	finally{
    		conn.close();
    	}
    	return chequedata;
    	
    }
	
	
	public JSONArray getAgmtSearchData(String agmtno,String clientname,String clientmobile,String clientmail,String id,String agmtdate) throws SQLException{
		JSONArray clientdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return clientdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			String sqltest="";
			java.sql.Date sqldate=null;
			
			if(!agmtno.equalsIgnoreCase("")){
				sqltest+=" and agmt.voc_no like '%"+agmtno+"%'";
			}
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+clientname+"%'";
			}
			if(!clientmobile.equalsIgnoreCase("")){
				sqltest+=" and ac.per_mob like '%"+clientmobile+"%'";
			}
			if(!clientmail.equalsIgnoreCase("")){
				sqltest+=" and ac.mail1 like '%"+clientmail+"%'";
			}
			if(!agmtdate.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(agmtdate);
			}
			if(sqldate!=null){
				sqltest+=" and agmt.date='"+sqldate+"'";
			}
			strsql="select agmt.date,agmt.doc_no agmtdocno,agmt.voc_no agmtvocno,ac.refname clientname,ac.per_mob clientmobile,ac.mail1 clientmail "+
			" from gl_lagmt agmt left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM') where agmt.status=3 and agmt.clstatus=0 "+sqltest;
			System.out.println("Agmt Search Query : "+strsql);
			ResultSet rsclient=stmt.executeQuery(strsql);
			clientdata=objcommon.convertToJSON(rsclient);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return clientdata;
	}
}
