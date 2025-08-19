package com.dashboard.travel.insurancevendorpayment;   

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsInsuranceVendorPaymentDAO  {    
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray insvndpayGrid(String branch,String uptodate,String atype,String accdocno, String salesperson,String check) throws SQLException {
       
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
        
        java.sql.Date sqlUpToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtIndividualAgeing = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")){
				
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
					sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
				}
				
				String sql = "",condition="",joins="",casestatement="";
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    		}

				if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
					sql+=" and j.acno="+accdocno+"";
	            }
				
				if(!(salesperson.equalsIgnoreCase(""))){
	    			sql+=" and bk.sal_id="+salesperson+"";
	    		}
				
				joins=ClsCommon.getFinanceVocTablesJoins(conn);
				casestatement=ClsCommon.getFinanceVocTablesCase(conn);
				condition=" and bk.dtype='VND'";
				
				sql = "select  a.tranid,a.name,a.date,a.transtype,"+casestatement+"a.acno,a.brhid,a.description,a.vndamount vndamt,a.vndrcvd vndrvd,a.vndbal vndbl,a.client,a.netpur,if(a.sernetsales>0,a.sernetsales,if(a.tktnetsales>0,a.tktnetsales,a.htlnetsales)) netsales,coalesce(if(a.sernetsales>0,a.sernetsales,if(a.tktnetsales>0,a.tktnetsales,a.htlnetsales))-a.netpur,0) profit,coalesce((coalesce(if(a.sernetsales>0,a.sernetsales,if(a.tktnetsales>0,a.tktnetsales,a.htlnetsales))-a.netpur,0)/coalesce(if(a.sernetsales>0,a.sernetsales,if(a.tktnetsales>0,a.tktnetsales,a.htlnetsales)),0))*100,0) profitper from ("
						+ "select if(coalesce(req.refname,'')='',ak.refname,req.refname) client,j.date,j.dtype transtype,j.doc_no transno,j.acno,h.description name,coalesce(j.description,'') description,sum(j.dramount) vndamount,CONVERT(coalesce(j.out_amount,''),CHAR(50)) vndrcvd,sum(j.dramount) - coalesce(j.out_amount,0) vndbal, j.tranid, j.brhid,rd.netpur,coalesce(sr.sprice-(coalesce(jv.dramount,0)*coalesce(jv.id,0)),0) sernetsales,coalesce(td.sprice,0) tktnetsales,coalesce(coalesce(hd.sprice,0)-coalesce(hd.vatamt,0),0) htlnetsales from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno and bk.dtype='VND' left join my_srvpurm rm on (rm.doc_no=j.doc_no and j.dtype='CPU') left join (select sum(nettotal) netpur,rdocno from my_srvpurd where 1=1 group by rdocno) rd on rd.rdocno=rm.doc_no left join my_srvlpom om on (om.doc_no=rm.refno and rm.reftype='NPO') left join (select xodoc,sum(total) sprice,rdocno from tr_srtour where 1=1 group by xodoc) sr on (sr.xodoc=om.doc_no) left join tr_servicereqm req on req.doc_no=sr.rdocno left join (select cpudoc,sum(sprice) sprice,cldocno from ti_ticketvoucherd where 1=1 group by cpudoc) td on (td.cpudoc=rm.doc_no) left join (select cpudoc,sum(sprice) sprice,cldocno,sum(clvatamt) vatamt from ti_hotelvoucherd where 1=1 group by cpudoc) hd on (hd.cpudoc=rm.doc_no) left join my_acbook ak on ((ak.cldocno=req.cldocno or ak.cldocno=td.cldocno or ak.cldocno=hd.cldocno) and ak.dtype='CRM') left join tr_invoicem inv on inv.doc_no=req.invtrno left join my_jvtran jv on (jv.acno=(select acno from gl_taxmaster where per=5 and type=2) and jv.dtype='TINV' and jv.doc_no=inv.doc_no) "
						+ "where j.status=3 and j.paid=0 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+" group by j.tranid having vndbal<>0 ) a"+joins+" order by acno,date";
				//System.out.println("mainsql--->>>"+sql);          
				ResultSet resultSet = stmtIndividualAgeing.executeQuery(sql);  
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				}
				
				stmtIndividualAgeing.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray individualAgeingSummary(String branch,String uptodate,String atype,String accdocno, String salesperson,String category,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlUpToDate = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDayBook = conn.createStatement();
				
				if(check.equalsIgnoreCase("1")){
				
				if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
					sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
				}
				
				String sql = "",condition="";
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    		}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and j.brhId="+branch+"";
	    		}

				if(!(accdocno.equalsIgnoreCase("0")) && !(accdocno.equalsIgnoreCase(""))){
					sql+=" and j.acno="+accdocno+"";
	            }
				
				if(!(salesperson.equalsIgnoreCase(""))){
	    			sql+=" and bk.sal_id="+salesperson+"";
	    		}
				
				if(!(category.equalsIgnoreCase(""))){
	    			sql+=" and bk.catid="+category+"";
	    		}
				
		        if(!(sqlUpToDate==null)){
		        	sql+=" and j.date<='"+sqlUpToDate+"'";
			        }
				
				/*sql = "select name 'ACCOUNT_NAME',ag.contact 'CONTACT_PERSON',ag.pmob 'MOBILE_NO',CONVERT(if(sum(t7+u6)<0,round((sum(t7+u6)*-1),2),''),CHAR(10)) 'ADVANCE',CONVERT(if(sum(t7+u6)>0,round((sum(t7+u6)),2),''),CHAR(10)) 'BALANCE',CONVERT(if(sum(u6<0),round((sum(u6*-1)),2),''),CHAR(10)) 'APPLIED',"
						+ "CONVERT(if(sum(t7)>0,round((sum(t7)),2),''),CHAR(10)) 'TOTAL',ag.acno,ag.brhid 'BRANCH_ID' from (select d.name,d.mob,d.contact,d.pmob,d.acno,d.brhid,d.doc_no,"
						+ "CONVERT(if(d.bal<0,round((d.bal),2),''),CHAR(10)) U6,if(d.bal>0,d.bal,0) t7 from (select j.acno,j.brhid,h.description name,bk.com_mob mob,bk.per_mob pmob,"
						+ "bk.contactPerson contact,sum(dramount) - coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc "
						+ "on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno  "+condition+" left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join "
						+ "my_jvtran j on j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+" and j.id>0  group by j.tranid having bal<>0 union all select j.acno,j.brhid,"
						+ "h.description name,bk.com_mob mob,bk.per_mob pmob,bk.contactPerson contact,"
						+ "sum(dramount)- coalesce(o.amount,0)*id bal, j.tranid, j.doc_no,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) duedys from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on "
						+ "j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno  "+condition+" left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' "
						+ "group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+" and j.id<0 group by j.tranid having bal<>0) d) ag group by acno";*/
				
				/*sql = "select name 'ACCOUNT_NAME',ag.contact 'CONTACT_PERSON',ag.pmob 'MOBILE_NO',CONVERT(if(sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))<0,round((sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))*-1),2),''),CHAR(10)) 'ADVANCE',"
						+ "CONVERT(if(sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))>0,round((sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))),2),''),CHAR(10)) 'BALANCE',CONVERT(if(sum(if(balance<0,round((balance),2),0)<0),round((sum(if(balance<0,round((balance),2),0)*-1)),2),''),CHAR(10)) 'UNAPPLIED',"
						+ "CONVERT(if(sum(if(balance>0,balance,0))>0,round((sum(if(balance>0,balance,0))),2),''),CHAR(10)) 'TOTAL',ag.acno,ag.brhid 'BRANCH_ID' from (select j.date,j.dtype,j.doc_no,j.acno,h.description name,bk.per_mob pmob,bk.contactPerson contact,if(j.description=0,'',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount) - "
						+ "coalesce(o.amount,0) balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no "
						+ "inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" "
						+ "left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid "
						+ "where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"'  "+sql+" and j.id>0 group by j.tranid having balance<>0 union all "
						+ "select j.date,j.dtype,j.doc_no,j.acno,h.description name,bk.per_mob pmob,bk.contactPerson contact,if(j.description=0,'',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount)+coalesce(o.amount,0) "
						+ "balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no "
						+ "inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) "
						+ "amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+" and j.id<0 "
						+ "group by j.tranid having balance<>0) ag group by acno";*/
				
				 if(atype.equalsIgnoreCase("AR")){
					condition=" and bk.dtype='CRM'";

					sql = "select name 'ACCOUNT_NAME',ag.contact 'CONTACT_PERSON',ag.pmob 'MOBILE_NO',CONVERT(if(sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))<0,"
						+ "round((sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))*-1),2),''),CHAR(50)) 'ADVANCE',CONVERT(if(sum(if(balance>0,balance,0)+if(balance<0,"
						+ "round((balance),2),0))>0,round((sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))),2),''),CHAR(50)) 'BALANCE',CONVERT(if(sum(if(balance<0,"
						+ "round((balance),2),0)<0),round((sum(if(balance<0,round((balance),2),0)*-1)),2),''),CHAR(50)) 'UNAPPLIED',CONVERT(if(sum(if(balance>0,balance,0))>0,"
						+ "round((sum(if(balance>0,balance,0))),2),''),CHAR(50)) 'TOTAL',ag.acno,ag.brhid 'BRANCH_ID' from (select j.date,j.dtype,j.doc_no,j.acno,h.description name,"
						+ "bk.per_mob pmob,bk.contactPerson contact,if(j.description=0,'',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,"
						+ "sum(dramount) - coalesce(o.amount,0) balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j "
						+ "inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no "
						+ "left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on "
						+ "j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"'  "+sql+" "
						+ "and j.id>0 group by j.tranid having balance<>0 union all select j.date,j.dtype,j.doc_no,j.acno,h.description name,bk.per_mob pmob,bk.contactPerson contact,"
						+ "if(j.description=0,'',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount)+coalesce(o.amount,0) balance, j.tranid,"
						+ "j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on "
						+ "b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" left join "
						+ "(select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on "
						+ "j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"' "+sql+" and j.id<0 group by j.tranid having balance<>0) ag group by acno";
				
		        } else if(atype.equalsIgnoreCase("AP")){
		        	condition=" and bk.dtype='VND'";
		        	
		        	sql = "select name 'ACCOUNT_NAME',ag.contact 'CONTACT_PERSON',ag.pmob 'MOBILE_NO',CONVERT(if(sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))>0,round((sum(if(balance>0,"
		        			+ "balance,0)+if(balance<0,round((balance),2),0))),2),''),CHAR(50)) 'ADVANCE',CONVERT(if(sum(if(balance>0,balance,0)+if(balance<0,round((balance),2),0))<0,round((sum(if(balance>0,"
		        			+ "balance,0)+if(balance<0,round((balance),2),0))*-1),2),''),CHAR(50)) 'BALANCE',CONVERT(if(sum(if(balance>0,round((balance),2),0)>0),round((sum(if(balance>0,round((balance),2),0))),2),''),CHAR(50)) "
		        			+ "'UNAPPLIED',CONVERT(if(sum(if(balance<0,balance,0))<0,round((sum(if(balance<0,balance,0))),2)*-1,''),CHAR(50)) 'TOTAL',ag.acno,ag.brhid 'BRANCH_ID' from (select j.date,j.dtype,j.doc_no,j.acno,"
		        			+ "h.description name,bk.per_mob pmob,bk.contactPerson contact,if(j.description=0,'',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount) - "
							+ "coalesce(o.amount,0) balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no "
							+ "inner join my_curr bc on b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" "
							+ "left join (select ap_trid,o.tranid,sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.tranid where j.date<='"+sqlUpToDate+"' group by ap_trid ) o on j.tranid=o.ap_trid "
							+ "where j.status=3 and h.atype='"+atype+"' and j.date<='"+sqlUpToDate+"'  "+sql+" and j.id<0 group by j.tranid having balance<>0 union all select j.date,j.dtype,j.doc_no,j.acno,h.description name,"
							+ "bk.per_mob pmob,bk.contactPerson contact,if(j.description=0,'',j.description) description,sum(dramount) amount,CONVERT(coalesce(o.amount,''),CHAR(50)) applied,sum(dramount)+coalesce(o.amount,0) "
							+ "balance, j.tranid, j.brhid,TIMESTAMPDIFF(Day,cast(j.date as datetime),cast('"+sqlUpToDate+"' as datetime)) age from my_jvtran j inner join my_brch b on j.brhId=b.doc_no inner join my_curr bc on "
							+ "b.curId=bc.doc_no inner join my_head h on j.acno=h.doc_no inner join my_curr c on j.curId=c.doc_no left join my_acbook bk on h.cldocno=bk.cldocno "+condition+" left join (select ap_trid,o.tranid,"
							+ "sum(coalesce(amount,0)) amount from my_outd o inner join my_jvtran j on j.tranid=o.ap_trid where j.date<='"+sqlUpToDate+"' group by tranid) o on j.tranid=o.tranid where j.status=3 and h.atype='"+atype+"' "
							+ "and j.date<='"+sqlUpToDate+"' "+sql+" and j.id>0 group by j.tranid having balance<>0) ag group by acno";
					
				}
				
				ResultSet resultSet = stmtDayBook.executeQuery(sql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				}
				
				stmtDayBook.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
public JSONArray accountsDetails(HttpSession session,String accountno,String accountname,String date,String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = ClsConnection.getMyConnection();
		       Statement stmtBPO = conn.createStatement();
	
		       Enumeration<String> Enumeration = session.getAttributeNames();
	           int a=0;
	           while(Enumeration.hasMoreElements()){
	            if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
	             a=1;
	            }
	           }
	           if(a==0){
	              return RESULTDATA;
	            }
	           String branch=session.getAttribute("BRANCHID").toString();
	           String company = session.getAttribute("COMPANYID").toString();
	           
	           java.sql.Date sqlDate=null;
	           
	           if(check.equalsIgnoreCase("1")){
	        	   
		        String sqltest="";
		        String sql="";
		        
		        date.trim();
		           if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
		           {
		        	   sqlDate = ClsCommon.changeStringtoSqlDate(date);
		           }
		        
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		           sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        	
		        sql="select t.doc_no,t.account,t.description,t.atype,t.curid,c.code currency,round(cb.rate,2) rate,c.type from my_head t left join my_curr c on t.curid=c.doc_no "
			        	  + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
			        	  + "where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
			        	  + "where t.atype='GL' and t.m_s=0 and t.den=305"+sqltest;
		        System.out.println("banksql---->>>"+sql);  
		       ResultSet resultSet = stmtBPO.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
		       stmtBPO.close();
		       conn.close();
		       }
	          stmtBPO.close();
			  conn.close();   
	     }
	     catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     }finally{
				conn.close();
			}
	       return RESULTDATA;
	  }

	public JSONArray accountDetails(String type,String account,String partyname,String contact,String check) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	    if(!(check.equalsIgnoreCase("1"))){
	    	return RESULTDATA1;
	    }
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtIndividualAgeing1 = conn.createStatement();
			
	    	    String sql = "";
	    	    String condition="";
            	
				/*if(type.equalsIgnoreCase("AR")){
					condition="and a.dtype='CRM'";
				}*/
				if(type.equalsIgnoreCase("AP")){
					condition="and a.dtype='VND'";
				}
				
	    	    if(!(account.equalsIgnoreCase(""))){
	                sql=sql+" and t.doc_no like '%"+account+"%'";
	            }
	            if(!(partyname.equalsIgnoreCase(""))){
	             sql=sql+" and t.description like '%"+partyname+"%'";
	            }
	            if(!(contact.equalsIgnoreCase(""))){
	                sql=sql+" and a.per_mob like '%"+contact+"%'";
	            }
	            
				sql = "select a.per_mob,t.doc_no,t.account,t.description,c.code curr from my_acbook a left join my_head t on a.acno=t.doc_no "
						+ ""+condition+" left join my_curr c on t.curid=c.doc_no where t.atype='"+type+"' and a.status<>7 and t.m_s=0"+sql;
				//System.out.println("sql====="+sql);        
				ResultSet resultSet1 = stmtIndividualAgeing1.executeQuery(sql);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtIndividualAgeing1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
}
