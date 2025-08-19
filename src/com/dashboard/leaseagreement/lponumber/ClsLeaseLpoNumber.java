package com.dashboard.leaseagreement.lponumber;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;




public class ClsLeaseLpoNumber 
{
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray mranodetails() throws SQLException {
	     JSONArray RESULTDATA=new JSONArray();
	     
	     Connection conn =null;
	     try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement();
				
				String sql="select po mrano from gl_lagmt where status=3";
				//System.out.println("----------------"+sql);
			 		ResultSet resultSet = stmtVeh.executeQuery(sql);
	     		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVeh.close();
					conn.close();
	    
		}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	     return RESULTDATA;
	    }
	public JSONArray salesmanchangedetails() throws SQLException {
	     JSONArray RESULTDATA=new JSONArray();
	     
	     Connection conn =null;
	     try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement();
				
				String sql="select sal_name,doc_no from my_salm where status=3";
				//System.out.println("----------------"+sql);
			 		ResultSet resultSet = stmtVeh.executeQuery(sql);
	     		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVeh.close();
					conn.close();
	    
		}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	     return RESULTDATA;
	    }

 public JSONArray detailedgrid(String brnchval,String fromdate,String todate,String cldocno,String status,String fleet,String salesman,String type,String outchk,String inchk,String catid) throws SQLException {
//System.out.println(salesman);
     JSONArray RESULTDATA=new JSONArray();
     
     java.sql.Date sqlfromdate = null;
     if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
  	{
  		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
  		
  	}
  	else{
  
  	}

     java.sql.Date sqltodate = null;
  	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
  	{
  		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
  		
  	}
  	else{
  
  	}
  	
   //	System.out.println("hjbf"+salesmandoc);
 	String sqltest="";
 	if(!(status.equalsIgnoreCase("")|| status.equalsIgnoreCase("NA"))){
 		sqltest=sqltest+" and r.clstatus='"+status+"' ";
 	}
 	if(!(cldocno.equalsIgnoreCase("") || cldocno.equalsIgnoreCase("NA"))){
 		sqltest=sqltest+" and a.cldocno='"+cldocno+"' ";
 	}
 	if(!(fleet.equalsIgnoreCase("")|| fleet.equalsIgnoreCase("NA"))){
 		sqltest=sqltest+" and (r.perfleet='"+fleet+"' or r.tmpfleet='"+fleet+"') ";
 	}
 	if(!(salesman.equalsIgnoreCase("") || salesman.equalsIgnoreCase("NA"))){
 		sqltest=sqltest+" and r.salid='"+salesman+"' ";
 	}
 	
 	/*if(!(type.equalsIgnoreCase("") || type.equalsIgnoreCase("NA"))){
 		sqltest=sqltest+" and t.rentaltype='"+type+"' ";
 	}*/
 	if(!(catid.equalsIgnoreCase("") || catid.equalsIgnoreCase("NA"))){
 		sqltest=sqltest+" and a.catid='"+catid+"' ";
 	}
 	
 	
 	
 	if(!((brnchval.equalsIgnoreCase("a")) || (brnchval.equalsIgnoreCase("NA")))){
			sqltest+=" and r.brhid="+brnchval+"";
		}
 	
 	
 	/*if(inchk.equalsIgnoreCase("IN"))
 	{
 		sqltest+="	and  cs.indate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
 		
 	}
 	else
 	{*/
 		
 		sqltest+="	and  r.outdate between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
 	/*}*/
 	
 	

 	
 	Connection conn =  null;
 	try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
			

         		
         		String sql =" select  @s:=@s+1 SL,r.doc_no Docno,r.voc_no 'LA NO',r.po 'PO NO',if(r.perfleet=0,r.tmpfleet,r.perfleet) Fleet,v.FLNAME 'Fleet Name',"
         				+ "v.reg_no 'Reg NO',r.perfleet 'Contract Fleet',v1.reg_no 'Contract Reg No',"
         				+ "a.refname 'Client Name',  a.contactperson 'Contact Person', cdr.name 'Driver',"
         				+ "a.per_mob 'Mob NO', date_format(r.duedate,'%d.%m.%Y') 'Due Date',"
         				+ "  convert(coalesce(r.refno,''),char(30)) 'Ref No',r.manualra 'Manual RA',"
         				+ "  ur.user_name 'Open User', ms.sal_name 'Salesman' , tc.rate Rent,tc.cdw CDW,"
         				+ "  coalesce((select invoiced from gl_lcalc where rdocno=r.doc_no and invno >0 and idno=1 and  rowno=(select max(rowno) from gl_lcalc where rdocno=r.doc_no and invno >0 and idno=1)),0) 'Inv Rent',"
         				+ "  coalesce((select invoiced from gl_lcalc where rdocno=r.doc_no and invno >0 and idno=17 and  rowno=(select max(rowno) from gl_lcalc where rdocno=r.doc_no and invno >0 and idno=17)),0) 'Inv CDW'  from gl_lagmt r	left join gl_vehmaster v on (r.perfleet=v.fleet_no or r.tmpfleet=v.fleet_no) left join my_acbook a on a.cldocno=r.cldocno   and a.dtype='CRM'  left join gl_vehgroup g on g.doc_no=v.vgrpid"
         				+ " left join  gl_ltarif tc on tc.rdocno=r.doc_no"
         				+ " left join gl_vehbrand br  on br.doc_no=v.brdid "
         				+ " left join gl_vehmodel mo on  mo.doc_no=v.vmodid"
         				+ " left join gl_vehmaster v1 on r.perfleet=v1.fleet_no"
         				+ "   left join gl_ldriver dr on dr.rdocno=r.doc_no and dr.status=3"
         				+ "  left join gl_drdetails cdr on cdr.dr_id=dr.drid "
         				+ " left join my_user ur on ur.doc_no=r.userid left join my_salm ms on ms.doc_no=r.salid ,"
         				+ "(SELECT @s:= 0) AS s  where r.status=3     " +sqltest+ " group by r.doc_no";
         		
         	
         System.out.println("--------"+sql);
             
         		ResultSet resultSet = stmtVeh.executeQuery(sql);
         		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
         		// System.out.println("--------"+RESULTDATA);
  				stmtVeh.close();
  				
         	
         	
         	conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
     return RESULTDATA;
 }
 
 public JSONArray clientDetailsSearch() throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		    
		Connection conn = null;
	    
		  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtsalik = conn.createStatement ();
		    
		    String sql = "";
			
			sql = "select cldocno,refname from my_acbook where status=3 and dtype='CRM'";
			
			ResultSet resultSet = stmtsalik.executeQuery(sql);
		                
		    RESULTDATA=ClsCommon.convertToJSON(resultSet);
		    stmtsalik.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATA;
		}
 }
