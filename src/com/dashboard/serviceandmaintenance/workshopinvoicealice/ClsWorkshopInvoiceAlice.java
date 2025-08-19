package com.dashboard.serviceandmaintenance.workshopinvoicealice;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.connection.ClsConnection;
import com.common.ClsCommon;

import net.sf.json.JSONArray;

public class ClsWorkshopInvoiceAlice {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon commonDAO = new ClsCommon();
	
	public JSONArray wsinvGridLoad(String fromdate,String todate,String id) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		String wsdb=getDatabase("ws");
		String crdb=getDatabase("cr");
		
		try {
			conn=ClsConnection.getMyConnection();

			Statement stmt = conn.createStatement ();
			String sqltest="";
			
			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=commonDAO.changeStringtoSqlDate(fromdate);
			}
			if(!fromdate.equalsIgnoreCase("")){
				sqltodate=commonDAO.changeStringtoSqlDate(todate);
				sqltest+=" and m.date between '"+sqlfromdate+"' and '"+sqltodate+"'";
			}
			
			String resql=" select m.invoicetoacno,g.insurcldocno,m.doc_no invno,date_format(m.date,'%d.%m.%Y') invdate,m.refno,g.regno,m.taxtotal totalinv,e.doc_no,"
					+" if(coalesce(es.sparetot,0)>m.taxtotal,m.taxtotal,coalesce(es.sparetot,0) ) sparetot,if(m.taxtotal-coalesce(es.sparetot,0)<0,0,m.taxtotal-coalesce(es.sparetot,0)) labourtot ,g.refno,"
					+" convert(concat(coalesce(vb.brand,''),' ',coalesce(vm.vtype,'')),char(200)) make,g.pltid,convert(coalesce(nr.fleet_no,''),char) fleet, j.doc_no jobcardno,"
					+" (select acno from "+crdb+"my_account where codeno='WORKSHOPACCOUNT') acno,"
					+" (select acno from "+wsdb+"my_account where codeno='MAINTSP') acnosp,"
					+" (select acno from "+wsdb+"my_account where codeno='MAINTLAB') acnolab "
					+" from "+wsdb+"ws_invm m "
					+" inner join "+wsdb+"MY_JVTRAN Jv on (jv.doc_no=m.doc_no and jv.dtype='mnt' and jv.acno=m.invoicetoacno and jv.status=3)"
					+" left join "+wsdb+"ws_jobcard j on (m.refno=j.doc_no and m.reftype='JC')"
					+" left join "+wsdb+"ws_estm e on (j.refno=e.doc_no and j.reftype='EST')"
					+" left join "+wsdb+"ws_gateinpass g on ((j.reftype='GIP' and j.refno=g.doc_no) or (e.gipno=g.doc_no))"
					+" left join (select jobcarddocno ,sum(customeramt) sparetot from "+wsdb+"ws_jccspare group by jobcarddocno) es on (j.doc_no=es.jobcarddocno)"
					+" left join "+wsdb+"gl_vehbrand vb on (g.brdid=vb.doc_no)"
					+" left join "+wsdb+"gl_vehmodel vm on (g.modid=vm.doc_no)"
					+" left join "+crdb+"gl_nrm nr on (nr.doc_no=g.movno)"
					+" where g.cldocno in (1,200) and m.status=3 and jv.dramount!=0 and m.nipno=0 "+sqltest+" order by m.doc_no";
			
			System.out.println("--resql--"+resql);
			ResultSet resultSet = stmt.executeQuery(resql);
			
			RESULTDATA=commonDAO.convertToJSON(resultSet);
			
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
	
	public JSONArray wsinvExcelLoad(String fromdate,String todate,String id) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		String wsdb=getDatabase("ws");
		String crdb=getDatabase("cr");
		
		try {
			conn=ClsConnection.getMyConnection();

			Statement stmt = conn.createStatement ();
			String sqltest="";
			
			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=commonDAO.changeStringtoSqlDate(fromdate);
			}
			if(!fromdate.equalsIgnoreCase("")){
				sqltodate=commonDAO.changeStringtoSqlDate(todate);
				sqltest+=" and m.date between '"+sqlfromdate+"' and '"+sqltodate+"'";
			}
			
			String resql=" select m.doc_no 'Inv No',date_format(m.date,'%d.%m.%Y') 'Inv Date', j.doc_no 'Jobcard No',g.regno 'Reg No',convert(concat(coalesce(vb.brand,''),' ',coalesce(vm.vtype,'')),char(200)) 'Make',"
					+" round(m.taxtotal,2) 'Total Invoice',round(if(coalesce(es.sparetot,0)>m.taxtotal,m.taxtotal,coalesce(es.sparetot,0) ),2) 'Spare Total',round(if(m.taxtotal-coalesce(es.sparetot,0)<0,0,m.taxtotal-coalesce(es.sparetot,0)),2) 'Labour Total' ,g.refno 'Ref No'"
					+" from "+wsdb+"ws_invm m "
					+" inner join "+wsdb+"MY_JVTRAN Jv on (jv.doc_no=m.doc_no and jv.dtype='mnt' and jv.acno=m.invoicetoacno and jv.status=3)"
					+" left join "+wsdb+"ws_jobcard j on (m.refno=j.doc_no and m.reftype='JC')"
					+" left join "+wsdb+"ws_estm e on (j.refno=e.doc_no and j.reftype='EST')"
					+" left join "+wsdb+"ws_gateinpass g on ((j.reftype='GIP' and j.refno=g.doc_no) or (e.gipno=g.doc_no))"
					+" left join (select jobcarddocno ,sum(customeramt) sparetot from "+wsdb+"ws_jccspare group by jobcarddocno) es on (j.doc_no=es.jobcarddocno)"
					+" left join "+wsdb+"gl_vehbrand vb on (g.brdid=vb.doc_no)"
					+" left join "+wsdb+"gl_vehmodel vm on (g.modid=vm.doc_no)"
					+" left join "+crdb+"gl_nrm nr on (nr.doc_no=g.movno)"
					+" where g.cldocno=1 and m.status=3 and jv.dramount!=0 and m.nipno=0 "+sqltest+" order by m.doc_no";
			
//			System.out.println("--resql--"+resql);
			ResultSet resultSet = stmt.executeQuery(resql);
			
			RESULTDATA=commonDAO.convertToEXCEL(resultSet);
			
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
	
	public String getDatabase(String code) throws SQLException{
		Connection conn = null;
		String  db=null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();
			String sqldb="select carrental_db,workshop_db from my_comp";
			ResultSet resultSet = stmt.executeQuery(sqldb);
			if(code.equalsIgnoreCase("ws")){
				while(resultSet.next()){
					db=resultSet.getString("workshop_db")+".";
				}
			}
			else{
				while(resultSet.next()){
					db=resultSet.getString("carrental_db")+".";
				}
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return db;
	}
	
}
