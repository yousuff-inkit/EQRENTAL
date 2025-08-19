package com.dashboard.equipment.equiputildownload;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.TimerTask;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEquipUtilDownloadAction extends TimerTask{

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public void run(){
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			ClsEquipUtilDownloadDAO dao=new ClsEquipUtilDownloadDAO();
			java.sql.Date sqldate=null;
			String strmisc="select CURDATE() basedate";
			ResultSet rsmisc=conn.createStatement().executeQuery(strmisc);
			while(rsmisc.next()){
				sqldate=rsmisc.getDate("basedate");
			}
			int value=dao.downloadData(sqldate, conn);
			if(value>0){
				conn.commit();
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
