package com.dashboard.equipment.forsaleremarks;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsForsaleRemarksDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public String statussearch() throws SQLException {
		String cellarray1 = "";  
	     Connection conn = null;
	  try {
	     conn = ClsConnection.getMyConnection();
	    Statement stmt6 = conn.createStatement ();
	    String tasql= ("select doc_no,st_desc from gl_forsalestatus");
	    //System.out.println("----------"+tasql);
	    ResultSet resultSet5 = stmt6.executeQuery(tasql);
	    while (resultSet5.next()) {
	     cellarray1+=resultSet5.getString("st_desc")+",";
	     //bean.setRentaltype(resultSet5.getString("rentaltype"));
//	     System.out.println("----------"+tasql);
	    }
	    cellarray1=cellarray1.substring(0, cellarray1.length()-1);
	    stmt6.close();
	    conn.close();
	  }
	  catch(Exception e){
	   conn.close();
	   e.printStackTrace();
	  }
	     return cellarray1;
	 }
	
	
	public JSONArray searchUnrentable(String branchval,String relodestatus,String id) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        if(!id.equalsIgnoreCase("1")) {
        	return RESULTDATA;    
        }    
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
            	String sqltest="";
				if(!(branchval.equalsIgnoreCase("")) && !(branchval.equalsIgnoreCase("a")) && !(branchval.equalsIgnoreCase("NA"))){
            		sqltest=" and m.a_br='"+branchval+"'";
            	}
				String sql1="";
				if(!(relodestatus.equalsIgnoreCase("ALL"))){
					 sql1=" and coalesce(m.FORSALESTATUS,'FS')='"+relodestatus+"'";   
				}
				
				String sqldata="select  'Save' btnsave,coalesce(un.remarks,'') remarks,v.doc_no movdocno,m.doc_no,m.a_br brhid,br.branchname,m.FLEET_NO,m.FLNAME,m.REG_NO,v.kmin cur_km,m.SRVC_KM,y.YOM,m.renttype renttype,v.din,v.tin,"+
            			" CASE WHEN v.fin='0.000' THEN 'Level 0/8' WHEN v.fin='0.125' THEN 'Level 1/8' WHEN v.fin='0.250' THEN 'Level 2/8' WHEN v.fin='0.375'"+
            			" THEN 'Level 3/8' WHEN v.fin='0.500' THEN 'Level 4/8' WHEN v.fin='0.625' THEN 'Level 5/8' WHEN m.C_FUEL='0.750' THEN 'Level 6/8'"+
            			" WHEN m.C_FUEL='0.875' THEN 'Level 7/8' WHEN m.C_FUEL='1.000' THEN 'Level 8/8' END as 'C_FUEL',l.LOC_NAME,g.gname,c.color,"+
            			" b.brand_name,TIMESTAMPDIFF(Day,din,now()) idledays,coalesce(m.FORSALESTATUS,'FS') cstatus from gl_vehmaster m "
            			+ " inner join gl_vmove v on v.fleet_no=m.fleet_no and m.tran_code='FS' and m.fstatus='L' "
    					+ " inner  join   (select max(doc_no) maxd,fleet_no from gl_vmove group by fleet_no) a "
    					+ " on v.doc_no=a.maxd and v.fleet_no=a.fleet_no "
    					+ " left join my_locm l on l.doc_no=m.A_LOC  left join gl_vehgroup g on g.doc_no=m.VGRPID left join"
            			+ " my_color c on(m.clrid=c.doc_no)  left join gl_vehbrand b on(m.brdid=b.doc_no) left join my_brch br on br.doc_no=m.a_br"
            			+ " left join gl_yom y on y.doc_no=m.yom left join gl_forsale un on (v.doc_no=un.movdocno and v.fleet_no=un.fleetno) where 1=1 "+sql1+" " +sqltest ;					
				System.out.println("UnRentable Query:"+sqldata);
				ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVeh1.close();
				conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	public JSONArray subDetailss(String brnchval) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
     	Connection conn = null;  
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				String sqltest="";
				if(!(brnchval.equalsIgnoreCase("")) && !(brnchval.equalsIgnoreCase("a"))){
            		sqltest=" and m.a_br='"+brnchval+"'";
            	}
				String sql="select * from (select if(uns.st_desc is null or uns.st_desc='','FS',uns.st_desc) description,count(*) count,if(uns.st_desc is null or uns.st_desc='','FS',uns.st_desc) relodestatus from gl_vehmaster m  left join gl_forsalestatus uns on uns.st_desc=m.forsalestatus where m.tran_code='FS' and m.fstatus='L' and m.statu=3 "+sqltest+"  group by m.forsalestatus) a  group by a.relodestatus"
        				+ " union all "
        				+ " select 'ALL' description,count(*) count,'ALL' relodestatus from gl_vehmaster m  where m.tran_code='FS' and m.fstatus='L' and m.statu=3 "+sqltest  ;
				System.out.println("----"+sql);                      
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
            	conn.close();
		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
}
