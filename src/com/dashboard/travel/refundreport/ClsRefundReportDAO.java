package com.dashboard.travel.refundreport;
    
	import com.common.ClsCommon;
import com.connection.ClsConnection;

	import java.sql.*;

	import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
	public class ClsRefundReportDAO {  

		ClsConnection objconn=new ClsConnection();     
		ClsCommon objcommon=new ClsCommon();     
		
		public JSONArray detailGrid(String check,String fromdate,String todate) throws SQLException{
			JSONArray data=new JSONArray();  
			if(!check.equalsIgnoreCase("1")){
				return data;     
			}
			Connection conn=null; 
			String sqltest="";
			java.sql.Date sqlfromdate = null;
			java.sql.Date sqltodate = null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){                
				sqltodate=objcommon.changeStringtoSqlDate(todate);   
			}
			if(sqlfromdate!=null && sqltodate!=null){
				sqltest+=" and ts.date between '"+sqlfromdate+"' and '"+sqltodate+"'";        
			}
			try{      
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();  
				        
				String strsql="select ts.refstockid,u.user_name user,tr.name tour,ac.refname vendor,l.loc_name locname,b.branchname branch,date_format(ts.date,'%d.%m.%Y') date,date_format(ts.expdate,'%d.%m.%Y') expdate,ts.adult,ts.child,ts.spadult,ts.spchild from tr_tourstock ts left join tr_tours tr on tr.doc_no=ts.tourid left join my_acbook ac on ac.doc_no=ts.vendorid and ac.dtype='vnd' left join my_locm l on l.doc_no=ts.locid left join my_brch b on b.doc_no=ts.brhid left join my_user u on u.doc_no=ts.userid where 1=1 "+sqltest+""; 
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
		public JSONArray summaryGrid(String check) throws SQLException{           
			JSONArray data=new JSONArray();  
			if(!check.equalsIgnoreCase("1")){
				return data;     
			}
			Connection conn=null; 
			try{      
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();  
				        
				String strsql="select a.* from(select u.user_name user,tr.name tour,date_format(ts.expdate,'%d.%m.%Y') expdate,sum(adult) adult,sum(child) child from tr_tourstock ts left join tr_tours tr on tr.doc_no=ts.tourid left join my_user u on u.doc_no=ts.userid where 1=1 group by ts.refstockid)a where (a.adult>0 or a.child>0)"; 
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