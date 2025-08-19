package com.dashboard.workshop.gateoutpass;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.workshop.gateinpass.ClsGateInPassBean;

import net.sf.json.JSONArray;

public class ClsGateOutPassDAO {

	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	public JSONArray getGateInPassData(String fromdate,String todate,String id,String gatedocno,String branch)throws SQLException
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
			if(!gatedocno.equalsIgnoreCase("")){
				sqltest+=" and m.doc_no="+gatedocno;
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and m.brhid="+branch;
			}
			Statement stmt=conn.createStatement();
			String strsql="select coalesce(veh.srvc_km,0)+coalesce(veh.lst_srv,0) srvcduekm,m.srvcduediff,m.doc_no,m.date,m.brhid,br.branchname,veh.fleet_no,veh.reg_no,veh.flname,case when m.agmtexist=1 and m.newdriver=0 then dr.name when m.agmtexist=0 and m.newdriver=0 then sal.sal_name else m.drivername end driver,"+
			" m.indate,m.intime,m.inkm,CASE WHEN m.infuel=0.000 THEN 'Level 0/8' WHEN m.infuel=0.125 THEN 'Level 1/8' WHEN m.infuel=0.250 THEN"+
			" 'Level 2/8' WHEN m.infuel=0.375 THEN 'Level 3/8' WHEN m.infuel=0.500 THEN 'Level 4/8' WHEN m.infuel=0.625 THEN 'Level 5/8'  WHEN"+
			" m.infuel=0.750 THEN 'Level 6/8' WHEN m.infuel=0.875 THEN 'Level 7/8' WHEN m.infuel=1.000 THEN 'Level 8/8'  END as infuel"+
			"  from gl_workgateinpassm m left join gl_equipmaster veh on m.fleet_no=veh.fleet_no left join gl_drdetails dr on (m.driverid=dr.dr_id and dr.dtype='CRM' and m.agmtexist=1) left join my_salesman sal on (m.driverid=sal.doc_no and sal.sal_type='DRV' and m.agmtexist=0) left join my_brch br on m.brhid=br.doc_no where m.status=3 and m.outstatus<>1 and m.processstatus=2 "+sqltest+" order by m.doc_no";
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
	
	
	public JSONArray getGateInPassExcelData(String fromdate,String todate,String id,String gatedocno,String branch)throws SQLException
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
			if(!gatedocno.equalsIgnoreCase("")){
				sqltest+=" and m.doc_no="+gatedocno;
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and m.brhid="+branch;
			}
			Statement stmt=conn.createStatement();
			String strsql="select br.branchname 'Branch',m.doc_no 'Doc No',date_format(m.date,'%d.%m.%Y') 'Date',veh.fleet_no 'Fleet No',veh.reg_no "+
			" 'Asset id',veh.flname 'Fleet Name',case when m.agmtexist=1 and m.newdriver=0 then dr.name when m.agmtexist=0 and m.newdriver=0 then "+
			" sal.sal_name else m.drivername end 'Driver',m.indate 'In Date',m.intime 'In Time',round(m.inkm,0) 'In Km',CASE WHEN m.infuel=0.000 "+
			" THEN 'Level 0/8' WHEN m.infuel=0.125 THEN 'Level 1/8' WHEN m.infuel=0.250 THEN 'Level 2/8' WHEN m.infuel=0.375 THEN 'Level 3/8' WHEN "+
			" m.infuel=0.500 THEN 'Level 4/8' WHEN m.infuel=0.625 THEN 'Level 5/8'  WHEN m.infuel=0.750 THEN 'Level 6/8' WHEN m.infuel=0.875 THEN "+
			" 'Level 7/8' WHEN m.infuel=1.000 THEN 'Level 8/8'  END 'In Fuel',round(coalesce(veh.srvc_km,0)+coalesce(veh.lst_srv,0),0) "+
			" 'Service Due Km',round(m.srvcduediff,0) 'Service Due Diff'"+
			"  from gl_workgateinpassm m left join gl_equipmaster veh on m.fleet_no=veh.fleet_no left join gl_drdetails dr on (m.driverid=dr.dr_id and dr.dtype='CRM' and m.agmtexist=1) left join my_salesman sal on (m.driverid=sal.doc_no and sal.sal_type='DRV' and m.agmtexist=0) left join my_brch br on m.brhid=br.doc_no where m.status=3 and m.outstatus<>1 and m.processstatus=2 "+sqltest+" order by m.doc_no";
			System.out.println("Excel Query:"+strsql);
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
	public JSONArray getGateInPassSearchData(String id,String fromdate,String todate,String branch) throws SQLException{
		JSONArray searchdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return searchdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String strsql="";
			String sqltest="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			if(sqlfromdate!=null){
				sqltest+=" and m.date>='"+sqlfromdate+"'";
			}
			if(sqltodate!=null){
				sqltest+=" and m.date<='"+sqltodate+"'";
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and m.brhid="+branch;
			}
			strsql="select br.branchname,m.doc_no,m.date,veh.fleet_no,veh.reg_no,m.drivername from gl_workgateinpassm m left join gl_equipmaster veh on (m.fleet_no=veh.fleet_no) left join my_brch br on (m.brhid=br.doc_no) where m.status=3 and m.outstatus<>1 and m.processstatus=2"+sqltest+" order by m.doc_no";
			System.out.println(strsql);
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(strsql);
			searchdata=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return searchdata;
	}
	public  ClsGateOutPassBean getPrint(String docno, HttpServletRequest request ,HttpSession session,String brhid) throws SQLException {
		 ClsGateOutPassBean bean = new ClsGateOutPassBean();
		  Connection conn = null; // String brcid=session.getAttribute("BRANCHID").toString();
		try {
				 conn = objconn.getMyConnection();
				Statement stmtprint = conn.createStatement ();
	        	
				/*String resql=("select m.invno,date_format(m.invdate,'%d-%m-%Y') invdate,m.doc_no,m.voc_no,date_format(m.date,'%d-%m-%Y') date,round(m.netamount,2) netamount,m.type,m.acno,if(m.reftype='DIR','Direct',concat('NI Purchase Order ','(',m.refno,')')) reftype,m.refno,m.curid,m.rate,m.delterm, "
						+ "coalesce(m.payterm,'') payterm,date_format(m.deldate,'%d-%m-%Y') deldate,coalesce(m.desc1,'') desc1,coalesce(h.description,'') description,h.account from my_srvpurm m left join my_head h on h.doc_no=m.acno  where m.DOC_NO='"+docno+"' ");
				*/
				
				String resql="select  br.branchname branch,concat(DATE_FORMAT(m.indate,'%d-%m-%y'),' @ ',m.intime) date,concat(DATE_FORMAT(m.outdate,'%d-%m-%y'),' @ ',m.outtime) outdatetime,vm.eng_no,vm.ch_no,round((vm.srvc_km+m.inkm),2) srvckm,round(m.inkm,2) inkm,ac.refname client,drivername,drivermobile,vm.reg_no,m.remarks,m.doc_no from  gl_workgateinpassm m left join my_acbook ac on m.cldocno=ac.cldocno and dtype='crm' left join gl_equipmaster vm on vm.fleet_no=m.fleet_no left join my_brch br on m.brhid=br.doc_no where m.doc_no='"+docno+"' and m.brhid='"+brhid+"' ";				
						System.out.println("Query++++++++"+resql);
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
			     
			       while(pintrs.next()){
			    	   
			    	   bean.setDocno(pintrs.getString("doc_no"));
			    	   bean.setDatetime(pintrs.getString("date"));
			    	   bean.setOutdatetime(pintrs.getString("outdatetime"));
			    	   bean.setBranch(pintrs.getString("branch"));
			    	   bean.setClient(pintrs.getString("client"));
			    	   bean.setInkm(pintrs.getString("inkm"));
			    	   bean.setEng_no(pintrs.getString("eng_no"));
			    	   bean.setCh_no(pintrs.getString("ch_no"));
			    	   bean.setSrvckm(pintrs.getString("srvckm"));
			    	   bean.setDriver(pintrs.getString("drivername"));
			    	   bean.setDrivernumber(pintrs.getString("drivermobile"));
			    	   bean.setRegno(pintrs.getString("reg_no"));
			    	   bean.setRemarks(pintrs.getString("remarks"));
			    	       	 
			    	    
			       }
			       String partsqry="select @i:=@i+1 srno,a.* from (select m.doc_no,ma.productname,u.unit_desc,p.qty from gl_worksrvcadvisorm m "
							+ " left join gl_worksrvcadvisorparts p on m.doc_no=p.rdocno left join my_main ma on p.productdocno=ma.doc_no "
							+ " left join my_unitm u on ma.munit=u.doc_no where m.status=3 and ma.productname is not null and m.gateinpassdocno="+docno+")a,(select @i:=0)r;";
			       System.out.println("partsqry"+partsqry);
			       bean.setPartsqry(partsqry);
					String jobqry="select @i:=@i+1 srno,a.* from (select job.doc_no,job.rdocno,v.mtype,v.name from "
							+ " gl_worksrvcadvisorm m left join gl_worksrvcadvisormaint job on m.doc_no=job.rdocno "
							+ " left join gl_vrepm v on job.maintenancedocno=v.docno where m.status=3 and job.doc_no is not null and m.gateinpassdocno="+docno+")a,(select @i:=0)r;";
					System.out.println("job"+jobqry);
					bean.setJobqry(jobqry);

				stmtprint.close();
				
				conn.close();



				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;
		
	
	}
}
