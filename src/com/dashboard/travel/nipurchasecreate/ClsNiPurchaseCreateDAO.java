package com.dashboard.travel.nipurchasecreate;   
    
	import com.common.ClsCommon;
import com.connection.ClsConnection;

	import java.sql.*;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
	public class ClsNiPurchaseCreateDAO {        

		ClsConnection objconn=new ClsConnection();     
		ClsCommon objcommon=new ClsCommon();
		Connection conn ;
		
		public JSONArray nipurchasedata(String id) throws SQLException{ 
			JSONArray data=new JSONArray(); 
			if(!id.equalsIgnoreCase("1")){
				return data;  
			}
			Connection conn=null; 
			try{
			conn=objconn.getMyConnection(); 
			Statement stmt=conn.createStatement();               
			String sqltest="";
			String strsql="select o.brhid,o.doc_no, o.voc_no, o.date, o.type, o.acno, o.delterm, o.payterm, o.deldate, o.desc1, o.netamount netamt,h.description accname from my_srvlpom o  inner join my_srvlpod d on d.rdocno=o.doc_no left join my_head h on h.doc_no=o.acno where o.status=3 and d.qty-out_qty>0 group by  o.doc_no";      
			//System.out.println("strsql--->>>"+strsql);       
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
		
		public   JSONArray reloadnioreder(HttpSession session,String nidoc,String id) throws SQLException {
  
			JSONArray RESULTDATA=new JSONArray();
			if(!id.equalsIgnoreCase("1")){
				return RESULTDATA;    
			}
		    String brcid=session.getAttribute("BRANCHID").toString();
		    Connection conn = null;
			try {
					 conn = objconn.getMyConnection();  
					Statement stmtVeh1 = conn.createStatement ();
		        	String pySql=(" select rowno,srno,desc1 description,coalesce(unitprice,0) unitprice,coalesce(qty,0) qty,coalesce(total,0) total,coalesce(discount,0) discount,coalesce(nettotal,0) nettotal,coalesce(nuprice,0) nuprice "  
		        			+ ",coalesce(taxper,0) taxper,coalesce(taxamount,0) taxperamt,coalesce(nettaxamount,0) taxamount,(select coalesce(acno,0) acno from my_account where codeno='VENDOR ACCOUNT') account,(select h.description from my_account ac left join my_head h on h.account=ac.acno where codeno='VENDOR ACCOUNT') accname,'GL' type,(select coalesce(h.doc_no,0) acno from my_account ac left join my_head h on h.account=ac.acno where codeno='VENDOR ACCOUNT') headdoc from my_srvlpod  where rdocno='"+nidoc+"' ");
		         	System.out.println("========"+pySql);  
					ResultSet resultSet = stmtVeh1.executeQuery(pySql);
  
					RESULTDATA=objcommon.convertToJSON(resultSet); 
					stmtVeh1.close();   
					conn.close();

			}
			catch(Exception e){         
				e.printStackTrace();
				conn.close();
			}
		//	System.out.println(RESULTDATA);
		    return RESULTDATA;
		}
		
	}


