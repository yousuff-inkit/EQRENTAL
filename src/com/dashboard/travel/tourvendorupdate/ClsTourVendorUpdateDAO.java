package com.dashboard.travel.tourvendorupdate;
    
	import com.common.ClsCommon;
import com.connection.ClsConnection;

	import java.sql.*;

	import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
	public class ClsTourVendorUpdateDAO {      

		ClsConnection objconn=new ClsConnection();       
		ClsCommon objcommon=new ClsCommon();
		
		public JSONArray detailGrid(String id) throws SQLException{ 
			JSONArray data=new JSONArray(); 
			if(!id.equalsIgnoreCase("1")){    
				return data;
			}
			Connection conn=null; 
			java.sql.Date edates = null; 
			try{  
			conn=objconn.getMyConnection();   
			Statement stmt=conn.createStatement();
			String sqltest="";   
			
			String strsql="select m.rdocno,det.voc_no doc_no,det.refname,det.mail email,det.mob mobile,m.distype,m.adultdis,m.childdis,m.time,m.tourid,coalesce(m.rowno,0) rowno,name tourname,m.remarks,"
					+ " DATE_FORMAT(m.date,'%d.%m.%Y') date,coalesce(m.vendorid,0) vndid,ac.refname vendor,coalesce(m.adult,0) adult,coalesce(m.child,0) child,"
					+ " coalesce(m.spadult,0) spadult,coalesce(m.spchild,0) spchild,coalesce(m.adultval,0) adultval,coalesce(m.childval,0) childval,coalesce(m.total,0) total,m.tvltotal "
					+ " from tr_srtour m left join tr_servicereqm det  on m.rdocno=det.doc_no left join tr_prtourd d on d.rowno=m.tourdocno left join my_acbook ac on m.vendorid=ac.doc_no"
					+ "  left join tr_tours tr on m.tourid=tr.doc_no where 1=1 and m.vendorid=0 group by m.rowno order by det.doc_no,m.rowno"; 
			
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
		
		public JSONArray detailExcel(String id) throws SQLException{ 
			JSONArray data=new JSONArray(); 
			if(!id.equalsIgnoreCase("1")){    
				return data;
			}
			Connection conn=null; 
			java.sql.Date edates = null; 
			try{  
			conn=objconn.getMyConnection();   
			Statement stmt=conn.createStatement();
			String sqltest="";   
			
			String strsql="select det.voc_no 'Doc No',det.refname 'Client',det.mail Email,det.mob Mobile,m.distype 'Discount Type',m.adultdis 'Adult Discount',m.childdis 'Child Discount',m.time 'Time',name 'Tour Name,m.remarks 'Remarks',"
					+ " DATE_FORMAT(m.date,'%d.%m.%Y') Date,ac.refname Vendor,coalesce(m.adult,0) Adult,coalesce(m.child,0) Child,"
					+ " coalesce(m.spadult,0) 'SP Adult',coalesce(m.spchild,0) 'SP Child',coalesce(m.total,0) Total,m.tvltotal 'Travel Total'"
					+ " from tr_srtour m left join tr_servicereqm det  on m.rdocno=det.doc_no left join tr_prtourd d on d.rowno=m.tourdocno left join my_acbook ac on m.vendorid=ac.doc_no"
					+ "  left join tr_tours tr on m.tourid=tr.doc_no where 1=1 and m.vendorid=0 group by m.rowno order by det.doc_no,m.rowno"; 
			
			System.out.println("travel Grid--->>>"+strsql);               
			ResultSet rs=stmt.executeQuery(strsql);     
			data=objcommon.convertToEXCEL(rs);             
			} 
			catch(Exception e){
			e.printStackTrace();
			}
			finally{
			conn.close(); 
			}
			return data;
			}
		
		public JSONArray searchVendor(String docno,String vndid) throws SQLException{                                    
			JSONArray data=new JSONArray();                                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{
				conn=objconn.getMyConnection();     
				Statement stmt=conn.createStatement(); 
				String strsql="",strsql2="",strsql3="";
				int vendval=0;
				 ResultSet rs=null,rss=null,rs1=null;
				 /*  strsql="select refname,coalesce(doc_no,0) vendorid from  my_acbook ac left join tr_srtour tr on tr.vendorid=ac.cldocno and ac.dtype='VND' where ac.dtype='VND' and ac.status=3 and tr.rdocno='"+docno+"' group by ac.cldocno";
				   //System.out.println("strsql====="+strsql);  
				   rs=stmt.executeQuery(strsql);
				   while(rs.next()){
					   vendval+=rs.getInt("vendorid");
				   }
				   if(vendval==0){*/   
					   strsql3="select refname,doc_no vendorid from  my_acbook where dtype='vnd' and status=3";
					   //System.out.println("strsql3====="+strsql3);
					    rs1=stmt.executeQuery(strsql3);
					   data=objcommon.convertToJSON(rs1);    
				  /* }else{
					   strsql2="select refname,coalesce(doc_no,0) vendorid from  my_acbook ac left join tr_srtour tr on tr.vendorid=ac.cldocno and ac.dtype='VND' where ac.dtype='VND' and ac.status=3 and tr.rdocno='"+docno+"' group by ac.cldocno";
					   //System.out.println("strsql2====="+strsql2);  
					   rss=stmt.executeQuery(strsql2);
					   data=objcommon.convertToJSON(rss);
				   }*/
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


