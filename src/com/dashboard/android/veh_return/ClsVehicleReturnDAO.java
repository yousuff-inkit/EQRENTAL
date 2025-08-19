package com.dashboard.android.veh_return;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsVehicleReturnDAO
{
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray returnSearch() throws SQLException
	{
		JSONArray RESULTDATA=new JSONArray();
		    
		Connection conn = null;
	    
		  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtreg = conn.createStatement ();
		    
		    String sql = "";
			
			sql ="select v.doc_no,v.name,v.mobile_no,v.vehicle_no,DATE_FORMAT(v.rtn_date,'%d.%m.%Y') rtn_date,v.rtn_time,v.place,DATE_FORMAT(v.cdate,'%d.%m.%Y') cdate,u.name rname,u.email remail,u.mobile_no rmobile from vehicle_return v left join user_register u on v.user_id=u.doc_no where status=0;";
			System.out.println("..return"+sql);
			ResultSet rs= stmtreg.executeQuery(sql);
		                
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
	
	public JSONArray userSearch() throws SQLException
	{
		JSONArray RESULTDATAA=new JSONArray();
		    
		Connection conn = null;
	    
		  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtreg1 = conn.createStatement ();
		    
		    String sqll = "";
			
			sqll ="select doc_no,user_name from my_user";
			
			ResultSet rss= stmtreg1.executeQuery(sqll);
		                
		    RESULTDATAA=ClsCommon.convertToJSON(rss);
		    stmtreg1.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATAA;
	}
}
