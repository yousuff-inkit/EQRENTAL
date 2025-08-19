package com.dashboard.audit.securitychequelist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSecurityChequeList  {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray securityChequeListGridLoading(String branch,String uptodate,String check,String cmbtype) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		Connection conn = null;
		
		java.sql.Date sqlUpToDate = null;
        
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtSecChqList = conn.createStatement();
			    
			    if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
		        	sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
		        }
			    
			    String sql = "",sqltest = "",condition = "";
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sqltest+=" and s.brhid="+branch+"";
	    		}
			    
			    if(!(sqlUpToDate==null)){
		        	sqltest+=" and s.chqdt<='"+sqlUpToDate+"'";
			    }
			    
			    if(cmbtype.equalsIgnoreCase("all")){
					condition+="";
				}
			    if(cmbtype.equalsIgnoreCase("open")){
					condition+=" and s.chqclose=0";
				}
			    if(cmbtype.equalsIgnoreCase("closed")){
					condition+=" and s.chqclose=1";
				}
				
			    sql = "select s.date,s.doc_no,s.chqno ,s.chqno cheque_no,s.chqdt,s.chqdt cheque_date,s.amount,s.remarks,s.acno_from,s.acno_to,s.brhid branchid,h.description bank,h1.description,h1.description paidto,"
			        + "convert(concat(' Date : ',coalesce(DATE_FORMAT(s.date,'%d-%m-%Y'),'  '),' * ','Doc No  : ',coalesce(s.doc_no, ' '),' * ',"
			    	+"'Cheque No : ' ,coalesce(s.chqno,' '),' * ','Cheque Date : ', coalesce(DATE_FORMAT(s.chqdt,'%d-%m-%Y'),' ')),char(1000)) info from my_secchq s " 
			    	+ "left join my_head h on s.acno_from=h.doc_no left join my_head h1 on s.acno_to=h1.doc_no where s.status=3 "+condition+" "+sqltest+" ";
			    
			    
			    
			    System.out.println("grid loading===="+sql);
			    
			    ResultSet resultSet = stmtSecChqList.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtSecChqList.close();
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