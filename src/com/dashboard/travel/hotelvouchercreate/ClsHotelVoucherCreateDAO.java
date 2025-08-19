package com.dashboard.travel.hotelvouchercreate;
    
	import com.common.ClsCommon;
import com.connection.ClsConnection;

	import java.sql.*;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
	public class ClsHotelVoucherCreateDAO {  

		ClsConnection objconn=new ClsConnection();       
		ClsCommon objcommon=new ClsCommon();       
		
		public int insert(int rdocno,int rvocno,String suppconfno,String clid,String vndid,Date issuedate,String isstaffid,String countryid,String cityid,String hotelid,String roomtypeid,String mealplan,String txtrate,String taxamt,String supptot,String servfee,String paybackamt,String acc_docno,String sellingprice,String nonvatamt,String vatamt,String guest,String vtype,String branch,String clvatamt,String inclusiveval,HttpSession session,HttpServletRequest request,String mode) throws SQLException {
			  	Connection conn = null;    
			try{   
				conn=objconn.getMyConnection();        
				conn.setAutoCommit(false);
				Statement stmt=conn.createStatement(); 
				String userid=session.getAttribute("USERID").toString().trim();        
				int vocno=0,docno=0,datas=0;
				if(rdocno==0){
					String sqlvoc="select coalesce((max(voc_no)+1),1) voc_no from ti_hotelvoucherm where brhid='"+branch+"'";    
					ResultSet rs7=stmt.executeQuery(sqlvoc);
					if(rs7.next()){
						vocno=rs7.getInt("voc_no");    
					}
					String strsql="insert into ti_hotelvoucherm(voc_no, userid, status, brhid) values('"+vocno+"',"+userid+",3,"+branch+")";              
					//System.out.println(strsql);  
					int insertval=stmt.executeUpdate(strsql);   
					if(insertval>0){ 
						String sql1="select max(doc_no) docno from ti_hotelvoucherm";
						ResultSet rs=stmt.executeQuery(sql1);        
						if(rs.next()){
							docno=rs.getInt("docno");
						}
					}
				}else{
					docno=rdocno; 
					vocno=rvocno;   
				}   
				
				if(docno>0){
				CallableStatement stmtTVC = conn.prepareCall("{CALL ti_hotelvoucherDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");           
				stmtTVC.setString(1,suppconfno);  
				stmtTVC.setInt(2, clid=="" || clid==null || clid.equalsIgnoreCase("")?0:Integer.parseInt(clid));
				stmtTVC.setInt(3, vndid=="" || vndid==null || vndid.equalsIgnoreCase("")?0:Integer.parseInt(vndid));
				stmtTVC.setDate(4,issuedate);
				stmtTVC.setInt(5, isstaffid=="" || isstaffid==null || isstaffid.equalsIgnoreCase("")?0:Integer.parseInt(isstaffid));
				stmtTVC.setInt(6, countryid=="" || countryid==null || countryid.equalsIgnoreCase("")?0:Integer.parseInt(countryid));
				stmtTVC.setInt(7, cityid=="" || cityid==null || cityid.equalsIgnoreCase("")?0:Integer.parseInt(cityid));
				stmtTVC.setInt(8, hotelid=="" || hotelid==null || hotelid.equalsIgnoreCase("")?0:Integer.parseInt(hotelid));
				stmtTVC.setString(9,roomtypeid);
				stmtTVC.setString(10, mealplan);
				stmtTVC.setDouble(11, txtrate=="" || txtrate==null || txtrate.equalsIgnoreCase("")?0.0:Double.parseDouble(txtrate));
				stmtTVC.setDouble(12, nonvatamt=="" || nonvatamt==null || nonvatamt.equalsIgnoreCase("")?0.0:Double.parseDouble(nonvatamt));     
				stmtTVC.setDouble(13, taxamt=="" || taxamt==null || taxamt.equalsIgnoreCase("")?0.0:Double.parseDouble(taxamt));
				stmtTVC.setDouble(14, supptot=="" || supptot==null || supptot.equalsIgnoreCase("")?0.0:Double.parseDouble(supptot));
				stmtTVC.setDouble(15, servfee=="" || servfee==null || servfee.equalsIgnoreCase("")?0.0:Double.parseDouble(servfee));
				stmtTVC.setDouble(16, paybackamt=="" || paybackamt==null || paybackamt.equalsIgnoreCase("")?0.0:Double.parseDouble(paybackamt));
				stmtTVC.setInt(17, acc_docno=="" || acc_docno==null || acc_docno.equalsIgnoreCase("")?0:Integer.parseInt(acc_docno));
				stmtTVC.setDouble(18, sellingprice=="" || sellingprice==null || sellingprice.equalsIgnoreCase("")?0.0:Double.parseDouble(sellingprice));
				stmtTVC.setInt(19,docno);
				stmtTVC.setDouble(20, vatamt=="" || vatamt==null || vatamt.equalsIgnoreCase("")?0.0:Double.parseDouble(vatamt));    
				stmtTVC.setString(21,guest);
				stmtTVC.setString(22,vtype); 
				stmtTVC.setDouble(23, clvatamt=="" || clvatamt==null || clvatamt.equalsIgnoreCase("")?0.0:Double.parseDouble(clvatamt));
				stmtTVC.setInt(24, inclusiveval=="" || inclusiveval==null || inclusiveval.equalsIgnoreCase("")?0:Integer.parseInt(inclusiveval));     
				stmtTVC.setString(25,mode);  
				datas=stmtTVC.executeUpdate();
				 request.setAttribute("vocno", vocno);  
				//System.out.println("in dao==="+datas);  
				if(datas<=0){  
					stmtTVC.close();
					conn.close();
					return 0;
				}
				if(datas>0){  
					stmtTVC.close();
					stmt.close();   
				}
				}
			    //docno=stmtTVC.getInt("docNo");
				if (datas > 0) {
					conn.commit();
					conn.close();
					return docno;
				}
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
		public boolean edit(int rowno,String suppconfno,String clid,String vndid,Date issuedate,String isstaffid,String countryid,String cityid,String hotelid,String roomtypeid,String mealplan,String txtrate,String taxamt,String supptot,String servfee,String paybackamt,String acc_docno,String sellingprice,String nonvatamt,String vatamt,String guest,String vtype,String branch,String clvatamt,String inclusiveval,HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		  	Connection conn = null;    
		try{     
			conn=objconn.getMyConnection();        
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement(); 
			int datas=0;
			CallableStatement stmtTVC = conn.prepareCall("{CALL ti_hotelvoucherDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");           
			stmtTVC.setString(1,suppconfno);  
			stmtTVC.setInt(2, clid=="" || clid==null || clid.equalsIgnoreCase("")?0:Integer.parseInt(clid));
			stmtTVC.setInt(3, vndid=="" || vndid==null || vndid.equalsIgnoreCase("")?0:Integer.parseInt(vndid));
			stmtTVC.setDate(4,issuedate);
			stmtTVC.setInt(5, isstaffid=="" || isstaffid==null || isstaffid.equalsIgnoreCase("")?0:Integer.parseInt(isstaffid));
			stmtTVC.setInt(6, countryid=="" || countryid==null || countryid.equalsIgnoreCase("")?0:Integer.parseInt(countryid));
			stmtTVC.setInt(7, cityid=="" || cityid==null || cityid.equalsIgnoreCase("")?0:Integer.parseInt(cityid));
			stmtTVC.setInt(8, hotelid=="" || hotelid==null || hotelid.equalsIgnoreCase("")?0:Integer.parseInt(hotelid));
			stmtTVC.setString(9,roomtypeid);
			stmtTVC.setString(10, mealplan);
			stmtTVC.setDouble(11, txtrate=="" || txtrate==null || txtrate.equalsIgnoreCase("")?0.0:Double.parseDouble(txtrate));
			stmtTVC.setDouble(12, nonvatamt=="" || nonvatamt==null || nonvatamt.equalsIgnoreCase("")?0.0:Double.parseDouble(nonvatamt));     
			stmtTVC.setDouble(13, taxamt=="" || taxamt==null || taxamt.equalsIgnoreCase("")?0.0:Double.parseDouble(taxamt));
			stmtTVC.setDouble(14, supptot=="" || supptot==null || supptot.equalsIgnoreCase("")?0.0:Double.parseDouble(supptot));
			stmtTVC.setDouble(15, servfee=="" || servfee==null || servfee.equalsIgnoreCase("")?0.0:Double.parseDouble(servfee));
			stmtTVC.setDouble(16, paybackamt=="" || paybackamt==null || paybackamt.equalsIgnoreCase("")?0.0:Double.parseDouble(paybackamt));
			stmtTVC.setInt(17, acc_docno=="" || acc_docno==null || acc_docno.equalsIgnoreCase("")?0:Integer.parseInt(acc_docno));
			stmtTVC.setDouble(18, sellingprice=="" || sellingprice==null || sellingprice.equalsIgnoreCase("")?0.0:Double.parseDouble(sellingprice));
			stmtTVC.setInt(19,rowno);  
			stmtTVC.setDouble(20, vatamt=="" || vatamt==null || vatamt.equalsIgnoreCase("")?0.0:Double.parseDouble(vatamt));    
			stmtTVC.setString(21,guest);
			stmtTVC.setString(22,vtype); 
			stmtTVC.setDouble(23, clvatamt=="" || clvatamt==null || clvatamt.equalsIgnoreCase("")?0.0:Double.parseDouble(clvatamt));
			stmtTVC.setInt(24, inclusiveval=="" || inclusiveval==null || inclusiveval.equalsIgnoreCase("")?0:Integer.parseInt(inclusiveval));
			stmtTVC.setString(25,mode);  
			datas=stmtTVC.executeUpdate();
			//System.out.println("in dao==="+datas);  
			if(datas<=0){  
				stmtTVC.close();
				conn.close();
				return false;
			}
			if (datas > 0) { 
				stmtTVC.close();  
				stmt.close();   
				conn.commit();
				conn.close();
				return true;
			}
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
		public boolean delete(int rdocno,int rvocno,String suppconfno,String clid,String vndid,Date issuedate,String isstaffid,String countryid,String cityid,String hotelid,String roomtypeid,String mealplan,String txtrate,String taxamt,String supptot,String servfee,String paybackamt,String acc_docno,String sellingprice,String nonvatamt,String vatamt,String guest,String vtype,String branch,String clvatamt,String inclusiveval,HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		  	Connection conn = null;       
		try{   
			conn=objconn.getMyConnection();        
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement(); 
			String userid=session.getAttribute("USERID").toString().trim();        
			int datas=0;
			CallableStatement stmtTVC = conn.prepareCall("{CALL ti_hotelvoucherDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");           
			stmtTVC.setString(1,suppconfno);  
			stmtTVC.setInt(2, clid=="" || clid==null || clid.equalsIgnoreCase("")?0:Integer.parseInt(clid));
			stmtTVC.setInt(3, vndid=="" || vndid==null || vndid.equalsIgnoreCase("")?0:Integer.parseInt(vndid));
			stmtTVC.setDate(4,issuedate);
			stmtTVC.setInt(5, isstaffid=="" || isstaffid==null || isstaffid.equalsIgnoreCase("")?0:Integer.parseInt(isstaffid));
			stmtTVC.setInt(6, countryid=="" || countryid==null || countryid.equalsIgnoreCase("")?0:Integer.parseInt(countryid));
			stmtTVC.setInt(7, cityid=="" || cityid==null || cityid.equalsIgnoreCase("")?0:Integer.parseInt(cityid));
			stmtTVC.setInt(8, hotelid=="" || hotelid==null || hotelid.equalsIgnoreCase("")?0:Integer.parseInt(hotelid));
			stmtTVC.setString(9,roomtypeid);
			stmtTVC.setString(10, mealplan);
			stmtTVC.setDouble(11, txtrate=="" || txtrate==null || txtrate.equalsIgnoreCase("")?0.0:Double.parseDouble(txtrate));
			stmtTVC.setDouble(12, nonvatamt=="" || nonvatamt==null || nonvatamt.equalsIgnoreCase("")?0.0:Double.parseDouble(nonvatamt));     
			stmtTVC.setDouble(13, taxamt=="" || taxamt==null || taxamt.equalsIgnoreCase("")?0.0:Double.parseDouble(taxamt));
			stmtTVC.setDouble(14, supptot=="" || supptot==null || supptot.equalsIgnoreCase("")?0.0:Double.parseDouble(supptot));
			stmtTVC.setDouble(15, servfee=="" || servfee==null || servfee.equalsIgnoreCase("")?0.0:Double.parseDouble(servfee));
			stmtTVC.setDouble(16, paybackamt=="" || paybackamt==null || paybackamt.equalsIgnoreCase("")?0.0:Double.parseDouble(paybackamt));
			stmtTVC.setInt(17, acc_docno=="" || acc_docno==null || acc_docno.equalsIgnoreCase("")?0:Integer.parseInt(acc_docno));
			stmtTVC.setDouble(18, sellingprice=="" || sellingprice==null || sellingprice.equalsIgnoreCase("")?0.0:Double.parseDouble(sellingprice));
			stmtTVC.setInt(19,rdocno);
			stmtTVC.setDouble(20, vatamt=="" || vatamt==null || vatamt.equalsIgnoreCase("")?0.0:Double.parseDouble(vatamt));    
			stmtTVC.setString(21,guest);
			stmtTVC.setString(22,vtype); 
			stmtTVC.setDouble(23, clvatamt=="" || clvatamt==null || clvatamt.equalsIgnoreCase("")?0.0:Double.parseDouble(clvatamt));
			stmtTVC.setInt(24, inclusiveval=="" || inclusiveval==null || inclusiveval.equalsIgnoreCase("")?0:Integer.parseInt(inclusiveval));
			stmtTVC.setString(25,mode);  
			datas=stmtTVC.executeUpdate();  
			//System.out.println("in dao==="+datas);  
			if(datas<=0){  
				stmtTVC.close();
				conn.close();
				return false;
			}
			if (datas > 0) {
				stmtTVC.close();
				stmt.close();   
				conn.commit();
				conn.close();
				return true;
			}
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
		public boolean griddelete(int rowno,String suppconfno,String clid,String vndid,Date issuedate,String isstaffid,String countryid,String cityid,String hotelid,String roomtypeid,String mealplan,String txtrate,String taxamt,String supptot,String servfee,String paybackamt,String acc_docno,String sellingprice,String nonvatamt,String vatamt,String guest,String vtype,String branch,String clvatamt,String inclusiveval,HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		  	Connection conn = null;      
		try{     
			conn=objconn.getMyConnection();        
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement(); 
			int datas=0;
			CallableStatement stmtTVC = conn.prepareCall("{CALL ti_hotelvoucherDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");           
			stmtTVC.setString(1,suppconfno);  
			stmtTVC.setInt(2, clid=="" || clid==null || clid.equalsIgnoreCase("")?0:Integer.parseInt(clid));
			stmtTVC.setInt(3, vndid=="" || vndid==null || vndid.equalsIgnoreCase("")?0:Integer.parseInt(vndid));
			stmtTVC.setDate(4,issuedate);
			stmtTVC.setInt(5, isstaffid=="" || isstaffid==null || isstaffid.equalsIgnoreCase("")?0:Integer.parseInt(isstaffid));
			stmtTVC.setInt(6, countryid=="" || countryid==null || countryid.equalsIgnoreCase("")?0:Integer.parseInt(countryid));
			stmtTVC.setInt(7, cityid=="" || cityid==null || cityid.equalsIgnoreCase("")?0:Integer.parseInt(cityid));
			stmtTVC.setInt(8, hotelid=="" || hotelid==null || hotelid.equalsIgnoreCase("")?0:Integer.parseInt(hotelid));
			stmtTVC.setString(9,roomtypeid);
			stmtTVC.setString(10, mealplan);
			stmtTVC.setDouble(11, txtrate=="" || txtrate==null || txtrate.equalsIgnoreCase("")?0.0:Double.parseDouble(txtrate));
			stmtTVC.setDouble(12, nonvatamt=="" || nonvatamt==null || nonvatamt.equalsIgnoreCase("")?0.0:Double.parseDouble(nonvatamt));     
			stmtTVC.setDouble(13, taxamt=="" || taxamt==null || taxamt.equalsIgnoreCase("")?0.0:Double.parseDouble(taxamt));
			stmtTVC.setDouble(14, supptot=="" || supptot==null || supptot.equalsIgnoreCase("")?0.0:Double.parseDouble(supptot));
			stmtTVC.setDouble(15, servfee=="" || servfee==null || servfee.equalsIgnoreCase("")?0.0:Double.parseDouble(servfee));
			stmtTVC.setDouble(16, paybackamt=="" || paybackamt==null || paybackamt.equalsIgnoreCase("")?0.0:Double.parseDouble(paybackamt));
			stmtTVC.setInt(17, acc_docno=="" || acc_docno==null || acc_docno.equalsIgnoreCase("")?0:Integer.parseInt(acc_docno));
			stmtTVC.setDouble(18, sellingprice=="" || sellingprice==null || sellingprice.equalsIgnoreCase("")?0.0:Double.parseDouble(sellingprice));
			stmtTVC.setInt(19,rowno);  
			stmtTVC.setDouble(20, vatamt=="" || vatamt==null || vatamt.equalsIgnoreCase("")?0.0:Double.parseDouble(vatamt));    
			stmtTVC.setString(21,guest);
			stmtTVC.setString(22,vtype); 
			stmtTVC.setDouble(23, clvatamt=="" || clvatamt==null || clvatamt.equalsIgnoreCase("")?0.0:Double.parseDouble(clvatamt));
			stmtTVC.setInt(24, inclusiveval=="" || inclusiveval==null || inclusiveval.equalsIgnoreCase("")?0:Integer.parseInt(inclusiveval)); 
			stmtTVC.setString(25,mode); 
			datas=stmtTVC.executeUpdate();
			//System.out.println("in dao==="+datas);    
			if(datas<=0){  
				stmtTVC.close();
				conn.close();
				return false;
			}
			if (datas > 0) { 
				stmtTVC.close();  
				stmt.close();   
				conn.commit();
				conn.close();
				return true;
			}
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
		public JSONArray searchclient(HttpSession session) throws SQLException{
			JSONArray data=new JSONArray();                                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{ 
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();         
				String strsql="select refname,cldocno from my_acbook  where dtype='crm' and status<>7";  
				//System.out.println("strsql-------------->>>"+strsql);
				ResultSet rs=stmt.executeQuery(strsql);
				data=objcommon.convertToJSON(rs);  
			}   
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();  
			}
			return data;
		}   
		public JSONArray searchAccount() throws SQLException{
			JSONArray data=new JSONArray();                                      
			Connection conn=null; 
			try{ 
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement(); 
				String grpno="0";
				String strsql1="select acno from my_account where codeno='Payback Account'";         
				//System.out.println("strsql1-------------->>>"+strsql1);
				ResultSet rs1=stmt.executeQuery(strsql1);
				while(rs1.next()){
					grpno=rs1.getString("acno");  
				}
				String strsql="select  description account,account acno,doc_no from my_head where grpno='"+grpno+"'";     
				//System.out.println("strsql-------------->>>"+strsql);
				ResultSet rs=stmt.executeQuery(strsql);
				data=objcommon.convertToJSON(rs);    
			}   
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();  
			}
			return data;
		}  
		public JSONArray searchCountry() throws SQLException{   
			JSONArray data=new JSONArray();                                      
			Connection conn=null; 
			try{ 
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();           
				String strsql="select  country_name name,doc_no from my_acountry where status<>7";    
				//System.out.println("strsql-------------->>>"+strsql);
				ResultSet rs=stmt.executeQuery(strsql);
				data=objcommon.convertToJSON(rs);  
			}   
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();  
			}
			return data;
		}  
		public JSONArray searchCity(String docno) throws SQLException{         
			JSONArray data=new JSONArray();                                      
			Connection conn=null; 
			try{ 
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();           
				String strsql="select  city_name name,doc_no from my_acity where country_id='"+docno+"' and status<>7";    
				//System.out.println("strsql-------------->>>"+strsql);
				ResultSet rs=stmt.executeQuery(strsql);
				data=objcommon.convertToJSON(rs);  
			}   
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();  
			}
			return data;
		}  
		public JSONArray searchRoomtype(HttpSession session) throws SQLException{
			JSONArray data=new JSONArray();                                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();
				        
				String strsql="select distinct name roomtype from tr_roomtype where status=3"; 
				ResultSet rs=stmt.executeQuery(strsql);   
				data=objcommon.convertToJSON(rs);  
			}     
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();  
			}
			return data;
		}
		public JSONArray searchHotel() throws SQLException{ 
			JSONArray data=new JSONArray(); 
			
			Connection conn=null; 
			try{  
				conn=objconn.getMyConnection();   
				Statement stmt=conn.createStatement();
				String strsql="select name,doc_no from tr_hotel where status=3"; 
				//System.out.println("Hotel search--->>>"+strsql); 
				ResultSet rs=stmt.executeQuery(strsql);
				data=objcommon.convertToJSON(rs);   
			} 
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close(); 
			}
			 return data;  
			}
		public JSONArray searchsupplier(HttpSession session) throws SQLException{
			JSONArray data=new JSONArray();                                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{ 
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();         
				String strsql="select refname,cldocno from my_acbook  where dtype='vnd'  and status<>7";  
				//System.out.println("strsql-------------->>>"+strsql);
				ResultSet rs=stmt.executeQuery(strsql);
				data=objcommon.convertToJSON(rs);  
			}   
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();  
			}
			return data;
		}
		public JSONArray loadGrid(String docno,String brhid,HttpSession session) throws SQLException{              
			JSONArray data=new JSONArray();                                            
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{ 
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();
				String strsql="select d.cpudoc,d.invtrno,'Delete' deletes,d.sprice,d.cldocno,d.vnddocno,d.rowno,suppconfno,DATE_FORMAT(issuedate,'%d.%m.%Y') issuedate,u1.user_name isstaff,cn.country_name country,cy.city_name city,ht.name hotel,d.roomtype,"
						+ "ac.refname customer,acc.refname vendor from ti_hotelvoucherm m left join ti_hotelvoucherd d on d.rdocno=m.doc_no  left join my_acbook ac on (ac.cldocno=d.cldocno and ac.dtype='CRM')"
						+ " left join my_acbook acc on (acc.cldocno=d.vnddocno and acc.dtype='VND')  left join my_user u1 on u1.doc_no=d.isstaffid  left join my_acountry cn on cn.doc_no=d.countryid left join my_acity cy on cy.doc_no=d.cityid left join tr_hotel ht on ht.doc_no=d.hotelid  where m.status<>7 and m.doc_no='"+docno+"'";   
				System.out.println("strsql-------------->>>"+strsql);   
				ResultSet rs=stmt.executeQuery(strsql);  
				data=objcommon.convertToJSON(rs);  
			}   
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();  
			}
			return data;
		}    
		public JSONArray mainSearch(HttpSession session,String customer,String docNo,String date,String tno,String check,String brhid) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();      
	        if(!(check.equalsIgnoreCase("1"))){
	        	return RESULTDATA;
	        }
	        Connection conn = null;
	        java.sql.Date sqlIssueDate=null;
	           
	     try {
		       conn = objconn.getMyConnection();
		       Statement stmtBPV = conn.createStatement();
		       
		        date.trim();
		        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
		        {
		        	sqlIssueDate = objcommon.changeStringtoSqlDate(date);
		        }
		        
		        String sqltest="";
		        if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("0")){   
		        	sqltest=sqltest+" and m.brhid='"+brhid+"'";           
		        }
		        if(!(docNo.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and m.voc_no like '%"+docNo+"%'";    
		        }
		        if(!(customer.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and ac.refname like '%"+customer+"%'" ;
		        }
		        if(!(tno.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and d.suppconfno like '%"+tno+"%'";  
		        }
		        if(!(sqlIssueDate==null)){
			         sqltest=sqltest+" and d.issuingdate='"+sqlIssueDate+"'";          
			        } 
		        
		        String sqlsearch="select d.suppconfno, DATE_FORMAT(d.issuedate,'%d.%m.%Y') issuedate,ac.refname customer,m.voc_no,m.doc_no from ti_hotelvoucherm m left join ti_hotelvoucherd d on d.rdocno=m.doc_no  left join my_acbook ac on (ac.cldocno=d.cldocno and ac.dtype='CRM')  where m.status <> 7 "+sqltest+" order by m.doc_no,d.rdocno"; 
		       //System.out.println("sqlsearch===="+sqlsearch);               
		       ResultSet resultSet = stmtBPV.executeQuery(sqlsearch);  
		       RESULTDATA=objcommon.convertToJSON(resultSet);
		       
		       stmtBPV.close();
		       conn.close();
	     }
	     catch(Exception e){
	    	 	e.printStackTrace();
	    	 	conn.close();
	     }
           return RESULTDATA;
       }
	}          