package com.dashboard.procurment.alternativeitems;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsAlternativeItemsDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray secondload(String id,String docno,String qty) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;      
		}

		
		Connection conn = null;   

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();     
			String sql="select mm.doc_no mpsrno,u.doc_no uomid, mm.psrno,cat.category,sc.subcategory,bd.brandname,part_no pid,productname pdesc,u.unit uom from my_main mm  left join  my_brand bd on mm.brandid=bd.doc_no left join my_catm cat on(mm.catid=cat.doc_no) left join my_scatm sc on(mm.scatid=sc.doc_no)  left join my_unitm u on u.doc_no=mm.munit where mm.status=3 ";
			//System.out.println("stkdoc==="+docno.length());
			
			System.out.println("------rawmaterialload------"+sql);   
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);   


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray altergridload(String id,String docno,String qty) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;      
		}

		
		Connection conn = null;   

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();     
			String sql="select coalesce(ar.altpsrno,0)altpsrno,mm.doc_no mpsrno,u.doc_no uomid, mm.psrno,cat.category,sc.subcategory,bd.brandname,part_no pid,productname pdesc,u.unit uom from my_main mm  inner join my_pralter ar on mm.psrno=ar.rdocno  left join  my_brand bd on mm.brandid=bd.doc_no left join my_catm cat on(mm.catid=cat.doc_no) left join my_scatm sc on(mm.scatid=sc.doc_no)  left join my_unitm u on u.doc_no=mm.munit where mm.status=3 and mm.psrno="+docno+" union all\r\n" + 
					"select 0 altpsrno,mm.doc_no mpsrno,u.doc_no uomid, mm.psrno,cat.category,sc.subcategory,bd.brandname,part_no pid,productname pdesc,u.unit uom from my_main mm  left join my_pralter ar on mm.psrno=ar.rdocno  left join  my_brand bd on mm.brandid=bd.doc_no left join my_catm cat on(mm.catid=cat.doc_no) left join my_scatm sc on(mm.scatid=sc.doc_no)  left join my_unitm u on u.doc_no=mm.munit where mm.status=3 and mm.psrno not in(select altpsrno from my_pralter where rdocno="+docno+") and mm.psrno!="+docno+" group by mm.psrno; ";
			//System.out.println("stkdoc==="+docno.length());
			
			System.out.println("------rawmaterialload------"+sql);   
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);   


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray viewload(String id,String docno,String qty) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;      
		}

		
		Connection conn = null;   

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();     
			String sql="select mm.doc_no mpsrno,u.doc_no uomid, mm.psrno,cat.category,sc.subcategory,bd.brandname,mm.part_no pid,mm.productname pdesc,u.unit uom,dt.department,m2.doc_no deppsrno,m2.part_no deppartno,m2.productname depproduct from my_main mm inner join my_pralter ar on mm.doc_no=ar.rdocno left join my_main m2 on m2.doc_no=ar.altpsrno left join my_dept dt on m2.deptid=dt.doc_no left join  my_brand bd on mm.brandid=bd.doc_no left join my_catm cat on(mm.catid=cat.doc_no) left join my_scatm sc on(mm.scatid=sc.doc_no)  left join my_unitm u on u.doc_no=mm.munit  where mm.status=3";
			//System.out.println("stkdoc==="+docno.length());
			
			System.out.println("------viewloadvhh------"+sql);   
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);   


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
}
