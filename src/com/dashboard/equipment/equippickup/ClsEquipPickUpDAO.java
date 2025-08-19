package com.dashboard.equipment.equippickup;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.vehicletransactions.replacement.ClsReplacementBean;

public class ClsEquipPickUpDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray getContracts(String docno,String fleet,String regno,String client,String date,String mobile,String branch,String id) throws SQLException {
		//java.sql.Date sqlStartDate = objcommon.changeStringtoSqlDate(date);
		//System.out.println("Date"+sqlStartDate);
		
		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn =null;
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sqltest="";
			//System.out.println();
			if(!(docno.equalsIgnoreCase(""))){
				sqltest=" and agmt.voc_no like '%"+docno+"%'";
			}
			if(!(fleet.equalsIgnoreCase(""))){
				sqltest=sqltest+" and veh.fleet_no like '%"+fleet+"%'";
			}
			if(!(regno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and veh.reg_no like '%"+regno+"%'";
			}
			if(!(client.equalsIgnoreCase(""))){
				sqltest=sqltest+" and ac.refname like '%"+client+"%'";
			}
			if(!(mobile.equalsIgnoreCase(""))){
				sqltest=sqltest+" and ac.per_mob like '%"+mobile+"%'";
			}
			java.sql.Date sqlsearchdate=null;
			if(!(date.equalsIgnoreCase(""))){
				sqlsearchdate=ClsCommon.changeStringtoSqlDate(date);
			}
			if(sqlsearchdate!=null){
				sqltest=sqltest+" and agmt.date='"+sqlsearchdate+"'";
			}
//			System.out.println("Default SqlTest:"+sqltest);
			//System.out.println("DOCNO:"+docno+"FLEET:"+fleet+"REGNO:"+regno+"CLIENT:"+client+"DATE:"+date+"MOBILE:"+mobile);
			if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("")){
				sqltest+=" and agmt.brhid="+branch;
			}
			String strSql = "select calc.doc_no calcdocno,agmt.doc_no,agmt.voc_no,calc.currentfleetno fleet_no,veh.reg_no,agmt.date,br.branchname,veh.flname,ac.refname,ac.cldocno from gl_rentalcontractm agmt"+
			" left join gl_rentalquotecalc calc on agmt.doc_no=calc.contractdocno"+
			" left join my_brch br on agmt.brhid=br.doc_no"+
			" left join gl_equipmaster veh on calc.currentfleetno=veh.fleet_no"+
			" left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM')"+
			" where agmt.clstatus=0 and agmt.status=3 "+sqltest+" order by agmt.doc_no";
//			System.out.println("Agmt Search Query:"+strSql);	
			 ResultSet resultSet = stmt.executeQuery(strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		    return RESULTDATA;

		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
		
	    return RESULTDATA;
	}
	public int insert(String agmtno, String cmbagmttype, String fleet_no,
			Date indate, String intime, String inkm, String cmbinfuel,String cmbbranch,HttpSession session,String cldocno,String mode,
			String pickdesc,ClsEquipPickUpAction masteraction) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			int docno=0;
			if(inkm.equalsIgnoreCase("")){
				inkm="0";
			}
			if(cmbinfuel.equalsIgnoreCase("")){
				cmbinfuel="0";
			}
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtPickUp = conn.prepareCall("{ CALL equipPickupDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtPickUp.registerOutParameter(10, java.sql.Types.INTEGER);
			stmtPickUp.setString(1,agmtno);
			stmtPickUp.setString(2,cldocno);
			stmtPickUp.setString(3, fleet_no);
			stmtPickUp.setDate(4,indate);
			stmtPickUp.setString(5,intime);
			stmtPickUp.setString(6,inkm);
			stmtPickUp.setString(7,cmbinfuel);
			stmtPickUp.setString(8,session.getAttribute("USERID").toString());
			stmtPickUp.setString(9,cmbbranch);
			stmtPickUp.setString(11,mode);
			stmtPickUp.setString(12,pickdesc);
			stmtPickUp.setString(13,cmbagmttype);
			stmtPickUp.setString(14,masteraction.getCalcdocno());
			stmtPickUp.executeUpdate();
			docno=stmtPickUp.getInt("docNo");
			if(docno>0){
				conn.commit();
				stmtPickUp.close();
				conn.close();				
				return docno;
			}
			else{
				stmtPickUp.close();
				conn.close();
				return 0;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		finally{
			conn.close();
		}
		return 0;
	}

	
	public JSONArray getPickUpData(String branch) throws SQLException {
		//java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(date);
		//System.out.println("Date"+sqlStartDate);
		Connection conn =null;
		
	    JSONArray RESULTDATA=new JSONArray();
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String strSql = "select pick.calcdocno,veh.flname,pick.doc_no,ac.refname,ac.per_mob,pick.fleet_no,veh.reg_no,coalesce(calc.delenddate,calc.delstartdate) startdate,"+
			" coalesce(calc.delendtime,calc.delstarttime) starttime,coalesce(calc.delendkm,calc.delstartkm) startkm,"+
			" coalesce(calc.delendfuel,calc.delstartfuel) startfuel,pick.pdate,pick.ptime,pick.pkm,pick.pfuel,pick.brhid from eq_vehpickup pick"+
			" left join gl_rentalcontractm ragmt on (pick.agmttype='ERC' and pick.agmtno=ragmt.doc_no)"+
			" left join gl_rentalquotecalc calc on pick.calcdocno=calc.doc_no"+
			" left join my_acbook ac on (pick.cldocno=ac.cldocno and ac.dtype='CRM')"+
			" left join gl_equipmaster veh on pick.fleet_no=veh.fleet_no where pick.status=3";
			
			System.out.println("Pickup Query:"+strSql);	
			
			ResultSet resultSet = stmt.executeQuery(strSql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		    return RESULTDATA;

		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
		
	    return RESULTDATA;
	}
	
	
	
	
	public  ClsEquipPickUpBean getPrint(int docno) throws SQLException {
		ClsEquipPickUpBean printbean = new ClsEquipPickUpBean();
		 Connection conn = null; 
		 try {
			 conn = ClsConnection.getMyConnection();
	       Statement stmtpaint = conn.createStatement();
	       String strSql="";
	     /* strSql=("select coalesce(dr.name,dr1.name) drivenby,coalesce(r.description,'') description,deldrv.sal_name deldriver,coldrv.sal_name coldriver,"+
	    		  " outloc.loc_name outloc,inloc.loc_name inloc,v.flname infleetname,v1.flname outfleetname,loc.loc_name,r.delstatus delstatus1,r.clstatus,"+
	    		  " usr.user_name,opusr.user_name openuser,main.branchname mainbrch,inbr.branchname inandcolbrch,outbr.branchname outanddelbrch,st.st_desc,"+
	    		  " ac.acno,ac.refname,r.reptype,r.DOC_NO,DATE_FORMAT(r.DATE,'%d-%m-%Y') DATE,if(r.RTYPE='RAG','Rental','Lease') rtype,r.RDOCNO,r.RFLEETNO,"+
	    		  " DATE_FORMAT(r.RDATE,'%d-%m-%Y') RDATE,r.RTIME,round(r.RKM) rkm,r.RFUEL 'RFUEL',r.RLOCID,r.TRANCODE,r.REPTYPE,r.USERID,"+
	    		  " r.OBRHID,r.OLOCID,r.OFLEETNO,DATE_FORMAT(r.ODATE,'%d-%m-%Y') odate,r.OTIME,round(r.OKM) okm,r.ofuel 'ofuel',"+
	    		  " if(r.DELSTATUS=0,'NO','YES') delstatus ,r.DELDRVID,r.DELTIME,DATE_FORMAT(r.DELDATE,'%d-%m-%Y') DELDATE,round(r.DELKM) delkm,"+
	    		  " r.DELFUEL 'DELFUEL',r.DELAT,DATE_FORMAT(r.INDATE,'%d-%m-%Y') indate,r.INTIME,round(r.INKM) inkm,r.INFUEL 'infuel',r.INLOC,"+
	    		  " r.CLSTATUS,r.CLDRVID,DATE_FORMAT(r.CLDATE,'%d-%m-%Y') cldate,r.CLTIME,round(r.CLKM) clkm,r.CLFUEL 'CLFUEL', v.flname,"+
	    		  " concat(au.authid,'-',p.code_name,'-',v.reg_no) reg_no , concat(au1.authid,'-',p1.code_name,'-',v1.reg_no) reg_no2 from"+
	    		  " gl_vehreplace r left join gl_vehmaster v on v.fleet_no=r.rfleetno  left join gl_vehplate p on p.doc_no=v.pltid left join"+
	    		  " gl_vehauth au on au.doc_no=v.authid left join gl_vehmaster v1 on v1.fleet_no=r.OFLEETNO  left join gl_vehplate p1 on"+
	    		  " p1.doc_no=v1.pltid left join gl_vehauth au1 on au1.doc_no=v1.authid left join my_brch main on r.rbrhid=main.doc_no"+
	    		  " left join my_brch inbr on r.INBRHID=inbr.doc_no left join my_brch outbr on r.OBRHID=outbr.doc_no left join my_locm loc on"+
	    		  " r.rlocid=loc.doc_no left join gl_ragmt agmt on (r.rdocno=agmt.doc_no and r.rtype='RAG') left join gl_lagmt lagmt on"+
	    		  " (r.rdocno=lagmt.doc_no and r.rtype='LAG') left join my_acbook ac on (((agmt.cldocno=ac.cldocno and r.rtype='RAG' and ac.dtype='CRM') or (lagmt.cldocno=ac.cldocno and r.rtype='LAG'))"+
	    		  " and ac.dtype='CRM') left join gl_rdriver rdr on agmt.doc_no=rdr.rdocno left join gl_ldriver ldr on lagmt.doc_no=ldr.rdocno"+
	    		  " left join gl_drdetails dr on ((rdr.drid=dr.dr_id or ldr.drid=dr.dr_id) and dr.dtype='CRM')"+
	    		  " left join gl_drdetails dr1 on ((agmt.drid=dr1.doc_no or lagmt.drid=dr1.doc_no) and dr1.dtype='DRV')"+
	    		  " left join gl_status st on st.status=r.trancode  left join my_user usr on usr.doc_no=r.userid"+
	    		  " left join my_user opusr on opusr.doc_no=r.outuserid left join my_locm outloc on r.olocid=outloc.doc_no left join my_locm inloc"+
	    		  " on r.inloc=inloc.doc_no left join my_salesman deldrv on (r.deldrvid=deldrv.doc_no and deldrv.sal_type='DRV') left join my_salesman"+
	    		  " coldrv on (r.cldrvid=coldrv.doc_no and coldrv.sal_type='DRV' )where r.doc_no="+docno+" ");*/
	       strSql="select coalesce(pick.desc1,'') pickdesc,DATE_FORMAT(ragmt.date,'%d-%m-%Y') vradate,agmtbr.branchname agmtbranch,"+
	    		  " pickbr.branchname pickbranch,agmtloc.loc_name,pick.agmttype,ragmt.voc_no agmtno,ac.cldocno,ac.acno,ac.refname,coalesce(coalesce(calc.drivername,''),'')"+
	    		  " drivenby,coalesce(ragmt.description,'') description,pick.doc_no,DATE_FORMAT(pick.DATE,'%d-%m-%Y') DATE,"+
	    		  " pick.fleet_no,veh.flname,concat(auth.authid,'-',plate.code_name,'-',veh.reg_no) reg_no,DATE_FORMAT(coalesce(calc.delenddate,calc.delstartdate),'%d-%m-%Y') startdate,coalesce(calc.delendtime,calc.delstarttime) starttime,"+
	    		  " round(coalesce(coalesce(calc.delendkm,calc.delstartkm),0),2) startkm, coalesce(coalesce(calc.delendfuel,calc.delstartfuel),0.000) startfuel,"+
	    		  " DATE_FORMAT(pick.pdate,'%d-%m-%Y') pdate,pick.ptime,round(pick.pkm,2) pkm,pick.pfuel from eq_vehpickup pick left join gl_rentalcontractm ragmt on "+
	    		  " (pick.agmtno=ragmt.doc_no and pick.agmttype='RAG') left join gl_rentalquotecalc calc on (pick.calcdocno=calc.doc_no) "+
	    		  " left join my_acbook ac on (pick.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch agmtbr on ragmt.brhid=agmtbr.doc_no "+
	    		  " left join my_locm agmtloc on (0=agmtloc.doc_no) left join gl_equipmaster veh on pick.fleet_no=veh.fleet_no left join gl_vehauth auth on"+
	    		  " veh.authid=auth.doc_no left join gl_vehplate plate on plate.doc_no=veh.pltid left join my_brch pickbr on pick.brhid=pickbr.doc_no"+
	    		  " where pick.doc_no="+docno;
		       
	      // concat('On',' ',DATE_FORMAT(edate, '%d-%m-%Y'),' ','at',' ',DATE_FORMAT(edate, '%H:%i')) opendate

	       ResultSet resultSet = stmtpaint.executeQuery(strSql); 
	       
	      ClsCommon common=new ClsCommon();
	       while(resultSet.next()){
	    	  printbean.setLblagmtbranch(resultSet.getString("agmtbranch"));
	    	  printbean.setLblpickbranch(resultSet.getString("pickbranch"));
	    	  printbean.setLblagmtloc(resultSet.getString("loc_name"));
	    	  printbean.setLblagmttype(resultSet.getString("agmttype"));
	    	  printbean.setLblvrano(resultSet.getString("agmtno"));
	    	  printbean.setLblclientacno(resultSet.getString("acno"));
	    	  printbean.setLblrefname(resultSet.getString("refname"));
	    	  printbean.setLbldrivenby(resultSet.getString("drivenby"));
	    	  printbean.setLblagmtdesc(resultSet.getString("description"));
	    	  printbean.setLbldocno(resultSet.getString("doc_no"));
	    	  printbean.setLbldate(resultSet.getString("date"));
	    	  printbean.setLblfleet_no(resultSet.getString("fleet_no"));
	    	  printbean.setLblflname(resultSet.getString("flname"));
	    	  printbean.setLblregno(resultSet.getString("reg_no"));
	    	  printbean.setLblstartdate(resultSet.getString("startdate"));
	    	  printbean.setLblstarttime(resultSet.getString("starttime"));
	    	  printbean.setLblstartkm(resultSet.getString("startkm"));
	    	  printbean.setLblstartfuel(common.checkFuelName(conn, resultSet.getString("startfuel")));
	    	  printbean.setLblpdate(resultSet.getString("pdate"));
	    	  printbean.setLblptime(resultSet.getString("ptime"));
	    	  printbean.setLblpkm(resultSet.getString("pkm"));
	    	  printbean.setLblpfuel(common.checkFuelName(conn, resultSet.getString("pfuel")));
	    	   printbean.setLblvradate(resultSet.getString("vradate"));
	    	  printbean.setLblpickdesc(resultSet.getString("pickdesc"));
	       }
	       
	       stmtpaint.close();
	       
	       
	       Statement stmtinvoice10 = conn.createStatement ();
		    String  companysql="select c.company,c.address,c.tel,c.fax,l.loc_name location,b.branchname from eq_vehpickup r  "
		    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
		    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";

		    
	         ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
		       
		       while(resultsetcompany.next()){
		    	   
		  
		    	   printbean.setBarnchval(resultsetcompany.getString("branchname"));
		    	   printbean.setCompanyname(resultsetcompany.getString("company"));
		    	  
		    	   printbean.setAddress(resultsetcompany.getString("address"));
		    	 
		    	   printbean.setMobileno(resultsetcompany.getString("tel"));
		    	  
		    	   printbean.setFax(resultsetcompany.getString("fax"));
		    	   printbean.setLocation(resultsetcompany.getString("location"));
		    	  
		    	   
		    	   
		       } 
		       stmtinvoice10.close();
	       
	       
	       conn.close();
	      }
	      catch(Exception e){
	       e.printStackTrace();
	      conn.close();
	      }
		 finally{
				conn.close();
			}
	      return printbean;
	     }


	public boolean delete(int docno,String mode,HttpSession session,String cmbbranch) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtPickUp = conn.prepareCall("{CALL vehPickupDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtPickUp.setInt(11,docno);
			stmtPickUp.setString(1,null);
			stmtPickUp.setString(2,null);
			stmtPickUp.setString(3,null);
			stmtPickUp.setString(4, null);
			stmtPickUp.setDate(5,null);
			stmtPickUp.setString(6,null);
			stmtPickUp.setString(7,null);
			stmtPickUp.setString(8,null);
			stmtPickUp.setString(9,session.getAttribute("USERID").toString());
			stmtPickUp.setString(10,cmbbranch);
			stmtPickUp.setString(12,mode);
			stmtPickUp.setString(13,null);
			int val=stmtPickUp.executeUpdate();
			
			if(val>0){
				conn.commit();
				stmtPickUp.close();
				conn.close();				
				return true;
			}
			else{
				stmtPickUp.close();
				conn.close();
				return false;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			
		}
		finally{
			conn.close();
		}
		return false;
	}


}
