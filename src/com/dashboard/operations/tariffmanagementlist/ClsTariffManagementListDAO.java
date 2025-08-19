package com.dashboard.operations.tariffmanagementlist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsTariffManagementListDAO {
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray FirstListGridLoading(String check,String fromdate,String todate) throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
		if(!check.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		try {
			
			    conn = ClsConnection.getMyConnection();
			    Statement stmtStaff = conn.createStatement();
			    if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
			    String sql1="";
		        String sql="select m5.doc_no clientid,if(m2.tariftype='Corporate',m6.cat_name,m5.refname) clientname,m2.doc_no docno,currentdate,tariftype,tariffor,validfrm,validto,if(del_stat=1,'Yes','No')chk,notes from gl_tarifm m2 left join my_acbook m5 on (m2.clientid=m5.doc_no and m5.dtype='CRM') left join my_clcatm m6 on (m2.clientid=m6.doc_no and m6.dtype='CRM') where m2.status<>7 and currentdate>='"+sqlFromDate+"' and currentdate<='"+sqlToDate+"'";
		       //System.out.println("Fist========="+sql);
		        ResultSet resultSet = stmtStaff.executeQuery(sql);
         
		        RESULTDATA=ClsCommon.convertToJSON(resultSet);
		    
		    stmtStaff.close();
		    conn.close();
	       }catch(Exception e){
		  e.printStackTrace();
		  conn.close();
	  }finally{
		  conn.close();
	  }
		return RESULTDATA;
	}
	
public JSONArray FirstListExcelLoading(String check,String fromdate,String todate) throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
		if(!check.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		try {
			
			    conn = ClsConnection.getMyConnection();
			    Statement stmtStaff = conn.createStatement();
			    String sql1="";
			    if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
				}
		        String sql="select m2.doc_no 'DOCNO',currentdate 'Date',tariftype 'Tariff Type',if(m2.tariftype='Corporate',m6.cat_name,m5.refname)'Tariff Type Corporate ',tariffor 'Tariff For',validfrm 'Valid From',validto 'Valid To',if(del_stat=1,'Yes','No') 'Delivery Charge',notes 'Notes' from gl_tarifm m2 left join my_acbook m5 on (m2.clientid=m5.doc_no and m5.dtype='CRM') left join my_clcatm m6 on (m2.clientid=m6.doc_no and m6.dtype='CRM') where m2.status<>7 and currentdate>='"+sqlFromDate+"' and currentdate<='"+sqlToDate+"'";
		      // System.out.println("excel========="+sql);
		        ResultSet resultSet = stmtStaff.executeQuery(sql);
         
		        RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
		    
		    stmtStaff.close();
		    conn.close();
	       }catch(Exception e){
		  e.printStackTrace();
		  conn.close();
	  }finally{
		  conn.close();
	  }
		return RESULTDATA;
	}
	
public JSONArray DetailGridLoading(String docno,String check) throws SQLException{
		
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
		if(!check.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		try {
			
			    conn = ClsConnection.getMyConnection();
			    Statement stmtStaff = conn.createStatement();
			    String sql1="";
			    if(!docno.equalsIgnoreCase("")){
					sql1=docno;
				}
			   
		        String sql="select distinct if(m1.gid is null,grp2.gname,grp1.gname)gid,m3.rentaltype,m1.cdw,m1.pai,m1.kmrest,m1.exkmrte,m1.rate,"
		        		+ "m1.gps,m1.babyseater,m1.cooler,coalesce(m1.disclevel1,0)disclevel1,coalesce(m1.disclevel2,0)disclevel2,coalesce(m1.disclevel3,0)disclevel3,m1.cdw1,m1.pai1,m1.oinschg,m1.chaufchg,m1.chaufexchg,"
		        		+ "m1.exhrchg,if(m1.gid is null,grp2.doc_no,grp1.doc_no) docno, round(coalesce(ex.securityamt,0),2) securityamt,round(coalesce(ex.insurexcess,0),2) insurexcess,"
		        		+ "round(coalesce(ex.cdwexcess,0),2) cdwexcess,round(coalesce(ex.scdwexcess,0),2) scdwexcess from gl_tarifm m2 left join gl_tarifd m1 on m2.doc_no=m1.doc_no "
		        		+ "left join gl_tlistm m3 on m1.renttype=m3.rentaltype left join gl_tarifcondn m4 on m2.doc_no=m4.doc_no "
		        		+ "left join gl_tarifexcess ex on ((m2.doc_no=ex.rdocno and m1.gid=ex.gid) or (m2.doc_no=ex.rdocno and m4.gid=ex.gid)) "
		        		+ "left join gl_vehgroup grp1 on m1.gid=grp1.doc_no left join gl_vehgroup grp2 on m4.gid=grp2.doc_no where m2.doc_no="+sql1+" and m2.status<>7";
		       //System.out.println("Detgrid========="+sql);
		        ResultSet resultSet = stmtStaff.executeQuery(sql);
         
		        RESULTDATA=ClsCommon.convertToJSON(resultSet);
		    
		    stmtStaff.close();
		    conn.close();
	       }catch(Exception e){
		  e.printStackTrace();
		  conn.close();
	  }finally{
		  conn.close();
	  }
		return RESULTDATA;
	}

public JSONArray DetailExcelLoading(String docno,String check) throws SQLException{
	
	JSONArray RESULTDATA=new JSONArray();
	Connection conn = null;
	if(!check.equalsIgnoreCase("1")){
		return RESULTDATA;
	}
	try {
		
		    conn = ClsConnection.getMyConnection();
		    Statement stmtStaff = conn.createStatement();
		    String sql1="";
		    if(!docno.equalsIgnoreCase("")){
				sql1=docno;
			}
		   
	        String sql="select distinct if(m1.gid is null,grp2.gname,grp1.gname)'Group Name',m3.rentaltype 'Rental Type',m1.rate 'Tariff',m1.cdw 'CDW',m1.pai 'PAI',"
					+ "m1.cdw1 'Super CDW',m1.gps 'GPS',m1.babyseater 'Child Seat',m1.kmrest 'KM Restrict',m1.exkmrte 'Excess KM Rate',m1.chaufchg 'Chauffer',"
					+ "coalesce(m1.disclevel1,0) 'DiscLevel1',coalesce(m1.disclevel2,0) 'DiscLevel2',coalesce(m1.disclevel3,0) 'DiscLevel3',round(coalesce(ex.securityamt,0),2) 'Security Amount',"
					+ "round(coalesce(ex.insurexcess,0),2) 'Insurance Excess',round(coalesce(ex.cdwexcess,0),2) 'CDW Excess',round(coalesce(ex.scdwexcess,0),2) 'Super CDW Excess' "
					+ "from gl_tarifm m2 left join gl_tarifd m1 on m2.doc_no=m1.doc_no "
	        		+ "left join gl_tlistm m3 on m1.renttype=m3.rentaltype left join gl_tarifcondn m4 on m2.doc_no=m4.doc_no "
	        		+ "left join gl_tarifexcess ex on ((m2.doc_no=ex.rdocno and m1.gid=ex.gid) or (m2.doc_no=ex.rdocno and m4.gid=ex.gid)) "
	        		+ "left join gl_vehgroup grp1 on m1.gid=grp1.doc_no left join gl_vehgroup grp2 on m4.gid=grp2.doc_no where m2.doc_no="+sql1+" and m2.status<>7";
	       //System.out.println("Detgridexcel========="+sql);
	        ResultSet resultSet = stmtStaff.executeQuery(sql);
     
	        RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
	    
	    stmtStaff.close();
	    conn.close();
       }catch(Exception e){
	  e.printStackTrace();
	  conn.close();
  }finally{
	  conn.close();
  }
	return RESULTDATA;
}

}
