package com.dashboard.client.bulksms;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.sms.SmsAction;

public class ClsBulkSMSDAO  {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

  public JSONArray clientGridLoading(String branch,String catid,String salid,String check) throws SQLException {
	
	  JSONArray RESULTDATA=new JSONArray();    
	
	  if(!(check.equalsIgnoreCase("1"))){
		  return RESULTDATA;
	  }
	
	  Connection conn = null;

	  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtCRM = conn.createStatement();
	    
		    String sqls="";
			
			if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
				sqls+=" and cl.brhid="+branch+"";      
    		}
			if(!((catid.equalsIgnoreCase("")) || (catid.equalsIgnoreCase("0")))){
				sqls+=" and cl.catid="+catid+"";         
    		}
			if(!((salid.equalsIgnoreCase("")) || (salid.equalsIgnoreCase("0")))){
				sqls+=" and cl.sal_id="+salid+"";          
    		}
			String sql="SELECT cat.category,refname,cl.cldocno,per_mob,sal_name,mail1 FROM my_acbook cl left join my_clcatm cat on cl.catid=cat.doc_no and cat.dtype='CRM' left join my_salm s on cl.sal_id=s.doc_no  where cl.dtype='CRM' and cl.status=3 "+sqls+"";
			//System.out.println("sql======"+sql);    
		    ResultSet resultSet = stmtCRM.executeQuery(sql);         
		    RESULTDATA=ClsCommon.convertToJSON(resultSet);
		    
		    stmtCRM.close();
		    conn.close();
	  }catch(Exception e){
		  e.printStackTrace();
		  conn.close();
	  }finally{
		  conn.close();
	  }
	  return RESULTDATA;
	}
	public JSONArray getClientCategory(String id) throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
		if(!(id.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		Connection conn = null;

		
		  try {
			     conn = ClsConnection.getMyConnection();
			    Statement stmtCRM = conn.createStatement ();
			    String clsql="select doc_no,cat_name from my_clcatm where status=3";
			    
			    ResultSet resultSet = stmtCRM.executeQuery (clsql);
			    
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtCRM.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
	}
	public JSONArray getSalesmanData(String id) throws SQLException{   
		JSONArray RESULTDATA=new JSONArray();
		if(!(id.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		Connection conn = null;

		
		  try {
			     conn = ClsConnection.getMyConnection();
			    Statement stmtCRM = conn.createStatement ();
			    String clsql="select sal_name name,doc_no from my_salm where status=3";   
			    
			    ResultSet resultSet = stmtCRM.executeQuery (clsql);
			    
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtCRM.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
	}
	public String sendSMS(String doc_no,String branchid,String dtype,String phone,String clname, String msg, Connection conn){
		System.out.println("inside sms");        
     
		Statement smt=null;
		try {

		    smt = conn.createStatement();
			SmsAction sms=new SmsAction();
			sms.doSendSms(phone, clname, msg, doc_no, dtype, branchid, conn);
			      
		}catch(Exception e){
			e.printStackTrace();
			return "fail";   
		}
			return "success";    
	 }   
 }
