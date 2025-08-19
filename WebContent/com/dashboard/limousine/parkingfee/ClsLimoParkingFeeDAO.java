package com.dashboard.limousine.parkingfee;

import java.sql.*;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsLimoParkingFeeDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getParkingFeeData(String cldocno,String location,String branch,String id) throws SQLException{
		Connection conn=null;
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and m.cldocno="+cldocno;
			}
			if(!location.equalsIgnoreCase("")){
				sqltest+=" and m.locationdocno="+location;
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and m.brhid="+branch;
			}
			String strsql="select m.doc_no,m.cldocno,m.locationdocno,round(m.amount,2) amount,ac.refname,loc.location from gl_limoparkingfee m "+
			" left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_cordinates loc on (m.locationdocno=loc.doc_no and "+
			" loc.chkairport=1 and loc.status=3) where m.status=3"+sqltest;
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
	
	public JSONArray getParkingFeeDataExcel(String cldocno,String location,String branch,String id) throws SQLException{
		Connection conn=null;
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and m.cldocno="+cldocno;
			}
			if(!location.equalsIgnoreCase("")){
				sqltest+=" and m.locationdocno="+location;
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and m.brhid="+branch;
			}
			String strsql="select m.cldocno 'Client #',ac.refname 'Client',loc.location 'Airport',format(round(m.amount,2),2) 'Amount' from gl_limoparkingfee m "+
			" left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') left join gl_cordinates loc on (m.locationdocno=loc.doc_no and "+
			" loc.chkairport=1 and loc.status=3) where m.status=3"+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToEXCEL(rs);
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
