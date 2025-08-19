package com.dashboard.travel.tours;
    
	import com.common.ClsCommon;
import com.connection.ClsConnection;

	import java.sql.*;

	import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
	public class ClsToursDAO {  

		ClsConnection objconn=new ClsConnection();     
		ClsCommon objcommon=new ClsCommon();     
		
		
		public JSONArray searchTourtype(HttpSession session) throws SQLException{
			JSONArray data=new JSONArray();                                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();  
				        
				String strsql="select name,doc_no from tr_tours where status=3"; 
				ResultSet rs=stmt.executeQuery(strsql);  
				data=objcommon.convertToJSON(rs);  
			}   
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();  
			}   
			return data;
		}
	}          