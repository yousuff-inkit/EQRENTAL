package com.operations.agreement.masterleaseagmtalmariah;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.marketing.leasecalculator.ClsLeaseCalculatorBean;

public class ClsMasterLeaseAgmtAlmariahDAO {
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
	
	public JSONArray getProjectData(String id) throws SQLException{
		JSONArray projectdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return projectdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String strsql="select project_name project,doc_no,date from gl_project where status=3";
			Statement stmt=conn.createStatement();
			ResultSet  rs=stmt.executeQuery(strsql);
			projectdata=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return projectdata;
	}
	
	public JSONArray getQotRefData(String id,String cmbreftype) throws SQLException{
		JSONArray projectdata=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return projectdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String strsql="select calc.doc_no,calc.date,ac.refname,ac.contactPerson,ac.mail1,ac.cldocno,ac.per_mob,concat(ac.address,'  ',ac.address2)"+
			" as address ,ac.per_tel from gl_almariahleasecalcm calc left join gl_lprm req on calc.reqdoc=req.doc_no  "
			+ " left join my_acbook ac on (req.cldocno=ac.cldocno and ac.dtype='CRM') where calc.status=3";
			Statement stmt=conn.createStatement();
			ResultSet  rs=stmt.executeQuery(strsql);
			projectdata=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return projectdata;
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
			String formdetailcode, ArrayList<String> gridarray, HttpServletRequest request, String cmbreftype, String hidqotrefno, String hidprojectno) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		int docno=0;
		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			if(hidqotrefno.equalsIgnoreCase("")){
				hidqotrefno="0";
			}
			if(hidprojectno.equalsIgnoreCase("")){
				hidprojectno="0";
			}
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
			Statement stmtupdate= conn.createStatement();
			String strupdatemaster="update gl_masterlagm set reftype='"+cmbreftype+"',qotrefno='"+hidqotrefno+"',projectno='"+hidprojectno+"' where doc_no="+docno;
			int updateval=stmtupdate.executeUpdate(strupdatemaster);
			if(updateval<0){
				conn.close();
				return 0;
			}
			if(docno<=0)
			{
				conn.close();
				return 0;
			}
			int totalqty=0;
			for(int i=0,j=1;i<gridarray.size();i++,j++){
				String temp[]=gridarray.get(i).split("::");
				CallableStatement stmtdet = conn.prepareCall("{CALL masterLAGDDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				stmtdet.setInt(1, docno);
				stmtdet.setInt(2, Integer.parseInt(temp[0].equalsIgnoreCase("") || temp[0].equalsIgnoreCase("undefined") || temp[0]==null || temp[0].isEmpty()?"0":temp[0]));
				stmtdet.setInt(3,Integer.parseInt(temp[1].equalsIgnoreCase("") || temp[1].equalsIgnoreCase("undefined") || temp[1]==null || temp[1].isEmpty()?"0":temp[1]));
				stmtdet.setInt(4,Integer.parseInt(temp[2].equalsIgnoreCase("") || temp[2].equalsIgnoreCase("undefined") || temp[2]==null || temp[2].isEmpty()?"0":temp[2]));
				stmtdet.setInt(5,Integer.parseInt(temp[3].equalsIgnoreCase("") || temp[3].equalsIgnoreCase("undefined") || temp[3]==null || temp[3].isEmpty()?"0":temp[3]));
				stmtdet.setInt(6, Integer.parseInt(temp[4].equalsIgnoreCase("") || temp[4].equalsIgnoreCase("undefined") || temp[4]==null || temp[4].isEmpty()?"0":temp[4]));
				stmtdet.setDouble(7,Double.parseDouble(temp[5].equalsIgnoreCase("") || temp[5].equalsIgnoreCase("undefined") || temp[5]==null || temp[5].isEmpty()?"0":temp[5]));
				stmtdet.setDouble(8,Double.parseDouble(temp[6].equalsIgnoreCase("") || temp[6].equalsIgnoreCase("undefined") || temp[6]==null || temp[6].isEmpty()?"0":temp[6]));
				stmtdet.setDouble(9,Double.parseDouble(temp[7].equalsIgnoreCase("") || temp[7].equalsIgnoreCase("undefined") || temp[7]==null || temp[7].isEmpty()?"0":temp[7]));
				stmtdet.setDouble(10,Double.parseDouble(temp[8].equalsIgnoreCase("") || temp[8].equalsIgnoreCase("undefined") || temp[8]==null || temp[8].isEmpty()?"0":temp[8]));
				stmtdet.setDouble(11,Double.parseDouble(temp[9].equalsIgnoreCase("") || temp[9].equalsIgnoreCase("undefined") || temp[9]==null || temp[9].isEmpty()?"0":temp[9]));
				stmtdet.setDouble(12,Double.parseDouble(temp[10].equalsIgnoreCase("") || temp[10].equalsIgnoreCase("undefined") || temp[10]==null || temp[10].isEmpty()?"0":temp[10]));
				stmtdet.setDouble(13,Double.parseDouble(temp[11].equalsIgnoreCase("") || temp[11].equalsIgnoreCase("undefined") || temp[11]==null || temp[11].isEmpty()?"0":temp[11]));
				stmtdet.setString(14,mode);
				stmtdet.setInt(15,j);
				stmtdet.setDouble(16,Double.parseDouble(temp[12].equalsIgnoreCase("") || temp[12].equalsIgnoreCase("undefined") || temp[12]==null || temp[12].isEmpty()?"0":temp[12]));
				stmtdet.setDouble(17,Double.parseDouble(temp[13].equalsIgnoreCase("") || temp[13].equalsIgnoreCase("undefined") || temp[13]==null || temp[13].isEmpty()?"0":temp[13]));
				stmtdet.setDouble(18,Double.parseDouble(temp[14].equalsIgnoreCase("") || temp[14].equalsIgnoreCase("undefined") || temp[14]==null || temp[14].isEmpty()?"0":temp[14]));
				stmtdet.setDouble(19,Double.parseDouble(temp[15].equalsIgnoreCase("") || temp[15].equalsIgnoreCase("undefined") || temp[15]==null || temp[15].isEmpty()?"0":temp[15]));
				stmtdet.setDouble(20,Double.parseDouble(temp[16].equalsIgnoreCase("") || temp[16].equalsIgnoreCase("undefined") || temp[16]==null || temp[16].isEmpty()?"0":temp[16]));
				stmtdet.setDouble(21,Double.parseDouble(temp[17].equalsIgnoreCase("") || temp[17].equalsIgnoreCase("undefined") || temp[17]==null || temp[17].isEmpty()?"0":temp[17]));
				stmtdet.setDouble(22,Double.parseDouble(temp[18].equalsIgnoreCase("") || temp[18].equalsIgnoreCase("undefined") || temp[18]==null || temp[18].isEmpty()?"0":temp[18]));
				stmtdet.setDouble(23,Double.parseDouble(temp[19].equalsIgnoreCase("") || temp[19].equalsIgnoreCase("undefined") || temp[19]==null || temp[19].isEmpty()?"0":temp[19]));
				stmtdet.setDouble(24,Double.parseDouble(temp[20].equalsIgnoreCase("") || temp[20].equalsIgnoreCase("undefined") || temp[20]==null || temp[20].isEmpty()?"0":temp[20]));
				stmtdet.executeQuery();
				totalqty=totalqty+Integer.parseInt(temp[4].equalsIgnoreCase("") || temp[4].equalsIgnoreCase("undefined") || temp[4]==null || temp[4].isEmpty()?"0":temp[4]);
			}
			
			String strupdate="update gl_masterlagm set totalqty="+totalqty+" where doc_no="+docno;
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
			String strsql="select coalesce(prj.project_name,'') projectname,prj.doc_no projectno,m.reftype,m.qotrefno,m.doc_no,m.voc_no,m.po,m.refno,m.cldocno,m.description,m.startdate,m.enddate,m.date,"+
					" ac.refname,ac.address,ac.per_mob,ac.mail1,ac.contactperson,if(rq.driver='yes',1,0) as driver,if(rq.security_pass='yes',1,0)as security_pass,if(rq.fuel='yes',1,0) as fuel from gl_masterlagm m left join my_acbook ac on (m.cldocno=ac.cldocno and "+
					" ac.dtype='CRM') left join gl_project prj on m.projectno=prj.doc_no"
					+ " left join gl_almariahleasecalcm cm on m.qotrefno=cm.doc_no left join gl_almariahleasecalcreq rq on cm.doc_no=rq.leasereqdocno where m.status=3"+sqltest;
			
			System.out.println("...................---------------............"+strsql);
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
	
public JSONArray getMasterGridData(String docno,String id,String reftype) throws SQLException{
		
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="";
			if(reftype.equalsIgnoreCase("QOT")){
				strsql="select brd.brand_name brand,brd.doc_no brandid,model.vtype model,model.doc_no modelid,reqd.spec specification,spec.doc_no specid,"+
				" lag.duration leaseduration,lag.qty,lag.rate,lag.cdw,lag.pai,lag.gps,lag.childseat,lag.kmrestrict,lag.excesskmrate,"+
				" lag.totalcostpermonth,lag.drivercostpermonth,lag.diw,lag.hpd,lag.fuel,lag.salik,lag.securitypass,lag.safetyacc,"+
				" lag.rateperexhr from gl_masterlagm m left join "+
				" gl_masterlagd lag on m.doc_no=lag.rdocno left join gl_almariahleasecalcm calc on m.qotrefno=calc.doc_no left join gl_lprm reqm on calc.reqdoc=reqm.doc_no "+
				" left join gl_lprd reqd on reqm.doc_no=reqd.rdocno left join gl_vehbrand brd on lag.brdid=brd.doc_no left join gl_vehmodel model on "+
				" lag.modelid=model.doc_no left join gl_vehspec spec on lag.specid=spec.doc_no where lag.rdocno="+docno+" and lag.status=3";
			}
			else{
				strsql="select brd.brand_name brand,brd.doc_no brandid,model.vtype model,model.doc_no modelid,spec.name specification,spec.doc_no specid,"+
						" lag.duration leaseduration,lag.qty,lag.rate,lag.cdw,lag.pai,lag.gps,lag.childseat,lag.kmrestrict,lag.excesskmrate,"+
				" lag.totalcostpermonth,lag.drivercostpermonth,lag.diw,lag.hpd,lag.fuel,lag.salik,lag.securitypass,lag.safetyacc,"+
				" lag.rateperexhr from gl_masterlagd lag left join gl_vehbrand brd "+
						" on lag.brdid=brd.doc_no left join gl_vehmodel model on lag.modelid=model.doc_no left join gl_vehspec spec on lag.specid=spec.doc_no where "+
						" lag.rdocno="+docno+" and lag.status=3";
			}
			
			System.out.println("====gridsql=="+strsql);
			
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
public JSONArray getMasterGridRefData(String docno,String id,String refno) throws SQLException{
	
	JSONArray data=new JSONArray();
	if(!id.equalsIgnoreCase("2")){
		return data;
	}
	Connection conn=null;
	try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		
		String strsql="select brd.brand_name brand,brd.doc_no brandid,model.vtype model,model.doc_no modelid,reqd.spec specification,0 specid,"+
		" reqd.ldur leaseduration,reqd.qty,alm.ratepermonth rate,0 cdw,0 pai,0 gps,0 childseat,reqd.kmusage kmrestrict,"+
		" coalesce(alm.totalcostpermonth,0) totalcostpermonth,coalesce(alm.drivercostpermonth,0) drivercostpermonth,"+
		" coalesce(alm.exkmcharge,0) excesskmrate,coalesce(alm.ddiw,0) diw,coalesce(alm.dhpd,0) hpd,coalesce(alm.fuelincome,0) fuel,"+
		" coalesce(alm.salikcharge,0) salik,coalesce(alm.securitypassincome,0) securitypass,coalesce(alm.accessories,0) safetyacc,"+
		" coalesce(alm.rateperexhour,0) rateperexhr from gl_almariahleasecalcm "+
		" calc left join gl_lprm reqm on calc.reqdoc=reqm.doc_no left join gl_lprd reqd on reqm.doc_no=reqd.rdocno left join gl_almariahleasecalcreq alm on (reqm.doc_no=alm.leasereqdocno and reqd.sr_no=alm.sr_no) left join gl_vehbrand brd "+
		" on reqd.brdid=brd.doc_no left join gl_vehmodel model on reqd.modid=model.doc_no where calc.doc_no="+refno+" and calc.status=3";
		System.out.println(strsql);
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
public  ClsMasterLeaseAgmtAlmariahBean getPrint(int docno, HttpServletRequest request ,HttpSession session) throws SQLException {
	ClsMasterLeaseAgmtAlmariahBean bean = new ClsMasterLeaseAgmtAlmariahBean();
	Connection conn = null;
	ClsConnection conobj=new ClsConnection();
	conn=conobj.getMyConnection();
	
	try{
		Statement stmt =conn.createStatement();
		String printsql="select m.date,DATE_FORMAT(m.startdate,'%e %M %Y') startdate,ac.refName,ac.dtype,dr.dlno licenseno,dr.issfrm area,timestampdiff(month,startdate,enddate) leasemonths,"
				+" round(d.hpd,2) hrs,round(d.diw,2) days,round(d.rateperexhr,2) exhr,round(d.kmrestrict,2) km,round(d.excesskmrate,2) excesskm,"
				+" convert(concat('Vehicle Rental Services, Vehicle Only, ',if(lreq.driver='Yes','With driver','Without driver'),' , ',"
				+" if(lreq.fuel='Yes','With fuel','Without fuel'),' , ',if(lreq.security_pass='Yes','With Security Pass','Without Security Pass')),char(1000))"
				+" services from gl_masterlagm m left join my_acbook ac on m.cldocno=ac.cldocno and ac.dtype='CRM'"
				+" left join gl_drdetails dr on m.cldocno=dr.cldocno left join gl_masterlagd d on m.doc_no=d.rdocno"
				+" left join gl_almariahleasecalcreq lreq on m.refNo=lreq.rdocno and d.sr_no=lreq.sr_no where m.doc_no="+docno+" group by m.doc_no";
		System.out.println("..................---------..............."+printsql);
		ResultSet rsprint=stmt.executeQuery(printsql);
		while(rsprint.next()){
			bean.setLbldate(rsprint.getString("date"));
			bean.setLblcompanyname(rsprint.getString("refName"));
			bean.setLbllicenseno(rsprint.getString("licenseno"));
			bean.setLblarea(rsprint.getString("area"));
			bean.setLblcontractperiod(rsprint.getString("leasemonths"));
			bean.setLblservices(rsprint.getString("services"));
			bean.setStartdate(rsprint.getString("startdate"));
			System.out.println("strdate"+rsprint.getString("startdate"));

			bean.setLblhpd(rsprint.getString("hrs"));
			bean.setLbldiw(rsprint.getString("days"));
			bean.setLblrateperexhr(rsprint.getString("exhr"));
			bean.setLblkmrestrict(rsprint.getString("km"));
			bean.setLblexcesskm(rsprint.getString("excesskm"));
		}
		
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}

	return bean;
}




}
