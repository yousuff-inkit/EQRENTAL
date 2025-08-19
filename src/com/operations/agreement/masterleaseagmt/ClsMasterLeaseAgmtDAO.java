package com.operations.agreement.masterleaseagmt;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsMasterLeaseAgmtDAO {
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	
	public JSONArray getBrandData(String id) throws SQLException{
		JSONArray branddata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return branddata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String strsql="select brand_name brand,doc_no,date from gl_vehbrand where status=3";
			Statement stmt=conn.createStatement();
			ResultSet  rs=stmt.executeQuery(strsql);
			branddata=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return branddata;
	}
	
	
	public JSONArray getModelData(String id,String brandid) throws SQLException{
		JSONArray branddata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return branddata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String strsql="select model.vtype model,model.doc_no,model.date,brd.brand_name brand from gl_vehmodel model left join gl_vehbrand brd on model.brandid=brd.doc_no where model.status=3 and model.brandid="+brandid;
			Statement stmt=conn.createStatement();
			ResultSet  rs=stmt.executeQuery(strsql);
			branddata=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return branddata;
	}
	
	public JSONArray getSpecData(String id) throws SQLException{
		JSONArray branddata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return branddata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String strsql="select doc_no,name spec from gl_vehspec where status=3";
			Statement stmt=conn.createStatement();
			ResultSet  rs=stmt.executeQuery(strsql);
			branddata=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return branddata;
	}


	public int insert(Date sqldate, Date sqlstartdate, Date sqlenddate,
			String po, String refno, String cldocno, String description,
			String brchName, HttpSession session, String mode,
			String formdetailcode, ArrayList<String> gridarray, HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int docno=0;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			/*if(po.equalsIgnoreCase("")){
				po="0";
			}
			if(refno.equalsIgnoreCase("")){
				refno="0";
			}*/
			CallableStatement stmt = conn.prepareCall("{CALL masterLAGMDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(12, java.sql.Types.INTEGER);
			stmt.registerOutParameter(13, java.sql.Types.INTEGER);
			stmt.setString(1,po);
			stmt.setString(2,refno);
			stmt.setInt(3,Integer.parseInt(cldocno));
			stmt.setString(4, description);
			stmt.setDate(5,sqlstartdate);
			stmt.setDate(6,sqlenddate);
			stmt.setDate(7,sqldate);
			stmt.setString(8,formdetailcode);
			stmt.setString(9,session.getAttribute("COMPANYID").toString().trim());
			stmt.setString(11,session.getAttribute("BRANCHID").toString().trim());
			stmt.setString(10,session.getAttribute("USERID").toString().trim());
			stmt.setString(14,mode);
			stmt.executeQuery();
			docno=stmt.getInt("docNo");
			int vocno=stmt.getInt("vocNo");
			request.setAttribute("vocno", vocno);
			if(docno<=0)
			{
				conn.close();
				return 0;
			}
			int totalqty=0;
			for(int i=0;i<gridarray.size();i++){
				String temp[]=gridarray.get(i).split("::");
				CallableStatement stmtdet = conn.prepareCall("{CALL masterLAGDDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				stmtdet.setInt(1, docno);
				stmtdet.setInt(2, Integer.parseInt(temp[0].equalsIgnoreCase("") || temp[0].equalsIgnoreCase("undefined") || temp[0]==null || temp[0].isEmpty()?"0":temp[0]));
				stmtdet.setInt(3,Integer.parseInt(temp[1].equalsIgnoreCase("") || temp[1].equalsIgnoreCase("undefined") || temp[1]==null || temp[1].isEmpty()?"0":temp[1]));
				stmtdet.setInt(4,Integer.parseInt(temp[2].equalsIgnoreCase("") || temp[2].equalsIgnoreCase("undefined") || temp[2]==null || temp[2].isEmpty()?"0":temp[2]));
				stmtdet.setInt(5,Integer.parseInt(temp[3].equalsIgnoreCase("") || temp[3].equalsIgnoreCase("undefined") || temp[3]==null || temp[3].isEmpty()?"0":temp[3]));
				stmtdet.setInt(6, Integer.parseInt(temp[4].equalsIgnoreCase("") || temp[4].equalsIgnoreCase("undefined") || temp[4]==null || temp[4].isEmpty()?"0":temp[4]));
				stmtdet.setInt(7,Integer.parseInt(temp[5].equalsIgnoreCase("") || temp[5].equalsIgnoreCase("undefined") || temp[5]==null || temp[5].isEmpty()?"0":temp[5]));
				stmtdet.setInt(8,Integer.parseInt(temp[6].equalsIgnoreCase("") || temp[6].equalsIgnoreCase("undefined") || temp[6]==null || temp[6].isEmpty()?"0":temp[6]));
				stmtdet.setDouble(9,Double.parseDouble(temp[7].equalsIgnoreCase("") || temp[7].equalsIgnoreCase("undefined") || temp[7]==null || temp[7].isEmpty()?"0":temp[7]));
				stmtdet.setDouble(10,Double.parseDouble(temp[8].equalsIgnoreCase("") || temp[8].equalsIgnoreCase("undefined") || temp[8]==null || temp[8].isEmpty()?"0":temp[8]));
				stmtdet.setDouble(11,Double.parseDouble(temp[9].equalsIgnoreCase("") || temp[9].equalsIgnoreCase("undefined") || temp[9]==null || temp[9].isEmpty()?"0":temp[9]));
				stmtdet.setDouble(12,Double.parseDouble(temp[10].equalsIgnoreCase("") || temp[10].equalsIgnoreCase("undefined") || temp[10]==null || temp[10].isEmpty()?"0":temp[10]));
				stmtdet.setDouble(13,Double.parseDouble(temp[11].equalsIgnoreCase("") || temp[11].equalsIgnoreCase("undefined") || temp[11]==null || temp[11].isEmpty()?"0":temp[11]));
				stmtdet.setString(14,mode);
				
				stmtdet.executeQuery();
				totalqty=totalqty+Integer.parseInt(temp[4].equalsIgnoreCase("") || temp[4].equalsIgnoreCase("undefined") || temp[4]==null || temp[4].isEmpty()?"0":temp[4]);
			}
			
			String strupdate="update gl_masterlagm set totalqty="+totalqty+" where doc_no="+docno;
			Statement stmtupdate=conn.createStatement();
			int update=stmtupdate.executeUpdate(strupdate);
			if(update<0){
				return 0;
			}
			conn.commit();
			return docno;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return 0;
	}
	
	public JSONArray getSearchData(String cldocno,String clientname,String date,String po,String refno,String vocno,String id) throws SQLException{
		
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			java.sql.Date sqldate=null;
			if(!cldocno.equalsIgnoreCase("")){
				sqltest+=" and m.cldocno like '%"+cldocno+"%'";
			}
			if(!clientname.equalsIgnoreCase("")){
				sqltest+=" and ac.refname like '%"+clientname+"%'";
			}
			if(!date.equalsIgnoreCase("")){
				sqldate=objcommon.changeStringtoSqlDate(date);
				sqltest+=" and m.date='"+sqldate+"'";
			}
			if(!po.equalsIgnoreCase("")){
				sqltest+=" and m.po like '%"+po+"%'";
			}
			if(!refno.equalsIgnoreCase("")){
				sqltest+=" and m.refno like '%"+refno+"%'";
			}
			if(!vocno.equalsIgnoreCase("")){
				sqltest+=" and m.voc_no like '%"+vocno+"%'";
			}
			String strsql="select m.doc_no,m.voc_no,m.po,m.refno,m.cldocno,m.description,m.startdate,m.enddate,m.date,ac.refname,ac.address,ac.per_mob,ac.mail1,ac.contactperson from gl_masterlagm m left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') where m.status=3"+sqltest;
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
	
public JSONArray getMasterGridData(String docno,String id) throws SQLException{
		
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			String strsql="select brd.brand_name brand,brd.doc_no brandid,model.vtype model,model.doc_no modelid,spec.name specification,spec.doc_no specid,"+
			" lag.duration leaseduration,lag.qty,lag.rate,lag.cdw,lag.pai,lag.gps,lag.childseat,lag.kmrestrict,lag.excesskmrate from gl_masterlagd lag left join gl_vehbrand brd "+
			" on lag.brdid=brd.doc_no left join gl_vehmodel model on lag.modelid=model.doc_no left join gl_vehspec spec on lag.specid=spec.doc_no where "+
			" lag.rdocno="+docno+" and lag.status=3";
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
