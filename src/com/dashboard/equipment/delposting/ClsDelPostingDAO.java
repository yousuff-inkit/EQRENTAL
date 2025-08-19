package com.dashboard.equipment.delposting;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsDelPostingDAO {
	
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getDelPostingData(String id,String brhid, String type) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
						
			String sqltest="";
			if(type.equalsIgnoreCase("PRE")){
				sqltest=" jvtrno=0 ";
			}else{
				sqltest=" jvtrno!=0 ";
			}
			
			if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")){
				sqltest+=" AND m.brhid="+brhid;
			}
			String strsql="select rqc.contractdocno, ac.RefName client, ac.RefName vendor,m.invno, m.invdate, m.gatepassno, m.amount, m.vat, m.netamt, "+
" m.fleet, m.driver, m.date, m.time, m.km, m.fuel, m.address, m.remarks, coalesce(p.voc_no,0) cpudocno, m.vndid ,m.srno docno"+  
" from eq_deldetails m left join my_acbook ac on m.vndid = ac.doc_no and ac.dtype='vnd' left join my_srvpurm p on m.jvtrno=p.tr_no"+
" left join gl_rentalquotecalc rqc on rqc.deldocno=m.deldocno left join gl_rentalcontractm rc on rc.doc_no=rqc.contractdocno"+
" left join my_acbook ac2 ON ac2.doc_no=rc.cldocno and ac2.dtype='crm' where "+sqltest+" group by m.srno order by m.srno";
			
			
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

}
