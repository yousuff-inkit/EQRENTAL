package com.dashboard.travel.visapricemanagement;
    
	import com.common.ClsCommon;
import com.connection.ClsConnection;

	import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
	public class ClsVisaPriceManagementDAO {     

		ClsConnection objconn=new ClsConnection();     
		ClsCommon objcommon=new ClsCommon();
		Connection conn ;
		public int insert(int docno,String taxtype,ArrayList<String> visaarraydet,HttpSession session,HttpServletRequest request,String mode) throws SQLException {
				try{   
				int status=3,val2=0;  
				String dtype="";
				conn=objconn.getMyConnection();   
				conn.setAutoCommit(false); 
				Statement stmt = conn.createStatement ();  
				CallableStatement stmt2=null;
				CallableStatement stmt3=null; 
				 int i=0,j=0,val=0;   
				 System.out.println("in dao ===="+docno);
				 System.out.println("in dao ===="+visaarraydet);    
					for(i=0;i< visaarraydet.size();i++){     
						//System.out.println("in visa--->>>");
						String[] vgridarraydet=((String) visaarraydet.get(i)).split("::"); 
						int rid=(vgridarraydet[6].trim().equalsIgnoreCase("undefined") || vgridarraydet[6].trim().equalsIgnoreCase("NaN")|| vgridarraydet[6].trim().equalsIgnoreCase("")|| vgridarraydet[6].isEmpty()?0:Integer.parseInt(vgridarraydet[6].trim()));
						int rowdelete=(vgridarraydet[7].trim().equalsIgnoreCase("undefined") || vgridarraydet[7].trim().equalsIgnoreCase("NaN")|| vgridarraydet[7].trim().equalsIgnoreCase("")|| vgridarraydet[7].isEmpty()?0:Integer.parseInt(vgridarraydet[7].trim()));
						if(rowdelete==1){            
							status=7;   
						}else{
							status=3;
						}
						if(rid>0){
					        stmt3 = conn.prepareCall("update tr_prvisad set vendorid=?, visaid=?, value=?,maxdisval=?, marginper=?, marginval=?, sprice=?, status='"+status+"' where rowno="+rid+"");         
						 	    stmt3.setInt(1,docno);           
						   	    stmt3.setInt(2,(vgridarraydet[0].trim().equalsIgnoreCase("undefined") || vgridarraydet[0].trim().equalsIgnoreCase("NaN")|| vgridarraydet[0].trim().equalsIgnoreCase("")|| vgridarraydet[0].isEmpty()?0:Integer.parseInt(vgridarraydet[0].trim())));    
								stmt3.setDouble(3,(vgridarraydet[1].trim().equalsIgnoreCase("undefined") || vgridarraydet[1].trim().equalsIgnoreCase("NaN")|| vgridarraydet[1].trim().equalsIgnoreCase("")|| vgridarraydet[1].isEmpty()?0.0:Double.parseDouble(vgridarraydet[1].trim())));    
								stmt3.setDouble(4,(vgridarraydet[2].trim().equalsIgnoreCase("undefined") || vgridarraydet[2].trim().equalsIgnoreCase("NaN")|| vgridarraydet[2].trim().equalsIgnoreCase("")|| vgridarraydet[2].isEmpty()?0.0:Double.parseDouble(vgridarraydet[2].trim())));
								stmt3.setDouble(5,(vgridarraydet[3].trim().equalsIgnoreCase("undefined") || vgridarraydet[3].trim().equalsIgnoreCase("NaN")|| vgridarraydet[3].trim().equalsIgnoreCase("")|| vgridarraydet[3].isEmpty()?0.0:Double.parseDouble(vgridarraydet[3].trim())));
								stmt3.setDouble(6,(vgridarraydet[4].trim().equalsIgnoreCase("undefined") || vgridarraydet[4].trim().equalsIgnoreCase("NaN")|| vgridarraydet[4].trim().equalsIgnoreCase("")|| vgridarraydet[4].isEmpty()?0.0:Double.parseDouble(vgridarraydet[4].trim())));
								stmt3.setDouble(7,(vgridarraydet[5].trim().equalsIgnoreCase("undefined") || vgridarraydet[5].trim().equalsIgnoreCase("NaN")|| vgridarraydet[5].trim().equalsIgnoreCase("")|| vgridarraydet[5].isEmpty()?0.0:Double.parseDouble(vgridarraydet[5].trim())));
								//System.out.println("stmt3"+stmt3);   
							    val = stmt3.executeUpdate();  
						}else{
							stmt2 = conn.prepareCall("insert into tr_prvisad(vendorid, visaid, value, maxdisval, marginper, marginval, sprice,status) values(?, ?, ?, ?, ?, ?, ?, ?)");
						 	    stmt2.setInt(1,docno);         
						   	    stmt2.setInt(2,(vgridarraydet[0].trim().equalsIgnoreCase("undefined") || vgridarraydet[0].trim().equalsIgnoreCase("NaN")|| vgridarraydet[0].trim().equalsIgnoreCase("")|| vgridarraydet[0].isEmpty()?0:Integer.parseInt(vgridarraydet[0].trim())));    
						   	    stmt2.setDouble(3,(vgridarraydet[1].trim().equalsIgnoreCase("undefined") || vgridarraydet[1].trim().equalsIgnoreCase("NaN")|| vgridarraydet[1].trim().equalsIgnoreCase("")|| vgridarraydet[1].isEmpty()?0.0:Double.parseDouble(vgridarraydet[1].trim())));    
								stmt2.setDouble(4,(vgridarraydet[2].trim().equalsIgnoreCase("undefined") || vgridarraydet[2].trim().equalsIgnoreCase("NaN")|| vgridarraydet[2].trim().equalsIgnoreCase("")|| vgridarraydet[2].isEmpty()?0.0:Double.parseDouble(vgridarraydet[2].trim())));
								stmt2.setDouble(5,(vgridarraydet[3].trim().equalsIgnoreCase("undefined") || vgridarraydet[3].trim().equalsIgnoreCase("NaN")|| vgridarraydet[3].trim().equalsIgnoreCase("")|| vgridarraydet[3].isEmpty()?0.0:Double.parseDouble(vgridarraydet[3].trim())));
								stmt2.setDouble(6,(vgridarraydet[4].trim().equalsIgnoreCase("undefined") || vgridarraydet[4].trim().equalsIgnoreCase("NaN")|| vgridarraydet[4].trim().equalsIgnoreCase("")|| vgridarraydet[4].isEmpty()?0.0:Double.parseDouble(vgridarraydet[4].trim())));
								stmt2.setDouble(7,(vgridarraydet[5].trim().equalsIgnoreCase("undefined") || vgridarraydet[5].trim().equalsIgnoreCase("NaN")|| vgridarraydet[5].trim().equalsIgnoreCase("")|| vgridarraydet[5].isEmpty()?0.0:Double.parseDouble(vgridarraydet[5].trim())));
								stmt2.setInt(8,status);               
								//System.out.println("stmt2"+stmt2);   
								val = stmt2.executeUpdate();
						}
				}
			  	if(val<=0){          
			  		stmt2.close();
			        conn.close();
			      }   
				if(val>0){
					String strsql4="update my_acbook set visataxtype='"+taxtype+"' where cldocno='"+docno+"'"; 
					//System.out.println("strsql4--->>>"+strsql4); 
					int temp3=stmt.executeUpdate(strsql4);        
				}
				if (val > 0) {   
					conn.commit();        
					conn.close();
					return val;       
				}   
			}catch(Exception e){	
				e.printStackTrace();
				conn.close();	
			}
			return 0;
		}
		public JSONArray pricegriddata(String id) throws SQLException{ 
			JSONArray data=new JSONArray(); 
			if(!id.equalsIgnoreCase("1")){
				return data;  
			}
			Connection conn=null; 
			try{
			conn=objconn.getMyConnection(); 
			Statement stmt=conn.createStatement();
			String sqltest="";
			String strsql="select ac.refname,ac.cldocno,ac.per_mob mob,ac.mail1 email,ac.acno,ac.contactperson cperson,ac.trnnumber trnno,h.description acgrp,coalesce(ac.visataxtype,'') taxtype from my_acbook ac left join  my_head h on h.DOC_no=ac.acc_group and h.m_s='1' and h.den='255' and h.atype='AP' where ac.dtype='vnd' and h.doc_no='1638'"; 
			//System.out.println("price--->>>"+strsql); 
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

		public JSONArray visagriddata(String docno,String id) throws SQLException{ 
			JSONArray data=new JSONArray(); 
			if(!id.equalsIgnoreCase("1")){
				return data;  
			}
			Connection conn=null; 
			try{
			conn=objconn.getMyConnection(); 
			Statement stmt=conn.createStatement();
			String sqltest="";
			String strsql="select rowno,vendorid rdocno, visaid, value,  marginper, maxdisval,marginval, sprice,v.name vtype from tr_prvisad d left join tr_visatype v on v.doc_no=d.visaid where vendorid='"+docno+"' and d.status=3"; 
			//System.out.println("price--->>>"+strsql); 
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
		public JSONArray visagridExcel(String docno,String id) throws SQLException{ 
			JSONArray data=new JSONArray(); 
			if(!id.equalsIgnoreCase("1")){
				return data;  
			}
			Connection conn=null; 
			try{
			conn=objconn.getMyConnection(); 
			Statement stmt=conn.createStatement();  
			String strsql="select v.name 'Visa Type',d.value 'Value', d.marginper 'Margin %',d.marginval 'Margin Value', d.sprice 'Selling Price',d.maxdisval 'Max Discount Value' from tr_prvisad d left join tr_visatype v on v.doc_no=d.visaid where vendorid='"+docno+"' and d.status=3"; 
			//System.out.println("price--->>>"+strsql);   
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
		public JSONArray searchVisa() throws SQLException{ 
			JSONArray data=new JSONArray(); 
			/*if(!id.equalsIgnoreCase("1")){
				return data;  
			}*/
			Connection conn=null; 
			try{
			conn=objconn.getMyConnection();   
			Statement stmt=conn.createStatement();
			String strsql="select name,doc_no from tr_visatype where status=3"; 
			//System.out.println("visa search--->>>"+strsql); 
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
	}


