package com.dashboard.travel.airlinerecon;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;

public class ClsTravelAirlineReconDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getAirlineReconData(String id,String fromdate,String todate)throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String sqltest="";
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and d.issuedate>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and d.issuedate<='"+sqltodate+"'";
			}
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="SELECT round(jv.dramount*jv.id,2) gwamount,convert(concat(coalesce(m.voc_no,''),' ',coalesce(a.name,'')),char(200)) gwairline,d.ticketno gwticketno,d.issuedate gwissuedate,"+
			" d.suptotal,air.airline iataairline,SUBSTRING_INDEX(air.documentno,' ',1) iataticketno,"+
			" air.issuedate iataissuedate,round(air.netamount,2) iataamount FROM ti_ticketvoucherm m left join ti_ticketvoucherD d on m.doc_no=d.rdocno"+
			" left join ti_airline a on a.doc_no=d.airlineid left join gl_limoairlinedata air on (d.ticketno=SUBSTRING_INDEX(air.documentno,' ',1))"+
			" left join my_jvtran jv on (jv.acno=1735 and jv.doc_no=d.invtrno and jv.dtype='TINV')"+
			" where coalesce(air.reconstatus,0)=0 and m.status=3 and d.vnddocno=89 and coalesce(jv.tr_no,0)>0"+sqltest;
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
