package com.dashboard.android.user_editprofile;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsProfileEditDAO
{
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray registerUser() throws SQLException
	{
		JSONArray RESULTDATA=new JSONArray();
		    
		Connection conn = null;
	    
		  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtreg = conn.createStatement ();
		    
		    String sql = "";
			
			sql="select doc_no,name,email,mobile_no,user_name from user_register";
			ResultSet rs= stmtreg.executeQuery(sql);
		                
			System.out.println("profilesql--"+sql);
		    RESULTDATA=ClsCommon.convertToJSON(rs);
		    stmtreg.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATA;
	}
}
