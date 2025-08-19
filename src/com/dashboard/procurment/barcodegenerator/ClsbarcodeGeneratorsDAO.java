package com.dashboard.procurment.barcodegenerator;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsbarcodeGeneratorsDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	public JSONArray brandSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,brand from my_brand where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	
	public JSONArray suitbrandSearch1(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

		 	String sql="select convert(doc_no,char(50)) as doc_no,brand from (select '' doc_no ,'' brand union all  select doc_no,brand from my_sbrand where status=3  ) as a ";
			 
			 
		//	 System.out.println("=========sql===="+sql);
			 
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	
	public JSONArray suitbrandSearch(HttpSession session,String yomfrm,String yomto) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

		//	String sql="select convert(doc_no,char(50)) as doc_no,brand from (select '' doc_no ,'' brand union all  select doc_no,brand from my_sbrand where status=3  ) as a ";
			 String sql = " select convert('',char(20)) doc_no ,'' brand  union all  select convert(b.doc_no,char(20)) doc_no, b.brand  from my_sbrand b	left join my_syom f on f.doc_no= b.frmyomid "
					 +"		left join my_syom t on t.doc_no= b.toyomid where   b.status=3 and b.frmyomid>0  and f.yom<='"+yomfrm+"' and  "
					 +"	   t.yom>='"+yomto+"'  ";
			 
		//	 System.out.println("=========sql===="+sql);
			 
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	public JSONArray suitmodelSearch(HttpSession session,String brandid,String yomfrm,String  yomto) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			
			//String sql="select convert(doc_no,char(50)) as doc_no,model,brand from ( select '' doc_no ,'' model,'' brand union all select m.doc_no,model,brand from my_smodel m left join my_sbrand b on(m.brandid=b.doc_no) where b.status=3 and m.status=3 and m.brandid='"+brandid+"' ) as a";
			
			 String sql = "select '' model,convert('',char(20)) doc_no ,'' brand  union all   select b.model,convert(b.doc_no,char(20)) doc_no,m.brand from my_smodel b left join my_sbrand m on(b.brandid=m.doc_no) 	left join my_syom f on f.doc_no= b.frmyomid "
					 +"		left join my_syom t on t.doc_no= b.toyomid where   b.status=3 and b.brandid='"+brandid+"' and b.frmyomid>0  and f.yom<='"+yomfrm+"' and   t.yom>='"+yomto+"'  ";
		//	System.out.println("===modelSearch===="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray subModelSearch(HttpSession session,String brandid,String modelid,String yomfrm,String yomto) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			 String sql="select convert('',char(50)) as doc_no,'' submodel,'' model union all select convert(doc_no,char(50)) as doc_no,submodel,model from "
						+ "( select  convert(m.doc_no,char(50)) as doc_no,submodel,model from my_ssubmodel m left join my_smodel mo "
						+ "on(m.modelid=mo.doc_no) left join my_syom f on f.doc_no= m.frmyomid "
						 +"		left join my_syom t on t.doc_no= m.toyomid where mo.status=3 and m.status=3 and"
						 + "   m.brandid="+brandid+" and m.modelid='"+modelid+"'   and f.yom<='"+yomfrm+"' and  "
						+"	   t.yom>='"+yomto+"'  ) as a";
			
		/*	String sql="select convert(doc_no,char(50)) as doc_no,submodel,model from "
					+ "(  select '' doc_no ,'' submodel,'' model union all select m.doc_no,submodel,model from my_ssubmodel m left join my_smodel mo "
					+ "on(m.modelid=mo.doc_no) where mo.status=3 and m.status=3 and m.modelid="+modelid+""
					+ " and m.brandid="+brandid+" ) as a";*/
		//	System.out.println("===subModelSearch===="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public JSONArray yomSearch(HttpSession session,String type,String yomfrm,String yomto) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql="";
			String sqlappend="";
			if(!(yomfrm.equalsIgnoreCase(""))){
				sqlappend=sqlappend+" and date_format(str_to_date(yom,'%Y'),'%Y')>="+yomfrm+" ";
			}
			String joinsql="";
	 
			
			if(type.equalsIgnoreCase("frm"))
			{
			 
				
				sql="select convert('',char(20)) doc_no,'' yom,'' desc1 union all   select  convert(y.doc_no,char(20)) doc_no,y.yom,y.desc1 from my_syom  y  where y.status=3 order by desc1;"; 
				
			 
			}
			else if(type.equalsIgnoreCase("to"))
			 
			{
				
		 
				sql="  select  doc_no,yom,desc1 from (select convert('',char(20)) doc_no,'' yom,'' desc1 union all select  convert(doc_no,char(20)) doc_no,yom,desc1 from my_syom where desc1='0' "
						+ "	 union all  (select  convert(doc_no,char(20)) doc_no,yom,desc1 from my_syom where status=3 "+sqlappend+" ))a order by a.desc1 ";
			 
			}
			
	// System.out.println("=======sql==="+sql);

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	public JSONArray yomSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select doc_no,yom from my_syom where status=3";
			String sql="select convert(doc_no,char(50)) as doc_no,yom from ( select '' doc_no ,'' yom  union all  select doc_no,yom from my_syom where status=3 union all select '-1','ALL') as a";
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray suitSpec1Search(HttpSession session,String brandid,String modelid,String submodelid,String yomfrm,String  yomto) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select doc_no,spec from my_suitspec1 where status=3";
		//	String sql="select convert(doc_no,char(50)) as doc_no,spec from ( select '' doc_no ,'' spec  union all   select doc_no,spec from my_suitspec1 where status=3 and brandid="+brandid+" and  modelid="+modelid+" and  submodelid="+submodelid+") as a";
			
			String sql=" select convert('',char(20)) doc_no ,'' spec  union all  select convert(s.doc_no,char(20)) doc_no,s.spec from my_suitspec1 s left join my_syom f on f.doc_no= s.frmyomid "
						 +"		left join my_syom t on t.doc_no= s.toyomid where s.status=3 and  "
					+ " s.brandid="+brandid+" and  s.modelid="+modelid+" and  s.submodelid="+submodelid+" and f.yom<='"+yomfrm+"' and  "
						+"	   t.yom>='"+yomto+"' " ;
			
			//System.out.println("=========sql====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray suitSpec2Search(HttpSession session,String brandid,String modelid,String submodelid,String yomfrm,String  yomto) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select doc_no,spec from my_suitspec2 where status=3";
		//	String sql="select convert(doc_no,char(50)) as doc_no,spec from (select '' doc_no ,'' spec  union all select doc_no,spec from my_suitspec2 where status=3 and brandid="+brandid+" and  modelid="+modelid+" and  submodelid="+submodelid+") as a";
			
			
			
			String sql=" select convert('',char(20)) doc_no ,'' spec  union all  select convert(s.doc_no,char(20)) doc_no,s.spec from my_suitspec2 s left join my_syom f on f.doc_no= s.frmyomid "
					 +"		left join my_syom t on t.doc_no= s.toyomid where s.status=3 and  "
				+ " s.brandid="+brandid+" and  s.modelid="+modelid+" and  s.submodelid="+submodelid+" and f.yom<='"+yomfrm+"' and  "
					+"	   t.yom>='"+yomto+"' " ;
		//	System.out.println("=========sql====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray suitSpec3Search(HttpSession session,String brandid,String modelid,String submodelid,String yomfrm,String  yomto) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select doc_no,spec from my_suitspec3 where status=3";
			//String sql="select convert(doc_no,char(50)) as doc_no,spec from ( select '' doc_no ,'' spec  union all select doc_no,spec from my_suitspec3 where status=3 and brandid="+brandid+" and  modelid="+modelid+" and  submodelid="+submodelid+") as a";
			
			
			String sql=" select convert('',char(20)) doc_no ,'' spec  union all  select convert(s.doc_no,char(20)) doc_no,s.spec from my_suitspec3 s left join my_syom f on f.doc_no= s.frmyomid "
					 +"	left join my_syom t on t.doc_no= s.toyomid where s.status=3 and  "
					 + " s.brandid="+brandid+" and  s.modelid="+modelid+" and  s.submodelid="+submodelid+" and f.yom<='"+yomfrm+"' and  "
					 +"	 t.yom>='"+yomto+"' " ;
			
		//	System.out.println("=========sql====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray typeSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,producttype ptype from my_ptype where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray productSearch(HttpSession session,String brandid,String catid,String subcatid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql1="";
			//System.out.println("brandid===="+brandid);
			if(!(brandid.equalsIgnoreCase("0") || brandid.equalsIgnoreCase(""))){
				sql1="and b.doc_no in ("+brandid+")";
			}

			String sql2="";
			//System.out.println("brandid===="+brandid);
			if(!(catid.equalsIgnoreCase("0") || catid.equalsIgnoreCase(""))){
				sql2="and c.doc_no in ("+catid+")";
			}

			String sql3="";
			//System.out.println("brandid===="+brandid);
			if(!(subcatid.equalsIgnoreCase("0") || subcatid.equalsIgnoreCase(""))){
				sql3="and s.doc_no in ("+subcatid+")";
			}


			String sql="select m.doc_no,m.part_no prodcode,m.productname prodname,b.brand from my_main m inner join my_brand b on(m.brandid=b.doc_no)"
					+ "inner join my_catm c on(m.catid=c.doc_no) inner join my_scatm s on(m.scatid=s.doc_no) inner join my_desc aa on aa.psrno=m.psrno  where aa.discontinued=0 and m.status=3  "+sql1+" "+sql2+" "+sql3+"";
			//System.out.println("==productSearch==="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray catSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select category cat,doc_no  from my_catm where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray deptSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select department dept, doc_no from my_dept where status<>7";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray subCatSearch(HttpSession session,String catid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select subcategory subcat,s.doc_no,category cat  from my_scatm s inner join my_catm c on(c.doc_no=s.catid) and c.doc_no in ("+catid+")";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	public JSONArray partSearch1(HttpSession session,String type,String hidsbrand,String hidsmodel,
			String hidyom,String hidspec1,String hidspec2,String hidspec3,String hidbrand,String hidtype,String hidcat,
			String hidsubcat,String hidproduct,String branchid,String hidept,String suitid,String hidsubmodel,String gridtype,String load
			,String brandid1,String modelid1,String submodelid1,String yomid1,String spec1id1,String spec2id1,String spec3id1) throws SQLException {


 	
		System.out.println("===brandid1===="+brandid1);
		System.out.println("===modelid1===="+modelid1);
		System.out.println("===submodelid1===="+submodelid1);
		System.out.println("===yomid1===="+yomid1);
		System.out.println("===spec1id1===="+spec1id1);
		System.out.println("===spec2id1===="+spec2id1);
		System.out.println("===spec3id1===="+spec3id1); 
		
		JSONArray RESULTDATA=new JSONArray();

	//	System.out.println("===load===="+load);
		
		if(!(load.equalsIgnoreCase("load")))
		{
			return RESULTDATA;
		}
		
		
		Connection conn = null;

		try {
		//	System.out.println("===gridtype======="+gridtype);
			
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String minyom="",maxyom="";
			String sql ="";
			String brsql ="";
			if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equalsIgnoreCase("undefined")|| branchid.equalsIgnoreCase("a"))){
				brsql="and brhid in ("+branchid+")";
			}
			String joinsql="    ";
			String selectjoinsql="   ";
			if(gridtype.equalsIgnoreCase("cal"))
			{
				  joinsql="  left join (select sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty,prdid  from  my_prddin  where 1=1 "+brsql+" group by psrno) s   on s.prdid=m.doc_no ";
				  selectjoinsql="  convert(if(coalesce(s.stkqty,0)=0,'',coalesce(s.stkqty,0)),char(100)) stkqty,";	
			}
			
			String sqlwhere="    ";
			
		 
			if(!(brandid1.equalsIgnoreCase("0") || brandid1.equalsIgnoreCase("")  || brandid1.equalsIgnoreCase("undefined") )){
				sqlwhere= sqlwhere + "and vs.sbrandid = "+brandid1+" ";
			}
			if(!(modelid1.equalsIgnoreCase("0") || modelid1.equalsIgnoreCase("")  || modelid1.equalsIgnoreCase("undefined") )){
				sqlwhere= sqlwhere + "and vs.smodelid ="+modelid1+" ";
			}
			
			if(!(submodelid1.equalsIgnoreCase("0") || submodelid1.equalsIgnoreCase("")  || submodelid1.equalsIgnoreCase("undefined") )){
				sqlwhere= sqlwhere + "and vs.submodelid  ="+submodelid1+" ";
			}
			
			
 		if(!(yomid1.equalsIgnoreCase("0") || yomid1.equalsIgnoreCase("")  || brandid1.equalsIgnoreCase("yomid1") )){
				 
						 
						
						sqlwhere= sqlwhere + "	 and if(coalesce(s.syomto_id,0)<=0,s.syomfrm_id<="+yomid1+","+yomid1+" between coalesce(s.syomfrm_id,0) "
								+ "  and coalesce(s.syomto_id,0))    and y1.yom is not null  " ;
			}
			 
			
			if(!(spec2id1.equalsIgnoreCase("0") || spec2id1.equalsIgnoreCase("")  || spec2id1.equalsIgnoreCase("undefined") )){
			 
				sqlwhere= sqlwhere + "and vs.esizeid="+spec2id1+" ";
			}
			
			
			if(!(spec1id1.equalsIgnoreCase("0") || spec1id1.equalsIgnoreCase("")  || spec1id1.equalsIgnoreCase("undefined") )){
				
				sqlwhere= sqlwhere + "and ((s.bsize1id=0 and  s.bsize2id=0  and s.bsize3id=0 )  or ( s.bsize1id="+spec1id1+" or  s.bsize2id="+spec1id1+"  or s.bsize3id="+spec1id1+" ))    ";
				
			}
			
			
			if(!(spec3id1.equalsIgnoreCase("0") || spec3id1.equalsIgnoreCase("")  || spec3id1.equalsIgnoreCase("undefined") )){
				
				sqlwhere= sqlwhere + "and ((s.csize1id=0 and  s.csize2id=0  and s.csize3id=0)  or (s.csize1id="+spec3id1+" or  s.csize2id="+spec3id1+"  or s.csize3id="+spec3id1+" ))    ";
				 
			}
			
			
		/*	,brandid1,modelid1,submodelid1,yomid1,spec1id1,spec2id1,spec3id1
			*/
			
			//System.out.println("==hidsbrand==="+hidsbrand+"==hidsmodel=="+hidsmodel+"==hidyom==="+hidyom+"=hidspec1=="+hidspec1+"==hidspec2=="+hidspec2+"==hidspec3=="+hidspec3+"==hidbrand==="+hidbrand+"==hidcat==="+hidcat+"==hidsubcat=="+hidsubcat+"==hidproduct="+hidproduct);


			String sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sqlfinal="";

			if(!(hidsbrand.equalsIgnoreCase("0") || hidsbrand.equalsIgnoreCase("") || hidsbrand.equalsIgnoreCase("undefined"))){
				if(hidsbrand.equalsIgnoreCase("-1")){
					sql1="and vs.sbrandid in ("+hidsbrand+")";
				}
				else{
					sql1="and sb.doc_no in ("+hidsbrand+")";
				}

			}

			if(!(hidsmodel.equalsIgnoreCase("0") || hidsmodel.equalsIgnoreCase("") || hidsmodel.equalsIgnoreCase("undefined"))){
				if(hidsmodel.equalsIgnoreCase("-1")){
					sql2="and vs.smodelid in ("+hidsmodel+")";
				}
				else{
					sql2="and sm.doc_no in ("+hidsmodel+")";
				}
			}


			if(!(hidsubmodel.equalsIgnoreCase("0") || hidsmodel.equalsIgnoreCase("") || hidsubmodel.equalsIgnoreCase("undefined"))){
				if(hidsubmodel.equalsIgnoreCase("-1")){
					sql2="and vs.submodelid in ("+hidsubmodel+")";
				}
				else{
					sql2="and sbm.doc_no in ("+hidsubmodel+")";
				}
			}

			if(!(hidyom.equalsIgnoreCase("0") || hidyom.equalsIgnoreCase("") || hidyom.equalsIgnoreCase("undefined"))){

				if(hidyom.equalsIgnoreCase("-1")){
					sql3 ="and s.syomfrm_id in ("+hidyom+") or s.syomto_id in ("+hidyom+")";
				}
				else{
					String sqlyom="select min(yom) y1,max(yom) y2 from my_syom where doc_no in ("+hidyom+")"; 
					ResultSet rsyom=stmt.executeQuery(sqlyom);
					while(rsyom.next()){
						minyom=rsyom.getString("y1");
						maxyom=rsyom.getString("y2");
						//System.out.println("===minyom===="+minyom+"==maxyom==="+maxyom);
					}

					sql3="and str_to_date(y1.yom, '%Y')<=str_to_date("+maxyom+" , '%Y') and str_to_date(y2.yom, '%Y')>=str_to_date("+minyom+" , '%Y') ";
				}
			}
			if(!( hidspec1.equalsIgnoreCase("") || hidspec1.equalsIgnoreCase("undefined"))){
				if(hidspec1.equalsIgnoreCase("0") || hidspec1.equalsIgnoreCase("-1")){
					sql4="and vs.bsize1id in ("+hidspec1+")";
					sql4=sql4+" or vs.bsize2id in ("+hidspec1+")";
					sql4=sql4+" or vs.bsize3id in ("+hidspec1+")";
				}
				else{
					sql4=" and s11.doc_no in ("+hidspec1+")";
					sql4=sql4+" or s12.doc_no in ("+hidspec1+")";
					sql4=sql4+" or s13.doc_no in ("+hidspec1+")";
				}
			}

			if(!(hidspec2.equalsIgnoreCase("0") || hidspec2.equalsIgnoreCase("") || hidspec2.equalsIgnoreCase("undefined"))){
				if(hidspec2.equalsIgnoreCase("-1")){
					sql5="and s.spec2_id in ("+hidspec2+")";

				}
				else{
					sql5="and s2.doc_no in ("+hidspec2+")";

				}
			}

			if(!(hidspec3.equalsIgnoreCase("null") || hidspec3.equalsIgnoreCase("") || hidspec3.equalsIgnoreCase("undefined"))){
				if(hidspec3.equalsIgnoreCase("-1") || hidspec3.equalsIgnoreCase("0")){
					sql6="and vs.csize1id in ("+hidspec3+")";
					sql6=sql6+" or vs.csize2id in ("+hidspec3+")";
					sql6=sql6+" or vs.csize3id in ("+hidspec3+")";
				}
				else{
					sql6=" and s31.doc_no in ("+hidspec3+")";
					sql6=sql6+" or s32.doc_no in ("+hidspec3+")";
					sql6=sql6+" or s33.doc_no in ("+hidspec3+")";
				}
			}
			if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
				sql7="and b.doc_no in ("+hidbrand+")";
			}

			if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
				sql8="and pt.doc_no in ("+hidtype+")";
			}

			if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
				sql9="and c.doc_no in ("+hidcat+")";
			}
			if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
				sql10="and sc.doc_no in ("+hidsubcat+")";
			}

			if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
				sql11="and m.doc_no in ("+hidproduct+")";
			}
		/*	if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equalsIgnoreCase("undefined")|| branchid.equalsIgnoreCase("a"))){
				sql12="and d.brhid in ("+branchid+")";
			}*/
			if(!(hidept.equalsIgnoreCase("0") || hidept.equalsIgnoreCase("") || hidept.equalsIgnoreCase("undefined"))){
				sql13="and dep.doc_no in ("+hidept+")";
			}

			sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13;


			//System.out.println("===sqlfinal===="+sqlfinal);
			if(type.equalsIgnoreCase("1")){  

				  

				sql = "select  "+selectjoinsql+" if(d.brhid=0, cp.company, br.branchname) as branch,convert(if(m.fixingprice=0,'',m.fixingprice),char(100)) fixingprice,"
						+ "  convert(if(m.lbrchg=0,'',m.lbrchg),char(100)) lbrchg,case when curdate() between clrfromdate and clrtodate then convert(if(clrprice=0,'',clrprice),char(100)) else ' '  end as  clrprice ,"
						+ " convert(if(m.stdprice=0,'',m.stdprice),char(100)) stdprice, m.doc_no,m.part_no product,m.productname pdesc,pt.producttype as type,b.brand as brand,"
						+ " c.category as cat,sc.subcategory as scat,dep.department as dept "
						/*+ "case when vs.sbrandid=-1 then 'ALL' else sb.brand end  as sbrand,"
						+ "case when vs.smodelid=-1 then 'ALL' else sm.model end  as smodel,"
						+ "(case when vs.submodelid=-1 then 'ALL' else submodel end) as submodel,"
						+ "(case when vs.esizeid=-1 then 'ALL' else coalesce(s2.spec,'') end) as esize,"
						+ "(case when s.bsize1id=-1 then 'ALL' else coalesce(s11.spec,'') end) as bsize1,"
						+ "(case when s.bsize2id=-1 then 'ALL' else coalesce(s12.spec,'') end) as bsize2,"
						+ "(case when s.bsize3id=-1 then 'ALL' else coalesce(s13.spec,'') end) as bsize3,"
						+ "(case when s.csize1id=-1 then 'ALL' else coalesce(s31.spec,'') end) as csize1,"
						+ "(case when s.csize2id=-1 then 'ALL' else coalesce(s32.spec,'') end) as csize2,"
						+ "(case when s.csize3id=-1 then 'ALL' else coalesce(s33.spec,'') end) as csize3,"
						+ "case when s.syomfrm_id=-1 then 'ALL' else y1.yom end as yomfrm,"
						+ "case when s.syomto_id=-1 then 'ALL' else y2.yom end as yomto,"
						+ "br.branchname as branch,"
						+ " */ +" from my_main m inner join my_desc d on(m.doc_no=d.psrno) " 
						+ "left join my_prodsuit s on(m.doc_no=s.psrno) left join my_vehsuitmaster vs on(vs.doc_no=s.vehsuitid) "
						+ "left join my_ptype pt on(m.typeid=pt.doc_no) left join my_brand b on(m.brandid=b.doc_no) "
						+ "left join my_dept dep on(dep.doc_no=m.deptid) left join my_catm c on(m.catid=c.doc_no) "
						+ "left join my_scatm sc on(m.scatid=sc.doc_no) left join my_sbrand sb  on(vs.sbrandid=sb.doc_no) "
						+ "left join my_smodel sm on(vs.smodelid=sm.doc_no) "
						+ "left join my_syom  y1 on(y1.doc_no=s.syomfrm_id) left join my_syom y2 on(y2.doc_no=s.syomto_id) "
						+ "left join my_ssubmodel sbm on(sbm.doc_No=vs.submodelid) left join my_suitspec2 s2 on(s2.doc_no=vs.esizeid)"
						+ "left join my_suitspec1 s11 on(s11.doc_no=s.bsize1id)"       
						+ "left join my_suitspec1 s12 on(s12.doc_no=s.bsize2id)"   
						+ "left join my_suitspec1 s13 on(s13.doc_no=s.bsize3id)"
						+ "left join my_suitspec3 s31 on(s31.doc_no=s.csize1id)"
						+ "left join my_suitspec3 s32 on(s32.doc_no=s.csize2id)"
						+ "left join my_suitspec3 s33 on(s33.doc_no=s.csize3id)"
						+ "left join my_brch br on(br.doc_no=d.brhid) left join my_comp cp on (cp.doc_no=d.cmpid)   "+joinsql+" "
						+ "where m.status=3 "+sqlfinal+" "+sqlwhere+" group by m.doc_no ";

			  System.out.println("==sql=type1==="+sql);

						ResultSet resultSet = stmt.executeQuery(sql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);

			}
			else if(type.equalsIgnoreCase("2")){


				sql = "select  "+selectjoinsql+" br.branchname as branch,m.doc_no,m.part_no product,m.productname pdesc,pt.producttype as type "
						+ " ,convert(if(m.fixingprice=0,'',m.fixingprice),char(100)) fixingprice,"
						+ "  convert(if(m.lbrchg=0,'',m.lbrchg),char(100)) lbrchg,convert(if(m.clrprice=0,'',m.clrprice),char(100)) clrprice, "
						+ " convert(if(m.stdprice=0,'',m.stdprice),char(100)) stdprice, b.brand as brand,c.category as cat,sc.subcategory as scat,dep.department as dept "
						/*+ "case when vs.sbrandid=-1 then 'ALL' else sb.brand end  as sbrand,"
						+ "case when vs.smodelid=-1 then 'ALL' else sm.model end  as smodel,"
						+ "(case when vs.submodelid=-1 then 'ALL' else submodel end) as submodel,"
						+ "(case when vs.esizeid=-1 then 'ALL' else coalesce(s2.spec,'') end) as esize,"
						+ "(case when vs.bsize1id=-1 then 'ALL' else coalesce(s11.spec,'') end) as bsize1,"
						+ "(case when vs.bsize2id=-1 then 'ALL' else coalesce(s12.spec,'') end) as bsize2,"
						+ "(case when vs.bsize3id=-1 then 'ALL' else coalesce(s13.spec,'') end) as bsize3,"
						+ "(case when vs.csize1id=-1 then 'ALL' else coalesce(s31.spec,'') end) as csize1,"
						+ "(case when vs.csize2id=-1 then 'ALL' else coalesce(s32.spec,'') end) as csize2,"
						+ "(case when vs.csize3id=-1 then 'ALL' else coalesce(s33.spec,'') end) as csize3,"
						+ "case when s.syomfrm_id=-1 then 'ALL' else y1.yom end as yomfrm,"
						+ "case when s.syomto_id=-1 then 'ALL' else y2.yom end as yomto,"
						+ ""
						+ "  */ + "  from my_main m inner join my_desc d on(m.doc_no=d.psrno) "
						+ "left join my_prodsuit s on(m.doc_no=s.psrno) left join my_vehsuitmaster vs on(vs.doc_no=s.vehsuitid) "
						+ "left join my_ptype pt on(m.typeid=pt.doc_no) left join my_brand b on(m.brandid=b.doc_no) "
						+ "left join my_dept dep on(dep.doc_no=m.deptid) left join my_catm c on(m.catid=c.doc_no) "
						+ "left join my_scatm sc on(m.scatid=sc.doc_no) left join my_sbrand sb  on(vs.sbrandid=sb.doc_no) "
						+ "left join my_smodel sm on(vs.smodelid=sm.doc_no) "
						+ "left join my_syom  y1 on(y1.doc_no=s.syomfrm_id) left join my_syom y2 on(y2.doc_no=s.syomto_id) "
						+ "left join my_ssubmodel sbm on(sbm.doc_No=vs.submodelid) left join my_suitspec2 s2 on(s2.doc_no=vs.esizeid)"
						+ "left join my_suitspec1 s11 on(s11.doc_no=vs.bsize1id)"
						+ "left join my_suitspec1 s12 on(s12.doc_no=vs.bsize2id)"
						+ "left join my_suitspec1 s13 on(s13.doc_no=vs.bsize3id)"
						+ "left join my_suitspec3 s31 on(s31.doc_no=vs.csize1id)"
						+ "left join my_suitspec3 s32 on(s32.doc_no=vs.csize2id)"
						+ "left join my_suitspec3 s33 on(s33.doc_no=vs.csize3id)"
						+ "left join my_brch br on(br.doc_no=d.brhid)  "+joinsql+" "
						+ "where m.status=3 and vs.doc_no in("+suitid+") group by m.doc_no ";

			System.out.println("==sql=type2==="+sql);

				ResultSet resultSet = stmt.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
			}
			

		


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public JSONArray partSearch(HttpSession session,String type,String hidsbrand,String hidsmodel,
			String hidyom,String hidspec1,String hidspec2,String hidspec3,String hidbrand,String hidtype,String hidcat,
			String hidsubcat,String hidproduct,String branchid,String hidept,String suitid,String hidsubmodel,String load
			) throws SQLException {


 	
 
		JSONArray RESULTDATA=new JSONArray();

		 // System.out.println("==sql=load==="+load);
		
		if(!(load.equalsIgnoreCase("load")))
		{
			return RESULTDATA;
		}
		
		 // System.out.println("==sql=type1===");
		Connection conn = null;

		try {
		 
			
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String minyom="",maxyom="";
			String sql ="";
			String brsql ="";
			if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equalsIgnoreCase("undefined")|| branchid.equalsIgnoreCase("a"))){
				brsql="and brhid in ("+branchid+")";
			}
			String joinsql="    ";
			String selectjoinsql="   ";
		/*	if(gridtype.equalsIgnoreCase("cal"))
			{
				  joinsql="  left join (select sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty,prdid  from  my_prddin  where 1=1 "+brsql+" group by psrno) s   on s.prdid=m.doc_no ";
				  selectjoinsql="  convert(if(coalesce(s.stkqty,0)=0,'',coalesce(s.stkqty,0)),char(100)) stkqty,";	
			}
			*/
			String sqlwhere="";
			
			String sqlsuit="";
 
			if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+ " and b.doc_no in ("+hidbrand+")";
			}

			if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+ "and pt.doc_no in ("+hidtype+")";
			}

			if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+ "and c.doc_no in ("+hidcat+")";
			}
			if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+  "and sc.doc_no in ("+hidsubcat+")";
			}

			if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+  "and m.doc_no in ("+hidproduct+")";
			}
	 
			if(!(hidept.equalsIgnoreCase("0") || hidept.equalsIgnoreCase("") || hidept.equalsIgnoreCase("undefined"))){
				sqlwhere=sqlwhere+  "and dep.doc_no in ("+hidept+")";
			}

			 
			 
			  System.out.println("==sql=type1===");
 
		//	doc_no, psrno, typeid, yomfrm, yomfrmid, yomto, yomtoid, brandid, modelid, submodelid, esizeid, bsizeid, csizeid, date, status
				  
/*
				sql = " select  "+selectjoinsql+"   convert(if(m.fixingprice=0,'',m.fixingprice),char(100)) fixingprice, "
						+ "  convert(if(m.lbrchg=0,'',m.lbrchg),char(100)) lbrchg,case when curdate() between clrfromdate and clrtodate "
						+ "  then convert(if(clrprice=0,'',clrprice),char(100)) else ' '  end as  clrprice , "
						+ " convert(if(m.stdprice=0,'',m.stdprice),char(100)) stdprice, m.doc_no,m.part_no product,m.productname pdesc, "
						+ "  pt.producttype as type,b.brand as brand,  c.category as cat,sc.subcategory as scat,dep.department as dept "
						+ "   from my_main m   inner join my_suitmaster vs on(vs.psrno=m.psrno)	 left join my_ptype pt on(m.typeid=pt.doc_no)  "
						+ " left join my_brand b on(m.brandid=b.doc_no) left join my_dept dep on(dep.doc_no=m.deptid) left join my_catm c on(m.catid=c.doc_no) "
						+ " left join my_scatm sc on(m.scatid=sc.doc_no) "+joinsql+" where m.mtypeid<>1 and m.status=3 "+sqlsuit+" group by m.doc_no "
						+ " union all "
						+ " select  "+selectjoinsql+"   convert(if(m.fixingprice=0,'',m.fixingprice),char(100)) fixingprice, "
						+ "  convert(if(m.lbrchg=0,'',m.lbrchg),char(100)) lbrchg,case when curdate() between clrfromdate and clrtodate "
						+ "  then convert(if(clrprice=0,'',clrprice),char(100)) else ' '  end as  clrprice , "
						+ " convert(if(m.stdprice=0,'',m.stdprice),char(100)) stdprice, m.doc_no,m.part_no product,m.productname pdesc, "
						+ "  pt.producttype as type,b.brand as brand,  c.category as cat,sc.subcategory as scat,dep.department as dept "
						+ "   from my_main m   left join my_ptype pt on(m.typeid=pt.doc_no)  "
						+ " left join my_brand b on(m.brandid=b.doc_no) left join my_dept dep on(dep.doc_no=m.deptid) left join my_catm c on(m.catid=c.doc_no) "
						+ " left join my_scatm sc on(m.scatid=sc.doc_no) "+joinsql+" where mtypeid=1 and m.status=3 "+sqlwhere+" group by m.doc_no ";*/
				
				
				sql = "  select    m.barcode,convert(if(m.fixingprice=0,'',m.fixingprice),char(100)) fixingprice, "
						+ "  convert(if(m.lbrchg=0,'',m.lbrchg),char(100)) lbrchg,case when curdate() between clrfromdate and clrtodate "
						+ "  then convert(if(clrprice=0,'',clrprice),char(100)) else ' '  end as  clrprice , "
						+ " convert(if(m.stdprice=0,'',m.stdprice),char(100)) stdprice, m.doc_no,m.part_no product,m.productname pdesc, "
						+ "  pt.producttype as type,b.brand as brand,  c.category as cat,sc.subcategory as scat,dep.department as dept "
						+ "   from my_main m   left join my_ptype pt on(m.typeid=pt.doc_no) left join my_desc de on de.psrno=m.psrno "
						+ " left join my_brand b on(m.brandid=b.doc_no) left join my_dept dep on(dep.doc_no=m.deptid) left join my_catm c on(m.catid=c.doc_no) "
						+ " left join my_scatm sc on(m.scatid=sc.doc_no) "+joinsql+" where  de.discontinued=0 and  m.status=3 "+sqlwhere+" group by m.doc_no ";


		  System.out.println("==sql=type1==="+sql);

						ResultSet resultSet = stmt.executeQuery(sql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
 

		


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray suitSearch(HttpSession session,String yomfrm,String yomto,String load) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		
		if(!(load.equalsIgnoreCase("load")))
		{
		return RESULTDATA;	
		}
		
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select s.doc_no,coalesce(syf.yom,s.yom_frm) yomfrm,coalesce(syt.yom,s.yom_to) yomto,s.doc_no,brand,(case when s.smodelid=-1 then 'ALL' else model end) as model,"
					+ "(case when s.submodelid=-1 then 'ALL' else submodel end) as submodel,"
					+ "(case when s.esizeid=-1 then 'ALL' else coalesce(s2.spec,'') end) as esize,"
					+ "(case when s.bsize1id=-1 then 'ALL' else coalesce(s11.spec,'') end) as bsize1,"
					+ "(case when s.bsize2id=-1 then 'ALL' else coalesce(s12.spec,'') end) as bsize2,"
					+ "(case when s.bsize3id=-1 then 'ALL' else coalesce(s13.spec,'') end) as bsize3,"
					+ "(case when s.csize1id=-1 then 'ALL' else coalesce(s31.spec,'') end) as csize1,"
					+ "(case when s.csize2id=-1 then 'ALL' else coalesce(s32.spec,'') end) as csize2,"
					+ "(case when s.csize3id=-1 then 'ALL' else coalesce(s33.spec,'') end) as csize3,"
					+ "s.sbrandid brandid,s.smodelid brandid,s.submodelid submodelid,s.esizeid,s.bsize1id,s.bsize2id,s.bsize3id,"
					+ "s.csize1id,s.csize2id,s.csize3id,ps.syomfrm_id yomfrmid,ps.syomto_id yomtoid  "
					+ "from my_vehsuitmaster s left join my_sbrand b on(b.doc_no=s.sbrandid ) left join my_smodel m on(m.doc_no=s.smodelid)"
					+ "left join my_ssubmodel sm on(sm.doc_No=s.submodelid and sm.modelid=s.smodelid) left join my_suitspec2 s2 on(s2.doc_no=s.esizeid)"
					+ "left join my_suitspec1 s11 on(s11.doc_no=s.bsize1id)"
					+ "left join my_suitspec1 s12 on(s12.doc_no=s.bsize2id)"
					+ "left join my_suitspec1 s13 on(s13.doc_no=s.bsize3id)"
					+ "left join my_suitspec3 s31 on(s31.doc_no=s.csize1id)"
					+ "left join my_suitspec3 s32 on(s32.doc_no=s.csize2id)"
					+ "left join my_suitspec3 s33 on(s33.doc_no=s.csize3id)"
					+ "left join my_prodsuit ps on(ps.vehsuitid=s.doc_no)"
					+ "left join my_syom syf on(ps.syomfrm_id=syf.doc_no)"
					+ "left join my_syom syt on(ps.syomto_id=syt.doc_no)"
					+ "where s.status=3 ";

			/*and date_format(str_to_date(s.yom_frm,'%Y'),'%Y')>="+yomfrm+" and date_format(str_to_date(yom_to,'%Y'),'%Y')<="+yomto+"*/

		//	System.out.println("=sql==suitSearch="+sql);

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
