package com.dashboard.travel.tourlist;
    
	import com.common.ClsCommon;
	import com.connection.ClsConnection;

	import java.sql.*;

	import javax.servlet.http.HttpSession;

	import net.sf.json.JSONArray;
	public class ClsTourListDAO {  

		ClsConnection objconn=new ClsConnection();     
		ClsCommon objcommon=new ClsCommon();
		
		public JSONArray detailGrid(HttpSession session, String check,String fromdate,String todate,String branch,String location) throws SQLException{ 
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
			java.sql.Date sqlfromdate=null;
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){  
				sqltest+=" and det.brhid="+branch;  
			}
			if(!location.equalsIgnoreCase("") && !location.equalsIgnoreCase("0") && !location.equalsIgnoreCase("a")){  
				sqltest+=" and det.locid="+location;
			}
			if( sqltodate!=null && sqlfromdate!=null){                 
					sqltest+=" and det.date between '"+sqlfromdate+"' and '"+sqltodate+"'";                
			}
			String strsql="select if(det.dpdocno>0,'Direct Payment',case when paytype=1 then 'Cash' when paytype=2 then 'Card' when paytype=3 then 'Cheque/Online' else '' END) paymode,s.sal_name salesman,m.rname,det.voc_no doc_no,det.refname,det.mail email,det.mob mobile,m.distype,m.adultdis,m.childdis,m.time,m.tourid,coalesce(m.rowno,0) rowno,name tourname,m.remarks,"
					+ " DATE_FORMAT(m.date,'%d.%m.%Y') date,coalesce(m.vendorid,0) vndid,ac.refname vendor,coalesce(m.adult,0) adult,coalesce(m.child,0) child,"
					+ " coalesce(m.spadult,0) spadult,coalesce(m.spchild,0) spchild,coalesce(m.infant,0) infant,coalesce(m.adultval,0) adultval,coalesce(m.childval,0) childval,coalesce(m.total,0) total,m.tvltotal "  
					+ " from tr_servicereqm det left join tr_srtour m on m.rdocno=det.doc_no left join tr_prtourd d on d.rowno=m.tourdocno left join my_acbook ac on m.vendorid=ac.doc_no"
					+ "  left join tr_tours tr on m.tourid=tr.doc_no left join my_salm s on det.salid=s.doc_no left join gl_rentreceipt g on g.aggno=det.doc_no and g.rtype='Service Request' where m.trconfirm=0 "+sqltest+" group by m.rowno order by det.doc_no,m.rowno"; 
			//System.out.println("travel Grid--->>>"+strsql);               
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


