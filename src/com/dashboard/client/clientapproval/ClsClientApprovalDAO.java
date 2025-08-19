package com.dashboard.client.clientapproval;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsClientApprovalDAO  {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

  public JSONArray clientApprovalGridLoading(String branch,String cldocno,String check) throws SQLException {
	
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
			
			if(!(cldocno.equalsIgnoreCase("0")) && !(cldocno.equalsIgnoreCase(""))){
				sqls+=" and cl.cldocno="+cldocno+"";
	        }
			
			System.out.println("SELECT category,refname,cldocno,per_mob,sal_name,concat(coalesce(address,''),'  ',coalesce(address2,'')) as address,mail1,"
		    		+ "if(invc_method=1,'Advance',if(invc_method=2,'Month End','Period')) invc_method,if(del_charges=0,'No','Yes') del_charges FROM my_acbook cl left JOIN "
		    		+ "my_clcatm cat ON cl.catid=cat.doc_no and cat.dtype='CRM' left join my_salm s on cl.sal_id=s.doc_no where cl.dtype='CRM' and cl.status=0"+sqls+" order by cl.doc_no");
			
		    ResultSet resultSet = stmtCRM.executeQuery ("SELECT category,refname,cldocno,per_mob,sal_name,concat(coalesce(address,''),'  ',coalesce(address2,'')) as address,mail1,"
		    		+ "if(invc_method=1,'Advance',if(invc_method=2,'Month End','Period')) invc_method,if(del_charges=0,'No','Yes') del_charges FROM my_acbook cl left JOIN "
		    		+ "my_clcatm cat ON cl.catid=cat.doc_no and cat.dtype='CRM' left join my_salm s on cl.sal_id=s.doc_no where cl.dtype='CRM' and cl.status=0"+sqls+" order by cl.doc_no");
		    
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
  
  public JSONArray clientApprovalExcelExport(String branch,String cldocno,String check) throws SQLException {
	  
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
				
				if(!(cldocno.equalsIgnoreCase("0")) && !(cldocno.equalsIgnoreCase(""))){
					sqls+=" and cl.cldocno="+cldocno+"";
		        }
				
			    ResultSet resultSet = stmtCRM.executeQuery ("SELECT category CATEGORY,refname NAME,cldocno Client_Code,per_mob MOBILE,sal_name SALESMAN,concat(coalesce(address,''),'  ',coalesce(address2,'')) as ADDRESS,"
			    		+ "mail1 'EMAIL ID',if(invc_method=1,'Advance',if(invc_method=2,'Month End','Period')) 'INV METHOD',if(del_charges=0,'No','Yes') 'DEL. CHARGES' FROM my_acbook cl left JOIN "
			    		+ "my_clcatm cat ON cl.catid=cat.doc_no and cat.dtype='CRM' left join my_salm s on cl.sal_id=s.doc_no where cl.dtype='CRM' and cl.status=0"+sqls+" order by cl.doc_no");
			    
			    RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
			    
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
  
  public JSONArray clientDetailsSearch(String clientname,String contact,String check) throws SQLException {
	   
	    JSONArray RESULTDATA1=new JSONArray();
	    
	    if(!(check.equalsIgnoreCase("1"))){
	    	return RESULTDATA1;
	    }
	    
	    Connection conn=null;
	    
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtCRM = conn.createStatement();
			
	    	    String sql = "";
	    	    
	            if(!(clientname.equalsIgnoreCase(""))){
	             sql=sql+" and t.description like '%"+clientname+"%'";
	            }
	            if(!(contact.equalsIgnoreCase(""))){
	                sql=sql+" and a.per_mob like '%"+contact+"%'";
	            }
	            
				sql = "select a.per_mob,a.doc_no,t.description from my_acbook a left join my_head t on a.acno=t.doc_no "
						+ "and a.dtype='CRM' where t.atype='AR' and a.status=0 and t.m_s=0"+sql;
				
				ResultSet resultSet1 = stmtCRM.executeQuery(sql);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtCRM.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
}
