package com.controlcentre.masters.vehiclemaster.subcategory;

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
public class ClsSubcategoryDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsSubcategoryBean subcategoryBean = new ClsSubcategoryBean();
	public int insert(String name, String catid, Date sqlStartDate,
			HttpSession session,String mode,String formdetailcode,String code) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			int aaa;
			
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testSql="select name from gl_vehsubcategory where status<>7 and name='"+name+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				stmtTest.close();
				conn.close();
				return -1;
			}
//			System.out.println("brandid"+brandid);
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			CallableStatement stmtSubcategory = conn.prepareCall("{call vehSubcategoryDML(?,?,?,?,?,?,?,?,?)}");
//			System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//			CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
			stmtSubcategory.registerOutParameter(6, java.sql.Types.INTEGER);
			stmtSubcategory.setString(1,name);
			stmtSubcategory.setDate(2,sqlStartDate);
			stmtSubcategory.setString(3,catid);
//			System.out.println("brandid"+brandid);
			stmtSubcategory.setString(4,session.getAttribute("BRANCHID").toString());
			stmtSubcategory.setString(5,session.getAttribute("USERID").toString());
			stmtSubcategory.setString(7,mode);
			stmtSubcategory.setString(8,formdetailcode);
			stmtSubcategory.setString(9,code);
			stmtSubcategory.executeQuery();
			aaa=stmtSubcategory.getInt("docNo");
//			System.out.println("no====="+aaa);
			subcategoryBean.setDocno(aaa);
			if (aaa > 0) {
				
//				System.out.println("Success"+SubcategoryBean.getDocno());
				conn.commit();
				stmtTest.close();
				stmtSubcategory.close();
				conn.close();
				return aaa;
			}
			stmtTest.close();
			stmtSubcategory.close();
			conn.close();
		}catch(Exception e){	
		e.printStackTrace();	
		conn.close();
		}
		return 0;
	}
	

    public  List<ClsSubcategoryBean> list() throws SQLException {
        List<ClsSubcategoryBean> listBean = new ArrayList<ClsSubcategoryBean>();
        Connection conn = ClsConnection.getMyConnection();
		try {
				
				Statement stmtCategory = conn.createStatement ();
            	
				ResultSet resultSet = stmtCategory.executeQuery ("select m1.name,m1.code,m1.doc_no,m1.catid,m1.date,m2.name catname,m2.doc_no catid from gl_vehsubcategory m1 left join gl_vehcategory m2 on m1.catid=m2.doc_no where m1.status<>7");

				while (resultSet.next()) {
					
					ClsSubcategoryBean bean = new ClsSubcategoryBean();
	            	bean.setDocno(resultSet.getInt("doc_no"));
					bean.setName(resultSet.getString("name"));
					bean.setCode(resultSet.getString("code"));
					bean.setSubcategorydate(resultSet.getDate("date"));
					bean.setCatname(resultSet.getString("catname"));
					bean.setCatid(resultSet.getString("catid"));
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

	public int edit(String name,int docno,Date subcategorydate,String catid,String mode, HttpSession session,String formdetailcode,String code) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			
//			System.out.println(conn);
			conn.setAutoCommit(false);
			Statement stmtTest=conn.createStatement ();
			String testSql="select name from gl_vehsubcategory where status<>7 and name='"+name+"' and doc_no<>'"+docno+"'";
			ResultSet resultSet1 = stmtTest.executeQuery (testSql);
			if(resultSet1.next()){
				stmtTest.close();
				conn.close();
				return -1;
			}
			CallableStatement stmtSubcategory = conn.prepareCall("{call vehSubcategoryDML(?,?,?,?,?,?,?,?,?)}");
			//PreparedStatement stmtSubcategory = conn.prepareStatement("update gl_vehSubcategory set brandid=?, date=?,Subcategory=? where doc_no=?");
			//System.out.println("update gl_vehSubcategory set brandid='"+brandid+"',date='"+Subcategorydate+"',Subcategory='"+Subcategory+"' where doc_no='"+docno+"'");
			stmtSubcategory.setInt(6, docno);
			stmtSubcategory.setString(1,name);
			stmtSubcategory.setDate(2,subcategorydate);
			stmtSubcategory.setString(3,catid);
			stmtSubcategory.setString(4,session.getAttribute("BRANCHID").toString());
			stmtSubcategory.setString(5,session.getAttribute("USERID").toString());
			stmtSubcategory.setString(7,mode);
			stmtSubcategory.setString(8,formdetailcode);
			stmtSubcategory.setString(9,code);

//			System.out.println("before date");
			//stmtModel.setDate(2,(Date)modeldate);
//			System.out.println("after date");
//	System.out.println(brandid+":"+docno+":"+model+":"+modeldate);
	
			int aa = stmtSubcategory.executeUpdate();
			
//			System.out.println("inside DAO1");
			if (aa>0) {
//				System.out.println("Success");
				conn.commit();
				stmtTest.close();
				stmtSubcategory.close();
				conn.close();
				return aa;
			}
			
			stmtTest.close();
			stmtSubcategory.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		
		
		return 0;
	}


	public int delete(String name,int docno,Date subcategorydate,String catid,String mode, HttpSession session,String formdetailcode,String code) throws SQLException {
		Connection conn=ClsConnection.getMyConnection();
		try{
			
			conn.setAutoCommit(false);
//			System.out.println(conn);
			Statement stmtTest=conn.createStatement ();

			String testsql3="select m.doc_no from gl_vehsubcategory b inner join gl_vehmaster m on m.subcatid=b.doc_no where b.name='"+name+"'";
			ResultSet resultSet3 = stmtTest.executeQuery (testsql3);
			if(resultSet3.next()){
				stmtTest.close();
				conn.close();
				return -2;
			}
			CallableStatement stmtSubcategory = conn.prepareCall("{call vehSubcategoryDML(?,?,?,?,?,?,?,?,?)}");
			stmtSubcategory.setString(1,name);
			stmtSubcategory.setDate(2,subcategorydate);
			stmtSubcategory.setString(3,catid);
			stmtSubcategory.setString(4,session.getAttribute("BRANCHID").toString());
			stmtSubcategory.setString(5,session.getAttribute("USERID").toString());
			stmtSubcategory.setInt(6,docno);
			stmtSubcategory.setString(7,mode);
			stmtSubcategory.setString(8,formdetailcode);
			stmtSubcategory.setString(9,code);

			//PreparedStatement stmtModel = conn.prepareStatement("update gl_vehmodel set status=7 where doc_no=?");
//			System.out.println("after stm inside delete");
			//System.out.println("update gl_vehmodel set status=7 where doc_no="+docno);
			//stmtModel.setInt(1,docno);
			int aa = stmtSubcategory.executeUpdate();
			if (aa>0) {
//				System.out.println("Success");
				conn.commit();
				stmtSubcategory.close();
				stmtTest.close();
				conn.close();
				return aa;
			}
			stmtTest.close();
			stmtSubcategory.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		
		
		return 0;
	}
	}

