package com.operations.marketing.rentalquote;

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
import com.operations.marketing.quotation.ClsquotationBean;

import net.sf.json.JSONArray;

public class ClsRentalQuoteDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray searchMaster(String branch,String qutdocno,String clientname,String clmob,String qutdate,String quttype,String id) throws SQLException {


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
	    	if(!(clmob.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and m.contactnumber like '%"+clmob+"%'";
	    	}
	    	
	    	if(!(quttype.equalsIgnoreCase(""))){
	    		
	    		sqltest=sqltest+" and m.rentaltype like '%"+quttype+"%'";
	    	}
	    	 if(!(sqlStartDate==null)){
	    		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
	    	} 
	        
	    	
	    	 	    	
	    	 Connection conn = null;
	 
			try {
					 conn = objconn.getMyConnection();
					Statement stmtenq1 = conn.createStatement ();
					String clssql= ("select coalesce(ac.refname,'') refname,m.date,m.doc_no docno,m.voc_no vocno,m.brhid,m.cldocno,coalesce(m.contactperson,'') contactperson,coalesce(m.contactnumber,'')"+
							" contactnumber,coalesce(m.attention,'') attention,coalesce(m.subject,'') subject,coalesce(m.description,'') description,m.rentaltype from "
							+ "gl_rentalquotem m left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') where m.status<>7 and m.BRHID="+brid+" " +sqltest+" order by m.doc_no");
					/*String clssql= ("select m.DOC_NO,m.DATE,m.cldocno,m.REF_NO,m.REF_TYPE,m.ATTN_TO,m.contact_no ,m.REMARKS,m.NETTOTAL,m.userid,m.email, "
							+ "a.refname ,a.address from gl_quotm m left join my_acbook a on a.cldocno=m.cldocno and dtype='CRM' where m.status<>7 and m.branch="+brid+" " +sqltest);*/
				
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
	public JSONArray getQuoteData(String docno,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select d.qty,td.rate,subcat.code,subcat.doc_no subcatid,d.hiremode,round(coalesce(d.subtotal,0),2) subtotal,d.equipdesc flname,d.grpid,d.tarifdocno, d.discount, d.maxdiscount, d.total, d.vatperc, d.vatamt, d.nettotal from gl_rentalquotem m left join gl_rentalquoted d on m.doc_no=d.rdocno"+
			" left join gl_tarifd td on (td.gid=d.grpid and td.doc_no=d.tarifdocno and"+
			" td.renttype=d.hiremode) left join gl_vehsubcategory subcat on d.code=subcat.doc_no where m.doc_no="+docno+"";
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
	public  JSONArray searchClientData(String branch,String clname,String mob,String id) throws SQLException {
	   	 JSONArray RESULTDATA=new JSONArray();
	   	 
	   	    if(!id.equalsIgnoreCase("1")){
	   	  return RESULTDATA;
	   	     }
	   	        
	    	    	
	   	 String brid=branch;
	    	
	    	
	    	    	
	    	
	    		
	    	
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
					 conn = objconn.getMyConnection();
					Statement stmtVeh1 = conn.createStatement ();
					
					String clsql= ("select cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);
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
	
	public  JSONArray getTariffData(HttpSession session,String branch,String vehgpid,String cldocno,String id,String rentaltype) throws SQLException {
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
	   		
	   		String userid=session.getAttribute("USERID").toString();
	   		String uLvl="0";
									
			ResultSet rs = stmtVeh.executeQuery("SELECT ulevel FROM my_user where doc_no="+userid);
			while(rs.next()) {
				uLvl=rs.getString("ulevel");
			} 
			
			String discCol="if("+uLvl+"='0',0,m1.disclevel"+uLvl+")";
	   					
	   	    String sqltari=("select coalesce(m1.rate,0) rate,m.doc_no,m.validto,concat(m.tariftype,' - ',m.notes) tariftype,m.clientid, 0 insurexcess, 0 cdwexcess,  "
			+ "	0 scdwexcess, "+discCol+" maxdiscount from gl_tarifm  m left join gl_tarifd m1 on m1.doc_no=m.doc_no where current_date between m.validfrm and m.validto and m.status=3 and "
			+ " (m1.gid='"+vehgpid+"' ) and m.tariftype='regular' "+sqlfilters+" group by m.doc_no   union all "
			+ " select aa.rate,aa.doc_no,aa.validto,concat(aa.tariftype,' ',ca.cat_name,' - ',aa.notes) tariftype,aa.clientid, aa.insurexcess, aa.cdwexcess, aa.scdwexcess, maxdiscount from "
			+ " (select coalesce(m1.rate,0) rate,m.doc_no,m.validto,m.tariftype,m.clientid,  0 insurexcess, 0 cdwexcess,  "
			+ "	0 scdwexcess,m.notes, "+discCol+" maxdiscount from gl_tarifm  m left join gl_tarifd m1 on m1.doc_no=m.doc_no  where   current_date between m.validfrm and m.validto  "
			+ " and m.status=3 and  (m1.gid='"+vehgpid+"' ) and m.tariftype='corporate' "+sqlfilters+" group by m.doc_no) aa "
			+ " inner join (select * from my_acbook cl where cl.dtype='CRM' and cl.doc_no='"+cldocno+"') bb  "
			+ "	on aa.tariftype='corporate' and aa.clientid=bb.catid left join my_clcatm ca on ca.doc_no=bb.catid    union all  "
			+ " select coalesce(m1.rate,0) rate,m.doc_no,m.validto,concat(m.tariftype,' - ',m.notes) tariftype,m.clientid, 0 insurexcess, 0 cdwexcess,  "
			+ "	0 scdwexcess, "+discCol+" maxdiscount from gl_tarifm  m left join gl_tarifd m1 on m1.doc_no=m.doc_no  "
			+ "  where  current_date between m.validfrm and m.validto  "
			+ " and m.status=3  and  (m1.gid='"+vehgpid+"' ) and m.tariftype='Client' and m.clientid='"+cldocno+"' "+sqlfilters+" group by m.doc_no ") ;
	   					
	   		System.out.println("=========1111========="+sqltari);
	   			
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
	public  JSONArray getEquipData(String docno,String fleetname,String fleetno,String regno,String searchdate,HttpSession session,
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
    		sqltest=sqltest+" and veh.doc_no like '%"+docno+"%'";
    	}
    	if(!(fleetname.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and veh.flname like '%"+fleetname+"%'";
    	}
    	
    	if(!(fleetno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and veh.fleet_no like '%"+fleetno+"%'";
    	}
    	if(!(regno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and veh.reg_no like '%"+regno+"%'";
    	}
    	if(!engine.equalsIgnoreCase("")){
    		sqltest=sqltest+" and veh.eng_no like '%"+engine+"%'";
    	}
    	
    	if(!chassis.equalsIgnoreCase("")){
    		sqltest=sqltest+" and veh.ch_no like  '%"+chassis+"%'";
    	}
    	
    	 if(sqldate!=null){
    		 sqltest=sqltest+" and veh.date='"+sqldate+"'";
    	 }
		Statement stmtsearch = conn.createStatement();
		String str1Sql="select sub.doc_no subcatid,sub.code,sub.doc_no subcatid,veh.vgrpid grpid,veh.eng_no engine,veh.ch_no chassis,veh.doc_no,veh.date,veh.reg_no,veh.fleet_no,veh.flname from gl_equipmaster veh left join gl_vehsubcategory sub on veh.subcatid=sub.doc_no where veh.statu<>7 and veh.dtype='EEM' and veh.tran_code<>'RA' "+sqltest+" group by veh.subcatid,veh.flname";
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

	public JSONArray contactPersonDetailsSearch(String clientdocno,String contactpersonsname,String contactpersonsmobile,String contactpersonsdocno,String chk) throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA=new JSONArray();
	
	    try {
	    	 	conn = objconn.getMyConnection();
	    		Statement stmt = conn.createStatement();
			
	    	    String sql1 = "";
				
	            if(!((contactpersonsname.equalsIgnoreCase("")) || (contactpersonsname.equalsIgnoreCase("0")))){
	            	sql1=sql1+" and cperson like '%"+contactpersonsname+"%'";
	            }
	            if(!((contactpersonsmobile.equalsIgnoreCase("")) || (contactpersonsmobile.equalsIgnoreCase("0")))){
	                sql1=sql1+" and c.mob like '%"+contactpersonsmobile+"%'";
	            }
	            if(!((contactpersonsdocno.equalsIgnoreCase("")) || (contactpersonsdocno.equalsIgnoreCase("0")))){
	                sql1=sql1+" and row_no like '%"+contactpersonsdocno+"%'";
	            }
				
	            String sql = "select cperson,c.tel as tel,ar.area,row_no as cprowno,c.mob,c.email from my_crmcontact c left join my_acbook a on (a.doc_no=c.cldocno) left join my_area ar on(c.area_id=ar.doc_no) where a.status=3 and a.dtype='CRM' and c.dtype='CRM' and c.cldocno="+clientdocno+" and a.doc_no="+clientdocno+""+sql1;
				
				if(chk.equalsIgnoreCase("1")){
					ResultSet resultSet = stmt.executeQuery(sql);
					RESULTDATA=objcommon.convertToJSON(resultSet);
				}
				else{
					stmt.close();
					conn.close();
					return RESULTDATA;
				}
				stmt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	

	public int insert(ClsRentalQuoteAction masteraction, HttpSession session,
			HttpServletRequest request, Connection conn, Date sqldate,ArrayList<String> quotearray,String dtype) {
		// TODO Auto-generated method stub
		int docno=0;
		int vocno=0;
		try{
			Statement stmt=conn.createStatement();
			
			String brhid=session.getAttribute("BRANCHID").toString();
			String userid=session.getAttribute("USERID").toString();
			String strmaxdocno="select (select coalesce(max(doc_no),0)+1 from gl_rentalquotem) maxdocno,(select coalesce(max(voc_no),0)+1 from gl_rentalquotem where brhid="+brhid+") maxvocno";
			ResultSet rsmaxdocno=stmt.executeQuery(strmaxdocno);
			while(rsmaxdocno.next()){
				docno=rsmaxdocno.getInt("maxdocno");
				vocno=rsmaxdocno.getInt("maxvocno");
			}
			int apprstatus=0;
			String strgetapprcount="select count(*) apprcount from my_apprmaster where status=3 and dtype='"+masteraction.getFormdetailcode()+"'";
			System.out.println(strgetapprcount);
			ResultSet rsapprcount=stmt.executeQuery(strgetapprcount);
			int apprcount=0;
			while(rsapprcount.next()){
				apprcount=rsapprcount.getInt("apprcount");
			}
			if(apprcount<=0){
				apprstatus=3;
			}
			else{
				apprstatus=0;
			}
			
			masteraction.setDelcharges(masteraction.getDelcharges().trim().equalsIgnoreCase("")?"0.00":masteraction.getDelcharges());
			masteraction.setCollcharges(masteraction.getCollcharges().trim().equalsIgnoreCase("")?"0.00":masteraction.getCollcharges());
			masteraction.setVatamt(masteraction.getVatamt().trim().equalsIgnoreCase("")?"0.00":masteraction.getVatamt());
			masteraction.setTotalamt(masteraction.getTotalamt().trim().equalsIgnoreCase("")?"0.00":masteraction.getTotalamt());
			masteraction.setSrvcharges(masteraction.getSrvcharges().trim().equalsIgnoreCase("")?"0.00":masteraction.getSrvcharges());
			
			String strinsertmaster="insert into gl_rentalquotem(doc_no, voc_no, date, brhid, userid, cldocno, cperson_id, contactperson, contactnumber, attention, subject, description, delcharges, collcharges, vatamt, totalamt, delremark, srvcharges, srvdesc, status)values("+
			""+docno+","+vocno+",'"+sqldate+"',"+brhid+","+userid+","+masteraction.getCldocno()+","+masteraction.getCptrno()+",'"+masteraction.getContactperson()+"','"+masteraction.getContactnumber()+"','"+masteraction.getAttention()+"','"+masteraction.getSubject()+"','"+masteraction.getDesc()+"',"+masteraction.getDelcharges()+","+masteraction.getCollcharges()+","+masteraction.getVatamt()+","+masteraction.getTotalamt()+",'"+masteraction.getDelremark()+"',"+masteraction.getSrvcharges()+",'"+masteraction.getSrvdesc()+"',"+apprstatus+")";
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
				
				String strinsertdetail="insert into gl_rentalquoted(rdocno, srno, code, grpid, tarifdocno, status,qty,hiremode,subtotal,discount,total,vatperc,vatamt,nettotal,maxdiscount,equipdesc)values("+
				""+docno+","+j+","+code+","+grpid+","+tarifdocno+",3,"+qty+",'"+hiremode+"',"+subtotal+","+discount+","+total+","+vatperc+","+vatamt+","+nettotal+","+maxdiscount+",'"+equipdesc+"')";
				int insertdetail=stmt.executeUpdate(strinsertdetail);
				if(insertdetail<=0){
					System.out.println("Detail Insert Error");
					return 0;
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
	public boolean edit(ClsRentalQuoteAction masteraction, HttpSession session,
			HttpServletRequest request, Connection conn, Date sqldate,
			ArrayList<String> quotearray, String formdetailcode, String docno) {
		// TODO Auto-generated method stub
		try{
			Statement stmt=conn.createStatement();
			
			String brhid=session.getAttribute("BRANCHID").toString();
			String userid=session.getAttribute("USERID").toString();
			
			String strupdatemaster="update gl_rentalquotem set date='"+sqldate+"', brhid="+brhid+", userid="+userid+", cldocno="+masteraction.getCldocno()+", cperson_id="+masteraction.getCptrno()+", contactperson='"+masteraction.getContactperson()+"', contactnumber='"+masteraction.getContactnumber()+"', attention='"+masteraction.getAttention()+"', subject='"+masteraction.getSubject()+"', description='"+masteraction.getDesc()+"', delcharges="+masteraction.getDelcharges()+", collcharges ="+masteraction.getCollcharges()+",vatamt="+masteraction.getVatamt()+",totalamt="+masteraction.getTotalamt()+", delremark='"+masteraction.getDelremark()+"', srvcharges="+masteraction.getSrvcharges()+", srvdesc='"+masteraction.getSrvdesc()+"' where doc_no="+docno;
			int updatemaster=stmt.executeUpdate(strupdatemaster);
			if(updatemaster<=0){
				System.out.println("Master Update Error");
				return false;
			}
			int deletedetail=stmt.executeUpdate("delete from gl_rentalquoted where rdocno="+docno);
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
				
				String strinsertdetail="insert into gl_rentalquoted(rdocno, srno, code, grpid, tarifdocno, status,qty,hiremode,subtotal,discount,total,vatperc,vatamt,nettotal,maxdiscount,equipdesc)values("+
				""+docno+","+j+","+code+","+grpid+","+tarifdocno+",3,"+qty+",'"+hiremode+"',"+subtotal+","+discount+","+total+","+vatperc+","+vatamt+","+nettotal+","+maxdiscount+",'"+equipdesc+"')";
			
				int insertdetail=stmt.executeUpdate(strinsertdetail);
				if(insertdetail<=0){
					System.out.println("Detail Insert Error");
					return false;
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
	public boolean delete(ClsRentalQuoteAction masteraction,
			HttpSession session, HttpServletRequest request, Connection conn,
			String formdetailcode, String docno) {
		// TODO Auto-generated method stub
		try{
			Statement stmt=conn.createStatement();

			String brhid=session.getAttribute("BRANCHID").toString();
			String userid=session.getAttribute("USERID").toString();
			
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
	public ClsRentalQuoteBean getViewDetails(String docno) throws SQLException {
		// TODO Auto-generated method stub
		ClsRentalQuoteBean bean=new ClsRentalQuoteBean();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select m.date,concat('NAME: ',coalesce(ac.refname,''),' ADDRESS: ',coalesce(ac.address,'')) clientdetails,m.doc_no docno,m.voc_no vocno,m.brhid,m.cldocno,coalesce(cperson_id,0)cperson_id,coalesce(m.contactperson,'') contactperson,coalesce(m.contactnumber,'')"+
			" contactnumber,coalesce(m.attention,'') attention,coalesce(m.subject,'') subject,coalesce(m.description,'') description,round(coalesce(m.delcharges,0),2) delcharges, round(coalesce(m.collcharges,0),2) collcharges,round(coalesce(m.vatamt,0),2) vatamt,round(coalesce(m.totalamt,0),2) totalamt,coalesce(m.delremark,'')delremark,"+
			"round(coalesce(m.srvcharges,0),2) srvcharges,coalesce(m.srvdesc,'')srvdesc from gl_rentalquotem m left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') where m.doc_no="+docno+" ";
			System.out.println("strsql===="+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				bean.setClientdetails(rs.getString("clientdetails"));
				bean.setDocno(rs.getString("docno"));
				bean.setVocno(rs.getString("vocno"));
				bean.setDate(rs.getDate("date").toString());
				bean.setCptrno(rs.getInt("cperson_id"));
				bean.setContactnumber(rs.getString("contactnumber"));
				bean.setContactperson(rs.getString("contactperson"));
				bean.setAttention(rs.getString("attention"));
				bean.setSubject(rs.getString("subject"));
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
	
	public ClsRentalQuoteBean getPrint(int docno, HttpServletRequest request) throws SQLException {
		ClsRentalQuoteBean bean = new ClsRentalQuoteBean();
		  Connection conn = null;
		try {
				 conn = objconn.getMyConnection();
				Statement stmtprint = conn.createStatement ();
	        	
				  // cldatails
		    	   
		    	  /* setLblclient setLblclientaddress setLblmob setLblemail setLbldate setLbltypep setDocvals*/
		    	   /*if(!(pintrs.getString("glterms").equalsIgnoreCase("")) && (!(pintrs.getString("glterms").equalsIgnoreCase("NA"))))
		    	   {
		    		   bean.setGeneralterms(pintrs.getString("glterms"));
		    		   
		    		   bean.setTerms1("General Terms And Conditions" );
		    		   
		    	   }*/
				
				String resql=("select q.voc_no,coalesce(q.description,'') glterms,coalesce(m.sal_name,'') salname,m.mob_no mob,q.DOC_NO,DATE_FORMAT(q.DATE,'%d-%m-%Y') DATE"+
				" ,coalesce(q.contactnumber,'') mob ,coalesce(a.refname,'') name,coalesce(a.address,'') com_add1,coalesce(a.per_mob,'') mob,coalesce(a.mail1,'') email from"+
				" gl_rentalquotem q   left join my_acbook a"+
				" on a.cldocno=q.cldocno and a.dtype='CRM' left join my_salm m on m.doc_no=a.sal_id   where q.DOC_NO="+docno+" ");
				System.out.println(resql);
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
			     
			       while(pintrs.next()){
			    	   bean.setLblsalclient(pintrs.getString("salname"));
			    	   bean.setLblsalmob(pintrs.getString("mob"));
			    	    bean.setLblclient(pintrs.getString("name"));
			    	    bean.setLblclientaddress(pintrs.getString("com_add1"));
			    	    bean.setLblmob(pintrs.getString("mob"));
			    	    bean.setLblemail(pintrs.getString("email"));
			    	    //upper
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    //bean.setLbltypep(pintrs.getString("type"));
			    	    bean.setVocno(pintrs.getInt("voc_no")+"");
			    	    bean.setDocno(pintrs.getInt("doc_no")+"");
			    	}
				
				stmtprint.close();
				
				
				
				 Statement stmtinvoice10 = conn.createStatement ();
		/*		    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from gl_quotm r  "
				    		+ " left join my_brch b on r.BRANCH=b.doc_no left join my_locm l on l.brhid=b.doc_no "
				    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";*/
			/*	    String  companysql="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_quotm r inner join "
				    		+ "    my_brch b on r.BRANCH=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join "
				    		+ "	    (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo) as lc on(lc.loc=l.loc) where  r.doc_no="+docno+"  ";*/
				  String  companysql="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_rentalquotem r inner join my_brch b on  "
				    		+ "r.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name, "
				    		+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.doc_no='"+docno+"' ";
                     //System.out.println("--------"+companysql);

			         ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
				       
				       while(resultsetcompany.next()){
				    	   
				    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
				    	   bean.setLblcompname(resultsetcompany.getString("company"));
				    	  
				    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
				    	 
				    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
				    	  
				    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
				    	   bean.setLbllocation(resultsetcompany.getString("location"));
				    	  
				    	   bean.setLblcstno(resultsetcompany.getString("cstno"));
					    	  
				    		  bean.setLblservicetax(resultsetcompany.getString("stcno"));
				    		  bean.setLblpan(resultsetcompany.getString("pbno"));
				    	   
				       } 
				       stmtinvoice10.close();
				       ArrayList<String> arr=new ArrayList<String>();
						Statement stmtinvoice2 = conn.createStatement ();
					
					/*	
						String strSqldetail="select if(qt.tariff=0,' ',round(qt.tariff,2)) rate ,coalesce(y.yom,'') yom,eq.sr_no,eq.brdid,eq.modid,eq.spec ,eq.clrid,round(eq.unit) unit,DATEDIFF(eq.todate,eq.frmdate) AS days, "
								+ " eq.rtype ,eq.grpid,vb.brand_name brand,vm.vtype model, "
								+ "vc.color color,vg.gname gname FROM gl_qenq eq left join gl_vehbrand vb on vb.doc_no=eq.BRDID "
								+ "left join gl_vehmodel vm on vm.doc_no=eq.MODID left join my_color vc on vc.doc_no=eq.clrid "
								+ "left join gl_vehgroup vg on vg.doc_no=eq.grpid left join gl_yom y on y.doc_no=eq.yom"
								+ " left join gl_quotd qt on (qt.rdocno=eq.rdocno and qt.rentaltype=eq.rtype)   where  eq.rdocno='"+docno+"' group by eq.sr_no ";
						*/
						String strSqldetail="select if(qt.rate=0,' ',round(qt.rate*eq.qty,2)) rate ,if(qt.cdw=0,' ',round(qt.cdw*eq.qty,2))"+
						" cdw ,if(qt.pai=0,' ',round(qt.pai*eq.qty,2)) pai , if(qt.gps=0,' ',round(qt.gps*eq.qty,2)) gps ,if(qt.babyseater=0,' ',"+
						" round(qt.babyseater*eq.qty,2)) babyseater ,(round(qt.rate*eq.qty,2)+round(qt.cdw*eq.qty,2)+round(qt.pai*eq.qty,2)+"+
						" round(qt.gps*eq.qty,2)+round(qt.babyseater*eq.qty,2))*(round(eq.qty)) total,coalesce(y.yom,'') yom,eq.srno,"+
						" round(eq.qty) unit,eq.hiremode rtype ,eq.grpid,vb.brand_name brand,vm.vtype model,vc.color color,vg.gname gname"+
						" FROM gl_rentalquoted eq left join gl_equipmaster veh on eq.fleet_no=veh.fleet_no left join gl_vehbrand vb on vb.doc_no=veh.BRDID left join gl_vehmodel vm on vm.doc_no=veh.vMODID"+
						" left join my_color vc on vc.doc_no=veh.clrid left join gl_vehgroup vg on vg.doc_no=veh.vgrpid left join gl_yom y on"+
						" y.doc_no=veh.yom left join gl_tarifd qt on (qt.doc_no=eq.tarifdocno and qt.gid=eq.grpid and qt.renttype=eq.hiremode) where eq.rdocno=="+docno+""+
						" group by eq.srno";
//				System.out.println("--------------"+strSqldetail);
			
					ResultSet rsdetail=stmtinvoice2.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){
						
							String temp="";
							String spci="";
							// bean.setFirstarray(1); 
					/*		if(rsdetail.getString("spec").equalsIgnoreCase("0"))
							{
								spci="";
							}
							else
							{
								spci=rsdetail.getString("spec");
							}*/
						/*temp=rowcount+"::"+rsdetail.getString("brand")+"::"+rsdetail.getString("model")+"::"+spci+"::"+rsdetail.getString("yom")+"::"+rsdetail.getString("color")+"::"+rsdetail.getString("rtype")+"::"+rsdetail.getString("rate")+"::"+rsdetail.getString("unit")+"::"+rsdetail.getString("days")+"::"+rsdetail.getString("gname") ;*/
							temp=rowcount+"::"+rsdetail.getString("brand")+"::"+rsdetail.getString("model")+"::"+rsdetail.getString("yom")+"::"+rsdetail.getString("rtype")+"::"+rsdetail.getString("rate")+"::"+rsdetail.getString("unit")+"::"+rsdetail.getString("cdw")+"::"+rsdetail.getString("pai")+"::"+rsdetail.getString("gps")+"::"+rsdetail.getString("babyseater")+"::"+rsdetail.getString("gname")+"::"+rsdetail.getString("total");
		
							arr.add(temp);
							rowcount++;
			
					
						
				              }
					stmtinvoice2.close();  
					request.setAttribute("details",arr); 
					
					
				       ArrayList<String> descarr=new ArrayList<String>();
								Statement stmtinvoice11 = conn.createStatement ();
							
							/*	
								String stsql="select  concat(c.srno,' .  ',m.description,' ',' ',if(c.descplus='0','',c.descplus)) descplus from gl_quotc c "
										+ " left join gl_qcond m on c.desid=m.doc_no where m.status=3 and c.rdocno='"+docno+"' order by c.rowno";
								
						//	System.out.println("--------------"+strSqldetail);
					
							ResultSet rsdetails=stmtinvoice11.executeQuery(stsql);
							
						String temp1="";
					String ss="";
							while(rsdetails.next()){
								 bean.setTerms2("Special Notes" );
								
								temp1=ss+"::"+rsdetails.getString("descplus") ;
				
								descarr.add(temp1);
								
							
								
						              }*/
							stmtinvoice2.close();  
							request.setAttribute("desc",descarr); 
					
				conn.close();



				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;
		
	
	 }
}
