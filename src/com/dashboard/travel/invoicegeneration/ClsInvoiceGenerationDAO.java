package com.dashboard.travel.invoicegeneration;
    
	import com.common.ClsCommon;
import com.connection.ClsConnection;

	import java.sql.*;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
	public class ClsInvoiceGenerationDAO {  

		ClsConnection objconn=new ClsConnection();         
		ClsCommon objcommon=new ClsCommon();       
		
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
		public JSONArray loadHotelGrid(String brhid,String cldocno,String id,HttpSession session) throws SQLException{                 
			JSONArray data=new JSONArray();   
			if(!id.equalsIgnoreCase("1")){ 
				return data;
			}
			Connection conn=null; 
			java.sql.Date edates = null;     
			String sqltest="";
			try{ 
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();  
				if(!cldocno.equalsIgnoreCase("0") && !cldocno.equalsIgnoreCase("")){   
					sqltest=" and d.cldocno='"+cldocno+"'";       
				}
				if(!brhid.equalsIgnoreCase("0") && !brhid.equalsIgnoreCase("")){       
					sqltest=" and m.brhid='"+brhid+"'";       
				}
				String strsql="select  round(coalesce(d.taxamt,0),2) taxamt,round(coalesce(d.vatamt,0),2) vatamt, round(coalesce(d.nonvatamt,0),2) nonvatamt,coalesce(d.cpudoc,0) cpudoc,coalesce(d.invtrno,0) invtrno,d.cldocno,d.vnddocno,m.voc_no,round(coalesce(suptotal,0),2) suptotal, round(coalesce(servfee,0),2) servfee, round(coalesce(paybackamt,0),2) paybackamt, round(coalesce(sprice,0),2) sprice,d.rowno,suppconfno,DATE_FORMAT(issuedate,'%d.%m.%Y') issuedate,u1.user_name isstaff,cn.country_name country,cy.city_name city,ht.name hotel,d.roomtype,"
						+ "ac.refname customer,acc.refname vendor from ti_hotelvoucherm m left join ti_hotelvoucherd d on d.rdocno=m.doc_no  left join my_acbook ac on (ac.cldocno=d.cldocno and ac.dtype='CRM')"
						+ " left join my_acbook acc on (acc.cldocno=d.vnddocno and acc.dtype='VND')  left join my_user u1 on u1.doc_no=d.isstaffid  left join my_acountry cn on cn.doc_no=d.countryid"
						+ " left join my_acity cy on cy.doc_no=d.cityid left join tr_hotel ht on ht.doc_no=d.hotelid  where m.status<>7  and !(d.invtrno>0 and d.cpudoc>0)  "+sqltest+" order by m.doc_no,d.rowno";    
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
		public JSONArray loadTicketGrid(String brhid,String cldocno,String id,HttpSession session) throws SQLException{                        
			JSONArray data=new JSONArray(); 
			if(!id.equalsIgnoreCase("1")){
				return data;
			}
			Connection conn=null; 
			java.sql.Date edates = null;     
			String sqltest="";
			try{ 
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement(); 
				if(!cldocno.equalsIgnoreCase("0") && !cldocno.equalsIgnoreCase("")){   
					sqltest=" and d.cldocno='"+cldocno+"'";     
				}
				if(!brhid.equalsIgnoreCase("0") && !brhid.equalsIgnoreCase("")){   
					sqltest=" and m.brhid='"+brhid+"'";       
				}
				String strsql="select  coalesce(d.cpudoc,0) cpudoc,coalesce(d.invtrno,0) invtrno,d.cldocno,d.vnddocno,m.voc_no,coalesce(suptotal,0) suptotal, coalesce(servfee,0) servfee, coalesce(paybackamt,0) paybackamt, coalesce(sprice,0) sprice,d.prnno,d.rowno,ticketno, d.cldocno, vnddocno, bookdate, issuedate, guest, ar.name airline, airlineid, sector, d.class classes, gds, bstaffid, tstaffid,u1.user_name bstaff,u2.user_name tstaff, issuetype, d.type, tickettype,"
						+ "ac.refname customer,acc.refname vendor from ti_ticketvoucherm m left join ti_ticketvoucherd d on d.rdocno=m.doc_no  left join my_acbook ac on (ac.cldocno=d.cldocno and ac.dtype='CRM')"
						+ " left join my_acbook acc on (acc.cldocno=d.vnddocno and acc.dtype='VND') left join ti_airline ar on ar.doc_no=d.airlineid left join my_user u1 on u1.doc_no=d.bstaffid "
						+ " left join my_user u2 on u2.doc_no=d.tstaffid where m.status<>7  and !(d.invtrno>0)  "+sqltest+" order by m.doc_no,d.rowno";      
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
		
		public JSONArray loadHotelExcel(String brhid,String cldocno,String id,HttpSession session) throws SQLException{              
			JSONArray data=new JSONArray();   
			if(!id.equalsIgnoreCase("1")){ 
				return data;
			}
			Connection conn=null; 
			java.sql.Date edates = null;     
			String sqltest="";
			try{ 
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement();  
				if(!cldocno.equalsIgnoreCase("0") && !cldocno.equalsIgnoreCase("")){   
					sqltest=" and d.cldocno='"+cldocno+"'";       
				}
				if(!brhid.equalsIgnoreCase("0") && !brhid.equalsIgnoreCase("")){   
					sqltest=" and m.brhid='"+brhid+"'";       
				}
				String strsql="select m.voc_no 'Doc No',suppconfno 'Supplier Conformation No',ac.refname 'Customer',acc.refname 'Supplier',DATE_FORMAT(issuedate,'%d.%m.%Y') 'Issue Date',u1.user_name 'Issuing Staff',cn.country_name 'Country',cy.city_name 'City',ht.name 'Hotel',d.roomtype 'Room Type',"
						+ "coalesce(sprice,0) 'Selling Price' from ti_hotelvoucherm m left join ti_hotelvoucherd d on d.rdocno=m.doc_no  left join my_acbook ac on (ac.cldocno=d.cldocno and ac.dtype='CRM')"
						+ " left join my_acbook acc on (acc.cldocno=d.vnddocno and acc.dtype='VND')  left join my_user u1 on u1.doc_no=d.isstaffid  left join my_acountry cn on cn.doc_no=d.countryid"
						+ " left join my_acity cy on cy.doc_no=d.cityid left join tr_hotel ht on ht.doc_no=d.hotelid  where m.status<>7  and !(d.invtrno>0 and d.cpudoc>0) "+sqltest+"  order by m.doc_no,d.rowno";
				//System.out.println("strsql-------------->>>"+strsql);
				ResultSet rs=stmt.executeQuery(strsql);  
				data=objcommon.convertToEXCEL(rs);  
			}   
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();  
			}
			return data;
		}
		public JSONArray loadTicketExcel(String brhid,String cldocno,String id,HttpSession session) throws SQLException{                        
			JSONArray data=new JSONArray(); 
			if(!id.equalsIgnoreCase("1")){
				return data;
			}
			Connection conn=null; 
			java.sql.Date edates = null;     
			String sqltest="";
			try{ 
				conn=objconn.getMyConnection();  
				Statement stmt=conn.createStatement(); 
				if(!cldocno.equalsIgnoreCase("0") && !cldocno.equalsIgnoreCase("")){     
					sqltest=" and d.cldocno='"+cldocno+"'";     
				}
				if(!brhid.equalsIgnoreCase("0") && !brhid.equalsIgnoreCase("")){      
					sqltest=" and m.brhid='"+brhid+"'";       
				}
				String strsql="select  m.voc_no 'Doc No',ticketno 'Ticket No',ac.refname 'Customer',acc.refname 'Supplier',bookdate 'Booking Date', issuedate 'Issue Date', guest 'Guest', ar.name 'Airline', u1.user_name 'Booking Staff',u2.user_name 'Ticketing Staff',"
						+ " d.prnno 'PRN No',coalesce(sprice,0) 'Selling Price' from ti_ticketvoucherm m left join ti_ticketvoucherd d on d.rdocno=m.doc_no  left join my_acbook ac on (ac.cldocno=d.cldocno and ac.dtype='CRM')"
						+ " left join my_acbook acc on (acc.cldocno=d.vnddocno and acc.dtype='VND') left join ti_airline ar on ar.doc_no=d.airlineid left join my_user u1 on u1.doc_no=d.bstaffid "
						+ " left join my_user u2 on u2.doc_no=d.tstaffid where m.status<>7  and !(d.invtrno>0) "+sqltest+"  order by m.doc_no,d.rowno";      
				//System.out.println("strsql-------------->>>"+strsql);    
				ResultSet rs=stmt.executeQuery(strsql);
				data=objcommon.convertToEXCEL(rs);              
			}   
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();  
			}
			return data;
		}  
		
	}          