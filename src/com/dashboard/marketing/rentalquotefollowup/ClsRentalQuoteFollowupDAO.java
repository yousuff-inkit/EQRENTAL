package com.dashboard.marketing.rentalquotefollowup;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsRentalQuoteFollowupDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public  JSONArray getEquipData(String docno,String fleetname,String fleetno,String regno,String searchdate,HttpSession session,
			String engine,String chassis,String id,String subcatid) throws SQLException {

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
    	if(!subcatid.equalsIgnoreCase("")){
    		sqltest=sqltest+" and veh.subcatid="+subcatid;
    	}
    	 if(sqldate!=null){
    		 sqltest=sqltest+" and veh.date='"+sqldate+"'";
    	 }
        
     
		
				Statement stmtsearch = conn.createStatement();
				String str1Sql="select sub.doc_no subcatid,sub.code,sub.doc_no subcatid,veh.vgrpid grpid,veh.eng_no engine,veh.ch_no chassis,veh.doc_no,veh.date,veh.reg_no,veh.fleet_no fleetno,veh.flname from gl_equipmaster veh left join gl_vehsubcategory sub on veh.subcatid=sub.doc_no where veh.statu<>7 and veh.dtype='EEM' and veh.status='IN' "+sqltest+"";
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
	public JSONArray getPreApprovalData(String docno,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			//Checking if already filled data
			int itemcount=0;
			String strcount="select count(*) itemcount from gl_rentalquotecalc where rdocno="+docno;
			ResultSet rscount=stmt.executeQuery(strcount);
			while(rscount.next()){
				itemcount=rscount.getInt("itemcount");
			}
			String strsql="";
			if(itemcount==0){
				/*strsql="select "+itemcount+" itemcount,d.qty,td.rate,d.code,veh.fleet_no,veh.flname,d.grpid,d.tarifdocno from gl_rentalquotem m left join gl_rentalquoted d on m.doc_no=d.rdocno"+
						" left join gl_equipmaster veh on d.fleet_no=veh.fleet_no left join gl_tarifd td on (td.gid=d.grpid and td.doc_no=d.tarifdocno and"+
						" td.renttype=m.rentaltype) where m.doc_no="+docno+" and m.status=3";*/
				int errorstatus=0;
				conn.setAutoCommit(false);
				String strgetdata="select qty,doc_no,code from gl_rentalquoted where rdocno="+docno;
				System.out.println(strgetdata);
				ResultSet rsgetdata=stmt.executeQuery(strgetdata);
				while(rsgetdata.next()){
					int subcatid=rsgetdata.getInt("code");
					int qty=rsgetdata.getInt("qty");
					String fleetno="0";//rsgetdata.getString("fleet_no");
					int detdocno=rsgetdata.getInt("doc_no");
					for(int i=1;i<=qty;i++){
						String strinsert="insert into gl_rentalquotecalc(rdocno,srno,subcatid,detdocno,fleet_no) values("+docno+","+i+","+subcatid+","+detdocno+","+fleetno+")";
						int insert=conn.createStatement().executeUpdate(strinsert);
						if(insert<=0){
							errorstatus=1;
						}
					}
				}
				if(errorstatus==0){
					conn.commit();
				}
			}
			strsql="select subcat.code,d.equipdesc flname,convert(calc.fleet_no,char(15)) fleet_no,calc.doc_no calcdocno,subcat.doc_no subcatid from gl_rentalquotecalc calc left join gl_rentalquoted d on calc.detdocno=d.doc_no left join gl_equipmaster veh on calc.fleet_no=veh.fleet_no left join gl_vehsubcategory subcat on calc.subcatid=subcat.doc_no where calc.approved=0 and d.rdocno="+docno;
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
	public JSONArray getFollowupData(String docno,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select p.process status,q.date,q.description ,q.fdate date,usr.user_name username from gl_brentalquote q left join my_user usr on"+
			" q.doc_no=usr.doc_no left join gl_bibp p on (p.srno=q.status and p.bibdid=(select doc_no from gl_bibd where description='Quotation Follow Up' and status=1)) where q.rdocno="+docno+" group by q.doc_no order by q.doc_no desc";
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
	public JSONArray getQuoteData(String id,String branch, String fromdate,String todate) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String sqlfilters="";
			java.sql.Date sqlfromdate = null, sqltodate = null;
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqlfilters+=" and m.brhid="+branch;
			}
			if (!fromdate.trim().equalsIgnoreCase("")) {
				sqlfromdate = objcommon.changeStringtoSqlDate(fromdate);
				sqlfilters += " and m.date>='" + sqlfromdate + "'";
			}
			if (!todate.trim().equalsIgnoreCase("")) {
				sqltodate = objcommon.changeStringtoSqlDate(todate);
				sqlfilters += " and m.date<='" + sqltodate + "'";
			}
			Statement stmt=conn.createStatement();
			String strsql="select case when m.processstatus=1 then 'Follow-Up' when m.processstatus=2 then 'Maintenance Approval' when m.processstatus=3 then 'Contract To Be Created' else '' end strprocess,m.brhid,m.processstatus,coalesce(ac.refname,'') refname,m.date,m.doc_no docno,m.voc_no vocno,m.cldocno,coalesce(m.contactperson,'')"+
					" contactperson,coalesce(m.contactnumber,'') contactnumber,coalesce(m.attention,'') attention,coalesce(m.subject,'') subject,"+
					" coalesce(m.description,'') description,m.rentaltype,br.branchname,coalesce(sum(d.nettotal),0)nettotal,coalesce(sm.sal_name)salesman,"+
					" coalesce(m.delcharges,0)delcharges,coalesce(m.collcharges,0)collcharges,coalesce(m.vatamt,0)vatamt,coalesce(m.totalamt,0)totalamt "+
					" from gl_rentalquotem m left join gl_rentalquoted d on d.rdocno=m.doc_no inner join my_brch br on br.doc_no=m.brhid left join my_acbook ac on (m.cldocno=ac.cldocno and ac.dtype='CRM') left join my_salm sm on sm.doc_no=ac.sal_id "+
					" where m.status=3 and m.followupstatus<>2 "+sqlfilters +" group by m.doc_no order by m.date desc,m.doc_no desc" ;

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
