package com.dashboard.travel.tourdiscountpaybackapproval;
    
	import com.common.ClsCommon;
	import com.connection.ClsConnection;

	import java.sql.*;

	import javax.servlet.http.HttpSession;

	import net.sf.json.JSONArray;
	public class ClsTourDiscountPaybackApprovalDAO {  

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
			String sqltest="";   
			java.sql.Date sqltodate=null;
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){  
				sqltest+=" and det.brhid="+branch;
			}
			if(!location.equalsIgnoreCase("") && !location.equalsIgnoreCase("0")){  
				sqltest+=" and det.locid="+location;
			}
			if( sqltodate!=null){
					sqltest+=" and det.date<='"+sqltodate+"'";                
			}
			String strsql="select m.rdocno doc_no,m.distype,m.adultdis,m.childdis,m.time,m.tourid,coalesce(m.rowno,0) rowno,name tourname,m.remarks,DATE_FORMAT(m.date,'%d.%m.%Y') date,coalesce(m.vendorid,0) vndid,ac.refname vendor,coalesce(m.adult,0) adult,coalesce(m.child,0) child,coalesce(m.spadult,0) spadult,coalesce(m.spchild,0) spchild,coalesce(m.adultval,0) adultval,coalesce(m.childval,0) childval,coalesce(m.total,0) total from tr_servicereqm det left join tr_srtour m on m.rdocno=det.doc_no left join tr_prtourd d on d.rowno=m.tourdocno left join my_acbook ac on m.vendorid=ac.doc_no left join tr_tours tr on m.tourid=tr.doc_no where (m.adultdis>d.adultdismax or m.childdis>d.childdismax) and m.confirm=0 "+sqltest+" group by m.rowno order by m.rowno"; 
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
		
		public JSONArray detailExGrid(HttpSession session, String check,String todate,String branch,String location) throws SQLException{ 
			JSONArray data=new JSONArray(); 
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
			}
			if(!location.equalsIgnoreCase("") && !location.equalsIgnoreCase("0")){  
				sqltest+=" and det.locid="+location;
			}
			if( sqltodate!=null){
					sqltest+=" and det.date<='"+sqltodate+"'";            
			}
			String strsql="select name tourname,DATE_FORMAT(m.date,'%d.%m.%Y') date,m.time,ac.refname vendor,coalesce(m.adult,0) adult,coalesce(m.spadult,0) spadult,m.distype,m.adultdis,coalesce(m.child,0) child,coalesce(m.spchild,0) spchild,m.childdis,coalesce(m.total,0) total,m.remarks from tr_servicereqm det left join tr_srtour m on m.rdocno=det.doc_no left join tr_prtourd d on d.rowno=m.tourdocno left join my_acbook ac on m.vendorid=ac.doc_no left join tr_tours tr on m.tourid=tr.doc_no  where (m.adultdis>d.adultdismax or m.childdis>d.childdismax) and m.confirm=0 "+sqltest+" group by m.rowno order by m.rowno"; 
			//System.out.println("flwp--->>>"+strsql); 
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
		
	}


