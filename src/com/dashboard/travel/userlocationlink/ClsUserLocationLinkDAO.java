package com.dashboard.travel.userlocationlink;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsUserLocationLinkDAO {

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	
	
	public JSONArray userdata(String id) throws SQLException{        
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
		strsql1="select u.DOC_NO docno,u.USER_ID userid, u.USER_NAME uname,  r.user_role urole, u.email from my_user u left join my_urole r on r.doc_no=u.role_id where u.status=3";
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
	
	public JSONArray locationdata(String id,String docno) throws SQLException{        
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
		
		
		strsql1="select convert(coalesce(a.rowno,0),char(50))rowno,a.val,a.docno,a.lname from(select uk.rowno,if(uk.rowno is null,0,1)val,doc_no docno,loc_name lname from my_locm ln left join tr_userloclink uk on ln.doc_no= uk.locid where uk.userid="+docno+" union all select 0 rowno,0  val,lt.doc_no docno,lt.loc_name lname from my_locm lt )a group by a.docno";
		//System.out.println("location--->>>"+strsql1);
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
}
