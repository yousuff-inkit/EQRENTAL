package com.equipment.equipcontractclose;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEquipContractCloseDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray searchMaster(String branch,String docno,String clientname,String contractvocno,String date,String id,String assetid) throws SQLException{
		if(!id.equalsIgnoreCase("1")) return new JSONArray();
		Connection conn=null;
		JSONArray data=new JSONArray();
		try{
			String sqlfilters="";
			 String brid=branch;
		    	
		    	
			    
		    	java.sql.Date sqlStartDate=null;
		    
		    	
		    	//enqdate.trim();
		    	if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
		    	{
		    	sqlStartDate = objcommon.changeStringtoSqlDate(date);
		    	}
		    	
		    
		    	String sqltest="";
		    	if(!(docno.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and m.voc_no like '%"+docno+"%'";
		    	}
		    	if(!(clientname.equalsIgnoreCase(""))){
		    		//sqltest=sqltest+" and  if(m.cldocno!=0,a.refname like '%"+clientname+"%',e.name like '%"+clientname+"%'  )";                                           
		    		sqltest=sqltest+" and  ac.refname like '%"+clientname+"%'";
		    	}
		    	if(!(contractvocno.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and agmt.voc_no like '%"+contractvocno+"%'";
		    	}
		    	
		    	
		    	 if(!(sqlStartDate==null)){
		    		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
		    	} 
		        
			
			if(!assetid.equalsIgnoreCase("")){
				sqltest+=" and e.reg_no like '%"+assetid+"%'";
			}
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			/* String strsql="select m.doc_no docno,m.voc_no vocno,m.date,m.enddate,m.endtime,agmt.doc_no contractdocno,agmt.voc_no contractvocno,ac.refname,e.reg_no assetid "+
			" from eq_contractclosem m"+
			" left join gl_rentalcontractm agmt on m.contractdocno=agmt.doc_no"+
			" left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM')"
			+ "left join gl_rentalcontractd d on agmt.doc_no=d.rdocno  "
			+ " left join gl_rentalquoted qotd on d.quotedetdocno=qotd.doc_no "
			+ "left join gl_rentalquotecalc calc on (qotd.doc_no=calc.detdocno and calc.contractdocno=agmt.doc_no) "
			+ " left join gl_equipmaster e on e.fleet_no=calc.fleet_no  where m.status=3 "+sqltest+" order by m.doc_no"; */
			String strsql="select m.doc_no docno,m.voc_no vocno,m.date,m.enddate,m.endtime,agmt.doc_no contractdocno,agmt.voc_no contractvocno,ac.refname,e.reg_no assetid "+  
					" from eq_contractclosem m"+
					" left join gl_rentalcontractm agmt on m.contractdocno=agmt.doc_no"+
					" left join my_acbook ac on (agmt.cldocno=ac.cldocno and ac.dtype='CRM')"
					+ " left join eq_contractclosed d on m.doc_no=d.rdocno   left join gl_rentalquotecalc calc on (d.calcdocno=calc.doc_no and calc.contractdocno=agmt.doc_no)  "
					+ " left join gl_equipmaster e on e.fleet_no=calc.fleet_no  where m.status=3 and m.brhid="+brid+" " +sqltest+" order by m.doc_no";
		System.out.println("Mainsearch--->"+strsql);
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
	public JSONArray getContractSaveData(String docno,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String strsql="select veh.reg_no assetid,calc.doc_no calcdocno,calc.contractdocno,veh.fleet_no,veh.flname,coalesce(calc.delenddate,calc.delstartdate) startdate,"+
			" coalesce(calc.delendtime,calc.delstarttime) starttime from eq_contractclosem m"+
			" left join eq_contractclosed d on m.doc_no=d.rdocno"+
			" left join gl_rentalquotecalc calc on d.calcdocno=calc.doc_no"+
			" left join gl_equipmaster veh on calc.currentfleetno=veh.fleet_no where m.doc_no="+docno+" order by d.doc_no";
			
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return data;
	}
	public JSONArray getContractEquipData(String contractdocno,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("2")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String strsql="select  veh.reg_no assetid,calc.doc_no calcdocno,calc.contractdocno,veh.fleet_no,veh.flname,coalesce(calc.delenddate,calc.delstartdate) startdate,"+
			" coalesce(calc.delendtime,calc.delstarttime) starttime from gl_rentalquotecalc calc"+
			" left join gl_equipmaster veh on calc.currentfleetno=veh.fleet_no where contractdocno="+contractdocno+" and contractenddate is null order by calc.doc_no";
			ResultSet rs=conn.createStatement().executeQuery(strsql);
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
	public JSONArray getContractSearchData(String contractno,String hiremode,String quoteno,String contractdate,String clientname,String assetid,String id, HttpSession session) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			String brhid=session.getAttribute("BRANCHID").toString();
			conn=objconn.getMyConnection();
			String sqlfilters="";
			if(!contractno.equalsIgnoreCase("")){
				sqlfilters+=" and m.voc_no like '%"+contractno+"%'";
			}
			if(!hiremode.equalsIgnoreCase("")){
				sqlfilters+=" and m.hiremode like '%"+hiremode+"%'";
			}
			if(!quoteno.equalsIgnoreCase("")){
				sqlfilters+=" and qot.voc_no like '%"+quoteno+"%'";
			}
			if(!contractdate.equalsIgnoreCase("")){
				java.sql.Date sqldate=null;
				if(!contractdate.equalsIgnoreCase("")){
					sqldate=objcommon.changeStringtoSqlDate(contractdate);
				}
				sqlfilters+=" and m.date='"+sqldate+"'";
			}
			if(!clientname.equalsIgnoreCase("")){
				sqlfilters+=" and ac.refname like '%"+clientname+"%'";
			}
			if(!assetid.equalsIgnoreCase("")){
				sqlfilters+=" and e.reg_no like '%"+assetid+"%'";
			}
			
			String strsql="select e.reg_no assetid,coalesce(m.description,'') contractdesc,m.doc_no,m.voc_no,m.date,qot.doc_no quotedocno,qot.voc_no quotevocno,m.hiremode,ac.refname from gl_rentalcontractm m "
			+ " left join gl_rentalcontractd d on m.doc_no=d.rdocno   left join gl_rentalquoted qotd on d.quotedetdocno=qotd.doc_no left join gl_rentalquotecalc calc on (qotd.doc_no=calc.detdocno and calc.contractdocno=m.doc_no) "+
			" left join gl_equipmaster e on e.fleet_no=calc.fleet_no  left join gl_rentalquotem qot on (m.reftype='QOT' and m.refno=qot.doc_no)"+
			" left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') where m.clstatus=0 and m.status=3 and m.brhid="+brhid+" "+sqlfilters+" order by m.doc_no";
			System.out.println("contract search-->"+strsql);
			ResultSet rs=conn.createStatement().executeQuery(strsql);
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
	public int insert(ClsEquipContractCloseAction masteraction,
			HttpSession session, HttpServletRequest request, Connection conn,
			Date sqldate, ArrayList<String> closearray, String formdetailcode,
			Date sqlenddate) throws SQLException {
		// TODO Auto-generated method stub
		int docno=0,vocno=0;
		try{
			Statement stmt=conn.createStatement();
			int errorstatus=0;
			String brhid=session.getAttribute("BRANCHID").toString();
			String userid=session.getAttribute("USERID").toString();
			String strmaxdocno="select (select coalesce(max(doc_no),0)+1 from eq_contractclosem) maxdocno,(select coalesce(max(voc_no),0)+1 from eq_contractclosem where brhid="+brhid+") maxvocno";
			ResultSet rsmaxdocno=stmt.executeQuery(strmaxdocno);
			while(rsmaxdocno.next()){
				docno=rsmaxdocno.getInt("maxdocno");
				vocno=rsmaxdocno.getInt("maxvocno");
			}
			
			String strinsertmaster="insert into eq_contractclosem(doc_no,voc_no,date,brhid,userid, contractdocno, enddate, endtime,description, status)values("+
			""+docno+","+vocno+",'"+sqldate+"',"+brhid+","+userid+","+masteraction.getContractdocno()+",'"+sqlenddate+"','"+masteraction.getEndtime()+"','"+masteraction.getDesc()+"',3)";
			int insertmaster=stmt.executeUpdate(strinsertmaster);
			if(insertmaster<=0){
			//	System.out.println("Master Insert Error");
				return 0;
			}
			
			for(int i=0;i<closearray.size();i++){
				int calcdocno=Integer.parseInt(closearray.get(i));
				String strdetail="insert into eq_contractclosed(rdocno,contractdocno,calcdocno) values("+docno+","+masteraction.getContractdocno()+","+calcdocno+")";
				int detail=stmt.executeUpdate(strdetail);
				if(detail<=0){
					return 0;
				}
				String strcalc="update gl_rentalquotecalc set contractenddate='"+sqlenddate+"',contractendtime='"+masteraction.getEndtime()+"' where doc_no="+calcdocno;
				int calc=stmt.executeUpdate(strcalc);
				if(calc<=0){
					return 0;
				}
				String locid="",currentfleetno="";
				ResultSet rsgetloc=stmt.executeQuery("select (select min(doc_no) from my_locm where brhid="+brhid+") locid, (select currentfleetno from gl_rentalquotecalc where doc_no="+calcdocno+") currentfleetno");
				while(rsgetloc.next()){
					locid=rsgetloc.getString("locid");
					currentfleetno=rsgetloc.getString("currentfleetno");
				}
				String strmov="update gl_emove set status='IN',din='"+sqlenddate+"',tin='"+masteraction.getEndtime()+"',ibrhid="+brhid+",ilocid="+locid+",kmin=0,fin=0.000,ireason='Closing Contract' where rdocno="+masteraction.getContractdocno()+" and rdtype='ERC' and status='OUT' and fleet_no="+currentfleetno;
			//	System.out.println(strmov);
				int mov=stmt.executeUpdate(strmov);
				if(mov<=0){
					return 0;
				}
				String strupdateequip="update gl_equipmaster set status='IN',tran_code='UR' where fleet_no="+currentfleetno;
				int updateequip=stmt.executeUpdate(strupdateequip);
				if(updateequip<=0){
					return 0;
				}
			}
			
			//Checking All Equipments are closed
			
			String strcount="select count(*) itemcount from gl_rentalquotecalc where contractenddate is null and contractdocno="+masteraction.getContractdocno();
			int count=0;
			ResultSet rscount=stmt.executeQuery(strcount);
			while(rscount.next()){
				count=rscount.getInt("itemcount");
			}
			if(count==0){
				//Updating Contract Close Status
				String strupdatestatus="update gl_rentalcontractm set clstatus=1 where doc_no="+masteraction.getContractdocno();
				int updatestatus=stmt.executeUpdate(strupdatestatus);
				if(updatestatus<=0){
					return 0;
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			//conn.close();
		}
		request.setAttribute("VOCNO",vocno);
		return docno;
	}
}
