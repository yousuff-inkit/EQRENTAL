package com.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ClsConnectionMSSQL {

	public  Connection getMyConnection()
	{
		Connection conn=null;
		try {  
			/*
			 * Epic connection details
			 * 
			 * String JDBCDriver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"; String
			 * connString =
			 * "jdbc:sqlserver://gp-gateway:1433;selectMethod=cursor;databaseName=epic3";
			 * Class.forName(JDBCDriver); conn = DriverManager.getConnection(connString,
			 * "sa", "sa123");
			 */	        
			
			/*String url="jdbc:odbc:test";  
			   Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");  
			   conn=DriverManager.getConnection(url);  
			*/
			/* 
			 * mssql last working  
			*/ 
			  String JDBCDriver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"; 
			  // String connString ="jdbc:sqlserver://localhost:1433;integratedSecurity=true;databaseName=zk_db";  gateway server link  working
			  // String connString ="jdbc:sqlserver://HR/SQLEXPRESS:1433;user=sa;password=sa@1234;databaseName=zk_db"; nsib
//			  String connString ="jdbc:sqlserver://localhost;user=sa;password=sa@1234;databaseName=zk_db"; worked in nsib server  
			  String connString ="jdbc:sqlserver://HR/SQLEXPRESS;user=sa;password=sa@1234;databaseName=zk_db"; 		
			  
			  
			  
			  
			  // jdbc:sqlserver://dbHost\sqlexpress;user=sa;password=secret integratedSecurity=true;
			  // connString = "jdbc:sqlserver://gp-gateway:1433;selectMethod=cursor;databaseName=epic3"; 	
			  Class.forName(JDBCDriver); 
			  conn = DriverManager.getConnection(connString);
	          
		//	conn = DriverManager.getConnection("jdbc:sqlserver://localhost\gp-gateway", "myLoginId", "myPassword");
		/*	String dbURL = "jdbc:sqlserver://10.100.1.146:1433//GP-GATEWAY;user=sa;password=sa123";
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			 conn = DriverManager.getConnection(dbURL);*/
			if (conn != null) {
			    System.out.println("Connected");
			}
			  
			/*Statement stmtObj = conn.createStatement();
			ResultSet resObj = stmtObj.executeQuery("SELECT custname FROM rm00101 where dex_row_id<5;");
			while (resObj.next()) {
			    System.out.println(" data printing ==="+resObj.getString("custname"));
			}
*/
            /*Context ctx = new InitialContext();  
            DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/carrental");  
            conn = ds.getConnection();*/  
          
        }    
      
        catch (SQLException sqle) {  
            sqle.printStackTrace();  
        }
		catch (Exception e) {  
            e.printStackTrace();  
        }
		// System.out.println("----conn---"+conn);
        return conn;  
	}


}
