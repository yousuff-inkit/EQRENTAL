package com.dashboard.travel.ticketvouchercreate;
    
	import com.common.ClsCommon;
import com.connection.ClsConnection;

	import java.sql.*;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
	public class ClsTicketVoucherCreateDAO {  

		ClsConnection objconn=new ClsConnection();       
		ClsCommon objcommon=new ClsCommon();       
		
		public int insert(int rdocno,int rvocno,String ticketno,String clid,String vndid,Date bookingdate,Date issuedate,String guestname,String airlineid,String sector,String txtclass,String cmbgds,String bstaffid,String tstaffid,String cmbissuetype,String cmbtype,String cmbtickettype,String txtrate,String suppamt,String taxamt,String supptot,String servfee,String paybackamt,String acc_docno,String sellingprice,String farebasis,String cmbregioncode,String txtremarks,String bookingiatano,String ticketingiatano,String bookingofficeid,String ticketingofficeid,String firstofficeid,String currentofficeid,String prnno,String branch, HttpSession session,HttpServletRequest request,String mode) throws SQLException {
			  
			  	Connection conn = null;     
			try{   
				conn=objconn.getMyConnection();     
				conn.setAutoCommit(false);
				Statement stmt=conn.createStatement(); 
				String userid=session.getAttribute("USERID").toString().trim();    
				int vocno=0,docno=0,datas=0;
				if(rdocno==0){
					String sqlvoc="select coalesce((max(voc_no)+1),1) voc_no from ti_ticketvoucherm where brhid='"+branch+"'";    
					ResultSet rs7=stmt.executeQuery(sqlvoc);
					if(rs7.next()){
						vocno=rs7.getInt("voc_no");    
					}
					String strsql="insert into ti_ticketvoucherm(voc_no, userid, status, brhid) values('"+vocno+"',"+userid+",3,"+branch+")";              
					//System.out.println(strsql);  
					int insertval=stmt.executeUpdate(strsql);   
					if(insertval>0){ 
						String sql1="select max(doc_no) docno from ti_ticketvoucherm";
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
				CallableStatement stmtTVC = conn.prepareCall("{CALL ti_ticketvoucherDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");   
				
				stmtTVC.setString(1,ticketno);  
				stmtTVC.setInt(2, clid=="" || clid==null || clid.equalsIgnoreCase("")?0:Integer.parseInt(clid));
				stmtTVC.setInt(3, vndid=="" || vndid==null || vndid.equalsIgnoreCase("")?0:Integer.parseInt(vndid));
				stmtTVC.setDate(4,bookingdate);
				stmtTVC.setDate(5,issuedate);
				stmtTVC.setString(6,guestname);
				stmtTVC.setInt(7, airlineid=="" || airlineid==null || airlineid.equalsIgnoreCase("")?0:Integer.parseInt(airlineid));
				stmtTVC.setString(8,sector);
				stmtTVC.setString(9,txtclass);
				stmtTVC.setString(10,cmbgds);
				stmtTVC.setInt(11, bstaffid=="" || bstaffid==null || bstaffid.equalsIgnoreCase("")?0:Integer.parseInt(bstaffid));
				stmtTVC.setInt(12, tstaffid=="" || tstaffid==null || tstaffid.equalsIgnoreCase("")?0:Integer.parseInt(tstaffid));
				stmtTVC.setString(13,cmbissuetype);
				stmtTVC.setString(14,cmbtype);
				stmtTVC.setString(15,cmbtickettype);
				stmtTVC.setDouble(16, txtrate=="" || txtrate==null || txtrate.equalsIgnoreCase("")?0.0:Double.parseDouble(txtrate));
				stmtTVC.setDouble(17, suppamt=="" || suppamt==null || suppamt.equalsIgnoreCase("")?0.0:Double.parseDouble(suppamt));
				stmtTVC.setDouble(18, taxamt=="" || taxamt==null || taxamt.equalsIgnoreCase("")?0.0:Double.parseDouble(taxamt));
				stmtTVC.setDouble(19, supptot=="" || supptot==null || supptot.equalsIgnoreCase("")?0.0:Double.parseDouble(supptot));
				stmtTVC.setDouble(20, servfee=="" || servfee==null || servfee.equalsIgnoreCase("")?0.0:Double.parseDouble(servfee));
				stmtTVC.setDouble(21, paybackamt=="" || paybackamt==null || paybackamt.equalsIgnoreCase("")?0.0:Double.parseDouble(paybackamt));
				stmtTVC.setInt(22, acc_docno=="" || acc_docno==null || acc_docno.equalsIgnoreCase("")?0:Integer.parseInt(acc_docno));
				stmtTVC.setDouble(23, sellingprice=="" || sellingprice==null || sellingprice.equalsIgnoreCase("")?0.0:Double.parseDouble(sellingprice));
				stmtTVC.setString(24,farebasis);
				stmtTVC.setString(25,cmbregioncode);
				stmtTVC.setString(26,txtremarks);
				stmtTVC.setString(27,bookingiatano);
				stmtTVC.setString(28,ticketingiatano);
				stmtTVC.setString(29,bookingofficeid);
				stmtTVC.setString(30,ticketingofficeid);
				stmtTVC.setString(31,firstofficeid);
				stmtTVC.setString(32,currentofficeid);
				stmtTVC.setInt(33,docno);
				stmtTVC.setString(34,prnno);            
				stmtTVC.setString(35,mode);
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
		public boolean edit(int rowno,String ticketno,String clid,String vndid,Date bookingdate,Date issuedate,String guestname,String airlineid,String sector,String txtclass,String cmbgds,String bstaffid,String tstaffid,String cmbissuetype,String cmbtype,String cmbtickettype,String txtrate,String suppamt,String taxamt,String supptot,String servfee,String paybackamt,String acc_docno,String sellingprice,String farebasis,String cmbregioncode,String txtremarks,String bookingiatano,String ticketingiatano,String bookingofficeid,String ticketingofficeid,String firstofficeid,String currentofficeid,String prnno,String branch, HttpSession session,HttpServletRequest request,String mode) throws SQLException {
 		  	Connection conn = null;         
		try{   
			conn=objconn.getMyConnection();     
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement(); 
			int datas=0;
			
			if(rowno>0){
			CallableStatement stmtTVC = conn.prepareCall("{CALL ti_ticketvoucherDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");      
			
			stmtTVC.setString(1,ticketno);  
			stmtTVC.setInt(2, clid=="" || clid==null || clid.equalsIgnoreCase("")?0:Integer.parseInt(clid));
			stmtTVC.setInt(3, vndid=="" || vndid==null || vndid.equalsIgnoreCase("")?0:Integer.parseInt(vndid));
			stmtTVC.setDate(4,bookingdate);
			stmtTVC.setDate(5,issuedate);
			stmtTVC.setString(6,guestname);
			stmtTVC.setInt(7, airlineid=="" || airlineid==null || airlineid.equalsIgnoreCase("")?0:Integer.parseInt(airlineid));
			stmtTVC.setString(8,sector);
			stmtTVC.setString(9,txtclass);
			stmtTVC.setString(10,cmbgds);
			stmtTVC.setInt(11, bstaffid=="" || bstaffid==null || bstaffid.equalsIgnoreCase("")?0:Integer.parseInt(bstaffid));
			stmtTVC.setInt(12, tstaffid=="" || tstaffid==null || tstaffid.equalsIgnoreCase("")?0:Integer.parseInt(tstaffid));
			stmtTVC.setString(13,cmbissuetype);
			stmtTVC.setString(14,cmbtype);
			stmtTVC.setString(15,cmbtickettype);
			stmtTVC.setDouble(16, txtrate=="" || txtrate==null || txtrate.equalsIgnoreCase("")?0.0:Double.parseDouble(txtrate));
			stmtTVC.setDouble(17, suppamt=="" || suppamt==null || suppamt.equalsIgnoreCase("")?0.0:Double.parseDouble(suppamt));
			stmtTVC.setDouble(18, taxamt=="" || taxamt==null || taxamt.equalsIgnoreCase("")?0.0:Double.parseDouble(taxamt));
			stmtTVC.setDouble(19, supptot=="" || supptot==null || supptot.equalsIgnoreCase("")?0.0:Double.parseDouble(supptot));
			stmtTVC.setDouble(20, servfee=="" || servfee==null || servfee.equalsIgnoreCase("")?0.0:Double.parseDouble(servfee));
			stmtTVC.setDouble(21, paybackamt=="" || paybackamt==null || paybackamt.equalsIgnoreCase("")?0.0:Double.parseDouble(paybackamt));
			stmtTVC.setInt(22, acc_docno=="" || acc_docno==null || acc_docno.equalsIgnoreCase("")?0:Integer.parseInt(acc_docno));
			stmtTVC.setDouble(23, sellingprice=="" || sellingprice==null || sellingprice.equalsIgnoreCase("")?0.0:Double.parseDouble(sellingprice));
			stmtTVC.setString(24,farebasis);
			stmtTVC.setString(25,cmbregioncode);
			stmtTVC.setString(26,txtremarks);
			stmtTVC.setString(27,bookingiatano);
			stmtTVC.setString(28,ticketingiatano);
			stmtTVC.setString(29,bookingofficeid);
			stmtTVC.setString(30,ticketingofficeid);
			stmtTVC.setString(31,firstofficeid);
			stmtTVC.setString(32,currentofficeid);         
			stmtTVC.setInt(33,rowno);
			stmtTVC.setString(34,prnno); 
			stmtTVC.setString(35,mode);
			datas=stmtTVC.executeUpdate();
			//System.out.println("in dao==="+datas);
			if(datas<=0){  
				stmtTVC.close();
				conn.close();
				return false;
			}
			if(datas>0){         
				stmtTVC.close();
				stmt.close();   
			}
			}
			if (datas > 0) {           
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
		public boolean delete(int rdocno,int rvocno,String ticketno,String clid,String vndid,Date bookingdate,Date issuedate,String guestname,String airlineid,String sector,String txtclass,String cmbgds,String bstaffid,String tstaffid,String cmbissuetype,String cmbtype,String cmbtickettype,String txtrate,String suppamt,String taxamt,String supptot,String servfee,String paybackamt,String acc_docno,String sellingprice,String farebasis,String cmbregioncode,String txtremarks,String bookingiatano,String ticketingiatano,String bookingofficeid,String ticketingofficeid,String firstofficeid,String currentofficeid,String prnno,String branch, HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		  	Connection conn = null;     
		try{   
			conn=objconn.getMyConnection();     
			Statement stmt=conn.createStatement(); 
			String strsql="delete from ti_ticketvoucherm where doc_no='"+rdocno+"' and brhid='"+branch+"'";              
			//System.out.println(strsql);  
			int insertval=stmt.executeUpdate(strsql);        
			if (insertval > 0) {
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
		public boolean griddelete(int rowno,String ticketno,String clid,String vndid,Date bookingdate,Date issuedate,String guestname,String airlineid,String sector,String txtclass,String cmbgds,String bstaffid,String tstaffid,String cmbissuetype,String cmbtype,String cmbtickettype,String txtrate,String suppamt,String taxamt,String supptot,String servfee,String paybackamt,String acc_docno,String sellingprice,String farebasis,String cmbregioncode,String txtremarks,String bookingiatano,String ticketingiatano,String bookingofficeid,String ticketingofficeid,String firstofficeid,String currentofficeid,String prnno,String branch, HttpSession session,HttpServletRequest request,String mode) throws SQLException {
 		  	Connection conn = null;           
		try{   
			conn=objconn.getMyConnection();     
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement(); 
			int datas=0;
			
			CallableStatement stmtTVC = conn.prepareCall("{CALL ti_ticketvoucherDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");      
			
			stmtTVC.setString(1,ticketno);  
			stmtTVC.setInt(2, clid=="" || clid==null || clid.equalsIgnoreCase("")?0:Integer.parseInt(clid));   
			stmtTVC.setInt(3, vndid=="" || vndid==null || vndid.equalsIgnoreCase("")?0:Integer.parseInt(vndid));
			stmtTVC.setDate(4,bookingdate);
			stmtTVC.setDate(5,issuedate);
			stmtTVC.setString(6,guestname);
			stmtTVC.setInt(7, airlineid=="" || airlineid==null || airlineid.equalsIgnoreCase("")?0:Integer.parseInt(airlineid));
			stmtTVC.setString(8,sector);
			stmtTVC.setString(9,txtclass);
			stmtTVC.setString(10,cmbgds);
			stmtTVC.setInt(11, bstaffid=="" || bstaffid==null || bstaffid.equalsIgnoreCase("")?0:Integer.parseInt(bstaffid));
			stmtTVC.setInt(12, tstaffid=="" || tstaffid==null || tstaffid.equalsIgnoreCase("")?0:Integer.parseInt(tstaffid));
			stmtTVC.setString(13,cmbissuetype);
			stmtTVC.setString(14,cmbtype);
			stmtTVC.setString(15,cmbtickettype);
			stmtTVC.setDouble(16, txtrate=="" || txtrate==null || txtrate.equalsIgnoreCase("")?0.0:Double.parseDouble(txtrate));
			stmtTVC.setDouble(17, suppamt=="" || suppamt==null || suppamt.equalsIgnoreCase("")?0.0:Double.parseDouble(suppamt));
			stmtTVC.setDouble(18, taxamt=="" || taxamt==null || taxamt.equalsIgnoreCase("")?0.0:Double.parseDouble(taxamt));
			stmtTVC.setDouble(19, supptot=="" || supptot==null || supptot.equalsIgnoreCase("")?0.0:Double.parseDouble(supptot));
			stmtTVC.setDouble(20, servfee=="" || servfee==null || servfee.equalsIgnoreCase("")?0.0:Double.parseDouble(servfee));
			stmtTVC.setDouble(21, paybackamt=="" || paybackamt==null || paybackamt.equalsIgnoreCase("")?0.0:Double.parseDouble(paybackamt));
			stmtTVC.setInt(22, acc_docno=="" || acc_docno==null || acc_docno.equalsIgnoreCase("")?0:Integer.parseInt(acc_docno));
			stmtTVC.setDouble(23, sellingprice=="" || sellingprice==null || sellingprice.equalsIgnoreCase("")?0.0:Double.parseDouble(sellingprice));
			stmtTVC.setString(24,farebasis);
			stmtTVC.setString(25,cmbregioncode);
			stmtTVC.setString(26,txtremarks);
			stmtTVC.setString(27,bookingiatano);
			stmtTVC.setString(28,ticketingiatano);
			stmtTVC.setString(29,bookingofficeid);
			stmtTVC.setString(30,ticketingofficeid);
			stmtTVC.setString(31,firstofficeid);
			stmtTVC.setString(32,currentofficeid);         
			stmtTVC.setInt(33,rowno);
			stmtTVC.setString(34,prnno); 
			stmtTVC.setString(35,mode);
			datas=stmtTVC.executeUpdate();
			System.out.println("in dao==="+datas);  
			if(datas<=0){  
				stmtTVC.close();
				conn.close();
				return false;
			}
			if(datas>0){         
				stmtTVC.close();
				stmt.close();   
			}
			if (datas > 0) {             
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
		public JSONArray searchAirline() throws SQLException{
			JSONArray data=new JSONArray();                                      
			Connection conn=null; 
			try{ 
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();           
				String strsql="select  name,doc_no from ti_airline where status<>7";    
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
				String strsql="select 'Delete' deletes,d.sprice,d.cpudoc,d.invtrno,d.prnno,d.rowno,ticketno, d.cldocno, vnddocno, bookdate, issuedate, guest, ar.name airline, airlineid, sector, d.class classes, gds, bstaffid, tstaffid,u1.user_name bstaff,u2.user_name tstaff, issuetype, d.type, tickettype,"
						+ "ac.refname customer,acc.refname vendor from ti_ticketvoucherm m left join ti_ticketvoucherd d on d.rdocno=m.doc_no  left join my_acbook ac on (ac.cldocno=d.cldocno and ac.dtype='CRM')"
						+ " left join my_acbook acc on (acc.cldocno=d.vnddocno and acc.dtype='VND') left join ti_airline ar on ar.doc_no=d.airlineid left join my_user u1 on u1.doc_no=d.bstaffid  left join my_user u2 on u2.doc_no=d.tstaffid where m.status<>7 and m.doc_no='"+docno+"'";    
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
	        java.sql.Date sqlBookDate=null;
	           
	     try {
		       conn = objconn.getMyConnection();
		       Statement stmtBPV = conn.createStatement();
		       
		        date.trim();
		        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
		        {
		        sqlBookDate = objcommon.changeStringtoSqlDate(date);
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
		         sqltest=sqltest+" and d.ticketno like '%"+tno+"%'";  
		        }
		        if(!(sqlBookDate==null)){
			         sqltest=sqltest+" and d.bookdate='"+sqlBookDate+"'";
			        } 
		        
		       String sqlsearch="select d.ticketno, DATE_FORMAT(d.bookdate,'%d.%m.%Y') bookdate,ac.refname customer,m.voc_no,m.doc_no from ti_ticketvoucherm m left join ti_ticketvoucherd d on d.rdocno=m.doc_no  left join my_acbook ac on (ac.cldocno=d.cldocno and ac.dtype='CRM')  where m.status <> 7 "+sqltest+" order by m.doc_no,d.rdocno";        
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