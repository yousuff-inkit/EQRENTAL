package com.dashboard.travel.hoteloffer;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsHotelOfferDAO {
	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray pricegriddata(String id,String hotelid) throws SQLException{        
		JSONArray data=new JSONArray(); 
		if(!id.equalsIgnoreCase("1")){
			return data;  
		}    
		Connection conn=null; 
		try{
		conn=objconn.getMyConnection(); 
		Statement stmt=conn.createStatement();           
		String sqltest="",strsql1="",strsql2=""; 
		ResultSet rs1=null,rs2=null;
		if(hotelid!=""){
			sqltest="left join tr_hotel ht on ht.doc_no=r.rdocno where ht.doc_no="+hotelid+" ";
		}
		strsql1="select roomid,h.doc_no docno,code,h.name,description desc1,DATE_FORMAT(fdate,'%d.%m.%Y')fdate,DATE_FORMAT(tdate,'%d.%m.%Y')tdate,appliedon type,per,amount,d.name room from tr_prhotelOFFER h left join tr_hoteld r on r.srno=h.roomid left join TR_ROOMTYPE d on d.doc_no=r.rtypeid "+sqltest+" ";
		//System.out.println("price--->>>"+strsql1);         
		rs1=stmt.executeQuery(strsql1);   
		//if(rs1.next()){
		data=objcommon.convertToJSON(rs1);           
		}
		catch(Exception e){
		e.printStackTrace();
		}
		finally{
		conn.close(); 
		}
		return data;
		}
	public JSONArray pricegridExceldata(String id,String hotelid) throws SQLException{        
		JSONArray data=new JSONArray(); 
		if(!id.equalsIgnoreCase("1")){
			return data;  
		}    
		Connection conn=null; 
		try{
		conn=objconn.getMyConnection(); 
		Statement stmt=conn.createStatement();           
		String sqltest="",strsql1="",strsql2=""; 
		ResultSet rs1=null,rs2=null;
		if(hotelid!=""){
			sqltest="left join tr_hotel ht on ht.doc_no=r.rdocno where ht.doc_no="+hotelid+" ";
		}
		strsql1="select code 'CODE',h.name 'NAME',description 'DESCRIPTION',DATE_FORMAT(fdate,'%d.%m.%Y') 'FROMDATE',DATE_FORMAT(tdate,'%d.%m.%Y')'TODATE',d.name 'ROOM',appliedon 'APPLIED ON',per 'PER',amount 'AMOUNT' from tr_prhotelOFFER h left join tr_hoteld r on r.srno=h.roomid left join TR_ROOMTYPE d on d.doc_no=r.rtypeid "+sqltest+" ";
		//System.out.println("price--->>>"+strsql1);         
		rs1=stmt.executeQuery(strsql1);   
		//if(rs1.next()){
		data=objcommon.convertToEXCEL(rs1);           
		}
		catch(Exception e){
		e.printStackTrace();
		}
		finally{
		conn.close(); 
		}
		return data;
		}
	public JSONArray roomdata(String id,String docno) throws SQLException{        
		JSONArray data=new JSONArray(); 
		if(!id.equalsIgnoreCase("1")){
			return data;  
		}    
		Connection conn=null; 
		try{
		conn=objconn.getMyConnection(); 
		Statement stmt=conn.createStatement();           
		String sqltest="",strsql1="",strsql2="";  
		ResultSet rs1=null,rs2=null;              
		strsql1="select d.name,d.rowno,d.roomid,r.name room,r.remarks cat,d.cpbasic cbasic,d.cpexbed cextra,d.child, d.hbadult, d.hbchild, d.fbadult, d.fbchild, d.inadult, d.inchild, d.marginper, d.maxdiscount, d.cost from tr_prhoteld d left join tr_hoteld hd on hd.srno=d.roomid left join TR_ROOMTYPE r on r.doc_no=hd.rtypeid where d.rdocno='"+docno+"'";
		//System.out.println("room--->>>"+strsql1);
		rs1=stmt.executeQuery(strsql1);  
		//if(rs1.next()){
		data=objcommon.convertToJSON(rs1);           
		}
		catch(Exception e){
		e.printStackTrace();
		}
		finally{
		conn.close(); 
		}
		return data;
		}
	public JSONArray countGridLoad(String id,String docno) throws SQLException{        
		JSONArray data=new JSONArray();     
		if(!id.equalsIgnoreCase("1")){
			return data;  
		}    
		Connection conn=null; 
		try{
		conn=objconn.getMyConnection(); 
		Statement stmt=conn.createStatement();           
		String sqltest="",strsql1="",strsql2="";  
		ResultSet rs1=null,rs2=null;                 
		strsql1="select d.rowno,d.rdocno,i.name,d.fdate, d.tdate,d.days,d.instruction doc_no from tr_prhoteldet d left join tr_prinstruction i on i.doc_no=d.instruction where d.rdocno='"+docno+"'";
		//System.out.println("ins--->>>"+strsql1);  
		rs1=stmt.executeQuery(strsql1);   
		//if(rs1.next()){
		data=objcommon.convertToJSON(rs1);           
		}
		catch(Exception e){
		e.printStackTrace();
		}
		finally{
		conn.close(); 
		}
		return data;
		}
	public JSONArray searchRoom(String docno) throws SQLException{   
		JSONArray data=new JSONArray(); 
		/*if(!id.equalsIgnoreCase("1")){
			return data;  
		}*/
		Connection conn=null; 
		try{
		conn=objconn.getMyConnection();   
		Statement stmt=conn.createStatement();
		String strsql="select r.name room,d.srno doc_no,r.remarks cat,d.name  from tr_hoteld d left join TR_ROOMTYPE r on r.doc_no=d.rtypeid where d.rdocno='"+docno+"'"; 
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
	public JSONArray searchInstruction() throws SQLException{   
		JSONArray data=new JSONArray(); 
		/*if(!id.equalsIgnoreCase("1")){
			return data;  
		}*/
		Connection conn=null; 
		try{
		conn=objconn.getMyConnection();   
		Statement stmt=conn.createStatement();  
		String strsql="select doc_no,name from tr_prinstruction where status=3"; 
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
public JSONArray searchHotel() throws SQLException{ 
	JSONArray data=new JSONArray(); 
	/*if(!id.equalsIgnoreCase("1")){
		return data;  
	}*/
	Connection conn=null; 
	try{
	conn=objconn.getMyConnection();   
	Statement stmt=conn.createStatement();
	String strsql="select h.name,h.doc_no,ac.refname,h.vendorid from tr_hotel h left join my_acbook ac on(ac.doc_no=h.vendorid and ac.dtype='vnd') where h.status=3"; 
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
public JSONArray searchNation() throws SQLException{ 
	JSONArray data=new JSONArray(); 
	/*if(!id.equalsIgnoreCase("1")){
		return data;  
	}*/
	Connection conn=null; 
	try{
	conn=objconn.getMyConnection();   
	Statement stmt=conn.createStatement();
	String strsql="select catid,nation name from my_natm where status=3;"; 
	//System.out.println("Nation search--->>>"+strsql); 
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
public JSONArray searchCategory() throws SQLException{            
	JSONArray data=new JSONArray(); 
	/*if(!id.equalsIgnoreCase("1")){
		return data;  
	}*/
	Connection conn=null;   
	try{
	conn=objconn.getMyConnection();   
	Statement stmt=conn.createStatement();         
	String strsql="select 0 doc_no,'All' name  union all  select doc_no,name from tr_pricecategory where status=3"; 
	//System.out.println("Category search--->>>"+strsql); 
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
