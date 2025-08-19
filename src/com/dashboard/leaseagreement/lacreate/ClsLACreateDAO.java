package com.dashboard.leaseagreement.lacreate;

import java.sql.*;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
public class ClsLACreateDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getLAData(String uptodate,String cldocno,String branch,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String strsql="",sqltest="";
			java.sql.Date sqldate=null;
			if(!uptodate.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(uptodate);
				sqltest+=" and m.date<='"+sqldate+"'";
			}
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and ac.cldocno="+cldocno;
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and m.brhid="+branch;
			}
			strsql="select d.sr_no masterrefsrno,ac.cldocno,m.doc_no,m.voc_no,ac.refname,m.po,m.refno,brd.brand_name brand,model.vtype model,coalesce(spec.name,'') spec,d.duration,"+
			" d.qty from gl_masterlagm m left join gl_masterlagd d on (m.doc_no=d.rdocno) left join my_acbook ac on"+
			" (m.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_vehbrand brd on (d.brdid=brd.doc_no) left join gl_vehmodel model on"+
			" (d.modelid=model.doc_no) left join gl_vehspec spec on d.specid=spec.doc_no where m.status=3  and (d.qty-d.outqty<>0)"+sqltest;
			System.out.println("Grid Loading Query: "+strsql);
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
			
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
	
	
	public   JSONArray vehSearch(String branch,String fleetno,String regno,String flname,String color,String group,String id,String masterrefno) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
	   	if(!id.equalsIgnoreCase("1")){
	   		return RESULTDATA;
	   	}
	   	 
	   	String sqltest="";
	    	
	    	if((!(fleetno.equalsIgnoreCase(""))) && (!(fleetno.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and v.fleet_no like '%"+fleetno+"%'";
	    	}
	    	if((!(regno.equalsIgnoreCase(""))) && (!(regno.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and v.reg_no like '%"+regno+"%'  ";
	    	}
	    	if((!(flname.equalsIgnoreCase(""))) && (!(flname.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and v.FLNAME like '%"+flname+"%'";
	    	}
	    	if((!(color.equalsIgnoreCase(""))) && (!(color.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and c.color like '%"+color+"%'";
	    	}
	    	if((!(group.equalsIgnoreCase(""))) && (!(group.equalsIgnoreCase("NA")))){
	    		sqltest=sqltest+" and g.gname like '%"+group+"%'";
	    	}
	   
	    	Connection conn =null;
			try {
				
				conn = objconn.getMyConnection();
				Statement stmtVeh8 = conn.createStatement ();
				String brdid="",modelid="";
				if(!masterrefno.equalsIgnoreCase("")){
					String strgetbrand="select brdid,modelid from gl_masterlagd where rdocno="+masterrefno+" and status=3";
					ResultSet rsgetbrand=stmtVeh8.executeQuery(strgetbrand);
					int i=0;
					while(rsgetbrand.next()){
						if(i==0){
							brdid=rsgetbrand.getString("brdid");
							modelid=rsgetbrand.getString("modelid");
						}
						else{
							brdid=","+rsgetbrand.getString("brdid");
							modelid=","+rsgetbrand.getString("modelid");
						}
					}
					if(!brdid.equalsIgnoreCase("")){
						sqltest+=" and v.brdid in ("+brdid+")";
					}
					if(!modelid.equalsIgnoreCase("")){
						sqltest+=" and v.vmodid in ("+modelid+")";
					}
					
				}
				String vehsql= "select  plate.code_name platecode,v.doc_no vdocno,v.reg_no,v.fleet_no,v.FLNAME,v.a_loc,m.fleet_no,m.kmin,m.fin,c.doc_no,c.color,g.gname,g.gid from gl_vehmaster v 	 "
				+ "left join gl_vmove m on v.fleet_no=m.fleet_no  left join my_color c  on v.clrid=c.doc_no left join gl_vehgroup g on g.doc_no=v.vgrpid  left join gl_vehplate plate on v.pltid=plate.doc_no "
				+ "	where v.a_br="+branch+" and ins_exp >=current_date and v.statu <> 7 and "
				+ "	m.doc_no=(select (max(doc_no)) from gl_vmove where fleet_no=v.fleet_no) and  "
				+ " fstatus in ('L','N') and v.status='IN' and v.tran_code='RR' and v.renttype in ('A','L') "+sqltest ;
				System.out.println("--------lease-------"+vehsql);
				ResultSet resultSet = stmtVeh8.executeQuery(vehsql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtVeh8.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	
	
	public   JSONArray clientSearch(String branch,String clname,String mob,String lcno,String passno,String nation,String dob,String masterrefnocldocno,String refno,String id) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
	   	if(!id.equalsIgnoreCase("1")){
	   		return RESULTDATA;
	   	}
	   	java.sql.Date sqlStartDate=null;
	    dob.trim();
	    System.out.println("DOB: "+dob);
	    if(!(dob.equalsIgnoreCase("")) && !dob.equalsIgnoreCase("undefined"))
	    {
	    	sqlStartDate = objcommon.changeStringtoSqlDate(dob);
	    }
	    	
	    		
	    
	    	
	    	String sqltest="";
	    	
	    	if(!(clname.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and a.RefName like '%"+clname+"%'";
	    	}
	    	if(!(mob.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and (a.per_mob like '%"+mob+"%' or d.mobno like '%"+mob+"%')";
	    	}
	    	if(!(lcno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.dlno like '%"+lcno+"%'";
	    	}
	    	if(!(passno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.passport_no like '%"+passno+"%'";
	    	}
	    	if(!(nation.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and d.nation like '%"+nation+"%'";
	    	}
	    	 if(!(sqlStartDate==null)){
	    		sqltest=sqltest+" and d.dob='"+sqlStartDate+"'";
	    	} 
	        /*if(!masterrefnocldocno.equalsIgnoreCase("")){
	        	sqltest+=" and a.cldocno="+masterrefnocldocno;
	        }*/
	    	 Connection conn =null;
			try {
					  conn = objconn.getMyConnection();
					Statement stmtVeh8 = conn.createStatement ();
	            
					int method=0;
					
					String chk="select method  from gl_config where field_nme='Clientinvchk'";
					ResultSet rs=stmtVeh8.executeQuery(chk); 
					if(rs.next())
					{
						
						method=rs.getInt("method");
					}
					String clsql= ("select distinct "+method+" method,a.advance,a.invc_method,d.dob,d.dlno,d.nation,d.name drname,a.contactPerson,a.mail1,a.cldocno,trim(a.RefName) RefName,a.per_mob,concat(a.address,'  ',a.address2) as address ,a.per_tel,a.codeno,a.acno,m.doc_no, "
							+ " trim(m.sal_name) sal_name from my_acbook a left join my_salm m on a.sal_id=m.doc_no and m.status<>7 "
							+ "left join gl_drdetails d on d.cldocno=a.cldocno and d.dtype=a.dtype where a.dtype='CRM' and a.status=3 " +sqltest);
					
					System.out.println(clsql);
					ResultSet resultSet = stmtVeh8.executeQuery(clsql);
					
					RESULTDATA=objcommon.convertToJSON(resultSet);
					stmtVeh8.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	
	
	
	public JSONArray chufferinfo() throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
	   	Connection conn=null;
	   	try {
	   		conn = objconn.getMyConnection();
	   		Statement stmtVeh = conn.createStatement();
	   		String sqll="select sal_code,doc_no,sal_name from my_salesman where sal_type='DRV' and status<>7 ";
	   		ResultSet resultSet = stmtVeh.executeQuery(sqll);
	   		RESULTDATA=objcommon.convertToJSON(resultSet);
	   		stmtVeh.close();
	   		conn.close();
	   	}
	   	catch(Exception e){
	   		e.printStackTrace();
	   		conn.close();
	   	}
	   	finally{
	   		conn.close();
	   	}
	   	return RESULTDATA;
	}
	
	public JSONArray driverGridReloading(String docNo,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))) {
  		  return RESULTDATA;
  	    }
        
        Connection conn = null;
        
		try {
				conn = objconn.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				
				ResultSet resultSet = stmtCRM.executeQuery ("SELECT doc_no,dr_id,sr_no srno,name,dob,DATE_FORMAT(dob,'%d.%m.%Y') AS hiddob,nation as nation1,mobno,"
						+ "passport_no,pass_exp,DATE_FORMAT(pass_exp,'%d.%m.%Y') AS hidpassexp,dlno,issdate,DATE_FORMAT(issdate,'%d.%m.%Y') AS hidissdate,issfrm,led,"
						+ "DATE_FORMAT(led,'%d.%m.%Y') AS hidled,ltype,visano,visa_exp,DATE_FORMAT(visa_exp,'%d.%m.%Y') AS hidvisaexp,hcdlno,hcissdate,"
						+ "DATE_FORMAT(hcissdate,'%d.%m.%Y') AS hidhcissdate,hcled,DATE_FORMAT(hcled,'%d.%m.%Y') AS hidhcled,'Attach' attachbtn FROM gl_drdetails "
						+ "where dtype='CRM' and doc_no="+docNo+"");
                System.out.println("SELECT doc_no,dr_id,sr_no srno,name,dob,DATE_FORMAT(dob,'%d.%m.%Y') AS hiddob,nation as nation1,mobno,"
						+ "passport_no,pass_exp,DATE_FORMAT(pass_exp,'%d.%m.%Y') AS hidpassexp,dlno,issdate,DATE_FORMAT(issdate,'%d.%m.%Y') AS hidissdate,issfrm,led,"
						+ "DATE_FORMAT(led,'%d.%m.%Y') AS hidled,ltype,visano,visa_exp,DATE_FORMAT(visa_exp,'%d.%m.%Y') AS hidvisaexp,hcdlno,hcissdate,"
						+ "DATE_FORMAT(hcissdate,'%d.%m.%Y') AS hidhcissdate,hcled,DATE_FORMAT(hcled,'%d.%m.%Y') AS hidhcled,'Attach' attachbtn FROM gl_drdetails "
						+ "where dtype='CRM' and doc_no="+docNo+"");
				RESULTDATA=objcommon.convertToJSON(resultSet);
				
				stmtCRM.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return RESULTDATA;
    }
}
