package com.dashboard.travel.travel;
    
	import com.common.ClsCommon;
import com.connection.ClsConnection;

	import java.sql.*;

	import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
	public class ClsTravelDAO {  

		ClsConnection objconn=new ClsConnection();     
		ClsCommon objcommon=new ClsCommon();     
		
		public JSONArray detailGrid(HttpSession session, String check,String todate,String branch,String location) throws SQLException{ 
			JSONArray data=new JSONArray(); 
			if(!check.equalsIgnoreCase("1")){    
				return data;
			}
			Connection conn=null; 
			java.sql.Date edates = null;   
			try{  
			conn=objconn.getMyConnection();   
			Statement stmt=conn.createStatement();
			String sqltest="",sqltest2="";   
			java.sql.Date sqltodate=null;
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){  
				sqltest+=" and det.brhid="+branch;
				sqltest2+=" and m.brhid="+branch;
			}
			if(!location.equalsIgnoreCase("") && !location.equalsIgnoreCase("0")){  
				sqltest+=" and det.locid="+location;
				sqltest2+=" and m.locid="+location;  
			}
			if( sqltodate!=null){
					sqltest+=" and det.date<='"+sqltodate+"'";   
					sqltest2+=" and m.fromdt<='"+sqltodate+"'";            
			}
			//String strsql="select 'Service Request' type,date,det.doc_no,det.doc_no voc_no,det.cldocno,det.refname client,det.mob,det.email,sum(det.visacount) visa,sum(det.ticketcount) ticket,sum(det.hotelcount) hotel,sum(transfercount) transfer,sum(tourcount) tour,sum(micecount) mice,0 total,0 vndid,0 rowno,'' hotelname,det.loc_name location,det.locid,coalesce(jvtrno,0) jvtrno,coalesce(limodocno,0) limodocno,disper from (select coalesce(pl.per,0) disper,m.limodocno,m.invtrno jvtrno,m.locid,l.loc_name,m.brhid,m.date,m.doc_no,ac.cldocno,m.refname,m.mob,m.mail email,coalesce(visa.pax,0) visacount,coalesce(ticket.pax,0) ticketcount,coalesce(hotel.pax,0) hotelcount,coalesce(transfer.pax,0) transfercount,coalesce(tour.pax,0) tourcount,coalesce(mice.pax,0) micecount from TR_servicereqm m left join TR_servicereqd visa on VISA.servid=1 and m.doc_no=visa.rdocno left join TR_servicereqd ticket on TICKET.servid=2 and m.doc_no=ticket.rdocno left join TR_servicereqd hotel on HOTEL.servid=3 and m.doc_no=hotel.rdocno left join TR_servicereqd transfer on TRANSFER.servid=4 and m.doc_no=transfer.rdocno left join TR_servicereqd tour on TOUR.servid=5 and m.doc_no=tour.rdocno left join TR_servicereqd mice on MICE.servid=6 and m.doc_no=mice.rdocno left join my_acbook ac on m.cldocno=ac.cldocno and ac.dtype='CRM' left join my_locm l on l.doc_no=m.locid left join my_clprivilage pl on pl.doc_no=ac.privilage and ac.dtype='crm') det where 1=1 "+sqltest+" group by det.DOC_NO union all select 'Hotel Booking' type,m.fromdt date,m.doc_no,m.voc_no,m.cldocno,m.clientname client,m.mobile mob,m.email,0 visa,0 ticket,COUNT(*) hotel,0 transfer,0 tour,0 mice,d.totalval total,h.vendorid vndid,d.rowno,h.name hotelname,l.loc_name location,m.locid,0 jvtrno,0 limodocno,0 disper  from tr_bookingm m left join tr_bookingd d on m.doc_no=d.rdocno left join tr_hotel h on h.doc_no=d.hotelid left join my_locm l on l.doc_no=m.locid where m.status=3 "+sqltest2+" GROUP BY M.DOC_NO";
			
			String strsql="select 'Service Request' type, adultdismax,  childdismax,childdis, adultdis,date,det.doc_no,det.voc_no,det.cldocno,det.refname client,det.mob,det.email,sum(det.visacount) visa,sum(det.ticketcount) ticket,sum(det.hotelcount) hotel,sum(transfercount) transfer,sum(tourcount) tour,sum(micecount) mice,0 total,0 vndid,0 rowno,'' hotelname,det.loc_name location,det.locid,coalesce(jvtrno,0) jvtrno,coalesce(limodocno,0) limodocno,disper,confirm,cstatus,agentid from (select case when cstatus=1 then 'XO Created' when cstatus=2 then 'XO Confirmed' when cstatus=3 then 'Comm. Receipt Created' when cstatus=4 then 'Invoice Created' else  'Entered' end as cstatus,coalesce(d.adultdismax,0) adultdismax, coalesce(d.childdismax,0) childdismax,coalesce(tr.childdis,0) childdis,coalesce(tr.adultdis,0) adultdis,tr.confirm,coalesce(pl.per,0) disper,m.agentid,m.limodocno,m.invtrno jvtrno,m.locid,l.loc_name,m.brhid,m.date,m.voc_no,m.doc_no,ac.cldocno,m.refname,m.mob,m.mail email,coalesce(visa.pax,0) visacount,coalesce(ticket.pax,0) ticketcount,coalesce(hotel.pax,0) hotelcount,coalesce(transfer.pax,0) transfercount,coalesce(tour.pax,0) tourcount,coalesce(mice.pax,0) micecount from TR_servicereqm m left join TR_servicereqd visa on VISA.servid=1 and m.doc_no=visa.rdocno left join TR_servicereqd ticket on TICKET.servid=2 and m.doc_no=ticket.rdocno left join TR_servicereqd hotel on HOTEL.servid=3 and m.doc_no=hotel.rdocno left join TR_servicereqd transfer on TRANSFER.servid=4 and m.doc_no=transfer.rdocno left join TR_servicereqd tour on TOUR.servid=5 and m.doc_no=tour.rdocno left join TR_servicereqd mice on MICE.servid=6 and m.doc_no=mice.rdocno left join my_acbook ac on m.cldocno=ac.cldocno and ac.dtype='CRM' left join my_locm l on l.doc_no=m.locid left join my_clprivilage pl on pl.doc_no=ac.privilage and ac.dtype='crm' left join tr_srtour tr on m.doc_no=tr.rdocno left join tr_prtourd d on d.rowno=tr.tourdocno group by tr.rowno) det where 1=1 "+sqltest+" group by det.DOC_NO";
	        System.out.println("travel Grid--->>>"+strsql);                   
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

				String strsql=" select f.ass_date date,u.user_name asuser,r.user_name user,f.remarks remark,f.action_status status from an_taskcreationdets f left join my_user u on u.doc_no=f.userid left join my_user r on r.doc_no=f.assnfrom_user where f.rdocno='"+docno+"'"; 
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
			
			public JSONArray servicetypeGrid(HttpSession session) throws SQLException{
				JSONArray data=new JSONArray();                                      
				Connection conn=null; 
				 java.sql.Date edates = null;     
				try{
					conn=objconn.getMyConnection();  
					Statement stmt=conn.createStatement();
					             
					String strsql="select name,doc_no from tr_servicetype where status=3";  
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
		public JSONArray searchclient(HttpSession session) throws SQLException{
			JSONArray data=new JSONArray();                                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{ 
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();     
				String strsql="select pl.per disper,refname user,cldocno doc_no,per_mob mob,mail1 mail,g.nationality nationid,t.nation,coalesce(ms.sal_name,'') salesman,ms.doc_no salid from my_acbook ac left join my_salm ms on ms.doc_no=ac.sal_id left join gl_sponsor g on g.doc_no=ac.doc_no left join my_natm t on t.doc_no=g.nationality left join my_clprivilage pl on pl.doc_no=ac.privilage and ac.dtype='crm' where dtype='crm'";  
				//System.out.println("strsql-------------->>>"+strsql);
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
		public JSONArray searchAgentclient(HttpSession session) throws SQLException{
			JSONArray data=new JSONArray();                                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{ 
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();     
				String strsql="select refname user,cldocno doc_no from my_acbook where catid=8 and status<>7 and dtype='crm'";  
				//System.out.println("strsql-------------->>>"+strsql);  
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
		public JSONArray searchvisa(HttpSession session) throws SQLException{
			JSONArray data=new JSONArray();                                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();
				        
				String strsql="select name visa,doc_no,validity from tr_visatype";  
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
		
		public JSONArray searchNation(HttpSession session) throws SQLException{
			JSONArray data=new JSONArray();                                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();
				        
				String strsql="select nation,doc_no from my_natm"; 
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
		public JSONArray searchSalesman() throws SQLException{                                  
			JSONArray data=new JSONArray();                                      
			Connection conn=null;                                
			try{
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();
				        
				String strsql="select sal_name,doc_no from my_salm"; 
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
		public JSONArray searchNation(HttpSession session,String natid) throws SQLException{
			JSONArray data=new JSONArray();                                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();
				        
				String strsql="select nation,doc_no from my_natm where doc_no='"+natid+"'";     
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
		public JSONArray searchRoomtype(HttpSession session) throws SQLException{
			JSONArray data=new JSONArray();                                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();
				        
				String strsql="select distinct name roomtype from tr_roomtype where status=3"; 
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
		
		public JSONArray searchPtype(HttpSession session) throws SQLException{
			JSONArray data=new JSONArray();                                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();
				        
				String strsql="select name,doc_no from tr_package"; 
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
		
		public JSONArray searchTourtype(HttpSession session) throws SQLException{
			JSONArray data=new JSONArray();                                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();  
				        
				String strsql="select name,doc_no,transport,private privateval from tr_tours where status=3"; 
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
		public JSONArray searchVendor(HttpSession session) throws SQLException{
			JSONArray data=new JSONArray();                                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{
				conn=objconn.getMyConnection();     
				Statement stmt=conn.createStatement();  
				        
				String strsql="select refname name,doc_no,cmode from my_acbook where dtype='vnd' and status=3";
				//System.out.println("strsql====="+strsql);
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
		public JSONArray searchVendor(HttpSession session,int tourid,String dates) throws SQLException{
			JSONArray data=new JSONArray();                                      
			Connection conn=null; 
			try{  
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();      
				java.sql.Date sqltodate=null;
				if(!dates.equalsIgnoreCase("") && !dates.equalsIgnoreCase("0")){                 
					sqltodate=objcommon.changeStringtoSqlDate(dates);         
				}
				//String strsql="select * from(select ac.cmode,t.rowno,refname name,doc_no,t.adult,t.spadult,t.child,t.spchild,coalesce(t.adultdismax,0) admaxdis, coalesce(t.childdismax,0) chmaxdis from tr_prtourd t inner join my_acbook ac on ac.doc_no=t.vendorid and ac.dtype='vnd' where t.tourid='"+tourid+"' and t.days=dayname('"+sqltodate+"') and '"+sqltodate+"' between t.fdate and t.tdate and t.offer=1  and t.status=3 union all select ac.cmode,t.rowno,refname name,doc_no,t.adult,t.spadult,t.child,t.spchild,coalesce(t.adultdismax,0) admaxdis, coalesce(t.childdismax,0) chmaxdis from tr_prtourd t inner join my_acbook ac on ac.doc_no=t.vendorid and ac.dtype='vnd' where t.tourid='"+tourid+"' and t.days=dayname('"+sqltodate+"') and  t.fdate is null and t.offer=1  and t.status=3 union all select ac.cmode,t.rowno,refname name,doc_no,t.adult,t.spadult,t.child,t.spchild,coalesce(t.adultdismax,0) admaxdis, coalesce(t.childdismax,0) chmaxdis from tr_prtourd t inner join my_acbook ac on ac.doc_no=t.vendorid and ac.dtype='vnd' where t.tourid='"+tourid+"' and '"+sqltodate+"' between t.fdate and t.tdate and t.offer=1 and t.days=''  and t.status=3 union all select ac.cmode,t.rowno,refname name,doc_no,t.adult,t.spadult,t.child,t.spchild,coalesce(t.adultdismax,0) admaxdis, coalesce(t.childdismax,0) chmaxdis from tr_prtourd t inner join my_acbook ac on ac.doc_no=t.vendorid and ac.dtype='vnd' where t.tourid='"+tourid+"' and t.fdate is null and t.offer=1  and t.days=''  and t.status=3  union all select ac.cmode,t.rowno,refname name,doc_no,t.adult,t.spadult,t.child,t.spchild,coalesce(t.adultdismax,0) admaxdis, coalesce(t.childdismax,0) chmaxdis from tr_prtourd t inner join my_acbook ac on ac.doc_no=t.vendorid and ac.dtype='vnd' where t.tourid='"+tourid+"' and t.days=dayname('"+sqltodate+"') and '"+sqltodate+"' between t.fdate and t.tdate and t.offer=0  and t.status=3 union all select ac.cmode,t.rowno,refname name,doc_no,t.adult,t.spadult,t.child,t.spchild,coalesce(t.adultdismax,0) admaxdis, coalesce(t.childdismax,0) chmaxdis from tr_prtourd t inner join my_acbook ac on ac.doc_no=t.vendorid and ac.dtype='vnd' where t.tourid='"+tourid+"' and t.days=dayname('"+sqltodate+"') and  t.fdate is null and t.offer=0  and t.status=3 union all select ac.cmode,t.rowno,refname name,doc_no,t.adult,t.spadult,t.child,t.spchild,coalesce(t.adultdismax,0) admaxdis, coalesce(t.childdismax,0) chmaxdis from tr_prtourd t inner join my_acbook ac on ac.doc_no=t.vendorid and ac.dtype='vnd' where t.tourid='"+tourid+"' and '"+sqltodate+"' between t.fdate and t.tdate and t.offer=0 and t.days=''  and t.status=3 union all select ac.cmode,t.rowno,refname name,doc_no,t.adult,t.spadult,t.child,t.spchild,coalesce(t.adultdismax,0) admaxdis, coalesce(t.childdismax,0) chmaxdis from tr_prtourd t inner join my_acbook ac on ac.doc_no=t.vendorid and ac.dtype='vnd' where t.tourid='"+tourid+"' and t.fdate is null and t.offer=0  and t.days='' and t.status=3)a group by doc_no";  
				String strsql="select a.* from(select ts.stockid,sum(coalesce(ts.adult,0)) adultcount,sum(coalesce(ts.child,0)) childcount,'stock' type,0 cmode,ts.stockid rowno,concat(u.user_name,' - ',(select coalesce(ac.refname,'') refname from my_account acc left join my_acbook ac on ac.acno=acc.acno where acc.codeno='Stock Vendor')) name,(select coalesce(ac.cldocno,0) cldocno from my_account acc left join my_acbook ac on ac.acno=acc.acno where acc.codeno='Stock Vendor') doc_no,ts.cpadult adult,ts.spadult,ts.cpchild child,ts.spchild,0 admaxdis, 0 chmaxdis from tr_tourstock ts left join my_user u on u.doc_no=ts.userid where ts.tourid='"+tourid+"' group by ts.tourid)a where (a.adultcount>0 or a.childcount>0) "  
						+ "union all select 0 stockid,0 adultcount,0 childcount,'tour' type,a.cmode,a.rowno,a.name,a.doc_no,a.adult,a.spadult,a.child,a.spchild,a.admaxdis,a.chmaxdis from(select ac.cmode,"
						+ "t.rowno,refname name,doc_no,t.adult,t.spadult,t.child,t.spchild,coalesce(t.adultdismax,0) admaxdis, coalesce(t.childdismax,0) chmaxdis from "
						+ "tr_prtourd t inner join my_acbook ac on ac.doc_no=t.vendorid and ac.dtype='vnd' where t.tourid='"+tourid+"' and t.days=dayname('"+sqltodate+"') "
						+ "and '"+sqltodate+"' between t.fdate and t.tdate and t.offer=1  and t.status=3 union all select ac.cmode,t.rowno,refname name,doc_no,"
						+ "t.adult,t.spadult,t.child,t.spchild,coalesce(t.adultdismax,0) admaxdis, coalesce(t.childdismax,0) chmaxdis from tr_prtourd t "
						+ "inner join my_acbook ac on ac.doc_no=t.vendorid and ac.dtype='vnd' where t.tourid='"+tourid+"' and t.days=dayname('"+sqltodate+"') and  "
						+ "t.fdate is null and t.offer=1  and t.status=3 union all select ac.cmode,t.rowno,refname name,doc_no,t.adult,t.spadult,t.child,t.spchild,"
						+ "coalesce(t.adultdismax,0) admaxdis, coalesce(t.childdismax,0) chmaxdis from tr_prtourd t inner join my_acbook ac on ac.doc_no=t.vendorid and ac.dtype='vnd'"
						+ " where t.tourid='"+tourid+"' and '"+sqltodate+"' between t.fdate and t.tdate and t.offer=1 and t.days=''  and t.status=3 union all select ac.cmode,t.rowno,"
						+ "refname name,doc_no,t.adult,t.spadult,t.child,t.spchild,coalesce(t.adultdismax,0) admaxdis, coalesce(t.childdismax,0) chmaxdis from tr_prtourd t inner join "
						+ "my_acbook ac on ac.doc_no=t.vendorid and ac.dtype='vnd' where t.tourid='"+tourid+"' and t.fdate is null and t.offer=1  and t.days=''  and t.status=3  "
						+ "union all select ac.cmode,t.rowno,refname name,doc_no,t.adult,t.spadult,t.child,t.spchild,coalesce(t.adultdismax,0) admaxdis, coalesce(t.childdismax,0) chmaxdis from "
						+ "tr_prtourd t inner join my_acbook ac on ac.doc_no=t.vendorid and ac.dtype='vnd' where t.tourid='"+tourid+"' and t.days=dayname('"+sqltodate+"') and '"+sqltodate+"' "
						+ "between t.fdate and t.tdate and t.offer=0  and t.status=3 union all select ac.cmode,t.rowno,refname name,doc_no,t.adult,t.spadult,t.child,t.spchild,"
						+ "coalesce(t.adultdismax,0) admaxdis, coalesce(t.childdismax,0) chmaxdis from tr_prtourd t inner join my_acbook ac on ac.doc_no=t.vendorid and ac.dtype='vnd' "
						+ "where t.tourid='"+tourid+"' and t.days=dayname('"+sqltodate+"') and  t.fdate is null and t.offer=0  and t.status=3 union all select ac.cmode,t.rowno,refname name,"
						+ "doc_no,t.adult,t.spadult,t.child,t.spchild,coalesce(t.adultdismax,0) admaxdis, coalesce(t.childdismax,0) chmaxdis from tr_prtourd t inner join my_acbook ac on ac.doc_no=t.vendorid and ac.dtype='vnd'"
						+ " where t.tourid='"+tourid+"' and '"+sqltodate+"' between t.fdate and t.tdate and t.offer=0 and t.days=''  and t.status=3 union all select ac.cmode,t.rowno,refname name,doc_no,t.adult,t.spadult,"
						+ "t.child,t.spchild,coalesce(t.adultdismax,0) admaxdis, coalesce(t.childdismax,0) chmaxdis from tr_prtourd t inner join my_acbook ac on ac.doc_no=t.vendorid and ac.dtype='vnd' where t.tourid='"+tourid+"' "
						+ "and t.fdate is null and t.offer=0  and t.days='' and t.status=3)a group by doc_no";      
				
				System.out.println("strsql===re=="+strsql);                     
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
		public JSONArray serviceGrid(String rdocno) throws SQLException{    
			JSONArray data=new JSONArray();                      
			Connection conn=null; 
			 java.sql.Date edates = null;       
			try{
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();     
				        
				String strsql="select rowno,coalesce(doc_no,0) serdocno,coalesce(servicetype,'') servicetype,coalesce(remarks,'') remarks,convert(coalesce(pax,0),char(50)) pax from (select d.servid doc_no,s.name servicetype,d.remarks,d.pax,d.rowno from tr_servicereqd d left join tr_servicetype s on s.doc_no=d.servid where rdocno='"+rdocno+"' union all select  doc_no,name servicetype,'' remarks,'' pax,0 rowno from tr_servicetype) a group by doc_no";
				//System.out.println("serviceGrid--->>>"+strsql);                                 
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
				        
				String strsql="select  u.user_name user,t.userid,ass_user,t.doc_no,ref_type,ref_no,strt_date,strt_time,description,act_status status from an_taskcreation t left join an_taskcreationdets a on t.doc_no=a.rdocno left join my_user u on u.doc_no=t.ass_user where  (t.userid='"+userid+"' or t.ass_user='"+userid+"') and t.close_status=0 and t.utype!='app' group by doc_no";        
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
		
		public JSONArray visaGrid(String rdocno) throws SQLException{  
			JSONArray data=new JSONArray();                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();     
				        
				String strsql="select m.rowno,m.name givenname, surname, v.name vtype,v.validity visaval, nation nationality, passportno passno,issuefrom issuedfrom,'Attach' attach,DATE_FORMAT(validupto,'%d.%m.%Y') vupto, remarks,m.visaid vdocno,m.natid from tr_srvisa m left join tr_visatype v on v.doc_no=m.visaid left join my_natm n on n.doc_no=m.natid where rdocno="+rdocno+"";        
				//System.out.println("visa--->>>"+strsql);                                 
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
		
		public JSONArray ticketGrid(String rdocno) throws SQLException{  
			JSONArray data=new JSONArray();                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();     
				String strsql="select rowno,ptype,issuefrom issuedfrom,'Attach' attach,DATE_FORMAT(validupto,'%d.%m.%Y') vupto,DATE_FORMAT(date,'%d.%m.%Y') date,name givenname,passportno passno, surname, passportno,  fromdest, todest, m.remarks from tr_srticket m   where rdocno="+rdocno+"";        
				//System.out.println("ticketGrid--->>>"+strsql);                                 
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
		
		public JSONArray hotelGrid(String rdocno,String type) throws SQLException{  
			JSONArray data=new JSONArray();                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();   
				if(type.equalsIgnoreCase("Service Request")){
					String strsql="select 'Attach' attach,DATE_FORMAT(fromdt,'%d.%m.%Y') fromdate,DATE_FORMAT(todate,'%d.%m.%Y') todate,p.name package,r.name rtype, guestname, m.remarks,'' vendor,'' vendorid,0 total,'' hotelname,'' location,m.rowno,m.packageid,m.rtypeid from tr_srhotel m left join tr_package p on p.doc_no=m.packageid left join tr_roomtype r on r.doc_no=m.rtypeid  where rdocno="+rdocno+"";        
					//System.out.println("hotelGrid--->>>"+strsql);                                 
					ResultSet rs=stmt.executeQuery(strsql);
					data=objcommon.convertToJSON(rs);   
				}else if(type.equalsIgnoreCase("Hotel Booking")){
					String strsql="select 'Attach' attach,DATE_FORMAT(fromdt,'%d.%m.%Y') fromdate,DATE_FORMAT(todt,'%d.%m.%Y') todate,'' package,r.name rtype,'' guestname,'' remarks,ac.refname vendor,ac.cldocno vendorid,d.totalval total,h.name hotelname,l.loc_name location,d.rowno  from tr_bookingm m left join tr_bookingd d on d.rdocno=m.doc_no left join tr_hotel h on d.hotelid=h.doc_no left join my_locm l on l.doc_no=m.locid left join tr_roomtype r on r.doc_no=d.roomtype left join my_acbook ac on h.vendorid=ac.doc_no and ac.dtype='vnd' where d.rdocno="+rdocno+" order by vendorid";        
					//System.out.println("hotelGrid--->>>"+strsql);                                 
					ResultSet rs=stmt.executeQuery(strsql);
					data=objcommon.convertToJSON(rs);
				}else{}
				  
			}   
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();  
			}
			return data;
		} 
		
		public JSONArray transferGrid(String rdocno) throws SQLException{  
			JSONArray data=new JSONArray();                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();     
				        
				String strsql="select rowno,fromdest, todest, name guestname, vehicle,pax noofpax,remarks,DATE_FORMAT(date,'%d.%m.%Y') date,time from tr_srtransfer  where rdocno="+rdocno+"";        
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
		public JSONArray accsearch_ap() throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        Connection conn=null; 
			try {
					conn=objconn.getMyConnection();      
					Statement stmt=conn.createStatement();    
					ResultSet resultSet = stmt.executeQuery ("select sal_name description,acc_no acno,doc_no from my_salesman where sal_type='sla'");
					RESULTDATA=objcommon.convertToJSON(resultSet);  
					stmt.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
			}
	        return RESULTDATA;
	    }
		public JSONArray tourGrid(String rdocno) throws SQLException{  
			JSONArray data=new JSONArray();                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{
				conn=objconn.getMyConnection();    
				Statement stmt=conn.createStatement();                
				        
				String strsql="select 0 rowdelete,if((select coalesce(method,0) from gl_config where field_nme='lammo tourism')=1,cpudoc,xodoc) xodocno,coalesce(ac.tourtaxtype,'') tourtaxtype,m.tvltotal,m.tourdocno,acc.acno clientacno,h.sal_name salesagent,h.acc_no satacno,h.doc_no satdocno ,m.confirm,distype,adultdis,childdis,m.time,m.tourid,coalesce(m.rowno,0) rowno,name tourname,m.remarks,DATE_FORMAT(m.date,'%d.%m.%Y') date,coalesce(m.vendorid,0) vndid,ac.refname vendor,coalesce(m.adult,0) adult,coalesce(m.child,0) child,coalesce(m.spadult,0) spadult,coalesce(m.spchild,0) spchild,coalesce(m.adultval,0) adultval,coalesce(m.childval,0) childval,coalesce(m.total,0) total,det.refname,det.cldocno,coalesce(m.infant,0) infant,coalesce(m.stdtotal,0) stdtotal, m.transferid, m.groupid, m.transfertype, m.qty, m.loctype, m.rname, m.refno, m.plocid, m.ploctime, m.dlocid, m.rtripid,m. rndplocid, m.rndploctime, m.rnddlocid, m.tarifdetaildocno, m.estdistance, m.esttime, m.exdistancerate, m.extimerate, m.tourtransferrate, m.tourtransferratetot, m.rttarifdetaildocno, m.rtestdistance, m.rtesttime, m.rtexdistancerate, m.rtextimerate, m.rttourtransferrate, m.tarifdocno, m.rttarifdocno,coalesce(adultdismax,0) adultdismax, coalesce(childdismax,0) childdismax from tr_srtour m left join TR_servicereqm det on   det.doc_no=m.rdocno left join my_acbook acc on det.cldocno=acc.doc_no and acc.dtype='crm' left join my_salesman h on h.doc_no=det.satdocno and sal_type='sla' left join my_acbook ac on m.vendorid=ac.doc_no and ac.dtype='vnd' left join tr_tours tr on m.tourid=tr.doc_no left join tr_prtourd pr on pr.rowno=m.tourdocno where rdocno='"+rdocno+"'";        
				//System.out.println("tourGrid--->>>"+strsql);                                                            
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
		
		public JSONArray tourSubGrid(String rdocno) throws SQLException{  
			JSONArray data=new JSONArray();                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();        
				        
				String strsql="select remarks,rowno,name,age,height,weight from tr_srtourd where rdocno="+rdocno+"";        
				//System.out.println("tourGrid--->>>"+strsql);                                 
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
		
		public JSONArray nationGrid(HttpSession session) throws SQLException{  
			JSONArray data=new JSONArray();                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();     
				        
				String strsql="select  doc_no,nation from my_natm";        
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
		public JSONArray getSearchData() throws SQLException{     
			Connection conn=null;
			JSONArray RESULTDATA=new JSONArray();
			try{
				conn=objconn.getMyConnection();
				Statement stmt=conn.createStatement();
				String str="select doc_no,location from gl_cordinates where status=3";
				ResultSet rs=stmt.executeQuery(str);
				RESULTDATA=objcommon.convertToJSON(rs);
				   
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();
			}
			return RESULTDATA;
		}
		public JSONArray bookinggriddata(String fromdate,String todate,String locid,String nationid,String hotelid,int npax,int chd,String id,int childage1,int childage2,int childage3,int childage4,int childage5,int childage6,int extrabed,String mealplan,String cldocno,String roomid,String roomtypeid,String rating) throws SQLException{        
			JSONArray data=new JSONArray();       
			if(!id.equalsIgnoreCase("1")){
				return data;  
			}    
			Connection conn=null; 
			try{
			conn=objconn.getMyConnection();      
			Statement stmt=conn.createStatement();           
			String sqltest="",strsql1="",sql1="";               
			ResultSet rs1=null,rs2=null,rs3=null;
			java.sql.Date sqlfromdate = null;
			java.sql.Date sqltodate = null;
			int pvlper=0;
			String acsql="select coalesce(per,0) per from my_acbook ac left join my_clprivilage p on p.doc_no=ac.privilage where ac.cldocno='"+cldocno+"'";    
		    rs3=stmt.executeQuery(acsql);             
			while(rs3.next()){
		    	pvlper=rs3.getInt("per");       
		    }
			if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
		     	{
		     		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);  
		     	}
		     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
		     	{
		     		sqltodate=objcommon.changeStringtoSqlDate(todate);
		     	}
		     	else{
		     
		     	}                     
		     	if(sqlfromdate!=null){
		     		sqltest+=" and '"+sqlfromdate+"' between m.fdate and m.tdate";  
		     	}      
			  if(!(locid.equalsIgnoreCase("") || locid.equalsIgnoreCase("0"))){
        		sqltest+=" and a.doc_no='"+locid+"'";
        	   }
			  if(!(nationid.equalsIgnoreCase("") || nationid.equalsIgnoreCase("0"))){
				  sqltest+=" and m.pcatid='"+nationid+"'";
	        	   }
			  if(!(hotelid.equalsIgnoreCase("") || hotelid.equalsIgnoreCase("0"))){
				  sqltest+=" and m.hotelid='"+hotelid+"'";
	        	   }
			    if(chd!=0 && npax==0){   
				  sqltest+=" and "+chd+"<=hd.adult";       
	        	   }else if(chd==0 && npax!=0){
				  sqltest+=" and "+npax+"<=hd.adult";       
	        	   }else if(chd!=0 && npax!=0){   
				  sqltest+=" and ("+npax+"-"+chd+")<=hd.adult";       
	        	   }    
			  if(chd!=0){
				  sqltest+=" and "+chd+"<=hd.child";               
	        	   }
			  if(!(roomtypeid.equalsIgnoreCase("") || roomtypeid.equalsIgnoreCase("0"))){  
				  sqltest+=" and rt.name='"+roomtypeid+"'";       
	        	   }     
			  if(!(roomid.equalsIgnoreCase("") || roomid.equalsIgnoreCase("0"))){  
				  sqltest+=" and hd.name='"+roomid+"'";         
	        	   }
			  if(!(rating.equalsIgnoreCase("") || rating.equalsIgnoreCase("0"))){  
				  sqltest+=" and h.rating='"+rating+"'";                  
	        	   }
			  if(mealplan.equalsIgnoreCase("BB")){
				  if(childage1!=0){  
		        		sql1+=" +(if("+childage1+" between h.childmin and childmax,d.child, 0))";
		        	   }
				  if(childage2!=0){  
					    sql1+=" +(if("+childage2+" between h.childmin and childmax,d.child, 0))";
		        	   }
				  if(childage3!=0){  
					    sql1+=" +(if("+childage3+" between h.childmin and childmax,d.child, 0))";
		        	   }
				  if(childage4!=0){  
					    sql1+=" +(if("+childage4+" between h.childmin and childmax,d.child, 0))";
		        	   }
				  if(childage5!=0){  
					    sql1+=" +(if("+childage5+" between h.childmin and childmax,d.child, 0))";
		        	   }
				  if(childage6!=0){     
					    sql1+=" +(if("+childage6+" between h.childmin and childmax,d.child, 0))";
		        	   }
			  }else if(mealplan.equalsIgnoreCase("HB")){
				  if(childage1!=0){  
		        		sql1+=" +(if("+childage1+" between h.childmin and childmax,d.hbchild, 0))";
		        	   }
				  if(childage2!=0){  
					    sql1+=" +(if("+childage2+" between h.childmin and childmax,d.hbchild, 0))";
		        	   }
				  if(childage3!=0){  
					    sql1+=" +(if("+childage3+" between h.childmin and childmax,d.hbchild, 0))";
		        	   }
				  if(childage4!=0){  
					    sql1+=" +(if("+childage4+" between h.childmin and childmax,d.hbchild, 0))";
		        	   }
				  if(childage5!=0){  
					    sql1+=" +(if("+childage5+" between h.childmin and childmax,d.hbchild, 0))";
		        	   }
				  if(childage6!=0){     
					    sql1+=" +(if("+childage6+" between h.childmin and childmax,d.hbchild, 0))";
		        	   }
				  if(npax!=0){     
					    sql1+=" +d.hbadult";    
		        	   }
			  }else if(mealplan.equalsIgnoreCase("FB")){
				  if(childage1!=0){  
		        		sql1+=" +(if("+childage1+" between h.childmin and childmax,d.fbchild, 0))";
		        	   }
				  if(childage2!=0){  
					    sql1+=" +(if("+childage2+" between h.childmin and childmax,d.fbchild, 0))";
		        	   }
				  if(childage3!=0){  
					    sql1+=" +(if("+childage3+" between h.childmin and childmax,d.fbchild, 0))";
		        	   }
				  if(childage4!=0){  
					    sql1+=" +(if("+childage4+" between h.childmin and childmax,d.fbchild, 0))";
		        	   }
				  if(childage5!=0){  
					    sql1+=" +(if("+childage5+" between h.childmin and childmax,d.fbchild, 0))";
		        	   }
				  if(childage6!=0){     
					    sql1+=" +(if("+childage6+" between h.childmin and childmax,d.fbchild, 0))";
		        	   }
				  if(npax!=0){     
					    sql1+=" +d.fbadult";    
		        	   }
			  }else if(mealplan.equalsIgnoreCase("INC")){
				  if(childage1!=0){  
		        		sql1+=" +(if("+childage1+" between h.childmin and childmax,d.inchild, 0))";
		        	   }
				  if(childage2!=0){  
					    sql1+=" +(if("+childage2+" between h.childmin and childmax,d.inchild, 0))";
		        	   }
				  if(childage3!=0){  
					    sql1+=" +(if("+childage3+" between h.childmin and childmax,d.inchild, 0))";
		        	   }
				  if(childage4!=0){  
					    sql1+=" +(if("+childage4+" between h.childmin and childmax,d.inchild, 0))";
		        	   }
				  if(childage5!=0){  
					    sql1+=" +(if("+childage5+" between h.childmin and childmax,d.inchild, 0))";
		        	   }
				  if(childage6!=0){     
					    sql1+=" +(if("+childage6+" between h.childmin and childmax,d.inchild, 0))";
		        	   }
				  if(npax!=0){     
					    sql1+=" +d.inadult";    
		        	   }
			  }else{}
			  
			  strsql1="select coalesce(hd.srno,0) roomid,coalesce(h.doc_no,0) hotelid,h.name hotel,a.area loc,rt.name rtype,rt.remarks cat,coalesce(hd.name,'') name,"  
					+ "  convert(concat(rating , ' ',hd.adult ,' Adult,',hd.child , ' Child,', hd.extrabed ,' Extrabed.'),char(50)) details"
					+ " ,coalesce((d.cpbasic+("+extrabed+"*d.cpexbed)"+sql1+")*(1+((d.marginper-(d.maxdiscount*"+pvlper+"))/100)),0) price from tr_prhotelm M left join tr_prhoteld d on d.rdocno=m.doc_no "
					+ " LEFT join tr_hotel h on m.hotelid=h.doc_no left join tr_hoteld hd on h.doc_no=hd.rdocno"
					+ " and d.roomid=hd.SRNO left join my_area a on h.areaid=a.doc_no left join tr_roomtype rt on hd.rtypeid=rt.doc_no where h.status=3 "+sqltest+"";
			
			System.out.println("hOTEL price--->>>"+strsql1);    
			rs1=stmt.executeQuery(strsql1);   
			data=objcommon.convertToJSON(rs1);           
			}
			catch(Exception e){
			e.printStackTrace();
			}
			finally{
			conn.close(); 
			}
			return data;
			}
		public JSONArray subgriddata(String rdocno,String id) throws SQLException{
			System.out.println("id===="+id);             
			JSONArray data=new JSONArray(); 
			if(!id.equalsIgnoreCase("1")){
				return data;  
			}    
			Connection conn=null; 
			try{
			conn=objconn.getMyConnection(); 
			Statement stmt=conn.createStatement();             
			ResultSet rs1=null;
			  
			String strsql1="select rowno,name,total from TR_srhoteld where rdocno='"+rdocno+"'";           
			System.out.println("subgrid--->>>"+strsql1);                
			rs1=stmt.executeQuery(strsql1);
			//if(rs1.next()){
			data=objcommon.convertToJSON(rs1);            
			}
			catch(Exception e){
			e.printStackTrace();
			}
			finally{
			conn.close(); 
			}
			return data;
			}
		public JSONArray searchHotel() throws SQLException{ 
			JSONArray data=new JSONArray(); 
			/*if(!id.equalsIgnoreCase("1")){
				return data;  
			}*/
			Connection conn=null; 
			try{  
			conn=objconn.getMyConnection();   
			Statement stmt=conn.createStatement();
			String strsql="select h.name,h.doc_no,ac.refname,h.vendorid from tr_hotel h left join my_acbook ac on(ac.doc_no=h.vendorid and ac.dtype='vnd') where h.status=3"; 
			//System.out.println("Hotel search--->>>"+strsql); 
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
		public JSONArray searchLocation() throws SQLException{      
			JSONArray data=new JSONArray(); 
			/*if(!id.equalsIgnoreCase("1")){   
				return data;  
			}*/
			Connection conn=null; 
			try{
			conn=objconn.getMyConnection();   
			Statement stmt=conn.createStatement();
			String strsql="select doc_no,area name from my_area where status=3;"; 
			//System.out.println("Location search--->>>"+strsql); 
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
		public JSONArray searchRoom() throws SQLException{ 
			JSONArray data=new JSONArray(); 
			/*if(!id.equalsIgnoreCase("1")){
				return data;  
			}*/
			Connection conn=null; 
			try{
			conn=objconn.getMyConnection();   
			Statement stmt=conn.createStatement();
			String strsql="SELECT DISTINCT name from TR_hoteld;"; 
			//System.out.println("Room search--->>>"+strsql); 
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
		public JSONArray searchNation() throws SQLException{ 
			JSONArray data=new JSONArray(); 
			/*if(!id.equalsIgnoreCase("1")){
				return data;  
			}*/
			Connection conn=null; 
			try{
			conn=objconn.getMyConnection();   
			Statement stmt=conn.createStatement();
			String strsql="select catid,nation name from my_natm where status=3;"; 
			//System.out.println("Nation search--->>>"+strsql); 
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


