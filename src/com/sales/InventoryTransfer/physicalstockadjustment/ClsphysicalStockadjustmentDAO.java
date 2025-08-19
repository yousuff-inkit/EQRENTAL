package com.sales.InventoryTransfer.physicalstockadjustment;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
//import com.sales.marketing.salesquotation.ClsSalesQuotationBean;

public class ClsphysicalStockadjustmentDAO {
	ClsphysicalStockadjustmentBean bean= new ClsphysicalStockadjustmentBean();
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	public   JSONArray searchProduct(HttpSession session,String location,String branch) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 
			String sql="";
		 
			String sqltest="";

			String sqltest1="";
			String sqltest3="";
			
			 
				 
			 
			
			if((!(location.equalsIgnoreCase(""))) && (!(location.equalsIgnoreCase("NA"))) && (!(location.equalsIgnoreCase("0"))) ){
				sqltest= " and i.locid = '"+location+"'  ";
				
				sqltest1=" and locid = '"+location+"'  ";
				sqltest3=" and pin.locid = '"+location+"'  ";
			}
 
		/*		sql="select bd.brandname,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,"
						+ " convert('',char(20)) qty,sum(i.out_qty) outqty, "
						+ " sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty,sum(i.op_qty) as totqty,i.stockid as stkid,i. unit_price unitprice  "
						+ " from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
						+ "    left join  my_brand bd on m.brandid=bd.doc_no inner join my_prddin i on(i.psrno=m.psrno and  "
						+ "i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+branch+"' ) where m.status=3 and  "
						+ "i.brhid='"+branch+"' "+sqltest+" group by i.prdid having  "
						+ "sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by  i.prdid,i.date  ";
				*/
		 
			// System.out.println("=========="+sqlStartDate);
			
			
				sql=" select coalesce(pin1.cost_price,0) cost_price, bd.brandname,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit, "
						+ " m.munit as unitdocno,m.psrno,coalesce(sum(rsv_qty),0) rsv_qty, coalesce(sum(i.op_qty-(i.out_qty+i.del_qty)),0) stk_qty, "
						+ " coalesce(sum(i.out_qty),0) outqty, coalesce(sum(i.op_qty-(i.out_qty+i.del_qty)),0) as balqty, "
						+ " coalesce(sum(i.op_qty),0) as totqty,coalesce(i.stockid,0)  as stkid,coalesce(i. unit_price,0)  unitprice   "
						+ " from my_main m left join my_unitm u on m.munit=u.doc_no "
				+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)      left join  my_brand bd on m.brandid=bd.doc_no "
				+ " left join (select max(stockid) maxstock,psrno,prdid,specno,brhid,locid from my_prddin  where brhid='"+branch+"' "+sqltest1+"  group by prdid ) pin "
				+ "  on(pin.psrno=m.psrno and  pin.prdid=m.doc_no and pin.specno=at.mspecno and pin.brhid='"+branch+"' "+sqltest3+"  ) "
				+ " left join (select  cost_price,psrno,prdid,specno,brhid,locid,stockid from my_prddin where brhid='"+branch+"' "+sqltest1+"   group by stockid  ) pin1 "
				+ "  on(pin1.psrno=m.psrno and  pin1.prdid=m.doc_no and pin1.specno=at.mspecno and pin1.stockid=pin.maxstock  ) "
				+ "  left join my_prddin i on(i.psrno=m.psrno and  i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+branch+"' "+sqltest+"     ) "
				 + " where m.status=3  group by m.psrno order by m.doc_no " ;
				
				/* commented for MMJ 04-11-2018 as per Yousuf instruction
				 *
				 *		sql=" select pin1.cost_price, bd.brandname,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,sum(rsv_qty) rsv_qty, "
						+ " sum(i.op_qty-(i.out_qty+i.del_qty)) stk_qty,sum(i.out_qty) outqty,  sum(i.op_qty-(i.out_qty+i.del_qty)) as balqty,sum(i.op_qty) as "
				 + " totqty,i.stockid as stkid,i. unit_price unitprice   from my_main m left join my_unitm u on m.munit=u.doc_no "
				+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)      left join  my_brand bd on m.brandid=bd.doc_no "
				+ " left join (select max(stockid) maxstock,psrno,prdid,specno,brhid,locid from my_prddin  where brhid='"+branch+"' "+sqltest1+"  group by prdid ) pin "
				+ "  on(pin.psrno=m.psrno and  pin.prdid=m.doc_no and pin.specno=at.mspecno and pin.brhid='"+branch+"' "+sqltest3+"  ) "
				+ " left join (select  cost_price,psrno,prdid,specno,brhid,locid,stockid from my_prddin where brhid='"+branch+"' "+sqltest1+"   group by stockid  ) pin1 "
				+ "  on(pin1.psrno=m.psrno and  pin1.prdid=m.doc_no and pin1.specno=at.mspecno and pin1.stockid=pin.maxstock  ) "
				+ "  inner join my_prddin i on(i.psrno=m.psrno and  i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+branch+"' "+sqltest+"     ) "
				 + " where m.status=3 and i.brhid='"+branch+"' "+sqltest+"   group by i.prdid  having  sum(op_qty-i.out_qty-i.del_qty)>0  and sum(rsv_qty)=0  "
				+ "  order by  i.prdid,i.date " ;
				 **/
 

			System.out.println("----searchProduct-sql---"+sql);

			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}


	public   JSONArray searchSalesPerson(HttpSession session) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 


			String sql="select doc_no,sal_name from my_salm where status=3";
			// System.out.println("-----fleetsql---"+fleetsql);

			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public   JSONArray searchLocation(String brcid) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 
 

			String sql="select m.doc_no,loc_name as location,branchname as branch from my_locm m left join my_brch b on(b.doc_no=m.brhid) where m.status=3 and brhid="+brcid+"";
			System.out.println("-----searchLocation---"+sql);

			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}


	public   JSONArray termsSearch(HttpSession session,String dtype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 


			String sql="select voc_no,dtype,termsheader as header from my_termsm where dtype='"+dtype+"' and status=3";
			// System.out.println("-----fleetsql---"+fleetsql);

			ResultSet resultSet = stmt.executeQuery (sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}







	public  JSONArray reqSearchMasters(HttpSession session,String docnoss,String refnosss,String datess,String aa,String clientid,String locaid) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}
		String brcid = session.getAttribute("BRANCHID").toString(); 

		String sqltest="";


		java.sql.Date  sqlStartDate = null;
		if(!(datess.equalsIgnoreCase("undefined"))&&!(datess.equalsIgnoreCase(""))&&!(datess.equalsIgnoreCase("0")))
		{
			sqlStartDate = ClsCommon.changeStringtoSqlDate(datess);
		}


		if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
			sqltest=sqltest+" and m.voc_no like '%"+docnoss+"%'";
		}
		if((!(refnosss.equalsIgnoreCase(""))) && (!(refnosss.equalsIgnoreCase("NA")))){
			sqltest=sqltest+" and m.refno like '%"+refnosss+"%'  ";
		}

		/*if((!(clientid.equalsIgnoreCase(""))) && (!(clientname.equalsIgnoreCase("NA")))){
      		sqltest=sqltest+" and ac.refname like '%"+clientname+"%'  ";
      	}*/


		if(!(sqlStartDate==null)){
			sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
		}

		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtmain = conn.createStatement ();

/*			 String pySql=("select * from (select sum(qty-d.out_qty) as qty,m.doc_no,m.rrefno as refno,m.voc_no,m.date,ac.refname as 
			client,0 as chk from my_sorderm m left join   my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_sorderd d
			on(d.rdocno=m.doc_no)  where m.status=3 and m.cldocno="+clientid+"  and m.brhid='"+brcid+"'     "+sqltest+" group by m.doc_no) as a having qty>0" );
		*/
			String pySql=("select * from (select sum(qty-d.out_qty) as qty,coalesce(ii.belqty,0) as bel,m.doc_no,m.rrefno as refno,m.voc_no,m.date,ac.refname "
					+ " as client,0 as chk from my_sorderm m left join   my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM')  "
					+ " left join my_sorderd d on(d.rdocno=m.doc_no) left join (select psrno,specno,prdid,brhid ,sum(op_qty)-(sum(out_qty+rsv_qty+del_qty)) belqty "
					+ "  from  my_prddin  where 1=1 group by  psrno) ii on (ii.psrno=d.psrno and ii.specno=d.specno and ii.prdid=d.prdid and ii.brhid=m.brhid)  "
					+ "  where d.clstatus=0 and m.status=3 and m.cldocno="+clientid+"  and m.brhid='"+brcid+"'     "+sqltest+"     group by m.doc_no)  as a having  qty>0 ");
			
			System.out.println("====pySql===="+pySql);
			ResultSet resultSet = stmtmain.executeQuery(pySql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet); 

			stmtmain.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//	System.out.println(RESULTDATA);
		return RESULTDATA;
	}



	public  JSONArray searchMaster(HttpSession session,String msdocno,String desc,String enqdate) throws SQLException {


		System.out.println("==searchMaster===");

		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}

		//  System.out.println("8888888888"+clnames); 	
		String brid=session.getAttribute("BRANCHID").toString();



		java.sql.Date sqlStartDate=null;


		if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = ClsCommon.changeStringtoSqlDate(enqdate);
		}

		String sqltest="";
		if(!(msdocno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.voc_no like '%"+msdocno+"%'";
		}

		if(!(desc.equalsIgnoreCase("")) && !(desc.equalsIgnoreCase(""))){
			sqltest=sqltest+" and description like '%"+desc+"%'";
		}


		if(!(sqlStartDate==null)){
			sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
		} 





		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			String clssql= ("select m.doc_no,m.voc_no,m.date,frmbrhid brhid,locid,description descs,coalesce(loc_name,'') as locname from  my_phkm m "
					+ "   left join my_locm l on m.locid=l.doc_no  where m.status=3 and m.brhid="+brid+" "+sqltest+"");
			System.out.println("====searchmaster===="+clssql);
			ResultSet resultSet = stmtenq1.executeQuery(clssql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtenq1.close();
			conn.close();
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}



	public JSONArray searchClient(HttpSession session,String clname,String mob) throws SQLException {

		//		System.out.println("==searchClient====");

		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}


		String brid=session.getAttribute("BRANCHID").toString();






		//System.out.println("name"+clname);

		String sqltest="";

		if(!(clname.equalsIgnoreCase(""))){
			sqltest=sqltest+" and refname like '%"+clname+"%'";
		}
		if(!(mob.equalsIgnoreCase(""))){
			sqltest=sqltest+" and per_mob like '%"+mob+"%'";
		}


		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt1 = conn.createStatement ();

			String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);
			//System.out.println("========"+clsql);
			ResultSet resultSet = stmt1.executeQuery(clsql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt1.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public JSONArray prdGridLoad(HttpSession session,String docno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select  specid,psrno as doc_no,rdocno,psrno,(qty-outqty) qty,outqty,(qty-outqty) as balqty,size,part_no,productid,productname,unit,unitdocno,stkid from "
					+ "( select at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(out_qty) as outqty,0 size,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.stockid as stkid from "
					+ "my_deld d  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) where m.status=3 and d.rdocno in("+docno+") group by psrno having sum(d.qty-d.out_qty)>0) as a ";
			System.out.println("===prdbranchLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray prdGridReload(HttpSession session,String docno,String enqdoc,String locationid,String reftype) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {

			if(((docno.equalsIgnoreCase(""))||(docno.equalsIgnoreCase("undefined")))){

				docno="0";
			}

		 
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();


			String sql="";
			int method=0;


/*  
			sql=" select  brandname,foc,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty, "
					+ " case when (totqty-outqty)=0 then 0 else (qty+balqty) end as balqty,0 size,part_no,productid as proid, "
		 + " productid,productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper, "
		+ "   dis, netotal from(select  brandname,foc,stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty, "
		+ "  (qtys-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, "
		 + "  total, discper,  dis, netotal from (select bd.brandname,d.foc,d.stockid as stkid,d.specno as specid,d.rdocno,m.doc_no "
		  + " psrno,aa.qty as qty, ii.op_qty  as qtys,ii.outqty,m.part_no,m.part_no "
		 + "  productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice, "
		+ "   d.total,d.disper discper, d.discount dis,sum(d.nettotal) netotal from my_delm ma left join my_deld d on "
		+ "   (ma.doc_no=d.rdocno)left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u "
		+ "   on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) "
		+ "   left join my_prddin i on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid and i.locid='"+locationid+"') "
		+ "     left join (select sum(qty) qty,psrno,rdocno,specno,prdid from my_deld where  rdocno in("+docno+") "
		+ "		  group by  psrno) aa on aa.psrno=i.psrno "
			+ "	  left join( select date,sum(op_qty) op_qty,stockid,sum(out_qty+del_qty+rsv_qty) outqty,prdid,psrno,specno,brhid,locid "
			+ "	   from my_prddin where locid='"+locationid+"' group by psrno,brhid) ii on "
				+ "	    (ii.psrno=i.psrno and ii.prdid=i.prdid and i.specno=ii.specno and ma.brhid=ii.brhid ) "
		  + "  where m.status=3 and d.rdocno in("+docno+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by d.prdid  order by i.date,d.prdid) as a ) as b ";

			*/
		  sql="select  m.part_no as proid, m.doc_no prodoc, m.productname as proname,bd.brandname,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno, "
		  		+ " sum(d.adj_qty) adj_qty, d.stk_qty, d.phy_qty, (sum(d.totcost_price)/sum(d.adj_qty)) cost_price ,(sum(d.totcost_price)/sum(d.adj_qty)) cost_price1 , "
		  		+ "  sum(d.totcost_price) totcost_price,d.specno as specid,d.rdocno,m.doc_no  psrno from my_phkd d  left join my_main m  "
		  		+ "on(d.psrno=m.doc_no and d.prdid=m.psrno) left join  my_unitm u  on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
		  		+ "  left join my_prodattrib at  on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) where d.rdocno in("+docno+") group by d.psrno " ;
 			
			System.out.println("== =prdGridReload==3==="+sql);


			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	public JSONArray prdGridReload(HttpSession session,String docno,String locationid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {

			if(((docno.equalsIgnoreCase(""))||(docno.equalsIgnoreCase("undefined")))){

				docno="0";
			}

			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

	/*		String sql="select d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,qty totqty,qty as oldqty,qty qty,out_qty outqty,qty as balqty,"
					+ "part_no,m.part_no productid,m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, KGPrice kgprice,"
					+ "amount unitprice, total,disper discper,discount dis,nettotal netotal from my_sorderd d  left join my_main m on(d.psrno=m.doc_no) "
					+ "left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) where m.status=3 and d.rdocno in ("+docno+") group by psrno "
					+ "having sum(d.qty-d.out_qty)>0";
			*/
			String sql="select bd.brandname,sum(qty)-sum(out_qty) valorderqty,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty, "
					+ " sum(qty) as oldqty,sum(qty)-sum(out_qty) qty,sum(out_qty) outqty,coalesce(ii.balqty,0) as balqty,part_no,m.part_no productid,m.part_no "
			 + " as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, "
			 + "  KGPrice kgprice,d.amount unitprice, d.total,d.disper discper,d.discount dis,d.nettotal netotal "
			+ "  from my_sorderm ma left join  my_sorderd d on ma.doc_no=d.rdocno "
			+ "   left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on "
			+ "  (d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "
			+ " left join( select date,sum(op_qty) op_qty,stockid, "
			 + " sum(op_qty)-sum(out_qty+del_qty+rsv_qty) balqty,prdid,psrno,specno,brhid,locid "
			 + " from my_prddin where 1=1 group by psrno) ii on  (ii.psrno=d.psrno and ii.prdid=d.prdid "
			 + "  and d.specno=ii.specno and ma.brhid=ii.brhid  )  "
			+ "  where m.status=3 and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' and d.clstatus=0  and d.rdocno in ("+docno+") group by d.psrno having sum(d.qty-d.out_qty)>0 ";
			

			System.out.println("===prdGridReload===2=="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}




	public JSONArray termsGridLoad(HttpSession session,String dtype) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select m.voc_no,m.dtype,termsheader terms,termsfooter conditions from MY_termsm m   "
					+ " inner join my_termsd d on(m.voc_no=d.rdocno and   d.status=3) where m.status=3 and d.dtype='"+dtype+"' order by terms";
			System.out.println("===termsGridLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray termsGridReLoad(HttpSession session,String dtype,String qotdoc) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select m.voc_no,m.dtype,termsheader terms,conditions conditions from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where  tr.dtype='"+dtype+"' and tr.rdocno="+qotdoc+" order by terms";
			System.out.println("===termsGridLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}



	public   JSONArray qotgridreload(String doc) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 
			String sql="";
			int method=0;
			String sqlcond1="";
			String sqlcond2="";
			String sqlselect="";

			if(((doc.equalsIgnoreCase(""))||(doc.equalsIgnoreCase("undefined")))){

				doc="0";
			}

			/*			String chk="select method  from gl_prdconfig where field_nme='prosearch_stock'";
			ResultSet rs=stmt.executeQuery(chk); 
			if(rs.next())
			{

				method=rs.getInt("method");
			}


			if(method>0){
				sqlcond1="inner join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno)";
				sqlcond2="group by i.stockid having sum((op_qty)-(i.out_qty+i.rsv_qty+i.del_qty))>0 order by i.date";
				sqlselect="i.stockid";
			}
			else{
				sqlselect="0";
				sqlcond1="";
				sqlcond2="group by psrno having sum(d.qty-d.out_qty)>0";
			}*/


			sqlcond1="inner join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno)";
			sqlcond2="group by i.stockid having sum((op_qty)-(i.out_qty+i.rsv_qty+i.del_qty))>0 order by i.date";
			sqlselect="i.stockid";

			sql="select  stkid,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno from "
					+ "( select "+sqlselect+" as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(d.out_qty) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from "
					+ "my_sorderm ma left join my_sorderd d on(ma.doc_no=d.rdocno) inner join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqlcond1+" where m.status=3 and d.rdocno in("+doc+")  "+sqlcond2+" ) as a group by psrno";


			System.out.println("=qotgridreload==="+sql);

			ResultSet resultSet = stmt.executeQuery(sql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet); 
			stmt.close();


		}
		catch(Exception e){
			e.printStackTrace();

		}
		finally{
			conn.close();
		}
		//	System.out.println(RESULTDATA);
		return RESULTDATA;
	}	



public int insert(java.sql.Date date, ArrayList<String> prodarray, HttpSession session,
		HttpServletRequest request, int locid, int brchNames,
		String desc, String mode, String formcode, int frmbrch)throws SQLException{



		Connection conn=null;
		int deldocno=0;
		conn=ClsConnection.getMyConnection();

		try{

			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL tr_physicalStockAdjustmentDML(?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			 
			stmt.setString(2,desc);
			 
			stmt.setString(3,mode);
			stmt.setString(4,formcode);
			stmt.setString(5, session.getAttribute("USERID").toString());
			stmt.setString(6, session.getAttribute("BRANCHID").toString());
			stmt.setString(7, session.getAttribute("COMPANYID").toString());
	 
			stmt.setInt(8, frmbrch);
			stmt.setInt(9, locid);
			int val = stmt.executeUpdate();
			deldocno=stmt.getInt("deldocno");
			int vocno=stmt.getInt("vdocNo");
			int trno=stmt.getInt("strno");
			request.setAttribute("vdocNo", vocno);
			//System.out.println("===vocno====="+vocno);
			if(vocno>0){

				int prodet=0;
				int prodout=0;
				
				
				
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){


					
 
						if(deldocno>0)
						{

							String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
						 
							String specno=""+(prod[7].equalsIgnoreCase("undefined") || prod[7].equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"";
						
													 
							String  adj_qty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double masterqty=Double.parseDouble(adj_qty);
							
							
							String  stk_qtys=""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].trim().equalsIgnoreCase("")|| prod[3].isEmpty()?0:prod[3].trim())+"";
							double stk_qty=Double.parseDouble(stk_qtys);
							
							
							String  phy_qtys=""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].trim().equalsIgnoreCase("")|| prod[4].isEmpty()?0:prod[4].trim())+"";
							double phy_qty=Double.parseDouble(phy_qtys);
							
/*						    	String  adj_qty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double masterqty=Double.parseDouble(adj_qty);
							
							                             0                   1                   2                     3                   4
							  newTextBox.val(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].adj_qty+"::"+rows[i].stk_qty+"::"+rows[i].phy_qty+"::"+ 
							  
						                            5                     6                          7      
								
							
									  rows[i].cost_price+"::"+rows[i].totalcost_price+"::"+rows[i].specid+"::");*/
							
							
							String sqlst=""; 
							
							if(locid>0)
							{
								sqlst=" and locid='"+locid+"' ";
								
							}
							if(masterqty<0)
							
							
							{
								
								
					          
									double balstkqty=0;
									double balstkqty1=0;
									int psrno=0;
									int stockid=0;
									double remstkqty=0;
									double outstkqty=0;
									double stkqty=0;
									double qty=0;
									double detqty=0;
									double unitprice=0.0;
									double tmp_qty=0.0;
									double outqtys=0.0;
									double refqty=0.0;
									String qty_fld="";
									String qryapnd="";
									String slquery="";
									masterqty=masterqty*-1;
									String loc=sqlst;
									double cost_price=0;
									
									int locids=locid;
								 
									 
						 
										qty_fld="out_qty";
										//qryapnd="and cost_price="+unitprice+"";
										//qryapnd="and stockid="+stkid+"";
										slquery="(out_qty+del_qty)";
										
									 
										 
								 

									


									Statement stmtstk=conn.createStatement();

									String stkSql="select cost_price,locid,stockid,psrno,specno,sum(op_qty) stkqty,sum((op_qty-"+slquery+")) balstkqty,"+slquery+" out_qty,"+qty_fld+" as qty,out_qty qtys,date from my_prddin "
											+ "where psrno='"+prdid+"' and specno='"+specno+"' "+qryapnd+"  and prdid='"+prdid+"' and brhid="+frmbrch+" "+loc+"  "
											+ "group by stockid,cost_price,prdid,psrno having sum((op_qty-"+slquery+"))>0 and sum(rsv_qty)=0 order by date,stockid";

									System.out.println("=1111111111111111111111   1stkSql=inside insert="+stkSql);

									ResultSet rsstk = stmtstk.executeQuery(stkSql);

									while(rsstk.next()) {

										balstkqty1=rsstk.getDouble("balstkqty");
										balstkqty=rsstk.getDouble("balstkqty");
										psrno=rsstk.getInt("psrno");
										outstkqty=rsstk.getDouble("out_qty");
										stockid=rsstk.getInt("stockid");
										stkqty=rsstk.getDouble("stkqty");
										qty=rsstk.getDouble("qty");
										outqtys=rsstk.getDouble("qtys");
										locids=rsstk.getInt("locid");
										cost_price=rsstk.getInt("cost_price");
										
										
										refqty=masterqty;
										System.out.println("---masterqty-----="+masterqty);	
										System.out.println("---balstkqty-----="+balstkqty);	
										System.out.println("---out_qty-----="+outstkqty);	
										System.out.println("---stkqty-----="+stkqty);
										System.out.println("---qty-----="+qty);

										String queryappnd="";
										
									 

										if(remstkqty>0)
										{

											masterqty=remstkqty;
										}

										 
										if(masterqty<=balstkqty)
										{
											detqty=masterqty;

									 
											
											System.out.println("-----queryappnd-----"+queryappnd);
											

											masterqty=masterqty+outqtys;
		 
											
											
											String sqls="update my_prddin set out_qty="+masterqty+"  where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" and brhid="+frmbrch+" and locid="+locids+"   ";
											System.out.println("--1---sqls---"+sqls);
											stmt.executeUpdate(sqls);
							
											masterqty=detqty; // work

										}
										else if(masterqty>balstkqty)
										{



											if(stkqty>=(masterqty+outstkqty))

											{
												balstkqty=masterqty+outqtys;	
												remstkqty=stkqty-outstkqty;

												System.out.println("---balstkqty-1---"+balstkqty);
											}
											else
											{
												remstkqty=masterqty-balstkqty;
												balstkqty=stkqty-outstkqty+outqtys;

												System.out.println("---masterqty-2---"+masterqty);
												System.out.println("---outstkqty-2---"+outstkqty);
												System.out.println("---stkqty-2---"+stkqty);
												System.out.println("---remstkqty-2---"+remstkqty);
												System.out.println("---balstkqty--2--"+balstkqty);
											}
											detqty=stkqty-outstkqty;

									 
											
											String sqls="update my_prddin set out_qty="+balstkqty+"  where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" and brhid="+frmbrch+" and locid="+locids+"";	
											System.out.println("-2----sqls---"+sqls);

											stmt.executeUpdate(sqls);	

											//remstkqty=masterqty-stkqty;



										}


							 
									 
										Double totalcost=0.0;
										
								  
										 totalcost=(cost_price*detqty)*-1;
										  
									 
										String sql="insert into my_phkd(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,unitid,adj_qty,stk_qty,phy_qty,cost_price,totcost_price, etype,locid)VALUES"
												+ " ("+trno+","+(i+1)+",'"+deldocno+"',"
												+ "'"+stockid+"',"
												+ "'"+(prod[7].equalsIgnoreCase("undefined") || prod[7].equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
												+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
												+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
												+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
												+ "'"+detqty*-1+"',"
												+ "'"+stk_qty+"',"
												+ "'"+phy_qty+"',"
												+ "'"+cost_price+"',"
												+ "'"+totalcost+"',"
												+ "'"+-1+"','"+locids+"')";

										System.out.println("branchper--->>>>Sql"+sql);
										prodet = stmt.executeUpdate (sql);

										String prodoutsql="";
		                                
					 
											
											 prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid,date, specid, psrno,qty,prdid,brhid,locid,unit_price,cost_price) Values"
													+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"+deldocno+","
													+ "'"+stockid+"',"
													+ "'"+date+"',"
													+ "'"+(prod[7].equalsIgnoreCase("undefined") || prod[7].equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
													+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
													+ "'"+detqty+"',"
													+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
													+"'"+frmbrch+"','"+locids+"',"+cost_price+",'"+cost_price+"')";

								 

										System.out.println("prodoutsql----------------------------------------------->>>>Sql"+prodoutsql);
										
										prodout = stmt.executeUpdate (prodoutsql);
										System.out.println("masterqty--->>>>"+masterqty);
										System.out.println("balstkqty1--->>>>"+balstkqty1);
								 	if(masterqty<=balstkqty1)
										{
											break;
										} 

								 
									}// wie

							
							
							
							
							
							
							
							
							}//master if
							else if(masterqty>0)
							{
								
								int  locidval=locid;
							 
								if(locid==0)
								{
									
									String sqlsss="select doc_no from my_locm where brhid='"+frmbrch+"' and mainloc=1 ";
									ResultSet rsss=stmt.executeQuery(sqlsss);
									if(rsss.next())
									{
										locidval=rsss.getInt("doc_no");
										
									}
									
								}
								else
								{
									locidval=locid;
									
								}
								
								String pincostprice=""+(prod[5].equalsIgnoreCase("undefined") || prod[5].equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"";
								
								/*						   
								                             0                   1                   2                     3                   4
								  newTextBox.val(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].adj_qty+"::"+rows[i].stk_qty+"::"+rows[i].phy_qty+"::"+ 
								  
							                            5                     6                          7      
									
								
										  rows[i].cost_price+"::"+rows[i].totalcost_price+"::"+rows[i].specid+"::");*/
								
								
								
								 
								Double totalcost=0.0;
								
						  
								 totalcost=(Double.parseDouble(pincostprice)*masterqty);
								 
								 String unitidss=""+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"";
								 
							     double fr=1;
							     String slss=" select fr from my_unit where psrno="+prdid+" and unit='"+unitidss+"' ";
							     
							     System.out.println("====slss==="+slss);
							     ResultSet rv1=stmt.executeQuery(slss);
							     if(rv1.next())
							     {
							    	 fr=rv1.getDouble("fr"); 
							     }
							     if(locidval==0)
							     {
							    	 locidval=locid; 
							     }
								  
							     String sql2="insert into my_prddin(sr_no, psrno,prdid,specno,unit_price,op_qty,locid,brhid,tr_no,dtype,cost_price,date,fr,unitid)values"
							    		 + "("+(i+1)+","
							             + "'"+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
									     + "'"+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
									     + "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("NaN")||prod[7].trim().equalsIgnoreCase("")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
							               + "'"+pincostprice+"',"
									     +"'"+masterqty+"',"
							             +"'"+locidval+"','"+frmbrch+"','"+trno+"','"+formcode+"',"+pincostprice+",'"+date+"',"+fr+",'"+unitidss+"')";
							     
							  System.out.println("--insert into my_prddin-----"+sql2);
							     int resultSet10 = stmt.executeUpdate(sql2);
							     if(resultSet10<=0)
									{
										conn.close();
										return 0;
										
									}
								
							     int stockids=0;	
								    
						         Statement selstmt=conn.createStatement();
						     String sqlssel="select coalesce((max(stockid)),1) stockid from my_prddin  ";
						     
						  
						     
						     ResultSet selrss=selstmt.executeQuery(sqlssel);
						     
						     if(selrss.next())
						     {
						    	 stockids=selrss.getInt("stockid") ;
						    	 
						    	 
						    	 
						 	 
						     }
						      	 
								 
								 
							 
								String sql="insert into my_phkd(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,unitid,adj_qty,stk_qty,phy_qty,cost_price,totcost_price,etype,locid)VALUES"
										+ " ("+trno+","+(i+1)+",'"+deldocno+"',"
										+ "'"+stockids+"',"
										+ "'"+(prod[7].equalsIgnoreCase("undefined") || prod[7].equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
										+ "'"+masterqty+"',"
										+ "'"+stk_qty+"',"
										+ "'"+phy_qty+"',"
										+ "'"+pincostprice+"',"
										+ "'"+totalcost+"',"
										+ "'"+1+"','"+locidval+"')";

								System.out.println(" --purchases->>>>pin="+sql);
								prodet = stmt.executeUpdate (sql);
								
							
								
								
								
								
							}

				 

						}

					}

				}// for
				
				double totcost_price=0.00;
				
				String totalcostamtsql="select sum(totcost_price) totcost_price from my_phkd where rdocno='"+deldocno+"' group by rdocno ";

			     ResultSet selrss=stmt.executeQuery(totalcostamtsql);
			     
			     if(selrss.next())
			     {
			    	 totcost_price=selrss.getDouble("totcost_price") ;
			    	 
			    	 
			    	 
			 	 
			     }
			     
			     
			  
			      	 
				 String vendorcur="1"; 
				 double venrate=1;
			     int acnos=0;
			     String curris="1";
			     double rates=1;
					String descs=formcode+":-Dated :- "+date; 
					
					String refdetails=formcode+""+vocno;
					
			     
			   String sql2="select  acno from my_account where codeno='STOCK ACCOUNT' ";
			   //System.out.println("-----4--sql2----"+sql2) ;

		       ResultSet tass1 = stmt.executeQuery (sql2);
				
				if (tass1.next()) {
			
					acnos=tass1.getInt("acno");		
					
			        }
				
				
				
				 String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
				   //System.out.println("-----5--sqls3----"+sqls3) ;
				   ResultSet tass3 = stmt.executeQuery (sqls3);
					
					if (tass3.next()) {
				
						curris=tass3.getString("curid");	
						 
						
				              }
					String currencytype1="";
					 String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
						        +"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
					 //System.out.println("-----6--sqlveh----"+sqlveh) ;
						     ResultSet resultSet44 = stmt.executeQuery(sqlveh);
						         
						      while (resultSet44.next()) {
						    	  rates=resultSet44.getDouble("rate");
						      currencytype1=resultSet44.getString("type");
						                 } 
					 
						      double pricetottal=totcost_price;
						      double ldramounts=0 ;     
						      if(currencytype1.equalsIgnoreCase("D"))
						      {
						      
				                   ldramounts=pricetottal/venrate ;  
						      }
						      
						      else
						      {
						    	   ldramounts=pricetottal*venrate ;  
						      }
			     
				 String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
					 		+ "values('"+date+"','"+refdetails+"',"+deldocno+",'"+acnos+"','"+descs+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,1,7,0,0,0,'"+rates+"',0,0,'"+formcode+"','"+frmbrch+"',"+trno+",3)";
			     
			     
				  System.out.println("---STOCK ACCOUNT sql11----"+sql11) ; 
			 
					 int ss1 = stmt.executeUpdate(sql11);

				     if(ss1<=0)
						{
							conn.close();
							return 0;
							
						}
				     
				     
			     
			     //======================================2================================================
 
				
				     double jvdramount=totcost_price*-1;
				     int id=0;
				     int adjustacno=0;
				     
				     String adjustcurrid="1";
				     
				     
				     double adjustcurrate=1;
				     
				 
						if(jvdramount>0 || jvdramount<0)
						{
							
							
							if(jvdramount>0)
							{
								id=1;
									
								
							}
							
							else
							{
								
								id=-1;
							}
							
							
							
						     
							   String sqls2="select  acno from my_account where codeno='STOCK ADJUSTMENT ACCOUNT' ";
							   //System.out.println("-----4--sql2----"+sql2) ;

						       ResultSet adjaccount = stmt.executeQuery (sqls2);
								
								if (adjaccount.next()) {
							
									adjustacno=adjaccount.getInt("acno");		
									
							        }
								
								
							
								 String expsqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+adjustacno+"'";
								   //System.out.println("-----5--sqls3----"+sqls3) ;
								   ResultSet exptass3 = stmt.executeQuery (expsqls3);
									
									if (exptass3.next()) {
								
										adjustcurrid=exptass3.getString("curid");	
										 
										
								              }
									String adjustcurrencytype1="";
									 String adjustsql = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
										        +"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+adjustcurrid+"'";
									// System.out.println("---adjustsql----"+adjustsql) ;
										     ResultSet resultadj = stmt.executeQuery(adjustsql);
										         
										      while (resultadj.next()) {
										    	  adjustcurrate=resultadj.getDouble("rate");
										    	  adjustcurrencytype1=resultadj.getString("type");
										                 } 
										      
										      
										      double adjustldramounts=0 ;     
										      if(adjustcurrencytype1.equalsIgnoreCase("D"))
										      {
										      
										    	  adjustldramounts=jvdramount/adjustcurrate ;  
										      }
										      
										      else
										      {
										    	  adjustldramounts=jvdramount*adjustcurrate ;  
										      }
							
							
										      
										      
										      
										      String adjustsql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
												 		+ "values('"+date+"','"+refdetails+"',"+deldocno+",'"+adjustacno+"','"+descs+"','"+adjustcurrid+"','"+adjustcurrate+"',"+jvdramount+","+adjustldramounts+",0,'"+id+"',7,0,0,0,'"+adjustcurrate+"',0,0,'"+formcode+"','"+frmbrch+"',"+trno+",3)";
										     
										     
											 System.out.println("---adjustsql11----"+sql11) ; 
										 
												 int result1 = stmt.executeUpdate(adjustsql11);

											     if(result1<=0)
													{
														conn.close();
														return 0;
														
													}
											     	      
							
							
							
						}
						

			}


			
 	 conn.commit();
		}
		catch(Exception e){
			deldocno=0;
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return deldocno;
	}

	public  ClsphysicalStockadjustmentBean getViewDetails(int docno,String branchid) throws SQLException{


		Connection conn =null;
		try {
			conn= ClsConnection.getMyConnection();

			Statement stmt = conn.createStatement ();

			String sql= ("select  m.shipdetid, if(sh.type=0,sh.clname,ac1.refname) clname,  sh.claddress, sh.contactperson, sh.tel, sh.mob, sh.email, sh.fax, "
					+ " l.loc_name,m.locid,m.date,m.pricegroup,m.doc_no,m.voc_no,coalesce(m.refno,'') refno,m.date,m.dtype,cr.doc_no as currid,cr.code as curr,cr.c_rate as curate,m.brhid,ac.refname as name,ac.address as cladd,m.cldocno,coalesce(m.ref_type,'DIR') as ref_type ,coalesce(rrefno,'') as rrefno,coalesce(description,'') as descrptn,coalesce(payterms,'') as payterms,coalesce(s.doc_no,0) as salid,coalesce(s.sal_name,'') as sal_name,coalesce(m.amount,0.00) as proamt,coalesce(m.discount,0.00) as discount,coalesce(m.netAmount,0.00) as netotal,coalesce(m.disper,0.00) as discper,coalesce(m.grantamt,0.00) as ordervalue,coalesce(m.servamt,0.00) as servamt,coalesce(m.roundof,0.00) as roundof "
					+ "from my_delm m left join my_deld d on(m.doc_no=d.rdocno) left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM')  "
					+ "  left join my_locm l on l.doc_no=m.locid  left join my_salm s on(s.doc_no=m.sal_id) "
					+ " left join my_shipdetails sh on sh.doc_no=m.shipdetid and sh.type>0 "
					+ "  left join my_acbook ac1 on(ac1.doc_no=sh.cldocno and ac1.dtype='CRM') "
					+ " left join my_curr cr on(m.curid=cr.doc_no) where m.doc_no="+docno+" and m.brhid="+branchid+"");

			System.out.println("==getViewDetails===="+sql);
			String dtype="";
			String sqot="";
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				
				bean.setTxtlocation(rs.getString("loc_name"));
				bean.setLocationid(rs.getString("locid"));
				bean.setHiddate(rs.getString("date"));
				bean.setHidcmbprice(rs.getString("pricegroup"));
				bean.setMasterdoc_no(rs.getInt("doc_no"));
				bean.setDocno(rs.getString("voc_no"));
				bean.setTxtrefno(rs.getString("refno"));
				bean.setCmbcurr(rs.getString("currid"));
				bean.setHidcmbcurrency(rs.getString("currid"));
				bean.setCurrate(rs.getString("curate"));
				bean.setSalespersonid(rs.getInt("salid"));
				bean.setTxtsalesperson(rs.getString("sal_name"));
				bean.setClientid(rs.getInt("cldocno"));
				bean.setRefmasterdocno(rs.getString("rrefno"));
				
				   
				
				bean.setCmbreftype(rs.getString("ref_type"));
				bean.setHidcmbreftype(rs.getString("ref_type"));
				dtype=rs.getString("ref_type");
				sqot=rs.getString("rrefno");
				bean.setProdsearchtype(rs.getString("ref_type")=="DIR"?"0":"2");
				bean.setTxtpaymentterms(rs.getString("payterms"));
				bean.setTxtdescription(rs.getString("descrptn"));
				bean.setTxtproductamt(rs.getString("proamt"));
				bean.setTxtdiscount(rs.getString("discount"));
				bean.setDescPercentage(rs.getString("discper"));
				bean.setRoundOf(rs.getString("roundof"));
				bean.setTxtnettotal(rs.getString("netotal"));
				bean.setNettotal(rs.getString("servamt"));
				bean.setOrderValue(rs.getString("ordervalue"));
				
				
				bean.setShipdocno(rs.getInt("shipdetid"));
				bean.setShipto(rs.getString("clname"));
				bean.setShipaddress(rs.getString("claddress"));
				bean.setContactperson(rs.getString("contactperson"));
				bean.setShiptelephone(rs.getString("tel"));
				
				
				bean.setShipmob(rs.getString("mob"));
				bean.setShipemail(rs.getString("email"));
				bean.setShipfax(rs.getString("fax"));
			

			}


			int i=0;
			String qotdoc="";
			if(dtype.equalsIgnoreCase("SOR"))
			{
				Statement stmt1  = conn.createStatement ();	
				String sqlss="select voc_no from  my_sorderm where doc_no in ("+sqot+") ";
				//System.out.println("==sqlss==="+sqlss);

				ResultSet resultSet1= stmt1.executeQuery(sqlss);


				while (resultSet1.next()) {

					if(i==0)
					{
						qotdoc=resultSet1.getString("voc_no")+",";	
					}
					else
					{
						qotdoc=qotdoc+resultSet1.getString("voc_no")+",";
					}


					i++;



				}

				if(qotdoc.endsWith(","))
				{
					qotdoc = qotdoc.substring(0,qotdoc.length() - 1);
				}

				bean.setRrefno(qotdoc);

			}



		}
		catch(Exception e){
			e.printStackTrace();
		}
finally
{
	conn.close();
}
		return bean;
	}



/*	public int update(String voc_no,int doc_no,java.sql.Date date,String refno,String pricegroup,ArrayList prodarray,ArrayList termsarray,ArrayList servarray,HttpSession session,HttpServletRequest request)  throws SQLException{

		Connection conn=null;
		int deldocno=0;
		conn=ClsConnection.getMyConnection();

		try{

			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL deliveryNoteDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


			stmt.setDate(1,date);
			stmt.setString(2,refno);
			stmt.setInt(3, clientid);
			stmt.setInt(4, Integer.parseInt(curr));
			stmt.setDouble(5, Double.parseDouble(currate));
			stmt.setInt(6, salesid);
			stmt.setString(7,rreftype);
			stmt.setString(8,qotmasterdocno);
			stmt.setString(9,locid);
			stmt.setString(10,desc);
			stmt.setDouble(11,Double.parseDouble(prodamt));
			stmt.setDouble(12,Double.parseDouble(descount));
			stmt.setDouble(13,Double.parseDouble(nettotal));
			stmt.setString(14,mode);
			stmt.setString(15,formcode);
			stmt.setString(16, session.getAttribute("USERID").toString());
			stmt.setString(17, session.getAttribute("BRANCHID").toString());
			stmt.setString(18, session.getAttribute("COMPANYID").toString());
			stmt.setDouble(19, Double.parseDouble(descper));
			stmt.setDouble(20, Double.parseDouble(servamt));
			stmt.setDouble(21, Double.parseDouble(roundof));
			stmt.setDouble(22, Double.parseDouble(finalamt));
			stmt.setInt(23, 0);
			stmt.setInt(24,doc_no);
			stmt.setInt(25,Integer.parseInt(voc_no));
			stmt.registerOutParameter(26, java.sql.Types.VARCHAR);
			
			// System.out.println("===stmt====="+stmt);
			int val = stmt.executeUpdate();
			deldocno=stmt.getInt("deldocno");
			int vocno=stmt.getInt("vdocNo");
			int trno=stmt.getInt("strno");
			request.setAttribute("vdocNo", vocno);
			if(val<=0)
			{
				conn.close();
				return 0;
				
			}
			
			
			
				
				
			if(vocno>0){
				
				
				System.out.println("==========updatadata======"+updatadata);
				
				if(updatadata.equalsIgnoreCase("Editvalue"))
				{	
					System.out.println("==========IN======");
			 
				int updateid=0;
				int prodet=0;
				int prodout=0;
				 
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined"))||(prod[0].equalsIgnoreCase("null") ||(prod[0].isEmpty())))){

						if(i==0)
						{
        int counts=0;							
        String tempstk="0";	
        
        int stkids=0;
        
        String tempstkids="0";
      
		double chkqtys=0;	
		double prdqty=0;

		double saveqty=0;
		int tmptrno=0;
		
		int prdidss=0;

		String sql9="select count(*) tmpcount from my_deld where rdocno='"+deldocno+"'"	;				
 
	//	System.out.println("-----sql9-----"+sql9);
		
		ResultSet rsstk11 = stmt.executeQuery(sql9);

		
		if(rsstk11.next())
		{
			counts=rsstk11.getInt("tmpcount");
		}
		
		Statement st=conn.createStatement();
	     for(int m=0;m<=counts;m++)
	     {
	    	 
	    	String sql2="select stockid,qty,prdid,tr_no from my_deld where rdocno='"+deldocno+"' and stockid not in("+tempstk+") group by stockid limit 1";
	    	System.out.println("-----sql2-----"+sql2);
	    	ResultSet rsstk111 = stmt.executeQuery(sql2);
	    	
	    	
	    	if(rsstk111.next())
	    	{
	    		chkqtys=rsstk111.getDouble("qty");
	    		stkids=rsstk111.getInt("stockid");
	    		prdidss=rsstk111.getInt("prdid");
	    		tmptrno=rsstk111.getInt("tr_no");
	    	
	    	
	    	String sql3=" select del_qty   prdqty  from my_prddin where stockid='"+stkids+"'";
	    	 System.out.println("-----sql3-----"+sql3);
	    	ResultSet rsstk1111 = stmt.executeQuery(sql3);
	    	
	    	
	    	if(rsstk1111.next())
	    	{
	    		prdqty=rsstk1111.getDouble("prdqty");
		    	saveqty=prdqty-chkqtys;
		    	
		    	if(saveqty<0){
		    	saveqty=0;
		    	
		    	}
		    	
		      	String sql31="update my_prddin set del_qty="+saveqty+" where stockid='"+stkids+"'";
		    	 System.out.println("-----sql31-----"+sql31);
		    	 stmt.executeUpdate(sql31);
		    	 
		    	 	String sql34="delete from my_prddout  where stockid='"+stkids+"' and prdid='"+prdidss+"' and tr_no='"+tmptrno+"' and brhid="+session.getAttribute("BRANCHID").toString()+" and locid='"+locid+"' ";
			    //	System.out.println("-----sql34-----"+sql34);
			    	 stmt.executeUpdate(sql34);
		    	 
		    	 if(m==0)
		    	 {
		    		 tempstk=String.valueOf(stkids);	 
		    	 }
		    	 else
		    	 {
		    	 tempstkids=tempstk+","+stkids+",";
		    	 tempstk=tempstkids;
		    	 }
		    	 System.out.println("-----tempstkids-----"+tempstkids);
		    	 //System.out.println("========"+m+"-----tempstk-----"+tempstk);
		    	  
		    	
		    	 
		    	 if(tempstk.endsWith(","))
					{
		    		 tempstk = tempstk.substring(0,tempstk.length() - 1);
					}
	    		
	    		
	    	}
	    	}

	    	 
	     }
 

 

    	 
    	      String dql31="delete from my_deld where rdocno='"+deldocno+"'";
    	 	  stmt.executeUpdate(dql31);
    	 	 String dql32="delete from my_deldser where rdocno='"+deldocno+"'";
    	 	 stmt.executeUpdate(dql32);
   	 	 
    	 	 String dql33= "delete from my_trterms where rdocno='"+deldocno+"' and dtype='"+formcode+"' ";
    	 	 stmt.executeUpdate(dql33);
    	  
      	 	 String deltermssqls="delete from my_deldetaild where rdocno='"+deldocno+"' and  dtype='"+formcode+"'  ";
	    	 	stmt.executeUpdate(deltermssqls);
						}
						
						
						
						
 
						if(deldocno>0)
						{

							String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
							String specno=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
							String stkid=""+(prod[12].equalsIgnoreCase("undefined") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"";						 
							String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double masterqty=Double.parseDouble(rqty);
							 
							double foc=Double.parseDouble(""+(prod[14].trim().equalsIgnoreCase("undefined") || prod[14].trim().equalsIgnoreCase("NaN")|| prod[14].trim().equalsIgnoreCase("")|| prod[14].isEmpty()?0:prod[14].trim())+"");

							String qtyss=""+(prod[15].trim().equalsIgnoreCase("undefined") || prod[15].trim().equalsIgnoreCase("") || prod[15].trim().equalsIgnoreCase("NaN")|| prod[15].isEmpty()?0:prod[15].trim())+"";
							double masterqty1=Double.parseDouble(qtyss);
							double oldqty=Double.parseDouble(""+(prod[13].equalsIgnoreCase("undefined") || prod[13].equalsIgnoreCase("") || prod[13].trim().equalsIgnoreCase("NaN")|| prod[13].isEmpty()?0:prod[13].trim())+"");
							masterqty1=(masterqty1-oldqty)+masterqty;
							
							 System.out.println("---------masterqty-----------"+masterqty);
							 System.out.println("---------masterqty1-----------"+masterqty1);
							 System.out.println("---------oldqty-----------"+oldqty);
							
					
							 
							 
							//int stockid=Integer.parseInt(stkid);
							int method=0;
							String chk="select method  from gl_prdconfig where field_nme='prosearch_stock'";
							ResultSet rsconfiq=stmt.executeQuery(chk); 
							if(rsconfiq.next())
							{

								method=rsconfiq.getInt("method");
							}



							double balstkqty=0;
							int psrno=0;
							int stockid=0;
							double remstkqty=0;
							double outstkqty=0;
							double stkqty=0;
							double qty=0;
							double detqty=0;
							double delqtys=0;
							double ckkqty=0;
							double balstkqty=0;
							int psrno=0;
							int stockid=0;
							double remstkqty=0;
							double outstkqty=0;
							double stkqty=0;
							double qty=0;
							double detqty=0;
							double focmasterqty=0.0;
							Statement stmtstk=conn.createStatement();

							String stkSql="select stockid,psrno,specno,sum(op_qty) stkqty,sum((op_qty-(rsv_qty+out_qty+del_qty))) balstkqty,(rsv_qty+out_qty+del_qty) out_qty,del_qty as qty,date from my_prddin "
									+ "where    locid='"+locid+"' and psrno='"+prdid+"' and specno='"+specno+"' and prdid='"+prdid+"' and brhid="+session.getAttribute("BRANCHID").toString()+" "
									+ "group by stockid,prdid,psrno having sum((op_qty-(rsv_qty+out_qty+del_qty)))>0 order by date,stockid";

							System.out.println("=stkSql=inside insert="+stkSql);

							ResultSet rsstk = stmtstk.executeQuery(stkSql);

							while(rsstk.next()) {
								
								System.out.println("---masterqty-----"+masterqty);	
								System.out.println("---foc-----"+foc);	
								System.out.println("---focmasterqty-----"+focmasterqty);	
								
								focmasterqty=masterqty;
								balstkqty=rsstk.getDouble("balstkqty");
								psrno=rsstk.getInt("psrno");
								outstkqty=rsstk.getDouble("out_qty");
								stockid=rsstk.getInt("stockid");
								stkqty=rsstk.getDouble("stkqty");
								qty=rsstk.getDouble("qty");
									
								System.out.println("---masterqty-----"+masterqty);	
								System.out.println("---balstkqty-----"+balstkqty);	
								System.out.println("---out_qty-----"+outstkqty);	
								System.out.println("---stkqty-----"+stkqty);
								System.out.println("---qty-----"+qty);


								if(remstkqty>0)
								{

									focmasterqty=remstkqty;
								}

								   ckkqty=focmasterqty;
								
								
								
								if(focmasterqty<=balstkqty)
								{   
									focmasterqty=focmasterqty+qty;
									
									System.out.println("---focmasterqty-----"+focmasterqty);
									
									System.out.println("---qty-----"+qty);
									detqty=masterqty;

									String sqls="update my_prddin set del_qty="+focmasterqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" and brhid="+session.getAttribute("BRANCHID").toString()+"";
									System.out.println("--1---sqls---"+sqls);
									stmt.executeUpdate(sqls);
									delqtys=focmasterqty-qty;
									focmasterqty=ckkqty-focmasterqty-qty;
									
									System.out.println("---focmasterqty---111--"+focmasterqty);
									//break;


								}
								else if(focmasterqty>balstkqty)
								{



									if(stkqty>=(focmasterqty+outstkqty))

									{
										balstkqty=focmasterqty+qty;	
										remstkqty=stkqty-outstkqty;

										System.out.println("---balstkqty-1---"+balstkqty);
									}
									else
									{
										remstkqty=focmasterqty-balstkqty;
										balstkqty=stkqty-outstkqty+qty;
										System.out.println("--qty2---"+qty);
										System.out.println("---focmasterqty-2---"+focmasterqty);
											System.out.println("---outstkqty-2---"+outstkqty);
											System.out.println("---stkqty-2---"+stkqty);
											System.out.println("---remstkqty-2---"+remstkqty);
											System.out.println("---balstkqty--2--"+balstkqty);
									}
									detqty=stkqty-outstkqty;

									String sqls="update my_prddin set del_qty="+balstkqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" and brhid="+session.getAttribute("BRANCHID").toString()+"";	
									System.out.println("-2----sqls---"+sqls);

									stmt.executeUpdate(sqls);	
									delqtys=detqty;
									//remstkqty=masterqty-stkqty;



								}
								
								
								
								Double NtWtKG=0.0;
								Double KGPrice=0.0;
								Double unitprice=0.0;
								Double total=0.0;
								Double discper=0.0;
								Double discount=0.0;
								Double netotal=0.0;

								if(!rreftype.equalsIgnoreCase("DIR"))
								{
									
								
								 NtWtKG=Double.parseDouble(""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"");
								 KGPrice=Double.parseDouble(""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"");
								 unitprice=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");
								 total=detqty*unitprice;
								 discper=Double.parseDouble(""+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"");
								 discount=(total*discper)/100;
								 netotal=total-discount;
								}
								 System.out.println("==NtWtKG===="+NtWtKG);
								 
								 System.out.println("==KGPrice===="+KGPrice);
								 
								 System.out.println("==unitprice===="+unitprice);
								 
								 System.out.println("==total===="+total);
								 
								 System.out.println("==discper===="+discper);
								 
								 System.out.println("==discount===="+discount);
								 
								 System.out.println("==netotal===="+netotal);
								 
								
								String sql="insert into my_deld(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal,foc)VALUES"
										+ " ("+trno+","+(i+1)+",'"+deldocno+"',"
										+ "'"+stockid+"',"
										+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
										+ "'"+delqtys+"',"
										+ "'"+NtWtKG+"',"
										+ "'"+KGPrice+"',"
										+ "'"+unitprice+"',"
										+ "'"+total+"',"
										+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
										+ "'"+discount+"',"
										+ "'"+netotal+"',"
										+ "'"+foc+"')";

								System.out.println("branchper--->>>>Sql"+sql);
								prodet = stmt.executeUpdate (sql);

								
								
								double cost_price=0;
								
								String sqlsss="select cost_price from my_prddin where stockid="+stockid+" ";
								
								System.out.println("========"+sqlsss);
								
								ResultSet rssss=stmt.executeQuery(sqlsss);
								
								if(rssss.next())
								{
									cost_price=	rssss.getDouble("cost_price");
								}
								

								String prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid,date, specid, psrno,del_qty,prdid,brhid,locid) Values"
										+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"+deldocno+","
										+ "'"+stockid+"',"
										+ "'"+date+"',"
										+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+ "'"+delqtys+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"',"+locid+")";

								System.out.println("prodoutsql--->>>>Sql"+prodoutsql);
								prodout = stmt.executeUpdate (prodoutsql);

								if(masterqty<=balstkqty)
								{
									break;
								}
								
								if(focmasterqty<=0)
								{
									break;
								}
								

							}

								if(remstkqty>0)
								{

									masterqty=remstkqty;
								}


								if(masterqty<=balstkqty)
								{
									masterqty=masterqty+qty;
									detqty=masterqty;
									remstkqty=masterqty-remstkqty;
									String sqls="update my_prddin set del_qty="+masterqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" and brhid="+session.getAttribute("BRANCHID").toString()+"";
									System.out.println("--1---sqls---"+sqls);
									stmt.executeUpdate(sqls);
									//break;


								}
								else if(masterqty>balstkqty)
								{



									if(stkqty>=(masterqty+outstkqty))

									{
										balstkqty=masterqty+qty;	
										remstkqty=stkqty-outstkqty;

										System.out.println("---balstkqty-1---"+balstkqty);
									}
									else
									{
										remstkqty=masterqty-balstkqty;
										balstkqty=stkqty-outstkqty+qty;

										System.out.println("---masterqty-2---"+masterqty);
											System.out.println("---outstkqty-2---"+outstkqty);
											System.out.println("---stkqty-2---"+stkqty);
											System.out.println("---remstkqty-2---"+remstkqty);
											System.out.println("---balstkqty--2--"+balstkqty);
									}
									detqty=balstkqty;

									String sqls="update my_prddin set del_qty="+balstkqty+" where stockid="+stockid+" and prdid="+prdid+" and  psrno="+psrno+" and specno="+specno+" and brhid="+session.getAttribute("BRANCHID").toString()+"";	
									System.out.println("-2----sqls---"+sqls);

									stmt.executeUpdate(sqls);	

									//remstkqty=masterqty-stkqty;



								}
								
								Double NtWtKG=0.0;
								Double KGPrice=0.0;
								Double unitprice=0.0;
								Double total=0.0;
								Double discper=0.0;
								Double discount=0.0;
								Double netotal=0.0;
								
								 NtWtKG=Double.parseDouble(""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"");
								 KGPrice=Double.parseDouble(""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"");
								 unitprice=Double.parseDouble(""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"");
								 total=detqty*unitprice;
								 discper=Double.parseDouble(""+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"");
								 discount=(total*discper)/100;
								 netotal=total-discount;
								
	 
								
								String sql="insert into my_deld(tr_No,sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal)VALUES"
										+ " ("+trno+","+(i+1)+",'"+deldocno+"',"
										+ "'"+stockid+"',"
										+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
										+ "'"+masterqty1+"',"
										+ "'"+NtWtKG+"',"
										+ "'"+KGPrice+"',"
										+ "'"+unitprice+"',"
										+ "'"+total+"',"
										+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
										+ "'"+discount+"',"
										+ "'"+netotal+"')";

								System.out.println("branchper--->>>>Sql"+sql);
								prodet = stmt.executeUpdate (sql);


								String prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid,date, specid, psrno,del_qty,prdid,brhid,locid) Values"
										+ " ("+(i+1)+",'"+trno+"','"+formcode+"',"+deldocno+","
										+ "'"+stockid+"',"
										+ "'"+date+"',"
										+ "'"+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+ "'"+detqty+"',"
										+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
										+"'"+Integer.parseInt(session.getAttribute("BRANCHID").toString())+"',"+locid+")";

								System.out.println("prodoutsql--->>>>Sql"+prodoutsql);
								prodout = stmt.executeUpdate (prodoutsql);

								if(masterqty<=balstkqty)
								{
									break;
								}


							}





							if(rreftype.equalsIgnoreCase("SOR"))
							{

								
								
								Statement stmt2=conn.createStatement();
								 int pridforchk=Integer.parseInt(prdid);
						    	 
								  
						   		 
					    		 if(pridforchk!=updateid)
					    		 {
					    		 
					 			String sqls="update  my_sorderd set out_qty=0 where rdocno in ("+qotmasterdocno+") and prdid="+pridforchk+" and clstatus=0 ";
			  
			    			    System.out.println("-----"+sqls);
			    			   	
					 			stmt2.executeUpdate(sqls);
			    				
			    				updateid=pridforchk;
					    		 
					    		 }
								double balqty=0;
								int docno=0;
								int rdocno=0;
								double remqty=0;
								double out_qty=0;
								double qtys=0;

								Statement stmt1=conn.createStatement();

								String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_sorderm m  left join "
										+ "my_sorderd d on m.doc_no=d.rdocno where d.rdocno in ("+qotmasterdocno+") and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.prdid='"+prdid+"' and  d.clstatus=0 group by d.doc_no having  sum(d.qty-d.out_qty)>0 "
										+ "order by m.date,d.doc_no";

								System.out.println("---strSql-----"+strSql);
								ResultSet rs = stmt1.executeQuery(strSql);


								while(rs.next()) {


									balqty=rs.getDouble("balqty");
									rdocno=rs.getInt("rdocno");
									out_qty=rs.getDouble("out_qty");

									docno=rs.getInt("doc_no");
									qtys=rs.getDouble("qty");


									System.out.println("---masterqty1-----"+masterqty1);	
									System.out.println("---balqty-----"+balqty);	
									System.out.println("---out_qty-----"+out_qty);	
									System.out.println("---qtys-----"+qtys);


									if(remqty>0)
									{

										masterqty1=remqty;
									}


									if(masterqty1<=balqty)
									{
										masterqty1=masterqty1+out_qty;


										String sqls="update my_sorderd set out_qty="+masterqty1+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+" and clstatus=0";

										System.out.println("--1---sqls---"+sqls);


										stmt.executeUpdate(sqls);
										break;


									}
									else if(masterqty1>balqty)
									{



										if(qtys>=(masterqty1+out_qty))

										{
											balqty=masterqty1+out_qty;	
											remqty=qtys-out_qty;

											//	System.out.println("---remqty-1---"+remqty);
										}
										else
										{
											remqty=masterqty1-balqty;
											balqty=qtys;

											//System.out.println("---remqty--2--"+remqty);
										}


										String sqls="update my_sorderd set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+" and clstatus=0";	
										System.out.println("-2----sqls---"+sqls);

										stmt.executeUpdate(sqls);	

										//remqty=masterqty-qtys;



									}





								}  







							}



						}

					}

				}


				for(int i=0;i< servarray.size();i++){

					String[] sorderarray=((String) servarray.get(i)).split("::");
					if(!(sorderarray[1].trim().equalsIgnoreCase("undefined")|| sorderarray[1].trim().equalsIgnoreCase("NaN")||sorderarray[1].trim().equalsIgnoreCase("")|| sorderarray[1].isEmpty()))
					{

						String sql="INSERT INTO my_deldser(srno,qty,desc1,unitprice,total,discount,nettotal,brhid,rdocno)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(sorderarray[1].trim().equalsIgnoreCase("undefined") || sorderarray[1].trim().equalsIgnoreCase("NaN")|| sorderarray[1].trim().equalsIgnoreCase("")|| sorderarray[1].isEmpty()?0:sorderarray[1].trim())+"',"
								+ "'"+(sorderarray[2].trim().equalsIgnoreCase("undefined") || sorderarray[2].trim().equalsIgnoreCase("NaN")|| sorderarray[2].trim().equalsIgnoreCase("")|| sorderarray[2].isEmpty()?0:sorderarray[2].trim())+"',"
								+ "'"+(sorderarray[3].trim().equalsIgnoreCase("undefined") || sorderarray[3].trim().equalsIgnoreCase("NaN")||sorderarray[3].trim().equalsIgnoreCase("")|| sorderarray[3].isEmpty()?0:sorderarray[3].trim())+"',"
								+ "'"+(sorderarray[4].trim().equalsIgnoreCase("undefined") || sorderarray[4].trim().equalsIgnoreCase("NaN")||sorderarray[4].trim().equalsIgnoreCase("")|| sorderarray[4].isEmpty()?0:sorderarray[4].trim())+"',"
								+ "'"+(sorderarray[5].trim().equalsIgnoreCase("undefined") || sorderarray[5].trim().equalsIgnoreCase("NaN")||sorderarray[5].trim().equalsIgnoreCase("")|| sorderarray[5].isEmpty()?0:sorderarray[5].trim())+"',"
								+ "'"+(sorderarray[6].trim().equalsIgnoreCase("undefined") || sorderarray[6].trim().equalsIgnoreCase("NaN")||sorderarray[6].trim().equalsIgnoreCase("")|| sorderarray[6].isEmpty()?0:sorderarray[6].trim())+"',"
								+ "'"+session.getAttribute("BRANCHID").toString()+"',"
								+"'"+deldocno+"')";

						int resultSet2 = stmt.executeUpdate(sql);

					}	    

				}


				int termsdet=0;

				System.out.println("termsarray.size()==="+termsarray.size());

				for(int i=0;i< termsarray.size();i++){


					String[] terms=((String) termsarray.get(i)).split("::");

					if(!((terms[0].equalsIgnoreCase("0"))||(terms[0].equalsIgnoreCase("undefined")))){




						String termsql="insert into my_trterms(rdocno, termsid, conditions, status, dtype)VALUES"
								+ " ('"+deldocno+"',"
								+ "'"+(terms[0].equalsIgnoreCase("undefined") || terms[0].equalsIgnoreCase("") || terms[0].trim().equalsIgnoreCase("NaN")|| terms[0].isEmpty()?0:terms[0].trim())+"',"
								+ "'"+(terms[3].equalsIgnoreCase("undefined") || terms[3].equalsIgnoreCase("") || terms[3].trim().equalsIgnoreCase("NaN")|| terms[3].isEmpty()?0:terms[3].trim())+"',"
								+ "'3',"
								+ "'"+formcode+"')";


						System.out.println("termsdet--->>>>Sql"+termsql);
						termsdet = stmt.executeUpdate (termsql);

					}
				}

	
				
				for(int i=0;i< shiparray.size();i++){


					String[] shiparrays=((String) shiparray.get(i)).split("::");

			 

					 if(!(shiparrays[1].trim().equalsIgnoreCase("undefined")|| shiparrays[1].trim().equalsIgnoreCase("NaN")||shiparrays[1].trim().equalsIgnoreCase("")|| shiparrays[1].isEmpty()))
				     {


						String shipsql="insert into my_deldetaild (rdocno,shipdetid,refdocno,desc1,refno,date,brhid,status,dtype)VALUES"
								+ " ('"+deldocno+"','"+shipdocno+"',"
								+ "'"+(shiparrays[0].trim().equalsIgnoreCase("undefined") || shiparrays[0].trim().equalsIgnoreCase("") || shiparrays[0].trim().equalsIgnoreCase("NaN")|| shiparrays[0].isEmpty()?0:shiparrays[0].trim())+"',"
								+ "'"+(shiparrays[1].trim().equalsIgnoreCase("undefined") || shiparrays[1].trim().equalsIgnoreCase("") || shiparrays[1].trim().equalsIgnoreCase("NaN")|| shiparrays[1].isEmpty()?0:shiparrays[1].trim())+"',"
								+ "'"+(shiparrays[2].trim().equalsIgnoreCase("undefined") || shiparrays[2].trim().equalsIgnoreCase("") || shiparrays[2].trim().equalsIgnoreCase("NaN")|| shiparrays[2].isEmpty()?0:shiparrays[2].trim())+"',"
								+ "'"+(shiparrays[3].trim().equalsIgnoreCase("undefined") || shiparrays[3].trim().equalsIgnoreCase("") || shiparrays[3].trim().equalsIgnoreCase("NaN")|| shiparrays[3].isEmpty()?0:ClsCommon.changetstmptoSqlDate(shiparrays[3].trim()))+"',"
							   + "'"+session.getAttribute("BRANCHID").toString()+"',"
								+ "'3',"
								+ "'"+formcode+"')";


					//	System.out.println("termsdet--->>>>Sql"+termsql);
					int	retdoc = stmt.executeUpdate(shipsql);
						
						 if(retdoc<=0)
							{
								conn.close();
								return 0;
								
							}

					}
				}
				
				
				String updatesql="update my_delm set shipdetid='"+shipdocno+"' where doc_no='"+deldocno+"' ";
				
				stmt.executeUpdate (updatesql);
				

			}
				  
			}
				
				
				if(deldocno>0)
				{
					conn.commit();		
					return deldocno;
				}
		}
	catch(Exception e){
		deldocno=0;
		e.printStackTrace();
	}
	finally{
		conn.close();
	}

	return deldocno;
}
*/
public int delete(String voc_no,int doc_no,java.sql.Date date,String refno,String pricegroup,String curr,String currate,int salesid,int clientid,String rrefno,String rreftype,String locid,String desc,
		String prodamt,String descount,String nettotal,String servamt,String roundof,String finalamt,String mode,String formcode,ArrayList prodarray,ArrayList termsarray,ArrayList servarray,HttpSession session,HttpServletRequest request,String qotmasterdocno,String descper) throws SQLException{

	Connection conn=null;
	int deldocno=0;
	conn=ClsConnection.getMyConnection();

	try{

		conn.setAutoCommit(false);

		CallableStatement stmt = conn.prepareCall("{CALL deliveryNoteDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


		stmt.setDate(1,date);
		stmt.setString(2,refno);
		stmt.setInt(3, clientid);
		stmt.setInt(4, Integer.parseInt(curr));
		stmt.setDouble(5, Double.parseDouble(currate));
		stmt.setInt(6, salesid);
		stmt.setString(7,rreftype);
		stmt.setString(8,rrefno);
		stmt.setString(9,locid);
		stmt.setString(10,desc);
		stmt.setDouble(11,Double.parseDouble(prodamt));
		stmt.setDouble(12,Double.parseDouble(descount));
		stmt.setDouble(13,Double.parseDouble(nettotal));
		stmt.setString(14,mode);
		stmt.setString(15,formcode);
		stmt.setString(16, session.getAttribute("USERID").toString());
		stmt.setString(17, session.getAttribute("BRANCHID").toString());
		stmt.setString(18, session.getAttribute("COMPANYID").toString());
		stmt.setDouble(19, Double.parseDouble(descper));
		stmt.setDouble(20, Double.parseDouble(servamt));
		stmt.setDouble(21, Double.parseDouble(roundof));
		stmt.setDouble(22, Double.parseDouble(finalamt));
		stmt.setInt(23, Integer.parseInt(pricegroup));
		stmt.setInt(24,doc_no);
		stmt.setInt(25,Integer.parseInt(voc_no));
		int val = stmt.executeUpdate();
		deldocno=stmt.getInt("deldocno");
		int vocno=stmt.getInt("vdocNo");	
		request.setAttribute("vdocNo", vocno);
		//System.out.println("===vocno====="+vocno);
		/*			if(vocno>0){

				int prodet=0;
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){




						String sql="insert into my_deld(sr_no,rdocno,stockid,specno, psrno, prdId,UNITID, qty,NtWtKG,KGPrice, amount, total, disper, discount, nettotal)VALUES"
								+ " ("+(i+1)+",'"+deldocno+"',"
								+ "'"+(prod[12].equalsIgnoreCase("undefined")|| prod[12].equalsIgnoreCase("null") || prod[12].equalsIgnoreCase("") || prod[12].trim().equalsIgnoreCase("NaN")|| prod[12].isEmpty()?0:prod[12].trim())+"',"
								+ "'"+(prod[10].equalsIgnoreCase("undefined")|| prod[10].equalsIgnoreCase("null") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
								+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("null")|| prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
								+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("null")|| prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
								+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("null")|| prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
								+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("null")|| prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
								+ "'"+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("null")|| prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
								+ "'"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("null")|| prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"',"
								+ "'"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("null")|| prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"',"
								+ "'"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("null")|| prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
								+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("null")|| prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
								+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("null")|| prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"',"
								+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("null")|| prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"')";


						System.out.println("branchper--->>>>Sql"+sql);
						prodet = stmt.executeUpdate (sql);


						if(prodet>0)
						{

							String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";						     							  
							//String entrytype=""+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].trim().equalsIgnoreCase("")|| prod[9].isEmpty()?0:prod[9].trim())+"";						 
							String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined")|| prod[2].trim().equalsIgnoreCase("null") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double masterqty=Double.parseDouble(rqty);

							if(rreftype.equalsIgnoreCase("SQOT"))
							{

								double balqty=0;
								int docno=0;
								int rdocno=0;
								double remqty=0;
								double out_qty=0;
								double qty=0;

								Statement stmt1=conn.createStatement();

								String strSql="select d.qty qty,sum((d.qty-d.out_qty)) balqty,d.doc_no,d.rdocno,d.out_qty out_qty,d.prdid  from my_delm m  left join "
										+ "my_deld d on m.doc_no=d.rdocno where d.rdocno in ("+qotmasterdocno+") and  m.brhid="+session.getAttribute("BRANCHID").toString()+" and d.prdid='"+prdid+"' group by d.doc_no having  sum(d.qty-d.out_qty)>0 "
										+ "order by m.date,d.doc_no";

								System.out.println("---strSql-----"+strSql);
								ResultSet rs = stmt1.executeQuery(strSql);


								while(rs.next()) {


									balqty=rs.getDouble("balqty");
									rdocno=rs.getInt("rdocno");
									out_qty=rs.getDouble("out_qty");

									docno=rs.getInt("doc_no");
									qty=rs.getDouble("qty");

									System.out.println("---masterqty-----"+masterqty);	

									System.out.println("---balqty-----"+balqty);	

									System.out.println("---out_qty-----"+out_qty);	
									System.out.println("---qty-----"+qty);


									if(remqty>0)
									{

										masterqty=remqty;
									}


									if(masterqty<=balqty)
									{
										masterqty=masterqty+out_qty;


										String sqls="update my_qotd set out_qty="+masterqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";

										System.out.println("--1---sqls---"+sqls);


										stmt.executeUpdate(sqls);
										break;


									}
									else if(masterqty>balqty)
									{



										if(qty>=(masterqty+out_qty))

										{
											balqty=masterqty+out_qty;	
											remqty=qty-out_qty;

											//	System.out.println("---remqty-1---"+remqty);
										}
										else
										{
											remqty=masterqty-balqty;
											balqty=qty;

											//System.out.println("---remqty--2--"+remqty);
										}


										String sqls="update my_qotd set out_qty="+balqty+" where rdocno="+rdocno+" and prdid="+prdid+" and  doc_no="+docno+"";	
										System.out.println("-2----sqls---"+sqls);

										stmt.executeUpdate(sqls);	

										//remqty=masterqty-qty;



									}


								}  







							}



						}

					}

				}


				for(int i=0;i< servarray.size();i++){

					String[] sorderarray=((String) servarray.get(i)).split("::");
					if(!(sorderarray[1].trim().equalsIgnoreCase("undefined")|| sorderarray[1].trim().equalsIgnoreCase("NaN")||sorderarray[1].trim().equalsIgnoreCase("")|| sorderarray[1].isEmpty()))
					{

						String sql="INSERT INTO my_deldser(srno,qty,desc1,unitprice,total,discount,nettotal,brhid,rdocno)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(sorderarray[1].trim().equalsIgnoreCase("undefined") || sorderarray[1].trim().equalsIgnoreCase("NaN")|| sorderarray[1].trim().equalsIgnoreCase("")|| sorderarray[1].isEmpty()?0:sorderarray[1].trim())+"',"
								+ "'"+(sorderarray[2].trim().equalsIgnoreCase("undefined") || sorderarray[2].trim().equalsIgnoreCase("NaN")|| sorderarray[2].trim().equalsIgnoreCase("")|| sorderarray[2].isEmpty()?0:sorderarray[2].trim())+"',"
								+ "'"+(sorderarray[3].trim().equalsIgnoreCase("undefined") || sorderarray[3].trim().equalsIgnoreCase("NaN")||sorderarray[3].trim().equalsIgnoreCase("")|| sorderarray[3].isEmpty()?0:sorderarray[3].trim())+"',"
								+ "'"+(sorderarray[4].trim().equalsIgnoreCase("undefined") || sorderarray[4].trim().equalsIgnoreCase("NaN")||sorderarray[4].trim().equalsIgnoreCase("")|| sorderarray[4].isEmpty()?0:sorderarray[4].trim())+"',"
								+ "'"+(sorderarray[5].trim().equalsIgnoreCase("undefined") || sorderarray[5].trim().equalsIgnoreCase("NaN")||sorderarray[5].trim().equalsIgnoreCase("")|| sorderarray[5].isEmpty()?0:sorderarray[5].trim())+"',"
								+ "'"+(sorderarray[6].trim().equalsIgnoreCase("undefined") || sorderarray[6].trim().equalsIgnoreCase("NaN")||sorderarray[6].trim().equalsIgnoreCase("")|| sorderarray[6].isEmpty()?0:sorderarray[6].trim())+"',"
								+ "'"+session.getAttribute("BRANCHID").toString()+"',"
								+"'"+deldocno+"')";

						int resultSet2 = stmt.executeUpdate(sql);

					}	    

				}


				int termsdet=0;

				System.out.println("termsarray.size()==="+termsarray.size());

				for(int i=0;i< termsarray.size();i++){


					String[] terms=((String) termsarray.get(i)).split("::");

					if(!((terms[0].equalsIgnoreCase("0"))||(terms[0].equalsIgnoreCase("undefined")))){




						String termsql="insert into my_trterms(rdocno, termsid, conditions, status, dtype)VALUES"
								+ " ('"+deldocno+"',"
								+ "'"+(terms[0].equalsIgnoreCase("undefined") || terms[0].equalsIgnoreCase("") || terms[0].trim().equalsIgnoreCase("NaN")|| terms[0].isEmpty()?0:terms[0].trim())+"',"
								+ "'"+(terms[3].equalsIgnoreCase("undefined") || terms[3].equalsIgnoreCase("") || terms[3].trim().equalsIgnoreCase("NaN")|| terms[3].isEmpty()?0:terms[3].trim())+"',"
								+ "'3',"
								+ "'"+formcode+"')";


						System.out.println("termsdet--->>>>Sql"+termsql);
						termsdet = stmt.executeUpdate (termsql);

					}
				}


			}*/



	//	conn.commit();
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}

	return deldocno;
}


public   JSONArray reloadserviceGrid(String docno) throws SQLException {

	JSONArray RESULTDATA=new JSONArray();


	Connection conn = null;
	try {
		conn = ClsConnection.getMyConnection();
		Statement stmtVeh1 = conn.createStatement ();
		String pySql=(" select srno,desc1 description,unitprice,qty,total,discount,nettotal from my_deldser  where rdocno='"+docno+"' ");
		//System.out.println("========"+pySql);
		ResultSet resultSet = stmtVeh1.executeQuery(pySql);

		RESULTDATA=ClsCommon.convertToJSON(resultSet); 
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


public    ClsphysicalStockadjustmentBean getPrint(int docno, HttpServletRequest request) throws SQLException {
	ClsphysicalStockadjustmentBean bean = new ClsphysicalStockadjustmentBean();
	  Connection conn = null;
	try {
			 conn = ClsConnection.getMyConnection();

			  ClsAmountToWords c = new ClsAmountToWords();
			 
			Statement stmtprint = conn.createStatement ();
       	
/*				String resql=("select m.rdtype,if(m.rdtype!='DIR',m.rrefno,'') rrefno,if(m.rdtype='DIR','Direct',if(m.rdtype='CEQ','Sales Enquiry','Sales Quotation')) type,m.doc_no,m.voc_no,m.refno,"
					+ " DATE_FORMAT(m.date,'%d.%m.%Y') AS date,h.description descs,h.account,m.acno,m.curId,m.rate,m.amount,m.disstatus,m.disper, \r\n" + 
			" m.discount,m.roundVal,round(m.netAmount,2) netAmount,round(m.supplExp,2) supplExp,round(m.nettotal,2) nettotal,m.prddiscount,m.delterms,m.payterms,m.description,DATE_FORMAT(m.deldate,'%d.%m.%Y') deldate   \r\n" + 
			" from my_qotm m left join my_head h on h.doc_no=m.acno   where   m.doc_no='"+docno+"'");
			*/
			
			String resql=("select l.loc_name location,coalesce(mm.sal_name,'') sal_name,m.ref_type rdtype,if(m.ref_type!='DIR',m.rrefno,'') rrefno,if(m.ref_type='DIR','Direct','Sales Order') type, "
					+ " m.doc_no,m.voc_no,m.refno, DATE_FORMAT(m.date,'%d.%m.%Y') AS date,h.description descs,h.account,m.acno,m.curId,m.rate,m.amount,m.disper,"
					+ " m.discount,round(m.netAmount,2) netAmount,m.delterms,m.payterms,m.description "
			+ "  from my_delm m left join my_head h on h.doc_no=m.acno left join my_salm mm on mm.doc_no=m.sal_id left join my_locm l on l.doc_no=m.locid  where   m.doc_no='"+docno+"'");
			
			
			ResultSet pintrs = stmtprint.executeQuery(resql);
			
	 
		       while(pintrs.next()){
		    	
		    	    bean.setLbldoc(pintrs.getInt("voc_no"));
		    	    bean.setLbldate(pintrs.getString("date"));
		    	    bean.setLblrefno(pintrs.getString("refno"));
		    	    bean.setLbldesc1(pintrs.getString("description"));
		    	    bean.setLbllocation1(pintrs.getString("location"));
		    	    bean.setLbldelterms(pintrs.getString("delterms"));
		    	    bean.setLbltype(pintrs.getString("type"));
		    	    bean.setLblvendoeacc(pintrs.getString("account"));  
		    	    bean.setLblvendoeaccName(pintrs.getString("descs"));
		    	    
		    	    
		    	    bean.setLblsalesPerson(pintrs.getString("sal_name"));
 
		    	    
		    	  
		       }
			

			stmtprint.close();
			
			
			
			 Statement stmt10 = conn.createStatement ();
			    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from my_delm r  "
			    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
			    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";


		         ResultSet resultsetcompany = stmt10.executeQuery(companysql); 
			       
			       while(resultsetcompany.next()){
			    	   
			    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
			    	   bean.setLblcompname(resultsetcompany.getString("company"));
			    	  
			    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
			    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
			    	  
			    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
			    	   bean.setLbllocation(resultsetcompany.getString("location"));
			    	  
			    	   
			    	   
			       } 
			     stmt10.close();
			       
			    
						
			     ArrayList<String> arr =new ArrayList<String>();
			   	 Statement stmtgrid = conn.createStatement();       
			     String temp="";  
			       String	strSqldetail="Select d.specno specid ,m.part_no productid,m.productname, u.unit,round(sum(d.qty),2) qty    from my_deld d "
       			+ " left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no    where d.rdocno='"+docno+"' group by d.prdId";
				
			        
			       
				ResultSet rsdetail=stmtgrid.executeQuery(strSqldetail);
				
				int rowcount=1;
		
				while(rsdetail.next()){
					 
						 
						temp=rowcount+"::"+rsdetail.getString("productid")+"::"+rsdetail.getString("productname")+"::"+
						rsdetail.getString("unit")+"::"+rsdetail.getString("qty") ;
						arr.add(temp);
						rowcount++;
		
						bean.setFirstarray(1);
					
			          }
			             
				request.setAttribute("details", arr);
				stmtgrid.close();
				
				
				
				 
				 
			
			conn.close();



			
	}
	catch(Exception e){
		conn.close();
		e.printStackTrace();
	}
	return bean;
	

}



public   JSONArray deldetailsSearch() throws SQLException {

	JSONArray RESULTDATA=new JSONArray();

	Connection conn = null;

	try {
		conn = ClsConnection.getMyConnection();
		Statement stmtVeh = conn.createStatement (); 


		String sql="select doc_no,desc1 from  my_deldetailm where status=3; ";
		// System.out.println("-----sql---"+sql);

		ResultSet resultSet = stmtVeh.executeQuery (sql);
		RESULTDATA=ClsCommon.convertToJSON(resultSet);
		stmtVeh.close();
		conn.close();

	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	//System.out.println(RESULTDATA);
	return RESULTDATA;
}

public   JSONArray reloadshipSearch(HttpSession session,String masterdocno,String formcode) throws SQLException {

	JSONArray RESULTDATA=new JSONArray();

	Connection conn = null;

	try {
		conn = ClsConnection.getMyConnection();
		Statement stmtVeh = conn.createStatement (); 


		String sql="select   refdocno doc_nos, desc1, refno, date from  my_deldetaild where status=3 and rdocno='"+masterdocno+"' and dtype='"+formcode+"' ";
	  System.out.println("-----sql---"+sql);

		ResultSet resultSet = stmtVeh.executeQuery (sql);
		RESULTDATA=ClsCommon.convertToJSON(resultSet);
		stmtVeh.close();
		conn.close();

	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	//System.out.println(RESULTDATA);
	return RESULTDATA;
}


public JSONArray shipsearchFrom(String clname,String mob) throws SQLException {


	JSONArray RESULTDATA=new JSONArray();  

	Connection conn = null;

	try {
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();     
		String sqltest="";

		if(!(clname.equalsIgnoreCase(""))){
			sqltest=sqltest+" and if(m.type=0,m.clname,ac.refname) like '%"+clname+"%'";
		}
		if(!(mob.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.mob like '%"+mob+"%'";
		}

 
		String sql=" select m.doc_no,m.type,m.cldocno,if(m.type=0,m.clname,ac.refname) clname, m.claddress,m.contactperson, m.tel, "
				+ " m.mob, m.email, m.fax from my_shipdetails m  left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM'  "
				+ " where  m.status=3 and m.type>0  " +sqltest;

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

