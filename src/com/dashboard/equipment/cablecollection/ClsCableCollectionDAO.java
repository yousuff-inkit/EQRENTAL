package com.dashboard.equipment.cablecollection;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsCableCollectionDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getCableData(String brhid,String fromdate,String todate,String id,String collectstatus) throws SQLException {
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			String sqlfilters="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!fromdate.equalsIgnoreCase("")) {
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqlfilters+=" and date(cb.edate)>='"+sqlfromdate+"'";
			}
			
			if(!todate.equalsIgnoreCase("")) {
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqlfilters+=" and date(cb.edate)<='"+sqltodate+"'";
			}
			
			if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")) {
				sqlfilters+=" and cnt.brhid="+brhid;
			}
			
			if(collectstatus.equalsIgnoreCase("1")) {
				sqlfilters+=" and cb.qty-cb.collectqty>0";
			}
			String strsql="SELECT round(cb.collectqty,0) collectqty,grp.doc_no assetgrpdocno,cb.rowno cablerowno,cnt.doc_no contractdocno,cnt.voc_no contractvocno,cb.edate,ROUND(cb.qty,0) qty,grp.grp_code assetgrpcode,grp.grp_name assetgrpname,ac.refname,ac.cldocno FROM my_cableissue cb \r\n" + 
					" LEFT JOIN gl_rentalcontractm cnt ON cb.contractdocno=cnt.doc_no\r\n" + 
					" LEFT JOIN my_acbook ac ON cnt.cldocno=ac.cldocno AND ac.dtype='CRM'\r\n" + 
					" LEFT JOIN my_fagrp grp ON cb.assetgrpid=grp.doc_no\r\n" + 
					" WHERE cb.status=3 AND cb.qty>0 "+sqlfilters;
			System.out.println(strsql);
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			conn.close();
		}
		return data;
	}
}
