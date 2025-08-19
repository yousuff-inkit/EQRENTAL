package com.limousine.jobassignmentmultiplebus;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.limousine.limobooking.ClsLimoBookingDAO;
import com.operations.vehicletransactions.movement.ClsMovementDAO;
import com.sms.SmsAction;

import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

public class ClsJobAssignMultipleBusDAO {
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	
	public JSONArray getVendorData(String id)throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select cldocno,refname from my_acbook where dtype='VND' and status=3";
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
	public JSONArray getBookCounterData(String date,String id,String branch) throws SQLException{
		JSONArray counterdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return counterdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			java.sql.Statement stmt=conn.createStatement();
			java.sql.Date sqldate=null;
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
			}
			
			String strsql="select book.doc_no,book.voc_no,ac.refname from gl_limobookm book left join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join"+
			" gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM')"+
			" where book.status=3 and book.date<='"+sqldate+"' and  (tran.assignstatus=0 or hours.assignstatus=0) and book.detailstatus<>3 group by book.doc_no"; 
			System.out.println("COUNT === "+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			counterdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return counterdata;
	}
	
	public JSONArray getDetailData(String uptodate,String id,String branch,String chkuptodate,String fromdate,String todate) throws SQLException{
		JSONArray detaildata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return detaildata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqluptodate=null;
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!uptodate.equalsIgnoreCase("")){
				sqluptodate=objcommon.changeStringtoSqlDate(uptodate);
			}
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			String strtransfer="",strhours="";
			String strdatecondition="";
			if(chkuptodate.equalsIgnoreCase("1")){
				strdatecondition=" and book.date<='"+sqluptodate+"'";
			}
			else{
				strdatecondition=" and book.date>='"+sqlfromdate+"' and book.date<='"+sqltodate+"'";
			}
			strtransfer=" book.status=3 "+strdatecondition+" and tran.assignstatus=0 and book.detailstatus<>3 and tran.masterstatus<>4";
			strhours=" book.status=3 "+strdatecondition+" and hours.assignstatus=0 and book.detailstatus<>3 and hours.masterstatus<>4";
			/*book.status=3 and book.detailstatus<>3 and book.doc_no="+bookdocno+" and
				(tran.assignstatus=0) and (tran.transferbranch=0 or tran.transferbranch="+branch+") and tran.masterstatus<>4
				book.status=3 and book.doc_no="+bookdocno+" and (hours.assignstatus=0) and (hours.transferbranch=0 or hours.transferbranch="+branch+") 
				and hours.masterstatus<>4
			*/
			String strsql="select * from (select coalesce(tran.refno,'') refno,coalesce(tran.remarks,'') remarks,coalesce(tran.otherdetails,'') otherdetails,tran.gid,grp.gname groupname,grp.doc_no groupid,tran.tarifdocno,tran.estdist estdistance,tran.esttime,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate,"+
			" tran.tarifdetaildocno,tran.detailupdate,book.doc_no bookdocno,'Update' btnupdate,tran.pickuplocid pickuplocationid,tran.dropfflocid dropofflocationid,coalesce(tran.guestdetails,'') guestdetails,convert(coalesce(tran.pax,1),char(5)) pax,coalesce(tran.vehdetails,'') vehdetails,coalesce(book.locationtype,'') loctype,coalesce(case when book.locationtype='flight' then book.flightno else book.roomno end,'') locrefno,coalesce(case when book.locationtype='flight' then book.airport else book.hotel end,'') locrefname,tran.transfertype,book.doc_no,book.cldocno,book.guestno,tran.doc_no detaildocno,tran.brandid,tran.modelid,tran.docname,ac.refname,guest.guest,'Transfer' type,null blockhrs,tran.pickupdate,"+
			" tran.pickuptime,pickup.location pickuplocation,tran.pickupadress pickupaddress,dropoff.location dropofflocation,tran.dropoffaddress,brd.brand_name brand,"+
			" model.vtype model,tran.nos from gl_limobookm book left join gl_limobooktransfer tran on (book.doc_no=tran.bookdocno) left join my_acbook ac on"+
			" (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no) left join gl_cordinates"+
			" pickup on (tran.pickuplocid=pickup.doc_no) left join gl_cordinates dropoff on (tran.dropfflocid=dropoff.doc_no) left join gl_vehbrand"+
			" brd on tran.brandid=brd.doc_no left join gl_vehmodel model on (tran.modelid=model.doc_no) left join gl_vehgroup grp on (tran.gid=grp.doc_no) where "+strtransfer+" and (tran.transferbranch=0 or tran.transferbranch="+branch+") union all"+
			" select '' refno,'' remarks,'' otherdetails,hours.gid,grp.gname groupname,grp.doc_no groupid,hours.tarifdocno,0 estdistance,'' esttime,hours.tarif,0 exdistancerate,0 extimerate,"+
			" hours.tarifdetaildocno,0 detailupdate,book.doc_no bookdocno,'Update' btnupdate,0 pickuplocationid,0 dropofflocationid,'' guestdetails,'' pax,'' vehdetails,coalesce(book.locationtype,'') loctype,coalesce(case when book.locationtype='flight' then book.flightno else book.roomno end,'') locrefno,coalesce(case when book.locationtype='flight' then book.airport else book.hotel end,'') locrefname,hours.transfertype,book.doc_no,book.cldocno,book.guestno,hours.doc_no detaildocno,hours.brandid,hours.modelid,hours.docname,ac.refname,guest.guest,'Limo' type,hours.blockhrs,hours.pickupdate,"+
			" hours.pickuptime,pickup.location pickuplocation,hours.pickupaddress,null dropofflocation,null dropoffaddress,brd.brand_name brand,"+
			" model.vtype model,hours.nos from gl_limobookm book left join gl_limobookhours hours on (book.doc_no=hours.bookdocno) left join"+
			" my_acbook ac on (book.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_limoguest guest on (book.guestno=guest.doc_no)"+
			" left join gl_cordinates pickup on (hours.pickuplocid=pickup.doc_no) left join gl_vehbrand"+
			" brd on (hours.brandid=brd.doc_no) left join gl_vehmodel model on (hours.modelid=model.doc_no) left join gl_vehgroup grp on (hours.gid=grp.doc_no) where "+strhours+" and (hours.transferbranch=0 or hours.transferbranch="+branch+") ) aa order by CAST(concat(aa.pickupdate,' ',aa.pickuptime)AS DATETIME)";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			detaildata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return detaildata;
	}
	public JSONArray getDriverData(String docno,String name,String mobile,String license,String date,String id)throws SQLException{
		JSONArray driverdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return driverdata;
		}
		Connection conn=null;
		try{
			String sqltest="";
			if(!docno.equalsIgnoreCase("")){
				sqltest+=" and doc_no like '%"+docno+"%'";
			}
			if(!name.equalsIgnoreCase("")){
				sqltest+=" and sal_name like '%"+name+"%'";
			}
			if(!mobile.equalsIgnoreCase("")){
				sqltest+=" and mobile like '%"+mobile+"%'";
			}
			if(!license.equalsIgnoreCase("")){
				sqltest+=" and lic_no like '%"+license+"%'";
			}
			java.sql.Date sqldate=null;
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
			}
			if(sqldate!=null){
				sqltest+=" and date like '"+sqldate+"'";
			}
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,sal_name name,lic_no license,date,mobile from my_salesman where sal_type='DRV' and status=3"+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			driverdata=objcommon.convertToJSON(rs);
			stmt.close();
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return driverdata;
	}
	public JSONArray getFleetData(String fleetno,String fleetname,String brand,String model,String group,String allfleets,
			String gridbrandid,String gridmodelid,String id,String regno,String gridgroupid) throws SQLException{
		JSONArray fleetdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return fleetdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(allfleets.equalsIgnoreCase("0")){
				//sqltest+=" and veh.brdid="+gridbrandid+" and veh.vmodid="+gridmodelid;
				sqltest+=" and veh.vgrpid="+gridgroupid;
			}
			else if(allfleets.equalsIgnoreCase("1")){
				System.out.println("Inside All Fleets");
				if(!fleetno.equalsIgnoreCase("")){
					sqltest+=" and veh.fleet_no like '%"+fleetno+"%'";
				}
				if(!fleetname.equalsIgnoreCase("")){
					sqltest+=" and veh.flname like '%"+fleetname+"%'";
				}
				if(!brand.equalsIgnoreCase("")){
					sqltest+=" and veh.brdid="+brand;
				}
				if(!model.equalsIgnoreCase("")){
					sqltest+=" and veh.vmodid="+model;
				}
				if(!group.equalsIgnoreCase("")){
					sqltest+=" and veh.vgrpid="+group;
				}
				if(!regno.equalsIgnoreCase("")){
					sqltest+=" and veh.reg_no like '%"+regno+"%' ";
				}
			}
			
			String strsql="select veh.reg_no ,veh.fleet_no,veh.flname,brd.brand_name brand,model.vtype model,grp.gname from gl_vehmaster veh left join gl_vehbrand brd on"+
			" veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no where"+
			" veh.statu=3 and veh.status='IN' and veh.limostatus=1 "+sqltest;
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			fleetdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return fleetdata;
	}







	public ArrayList<String> insert(Date sqluptodate, String cmbprocess, String hiddriver,
			String fleetno, String cmbtransferbranch, int bookdocno,
			int detaildocno, HttpSession session, String mode, String formdetailcode,String brchname, HttpServletRequest request, 
			String type, ArrayList<String> jobarray,String hidvendor)throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int docno=0;
		int vocno=0;
		int errorstatus=0;
		ArrayList<String> docarray=new ArrayList<>();
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtassign=conn.createStatement();
			for(int i=0;i<jobarray.size();i++){
				String temp[]=jobarray.get(i).split("::");
				bookdocno=Integer.parseInt(temp[0]);
				String jobname=temp[1];
				detaildocno=Integer.parseInt(temp[2]);
				type=temp[3];
				CallableStatement stmtJob =conn.prepareCall("{call limoJobAssignDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				stmtJob.registerOutParameter(14, java.sql.Types.INTEGER);
				stmtJob.registerOutParameter(15, java.sql.Types.INTEGER);
				stmtJob.setDate(1, sqluptodate);
				stmtJob.setInt(2, Integer.parseInt(temp[0]));
				stmtJob.setInt(3, Integer.parseInt(temp[2]));
				stmtJob.setString(4, cmbprocess);
				stmtJob.setString(5, hiddriver==null || hiddriver.equalsIgnoreCase("")?"0":hiddriver);
				stmtJob.setString(6, fleetno==null || fleetno.equalsIgnoreCase("")?"0":fleetno);
				stmtJob.setString(7, cmbtransferbranch==null || cmbtransferbranch.equalsIgnoreCase("")?"0":cmbtransferbranch);
				stmtJob.setString(8, hidvendor.equalsIgnoreCase("")?"0":hidvendor);
				stmtJob.setString(9, mode);
				stmtJob.setString(10, formdetailcode);
				stmtJob.setString(11, brchname);
				stmtJob.setString(12, session.getAttribute("USERID").toString());
				stmtJob.setString(13, session.getAttribute("COMPANYID").toString());
				stmtJob.executeQuery();
				docno=stmtJob.getInt("docNo");
				vocno=stmtJob.getInt("voc");
				if(docno<=0){
					errorstatus=1;
					return docarray;
				}
				else{
					String strupdate="update gl_jobassign set booktype='"+type+"' where doc_no="+docno;
					int update=stmtassign.executeUpdate(strupdate);
					String strassignupdate="";
					String strbranchtran="";
					/*  1-Branch Transfer
			    	2-Assignment
			    	3-External Vendors  */
					
					if(cmbprocess.equalsIgnoreCase("1")){
						if(type.equalsIgnoreCase("Transfer")){
							strbranchtran="update gl_limobooktransfer set transferbranch="+cmbtransferbranch+" where doc_no="+detaildocno;
						}
						else if(type.equalsIgnoreCase("Limo")){
							strbranchtran="update gl_limobookhours set transferbranch="+cmbtransferbranch+" where doc_no="+detaildocno;
						}
						int updatebranch=stmtassign.executeUpdate(strbranchtran);
						if(updatebranch<0){
							return docarray;
						}
						String strupdatelimomgmt="update gl_limomanagement set assigntype=1 where docno="+bookdocno+" and job='"+jobname+"'";
						int updatelimomgmt=stmtassign.executeUpdate(strupdatelimomgmt);
						if(updatelimomgmt<=0){
							errorstatus=1;
							return docarray;
						}
					}
					else if(cmbprocess.equalsIgnoreCase("2")){
						
						String strgetfleet="select veh.fleet_no,veh.flname,brd.brand_name brand,model.vtype model from gl_vehmaster veh left join "+
						" gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehmodel model on veh.vmodid=model.doc_no where veh.statu=3 and "+
						" veh.fleet_no="+fleetno;
						ResultSet rsgetfleet=stmtassign.executeQuery(strgetfleet);
						String fleetname="",brand="",model="";
						while(rsgetfleet.next()){
							fleetname=rsgetfleet.getString("flname");
							brand=rsgetfleet.getString("brand");
							model=rsgetfleet.getString("model");
						}
						if(type.equalsIgnoreCase("Transfer")){
							strassignupdate="update gl_limobooktransfer set assignstatus=1,masterstatus=3,assignedfleet="+fleetno+",assigneddriver="+hiddriver+" where doc_no="+detaildocno;
						}
						else if(type.equalsIgnoreCase("Limo")){
							strassignupdate="update gl_limobookhours set assignstatus=1,masterstatus=3,assignedfleet="+fleetno+",assigneddriver="+hiddriver+" where doc_no="+detaildocno;
							System.out.println("============== "+strassignupdate);
						}
						int assignval=stmtassign.executeUpdate(strassignupdate);
						if(assignval<=0){
							return docarray;
						}
						else{
							String strgetdriver="select doc_no,sal_name name from my_salesman where sal_type='DRV' and status=3 and doc_no="+hiddriver;
							ResultSet rsgetdriver=stmtassign.executeQuery(strgetdriver);
							String drivername="";
							while(rsgetdriver.next()){
								drivername=rsgetdriver.getString("name");
							}
							String strupdatelimomgmt="update gl_limomanagement set bstatus=2,assigntype=2,fname='"+fleetname+"',fno='"+fleetno+"',brand='"+brand+"',model='"+model+"',drivername='"+drivername+"' where docno="+bookdocno+" and job='"+jobname+"'";
							int updatelimomgmt=stmtassign.executeUpdate(strupdatelimomgmt);
							if(updatelimomgmt<=0){
								return docarray;
							}
							
							/*//Getting details for movement insertion
							java.sql.Date sqlcurrentdate=null;
							String jobname="";
							String strgetmovdetails="select doc_no,kmin,fin,CURDATE() currentdate from gl_vmove where doc_no=(select max(doc_no) from gl_vmove where fleet_no="+fleetno+")";
							Statement stmt=conn.createStatement();
							ResultSet rsmovdetails=stmt.executeQuery(strgetmovdetails);
							String maxmovdoc="",maxmovkm="",maxmovfuel="";
							while(rsmovdetails.next()){
								maxmovdoc=rsmovdetails.getString("doc_no");
								maxmovkm=rsmovdetails.getString("kmin");
								maxmovfuel=rsmovdetails.getString("fin");
								sqlcurrentdate=rsmovdetails.getDate("currentdate");
							}
							String strjobdetails="";
							if(type.equalsIgnoreCase("Transfer")){
								strjobdetails="select concat(bookdocno,' - ',docname) jobname from gl_limobooktransfer where doc_no="+detaildocno;
							}
							else if(type.equalsIgnoreCase("Limo")){
								strjobdetails="select concat(bookdocno,' - ',docname) jobname from gl_limobookhours where doc_no="+detaildocno;
							}
							ResultSet rsjobdetails=stmt.executeQuery(strjobdetails);
							while(rsjobdetails.next()){
								jobname=rsjobdetails.getString("jobname");
							}
							String strvehtrancode="select (select tran_code from gl_vehmaster where fleet_no="+fleetno+") tran_code,(select doc_no from my_locm where brhid="+brchname+""+
							" and status=3 limit 1) locid";
							String vehtrancode="",outlocation="";
							ResultSet rsveh=stmt.executeQuery(strvehtrancode);
							while(rsveh.next()){
								vehtrancode=rsveh.getString("tran_code");
								outlocation=rsveh.getString("locid");
							}
							String remarks="Limousine movement of type "+type+" for "+jobname;
							String outuser=session.getAttribute("USERID").toString();
							ClsMovementDAO movdao=new ClsMovementDAO();
							int movinsert=movdao.insert(sqlcurrentdate, dateout, fleetno, outlocation, timeout, maxmovkm, maxmovfuel, "TR", hiddriver, remarks, 
							outuser, null, 0, null, 0.0, null, null, "A", session, 0, 0, 0, 0,0, "MOV", brchname, vehtrancode);*/
							
							//2016-09-20::2016-09-10::1010348::5::10:28::62666.00::0.125::TR::1::Checking Values for Limousine::::null::0::null::0.0::null::null::
							//A::session::0::0::0::0::0::MOV::1::RR
							
						}
						String strgetsmsdet="select mobile,sal_name name from my_salesman where sal_type='DRV' and doc_no="+hiddriver;
						String mobile="",name="";
						ResultSet rssmsdet=stmtassign.executeQuery(strgetsmsdet);
						while(rssmsdet.next()){
							mobile=rssmsdet.getString("mobile");
							name=rssmsdet.getString("name");
						}
						SmsAction sms=new SmsAction();
						String smsdoctype="";
						if(type.equalsIgnoreCase("Transfer")){
							smsdoctype="LJT";
						}
						else if(type.equalsIgnoreCase("Limo")){
							smsdoctype="LJL";
						}
						sms.doSendSms(mobile,name, "", detaildocno+"", "",smsdoctype, brchname,conn);
						
					}
					else if(cmbprocess.equalsIgnoreCase("3")){
						
						if(type.equalsIgnoreCase("Transfer")){
							strassignupdate="update gl_limobooktransfer set assignedvendor="+hidvendor+" where doc_no="+detaildocno;
						}
						else if(type.equalsIgnoreCase("Limo")){
							strassignupdate="update gl_limobookhours set assignedvendor="+hidvendor+" where doc_no="+detaildocno;
							System.out.println("============== "+strassignupdate);
						}
						int assignval=stmtassign.executeUpdate(strassignupdate);
						if(assignval<=0){
							return docarray;
						}
						String strgetsmsdet="select coalesce(per_mob,'') mobile,refname name from my_acbook where dtype='VND' and cldocno="+hidvendor;
						String mobile="",name="";
						ResultSet rssmsdet=stmtassign.executeQuery(strgetsmsdet);
						while(rssmsdet.next()){
							mobile=rssmsdet.getString("mobile");
							name=rssmsdet.getString("name");
						}
						double vendortarif=getVendorTarif(conn,bookdocno,jobname);
						String strupdatelimomgmt="update gl_limomanagement set vendoramount="+vendortarif+", vendornetamount="+vendortarif+",bstatus=2,assigntype=3,drivername='"+name+"' where docno="+bookdocno+" and job='"+jobname+"'";
						System.out.println(strupdatelimomgmt);
						int updatelimomgmt=stmtassign.executeUpdate(strupdatelimomgmt);
						if(updatelimomgmt<0){
							errorstatus=1;
							return docarray;
						}
					}
					
				}
				docarray.add(docno+"::"+vocno);
			}
			if(errorstatus==0){
				conn.commit();
				request.setAttribute("VOCNO", vocno);
				return docarray;		

			}
			}
		
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return docarray;
	}
	
	private double getVendorTarif(Connection conn, int bookdocno, String jobname) {
		// TODO Auto-generated method stub
		String tarifdocno="",tarifdetaildocno="",estdistance="",esttime="",tarif="",exdistancerate="",extimerate="";
		double vendortarif=0.0;
		try{
			Statement stmt=conn.createStatement();
			String jobtype="";
			if(jobname.charAt(0)=='T'){
				jobtype="Transfer";
			}
			else{
				jobtype="Limo";
			}
			String strchecknecessary="";
			if(jobtype.equalsIgnoreCase("Transfer")){
				strchecknecessary="select pickuplocid pickuplocid,dropfflocid dropofflocid,gid groupid,m.cldocno,ac.catid,tran.transfertype,tran.assignedvendor from gl_limobooktransfer "+
				" tran left join gl_limobookm m on (tran.bookdocno=m.doc_no) left join my_acbook ac on (tran.assignedvendor=ac.cldocno and ac.dtype='VND') "+
				" where tran.bookdocno="+bookdocno+" and tran.docname='"+jobname+"'";		
			}
			else if(jobtype.equalsIgnoreCase("Limo")){
				strchecknecessary="select pickuplocid pickuplocid,hrs.blockhrs,gid groupid,m.cldocno,ac.catid,hrs.transfertype,hrs.assignedvendor from"+
				" gl_limobookhours hrs left join gl_limobookm m on (hrs.bookdocno=m.doc_no) left join my_acbook ac on (hrs.assignedvendor=ac.cldocno"+
				" and ac.dtype='VND') where hrs.bookdocno="+bookdocno+" and hrs.docname='"+jobname+"'";
			}
			
			ResultSet rschecknecessary=stmt.executeQuery(strchecknecessary);
			int pickuplocation=0,dropofflocation=0,group=0,cldocno=0,catid=0,vendorid=0;
			double blockhrs=0.0;
			String transfertype="";
			while(rschecknecessary.next()){
				pickuplocation=rschecknecessary.getInt("pickuplocid");
				if(jobtype.equalsIgnoreCase("Transfer")){
					dropofflocation=rschecknecessary.getInt("dropofflocid");	
				}
				else{
					blockhrs=rschecknecessary.getDouble("blockhrs");
				}
				group=rschecknecessary.getInt("groupid");
				cldocno=rschecknecessary.getInt("cldocno");
				catid=rschecknecessary.getInt("catid");
				vendorid=rschecknecessary.getInt("assignedvendor");
				transfertype=rschecknecessary.getString("transfertype");
			}
			if(pickuplocation>0 && dropofflocation>0 && group>0 && jobtype.equalsIgnoreCase("Transfer")){
				int isFound=0;
				if(isFound==0){
					String strgettarif="select m.doc_no,m.validto,m.tariftype,m.tarifvendor,m.desc1,tran.estdist estdistance,tran.doc_no "+
					" tarifdetaildocno,tran.esttime,tran.gid,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate from gl_limovendortarifm m left join gl_limovendortariftransfer tran on"+
					" tran.tarifdocno=m.doc_no  where current_date between m.validfrom and m.validto and m.status=3 and (tran.gid="+group+" and tran.pickuplocid="+pickuplocation+""+ 
					" and tran.dropofflocid="+dropofflocation+") and m.tariftype='Vendor' and m.tarifvendor="+vendorid+" and m.tariffor='"+transfertype+"' group by m.doc_no";
					System.out.println(strgettarif);
					ResultSet rsgettarifnew=stmt.executeQuery(strgettarif);
					while(rsgettarifnew.next()){
						tarifdocno=rsgettarifnew.getString("doc_no");
						tarifdetaildocno=rsgettarifnew.getString("tarifdetaildocno");
						estdistance=rsgettarifnew.getString("estdistance");
						esttime=rsgettarifnew.getString("esttime");
						tarif=rsgettarifnew.getString("tarif");
						exdistancerate=rsgettarifnew.getString("exdistancerate");
						extimerate=rsgettarifnew.getString("extimerate");
						isFound=1;
					}
				}
				if(isFound==0){
					String strgettarif="select m.doc_no,m.validto,m.tariftype,m.tarifvendor,m.desc1,tran.estdist estdistance,tran.doc_no "+
					" tarifdetaildocno,tran.esttime,tran.gid,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate from gl_limovendortarifm m left join gl_limovendortariftransfer tran on"+
					" tran.tarifdocno=m.doc_no  where current_date between m.validfrom and m.validto and m.status=3 and (tran.gid="+group+" and tran.pickuplocid="+pickuplocation+""+ 
					" and tran.dropofflocid="+dropofflocation+") and m.tariftype='Corporate' and m.tarifvendor="+catid+" and m.tariffor='"+transfertype+"' group by m.doc_no";
					System.out.println(strgettarif);
					ResultSet rsgettarifnew=stmt.executeQuery(strgettarif);
					while(rsgettarifnew.next()){
						tarifdocno=rsgettarifnew.getString("doc_no");
						tarifdetaildocno=rsgettarifnew.getString("tarifdetaildocno");
						estdistance=rsgettarifnew.getString("estdistance");
						esttime=rsgettarifnew.getString("esttime");
						tarif=rsgettarifnew.getString("tarif");
						exdistancerate=rsgettarifnew.getString("exdistancerate");
						extimerate=rsgettarifnew.getString("extimerate");
						isFound=1;
					}
				}
			}
			else if(group>0 && jobtype.equalsIgnoreCase("Limo")){
				int isFound=0;
				if(isFound==0){
					String strgettarif="select m.doc_no,m.validto,m.tariftype,m.tarifvendor,m.desc1,hrs.doc_no tarifdetaildocno,hrs.gid,"+
					" hrs.tarif,hrs.exhrrate,hrs.nighttarif,hrs.nightexhrrate from gl_limovendortarifm m left"+
					" join gl_limovendortarifhours hrs on hrs.tarifdocno=m.doc_no where current_date between m.validfrom and m.validto and"+
					" m.status=3 and (hrs.gid="+group+" and hrs.blockhrs="+blockhrs+") and m.tariftype='Vendor' and m.tarifvendor="+vendorid+" and m.tariffor='"+transfertype+"'"+
					" group by m.doc_no";
					System.out.println(strgettarif);
					ResultSet rsgettarifnew=stmt.executeQuery(strgettarif);
					while(rsgettarifnew.next()){
						tarifdocno=rsgettarifnew.getString("doc_no");
						tarifdetaildocno=rsgettarifnew.getString("tarifdetaildocno");
						tarif=rsgettarifnew.getString("tarif");	
						isFound=1;
					}
				}
				if(isFound==0){
					String strgettarif="select m.doc_no,m.validto,m.tariftype,m.tarifvendor,m.desc1,hrs.doc_no tarifdetaildocno,hrs.gid,"+
					" hrs.tarif,hrs.exhrrate,hrs.nighttarif,hrs.nightexhrrate from gl_limovendortarifm m left"+
					" join gl_limovendortarifhours hrs on hrs.tarifdocno=m.doc_no where current_date between m.validfrom and m.validto and"+
					" m.status=3 and (hrs.gid="+group+" and hrs.blockhrs="+blockhrs+") and m.tariftype='corporate' and m.tarifvendor="+catid+" and m.tariffor='"+transfertype+"'"+
					" group by m.doc_no";
					System.out.println(strgettarif);
					ResultSet rsgettarifnew=stmt.executeQuery(strgettarif);
					while(rsgettarifnew.next()){
						tarifdocno=rsgettarifnew.getString("doc_no");
						tarifdetaildocno=rsgettarifnew.getString("tarifdetaildocno");
						tarif=rsgettarifnew.getString("tarif");	
						isFound=1;
					}
				}
			}
			if(!tarif.equalsIgnoreCase("")){
				vendortarif=Double.parseDouble(tarif);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return vendortarif;
	}
	public  JSONArray getLocations(String id) throws SQLException {
	    JSONArray locdata=new JSONArray();
	    Connection conn = null;
		try {
			conn=objconn.getMyConnection();
			Statement stmtTarif = conn.createStatement ();
			String strSql="select doc_no,location from gl_cordinates where status=3";
	    	ResultSet resultSet = stmtTarif.executeQuery (strSql);
	    	locdata=objcommon.convertToJSON(resultSet);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
	    return locdata;
	}
	
	public JSONArray getBrandData(String id) throws SQLException{
		JSONArray branddata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return branddata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select brd.brand_name brand,brd.doc_no from gl_vehmaster veh left join gl_vehbrand brd on veh.brdid=brd.doc_no where veh.dtype='VEH' and"+
			" veh.statu=3 and veh.limostatus=1 group by brd.doc_no";
			ResultSet rs=stmt.executeQuery(strsql);
			branddata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return branddata;
	}
	
	public JSONArray getGroupData(String id) throws SQLException{
		JSONArray groupdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return groupdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select gname groupname,doc_no from gl_vehgroup where status=3";
			ResultSet rs=stmt.executeQuery(strsql);
			groupdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return groupdata;
	}
	public JSONArray getModelData(String brandid,String id) throws SQLException{
		JSONArray modeldata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return modeldata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select model.vtype model,model.doc_no from gl_vehmaster veh left join gl_vehmodel model on veh.vmodid=model.doc_no where"+
			" veh.dtype='VEH' and veh.statu=3 and veh.limostatus=1 and model.brandid="+brandid+" group by model.doc_no";
			ResultSet rs=stmt.executeQuery(strsql);
			modeldata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return modeldata;
	}
	
	public JSONArray getTarifData(String tarifmode,String brandid,String modelid,String pickuplocid,String dropofflocid,String blockhrs,
			String cldocno,String transfertype,String id,String groupid) throws SQLException{
		JSONArray tarifdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return tarifdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			/*int groupid=0;
		//	System.out.println("Group Query: select veh.vgrpid groupid from gl_vehmaster veh where veh.brdid="+brandid+" and veh.vmodid="+modelid+" and veh.dtype='VEH' and veh.statu=3 and veh.limostatus=1 group by veh.vgrpid");
			ResultSet rsgroup=stmt.executeQuery("select veh.vgrpid groupid from gl_vehmaster veh where veh.brdid="+brandid+" and veh.vmodid="+modelid+" and veh.dtype='VEH' and veh.statu=3 and veh.limostatus=1 group by veh.vgrpid");
			while (rsgroup.next()) {
				groupid=rsgroup.getInt("groupid");
			}*/
			int clientcatid=0;
			String clientcatname="";
			String clientname="";
			String strclientcategory="select cat.doc_no,cat.cat_name,ac.refname from my_acbook ac left join my_clcatm cat on ac.catid=cat.doc_no where ac.cldocno="+cldocno+" and ac.dtype='CRM';";
			ResultSet rsclientcat=stmt.executeQuery(strclientcategory);
			while(rsclientcat.next()){
				clientcatid=rsclientcat.getInt("doc_no");
				clientcatname=rsclientcat.getString("cat_name");
				clientname=rsclientcat.getString("refname");
			}
			
			String strsql="";
			if(tarifmode.equalsIgnoreCase("transferGrid")){
			strsql="select * from (select m.doc_no,m.validto,concat(m.tariftype,' - ','"+clientname+"',' - ',m.desc1) tariftype,m.tarifclient,tran.gid,tran.doc_no "+
			" tarifdetaildocno,tran.estdist estdistance,tran.esttime,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate from gl_limotarifm  m left join"+
			" gl_limotariftransfer tran on tran.tarifdocno=m.doc_no where current_date between m.validfrom and m.validto and m.status=3 and (tran.gid="+groupid+" and "+
			" tran.pickuplocid="+pickuplocid+" and tran.dropofflocid="+dropofflocid+") and m.tariftype='Client' and m.tarifclient="+cldocno+" and m.tariffor='"+transfertype+"' group by m.doc_no union all "+
			" select aa.doc_no,aa.validto,concat(aa.tariftype,' - ','"+clientcatname+"',' - ',aa.desc1) tariftype,aa.doc_no tarifdetaildocno,aa.gid,aa.tarifclient,aa.estdistance,"+
			" aa.esttime,aa.tarif,aa.exdistancerate,aa.extimerate from (select m.doc_no,m.validto,m.tariftype,m.tarifclient,m.desc1,tran.estdist estdistance,tran.doc_no "+
			" tarifdetaildocno,tran.esttime,tran.gid,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate from gl_limotarifm m left join gl_limotariftransfer tran on"+
			" tran.tarifdocno=m.doc_no  where current_date between m.validfrom and m.validto and m.status=3 and (tran.gid="+groupid+" and tran.pickuplocid="+pickuplocid+" "+
			" and tran.dropofflocid="+dropofflocid+") and m.tariftype='Corporate' and m.tarifclient="+clientcatid+" and m.tariffor='"+transfertype+"' group by m.doc_no) aa union all"+
			" select m.doc_no,m.validto,concat(m.tariftype,' - ',m.desc1) tariftype,m.tarifclient,tran.doc_no tarifdetaildocno,tran.gid,tran.estdist estdistance,"+
			" tran.esttime,tran.tarif,tran.exdistrate exdistancerate,tran.extimerate from gl_limotarifm  m left join gl_limotariftransfer tran on tran.tarifdocno=m.doc_no  "+
			" where current_date between m.validfrom and m.validto and m.status=3 and (tran.gid="+groupid+" and tran.pickuplocid="+pickuplocid+" and "+
			" tran.dropofflocid="+dropofflocid+") and m.tariftype='regular' and m.tariffor='"+transfertype+"' group by m.doc_no) zz ";
			}
			else if(tarifmode.equalsIgnoreCase("hoursGrid")){
				strsql="select * from (select m.doc_no,m.validto,concat(m.tariftype,' - ','"+clientname+"',' - ',m.desc1)  tariftype,m.tarifclient,hours.doc_no "+
				" tarifdetaildocno,hours.gid,hours.blockhrs,hours.tarif,hours.exhrrate,hours.nighttarif,hours.nightexhrrate from gl_limotarifm  m left join "+
				" gl_limotarifhours hours on hours.tarifdocno=m.doc_no where current_date between m.validfrom and m.validto and m.status=3 and (hours.gid="+groupid+" "+
				" and hours.blockhrs="+blockhrs+") and m.tariftype='Client' and m.tarifclient="+cldocno+" and m.tariffor='"+transfertype+"' group by m.doc_no union all"+
				" select aa.doc_no,aa.validto,concat(aa.tariftype,' - ','"+clientcatname+"',' - ',aa.desc1) tariftype,aa.doc_no tarifdetaildocno,aa.gid,aa.tarifclient,"+
				" aa.blockhrs,aa.tarif,aa.exhrrate,aa.nighttarif,aa.nightexhrrate from (select m.doc_no,m.validto,m.tariftype,m.tarifclient,m.desc1,hours.doc_no "+
				" tarifdetaildocno,hours.blockhrs,hours.tarif,hours.exhrrate,hours.nighttarif,hours.nightexhrrate,hours.gid from gl_limotarifm m left join "+
				" gl_limotarifhours hours on hours.tarifdocno=m.doc_no where current_date between m.validfrom and m.validto and m.status=3 and (hours.gid="+groupid+" and "+
				" hours.blockhrs="+blockhrs+") and m.tariftype='Corporate' and m.tarifclient="+clientcatid+" and m.tariffor='"+transfertype+"' group by m.doc_no) aa union all"+
				" select m.doc_no,m.validto,concat(m.tariftype,' - ',m.desc1) tariftype,m.tarifclient,hours.doc_no tarifdetaildocno,hours.gid,hours.blockhrs,hours.tarif,"+
				" hours.exhrrate,hours.nighttarif,hours.nightexhrrate from gl_limotarifm  m left join gl_limotarifhours hours on hours.tarifdocno=m.doc_no "+
				" where current_date between m.validfrom and m.validto and m.status=3 and (hours.gid="+groupid+" and hours.blockhrs="+blockhrs+") and m.tariftype='regular'"+
				"  and m.tariffor='"+transfertype+"' group by m.doc_no) zz ";
			}
			System.out.println("Tarif Query: "+strsql);
				ResultSet rs=stmt.executeQuery(strsql);
				tarifdata=objcommon.convertToJSON(rs);	
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return tarifdata;
	}
}
