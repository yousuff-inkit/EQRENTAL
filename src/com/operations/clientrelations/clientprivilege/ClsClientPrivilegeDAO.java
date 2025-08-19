package com.operations.clientrelations.clientprivilege;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;


public class ClsClientPrivilegeDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	
	ClsClientPrivilegeBean checkinBean = new ClsClientPrivilegeBean();
	
	Connection conn;
	
	public int insert( String privilege,String percentage,HttpSession session,String mode,String formdetailcode) throws SQLException {
		try{
			System.out.println("DAO");
			System.out.println(mode);
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			int docno;
			
			CallableStatement stmtServiceType = conn.prepareCall("{call privilegeDML(?,?,?,?,?,?,?)}");

			stmtServiceType.registerOutParameter(4, java.sql.Types.INTEGER);
			stmtServiceType.setString(1, privilege);
			stmtServiceType.setString(2,session.getAttribute("BRANCHID").toString());
			stmtServiceType.setString(3,session.getAttribute("USERID").toString());
			stmtServiceType.setString(5,mode);
			stmtServiceType.setString(6, formdetailcode);
			stmtServiceType.setDouble(7,percentage.equalsIgnoreCase(" ") || percentage.equalsIgnoreCase("") || percentage.equalsIgnoreCase("null") || percentage==null?0.0:Double.parseDouble(percentage.trim()));
			stmtServiceType.executeUpdate();

			docno=stmtServiceType.getInt("docNo");
			if (docno > 0) {
				conn.commit();
				stmtServiceType.close();
				conn.close();
				return docno;
			}
			else if (docno == -1){
				stmtServiceType.close();
				conn.close();
				return docno;
			}
			stmtServiceType.close();
			conn.close();
	 }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
		 conn.close();
	 }
	return 0;
  }

	public int edit( String privilege,String percentage,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
	
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtServiceType = conn.prepareCall("{call privilegeDML(?,?,?,?,?,?,?)}");

			stmtServiceType.setInt(4, docno);
			stmtServiceType.setString(1,privilege);
			stmtServiceType.setString(2,session.getAttribute("BRANCHID").toString());
			stmtServiceType.setString(3,session.getAttribute("USERID").toString());
			stmtServiceType.setString(5,"E");
			stmtServiceType.setString(6, formdetailcode);
			stmtServiceType.setDouble(7,percentage.equalsIgnoreCase(" ") || percentage.equalsIgnoreCase("") || percentage.equalsIgnoreCase("null") || percentage==null?0.0:Double.parseDouble(percentage.trim()));
			stmtServiceType.executeUpdate();

			//System.out.println(mode);
			
			int documentNo=stmtServiceType.getInt("docNo");
			if (documentNo > 0) {
				conn.commit();
				stmtServiceType.close();
				conn.close();
				return 1;
			}
			else if (documentNo == -1){
				stmtServiceType.close();
				conn.close();
				return documentNo;
			}
			stmtServiceType.close();
			conn.close();
	 }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
		 conn.close();
	 }
	return 0;
  }


	public boolean delete( String privilege,String percentage,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtServiceType = conn.prepareCall("{call privilegeDML(?,?,?,?,?,?,?)}");
		
			stmtServiceType.setInt(4, docno);
			stmtServiceType.setString(1,privilege);
			stmtServiceType.setString(2,session.getAttribute("BRANCHID").toString());
			stmtServiceType.setString(3,session.getAttribute("USERID").toString());
			stmtServiceType.setString(5,"D");
			stmtServiceType.setString(6, formdetailcode);
			stmtServiceType.setDouble(7,percentage.equalsIgnoreCase(" ") || percentage.equalsIgnoreCase("") || percentage.equalsIgnoreCase("null") || percentage==null?0.0:Double.parseDouble(percentage.trim()));
			stmtServiceType.executeUpdate();

			int documentNo=stmtServiceType.getInt("docNo");
			if (documentNo > 0) {
				conn.commit();
				stmtServiceType.close();
				return true;
			}	
			stmtServiceType.close();
		  conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
			return false;
		}finally{
			conn.close();
		}
		return false;
	}
	public  JSONArray getPrivilege() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
            	String sqldata="select wt.doc_no,wt.name,wt.per from my_clprivilage wt where wt.status<>7";
            	//System.out.println("nation=="+sqldata);
				ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtVeh1.close();
				conn.close();
				 return RESULTDATA;

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
}
