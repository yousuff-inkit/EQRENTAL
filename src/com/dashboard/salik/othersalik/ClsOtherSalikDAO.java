package com.dashboard.salik.othersalik;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsOtherSalikDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getOtherSalikData(String id,String uptodate) throws SQLException{
		JSONArray salikdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return salikdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqldate=null;
			if(!uptodate.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(uptodate);
			}
			String strsql="select 'Edit' btnsave,salik.regno,salik.tagno,salik.trans,salik.sal_date,coalesce(salik.source,'') source,round(salik.AMOUNT,2) AMOUNT"+
			" from gl_salik salik left join gl_vehmaster veh on salik.regno=veh.reg_no AND veh.fstatus='L' where salik.isallocated=0 and salik.sal_date<='"+sqldate+"' and veh.reg_no is null and salik.status<>7 group by salik.trans";
			ResultSet rs=stmt.executeQuery(strsql);
			salikdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return salikdata;
	}
	
	public int delete(String trans, HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		 Connection conn  = null;
			try{
				conn=objconn.getMyConnection();
				Statement stmt = conn.createStatement (); 
			    String upsql="update gl_salik set inv_no=9999999,status=7  where trans in ("+trans+")";
			    System.out.println(upsql);
			    int val=stmt.executeUpdate(upsql);
			    System.out.println("---upsql---"+val);
			 	stmt.close();
				conn.close();
			 	return val;
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				conn.close();
			}
		return 0;	
	}
}
