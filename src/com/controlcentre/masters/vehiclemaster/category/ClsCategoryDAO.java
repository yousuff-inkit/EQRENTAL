package com.controlcentre.masters.vehiclemaster.category;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import com.connection.ClsConnection;
//import com.sun.org.apache.bcel.internal.generic.DCONST;

public class ClsCategoryDAO {
	ClsConnection ClsConnection=new ClsConnection();




	ClsCategoryBean categoryBean = new ClsCategoryBean();
	public int insert(Date date_category, String category,String mode, HttpSession session,String formdetailcode,String txtcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			int aaa;
			
			
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testSql="select name from gl_vehcategory where status<>7 and name='"+category+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				stmtTest.close();
				conn.close();
				return -1;
			}
			CallableStatement stmtCategory = conn.prepareCall("{CALL vehCategoryDML(?,?,?,?,?,?,?,?)}");
			stmtCategory.registerOutParameter(6, java.sql.Types.INTEGER);
			stmtCategory.setString(1,category);
			stmtCategory.setString(2,txtcode);
			stmtCategory.setDate(3,date_category);
			stmtCategory.setString(4,session.getAttribute("BRANCHID").toString());
			stmtCategory.setString(5,session.getAttribute("USERID").toString());
			stmtCategory.setString(7,"A");
			stmtCategory.setString(8, formdetailcode);
			int val = stmtCategory.executeUpdate();
			aaa=stmtCategory.getInt("docNo");
		//System.out.println("FORM====="+formdetailcode);
			categoryBean.setDocno(aaa);
			
			if (val > 0) {
//				System.out.println("Sucess"+CategoryBean.getDocno());
				conn.commit();
				stmtCategory.close();
				stmtTest.close();
				conn.close();
				return aaa;
			}
			stmtCategory.close();
			stmtTest.close();

			conn.close();
		}catch(Exception e){	
		e.printStackTrace();	
		conn.close();
		}
		return 0;
	}

	public int edit(int docno, Date date_category, String category, HttpSession session,String formdetailcode,String txtcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testSql="select name from gl_vehcategory where status<>7 and name='"+category+"' and doc_no<>'"+docno+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				stmtTest.close();
				conn.close();
				return -1;
			}
		
			CallableStatement stmtCategory = conn.prepareCall("{CALL vehCategoryDML(?,?,?,?,?,?,?,?)}");
			stmtCategory.setString(1,category);
			stmtCategory.setString(2,txtcode);
			stmtCategory.setDate(3,date_category);
			stmtCategory.setString(4,session.getAttribute("BRANCHID").toString());
			stmtCategory.setString(5,session.getAttribute("USERID").toString());
			stmtCategory.setInt(6, docno);
			stmtCategory.setString(7,"E");
			stmtCategory.setString(8, formdetailcode);
			stmtCategory.executeUpdate();
			int aaa=stmtCategory.getInt("docNo");
//			System.out.println(aaa);
			categoryBean.setDocno(aaa);
			
			if (aaa > 0) {
//				System.out.println("Sucess");
				conn.commit();
				stmtTest.close();

				stmtCategory.close();
				conn.close();
				return aaa;
			}

			stmtCategory.close();
			stmtTest.close();

			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return 0;
	}


	public int delete(int docno, HttpSession session,String category,String formdetailcode) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			
			String testsql3="select m.doc_no from gl_vehcategory c inner join gl_vehmaster m on m.catid=c.doc_no where c.name='"+category+"'";
			ResultSet resultSet3 = stmtTest.executeQuery (testsql3);
			if(resultSet3.next()){
				stmtTest.close();
				conn.close();
				return -2;
			}
			CallableStatement stmtCategory = conn.prepareCall("{CALL vehCategoryDML(?,?,?,?,?,?,?,?)}");
			stmtCategory.setString(1,null);
			stmtCategory.setString(2,null);
			stmtCategory.setDate(3,null);
			stmtCategory.setString(4,session.getAttribute("BRANCHID").toString());
			stmtCategory.setString(5,session.getAttribute("USERID").toString());
			stmtCategory.setInt(6, docno);
			stmtCategory.setString(7,"D");
			stmtCategory.setString(8, formdetailcode);
			stmtCategory.executeUpdate();
			int aaa=stmtCategory.getInt("docNo");
			categoryBean.setDocno(aaa);
			
			if (aaa > 0) {
//				System.out.println("Sucess");
				conn.commit();
				stmtCategory.close();
				stmtTest.close();

				conn.close();
				return aaa;
			}
			stmtTest.close();

			stmtCategory.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return 0;
	}


    public  List<ClsCategoryBean> list() throws SQLException {
        List<ClsCategoryBean> listBean = new ArrayList<ClsCategoryBean>();
        Connection conn = ClsConnection.getMyConnection();
		try {
				
				
				Statement stmtCategory = conn.createStatement ();
            	
				ResultSet resultSet = stmtCategory.executeQuery ("select name, doc_no,DATE,code from gl_vehcategory where status<>7");

				while (resultSet.next()) {
					
					ClsCategoryBean bean = new ClsCategoryBean();
	            	bean.setDocno(resultSet.getInt("doc_no"));
					bean.setCategory(resultSet.getString("name"));
					bean.setDate_category(resultSet.getDate("date"));
					bean.setTxtcode(resultSet.getString("code")); 
            	

	            	listBean.add(bean);
//	            	System.out.println(listBean);
				}

				stmtCategory.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
//System.out.println("nitin===="+listBean);
        return listBean;
    }




}
