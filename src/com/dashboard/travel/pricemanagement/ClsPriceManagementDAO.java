package com.dashboard.travel.pricemanagement;
    
	import com.common.ClsCommon;
import com.connection.ClsConnection;

	import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
	public class ClsPriceManagementDAO {     

		ClsConnection objconn=new ClsConnection();     
		ClsCommon objcommon=new ClsCommon();
		Connection conn ;
		public int insert(int docno,String taxtype,ArrayList<String> termarray,HttpSession session,HttpServletRequest request,String mode) throws SQLException {
				try{   
				int status=3,val2=0;  
				String dtype="";
				conn=objconn.getMyConnection();   
				conn.setAutoCommit(false); 
				Statement stmt = conn.createStatement ();  
				CallableStatement stmt2=null;
				CallableStatement stmt3=null; 
				 int i=0,j=0;   
				 System.out.println("in dao ===="+docno);
				 System.out.println("in dao ===="+termarray);
				 for(j=0;j< termarray.size();j++){                
					String[] tgridarraydet=((String) termarray.get(j)).split("::");      
					int rowid=(tgridarraydet[9].trim().equalsIgnoreCase("undefined") || tgridarraydet[9].trim().equalsIgnoreCase("NaN")|| tgridarraydet[9].trim().equalsIgnoreCase("")|| tgridarraydet[9].isEmpty()?0:Integer.parseInt(tgridarraydet[9].trim()));
					int rowdelete=(tgridarraydet[11].trim().equalsIgnoreCase("undefined") || tgridarraydet[11].trim().equalsIgnoreCase("NaN")|| tgridarraydet[11].trim().equalsIgnoreCase("")|| tgridarraydet[11].isEmpty()?0:Integer.parseInt(tgridarraydet[11].trim()));
					if(rowdelete==1){        
						status=7;   
					}else{
						status=3;
					}
					if(rowid>0){
						stmt2 = conn.prepareCall("update tr_prtourd set vendorid=?, tourid=? ,fdate=?, tdate=?, days=?, offer=?, adult=?, child=?, spadult=?, spchild=?, terms=?, status=?,admarginper=?, chmarginper=?, admarginval=?, chmarginval=?, adultdismax=?, childdismax=?, copadultdismax=?, copchilddismax=? where rowno='"+rowid+"'");  
						java.sql.Date stdt=(tgridarraydet[1].trim().equalsIgnoreCase("undefined") || tgridarraydet[1].trim().equalsIgnoreCase("NaN")|| tgridarraydet[1].trim().equalsIgnoreCase("")|| tgridarraydet[1].isEmpty()?null:objcommon.changetstmptoSqlDate(tgridarraydet[1].trim()));
						java.sql.Date exdt=(tgridarraydet[2].trim().equalsIgnoreCase("undefined") || tgridarraydet[2].trim().equalsIgnoreCase("NaN")|| tgridarraydet[2].trim().equalsIgnoreCase("")|| tgridarraydet[2].isEmpty()?null:objcommon.changetstmptoSqlDate(tgridarraydet[2].trim())); 
						int offer = 0;        
							//System.out.println(stdt+"--->>>"+exdt);      
							if(tgridarraydet[4].trim().equalsIgnoreCase("true")){          
								offer=1;
							}
							else if(tgridarraydet[4].trim().equalsIgnoreCase("false")){  
								offer=0;
							}
						    stmt2.setInt(1,docno);                
					 	    stmt2.setInt(2,(tgridarraydet[0].trim().equalsIgnoreCase("undefined") || tgridarraydet[0].trim().equalsIgnoreCase("NaN")|| tgridarraydet[0].trim().equalsIgnoreCase("")|| tgridarraydet[0].isEmpty()?0:Integer.parseInt(tgridarraydet[0].trim())));    
							stmt2.setDate(3,stdt);
							stmt2.setDate(4,exdt);   
							stmt2.setString(5,(tgridarraydet[3].trim().equalsIgnoreCase("undefined") || tgridarraydet[3].trim().equalsIgnoreCase("NaN")|| tgridarraydet[3].trim().equalsIgnoreCase("")|| tgridarraydet[3].isEmpty()?"":tgridarraydet[3].trim()));
							stmt2.setInt(6,offer);    
							stmt2.setDouble(7,(tgridarraydet[5].trim().equalsIgnoreCase("undefined") || tgridarraydet[5].trim().equalsIgnoreCase("NaN")|| tgridarraydet[5].trim().equalsIgnoreCase("")|| tgridarraydet[5].isEmpty()?0.0:Double.parseDouble(tgridarraydet[5].trim())));        
							stmt2.setDouble(8,(tgridarraydet[6].trim().equalsIgnoreCase("undefined") || tgridarraydet[6].trim().equalsIgnoreCase("NaN")|| tgridarraydet[6].trim().equalsIgnoreCase("")|| tgridarraydet[6].isEmpty()?0.0:Double.parseDouble(tgridarraydet[6].trim())));
							stmt2.setDouble(9,(tgridarraydet[7].trim().equalsIgnoreCase("undefined") || tgridarraydet[7].trim().equalsIgnoreCase("NaN")|| tgridarraydet[7].trim().equalsIgnoreCase("")|| tgridarraydet[7].isEmpty()?0.0:Double.parseDouble(tgridarraydet[7].trim())));
							stmt2.setDouble(10,(tgridarraydet[8].trim().equalsIgnoreCase("undefined") || tgridarraydet[8].trim().equalsIgnoreCase("NaN")|| tgridarraydet[8].trim().equalsIgnoreCase("")|| tgridarraydet[8].isEmpty()?0.0:Double.parseDouble(tgridarraydet[8].trim()))); 
							stmt2.setString(11,(tgridarraydet[10].trim().equalsIgnoreCase("undefined") || tgridarraydet[10].trim().equalsIgnoreCase("NaN")|| tgridarraydet[10].trim().equalsIgnoreCase("")|| tgridarraydet[10].isEmpty()?"":tgridarraydet[10].trim()));      
							stmt2.setInt(12,status);         
							stmt2.setDouble(13,(tgridarraydet[12].trim().equalsIgnoreCase("undefined") || tgridarraydet[12].trim().equalsIgnoreCase("NaN")|| tgridarraydet[12].trim().equalsIgnoreCase("")|| tgridarraydet[12].isEmpty()?0.0:Double.parseDouble(tgridarraydet[12].trim())));
							stmt2.setDouble(14,(tgridarraydet[13].trim().equalsIgnoreCase("undefined") || tgridarraydet[13].trim().equalsIgnoreCase("NaN")|| tgridarraydet[13].trim().equalsIgnoreCase("")|| tgridarraydet[13].isEmpty()?0.0:Double.parseDouble(tgridarraydet[13].trim())));
							stmt2.setDouble(15,(tgridarraydet[14].trim().equalsIgnoreCase("undefined") || tgridarraydet[14].trim().equalsIgnoreCase("NaN")|| tgridarraydet[14].trim().equalsIgnoreCase("")|| tgridarraydet[14].isEmpty()?0.0:Double.parseDouble(tgridarraydet[14].trim())));
							stmt2.setDouble(16,(tgridarraydet[15].trim().equalsIgnoreCase("undefined") || tgridarraydet[15].trim().equalsIgnoreCase("NaN")|| tgridarraydet[15].trim().equalsIgnoreCase("")|| tgridarraydet[15].isEmpty()?0.0:Double.parseDouble(tgridarraydet[15].trim())));
							stmt2.setDouble(17,(tgridarraydet[16].trim().equalsIgnoreCase("undefined") || tgridarraydet[16].trim().equalsIgnoreCase("NaN")|| tgridarraydet[16].trim().equalsIgnoreCase("")|| tgridarraydet[16].isEmpty()?0.0:Double.parseDouble(tgridarraydet[16].trim())));
							stmt2.setDouble(18,(tgridarraydet[17].trim().equalsIgnoreCase("undefined") || tgridarraydet[17].trim().equalsIgnoreCase("NaN")|| tgridarraydet[17].trim().equalsIgnoreCase("")|| tgridarraydet[17].isEmpty()?0.0:Double.parseDouble(tgridarraydet[17].trim())));
							stmt2.setDouble(19,(tgridarraydet[18].trim().equalsIgnoreCase("undefined") || tgridarraydet[18].trim().equalsIgnoreCase("NaN")|| tgridarraydet[18].trim().equalsIgnoreCase("")|| tgridarraydet[18].isEmpty()?0.0:Double.parseDouble(tgridarraydet[18].trim())));
							stmt2.setDouble(20,(tgridarraydet[19].trim().equalsIgnoreCase("undefined") || tgridarraydet[19].trim().equalsIgnoreCase("NaN")|| tgridarraydet[19].trim().equalsIgnoreCase("")|| tgridarraydet[19].isEmpty()?0.0:Double.parseDouble(tgridarraydet[19].trim())));
							//System.out.println("stmt2"+stmt2);            
					    val2 = stmt2.executeUpdate();  
					}else{
					stmt3 = conn.prepareCall("insert into tr_prtourd(vendorid, tourid, fdate, tdate, days, offer, adult, child, spadult, spchild, terms, status, admarginper, chmarginper, admarginval, chmarginval, adultdismax, childdismax, copadultdismax, copchilddismax) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
					java.sql.Date stdt=(tgridarraydet[1].trim().equalsIgnoreCase("undefined") || tgridarraydet[1].trim().equalsIgnoreCase("NaN")|| tgridarraydet[1].trim().equalsIgnoreCase("")|| tgridarraydet[1].isEmpty()?null:objcommon.changetstmptoSqlDate(tgridarraydet[1].trim()));
					java.sql.Date exdt=(tgridarraydet[2].trim().equalsIgnoreCase("undefined") || tgridarraydet[2].trim().equalsIgnoreCase("NaN")|| tgridarraydet[2].trim().equalsIgnoreCase("")|| tgridarraydet[2].isEmpty()?null:objcommon.changetstmptoSqlDate(tgridarraydet[2].trim())); 
					int offer = 0;        
						//System.out.println(stdt+"--->>>"+exdt);      
						if(tgridarraydet[4].trim().equalsIgnoreCase("true")){          
							offer=1;
						}
						else if(tgridarraydet[4].trim().equalsIgnoreCase("false")){  
							offer=0;
						}
					    stmt3.setInt(1,docno);            
				 	    stmt3.setInt(2,(tgridarraydet[0].trim().equalsIgnoreCase("undefined") || tgridarraydet[0].trim().equalsIgnoreCase("NaN")|| tgridarraydet[0].trim().equalsIgnoreCase("")|| tgridarraydet[0].isEmpty()?0:Integer.parseInt(tgridarraydet[0].trim())));    
						stmt3.setDate(3,stdt);
						stmt3.setDate(4,exdt);   
						stmt3.setString(5,(tgridarraydet[3].trim().equalsIgnoreCase("undefined") || tgridarraydet[3].trim().equalsIgnoreCase("NaN")|| tgridarraydet[3].trim().equalsIgnoreCase("")|| tgridarraydet[3].isEmpty()?"":tgridarraydet[3].trim()));
						stmt3.setInt(6,offer);    
						stmt3.setDouble(7,(tgridarraydet[5].trim().equalsIgnoreCase("undefined") || tgridarraydet[5].trim().equalsIgnoreCase("NaN")|| tgridarraydet[5].trim().equalsIgnoreCase("")|| tgridarraydet[5].isEmpty()?0.0:Double.parseDouble(tgridarraydet[5].trim())));        
						stmt3.setDouble(8,(tgridarraydet[6].trim().equalsIgnoreCase("undefined") || tgridarraydet[6].trim().equalsIgnoreCase("NaN")|| tgridarraydet[6].trim().equalsIgnoreCase("")|| tgridarraydet[6].isEmpty()?0.0:Double.parseDouble(tgridarraydet[6].trim())));
						stmt3.setDouble(9,(tgridarraydet[7].trim().equalsIgnoreCase("undefined") || tgridarraydet[7].trim().equalsIgnoreCase("NaN")|| tgridarraydet[7].trim().equalsIgnoreCase("")|| tgridarraydet[7].isEmpty()?0.0:Double.parseDouble(tgridarraydet[7].trim())));
						stmt3.setDouble(10,(tgridarraydet[8].trim().equalsIgnoreCase("undefined") || tgridarraydet[8].trim().equalsIgnoreCase("NaN")|| tgridarraydet[8].trim().equalsIgnoreCase("")|| tgridarraydet[8].isEmpty()?0.0:Double.parseDouble(tgridarraydet[8].trim()))); 
						stmt3.setString(11,(tgridarraydet[10].trim().equalsIgnoreCase("undefined") || tgridarraydet[10].trim().equalsIgnoreCase("NaN")|| tgridarraydet[10].trim().equalsIgnoreCase("")|| tgridarraydet[10].isEmpty()?"":tgridarraydet[10].trim())); 
						stmt3.setInt(12,status); 
						stmt3.setDouble(13,(tgridarraydet[12].trim().equalsIgnoreCase("undefined") || tgridarraydet[12].trim().equalsIgnoreCase("NaN")|| tgridarraydet[12].trim().equalsIgnoreCase("")|| tgridarraydet[12].isEmpty()?0.0:Double.parseDouble(tgridarraydet[12].trim())));
						stmt3.setDouble(14,(tgridarraydet[13].trim().equalsIgnoreCase("undefined") || tgridarraydet[13].trim().equalsIgnoreCase("NaN")|| tgridarraydet[13].trim().equalsIgnoreCase("")|| tgridarraydet[13].isEmpty()?0.0:Double.parseDouble(tgridarraydet[13].trim())));
						stmt3.setDouble(15,(tgridarraydet[14].trim().equalsIgnoreCase("undefined") || tgridarraydet[14].trim().equalsIgnoreCase("NaN")|| tgridarraydet[14].trim().equalsIgnoreCase("")|| tgridarraydet[14].isEmpty()?0.0:Double.parseDouble(tgridarraydet[14].trim())));
						stmt3.setDouble(16,(tgridarraydet[15].trim().equalsIgnoreCase("undefined") || tgridarraydet[15].trim().equalsIgnoreCase("NaN")|| tgridarraydet[15].trim().equalsIgnoreCase("")|| tgridarraydet[15].isEmpty()?0.0:Double.parseDouble(tgridarraydet[15].trim())));
						stmt3.setDouble(17,(tgridarraydet[16].trim().equalsIgnoreCase("undefined") || tgridarraydet[16].trim().equalsIgnoreCase("NaN")|| tgridarraydet[16].trim().equalsIgnoreCase("")|| tgridarraydet[16].isEmpty()?0.0:Double.parseDouble(tgridarraydet[16].trim())));
						stmt3.setDouble(18,(tgridarraydet[17].trim().equalsIgnoreCase("undefined") || tgridarraydet[17].trim().equalsIgnoreCase("NaN")|| tgridarraydet[17].trim().equalsIgnoreCase("")|| tgridarraydet[17].isEmpty()?0.0:Double.parseDouble(tgridarraydet[17].trim())));
						stmt3.setDouble(19,(tgridarraydet[18].trim().equalsIgnoreCase("undefined") || tgridarraydet[18].trim().equalsIgnoreCase("NaN")|| tgridarraydet[18].trim().equalsIgnoreCase("")|| tgridarraydet[18].isEmpty()?0.0:Double.parseDouble(tgridarraydet[18].trim())));
						stmt3.setDouble(20,(tgridarraydet[19].trim().equalsIgnoreCase("undefined") || tgridarraydet[19].trim().equalsIgnoreCase("NaN")|| tgridarraydet[19].trim().equalsIgnoreCase("")|| tgridarraydet[19].isEmpty()?0.0:Double.parseDouble(tgridarraydet[19].trim())));
						//System.out.println("stmt2"+stmt2);               
					    val2 = stmt3.executeUpdate();  
					}
			    }   
			  	if(val2<=0){          
			        conn.close();
			        return 0;
			      } 
				if(val2>0){            
					String strsql4="update my_acbook set tourtaxtype='"+taxtype+"' where cldocno='"+docno+"'"; 
					System.out.println("strsql4--->>>"+strsql4); 
					int temp3=stmt.executeUpdate(strsql4);        
				}
				if (val2 > 0) {   
					conn.commit();
					conn.close();
					return val2;       
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
			String strsql="select ac.refname,ac.cldocno,ac.per_mob mob,ac.mail1 email,ac.acno,ac.contactperson cperson,ac.trnnumber trnno,h.description acgrp,coalesce(ac.tourtaxtype,'') taxtype from my_acbook ac left join  my_head h on h.DOC_no=ac.acc_group and h.m_s='1' and h.den='255' and h.atype='AP' where ac.dtype='vnd' and h.doc_no='1638'"; 
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

			public JSONArray tourgriddata(String docno,String id) throws SQLException{ 
			JSONArray data=new JSONArray(); 
			if(!id.equalsIgnoreCase("1")){
				return data;     
			}
			Connection conn=null; 
			try{
			conn=objconn.getMyConnection(); 
			Statement stmt=conn.createStatement();          
			String sqltest="";
			String strsql="select coalesce(d.terms,'') terms,d.rowno,vendorid rdocno, tourid, d.adult, d.child, d.spadult, d.spchild,v.name tour,if(d.offer=1,true,false) offer,d.days,fdate,tdate, admarginper, chmarginper, admarginval, chmarginval, adultdismax, childdismax,copadultdismax,copchilddismax from tr_prtourd d left join TR_TOURS v on v.doc_no=d.tourid where vendorid='"+docno+"' and d.status=3";    
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
			public JSONArray searchTour() throws SQLException{   
			JSONArray data=new JSONArray(); 
			/*if(!id.equalsIgnoreCase("1")){
				return data;  
			}*/
			Connection conn=null; 
			try{
			conn=objconn.getMyConnection();   
			Statement stmt=conn.createStatement();
			String sqltest="";
			String strsql="select name,doc_no from TR_TOURS where status=3"; 
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


