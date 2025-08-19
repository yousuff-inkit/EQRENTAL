package com.dashboard.limousine.jobclose;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.converters.SqlTimeConverter;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.google.common.util.concurrent.Service.State;

import net.sf.json.JSONArray;

public class ClsLimoJobCloseDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray getJobData(String fromdate,String todate,String bookdocno,String branch,String id) throws SQLException{
		JSONArray jobdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return jobdata;
		}
		Connection conn=null;
		try{
		java.sql.Date sqlfromdate=null,sqltodate=null;
		if(!fromdate.equalsIgnoreCase("")){
			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		}
		if(!todate.equalsIgnoreCase("")){
			sqltodate=objcommon.changeStringtoSqlDate(todate);
		}
		String sqltest="",sqltransferbranch="",sqlhoursbranch="";
		if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
			/*sqltest+=" and book.brhid="+branch;*/
			sqltransferbranch+=" and (tran.transferbranch=0 or tran.transferbranch="+branch+")";
			sqlhoursbranch+=" and (hours.transferbranch=0 or hours.transferbranch="+branch+")";
		}
		if(sqlfromdate!=null){
			sqltest+=" and book.date>='"+sqlfromdate+"'";
		}
		if(sqltodate!=null){
			sqltest+=" and book.date<='"+sqltodate+"'";
		}
		
		if(!bookdocno.equalsIgnoreCase("")){
			sqltest+=" and book.doc_no in ("+bookdocno+")";
		}
		/*String strsql="select * from (select tran.bookdocno,tran.tarifdetaildocno,coalesce(st.statusdesc,'Yet to Confirm') status,br.branchname transferfrombranch,tranbr.branchname currentbranch,book.doc_no,"+
		" book.cldocno,book.guestno,tran.doc_no detaildocno,tran.brandid,tran.tarifdocno,tran.modelid,tran.docname,ac.refname,guest.guest,'Transfer' type,null blockhrs,tran.pickupdate,"+
		" tran.pickuptime,pickup.location pickuplocation,tran.pickupadress pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand, "+
		" model.vtype model,tran.nos from gl_limobookm book left join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join my_acbook ac on "+
		" (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on "+
		" (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on (tran.dropfflocid=dropoff.doc_no) left join gl_vehbrand brd on tran.brandid=brd.doc_no "+
		" left join gl_vehmodel model on (tran.modelid=model.doc_no) left join my_brch br on book.brhid=br.doc_no left join my_brch tranbr on "+
		" tran.transferbranch=tranbr.doc_no left join gl_limostatus st on (tran.masterstatus=st.doc_no) where book.status=3 and tran.masterstatus=3 "+sqltest+sqltransferbranch+" union all"+
		" select hours.bookdocno,hours.tarifdetaildocno,coalesce(st.statusdesc,'Yet to Confirm') status,br.branchname transferfrombranch,hoursbr.branchname currentbranch,book.doc_no,book.cldocno,"+
		" book.guestno,hours.doc_no detaildocno,hours.brandid,hours.tarifdocno,hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type, hours.blockhrs,hours.pickupdate,"+
		" hours.pickuptime,pickup.location pickuplocation,hours.pickupaddress,null dropofflocation,null dropoffaddress, brd.brand_name brand,model.vtype model,"+
		" hours.nos from gl_limobookm book left join gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and "+
		" ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join "+
		" gl_vehbrand brd on (hours.brandid=brd.doc_no) left join gl_vehmodel model on (hours.modelid=model.doc_no) left join my_brch br on book.brhid=br.doc_no"+
		" left join my_brch hoursbr on hours.transferbranch=hoursbr.doc_no  left join gl_limostatus st on (hours.masterstatus=st.doc_no) where book.status=3  and hours.masterstatus=3 "+
		" "+sqltest+sqlhoursbranch+")a order by a.doc_no";*/
		String strsql="select * from (select veh.fleet_no,veh.reg_no,veh.flname,greet.greetrate,vip.viprate,boque.boquerate,tran.bookdocno,tran.tarifdetaildocno,coalesce(st.statusdesc,'Yet to Confirm') "+
		" status,br.branchname transferfrombranch,tranbr.branchname currentbranch,book.doc_no, book.cldocno,book.guestno,tran.doc_no detaildocno,tran.brandid,"+
		" tran.tarifdocno,tran.modelid,tran.docname,ac.refname,guest.guest,'Transfer' type,null blockhrs,tran.pickupdate, tran.pickuptime,pickup.location"+
		" pickuplocation,tran.pickupadress pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand,model.vtype model,tran.nos from "+
		" gl_limobookm book left join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join gl_limobooksrvc srvc on (book.doc_no=srvc.bookdocno and "+
		" tran.doc_no=srvc.typedocno) left join gl_limoextrasrvctarifd greet on (srvc.greettarifdocno=greet.doc_no and srvc.airportid=greet.airportid) left join"+
		" gl_limoextrasrvctarifd vip on (srvc.viptarifdocno=vip.doc_no and srvc.airportid=vip.airportid) left join gl_limoextrasrvctarifd boque on "+
		" (srvc.boquetarifdocno=boque.doc_no and srvc.airportid=boque.airportid) left join my_acbook ac on  (book.cldocno=ac.cldocno and ac.dtype='CRM') left join "+
		" gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on  (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on "+
		" (tran.dropfflocid=dropoff.doc_no) left join gl_vehmaster veh on tran.assignedfleet=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no  "+
		" left join gl_vehmodel model on (veh.vmodid=model.doc_no) left join my_brch br on book.brhid=br.doc_no left join my_brch tranbr on  "+
		" tran.transferbranch=tranbr.doc_no left join gl_limostatus st on (tran.masterstatus=st.doc_no) where book.status=3 and tran.masterstatus=3 "+
		" "+sqltest+sqltransferbranch+" union all"+
		" select veh.fleet_no,veh.reg_no,veh.flname,greet.greetrate,vip.viprate,boque.boquerate,hours.bookdocno,hours.tarifdetaildocno,coalesce(st.statusdesc,'Yet to Confirm') status,br.branchname "+
		" transferfrombranch,hoursbr.branchname currentbranch,book.doc_no,book.cldocno, book.guestno,hours.doc_no detaildocno,hours.brandid,hours.tarifdocno,"+
		" hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type, hours.blockhrs,hours.pickupdate, hours.pickuptime,pickup.location pickuplocation,"+
		" hours.pickupaddress,null dropofflocation,null dropoffaddress, brd.brand_name brand,model.vtype model, hours.nos from gl_limobookm book left join "+
		" gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join gl_limobooksrvc srvc on (book.doc_no=srvc.bookdocno and hours.doc_no=srvc.typedocno) left "+
		" join gl_limoextrasrvctarifd greet on (srvc.greettarifdocno=greet.doc_no and srvc.airportid=greet.airportid) left join gl_limoextrasrvctarifd vip on"+
		" (srvc.viptarifdocno=vip.doc_no and srvc.airportid=vip.airportid) left join gl_limoextrasrvctarifd boque on (srvc.boquetarifdocno=boque.doc_no and "+
		" srvc.airportid=boque.airportid) left join my_acbook ac on (book.cldocno=ac.cldocno and  ac.dtype='CRM') left join gl_limoguest guest on "+
		" (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join gl_vehmaster veh on hours.assignedfleet=veh.fleet_no "+
		" left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on (veh.vmodid=model.doc_no) left join my_brch br on book.brhid=br.doc_no "+
		" left join my_brch hoursbr on hours.transferbranch=hoursbr.doc_no  left join gl_limostatus st on (hours.masterstatus=st.doc_no) where book.status=3  and "+
		" hours.masterstatus=3 "+sqltest+sqlhoursbranch+" )a order by a.doc_no";
		System.out.println(strsql);
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		ResultSet rs=stmt.executeQuery(strsql);
		jobdata=objcommon.convertToJSON(rs);
		stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return jobdata;
	}
	
	public JSONArray getAmountData(String jobdocno,String bookdocno,String id) throws SQLException{
		JSONArray amountdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return amountdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String sqltest="";
			if(!jobdocno.equalsIgnoreCase("")){
				sqltest+=" and calc.jobdocno in ("+jobdocno+")";
			}
			if(!bookdocno.equalsIgnoreCase("")){
				sqltest+=" and calc.bookdocno in ("+bookdocno+")";
			}
			String str="select case when calc.jobtype='T' then tran.docname when calc.jobtype='L' then hours.docname else '' end jobname,calc.jobdocno,calc.bookdocno,calc.idno,calc.qty,calc.rate,calc.amount total,inv.description,inv.acno from gl_limojobclosecalc calc left join"+
			" gl_invmode inv on calc.idno=inv.idno left join gl_limobooktransfer tran on (calc.jobtype='T' and calc.jobdocno=tran.doc_no and calc.bookdocno=tran.bookdocno) "+
			" left join gl_limobookhours hours on (calc.jobtype='L' and calc.jobdocno=hours.doc_no and calc.bookdocno=hours.bookdocno) where 1=1"+sqltest;
			System.out.println("Amount Query: "+str);
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(str);
			amountdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return amountdata;
	}
	public JSONArray getAmountData2(String jobdocno,String bookdocno,String id) throws SQLException{
		JSONArray amountdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return amountdata;
		}
		System.out.println("Jobdocno: "+jobdocno);
		System.out.println("Bookdocno: "+bookdocno);
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String sqltest="";
			if(!jobdocno.equalsIgnoreCase("")){
				sqltest+=" and calc.jobdocno in ("+jobdocno+")";
			}
			if(!bookdocno.equalsIgnoreCase("")){
				sqltest+=" and calc.bookdocno in ("+bookdocno+")";
			}
			/*String str="select case when calc.jobtype='T' then tran.docname when calc.jobtype='L' then hours.docname else '' end jobname,calc.jobdocno,calc.bookdocno,calc.idno,calc.qty,calc.rate,calc.amount total,inv.description,inv.acno from gl_limojobclosecalc calc left join"+
			" gl_invmode inv on calc.idno=inv.idno left join gl_limobooktransfer tran on (calc.jobtype='T' and calc.jobdocno=tran.doc_no and calc.bookdocno=tran.bookdocno) "+
			" left join gl_limobookhours hours on (calc.jobtype='L' and calc.jobdocno=hours.doc_no and calc.bookdocno=hours.bookdocno) where 1=1"+sqltest;*/
			String str="select guest.guest,calc.bookdocno, calc.jobdocno, calc.jobtype, calc.jobname, calc.guestno, calc.total, calc.tarif, calc.nighttarif,"+
			" calc.exkmchg excesskmchg, calc.exhrchg excesshrchg, calc.exnighthrchg excessnighthrchg, calc.fuelchg, calc.parkingchg, calc.otherchg, calc.greetchg, calc.vipchg,calc.boquechg from "+
			" gl_limojobclosecalc calc left join gl_limoguest guest on (calc.guestno=guest.doc_no) where  1=1"+sqltest;
			System.out.println("Amount Query: "+str);
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(str);
			amountdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return amountdata;
	}
	public JSONArray getBookSearchData(String branch,String searchdate,String searchdocno,String searchclient,String searchguest,String id) throws SQLException{
		JSONArray bookdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return bookdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqldate=null;
			String sqltest="";
			if(!searchdate.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(searchdate);
			}
			if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("")){
				sqltest+=" and book.brhid="+branch;
			}
			if(sqldate!=null){
				sqltest+=" and book.date='"+sqldate+"'";
			}
			if(!searchdocno.equalsIgnoreCase("")){
				sqltest+=" and book.doc_no like '%"+searchdocno+"%'";
			}
			if(!searchclient.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+searchclient+"%'";
			}
			if(!searchguest.equalsIgnoreCase("")){
				sqltest+=" and guest.guest like '%"+searchguest+"%'";
			}
			String strsql="select book.doc_no bookdocno,book.date,ac.refname client,guest.guest from gl_limobookm book left join my_acbook ac on"+
			" (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on book.guestno=guest.doc_no where book.status=3"+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			bookdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return bookdata;
	}

	public int insert(ArrayList<String> calcarray, String mode,
			String cmbbranch, HttpSession session) throws SQLException {
		// TODO Auto-generated method stub
		int val=0;
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			int status=0;
			int maxdoc=0;
			String strmaxdoc="select coalesce(max(doc_no)+1,1) maxdoc from gl_limojobclose";
			Statement stmt=conn.createStatement();
			ResultSet rsmaxdoc=stmt.executeQuery(strmaxdoc);
			while(rsmaxdoc.next()){
				maxdoc=rsmaxdoc.getInt("maxdoc");
			}
			for(int i=0;i<calcarray.size();i++){
				String temp[]=calcarray.get(i).split("::");			
				CallableStatement stmtJobclose = conn.prepareCall("{call limoJobCloseDML(?,?,?,?,?,?,?,?,?,?)}");
				stmtJobclose.setString(1, temp[0]);
				stmtJobclose.setString(2, temp[1]);
				stmtJobclose.setString(3, temp[2]);
				stmtJobclose.setString(4, temp[3]);
				stmtJobclose.setString(5, mode);
				stmtJobclose.setString(6, "BLJC");
				stmtJobclose.setString(7, cmbbranch);
				stmtJobclose.setString(8, session.getAttribute("USERID").toString());
				stmtJobclose.setString(9, session.getAttribute("COMPANYID").toString());
				stmtJobclose.setInt(10, maxdoc);
				stmtJobclose.executeQuery();
				//int docno=stmtJobclose.getInt("docNo");
				if(maxdoc<=0){
					status=1;
					break;
				}
				String strupdatelimomgmt="update gl_limomanagement set bstatus=7 where docno="+temp[0]+" and job='"+temp[4]+"'";
				int updatelimomgmt=stmtJobclose.executeUpdate(strupdatelimomgmt);
				if(updatelimomgmt<=0){
					status=1;
					break;
				}
			}
			if(status!=1){
				conn.commit();
				return 1;
			}
			else{
				return 0;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return val;
	}
public JSONArray exceljobcloseData(String fromdate,String todate,String bookdocno,String branch,String id) throws SQLException{
		JSONArray jobdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return jobdata;
		}
		Connection conn=null;
		try{
		java.sql.Date sqlfromdate=null,sqltodate=null;
		if(!fromdate.equalsIgnoreCase("")){
			sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		}
		if(!todate.equalsIgnoreCase("")){
			sqltodate=objcommon.changeStringtoSqlDate(todate);
		}
		String sqltest="",sqltransferbranch="",sqlhoursbranch="";
		if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
			/*sqltest+=" and book.brhid="+branch;*/
			sqltransferbranch+=" and (tran.transferbranch=0 or tran.transferbranch="+branch+")";
			sqlhoursbranch+=" and (hours.transferbranch=0 or hours.transferbranch="+branch+")";
		}
		if(sqlfromdate!=null){
			sqltest+=" and book.date>='"+sqlfromdate+"'";
		}
		if(sqltodate!=null){
			sqltest+=" and book.date<='"+sqltodate+"'";
		}
		
		if(!bookdocno.equalsIgnoreCase("")){
			sqltest+=" and book.doc_no in ("+bookdocno+")";
		}
		/*String strsql="select * from (select tran.bookdocno,tran.tarifdetaildocno,coalesce(st.statusdesc,'Yet to Confirm') status,br.branchname transferfrombranch,tranbr.branchname currentbranch,book.doc_no,"+
		" book.cldocno,book.guestno,tran.doc_no detaildocno,tran.brandid,tran.tarifdocno,tran.modelid,tran.docname,ac.refname,guest.guest,'Transfer' type,null blockhrs,tran.pickupdate,"+
		" tran.pickuptime,pickup.location pickuplocation,tran.pickupadress pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand, "+
		" model.vtype model,tran.nos from gl_limobookm book left join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join my_acbook ac on "+
		" (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on "+
		" (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on (tran.dropfflocid=dropoff.doc_no) left join gl_vehbrand brd on tran.brandid=brd.doc_no "+
		" left join gl_vehmodel model on (tran.modelid=model.doc_no) left join my_brch br on book.brhid=br.doc_no left join my_brch tranbr on "+
		" tran.transferbranch=tranbr.doc_no left join gl_limostatus st on (tran.masterstatus=st.doc_no) where book.status=3 and tran.masterstatus=3 "+sqltest+sqltransferbranch+" union all"+
		" select hours.bookdocno,hours.tarifdetaildocno,coalesce(st.statusdesc,'Yet to Confirm') status,br.branchname transferfrombranch,hoursbr.branchname currentbranch,book.doc_no,book.cldocno,"+
		" book.guestno,hours.doc_no detaildocno,hours.brandid,hours.tarifdocno,hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type, hours.blockhrs,hours.pickupdate,"+
		" hours.pickuptime,pickup.location pickuplocation,hours.pickupaddress,null dropofflocation,null dropoffaddress, brd.brand_name brand,model.vtype model,"+
		" hours.nos from gl_limobookm book left join gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and "+
		" ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join "+
		" gl_vehbrand brd on (hours.brandid=brd.doc_no) left join gl_vehmodel model on (hours.modelid=model.doc_no) left join my_brch br on book.brhid=br.doc_no"+
		" left join my_brch hoursbr on hours.transferbranch=hoursbr.doc_no  left join gl_limostatus st on (hours.masterstatus=st.doc_no) where book.status=3  and hours.masterstatus=3 "+
		" "+sqltest+sqlhoursbranch+")a order by a.doc_no";*/
		String strsql="select * from (select veh.fleet_no,veh.reg_no,veh.flname,greet.greetrate,vip.viprate,boque.boquerate,tran.bookdocno,tran.tarifdetaildocno,coalesce(st.statusdesc,'Yet to Confirm') "+
		" status,br.branchname transferfrombranch,tranbr.branchname currentbranch,book.doc_no, book.cldocno,book.guestno,tran.doc_no detaildocno,tran.brandid,"+
		" tran.tarifdocno,tran.modelid,tran.docname,ac.refname,guest.guest,'Transfer' type,null blockhrs,tran.pickupdate, tran.pickuptime,pickup.location"+
		" pickuplocation,tran.pickupadress pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand,model.vtype model,tran.nos from "+
		" gl_limobookm book left join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join gl_limobooksrvc srvc on (book.doc_no=srvc.bookdocno and "+
		" tran.doc_no=srvc.typedocno) left join gl_limoextrasrvctarifd greet on (srvc.greettarifdocno=greet.doc_no and srvc.airportid=greet.airportid) left join"+
		" gl_limoextrasrvctarifd vip on (srvc.viptarifdocno=vip.doc_no and srvc.airportid=vip.airportid) left join gl_limoextrasrvctarifd boque on "+
		" (srvc.boquetarifdocno=boque.doc_no and srvc.airportid=boque.airportid) left join my_acbook ac on  (book.cldocno=ac.cldocno and ac.dtype='CRM') left join "+
		" gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates pickup on  (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on "+
		" (tran.dropfflocid=dropoff.doc_no) left join gl_vehmaster veh on tran.assignedfleet=veh.fleet_no left join gl_vehbrand brd on veh.brdid=brd.doc_no  "+
		" left join gl_vehmodel model on (veh.vmodid=model.doc_no) left join my_brch br on book.brhid=br.doc_no left join my_brch tranbr on  "+
		" tran.transferbranch=tranbr.doc_no left join gl_limostatus st on (tran.masterstatus=st.doc_no) where book.status=3 and tran.masterstatus=3 "+
		" "+sqltest+sqltransferbranch+" union all"+
		" select veh.fleet_no,veh.reg_no,veh.flname,greet.greetrate,vip.viprate,boque.boquerate,hours.bookdocno,hours.tarifdetaildocno,coalesce(st.statusdesc,'Yet to Confirm') status,br.branchname "+
		" transferfrombranch,hoursbr.branchname currentbranch,book.doc_no,book.cldocno, book.guestno,hours.doc_no detaildocno,hours.brandid,hours.tarifdocno,"+
		" hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type, hours.blockhrs,hours.pickupdate, hours.pickuptime,pickup.location pickuplocation,"+
		" hours.pickupaddress,null dropofflocation,null dropoffaddress, brd.brand_name brand,model.vtype model, hours.nos from gl_limobookm book left join "+
		" gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join gl_limobooksrvc srvc on (book.doc_no=srvc.bookdocno and hours.doc_no=srvc.typedocno) left "+
		" join gl_limoextrasrvctarifd greet on (srvc.greettarifdocno=greet.doc_no and srvc.airportid=greet.airportid) left join gl_limoextrasrvctarifd vip on"+
		" (srvc.viptarifdocno=vip.doc_no and srvc.airportid=vip.airportid) left join gl_limoextrasrvctarifd boque on (srvc.boquetarifdocno=boque.doc_no and "+
		" srvc.airportid=boque.airportid) left join my_acbook ac on (book.cldocno=ac.cldocno and  ac.dtype='CRM') left join gl_limoguest guest on "+
		" (book.guestno=guest.doc_no) left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join gl_vehmaster veh on hours.assignedfleet=veh.fleet_no "+
		" left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on (veh.vmodid=model.doc_no) left join my_brch br on book.brhid=br.doc_no "+
		" left join my_brch hoursbr on hours.transferbranch=hoursbr.doc_no  left join gl_limostatus st on (hours.masterstatus=st.doc_no) where book.status=3  and "+
		" hours.masterstatus=3 "+sqltest+sqlhoursbranch+" )a order by a.doc_no";
		System.out.println(strsql);
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		ResultSet rs=stmt.executeQuery(strsql);
		jobdata=objcommon.convertToEXCEL(rs);
		stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return jobdata;
	}

public int CalculateData(String bookdocno,String jobdocno, String jobname , String tarifdocno , String tarifdetaildocno, String startdate , 
			String starttime , String startkm , String enddate , String endtime, String endkm, String fuelchg,String parkingchg , String otherchg , 
			String greetchg , String vipchg , String boquechg,Connection conn) throws SQLException{

	/*	String bookdocno=request.getParameter("bookdocno")==null?"":request.getParameter("bookdocno");
		String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
		String jobname=request.getParameter("jobname")==null?"":request.getParameter("jobname");
		String tarifdocno=request.getParameter("tarifdocno")==null?"":request.getParameter("tarifdocno");
		String tarifdetaildocno=request.getParameter("tarifdetaildocno")==null?"":request.getParameter("tarifdetaildocno");
		String startdate=request.getParameter("startdate")==null?"":request.getParameter("startdate");
		String starttime=request.getParameter("starttime")==null?"":request.getParameter("starttime");
		String startkm=request.getParameter("startkm")==null?"":request.getParameter("startkm");
		String enddate=request.getParameter("enddate")==null?"":request.getParameter("enddate");
		String endtime=request.getParameter("endtime")==null?"":request.getParameter("endtime");
		String endkm=request.getParameter("endkm")==null?"":request.getParameter("endkm");
		String fuelchg=request.getParameter("fuelchg")==null || request.getParameter("fuelchg").equalsIgnoreCase("undefined") || request.getParameter("fuelchg").equalsIgnoreCase("")?"0.0":request.getParameter("fuelchg");
		String parkingchg=request.getParameter("parkingchg")==null || request.getParameter("parkingchg").equalsIgnoreCase("undefined") || request.getParameter("parkingchg").equalsIgnoreCase("")?"0.0":request.getParameter("parkingchg");
		String otherchg=request.getParameter("otherchg")==null || request.getParameter("otherchg").equalsIgnoreCase("undefined") || request.getParameter("otherchg").equalsIgnoreCase("")?"0.0":request.getParameter("otherchg");
		String greetchg=request.getParameter("greetchg")==null || request.getParameter("greetchg").equalsIgnoreCase("undefined") || request.getParameter("greetchg").equalsIgnoreCase("")?"0.0":request.getParameter("greetchg");
		String vipchg=request.getParameter("vipchg")==null || request.getParameter("vipchg").equalsIgnoreCase("undefined") || request.getParameter("vipchg").equalsIgnoreCase("")?"0.0":request.getParameter("vipchg");
		String boquechg=request.getParameter("boquechg")==null || request.getParameter("boquechg").equalsIgnoreCase("undefined") || request.getParameter("boquechg").equalsIgnoreCase("")?"0.0":request.getParameter("boquechg");
	*/	System.out.println(bookdocno+"::"+jobdocno+"::"+jobname+"::"+tarifdocno+"::"+tarifdetaildocno);

		int insertval=0;
		try{
			Statement stmt=conn.createStatement();
			System.out.println("Booking Doc No:"+bookdocno);
			System.out.println("Job Doc No:"+jobdocno);
			System.out.println("Job Name:"+jobname);
			System.out.println("Tarif Master Doc No:"+tarifdocno);
			System.out.println("Tarif Detail Doc No:"+tarifdetaildocno);
			System.out.println("endkm:"+endkm);
			System.out.println("startkm:"+startkm);
			
			//Getting tarif details.
			int guestno=0;
			int cldocno=0;
			int pickuplocid=0,dropofflocid=0;
			double kmrestrict=0.0,tarif=0.0,exkmrate=0.0,extimerate=0.0,exhourrate=0.0,nighttarif=0.0,nightexhourrate=0.0,totalhours=0.0,
					transferextrahours=0.0,totalkm=0.0,extrakm=0.0,extrakmamt=0.0,extrahouramt=0.0,extranighthouramt=0.0,limoexcesshours=0.0,limoexcessdayhours=0.0,limoexcessnighthours=0.0,limonighttarifamt=0.0;
			String timerestrict="",nightstarttime="",nightendtime="",timeafteraddhours="",timeafteraddmins="",jobtype="";
			int blockhrs=0,nightstartmethod=0,nightendmethod=0;
			String strtarif="",strnighttarif="",strtotalhours="",strtransferaddhours="",strtransferaddmins="",strtransferextrahours="",strmaster="",strinsert="",
					strlimoaddhours="",limotimeafteraddhours="",strlimocheckexcesshrs="",strlimo="",strnightlimohours="";
			java.sql.Date sqlstartdate=null,sqlenddate=null;
			ArrayList<String> queryarray=new ArrayList<String>();
			jobtype=jobname.charAt(0)=='T'?"Transfer":"Limo";
			if(!startdate.equalsIgnoreCase("undefined") && !startdate.equalsIgnoreCase("")){
				sqlstartdate=objcommon.changeStringtoSqlDate(startdate);
			}
			if(!enddate.equalsIgnoreCase("undefined") && !enddate.equalsIgnoreCase("")){
				sqlenddate=objcommon.changeStringtoSqlDate(enddate);
			}
			strmaster="select guestno,cldocno from gl_limobookm where status=3 and doc_no="+bookdocno;
			System.out.println("Master Query: "+strmaster);
			ResultSet rsmaster=stmt.executeQuery(strmaster);
			while(rsmaster.next()){
				guestno=rsmaster.getInt("guestno");
				cldocno=rsmaster.getInt("cldocno");
			}
			
			if(jobtype.equalsIgnoreCase("Transfer")){
				//Getting Pickup Location and Dropoff Location
				String strgetlocation="select pickuplocid pickuplocid,dropfflocid dropofflocid,triptype from gl_limobooktransfer where bookdocno="+bookdocno+" and doc_no="+jobdocno;
				String triptype="";
				ResultSet rslocation=stmt.executeQuery(strgetlocation);
				while(rslocation.next()){
					pickuplocid=rslocation.getInt("pickuplocid");
					dropofflocid=rslocation.getInt("dropofflocid");
					triptype=rslocation.getString("triptype");
				}
				if(triptype.equalsIgnoreCase("Arrival")){
					String strgetparkingfee="select round(coalesce(amount,0.0),2) amount from gl_limoparkingfee where status=3 and cldocno="+cldocno+" and locationdocno="+pickuplocid;
					ResultSet rsgetparkingfee=stmt.executeQuery(strgetparkingfee);
					while(rsgetparkingfee.next()){
						parkingchg=rsgetparkingfee.getString("amount");
					}
				}
				//strtarif="select estdist kmrestrict,esttime timerestrict,tarif,exdistrate exkmrate,extimerate from gl_limotariftransfer where doc_no="+tarifdetaildocno;
				/* strtarif="select estdist kmrestrict,esttime timerestrict,tarif,exdistrate exkmrate,extimerate from gl_limotariftransfer where "+
				" gid="+tarifdetaildocno+" and tarifdocno="+tarifdocno+" and pickuplocid="+pickuplocid+" and dropofflocid="+dropofflocid; */
				strtarif="select estdist kmrestrict,esttime timerestrict,tarif,exdistrate exkmrate,extimerate from gl_limobooktransfer where bookdocno="+bookdocno+" and doc_no="+jobdocno;
				System.out.println(strtarif);
				
				
			}
			else if(jobtype.equalsIgnoreCase("Limo")){
				strtarif="select blockhrs,tarif,exhrrate,nighttarif,nightexhrrate from gl_limobookhours where bookdocno="+bookdocno+" and doc_no="+jobdocno;
			}
			ResultSet rstarif=stmt.executeQuery(strtarif);
			while(rstarif.next()){
				if(jobtype.equalsIgnoreCase("Transfer")){
					kmrestrict=rstarif.getDouble("kmrestrict");
					timerestrict=rstarif.getString("timerestrict");
					tarif=rstarif.getDouble("tarif");
					exkmrate=rstarif.getDouble("exkmrate");
					extimerate=rstarif.getDouble("extimerate");
				}
				else if(jobtype.equalsIgnoreCase("Limo")){
					blockhrs=rstarif.getInt("blockhrs");
					tarif=rstarif.getDouble("tarif");
					exhourrate=rstarif.getDouble("exhrrate");
					nighttarif=rstarif.getDouble("nighttarif");
					nightexhourrate=rstarif.getDouble("nightexhrrate");
				}
			}

			//Getting Night start and end from gl_config

			strnighttarif="select (select method from gl_config where field_nme='nightendtime') nightendmethod,"+
				" (select description from gl_config where field_nme='nightendtime') nightendvalue,"+
				" (select method from gl_config where field_nme='nightstarttime') nightstartmethod,"+
				" (select description from gl_config where field_nme='nightstarttime')nightstartvalue";
			ResultSet rsnighttarif=stmt.executeQuery(strnighttarif);
			while(rsnighttarif.next()){
				nightstartmethod=rsnighttarif.getInt("nightstartmethod");
				nightstarttime=rsnighttarif.getString("nightstartvalue");
				nightendmethod=rsnighttarif.getInt("nightendmethod");
				nightendtime=rsnighttarif.getString("nightendvalue");
			}
			
			strtotalhours="select timestampdiff(minute,concat('"+sqlstartdate+"',' ','"+starttime+"'),concat('"+sqlenddate+"',' ','"+endtime+"'))/60 totalhours";
			ResultSet rstotalhours=stmt.executeQuery(strtotalhours);
			while(rstotalhours.next()){
				totalhours=rstotalhours.getDouble("totalhours");
			}
			
			if(jobtype.equalsIgnoreCase("Transfer")){
				
				//To subtract the time restrict;here we add the time restrict with the startdate and time
				
				strtransferaddhours="select DATE_FORMAT(TIMESTAMPADD(HOUR,"+timerestrict.split(":")[0]+",concat('"+sqlstartdate+"',' ','"+starttime+"')), '%H:%i') timeafteraddhours";
				System.out.println(strtransferaddhours);
				ResultSet rstimeafteraddhours=stmt.executeQuery(strtransferaddhours);
				while(rstimeafteraddhours.next()){
					timeafteraddhours=rstimeafteraddhours.getString("timeafteraddhours");
				}
				
				strtransferaddmins="select DATE_FORMAT(TIMESTAMPADD(MINUTE,"+timerestrict.split(":")[1]+",concat('"+sqlstartdate+"',' ','"+timeafteraddhours+"')), '%H:%i') timeafteraddmins";
				System.out.println(strtransferaddmins);
				ResultSet rstimeafteraddmins=stmt.executeQuery(strtransferaddmins);
				while(rstimeafteraddmins.next()){
					timeafteraddmins=rstimeafteraddmins.getString("timeafteraddmins");
				}
				
				strtransferextrahours="select TIMESTAMPDIFF(MINUTE,concat('"+sqlstartdate+"',' ','"+timeafteraddmins+"'),concat('"+sqlenddate+"',' ','"+endtime+"'))/60 transferextrahours";
				System.out.println(strtransferextrahours);
				ResultSet rstransferextrahours=stmt.executeQuery(strtransferextrahours);
				while(rstransferextrahours.next()){
					transferextrahours=rstransferextrahours.getDouble("transferextrahours");
				}
			}
			else if(jobtype.equalsIgnoreCase("Limo")){
				
				//To subtract the time restrict,here we add the block hours whith the start date and time.
				
				strlimoaddhours="select DATE_FORMAT(TIMESTAMPADD(HOUR,"+blockhrs+",concat('"+sqlstartdate+"',' ','"+starttime+"')), '%H:%i') limotimeafteraddhours";
				
				ResultSet rslimoafteraddhours=stmt.executeQuery(strlimoaddhours);
				while(rslimoafteraddhours.next()){
					limotimeafteraddhours=rslimoafteraddhours.getString("limotimeafteraddhours");
				}
				
				//Checking end time is less than time after adding block hours and therby finding excess hours.
				
				strlimocheckexcesshrs="select if(endtime<blocktime,0,timestampdiff(minute,blocktime,endtime)/60) limoexcesshrs from ("+
				" select timestamp(concat('"+sqlenddate+"',' ','"+endtime+"')) endtime,timestamp(concat('"+sqlstartdate+"',' ','"+limotimeafteraddhours+"')) blocktime)m";
				ResultSet rslimocheckblockhrs=stmt.executeQuery(strlimocheckexcesshrs);
				System.out.println("Total Limo Excess Hours Query: "+strlimocheckexcesshrs);
				while(rslimocheckblockhrs.next()){
					limoexcesshours=rslimocheckblockhrs.getDouble("limoexcesshrs");
				}
				//Getting Night Hours
				//1.Check End time is greater than night starttime then nighthours=endtime-nightstarttime
				//2.Check end time is greater than night nightendtime then nighthours=nightendtime-nightstarttime
				//3.Check end time is less than night starttime then nighthours=0;
				//4.Day hours=totalexcesshours-nighthours.
				if(sqlstartdate.compareTo(sqlenddate)==0){
					strnightlimohours="select case when (endtime>=nightstarttime and endtime<=nightendtime) then timestampdiff(minute,nightstarttime,endtime)/60"+
					" when (endtime>=nightstarttime and endtime>nightendtime) then timestampdiff(minute,nightstarttime,nightendtime)/60"+
					" when endtime<nightstarttime then 0 else 0 end nighthours from (select concat('"+sqlenddate+"',' ','"+endtime+"') endtime,"+
					" concat('"+sqlstartdate+"',' ','"+nightstarttime+"') nightstarttime,concat(date_add('"+sqlenddate+"',interval 1 day),' ','"+nightendtime+"') nightendtime)m";
				}
				else if(sqlstartdate.compareTo(sqlenddate)>0){
					strnightlimohours="select case when (endtime>=nightstarttime and endtime<=nightendtime) then timestampdiff(minute,nightstarttime,endtime)/60"+
					" when (endtime>=nightstarttime and endtime>nightendtime) then timestampdiff(minute,nightstarttime,nightendtime)/60"+
					" when endtime<nightstarttime then 0 else 0 end nighthours from (select concat('"+sqlenddate+"',' ','"+endtime+"') endtime,"+
					" concat('"+sqlstartdate+"',' ','"+nightstarttime+"') nightstarttime,concat('"+sqlenddate+"',' ','"+nightendtime+"') nightendtime)m";
				}
				else{
					System.out.println("else condition");

				}
					System.out.println("Night Checking"+strnightlimohours);
					ResultSet rsnightlimohours=stmt.executeQuery(strnightlimohours);
					while(rsnightlimohours.next()){
						limoexcessnighthours=rsnightlimohours.getDouble("nighthours");
					}	
					limoexcessnighthours=limoexcessnighthours<0?limoexcessnighthours*-1:limoexcessnighthours;
				
				limoexcessdayhours=limoexcesshours-limoexcessnighthours;
				
			}
			
			//Calculating Total kms and charges
			totalkm=Double.parseDouble(endkm)-Double.parseDouble(startkm);
			extrakm=totalkm-kmrestrict;
			if(extrakm>0){
				extrakmamt=extrakm*exkmrate;
			}
				
			//Calculating extra hour charge.
			if(jobtype.equalsIgnoreCase("Transfer")){
				if(transferextrahours>0){
					extrahouramt=transferextrahours*extimerate;
				}
			}
			else if(jobtype.equalsIgnoreCase("Limo")){
				if(limoexcessdayhours>0){
					extrahouramt=limoexcessdayhours*exhourrate;
				}
				if(limoexcessnighthours>0){
					extranighthouramt=limoexcessnighthours*nightexhourrate;
					limonighttarifamt=nighttarif;
				}
			}
			

			if(jobtype.equalsIgnoreCase("Transfer")){
				double tot=0.0;
				String strtot="select "+tarif+"+"+extrakmamt+"+"+extrahouramt+"+"+fuelchg+"+"+parkingchg+"+"+otherchg+"+"+greetchg+"+"+vipchg+"+"+boquechg+" total";
				ResultSet rstotal=stmt.executeQuery(strtot);
				while(rstotal.next()){
					tot=rstotal.getDouble("total");
				}
				System.out.println("Tot: "+tot);
				strinsert="insert into gl_limojobclosecalc(bookdocno,jobdocno,jobtype,jobname,guestno,total,tarif,exkmchg,exhrchg,fuelchg,parkingchg,otherchg,greetchg,vipchg,boquechg,status,startdate,starttime,startkm,closedate,closetime,closekm)values("+bookdocno+","+jobdocno+",'"+jobtype+"','"+jobname+"',"+guestno+","+tot+","+tarif+","+extrakmamt+","+extrahouramt+","+fuelchg+","+parkingchg+","+otherchg+","+greetchg+","+vipchg+","+boquechg+",3,'"+sqlstartdate+"','"+starttime+"',"+startkm+",'"+sqlenddate+"','"+endtime+"',"+endkm+")";
			}
			else if(jobtype.equalsIgnoreCase("Limo")){
				double tot=0.0;
				String strtot="select "+tarif+"+"+extrahouramt+"+"+extranighthouramt+"+"+limonighttarifamt+"+"+fuelchg+"+"+parkingchg+"+"+otherchg+"+"+greetchg+"+"+vipchg+"+"+boquechg+" total";
				ResultSet rstotal=stmt.executeQuery(strtot);
				while(rstotal.next()){
					tot=rstotal.getDouble("total");
				}
				strinsert="insert into gl_limojobclosecalc(bookdocno,jobdocno,jobtype,jobname,guestno,total,tarif,nighttarif,exhrchg,exnighthrchg,fuelchg,parkingchg,otherchg,greetchg,vipchg,boquechg,status,startdate,starttime,startkm,closedate,closetime,closekm)values("+bookdocno+","+jobdocno+",'"+jobtype+"','"+jobname+"',"+guestno+","+tot+","+tarif+","+limonighttarifamt+","+extrahouramt+","+extranighthouramt+","+fuelchg+","+parkingchg+","+otherchg+","+greetchg+","+vipchg+","+boquechg+",3,'"+sqlstartdate+"','"+starttime+"',"+startkm+",'"+sqlenddate+"','"+endtime+"',"+endkm+")";
				
			}
			Statement stmtinsert=conn.createStatement();
			Statement stmtdelete=conn.createStatement();
			String strdelete="delete from gl_limojobclosecalc where bookdocno="+bookdocno+" and jobdocno="+jobdocno+" and jobtype='"+jobtype+"'";
			int deleteval=stmtdelete.executeUpdate(strdelete);
			insertval=stmtinsert.executeUpdate(strinsert);
			if(insertval>0){
			}
//			return insertval;
		}
		catch(Exception e){
			//return 0;
			e.printStackTrace();
		}
		finally{
		}
		return insertval;
	}
}