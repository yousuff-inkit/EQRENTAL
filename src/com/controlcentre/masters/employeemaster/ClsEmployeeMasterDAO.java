package com.controlcentre.masters.employeemaster;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEmployeeMasterDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	 ClsEmployeeMasterBean employeemasterbean = new ClsEmployeeMasterBean();

	 public int insert(Date employeeMasterDate, String formdetailcode, String txtemployeeid, String txtemployeename, int txtempaccdocno, HttpSession session,HttpServletRequest request, String mode) throws SQLException {
			
		 		Connection conn = null;

		 		try{
		 			conn=ClsConnection.getMyConnection();
					conn.setAutoCommit(false);
					Statement stmtEMPS = conn.createStatement();
					
		 			String company=session.getAttribute("COMPANYID").toString().trim();
		 			String branch=session.getAttribute("BRANCHID").toString().trim();
		 			String currency=session.getAttribute("CURRENCYID").toString().trim();
		 			String userid=session.getAttribute("USERID").toString().trim();
					int docno;
					
					CallableStatement stmtEMP = conn.prepareCall("{CALL employeeMasterDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					stmtEMP.registerOutParameter(11, java.sql.Types.INTEGER);
					stmtEMP.setDate(1,employeeMasterDate);
					stmtEMP.setString(2,txtemployeeid);
					stmtEMP.setString(3,txtemployeename);
					stmtEMP.setInt(4,txtempaccdocno);
					stmtEMP.setString(5,"1");
					
					stmtEMP.setString(6,formdetailcode);
					stmtEMP.setString(7,currency);
					stmtEMP.setString(8,company);
					stmtEMP.setString(9,branch);
					stmtEMP.setString(10,userid);
					stmtEMP.setString(12,mode);
					stmtEMP.executeUpdate();
					docno=stmtEMP.getInt("docNo");
					
					employeemasterbean.setTxtempmasterdocno(docno);
					if (docno > 0) {
						conn.commit();
						stmtEMP.close();
						stmtEMPS.close();
						conn.close();
						return docno;
				}
					stmtEMP.close();
					conn.close();
					return docno;
			 }catch(Exception e){	
				 	e.printStackTrace();
				 	conn.close();
				 	return 0;
			 }finally{
				 conn.close();
			 }
		}

	 public int edit(int txtempmasterdocno, String formdetailcode, Date employeeMasterDate, String txtemployeeid, String txtemployeename, int txtempaccdocno, HttpSession session, String mode) throws SQLException {
		 
		 	Connection conn = null;
		 	
		 try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				
				String company=session.getAttribute("COMPANYID").toString().trim();
	 			String branch=session.getAttribute("BRANCHID").toString().trim();
	 			String currency=session.getAttribute("CURRENCYID").toString().trim();
	 			String userid=session.getAttribute("USERID").toString().trim();
	 			
	 			CallableStatement stmtEMP = conn.prepareCall("{CALL employeeMasterDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				
				stmtEMP.setDate(1,employeeMasterDate);
				stmtEMP.setString(2,txtemployeeid);
				stmtEMP.setString(3,txtemployeename);
				stmtEMP.setInt(4,txtempaccdocno);
				stmtEMP.setString(5,"1");
				stmtEMP.setString(6,formdetailcode);
				stmtEMP.setString(7,currency);
				stmtEMP.setString(8,company);
				stmtEMP.setString(9,branch);
				stmtEMP.setString(10,userid);
				stmtEMP.setInt(11, txtempmasterdocno);
				stmtEMP.setString(12,mode);
				stmtEMP.executeUpdate();
				//MSystem.out.println(txtempmasterdocno+"======"+stmtEMP);
				int docno=txtempmasterdocno;
				//stmtEMP.getInt("docNo");
				
				employeemasterbean.setTxtempmasterdocno(docno);
				if (docno > 0) {
					
					conn.commit();
					stmtEMP.close();
					conn.close();
					return 1;
				}	
				stmtEMP.close();
				conn.close();
				return 1;
		 }catch(Exception e){
			 	e.printStackTrace();	
			 	conn.close();
			 	return 0;
		 }finally{
			 conn.close();
		 }
		}

		public int delete(int txtempmasterdocno, String formdetailcode, HttpSession session, String mode) throws SQLException {
			
			Connection conn = null;
		 
		try{
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			String company=session.getAttribute("COMPANYID").toString().trim();
	 		String branch=session.getAttribute("BRANCHID").toString().trim();
	 		String currency=session.getAttribute("CURRENCYID").toString().trim();
	 		String userid=session.getAttribute("USERID").toString().trim();
			
	 		CallableStatement stmtEMP = conn.prepareCall("{CALL employeeMasterDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			
			stmtEMP.setDate(1,null);
			stmtEMP.setString(2,"");
			stmtEMP.setString(3,"");
			stmtEMP.setInt(4,0);
			stmtEMP.setString(5,"1");
			stmtEMP.setString(6,formdetailcode);
			stmtEMP.setString(7,currency);
			stmtEMP.setString(8,company);
			stmtEMP.setString(9,branch);
			stmtEMP.setString(10,userid);
			stmtEMP.setInt(11, txtempmasterdocno);
			stmtEMP.setString(12,mode);
			stmtEMP.executeUpdate();
			//MSystem.out.println(txtempmasterdocno+"======"+stmtEMP);
			int docno=txtempmasterdocno;
			//stmtEMP.getInt("docNo");
			
			employeemasterbean.setTxtempmasterdocno(docno);
			if (docno > 0) {
				
				conn.commit();
				stmtEMP.close();
				conn.close();
				return 1;
			}
			if (docno == -1){
				stmtEMP.close();
				conn.close();
				return docno;
			}
			stmtEMP.close();
			conn.close();
			return 0;
	 }catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
		 conn.close();
	 }
  }
     
		public  ClsEmployeeMasterBean getViewDetails(int docNo) throws SQLException {
			
			ClsEmployeeMasterBean employeemasterbean = new ClsEmployeeMasterBean();
			
			Connection conn = null;
			
			try {
			
				conn = ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtEMP = conn.createStatement();

				String sql= ("select m.date, m.codeNo, m.name, m.acno, if(m.active=1,'ACTIVE','TERMINATED') empstatus,h.account from hr_empm m left join my_head h on m.acno=h.doc_no "
						+ "where m.status<>7 and m.doc_no="+docNo+"");
				
				ResultSet resultSet = stmtEMP.executeQuery(sql);
							
				while (resultSet.next()) {
					
					employeemasterbean.setEmployeeDate(resultSet.getDate("date").toString());
					employeemasterbean.setTxtemployeeid(resultSet.getString("codeNo"));
					employeemasterbean.setTxtemployeename(resultSet.getString("name"));
					employeemasterbean.setTxtempaccount(resultSet.getString("account"));
					employeemasterbean.setTxtempaccdocno(resultSet.getInt("acno"));
					employeemasterbean.setLblemployeestatus(resultSet.getString("empstatus"));
					
			        }
				stmtEMP.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
		return employeemasterbean;
		}
 
    public  JSONArray employeeMainSearch(HttpSession session,String empname,String empid) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        Enumeration<String> Enumeration = session.getAttributeNames();
           int a=0;
           while(Enumeration.hasMoreElements()){
            if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
             a=1;
            }
           }
           if(a==0){
         return RESULTDATA;
            }
             
           String brid=session.getAttribute("BRANCHID").toString();
       
        String sqltest="";
        
        if(!(empname.equalsIgnoreCase(""))){
            sqltest=sqltest+" and m.name like '%"+empname+"%'";
        }
        
        if(!(empid.equalsIgnoreCase(""))){
        	sqltest=sqltest+" and m.codeno like '%"+empid+"%'";
        }
        
           
     try {
    	   conn = ClsConnection.getMyConnection();
    	   Statement stmtEMP = conn.createStatement();
       
	       ResultSet resultSet = stmtEMP.executeQuery("select m.name,m.codeno emp_id,m.doc_no from hr_empm m where m.dtype='EMP' and m.status<>7" +sqltest);
	
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	       
	       stmtEMP.close();
	       conn.close();
     }catch(Exception e){
    	 conn.close();
    	 e.printStackTrace();
     }finally{
    	 conn.close();
     }
       return RESULTDATA;
   }

}
