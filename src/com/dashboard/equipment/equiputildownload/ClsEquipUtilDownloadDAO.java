package com.dashboard.equipment.equiputildownload;

import java.sql.SQLException;
import java.sql.Connection;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEquipUtilDownloadDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public int downloadData(java.sql.Date sqldate,Connection conn) throws SQLException{
		int errorstatus=0;
		try{
			Statement stmt=conn.createStatement();
			
			String strdelete="delete from eq_equiputil where date='"+sqldate+"'";
			int delete=stmt.executeUpdate(strdelete);
			String strinsert="insert into eq_equiputil(date,fleet_no,onhire,ready,insp,repair,pickup)"+
			" select '"+sqldate+"',fleet_no,"+
			" case when tran_code in ('RA','DL') then 1 else 0 end onhire,"+
			" case when tran_code in ('RR','PDI') then 1 else 0 end ready,"+
			" case when tran_code in ('UR') then 1 else 0 end insp,"+
			" case when tran_code in ('GS','GA','GM') then 1 else 0 end repair,"+
			" case when tran_code in ('PIK') then 1 else 0 end pickup"+
			" from gl_equipmaster where statu=3";
			System.out.println(strinsert);
			int insert=stmt.executeUpdate(strinsert);
			if(insert<=0){
				errorstatus=1;
				return 0;
			}
			else{
				return 1;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return errorstatus;
	}
}
