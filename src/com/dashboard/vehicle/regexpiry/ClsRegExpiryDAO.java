package com.dashboard.vehicle.regexpiry;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsRegExpiryDAO {
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	public  JSONArray getClient(String branch,String clname,String mob,String lcno,String passno,String nation,String dob,String mode) throws SQLException {
        JSONArray data=new JSONArray();
        if(!mode.equalsIgnoreCase("1")){
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
	        	
	        	Statement stmt = conn.createStatement ();
				String strsql= "select distinct a.cldocno,trim(a.RefName) RefName,a.per_mob,trim(a.address) address,a.codeno,a.acno,m.doc_no,trim(m.sal_name) sal_name "+
				" from my_acbook a left join my_salm m on a.sal_id=m.doc_no and m.status<>7 left join gl_drdetails d on d.cldocno=a.cldocno where 1=1 and a.dtype='CRM' "+sqltest;
				//System.out.println("rental"+clsql);
				ResultSet rsclient = stmt.executeQuery(strsql);
				data=objcommon.convertToJSON(rsclient);
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
    		finally{
    			conn.close();
    		}
			//System.out.println(RESULTDATA);
	        return data;
    }
	
	
	public JSONArray getRegExpiryData(String branch,String expdate,String fromdate,String id,String cldocno) throws SQLException {

        JSONArray data=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return data;
        }
     	Connection conn = null;
		try {
				conn = objconn.getMyConnection();
				Statement stmt = conn.createStatement();
				java.sql.Date sqlToDate = null,sqlFromDate=null;
		     	if(!(expdate.equalsIgnoreCase("undefined"))&&!(expdate.equalsIgnoreCase(""))&&!(expdate.equalsIgnoreCase("0")))
		     	{
		     		sqlToDate=objcommon.changeStringtoSqlDate(expdate);
		     	}
		     	
		     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
		     	{
		     		sqlFromDate=objcommon.changeStringtoSqlDate(fromdate);
		     	}
		     	String sqltest="";
				if(!branch.equalsIgnoreCase("a") && !branch.equalsIgnoreCase("")){
					sqltest+=" and m.brhid='"+branch+"'";
				}
				if(sqlFromDate!=null && sqlToDate!=null){
					sqltest+=" and m.reg_exp between '"+sqlFromDate+"' and '"+sqlToDate+"' ";
				}
				if(!cldocno.equalsIgnoreCase("")){
					sqltest+=" and (rac.cldocno="+cldocno+" or lac.cldocno="+cldocno+")";
				}
			    String sqlexp="select case when m.tran_code in ('RA','RD','RW','RM') then 'Rental' when m.tran_code in ('LA','LC') then 'Lease' else '' end agmttype,"+
				" convert(case when m.tran_code in ('RA','RD','RW','RM') then rag.voc_no when m.tran_code in ('LA','LC') then lag.voc_no else '' end,char(25)) agmtno,"+
				" convert(case when m.tran_code in ('RA','RD','RW','RM') then rac.cldocno when m.tran_code in ('LA','LC') then lac.cldocno else '' end,char(25)) cldocno,"+
				" case when m.tran_code in ('RA','RD','RW','RM') then rac.refname when m.tran_code in ('LA','LC') then lac.refname else '' end refname,"+
				" 'Attach' attachbtn,m.doc_no docno,m.brhid,m.fleet_no,m.flname,m.reg_no,m.reg_exp,m.reg_date,g.gname,"
    			+ " c.color,b.brand_name,mo.vtype model,'Edit' btnsave,concat(au.authname,' - ',plt.code_name) platecode,coalesce(m.cur_km,0) currentkm,y.yom yearom "
				+ "	from gl_vehmaster m left join my_locm l on l.doc_no=m.A_LOC  left join gl_vehgroup g on g.doc_no=m.VGRPID "
				+ " left join my_color c on(m.clrid=c.doc_no) 	left join gl_vehbrand b on(m.brdid=b.doc_no) "
				+ " left join gl_vehmodel mo on mo.doc_no=m.vmodid left join gl_vehplate plt on m.pltid=plt.doc_no left join gl_vehauth au on au.doc_no=m.authid"
				+ " left join gl_yom y on m.yom=y.doc_no left join gl_ragmt rag on (rag.clstatus=0 and m.fleet_no=rag.fleet_no) left join"+
				" gl_lagmt lag on ((lag.perfleet=m.fleet_no or lag.tmpfleet=m.fleet_no ) and lag.clstatus=0) left join my_acbook rac on"+
				" (rag.cldocno=rac.cldocno and rac.dtype='CRM') left join my_acbook lac on (lag.cldocno=lac.cldocno and lac.dtype='CRM') "+
				" where m.statu=3 and fstatus in ('L','N') "+sqltest;
			    System.out.println("sqlexp  "+sqlexp);
				ResultSet rs = stmt.executeQuery (sqlexp);
				data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return data;
    }
}
