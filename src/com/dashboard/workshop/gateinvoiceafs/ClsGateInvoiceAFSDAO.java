package com.dashboard.workshop.gateinvoiceafs;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.connection.*;
import com.controlcentre.masters.maintenancemaster.maintenance.ClsMaintenanceDAO;
import com.common.*;
import com.operations.commtransactions.rentalreceipts.ClsRentalReceiptsAction;
import com.operations.commtransactions.rentalreceipts.ClsRentalReceiptsDAO;
import com.operations.vehicletransactions.maintenanceupdate.ClsmaintenanceDAO;
import com.sun.org.glassfish.external.arc.Taxonomy;
public class ClsGateInvoiceAFSDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray getInvoiceData(String fromdate,String todate,String id,String client,String cmbbranch)throws SQLException
	{
		JSONArray gatedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return gatedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(sqlfromdate!=null){
				sqltest+=" and m.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and m.date<='"+sqltodate+"'";
			}
			if(!client.equalsIgnoreCase("") && client!=null){
				sqltest+=" and (if(m.clientinvoice=0,cash.cldocno="+client+",m.cldocno="+client+"))";
			}
			if(!cmbbranch.equalsIgnoreCase("") && !cmbbranch.equalsIgnoreCase("a") && cmbbranch!=null){
				sqltest+=" and m.brhid="+cmbbranch;
			}
			Statement stmt=conn.createStatement();
			int cashcldocno=0;
			String strgetcash="select head.cldocno from my_account ac inner join my_head head on ac.acno=head.doc_no where ac.codeno='CASH CUSTOMER'";
			ResultSet rsgetcash=stmt.executeQuery(strgetcash);
			while(rsgetcash.next()){
				cashcldocno=rsgetcash.getInt("cldocno");
			}
			String strsql="select coalesce(veh.srvc_km,0)+coalesce(veh.lst_srv,0) serviceduekm,if(m.clientinvoice=0,cash.refname,ac.refname) refname,m.invamount,m.processstatus,m.doc_no,m.date,m.brhid,br.branchname,veh.fleet_no,veh.reg_no,veh.flname,case when m.agmtexist=1 and m.newdriver=0 then dr.name when m.agmtexist=0 and m.newdriver=0 then sal.sal_name else m.drivername end driver,"+
			" m.indate,m.intime,m.inkm,CASE WHEN m.infuel=0.000 THEN 'Level 0/8' WHEN m.infuel=0.125 THEN 'Level 1/8' WHEN m.infuel=0.250 THEN"+
			" 'Level 2/8' WHEN m.infuel=0.375 THEN 'Level 3/8' WHEN m.infuel=0.500 THEN 'Level 4/8' WHEN m.infuel=0.625 THEN 'Level 5/8'  WHEN"+
			" m.infuel=0.750 THEN 'Level 6/8' WHEN m.infuel=0.875 THEN 'Level 7/8' WHEN m.infuel=1.000 THEN 'Level 8/8'  END as infuel"+
			"  from gl_workgateinpassm m left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') left join my_acbook cash on (cash.cldocno="+cashcldocno+" and cash.dtype='CRM') left join gl_equipmaster veh on m.fleet_no=veh.fleet_no left join gl_drdetails dr on (m.driverid=dr.dr_id and dr.dtype='CRM' and m.agmtexist=1) left join my_salesman sal on (m.driverid=sal.doc_no and sal.sal_type='DRV' and m.agmtexist=0) left join my_brch br on m.brhid=br.doc_no where m.status=3 and m.processstatus in (3) and m.invno=0 "+sqltest+" order by m.doc_no";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			gatedata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return gatedata;
	}
	
	public JSONArray getInvoiceExcelData(String fromdate,String todate,String id,String client,String cmbbranch)throws SQLException
	{
		JSONArray gatedata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return gatedata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("") && fromdate!=null){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("") && todate!=null){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String sqltest="";
			if(sqlfromdate!=null){
				sqltest+=" and m.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and m.date<='"+sqltodate+"'";
			}
			if(!client.equalsIgnoreCase("") && client!=null){
				sqltest+=" and (if(m.clientinvoice=0,cash.cldocno="+client+",m.cldocno="+client+"))";
			}
			if(!cmbbranch.equalsIgnoreCase("") && !cmbbranch.equalsIgnoreCase("a") && cmbbranch!=null){
				sqltest+=" and m.brhid="+cmbbranch;
			}
			Statement stmt=conn.createStatement();
			int cashcldocno=0;
			String strgetcash="select head.cldocno from my_account ac inner join my_head head on ac.acno=head.doc_no where ac.codeno='CASH CUSTOMER'";
			ResultSet rsgetcash=stmt.executeQuery(strgetcash);
			while(rsgetcash.next()){
				cashcldocno=rsgetcash.getInt("cldocno");
			}
			String strsql="select br.branchname 'Branch',m.doc_no 'Doc No',date_format(m.date,'%d.%m.%Y') 'Date',veh.fleet_no 'Fleet No',veh.reg_no 'Asset id',"+
			" veh.flname 'Fleet Name',if(m.clientinvoice=0,cash.refname,ac.refname) 'Client',case when m.agmtexist=1 and"+
			" m.newdriver=0 then dr.name when m.agmtexist=0 and m.newdriver=0 then sal.sal_name else m.drivername end 'Driver',"+
			" round(m.invamount,2) 'Amount',date_format(m.indate,'%d.%m.%Y') 'Date',m.intime 'In Time',round(m.inkm,0) 'In Km',"+
			" CASE WHEN m.infuel=0.000 THEN 'Level 0/8' WHEN m.infuel=0.125 THEN 'Level 1/8' WHEN m.infuel=0.250 THEN 'Level 2/8' WHEN"+
			" m.infuel=0.375 THEN 'Level 3/8' WHEN m.infuel=0.500 THEN 'Level 4/8' WHEN m.infuel=0.625 THEN 'Level 5/8'  WHEN m.infuel=0.750"+
			" THEN 'Level 6/8' WHEN m.infuel=0.875 THEN 'Level 7/8' WHEN m.infuel=1.000 THEN 'Level 8/8'  END 'In Fuel',"+
			" round(coalesce(veh.srvc_km,0)+coalesce(veh.lst_srv,0),0) 'Service Due Km'"+
			"  from gl_workgateinpassm m left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') left join my_acbook cash on (cash.cldocno="+cashcldocno+" and cash.dtype='CRM') left join gl_equipmaster veh on m.fleet_no=veh.fleet_no left join gl_drdetails dr on (m.driverid=dr.dr_id and dr.dtype='CRM' and m.agmtexist=1) left join my_salesman sal on (m.driverid=sal.doc_no and sal.sal_type='DRV' and m.agmtexist=0) left join my_brch br on m.brhid=br.doc_no where m.status=3 and m.processstatus in (3) and m.invno=0 "+sqltest+" order by m.doc_no";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			gatedata=objcommon.convertToEXCEL(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return gatedata;
	}
	public int gateInvoiceInsert(String client ,String gatedocno,java.sql.Date sqlfromdate,java.sql.Date sqltodate,double amount,String cmbbranch,HttpSession session,HttpServletRequest request,Connection conn) throws SQLException{
	
		int invdocno=0,invtrno=0;
		System.out.println("DAO gatedocno"+gatedocno);
		try{
			Statement stmt=conn.createStatement();
			ClsmaintenanceDAO maintdao=new ClsmaintenanceDAO();
			
			String garragename="",garrageid="";
			String strgetgarrage="select name,doc_no from gl_garrage where status<>7 and name='OWN GARAGE'";
			ResultSet rsgetgarrage=stmt.executeQuery(strgetgarrage);
			while(rsgetgarrage.next()){
				garragename=rsgetgarrage.getString("name");
				garrageid=rsgetgarrage.getString("doc_no");
			}
			String strgetgatedata="select gate.fleet_no,gate.date,round(gate.inkm,0) inkm,round(coalesce(veh.srvc_km,0)+coalesce(veh.lst_srv,0),2) nextsrvckm from gl_workgateinpassm gate left join gl_equipmaster veh on gate.fleet_no=veh.fleet_no where gate.doc_no="+gatedocno+" and gate.brhid="+cmbbranch;
			ResultSet rsgetgatedata=stmt.executeQuery(strgetgatedata);
			String fleetno="",maintremarks="",inkm="",nextsrvckm="";
			while(rsgetgatedata.next()){
				fleetno=rsgetgatedata.getString("fleet_no");
				inkm=rsgetgatedata.getString("inkm");
				nextsrvckm=rsgetgatedata.getString("nextsrvckm");
			}
			double labourtotal=0.0,partstotal=0.0;
			maintremarks="Created with GIP "+gatedocno+"";
			ArrayList<String> mainarray=new ArrayList<>();
			ArrayList<String> servicearray=new ArrayList<>();
			String strgetlabour="select round(coalesce(rep.cost,0),2) cost,rep.docno,rep.name,maint.gateinpassdocno,maint.brhid,mtype from gl_worksrvcadvisormaint maint left join gl_vrepm rep on maint.maintenancedocno=rep.docno where gateinpassdocno="+gatedocno+" and brhid="+cmbbranch;
			ResultSet rsgetlabour=stmt.executeQuery(strgetlabour);
			while(rsgetlabour.next()){
				labourtotal+=rsgetlabour.getDouble("cost");
				servicearray.add(rsgetlabour.getString("mtype")+" :: "+rsgetlabour.getString("name")+" :: "+""+" :: "+rsgetlabour.getDouble("cost")+" :: "+0.0+" :: "+rsgetlabour.getDouble("cost"));
			}
			String strgetparts="select round(coalesce(prddout.qty*prddout.cost_price,0),2) partcost,productname  from gl_worksrvcadvisorparts parts inner join my_prddout prddout on parts.issuedocno=prddout.rdocno and parts.productdocno=prddout.prdid left join my_main m on parts.productdocno=m.doc_no "
					+ "where issuestatus=1  and parts.gateinpassdocno="+gatedocno+" and parts.brhid="+cmbbranch+" group by prddout.prdid ;";
			ResultSet rsparts=stmt.executeQuery(strgetparts);
			while(rsparts.next()){
				partstotal+=rsparts.getDouble("partcost");
				servicearray.add(""+" :: "+""+" :: "+rsparts.getString("productname")+" :: "+0.0+" :: "+rsparts.getDouble("partcost")+" :: "+rsparts.getDouble("partcost"));
			}
			
			String strtodate=objcommon.changeSqltoString(sqltodate);
			
			int maintvalue=maintdao.insert(strtodate, garragename, invdocno, sqltodate, sqlfromdate, fleetno, maintremarks, "service", inkm, 
			nextsrvckm, garrageid, labourtotal, partstotal, labourtotal+partstotal, session, "A", "MRU", mainarray, 
			servicearray, request);
			if(maintvalue>0){
				String strupdateinv="update gl_workgateinpassm set invno="+maintvalue+" where doc_no="+gatedocno+" and brhid="+cmbbranch;
				System.out.println(strupdateinv);
				int updateinv=stmt.executeUpdate(strupdateinv);
				if(updateinv<=0){
					return 0;
				}				
			}
			if(maintvalue<=0){
				return 0;
			}
			else{
				conn.commit();
				return maintvalue;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			//conn.close();
		}
		return invdocno;
	}


	public String getVoucherNo(int val, Connection conn)throws SQLException {
		String vocno="";
		// TODO Auto-generated method stub
		try{
			Statement stmt=conn.createStatement();
			String strinv="select voc_no from gl_invm where doc_no="+val;
			System.out.println("Voucher Query");
			ResultSet rs=stmt.executeQuery(strinv);
			while(rs.next()){
				vocno=rs.getString("voc_no");
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return vocno;
	}
}
