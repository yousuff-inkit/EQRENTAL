package com.dashboard.equipment.equiputildownload;

import java.sql.Connection;
import java.util.Timer;
import java.util.Date;  
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.joda.time.Seconds;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.*;

import com.NewSatDownload.*;
import com.connection.ClsConnection;

public class EquipUtilContextListener implements ServletContextListener {

	private ScheduledExecutorService scheduler;

	@Override
	public void contextInitialized(ServletContextEvent event) {

		ClsConnection ClsConnection=new ClsConnection();

		Connection conn = ClsConnection.getMyConnection();
		
		Timer time = new Timer(); // Instantiate Timer Object
		//ScheduledTask st = new ScheduledTask(); // Instantiate SheduledTask class
		
		Statement stmtrun =null;
		ResultSet rsrun=null;
		long satperiod=0;
		
		try {
			rsrun = conn.createStatement().executeQuery("Select description,SUBSTRING_INDEX(replace(description,'DAY', ''), ',', 1) days,"
					+ "SUBSTRING_INDEX(SUBSTRING_INDEX(replace(description,'Hours', ''), ',', -1), ' ', 1) hours,"
					+ "RIGHT(SUBSTRING_INDEX(replace(description,'Minutes', ''), ',', -1),3) minutes from gl_config where field_nme='equipautoperiod'");
			System.out.println("===== "+rsrun);
			while(rsrun.next())
			{
				//satperiod=rsrun.getLong("description");	
				fONE_DAY=rsrun.getInt("days");	
				fFOUR_AM=rsrun.getInt("hours");
				fZERO_MINUTES=rsrun.getInt("minutes");
			}
			
			//time.schedule(satdownload, 45000, satperiod);
			// time.scheduleAtFixedRate(satdownload1, getReShedulingTime(), fONCE_PER_DAY);  TODAY
			ClsEquipUtilDownloadAction equipaction=new ClsEquipUtilDownloadAction();
			//time.scheduleAtFixedRate(equipaction, getReShedulingTime(), fONCE_PER_DAY);
			time.scheduleAtFixedRate(equipaction, getReShedulingTime() , 1000*60*120);
			//time.scheduleAtFixedRate(satdownloadfull, getReShedulingTime() , 1000*60*60*12);
			
		//	time.schedule(satdownload1, getReShedulingTime() , 2*60*60);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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

	@Override
	public void contextDestroyed(ServletContextEvent event) {
		scheduler.shutdownNow();
	}
	
	
	  private final static long fONCE_PER_DAY = 1000*60*60*24;

	  private static int fONE_DAY;
	  private static int fFOUR_AM;
	  private static int fZERO_MINUTES;

	  private static Date getReShedulingTime(){
		  Calendar tomorrow = new GregorianCalendar();
		  tomorrow.add(Calendar.DATE, fONE_DAY);
		  Calendar result = new GregorianCalendar(
	      tomorrow.get(Calendar.YEAR),
	      tomorrow.get(Calendar.MONTH),
	      tomorrow.get(Calendar.DATE),
	      fFOUR_AM,
	      fZERO_MINUTES
	    );
	    return result.getTime();
	  }

}


