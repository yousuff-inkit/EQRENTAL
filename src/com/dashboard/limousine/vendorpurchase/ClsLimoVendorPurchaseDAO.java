package com.dashboard.limousine.vendorpurchase;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;
public class ClsLimoVendorPurchaseDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getVendorPurchaseData(String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select mgmt.type jobtype,ac.cldocno vendorid,m.desc1 description,m.doc_no,m.voc_no,m.date,head.account,head.doc_no acno,ac.refname,sum(mgmt.vendornetamount)"+
			" vendornetamount from gl_limobookm m left join gl_limobooktransfer tran on (m.doc_no=tran.bookdocno) left join gl_limomanagement mgmt"+
			" on (mgmt.docno=m.doc_no and mgmt.job=tran.docname) left join my_acbook ac on(tran.assignedvendor=ac.cldocno and ac.dtype='VND')"+
			" left join my_head head on (ac.acno=head.doc_no) where m.status=3 and mgmt.assigntype=3 and mgmt.bstatus=7 and vendorpurchasetrno=0 group by ac.cldocno union all"+
			" select mgmt.type jobtype,ac.cldocno vendorid,m.desc1 description,m.doc_no,m.voc_no,m.date,head.account,head.doc_no acno,ac.refname,sum(mgmt.vendornetamount)"+
			" vendornetamount from gl_limobookm m left join gl_limobookhours hrs on (m.doc_no=hrs.bookdocno) left join gl_limomanagement mgmt"+
			" on (mgmt.docno=m.doc_no and mgmt.job=hrs.docname) left join my_acbook ac on(hrs.assignedvendor=ac.cldocno and ac.dtype='VND')"+
			" left join my_head head on (ac.acno=head.doc_no) where m.status=3 and mgmt.assigntype=3 and mgmt.bstatus=7 and vendorpurchasetrno=0 group by ac.cldocno";
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
	
	public JSONArray getVendorPurchaseDetailData(String vendorid,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select mgmt.type jobtype,ac.tax,m.doc_no bookdocno,m.voc_no bookvocno,tran.docname,tran.pickupdate,tran.pickuptime,mgmt.plocation pickuplocation,"+
			" mgmt.dlocation dropofflocation,mgmt.vendoramount vendoramountold,mgmt.vendoramount,mgmt.vendordiscount,mgmt.vendornetamount from gl_limobookm m left join"+
			" gl_limobooktransfer tran on (m.doc_no=tran.bookdocno) left join gl_limomanagement mgmt on (mgmt.docno=m.doc_no and"+
			" mgmt.job=tran.docname) left join my_acbook ac on(tran.assignedvendor=ac.cldocno and ac.dtype='VND')"+
			" left join my_head head on (ac.acno=head.doc_no) where m.status=3 and mgmt.assigntype=3 and mgmt.bstatus=7 and vendorpurchasetrno=0 and tran.assignedvendor="+vendorid+" union all"+
			" select mgmt.type jobtype,ac.tax,m.doc_no bookdocno,m.voc_no bookvocno,hrs.docname,hrs.pickupdate,hrs.pickuptime,mgmt.plocation pickuplocation,"+
			" mgmt.dlocation dropofflocation,mgmt.vendoramount vendoramountold,mgmt.vendoramount,mgmt.vendordiscount,mgmt.vendornetamount from gl_limobookm m left join"+
			" gl_limobookhours hrs on (m.doc_no=hrs.bookdocno) left join gl_limomanagement mgmt on (mgmt.docno=m.doc_no and"+
			" mgmt.job=hrs.docname) left join my_acbook ac on(hrs.assignedvendor=ac.cldocno and ac.dtype='VND')"+
			" left join my_head head on (ac.acno=head.doc_no) where m.status=3 and mgmt.assigntype=3 and mgmt.bstatus=7 and vendorpurchasetrno=0 and hrs.assignedvendor="+vendorid;
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
