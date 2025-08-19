package com.dashboard.client.clientportal;

import java.sql.*;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
public class ClsClientPortalDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getClientData(String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String str="select ac.cldocno,ac.refname,ac.address,ac.mail1,ac.per_mob,head.account,ac.clientusername from my_acbook ac left join my_head head on ac.acno=head.doc_no where ac.status=3 and ac.dtype='CRM'";
			ResultSet rs=stmt.executeQuery(str);
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
