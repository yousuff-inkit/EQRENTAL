package com.dashboard.audit.newdb;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.google.gson.JsonArray;
import com.common.ClsCommon;
import com.connection.*;

public class NewDb {

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	
	
	public JSONArray listTables(String dbname,String check) throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
		
		if(!(check.equalsIgnoreCase("1"))){
	    	   return RESULTDATA;
	    }
		
		Connection conn = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtBUP = conn.createStatement();
			    String sql="";
			    
		    	sql = "SELECT table_name  FROM information_schema.`TABLES` WHERE table_schema ='"+dbname+"'";
			    	
			    ResultSet resultSet = stmtBUP.executeQuery(sql);
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtBUP.close();
			    conn.close();
		  } catch(Exception e){
		   e.printStackTrace();
		   conn.close();
		  } finally{
			  conn.close();
		  }
		  return RESULTDATA;	
	}

	public JSONArray listReqTables(String check) throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
		
		if(!(check.equalsIgnoreCase("1"))){
	    	   return RESULTDATA;
	    }
		Connection conn = null;
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtBUP = conn.createStatement();
			    String sql="";
			    
		    	sql = "SELECT tablename  FROM zz_reqtables";
			    	
			    ResultSet resultSet = stmtBUP.executeQuery(sql);
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtBUP.close();
			    conn.close();
		  } catch(Exception e){
		   e.printStackTrace();
		   conn.close();
		  } finally{
			  conn.close();
		  }
		  return RESULTDATA;	
	}

	public JSONArray getForm(String check) throws SQLException {
		String strSql="";
	    JSONArray RESULTDATA=new JSONArray();
	    /*if(!(check.equalsIgnoreCase("1")))
	    {
	    	return RESULTDATA;
	    }*/
	    Connection  conn = null;
        try {
			conn=ClsConnection.getMyConnection();
			Statement stmtuser = conn.createStatement ();
			
			strSql="SELECT formname menu ,tables FROM zz_formtables z;";
					
			ResultSet resultSet = stmtuser.executeQuery (strSql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtuser.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
	    return RESULTDATA;
	}
}
