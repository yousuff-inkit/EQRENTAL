package com.emailsmsautogenerate;

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

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.*;

import com.connection.ClsConnection;

public class EmailSmsAutoContextListener implements ServletContextListener {

	private ScheduledExecutorService scheduler;

	@Override
	public void contextInitialized(ServletContextEvent event) {

		ClsConnection ClsConnection=new ClsConnection();

		Connection conn = ClsConnection.getMyConnection();
		com.emailsmsautogenerate.EmailSmsAutoAction emailsmsautogenerate= new EmailSmsAutoAction(); 

		Timer time = new Timer(); // Instantiate Timer Object
		//ScheduledTask st = new ScheduledTask(); // Instantiate SheduledTask class


		Statement stmtrun =null;
		ResultSet rsrun=null;
		long emailsmsautogenerateperiod=0;
		
		try {
			rsrun = conn.createStatement().executeQuery("Select description,SUBSTRING_INDEX(replace(description,'DAY', ''), ',', 1) days,"
					+ "SUBSTRING_INDEX(SUBSTRING_INDEX(replace(description,'Hours', ''), ',', -2), ' ', 2) hours,"
					+ "RIGHT(SUBSTRING_INDEX(replace(description,'Minutes', ''), ',', -1),3) minutes from gl_config where field_nme='emailsmsautogenerate'");
			while(rsrun.next())
			{
				//emailsmsautogenerateperiod=rsrun.getLong("description");	
				fONE_DAY=rsrun.getInt("days");	
				fFOUR_AM=rsrun.getInt("hours");
				fZERO_MINUTES=rsrun.getInt("minutes");
			}
			
			//time.schedule(emailsmsautogenerate, 45000, satperiod);
			time.scheduleAtFixedRate(emailsmsautogenerate,getReShedulingTime(),fONCE_PER_DAY);
			//time.scheduleAtFixedRate(emailsmsautogenerate, 10, fONCE_PER_DAY);
			
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
		

		/*scheduler = Executors.newSingleThreadScheduledExecutor();
        scheduler.scheduleAtFixedRate(new SomeDailyJob(), 0, 1, TimeUnit.DAYS);
        scheduler.scheduleAtFixedRate(new SomeHourlyJob(), 0, 1, TimeUnit.HOURS);
        scheduler.scheduleAtFixedRate(new SATdownloadAction(), 1, 8, TimeUnit.MINUTES);*/
	}

	@Override
	public void contextDestroyed(ServletContextEvent event) {
		scheduler.shutdownNow();
	}
	
	
	  private final static long fONCE_PER_DAY = 86400000;

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
		System.out.println("time---------- :"+result.getTime());
	    return result.getTime();
	  }

}


