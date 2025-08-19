package com.dashboard.limousine.booking;

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

import net.sf.jasperreports.data.json.JsonDataAdapter;
import net.sf.json.JSONArray;

public class ClsLimoBookingDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getFleetData() throws SQLException{
		JSONArray fleetdata=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select veh.fleet_no,convert(concat(fleet_no,' - ',veh.reg_no,' - ',veh.flname),char(250)) flname from gl_vehmaster veh where veh.statu=3 and veh.status='IN' and veh.limostatus=1";
			ResultSet rs=stmt.executeQuery(strsql);
			fleetdata=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return fleetdata;
	}
	public JSONArray gridData(String branch,String id,String fromdate,String todate) throws SQLException{
		JSONArray RESULTDATA=new JSONArray();               
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and bm.brhid="+branch+"";  
			}
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and bm.pickupdate>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and bm.pickupdate<='"+sqltodate+"'";
			}
		    String strsql="select bm.bstatus,round(bm.vendoramount,2) vendoramount,round(bm.vendordiscount,2) vendordiscount,round(bm.vendornetamount,2) vendornetamount,bm.assigntype,bm.refno,bm.triptype,bm.otherdetails,bm.pax,concat(coalesce(veh.reg_no,''),' - ',coalesce(plt.code_name,'')) regdetails,coalesce(bm.bookremarks,'') bookremarks,coalesce(bm.drivername,'') drivername,coalesce(bm.groupname,'') groupname,bm.tarifdocno,bm.tarifdetaildocno,if(date_format(now(),'%Y-%m-%d')=bm.pickupdate,1,0) datval,bm.rowno, coalesce(bm.docno,0) docno, bm.brhid, bm.job, bm.client, bm.clientid, bm.guest, bm.guestid,"
		    		+ " bm.type, st.name status, bm.blockhrs, bm.pickupdate, bm.pickuptime,bm.plocation pickuplocation,bm.paddress pickupaddress,"
		    		+ " bm.dlocation dropofflocation,bm.daddress dropoffaddress, bm.brand, bm.model, bm.fname, bm.fno, bm.nos, coalesce(bm.tdocno,0) tdocno, bm.remarks "
		    		+ " from gl_limomanagement bm left join gl_limostatusdet st on st.doc_no=bm.bstatus left join gl_vehmaster veh on (bm.fno=veh.fleet_no and statu=3) left join gl_vehplate plt on veh.pltid=plt.doc_no where bm.confirm=0  "+sqltest+" order by pickupdate,pickuptime asc ";
		       
			//System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			RESULTDATA=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA;  
	}  
	public JSONArray gridExcel(String branch,String id) throws SQLException{
		JSONArray RESULTDATA=new JSONArray();               
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="",sqltransferbranch="",sqlhoursbranch="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and bm.brhid="+branch+"";  
			}
		    String strsql="select date_format(bm.pickupdate,'%d.%m.%Y') 'Pickup date', bm.pickuptime 'Pickup time',coalesce(bm.otherdetails,'') 'Other Details',coalesce(bm.fname,'') 'Fleet Name',"+
			" concat(coalesce(veh.reg_no,''),' - ',coalesce(plt.code_name,'')) 'Fleet',coalesce(bm.drivername,'') 'Driver',coalesce(bm.pax,'') 'PAX',"+
		    " coalesce(bm.groupname,'') 'Group',coalesce(bm.bookremarks,'') 'Booking Remarks',bm.paddress 'Pickup address',bm.daddress 'Dropoff address',"+
			" coalesce(bm.guest,'') 'Guest',coalesce(bm.client,'') 'Client',coalesce(bm.triptype,'') 'Trip Type',bm.docno 'Doc No',bm.job 'Job',bm.type 'Type', st.name 'Status',"+
			" bm.plocation 'Pickup Location',bm.dlocation 'Dropoff Location',bm.remarks 'Remarks' from "+
			" gl_limomanagement bm left join gl_limostatusdet st on st.doc_no=bm.bstatus  left join gl_vehmaster veh on (bm.fno=veh.fleet_no and statu=3) left join gl_vehplate plt on veh.pltid=plt.doc_no  where bm.confirm=0 "+sqltest+"";
		                        
			//System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			RESULTDATA=objcommon.convertToEXCEL(rs);  
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA;  
	}
	public JSONArray getDriverData()throws SQLException{      
		JSONArray driverdata=new JSONArray();
		Connection conn=null;
		try{
			String sqltest="";
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();        
			String strsql="select doc_no,sal_name name,lic_no license,date,mobile from my_salesman where sal_type='DRV' and status=3";
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
	public JSONArray searchuser(HttpSession session) throws SQLException{
		JSONArray data=new JSONArray();                                      
		Connection conn=null; 
		 java.sql.Date edates = null;     
		try{
			conn=objconn.getMyConnection();  
			Statement stmt=conn.createStatement();
			        
			String strsql="select user_name user,doc_no from my_user";  
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
	
	public JSONArray loadflwupgrid(String docno) throws SQLException{ 
		JSONArray data=new JSONArray(); 
		Connection conn=null; 
		java.sql.Date edates = null; 
		try{
		conn=objconn.getMyConnection(); 
		Statement stmt=conn.createStatement(); 
		
		String strsql="select f.ass_date date,u.user_name asuser,r.user_name user,f.remarks remark,f.action_status status from an_taskcreationdets f left join my_user u on u.doc_no=f.userid left join my_user r on r.doc_no=f.assnfrom_user where f.rdocno='"+docno+"'"; 
		//System.out.println("flwp--->>>"+strsql); 
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
	public JSONArray pendingGrid(String userid) throws SQLException{  
		JSONArray data=new JSONArray();                      
		Connection conn=null; 
		 java.sql.Date edates = null;     
		try{
			conn=objconn.getMyConnection();  
			Statement stmt=conn.createStatement();     
			        
			String strsql="select  us.user_name crtuser,u.user_name user,t.userid,ass_user,t.doc_no,ref_type,ref_no,strt_date,strt_time,description,act_status status from an_taskcreation t left join an_taskcreationdets a on t.doc_no=a.rdocno left join my_user us on us.doc_no=t.userid left join my_user u on u.doc_no=t.ass_user where  (t.userid='"+userid+"' or t.ass_user='"+userid+"') and t.close_status=0 and t.utype!='app' group by doc_no";        
			//System.out.println("pendingGrid--->>>"+strsql);                                 
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
	
}