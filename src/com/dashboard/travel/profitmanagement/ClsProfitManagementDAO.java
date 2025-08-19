package com.dashboard.travel.profitmanagement;
    
	import com.common.ClsCommon;
	import com.connection.ClsConnection;

	import java.sql.*;

	import javax.servlet.http.HttpSession;

	import net.sf.json.JSONArray;
	public class ClsProfitManagementDAO {  

		ClsConnection objconn=new ClsConnection();     
		ClsCommon objcommon=new ClsCommon();
		
		public JSONArray detailGrid(HttpSession session, String check,String fromdate,String todate,String branch,String location) throws SQLException{ 
			JSONArray data=new JSONArray(); 
			if(!check.equalsIgnoreCase("1")){    
				return data;
			}
			Connection conn=null; 
			try{  
			conn=objconn.getMyConnection();   
			Statement stmt=conn.createStatement();
			String sqltest="";   
			java.sql.Date sqltodate=null;
			java.sql.Date sqlfromdate=null;
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){  
				sqltest+=" and a.brhid="+branch;  
			}
			if(!location.equalsIgnoreCase("") && !location.equalsIgnoreCase("0") && !location.equalsIgnoreCase("a")){  
				sqltest+=" and a.locid="+location;
			}
			if( sqltodate!=null && sqlfromdate!=null){                 
					sqltest+=" and a.datess between '"+sqlfromdate+"' and '"+sqltodate+"'";                
			}
			String strsql=" select a.*,coalesce(a.netsales-a.netpur,0) marginval,round(coalesce((coalesce(a.netsales-a.netpur,0)/coalesce(a.netsales,0))*100,0),2) marginper from(select m.date datess,m.locid,m.brhid,'Tour' doctype,m.doc_no,m.voc_no,date_format(m.date,'%d.%m.%Y') date,m.refname,ac.refname vendor,b.branchname branch,l.loc_name location,convert(concat(tr.name,' - ',sr.adult,', ',sr.child),char(200)) remarks,round(coalesce(nd.nettaxamount,0),2) pvalue,round(coalesce(nd.taxamount,0),2) pvat,coalesce(nd.nettotal,0) netpur,round(if(if(COALESCE(acc.tourtaxtype,'')='',(select coalesce(a.tourtaxtype,'') tourtaxtype from my_account ac left join my_acbook a on a.acno=ac.acno where ac.codeno='CASH ACCOUNT'),acc.tourtaxtype)='INCLUSIVE',coalesce(sr.total,0),coalesce(sr.total,0)+((coalesce(sr.total,0)*5)/100)),2) svalue,round(if(if(COALESCE(acc.tourtaxtype,'')='',(select coalesce(a.tourtaxtype,'') tourtaxtype from my_account ac left join my_acbook a on a.acno=ac.acno where ac.codeno='CASH ACCOUNT'),acc.tourtaxtype)='INCLUSIVE',coalesce(sr.total,0)-((coalesce(sr.total,0)/105)*100),(coalesce(sr.total,0)*5)/100),2) svat,round(if(if(COALESCE(acc.tourtaxtype,'')='',(select coalesce(a.tourtaxtype,'') tourtaxtype from my_account ac left join my_acbook a on a.acno=ac.acno where ac.codeno='CASH ACCOUNT'),acc.tourtaxtype)='INCLUSIVE',coalesce(sr.total,0)-(coalesce(sr.total,0)-((coalesce(sr.total,0)/105)*100)),coalesce(sr.total,0)-((coalesce(sr.total,0)*5)/100)),2) netsales from tr_servicereqm m left join tr_srtour sr on sr.rdocno=m.doc_no left join my_acbook ac on ac.cldocno=sr.vendorid and ac.dtype='VND' left join my_acbook acc on acc.cldocno=m.cldocno and acc.dtype='CRM' left join my_brch b on m.brhid=b.doc_no left join my_locm l on m.locid=l.doc_no left join tr_tours tr on sr.tourid=tr.doc_no left join my_srvlpom np on sr.xodoc=np.doc_no left join my_srvpurm nr on (nr.refno=np.doc_no and nr.reftype='NPO') left join my_srvpurd nd on nd.rdocno=nr.doc_no  where m.status=3) a where 1=1 "+sqltest+""
					    + " union all select a.*,coalesce(a.netsales-a.netpur,0) marginval,round(coalesce((coalesce(a.netsales-a.netpur,0)/coalesce(a.netsales,0))*100,0),2) marginper from(select d.issuedate datess,0 locid,m.brhid,'Ticket' doctype,m.doc_no,m.voc_no,date_format(d.issuedate,'%d.%m.%Y') date,acc.refname,ac.refname vendor,b.branchname branch,'' location,convert(concat(ar.name,' - ',d.sector,', ',d.ticketno),char(200)) remarks,round(coalesce(nd.nettaxamount,0),2) pvalue,round(coalesce(nd.taxamount,0),2) pvat,coalesce(nd.nettotal,0) netpur,round(coalesce(d.sprice,0),2) svalue,0 svat,round(coalesce(d.sprice,0),2) netsales from ti_ticketvoucherm m left join ti_ticketvoucherd d on d.rdocno=m.doc_no left join my_acbook ac on ac.cldocno=d.vnddocno and ac.dtype='VND' left join my_acbook acc on acc.cldocno=d.cldocno and acc.dtype='CRM' left join my_brch b on m.brhid=b.doc_no left join ti_airline ar on ar.doc_no=d.airlineid  left join my_srvpurm nr on (nr.doc_no=d.cpudoc) left join my_srvpurd nd on nd.rdocno=nr.doc_no where m.status=3) a where 1=1 "+sqltest+""
					    + " union all select a.*,coalesce(a.netsales-a.netpur,0) marginval,round(coalesce((coalesce(a.netsales-a.netpur,0)/coalesce(a.netsales,0))*100,0),2) marginper from(select  d.issuedate datess,0 locid,m.brhid,case when coalesce(d.vtype,'')='H' then 'Hotel' when coalesce(d.vtype,'')='V' then 'Visa' when coalesce(d.vtype,'')='O' then 'Other' else '' end as doctype,m.doc_no,m.voc_no,date_format(d.issuedate,'%d.%m.%Y') date,acc.refname,ac.refname vendor,b.branchname branch,'' location,convert(concat(d.guest,' - ',d.suppconfno),char(200)) remarks,round(coalesce(nd.nettaxamount,0),2) pvalue,round(coalesce(nd.taxamount,0),2) pvat,coalesce(nd.nettotal,0) netpur,round(if(coalesce(d.clvatamt,0)>0,if(d.inclusive=1,coalesce(d.sprice,0),coalesce(d.sprice,0)+coalesce(d.clvatamt,0)),coalesce(d.sprice,0)),2) svalue,round(coalesce(d.clvatamt,0),2) svat,round(if(coalesce(d.clvatamt,0)>0,coalesce(d.sprice,0)-coalesce(d.clvatamt,0),coalesce(d.sprice,0)),2) netsales from ti_hotelvoucherm m left join ti_hotelvoucherd d on d.rdocno=m.doc_no left join my_acbook ac on ac.cldocno=d.vnddocno and ac.dtype='VND' left join my_acbook acc on acc.cldocno=d.cldocno and acc.dtype='CRM' left join my_brch b on m.brhid=b.doc_no left join my_srvpurm nr on (nr.doc_no=d.cpudoc) left join my_srvpurd nd on nd.rdocno=nr.doc_no where m.status=3) a  where 1=1 "+sqltest+""; 
			//System.out.println("travel Grid--->>>"+strsql);                      
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


