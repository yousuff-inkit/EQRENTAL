package com.dashboard.limousine.limoconfirmed;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsLimoConfirmedDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray gridData(String branch,String id,String fromdate,String todate) throws SQLException{
		JSONArray RESULTDATA=new JSONArray();               
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and bm.brhid="+branch+"";  
			}
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and bm.pickupdate>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and bm.pickupdate<='"+sqltodate+"'";
			}
		    String strsql="select round(coalesce(invd.total,0),2) invoicevalue,round(coalesce(bm.vendortaxtotal,0),2) purchasevalue,bm.bstatus,"+
			" round(bm.vendoramount,2) vendoramount,round(bm.vendordiscount,2) vendordiscount,round(bm.vendornetamount,2) vendornetamount,"+
		    " bm.assigntype,bm.refno,bm.triptype,bm.otherdetails,bm.pax,concat(coalesce(veh.reg_no,''),' - ',coalesce(plt.code_name,'')) "+
			" regdetails,coalesce(bm.bookremarks,'') bookremarks,coalesce(bm.drivername,'') drivername,coalesce(bm.groupname,'') groupname,"+
		    " bm.tarifdocno,bm.tarifdetaildocno,if(date_format(now(),'%Y-%m-%d')=bm.pickupdate,1,0) datval,bm.rowno, coalesce(bm.docno,0) docno,"+
			" bm.brhid, bm.job, bm.client, bm.clientid, bm.guest, bm.guestid,bm.type, st.name status, bm.blockhrs, bm.pickupdate, bm.pickuptime,"+
		    " bm.plocation pickuplocation,bm.paddress pickupaddress,bm.dlocation dropofflocation,bm.daddress dropoffaddress, bm.brand, bm.model,"+
			" bm.fname, bm.fno, bm.nos, coalesce(bm.tdocno,0) tdocno, bm.remarks from gl_limomanagement bm left join gl_limostatusdet st on "+
		    " st.doc_no=bm.bstatus left join gl_vehmaster veh on (bm.fno=veh.fleet_no and statu=3) left join gl_vehplate plt on "+
			" veh.pltid=plt.doc_no left join gl_limoinvd invd on (bm.docno=invd.bookdocno and bm.tdocno=invd.jobdocno and bm.type=invd.jobtype) "+
		    " left join gl_limoinvm inv on (invd.rdocno=inv.doc_no and inv.status=3)where bm.confirm=1  "+sqltest+" order by pickupdate,pickuptime asc ";
		       
			//System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			RESULTDATA=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA;  
	} 
}
