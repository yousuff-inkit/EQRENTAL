package com.operations.marketing.rentalcontract;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsRentalContractDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getQuoteSaveData(String docno,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			String sqlfilters="";
			
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select d.quotedetdocno detaildocno,round(sum(calc.approved)-qotd.outqty+d.qty,2) quoteqty,d.qty,round(coalesce(d.subtotal/d.qty,0),2) rate,subcat.code,subcat.doc_no subcatid,d.hiremode,round(coalesce(d.subtotal,0),2) subtotal,d.equipdesc flname,d.grpid,d.tarifdocno, d.discount, d.maxdiscount, d.total, d.vatperc, d.vatamt, d.nettotal from gl_rentalcontractm m left join gl_rentalcontractd d on m.doc_no=d.rdocno"+
			" left join gl_tarifd td on (td.gid=d.grpid and td.doc_no=d.tarifdocno and"+
			" td.renttype=m.hiremode) left join gl_vehsubcategory subcat on d.code=subcat.doc_no left join gl_rentalquoted qotd on d.quotedetdocno=qotd.doc_no left join gl_rentalquotecalc calc on"+
			" (qotd.doc_no=calc.detdocno and calc.approved=1 and calc.contractdocno=m.doc_no)where m.doc_no="+docno+" and m.status=3 GROUP BY d.doc_no";
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
	public JSONArray getRefQuoteData(HttpSession session,String quoteno,String hiremode,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("2")){
			return data;
		}
		Connection conn=null;
		try{
			String sqlfilters="";
			
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			/*String strsql="select round(d.qty-d.outqty,2) quoteqty,d.doc_no detaildocno,round(d.qty-d.outqty,2) qty,td.rate,subcat.code,subcat.doc_no subcatid,d.hiremode,round(coalesce((d.qty-d.outqty)*td.rate,0),2) subtotal,veh.fleet_no,veh.flname,d.grpid,d.tarifdocno from gl_rentalquotem m left join gl_rentalquoted d on m.doc_no=d.rdocno"+
			" left join gl_equipmaster veh on d.fleet_no=veh.fleet_no left join gl_tarifd td on (td.gid=d.grpid and td.doc_no=d.tarifdocno and"+
			" td.renttype=d.hiremode) left join gl_vehsubcategory subcat on d.code=subcat.doc_no where d.qty-d.outqty>0 and m.doc_no="+quoteno+" and m.status=3 and d.hiremode='"+hiremode+"'";
			*/
			
			String userid=session.getAttribute("USERID").toString();
	   		String uLvl="0";
									
			ResultSet rs1 = stmt.executeQuery("SELECT ulevel FROM my_user where doc_no="+userid);
			while(rs1.next()) {
				uLvl=rs1.getString("ulevel");
			} 
			
			String discCol="if("+uLvl+"='0',0,td.disclevel"+uLvl+")";
	   		
			String strsql="select base.* from (select d.outqty,sum(calc.approved) maxqty,round(sum(calc.approved)-d.outqty,2) quoteqty,d.doc_no detaildocno,round(sum(calc.approved)-d.outqty,2) qty,td.rate,subcat.code,subcat.doc_no subcatid,"+
			" d.hiremode,round(coalesce((sum(calc.approved)-d.outqty)*td.rate,0),2) subtotal,d.equipdesc flname,calc.grpid,"+
			" d.tarifdocno, d.discount, "+ discCol +"maxdiscount, d.total, d.vatperc, d.vatamt, d.nettotal from gl_rentalquotem m left join gl_rentalquoted d on m.doc_no=d.rdocno left join gl_rentalquotecalc calc on"+
			" (d.doc_no=calc.detdocno and calc.approved=1  and calc.contractdocno=0) left join gl_tarifd td on"+
			" (td.gid=d.grpid and td.doc_no=d.tarifdocno and td.renttype=d.hiremode) left join gl_vehsubcategory subcat on d.code=subcat.doc_no"+
			" where m.doc_no="+quoteno+" and m.status=3 and d.hiremode='"+hiremode+"' group by calc.detdocno) base where base.maxqty-base.outqty>0";
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
	public JSONArray getSalesmanData(String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
	   	Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();
			String clssql= ("select sal_name salesman,doc_no,coalesce(mob_no,'') mobile,coalesce(mail,'') mail from my_salm where status=3");
			ResultSet resultSet = stmtenq1.executeQuery(clssql);
			data=objcommon.convertToJSON(resultSet);
			stmtenq1.close();
			conn.close();
			return data;
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
	public JSONArray searchMaster(String branch,String qutdocno,String clientname,String refno,String qutdate,String quttype,String id,String assetid) throws SQLException {


	   	 JSONArray RESULTDATA=new JSONArray();
	   	    if(!id.equalsIgnoreCase("1")){
	   	  return RESULTDATA;
	   	     }
	   	        
	    	 //  System.out.println("8888888888"+clnames); 	
	   	 String brid=branch;
	    	
	    	
		    
	    	java.sql.Date sqlStartDate=null;
	    
	    	
	    	//enqdate.trim();
	    	if(!(qutdate.equalsIgnoreCase("undefined"))&&!(qutdate.equalsIgnoreCase(""))&&!(qutdate.equalsIgnoreCase("0")))
	    	{
	    	sqlStartDate = objcommon.changeStringtoSqlDate(qutdate);
	    	}
	    	
	    
	    	String sqltest="";
	    	if(!(qutdocno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and m.voc_no like '%"+qutdocno+"%'";
	    	}
	    	if(!(clientname.equalsIgnoreCase(""))){
	    		//sqltest=sqltest+" and  if(m.cldocno!=0,a.refname like '%"+clientname+"%',e.name like '%"+clientname+"%'  )";                                           
	    		sqltest=sqltest+" and  ac.refname like '%"+clientname+"%'";
	    	}
	    	if(!(refno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and qot.voc_no like '%"+refno+"%'";
	    	}
	    	
	    	if(!(quttype.equalsIgnoreCase(""))){
	    		
	    		sqltest=sqltest+" and m.reftype like '%"+quttype+"%'";
	    	}
	    	 if(!(sqlStartDate==null)){
	    		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
	    	} 
	        
	    	 if(!assetid.equalsIgnoreCase("")){
	    		 sqltest+=" and e.reg_no like '%"+assetid+"%'";
				}
	    	 	    	
	    	 Connection conn = null;
	 
			try {
					 conn = objconn.getMyConnection();
					Statement stmtenq1 = conn.createStatement ();
					String clssql= ("select coalesce(ac.refname,'') refname,convert(coalesce(qot.voc_no,''),char(10)) refno,m.date,concat('NAME: ',coalesce(ac.refname,''),' ADDRESS: ',coalesce(ac.address,'')) "+
			" clientdetails,m.doc_no docno,m.voc_no vocno,m.brhid,m.cldocno,coalesce(m.reftype,'') reftype,coalesce(m.refno,'') hidrefno,"+
			" coalesce(m.salid,'') salid,coalesce(sal.sal_name,'') salesman,coalesce(m.lpono,'') lpono,m.lpodate,m.hiremode,m.hirefromdate,"+
			" coalesce(m.description,'') description,round(coalesce(m.delcharges,0),2) delcharges,e.reg_no assetid from gl_rentalcontractm m left join my_acbook ac on "+
			" (m.cldocno=ac.cldocno and ac.dtype='CRM') left join my_salm sal on m.salid=sal.doc_no left join gl_rentalquotem qot on"+
			" (m.reftype='QOT' and m.refno=qot.doc_no) "
			+ "left join gl_rentalcontractd d on m.doc_no=d.rdocno "
			+ "  left join gl_rentalquoted qotd on d.quotedetdocno=qotd.doc_no "
			+ "left join gl_rentalquotecalc calc on (qotd.doc_no=calc.detdocno and calc.contractdocno=m.doc_no) "
			+ " left join gl_equipmaster e on e.fleet_no=calc.fleet_no  where m.status<>7 and m.BRHID="+brid+" "+sqltest+"  order by m.doc_no");
					/*String clssql= ("select m.DOC_NO,m.DATE,m.cldocno,m.REF_NO,m.REF_TYPE,m.ATTN_TO,m.contact_no ,m.REMARKS,m.NETTOTAL,m.userid,m.email, "
							+ "a.refname ,a.address from gl_quotm m left join my_acbook a on a.cldocno=m.cldocno and dtype='CRM' where m.status<>7 and m.branch="+brid+" " +sqltest);*/
			//	System.out.println("contractcreatesearch--->"+clssql);
					ResultSet resultSet = stmtenq1.executeQuery(clssql);
					
					RESULTDATA=objcommon.convertToJSON(resultSet);
					stmtenq1.close();
					conn.close();
					  return RESULTDATA;
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
				conn.close();
			}
			//System.out.println(RESULTDATA);
			  return RESULTDATA;
	    }
	public JSONArray getQuoteData(String docno,String date,String attention,String cldocno,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			String sqlfilters="";
			if(!docno.trim().equalsIgnoreCase("")){
				sqlfilters+=" and m.voc_no like '%"+docno+"%'";
			}
			if(!date.trim().equalsIgnoreCase("")){
				java.sql.Date sqldate=null;
				sqldate=objcommon.changeStringtoSqlDate(date);
				sqlfilters+=" and m.date='"+sqldate+"'";
			}
			if(!attention.trim().equalsIgnoreCase("")){
				sqlfilters+=" and m.attention like '%"+attention+"%'";
			}
			if(!cldocno.equalsIgnoreCase("")){
				sqlfilters+=" and m.cldocno="+cldocno;
			}
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select * from (select coalesce(sum(calc.approved),0) maxqty,d.outqty outqty,round(coalesce(m.delcharges,0),2) delcharges,"+
			"round(coalesce(m.collcharges,0),2) collcharges,round(coalesce(m.vatamt,0),2) vatamt,round(coalesce(m.totalamt,0),2) totalamt,coalesce(m.delremark,'')delremark,"+
			" m.date,m.doc_no,m.voc_no,coalesce(m.attention,'') attention,coalesce(m.description,'') description,round(coalesce(m.srvcharges,0),2) srvcharges,coalesce(m.srvdesc,'')srvdesc from gl_rentalquotem m left join "+
			" gl_rentalquoted d on m.doc_no=d.rdocno left join gl_rentalquotecalc calc on (d.doc_no=calc.detdocno and calc.approved=1 and calc.contractdocno=0)"+
			" where m.status=3 and m.followupstatus<>2 group by m.doc_no) base where base.maxqty-base.outqty>0";
			//System.out.println(strsql);
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
	public JSONArray searchClientData(String branch,String clname,String mob,String id) throws SQLException {
	   	 JSONArray RESULTDATA=new JSONArray();
	   	 
	   	    if(!id.equalsIgnoreCase("1")){
	   	  return RESULTDATA;
	   	     }
	   	        
	    	    	
	   	 String brid=branch;
	    	
	    	//System.out.println("name"+clname);
	    	
	    	String sqltest="";
	    	
	    	if(!(clname.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and ac.refname like '%"+clname+"%'";
	    	}
	    	if(!(mob.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and ac.per_mob like '%"+mob+"%'";
	    	}
	    	
	        
	    	Connection conn = null;
			try {
					 conn = objconn.getMyConnection();
					Statement stmtVeh1 = conn.createStatement ();
	            	
					String clsql= ("select ac.sal_id salid,coalesce(sal.sal_name,'') salesman,ac.cldocno,ac.refname,trim(coalesce(ac.address,'')) address,coalesce(ac.per_mob,'') per_mob,trim(coalesce(ac.mail1,'')) mail1 from my_acbook ac left join my_salm sal on ac.sal_id=sal.doc_no where  dtype='CRM' and ac.status=3 " +sqltest);
					System.out.println("========"+clsql);
					ResultSet resultSet = stmtVeh1.executeQuery(clsql);
					
					RESULTDATA=objcommon.convertToJSON(resultSet);
					stmtVeh1.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	
	public JSONArray getTariffData(String branch,String vehgpid,String cldocno,String id,String rentaltype) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
	   	if(!id.equalsIgnoreCase("1")){
	   		return RESULTDATA;
		}
		Connection conn=null;
	   	try{
	   		conn = objconn.getMyConnection();
	   		Statement stmtVeh = conn.createStatement ();
	   		String brch=branch;
	   		String sqlfilters="";
	   		if(!rentaltype.equalsIgnoreCase("")){
	   			sqlfilters+=" and m1.renttype='"+rentaltype+"'";
	   		}
	   	    String sqltari=("select coalesce(m1.rate,0) rate,m.doc_no,m.validto,concat(m.tariftype,' - ',m.notes) tariftype,m.clientid, coalesce(insurexcess,0) insurexcess, coalesce(cdwexcess,0) cdwexcess,  "
			+ "	coalesce(scdwexcess,0) scdwexcess from gl_tarifm  m left join gl_tarifd m1 on m1.doc_no=m.doc_no left join  "
			+ "	gl_tarifexcess t on t.rdocno=m.doc_no and t.gid='"+vehgpid+"' where    current_date between m.validfrm and m.validto and m.status=3 and "
			+ "  (m1.gid='"+vehgpid+"' or t.gid='"+vehgpid+"') and m.tariftype='regular' "+sqlfilters+" group by m.doc_no   union all "
			+ " select aa.rate,aa.doc_no,aa.validto,concat(aa.tariftype,' ',ca.cat_name,' - ',aa.notes) tariftype,aa.clientid, aa.insurexcess, aa.cdwexcess, aa.scdwexcess from "
			+ "   (select coalesce(m1.rate,0) rate,m.doc_no,m.validto,m.tariftype,m.clientid, coalesce(insurexcess,0) insurexcess, coalesce(cdwexcess,0) cdwexcess, "
			+ "   coalesce(scdwexcess,0) scdwexcess,m.notes    from gl_tarifm  m left join gl_tarifd m1 on m1.doc_no=m.doc_no left join  "
			+ "  	gl_tarifexcess t on t.rdocno=m.doc_no and t.gid='"+vehgpid+"' where   current_date between m.validfrm and m.validto  "
			+ " and m.status=3 and  (m1.gid='"+vehgpid+"' or t.gid='"+vehgpid+"') and m.tariftype='corporate' "+sqlfilters+" group by m.doc_no) aa "
			+ " inner join (select * from my_acbook cl where cl.dtype='CRM' and cl.doc_no='"+cldocno+"') bb  "
			+ "	on aa.tariftype='corporate' and aa.clientid=bb.catid left join my_clcatm ca on ca.doc_no=bb.catid    union all  "
			+ " select coalesce(m1.rate,0) rate,m.doc_no,m.validto,concat(m.tariftype,' - ',m.notes) tariftype,m.clientid, coalesce(insurexcess,0) insurexcess, coalesce(cdwexcess,0) cdwexcess,   "
			+ " coalesce(scdwexcess,0) scdwexcess from gl_tarifm  m left join gl_tarifd m1 on m1.doc_no=m.doc_no left join  "
			+ "gl_tarifexcess t on t.rdocno=m.doc_no and t.gid='"+vehgpid+"' where  current_date between m.validfrm and m.validto  "
			+ "  and m.status=3  and  (m1.gid='"+vehgpid+"' or t.gid='"+vehgpid+"') and m.tariftype='Client' and m.clientid='"+cldocno+"' "+sqlfilters+" group by m.doc_no ") ;
	   					
	   		//System.out.println("=========1111========="+sqltari);
	   		// gl_tarifexcess for cdw ,super cdw  insu
	   			
	   		ResultSet resultSet = stmtVeh.executeQuery(sqltari);
	   		RESULTDATA=objcommon.convertToJSON(resultSet);
	   		conn.close();
	   	}
	   	catch(Exception e){
	   		e.printStackTrace();
	   		conn.close();
	   	}
	   	finally{
	   		conn.close();
	   	}
	   	return RESULTDATA;
	}
	public JSONArray getEquipData(String docno,String fleetname,String fleetno,String regno,String searchdate,HttpSession session,
			String engine,String chassis,String id) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn=null;
        if(!id.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }
    	    	// String brnchid=session.getAttribute("BRANCHID").toString();
    	//System.out.println("name"+sclname);
    	try{
    		conn=objconn.getMyConnection();
    	String sqltest="";
    	java.sql.Date sqldate=null;
    	if(!(searchdate.equalsIgnoreCase(""))){
    		sqldate=objcommon.changeStringtoSqlDate(searchdate);	
    	}
    	if(!(docno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and doc_no like '%"+docno+"%'";
    	}
    	if(!(fleetname.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and flname like '%"+fleetname+"%'";
    	}
    	
    	if(!(fleetno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and fleet_no like '%"+fleetno+"%'";
    	}
    	if(!(regno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and reg_no like '%"+regno+"%'";
    	}
    	if(!engine.equalsIgnoreCase("")){
    		sqltest=sqltest+" and eng_no like '%"+engine+"%'";
    	}
    	
    	if(!chassis.equalsIgnoreCase("")){
    		sqltest=sqltest+" and ch_no like  '%"+chassis+"%'";
    	}
    	
    	 if(sqldate!=null){
    		 sqltest=sqltest+" and date='"+sqldate+"'";
    	 }
        
     
		
				Statement stmtsearch = conn.createStatement();
					String str1Sql="select sub.doc_no subcatid,sub.code,sub.doc_no subcatid,veh.vgrpid grpid,veh.eng_no engine,veh.ch_no chassis,veh.doc_no,veh.date,veh.reg_no,veh.fleet_no,veh.flname from gl_equipmaster veh left join gl_vehsubcategory sub on veh.subcatid=sub.doc_no where veh.statu<>7 and veh.dtype='EEM' "+sqltest+"";
					System.out.println("======="+str1Sql);
					ResultSet resultSet = stmtsearch.executeQuery(str1Sql);
					RESULTDATA=objcommon.convertToJSON(resultSet);
					stmtsearch.close();
					conn.close();
					return RESULTDATA;	
				
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
		conn.close();
        return RESULTDATA;
    }

	public int insert(ClsRentalContractAction masteraction, HttpSession session,
			HttpServletRequest request, Connection conn, Date sqldate,ArrayList<String> quotearray,String dtype,Date sqllpodate,Date sqlhirefromdate) {
		// TODO Auto-generated method stub
		int docno=0;
		int vocno=0;
		try{
			Statement stmt=conn.createStatement();
			
			String brhid=session.getAttribute("BRANCHID").toString();
			String userid=session.getAttribute("USERID").toString();
			String strmaxdocno="select (select coalesce(max(doc_no),0)+1 from gl_rentalcontractm) maxdocno,(select coalesce(max(voc_no),0)+1 from gl_rentalcontractm where brhid="+brhid+") maxvocno";
			ResultSet rsmaxdocno=stmt.executeQuery(strmaxdocno);
			while(rsmaxdocno.next()){
				docno=rsmaxdocno.getInt("maxdocno");
				vocno=rsmaxdocno.getInt("maxvocno");
			}
			
			masteraction.setDelcharges(masteraction.getDelcharges().trim().equalsIgnoreCase("")?"0.00":masteraction.getDelcharges());
			masteraction.setCollcharges(masteraction.getCollcharges().trim().equalsIgnoreCase("")?"0.00":masteraction.getCollcharges());
			masteraction.setVatamt(masteraction.getVatamt().trim().equalsIgnoreCase("")?"0.00":masteraction.getVatamt());
			masteraction.setTotalamt(masteraction.getTotalamt().trim().equalsIgnoreCase("")?"0.00":masteraction.getTotalamt());
			masteraction.setSrvcharges(masteraction.getSrvcharges().trim().equalsIgnoreCase("")?"0.00":masteraction.getSrvcharges());
			
			String strinsertmaster="insert into gl_rentalcontractm(doc_no, voc_no, date, brhid, userid, cldocno, reftype, refno, salid, hirefromdate,"+
			" hiremode,lpono,lpodate, description, delcharges, collcharges, vatamt, totalamt, delremark, srvcharges, srvdesc, status)values("+
			""+docno+","+vocno+",'"+sqldate+"',"+brhid+","+userid+","+masteraction.getCldocno()+",'"+masteraction.getCmbreftype()+"','"+(masteraction.getHidrefno().equalsIgnoreCase("")?"0":masteraction.getHidrefno())+"','"+masteraction.getHidsalesman()+"','"+sqlhirefromdate+"','"+masteraction.getCmbhiremode()+"',"+
			" '"+masteraction.getLpono()+"','"+sqllpodate+"','"+masteraction.getDesc()+"',"+masteraction.getDelcharges()+","+masteraction.getCollcharges()+","+masteraction.getVatamt()+","+masteraction.getTotalamt()+",'"+masteraction.getDelremark()+"',"+masteraction.getSrvcharges()+",'"+masteraction.getSrvdesc()+"',3)";
			int insertmaster=stmt.executeUpdate(strinsertmaster);
			if(insertmaster<=0){
				System.out.println("Master Insert Error");
				return 0;
			}
			for(int i=0,j=1;i<quotearray.size();i++,j++){
				String temp[]=quotearray.get(i).split("::");
				String code=temp[0]==null || temp[0].trim().equalsIgnoreCase("") || temp[0].trim().equalsIgnoreCase("undefined") || temp[0].trim().isEmpty()?"0":temp[0].trim();
				String grpid=temp[1]==null || temp[1].trim().equalsIgnoreCase("") || temp[1].trim().equalsIgnoreCase("undefined") || temp[1].trim().isEmpty()?"0":temp[1].trim();
				String tarifdocno=temp[2]==null || temp[2].trim().equalsIgnoreCase("") || temp[2].trim().equalsIgnoreCase("undefined") || temp[2].trim().isEmpty()?"0":temp[2].trim();
				String qty=temp[3]==null || temp[3].trim().equalsIgnoreCase("") || temp[3].trim().equalsIgnoreCase("undefined") || temp[3].trim().isEmpty()?"0":temp[3].trim();
				String hiremode=temp[4]==null || temp[4].trim().equalsIgnoreCase("") || temp[4].trim().equalsIgnoreCase("undefined") || temp[4].trim().isEmpty()?"0":temp[4].trim();
				String subtotal=temp[5]==null || temp[5].trim().equalsIgnoreCase("") || temp[5].trim().equalsIgnoreCase("undefined") || temp[5].trim().isEmpty()?"0":temp[5].trim();
				String maxdiscount=temp[6]==null || temp[6].trim().equalsIgnoreCase("") || temp[6].trim().equalsIgnoreCase("undefined") || temp[6].trim().isEmpty()?"0":temp[6].trim();
				String discount=temp[7]==null || temp[7].trim().equalsIgnoreCase("") || temp[7].trim().equalsIgnoreCase("undefined") || temp[7].trim().isEmpty()?"0":temp[7].trim();				
				String total=temp[8]==null || temp[8].trim().equalsIgnoreCase("") || temp[8].trim().equalsIgnoreCase("undefined") || temp[8].trim().isEmpty()?"0":temp[8].trim();
				String vatperc=temp[9]==null || temp[9].trim().equalsIgnoreCase("") || temp[9].trim().equalsIgnoreCase("undefined") || temp[9].trim().isEmpty()?"0":temp[9].trim();
				String vatamt=temp[10]==null || temp[10].trim().equalsIgnoreCase("") || temp[10].trim().equalsIgnoreCase("undefined") || temp[10].trim().isEmpty()?"0":temp[10].trim();
				String nettotal=temp[11]==null || temp[11].trim().equalsIgnoreCase("") || temp[11].trim().equalsIgnoreCase("undefined") || temp[11].trim().isEmpty()?"0":temp[11].trim();
				String equipdesc=temp[12]==null || temp[12].trim().equalsIgnoreCase("") || temp[12].trim().equalsIgnoreCase("undefined") || temp[12].trim().isEmpty()?"0":temp[12].trim();
				String detaildocno=temp[13]==null || temp[13].trim().equalsIgnoreCase("") || temp[13].trim().equalsIgnoreCase("undefined") || temp[13].trim().isEmpty()?"0":temp[13].trim();
				
				String strinsertdetail="insert into gl_rentalcontractd(rdocno, srno, code,grpid, tarifdocno, status,qty,hiremode,subtotal,discount,total,vatperc,vatamt,nettotal,maxdiscount,quotedetdocno,equipdesc)values("+
				""+docno+","+j+","+code+","+grpid+","+tarifdocno+",3,"+qty+",'"+hiremode+"',"+subtotal+","+discount+","+total+","+vatperc+","+vatamt+","+nettotal+","+maxdiscount+","+detaildocno+",'"+equipdesc+"')";
				int insertdetail=stmt.executeUpdate(strinsertdetail);
				if(insertdetail<=0){
					System.out.println("Detail Insert Error");
					return 0;
				}
				if(masteraction.getCmbreftype().trim().equalsIgnoreCase("QOT") && !masteraction.getRefno().trim().equalsIgnoreCase("")){
					String strupdatequote="update gl_rentalquoted set outqty=(outqty+"+qty+") where doc_no="+detaildocno+" and rdocno="+masteraction.getHidrefno();
					int updatequote=stmt.executeUpdate(strupdatequote);
					if(updatequote<0){
						System.out.println("Quote Detail Update Error");
						return 0;
					}
					//Updating Contract No
					String strupdatequotecalc="update gl_rentalquotecalc set contractdocno="+docno+" where detdocno="+detaildocno+" and approved=1";
					int updatequotecalc=stmt.executeUpdate(strupdatequotecalc);
					if(updatequotecalc<0){
						System.out.println("Quote Calc Update Error");
						return 0;
					}
				}
				
			}
			
			PreparedStatement stmtlog=conn.prepareStatement("insert into datalog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
			stmtlog.setInt(1,docno);
			stmtlog.setInt(2,Integer.parseInt(brhid));
			stmtlog.setString(3,dtype);
			stmtlog.setInt(4, Integer.parseInt(userid));
			stmtlog.setInt(5, 0);
			stmtlog.setInt(6, 0);
			stmtlog.setString(7, "A");
			int log=stmtlog.executeUpdate();
			if(log<=0){
				System.out.println("Log Insert Error");
				return 0;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			return 0;
		}
		request.setAttribute("VOCNO",vocno);
		return docno;
	}
	public boolean edit(ClsRentalContractAction masteraction, HttpSession session,
			HttpServletRequest request, Connection conn, Date sqldate,
			ArrayList<String> quotearray, String formdetailcode, String docno,Date sqllpodate,Date sqlhirefromdate) {
		// TODO Auto-generated method stub
		try{
			Statement stmt=conn.createStatement();
			
			String brhid=session.getAttribute("BRANCHID").toString();
			String userid=session.getAttribute("USERID").toString();
			
			String strupdatemaster="update gl_rentalcontractm set date='"+sqldate+"', brhid="+brhid+", userid="+userid+", cldocno="+masteraction.getCldocno()+", reftype='"+masteraction.getCmbreftype()+"', refno='"+(masteraction.getHidrefno().equalsIgnoreCase("")?"0":masteraction.getHidrefno())+"', salid='"+masteraction.getHidsalesman()+"', hirefromdate='"+sqlhirefromdate+"',hiremode='"+masteraction.getCmbhiremode()+"',lpono='"+masteraction.getLpono()+"',lpodate='"+sqllpodate+"', description='"+masteraction.getDesc()+"', delcharges="+(masteraction.getDelcharges().equalsIgnoreCase("")?"0.00":masteraction.getDelcharges())+", collcharges ="+masteraction.getCollcharges()+",vatamt="+masteraction.getVatamt()+",totalamt="+masteraction.getTotalamt()+", delremark='"+masteraction.getDelremark()+"', srvcharges="+masteraction.getSrvcharges()+", srvdesc='"+masteraction.getSrvdesc()+"' where doc_no="+docno;
			int updatemaster=stmt.executeUpdate(strupdatemaster);
			if(updatemaster<=0){
				System.out.println("Master Update Error");
				return false;
			}
			
			for(int i=0,j=1;i<quotearray.size();i++,j++){
				String temp[]=quotearray.get(i).split("::");
				String detaildocno=temp[13]==null || temp[13].trim().equalsIgnoreCase("") || temp[13].trim().equalsIgnoreCase("undefined") || temp[13].trim().isEmpty()?"0":temp[13].trim();
				
				if(Integer.parseInt(detaildocno)!=0){
				int contractqty=0;
				String strcontractqty="select qty from gl_rentalcontractd where quotedetdocno="+detaildocno+" and rdocno="+docno;
				System.out.println(strcontractqty);
				ResultSet rscontractqty=stmt.executeQuery(strcontractqty);
				while(rscontractqty.next()){
					contractqty=rscontractqty.getInt("qty");
				}
				String strinsertdetail="update gl_rentalquoted set outqty=(outqty-"+contractqty+") where doc_no="+detaildocno;
				System.out.println(strinsertdetail);
				int insertdetail=stmt.executeUpdate(strinsertdetail);
				if(insertdetail<=0){
					System.out.println("Detail Qty Update Error");
					return false;
				}
				}
			}
			
			int deletedetail=stmt.executeUpdate("delete from gl_rentalcontractd where rdocno="+docno);
			for(int i=0,j=1;i<quotearray.size();i++,j++){
				String temp[]=quotearray.get(i).split("::");
				String code=temp[0]==null || temp[0].trim().equalsIgnoreCase("") || temp[0].trim().equalsIgnoreCase("undefined") || temp[0].trim().isEmpty()?"0":temp[0].trim();
				String grpid=temp[1]==null || temp[1].trim().equalsIgnoreCase("") || temp[1].trim().equalsIgnoreCase("undefined") || temp[1].trim().isEmpty()?"0":temp[1].trim();
				String tarifdocno=temp[2]==null || temp[2].trim().equalsIgnoreCase("") || temp[2].trim().equalsIgnoreCase("undefined") || temp[2].trim().isEmpty()?"0":temp[2].trim();
				String qty=temp[3]==null || temp[3].trim().equalsIgnoreCase("") || temp[3].trim().equalsIgnoreCase("undefined") || temp[3].trim().isEmpty()?"0":temp[3].trim();
				String hiremode=temp[4]==null || temp[4].trim().equalsIgnoreCase("") || temp[4].trim().equalsIgnoreCase("undefined") || temp[4].trim().isEmpty()?"0":temp[4].trim();
				String subtotal=temp[5]==null || temp[5].trim().equalsIgnoreCase("") || temp[5].trim().equalsIgnoreCase("undefined") || temp[5].trim().isEmpty()?"0":temp[5].trim();
				String maxdiscount=temp[6]==null || temp[6].trim().equalsIgnoreCase("") || temp[6].trim().equalsIgnoreCase("undefined") || temp[6].trim().isEmpty()?"0":temp[6].trim();
				String discount=temp[7]==null || temp[7].trim().equalsIgnoreCase("") || temp[7].trim().equalsIgnoreCase("undefined") || temp[7].trim().isEmpty()?"0":temp[7].trim();
				String total=temp[8]==null || temp[8].trim().equalsIgnoreCase("") || temp[8].trim().equalsIgnoreCase("undefined") || temp[8].trim().isEmpty()?"0":temp[8].trim();
				String vatperc=temp[9]==null || temp[9].trim().equalsIgnoreCase("") || temp[9].trim().equalsIgnoreCase("undefined") || temp[9].trim().isEmpty()?"0":temp[9].trim();
				String vatamt=temp[10]==null || temp[10].trim().equalsIgnoreCase("") || temp[10].trim().equalsIgnoreCase("undefined") || temp[10].trim().isEmpty()?"0":temp[10].trim();
				String nettotal=temp[11]==null || temp[11].trim().equalsIgnoreCase("") || temp[11].trim().equalsIgnoreCase("undefined") || temp[11].trim().isEmpty()?"0":temp[11].trim();
				String equipdesc=temp[12]==null || temp[12].trim().equalsIgnoreCase("") || temp[12].trim().equalsIgnoreCase("undefined") || temp[12].trim().isEmpty()?"0":temp[12].trim();
				String detaildocno=temp[13]==null || temp[13].trim().equalsIgnoreCase("") || temp[13].trim().equalsIgnoreCase("undefined") || temp[13].trim().isEmpty()?"0":temp[13].trim();
				
				String strinsertdetail="insert into gl_rentalcontractd(rdocno, srno, code,grpid, tarifdocno, status,qty,hiremode,subtotal,discount,total,vatperc,vatamt,nettotal,maxdiscount,quotedetdocno,equipdesc)values("+
				""+docno+","+j+","+code+","+grpid+","+tarifdocno+",3,"+qty+",'"+hiremode+"',"+subtotal+","+discount+","+total+","+vatperc+","+vatamt+","+nettotal+","+maxdiscount+","+detaildocno+",'"+equipdesc+"')";
								
				int insertdetail=stmt.executeUpdate(strinsertdetail);
				if(insertdetail<=0){
					System.out.println("Detail Insert Error");
					return false;
				}
				if(masteraction.getCmbreftype().trim().equalsIgnoreCase("QOT") && !masteraction.getRefno().trim().equalsIgnoreCase("")){
					String strupdatequote="update gl_rentalquoted set outqty=(outqty+"+qty+") where doc_no="+detaildocno+" and rdocno="+masteraction.getHidrefno();
					int updatequote=stmt.executeUpdate(strupdatequote);
					if(updatequote<0){
						System.out.println("Quote Detail Update Error");
						return false;
					}
					//Updating Contract No
					String strupdatequotecalc="update gl_rentalquotecalc set contractdocno="+docno+" where detdocno="+detaildocno+"  and approved=1";
					int updatequotecalc=stmt.executeUpdate(strupdatequotecalc);
					if(updatequotecalc<0){
						System.out.println("Quote Calc Update Error");
						return false;
					}
				}
			}
			
			PreparedStatement stmtlog=conn.prepareStatement("insert into datalog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
			stmtlog.setInt(1,Integer.parseInt(docno));
			stmtlog.setInt(2,Integer.parseInt(brhid));
			stmtlog.setString(3,masteraction.getFormdetailcode());
			stmtlog.setInt(4, Integer.parseInt(userid));
			stmtlog.setInt(5, 0);
			stmtlog.setInt(6, 0);
			stmtlog.setString(7, "E");
			int log=stmtlog.executeUpdate();
			if(log<=0){
				System.out.println("Log Insert Error");
				return false;
			}
	}
	catch(Exception e){
		e.printStackTrace();
		return false;
	}
		return true;
	}
	public boolean delete(ClsRentalContractAction masteraction,
			HttpSession session, HttpServletRequest request, Connection conn,
			String formdetailcode, String docno) {
		// TODO Auto-generated method stub
		try{
			Statement stmt=conn.createStatement();

			String brhid=session.getAttribute("BRANCHID").toString();
			String userid=session.getAttribute("USERID").toString();
			//Checking if Quotation updated with corresponding contract
			ResultSet rsquote=stmt.executeQuery("select count(*) itemcount from gl_rentalquoted where contractdocno="+docno);
			int itemcount=0;
			while(rsquote.next()){
				itemcount=rsquote.getInt("itemcount");
			}
			if(itemcount>0){
				System.out.println("References Present in Quotation Error");
				return false;
			}
			String strupdatemaster="update gl_rentalquotem set status=7 where doc_no="+docno;
			int updatemaster=stmt.executeUpdate(strupdatemaster);
			if(updatemaster<=0){
				System.out.println("Master Update Error");
				return false;
			}
			String strupdatedetail="update gl_rentalquoted set status=7 where rdocno="+docno;
			int updatedetail=stmt.executeUpdate(strupdatedetail);
			if(updatedetail<=0){
				System.out.println("Detail Update Error");
				return false;
			}
			PreparedStatement stmtlog=conn.prepareStatement("insert into datalog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
			stmtlog.setInt(1,Integer.parseInt(docno));
			stmtlog.setInt(2,Integer.parseInt(brhid));
			stmtlog.setString(3,masteraction.getFormdetailcode());
			stmtlog.setInt(4, Integer.parseInt(userid));
			stmtlog.setInt(5, 0);
			stmtlog.setInt(6, 0);
			stmtlog.setString(7, "D");
			int log=stmtlog.executeUpdate();
			if(log<=0){
				System.out.println("Log Insert Error");
				return false;
			}
			else{
				return true;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
	public ClsRentalContractBean getViewDetails(String docno) throws SQLException {
		// TODO Auto-generated method stub
		ClsRentalContractBean bean=new ClsRentalContractBean();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select coalesce(qot.voc_no,'') refno,m.date,concat('NAME: ',coalesce(ac.refname,''),' ADDRESS: ',coalesce(ac.address,'')) "+
			" clientdetails,m.doc_no docno,m.voc_no vocno,m.brhid,m.cldocno,coalesce(m.reftype,'') reftype,coalesce(m.refno,'') hidrefno,"+
			" coalesce(m.salid,'') salid,coalesce(sal.sal_name,'') salesman,coalesce(m.lpono,'') lpono,m.lpodate,m.hiremode,m.hirefromdate,"+
			" coalesce(m.description,'') description,round(coalesce(m.delcharges,0),2) delcharges, round(coalesce(m.collcharges,0),2) collcharges,round(coalesce(m.vatamt,0),2) vatamt,round(coalesce(m.totalamt,0),2) totalamt,coalesce(m.delremark,'')delremark,"+
		    " round(coalesce(m.srvcharges,0),2) srvcharges,coalesce(m.srvdesc,'')srvdesc from gl_rentalcontractm m left join my_acbook ac on "+
			" (m.cldocno=ac.cldocno and ac.dtype='CRM') left join my_salm sal on m.salid=sal.doc_no left join gl_rentalquotem qot on"+
			" (m.reftype='QOT' and m.refno=qot.doc_no) where m.doc_no="+docno+" and m.status!=7";
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				bean.setClientdetails(rs.getString("clientdetails"));
				bean.setDocno(rs.getString("docno"));
				bean.setVocno(rs.getString("vocno"));
				bean.setDate(rs.getDate("date").toString());
				bean.setRefno(rs.getString("refno"));
				bean.setHidcmbreftype(rs.getString("reftype"));
				bean.setHidrefno(rs.getString("hidrefno"));
				bean.setHidsalesman(rs.getString("salid"));
				bean.setSalesman(rs.getString("salesman"));
				bean.setLpono(rs.getString("lpono"));
				bean.setLpodate(rs.getDate("lpodate").toString());
				bean.setHidcmbhiremode(rs.getString("hiremode"));
				bean.setHirefromdate(rs.getDate("hirefromdate").toString());
				bean.setDesc(rs.getString("description"));
				bean.setDelcharges(rs.getString("delcharges"));
				bean.setCollcharges(rs.getString("collcharges"));
				bean.setVatamt(rs.getString("vatamt"));
				bean.setTotalamt(rs.getString("totalamt"));
				bean.setDelremark(rs.getString("delremark"));
				bean.setSrvcharges(rs.getString("srvcharges"));
				bean.setSrvdesc(rs.getString("srvdesc"));
				bean.setCldocno(rs.getString("cldocno"));
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
