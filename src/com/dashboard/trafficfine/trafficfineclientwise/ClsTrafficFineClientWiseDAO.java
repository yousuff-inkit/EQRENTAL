package com.dashboard.trafficfine.trafficfineclientwise;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.trafficfine.ClsTrafficfineDAO;

import java.sql.*;

import net.sf.json.JSONArray;
public class ClsTrafficFineClientWiseDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray invoicedGridLoading(String branch,String fromdate,String todate,String cldocno,String clientcat,String id)throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();

		    java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
		    
	        if(!(fromdate.equalsIgnoreCase("")))
	        {
	        	sqlfromdate = objcommon.changeStringtoSqlDate(fromdate);
	        }
	        
	        if(!(todate.equalsIgnoreCase("")))
	        {
	        	sqltodate = objcommon.changeStringtoSqlDate(todate);
	        }
	        
		    String sql = "";
		    String sql1 = "";
		    
			if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sql+=" and m.brhid="+branch+"";
    		}
			
			if(sqlfromdate!=null){
	        	sql+=" and m.date>='"+sqlfromdate+"'";
		     }
	        
	        if(sqltodate==null){
	        	sql+=" and m.date<='"+sqltodate+"'";
		     }
	        
	        if(!(cldocno.equalsIgnoreCase(""))){
	        	sql+=" and ac.cldocno='"+cldocno+"'";
	        }
	        if(!clientcat.equalsIgnoreCase("")){
	        	sql+=" and ac.catid="+clientcat;
	        }
	        ClsTrafficfineDAO trafficdao=new ClsTrafficfineDAO();
	        double govfees=trafficdao.getGovFees(conn);
	        int govfeesparking=trafficdao.getGovFeesParking(conn);
	        String strgovfeesparking="";
	        if(govfeesparking>0){
	        	strgovfeesparking="  or trim(fine_source) like '%RTA(Parking Fine)%'  or trim(fine_source) like '%RTA (Parking Fines)%' or trim(fine_source) like '%RTA PARKING FINE%' or trim(fine_source) like '%ROADS & TRANSPORT AUTHORITY%'   or trim(fine_source) like '%ROADS & TRASNPORT AUTHORITY%'";
	        }
	        String strsql="select count(s.sr_no) trafficcount,convert(group_concat(m.voc_no),char(300)) invno,coalesce(ac.refname,sa.sal_name) "+
	        " refname,convert(group_concat(s.ticket_no),char(300)) ticket_no,convert(coalesce(round(sum(if((s.fine_source like"+
			" '%DUBAI%' "+strgovfeesparking+" )and "+govfees+">0,s.amount+"+govfees+",s.amount)),2),''),char(100)) amount"+
			" from gl_traffic s left join gl_ragmt r on s.ra_no=r.doc_no and (s.rtype in ('RM','RA','RD','RW','RF'))"+
			" left join gl_lagmt l on s.ra_no=l.doc_no and (s.rtype in ('LA','LC')) left join gl_status st on s.rtype=st.Status left join"+
			" my_acbook ac on ac.doc_no=s.emp_id and ac.dtype=s.emp_type left join my_salesman sa on sa.doc_no=s.emp_id and"+
			" sa.sal_type=s.emp_type left join gl_invm m on s.inv_no=m.doc_no and s.inv_type='INV'"+
			" where s.inv_no!=0 and s.isallocated=1 "+sql+" and s.ra_no<>0 and emp_type='CRM'"+
			" group by ac.cldocno";
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
	
	public JSONArray invoicedGridLoadingExcel(String branch,String fromdate,String todate,String cldocno,String clientcat,String id)throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();

		    java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
		    
	        if(!(fromdate.equalsIgnoreCase("")))
	        {
	        	sqlfromdate = objcommon.changeStringtoSqlDate(fromdate);
	        }
	        
	        if(!(todate.equalsIgnoreCase("")))
	        {
	        	sqltodate = objcommon.changeStringtoSqlDate(todate);
	        }
	        
		    String sql = "";
		    String sql1 = "";
		    
			if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sql+=" and m.brhid="+branch+"";
    		}
			
			if(sqlfromdate!=null){
	        	sql+=" and m.date>='"+sqlfromdate+"'";
		     }
	        
	        if(sqltodate==null){
	        	sql+=" and m.date<='"+sqltodate+"'";
		     }
	        
	        if(!(cldocno.equalsIgnoreCase(""))){
	        	sql+=" and ac.cldocno='"+cldocno+"'";
	        }
	        if(!clientcat.equalsIgnoreCase("")){
	        	sql+=" and ac.catid="+clientcat;
	        }
	        ClsTrafficfineDAO trafficdao=new ClsTrafficfineDAO();
	        double govfees=trafficdao.getGovFees(conn);
	        int govfeesparking=trafficdao.getGovFeesParking(conn);
	        String strgovfeesparking="";
	        if(govfeesparking>0){
	        	strgovfeesparking="  or trim(fine_source) like '%RTA(Parking Fine)%'  or trim(fine_source) like '%RTA (Parking Fines)%' or trim(fine_source) like '%RTA PARKING FINE%'  or trim(fine_source) like '%ROADS & TRANSPORT AUTHORITY%'   or trim(fine_source) like '%ROADS & TRASNPORT AUTHORITY%'";
	        }
	        String strsql="select coalesce(ac.refname,sa.sal_name) 'Client',convert(concat(group_concat(s.ticket_no separator ' ,'),';'),char(300)) 'Ticket No',convert(concat(group_concat(m.voc_no separator ' ,'),';'),char(300)) 'Inv No',count(s.sr_no) 'Traffic Count', convert(coalesce(round(sum(if((s.fine_source like '%DUBAI%' "+strgovfeesparking+" ) and "+govfees+">0,s.amount+"+govfees+",s.amount)),2),''),char(100)) 'Amount' from gl_traffic s left join gl_ragmt r on s.ra_no=r.doc_no and (s.rtype in ('RM','RA','RD','RW','RF'))"+
			" left join gl_lagmt l on s.ra_no=l.doc_no and (s.rtype in ('LA','LC')) left join gl_status st on s.rtype=st.Status left join"+
			" my_acbook ac on ac.doc_no=s.emp_id and ac.dtype=s.emp_type left join my_salesman sa on sa.doc_no=s.emp_id and"+
			" sa.sal_type=s.emp_type left join gl_invm m on s.inv_no=m.doc_no and s.inv_type='INV'"+
			" where s.inv_no!=0 and s.isallocated=1 "+sql+" and s.ra_no<>0 and emp_type='CRM'"+
			" group by ac.cldocno";
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
public  JSONArray getClient(String branch,String clname,String mob,String lcno,String passno,String nation,String dob,String id) throws SQLException {
        
        JSONArray data=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return data;
        }
        Connection conn =null;
        try {
        	conn=objconn.getMyConnection();
        	java.sql.Date sqlStartDate=null;
        	dob.trim();
	    	if(!(dob.equalsIgnoreCase("")) && !(dob.equalsIgnoreCase("undefined")))
	    	{
	    	sqlStartDate = objcommon.changeStringtoSqlDate(dob);
	    	}
	    	
	    		
	    	
	    	//System.out.println("name"+clname);
	    	
	    	String sqltest="";
	    	
	    	if(!(clname.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and a.RefName like '%"+clname+"%'";
	    	}
	    	if(!(mob.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and a.per_mob='%"+mob+"%'";
	    	}
	    	if(!(lcno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.dlno='%"+lcno+"%'";
	    	}
	    	if(!(passno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.passport_no='%"+passno+"%'";
	    	}
	    	if(!(nation.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.nation like'%"+nation+"%'";
	    	}
	    	 if(!(sqlStartDate==null)){
	    		sqltest=sqltest+" and d.dob='"+sqlStartDate+"'";
	    	} 
	        
	    	Statement stmtVeh8 = conn.createStatement ();
			String clsql= "select distinct a.cldocno,trim(a.RefName) RefName,a.per_mob,trim(a.address) address,a.codeno,a.acno,m.doc_no,trim(m.sal_name) sal_name,d.nation,d.dlno,d.passport_no,d.dob,a.per_tel,d.name drname "+
			" from my_acbook a left join my_salm m on a.sal_id=m.doc_no and m.status<>7 left join gl_drdetails d on d.cldocno=a.cldocno where 1=1 and a.dtype='CRM' "+sqltest;
			System.out.println("Client Search Query:"+clsql);
			ResultSet resultSet = stmtVeh8.executeQuery(clsql);
			data=objcommon.convertToJSON(resultSet);
			stmtVeh8.close();
			conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
    		finally{
    			conn.close();
    		}
	        return data;
    }


public JSONArray clientCategorySearch(String id) throws SQLException {
    JSONArray RESULTDATA=new JSONArray();
    if(!id.equalsIgnoreCase("1")){
    	return RESULTDATA;
    }
    Connection  conn = null;
    
	try {
		conn=objconn.getMyConnection();
		Statement stmtClientAnalysis=conn.createStatement();
		
		String strSql="select doc_no,cat_name clientcatname from my_clcatm where status=3 and dtype='CRM'";
        
		ResultSet resultSet = stmtClientAnalysis.executeQuery(strSql);
    	RESULTDATA=objcommon.convertToJSON(resultSet);
			
    	stmtClientAnalysis.close();
		conn.close();
		
		return RESULTDATA;

	} catch(Exception e){
		e.printStackTrace();
		conn.close();
	} finally{
		conn.close();
	}
	
    return RESULTDATA;
}
}
