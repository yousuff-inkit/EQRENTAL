package com.dashboard.client.clientaccountlinking;  

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsClientDAO  {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
  public JSONArray clientListGridLoading(String check) throws SQLException {
	JSONArray RESULTDATA=new JSONArray();
	if(!(check.equalsIgnoreCase("load"))){
		return RESULTDATA;
	}
	Connection conn = null;

	
	  try {
		     conn = ClsConnection.getMyConnection();
		    Statement stmtCRM = conn.createStatement ();  
		    String clsql="SELECT convert(coalesce(cl.limoacno,''),char(50)) limoacno,h.account,cat.acc_group,tx.desc1 taxcat,cl.credit,cl.period,cl.period2,cat.category,refname,cl.cldocno,per_mob,sal_name,"
		    		+" concat(coalesce(address,''),'  ',coalesce(address2,'')) as address,mail1,if(invc_method=1,'Month End','Period') "
		    		+" invc_method, if(del_charges=0,'No','Yes') del_charges,trnnumber"
		    		+" FROM my_acbook CL left JOIN my_clcatm cat ON cl.catid=cat.doc_no and cat.dtype='CRM' left join my_salm s on cl.sal_id=s.doc_no"
		    		+" left join my_head h on cl.acno=h.doc_no left join my_cltax tx on cl.taxid=tx.doc_no where cl.dtype='CRM' and cl.status=3";
		   // System.out.println("sql======="+clsql);   
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
  
  public JSONArray clientListExcelExport(String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		if(!(check.equalsIgnoreCase("load"))){
			return RESULTDATA;
		}
		Connection conn = null;  
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtCRM = conn.createStatement ();
		    
			    ResultSet resultSet = stmtCRM.executeQuery ("SELECT cl.cldocno Client_Code,h.account 'Account No',convert(coalesce(cl.limoacno,''),char(50)) 'Limo Account No',cat.acc_group 'Acc Group',refname NAME,cat.category CATEGORY,tx.desc1 'Tax Category',trnnumber 'TRN No',"
			    		+ " concat(coalesce(address,''),'  ',coalesce(address2,'')) as ADDRESS,per_mob MOBILE,sal_name SALESMAN,mail1 'EMAIL ID',if(invc_method=1,'Month End','Period') "
			    		+ " 'INV METHOD',if(del_charges=0,'No','Yes') 'DEL. CHARGES',cl.credit  'Credit Limit',cl.period 'Credit Period',cl.period2 'Max Days'"
			    		+ " FROM my_acbook CL left JOIN my_clcatm cat ON cl.catid=cat.doc_no and cat.dtype='CRM' left join my_salm s on cl.sal_id=s.doc_no "
			    		+ " left join my_head h on cl.acno=h.doc_no left join my_cltax tx on cl.taxid=tx.doc_no where cl.dtype='CRM'");
			    
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
}
