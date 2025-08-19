
package com.dashboard.operations.alfahin;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsalfahinDAO  {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	
	
	public JSONArray alfahinGridLoading(String branch,String fromdate,String todate,String doc_no) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
		
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
        }
        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
        }
       // System.out.println("kjfnk"+doc_no);
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtClosure = conn.createStatement();
			    String sqld = "",sqlf="";
			    int val=0;
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sqld+=" and r.brhid="+branch+"";
	    		}
			    if(!(doc_no.equalsIgnoreCase("")) && !(doc_no.equalsIgnoreCase("NA"))){
		            sqld=sqld+" and r.userid ="+doc_no+" ";
		         }
			    String fetch="select method from gl_config where field_nme like '%Collection Closure%'";
			    ResultSet result = stmtClosure.executeQuery(fetch);
			    if(result.next()){
			    	val=result.getInt("method");
			    }
			    
			    //System.out.println("lkjbvlkjdf"+doc_no);
			    if(val==1)
			    {
			     sqlf="select  cc.agmtopndate,cc.branch,cc.date,cc.rdocno,cc.dtype,cc.srno,cc.refname,concat(cc.payas,' ',cc.cardtype) payas,coalesce(cc.no,'') as rano,cc.cashtotal,cc.cardtotal,cc.chequetotal from "
			    		        + "(select COALESCE(ra.date,la.date) agmtopndate,if(r.ibbrchid=0,b.branchname,br.branchname) branch,r.date,r.rdocno,r.dtype,r.srno,a.refname,if(r.payas=1,'On Account',if(r.payas=2,'Advance','Security')) payas, "
			    				+ "if(r.cardtype=0,' ',if(r.cardtype=2,'(Master)','(Visa)')) cardtype, CONCAT(IF(ra.voc_no IS NULL,'LAG','RAG') , ' - ' ,COALESCE(ra.voc_no,la.voc_no)) NO, "
			    				+ "CONVERT(if(r.paytype=1,round(r.netamt,2),'  '),CHAR(100)) cashtotal,CONVERT(if(r.paytype=2,round(r.netamt,2),'  '),CHAR(100)) cardtotal,CONVERT(if(r.paytype=3,round(r.netamt,2),'  '),CHAR(100)) chequetotal from "
			    				+ "gl_rentreceipt r LEFT JOIN MY_HEAD H ON R.CLDOCNO=H.CLDOCNO AND H.DTYPE='CRM' "
			    				+ "left join my_jvtran j on r.tr_no=j.tr_no AND H.DOC_NO=J.ACNO left join my_outd o on j.tranid=o.tranid left join my_jvtran jv on jv.tranid=o.ap_trid left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM' left join gl_ragmt ra on ((r.aggno=ra.doc_no and r.rtype='RAG' ) OR  (JV.RDOCNO=ra.doc_no and JV.rtype='RAG' )) "
			    				+ "left join gl_lagmt la on ((r.aggno=la.doc_no and r.rtype='LAG') OR  (JV.RDOCNO=La.doc_no and JV.rtype='LAG' )) left join my_brch b on r.brhid=b.branch left join my_brch br on r.ibbrchid=br.branch where r.date>='"+sqlFromDate+"' and "
			    				+ "r.date<='"+sqlToDate+"' and r.status=3 "+sqld+" group by r.srno,r.brhid)cc";
			    }else{
			    
			      sqlf = "select cc.branch,cc.user_name,cc.date,cc.rdocno,cc.dtype,cc.srno,cc.refname,concat(cc.payas,' ',cc.cardtype) payas,coalesce(cc.rano,'') as rano,cc.cashtotal,cc.cardtotal,cc.chequetotal from "
						+ "(select if(r.ibbrchid=0,b.branchname,br.branchname) branch,r.date,r.rdocno,r.dtype,r.srno,a.refname,if(r.payas=1,'On Account',if(r.payas=2,'Advance','Security')) payas,"
						+ "if(r.cardtype=0,' ',if(r.cardtype=2,'(Master)','(Visa)')) cardtype,if(r.payas=1,concat(jv.rtype,' - ',CONVERT(jv.rdocno,CHAR(100))),concat(r.rtype,' - ',CONVERT(if(r.rtype='0','',if(r.rtype='RAG',ra.voc_no,la.voc_no)),CHAR(100)))) rano,"
						+ "CONVERT(if(r.paytype=1,round(r.netamt,2),'  '),CHAR(100)) cashtotal,CONVERT(if(r.paytype=2,round(r.netamt,2),'  '),CHAR(100)) cardtotal,CONVERT(if(r.paytype=3,round(r.netamt,2),'  '),CHAR(100)) chequetotal,us.user_name from gl_rentreceipt r "
						+ "left join my_user us on r.userid=us.doc_no left join my_jvtran j on r.tr_no=j.tr_no left join my_outd o on j.tranid=o.tranid left join my_jvtran jv on jv.tranid=o.ap_trid left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM' left join gl_ragmt ra on "
						+ "(r.aggno=ra.doc_no and r.rtype='RAG') left join gl_lagmt la on (r.aggno=la.doc_no and r.rtype='LAG') left join my_brch b on r.brhid=b.doc_no left join my_brch br on r.ibbrchid=br.doc_no where r.date>='"+sqlFromDate+"' and "
						+ "r.date<='"+sqlToDate+"' and r.status=3 "+sqld+" group by r.srno,r.brhid)cc";
			    }
			    System.out.println("chng===="+sqlf);
			    ResultSet resultSet = stmtClosure.executeQuery(sqlf);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtClosure.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
		
	public JSONArray alfahinGridExcelExport(String branch,String fromdate,String todate,String doc_no) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
		
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtClosure = conn.createStatement();
			    
			    if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        
			    if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
		        
			    String sqld = "",sqlf="";
			    int val=0;
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sqld+=" and r.brhid="+branch+"";
	    		}
			    if(!(doc_no.equalsIgnoreCase("")) && !(doc_no.equalsIgnoreCase("NA"))){
		            sqld=sqld+" and r.userid ="+doc_no+" ";
		         }
			    
			    String fetch="select method from gl_config where field_nme like '%Collection Closure%'";
			    ResultSet result = stmtClosure.executeQuery(fetch);
			    if(result.next()){
			    	val=result.getInt("method");
			    }
			    
			    if(val==1)
			    {
			    	 sqlf="select  cc.agmtopndate,cc.branch,cc.date,cc.rdocno,cc.dtype,cc.srno,cc.refname,concat(cc.payas,' ',cc.cardtype) payas,coalesce(cc.no,'') as rano,cc.cashtotal,cc.cardtotal,cc.chequetotal from "
			    		        + "(select COALESCE(ra.date,la.date) agmtopndate,if(r.ibbrchid=0,b.branchname,br.branchname) branch,r.date,r.rdocno,r.dtype,r.srno,a.refname,if(r.payas=1,'On Account',if(r.payas=2,'Advance','Security')) payas, "
			    				+ "if(r.cardtype=0,' ',if(r.cardtype=2,'(Master)','(Visa)')) cardtype, CONCAT(IF(ra.voc_no IS NULL,'LAG','RAG') , ' - ' ,COALESCE(ra.voc_no,la.voc_no)) NO, "
			    				+ "CONVERT(if(r.paytype=1,round(r.netamt,2),'  '),CHAR(100)) cashtotal,CONVERT(if(r.paytype=2,round(r.netamt,2),'  '),CHAR(100)) cardtotal,CONVERT(if(r.paytype=3,round(r.netamt,2),'  '),CHAR(100)) chequetotal from "
			    				+ "gl_rentreceipt r LEFT JOIN MY_HEAD H ON R.CLDOCNO=H.CLDOCNO AND H.DTYPE='CRM' "
			    				+ "left join my_jvtran j on r.tr_no=j.tr_no AND H.DOC_NO=J.ACNO left join my_outd o on j.tranid=o.tranid left join my_jvtran jv on jv.tranid=o.ap_trid left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM' left join gl_ragmt ra on ((r.aggno=ra.doc_no and r.rtype='RAG' ) OR  (JV.RDOCNO=ra.doc_no and JV.rtype='RAG' )) "
			    				+ "left join gl_lagmt la on ((r.aggno=la.doc_no and r.rtype='LAG') OR  (JV.RDOCNO=La.doc_no and JV.rtype='LAG' )) left join my_brch b on r.brhid=b.branch left join my_brch br on r.ibbrchid=br.branch where r.date>='"+sqlFromDate+"' and "
			    				+ "r.date<='"+sqlToDate+"' and r.status=3 "+sqld+" group by r.srno,r.brhid)cc";
			    }else{
			    
			      sqlf = "select cc.branch,cc.user_name,cc.date,cc.rdocno,cc.dtype,cc.srno,cc.refname,concat(cc.payas,' ',cc.cardtype) payas,coalesce(cc.rano,'') as rano,cc.cashtotal,cc.cardtotal,cc.chequetotal from "
						+ "(select if(r.ibbrchid=0,b.branchname,br.branchname) branch,r.date,r.rdocno,r.dtype,r.srno,a.refname,if(r.payas=1,'On Account',if(r.payas=2,'Advance','Security')) payas,"
						+ "if(r.cardtype=0,' ',if(r.cardtype=2,'(Master)','(Visa)')) cardtype,if(r.payas=1,concat(jv.rtype,' - ',CONVERT(jv.rdocno,CHAR(100))),concat(r.rtype,' - ',CONVERT(if(r.rtype='0','',if(r.rtype='RAG',ra.voc_no,la.voc_no)),CHAR(100)))) rano,"
						+ "CONVERT(if(r.paytype=1,round(r.netamt,2),'  '),CHAR(100)) cashtotal,CONVERT(if(r.paytype=2,round(r.netamt,2),'  '),CHAR(100)) cardtotal,CONVERT(if(r.paytype=3,round(r.netamt,2),'  '),CHAR(100)) chequetotal,us.user_name from gl_rentreceipt r "
						+ "left join my_user us on r.userid=us.doc_no left join my_jvtran j on r.tr_no=j.tr_no left join my_outd o on j.tranid=o.tranid left join my_jvtran jv on jv.tranid=o.ap_trid left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM' left join gl_ragmt ra on "
						+ "(r.aggno=ra.doc_no and r.rtype='RAG') left join gl_lagmt la on (r.aggno=la.doc_no and r.rtype='LAG') left join my_brch b on r.brhid=b.doc_no left join my_brch br on r.ibbrchid=br.doc_no where r.date>='"+sqlFromDate+"' and "
						+ "r.date<='"+sqlToDate+"' and r.status=3 "+sqld+" group by r.srno,r.brhid)cc";
			    }
			    ResultSet resultSet = stmtClosure.executeQuery(sqlf);
			                
			    RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
			    
			    stmtClosure.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public ClsAlfahinBean getPrint(HttpServletRequest request,String branch,String fromdate,String todate,String doc_no) throws SQLException {
		ClsAlfahinBean bean = new ClsAlfahinBean();
		
		Connection conn = null;

	try {
		
		conn = ClsConnection.getMyConnection();
		Statement stmtCollectionClosure = conn.createStatement();
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		String sqld="",sql="",sql1 = "",sql2 = "";
		
        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
        }
        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
        }
		
		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			sqld+=" and r.brhId="+branch+"";
		}
		 if(!(doc_no.equalsIgnoreCase("a")) && !(doc_no.equalsIgnoreCase("NA"))){
	            sqld=sqld+" and r.userid ="+doc_no+" ";
	         }
		
		sql="select 'Collection Closure' vouchername,CONCAT('From ',DATE_FORMAT('"+sqlFromDate+"','%D %M  %Y '),'  To  ',DATE_FORMAT('"+sqlToDate+"','%D %M  %Y ')) vouchername1,"
			+ "c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_rentreceipt r inner join my_brch b on r.brhid=b.doc_no inner join my_comp c "
			+ "on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc "
			+ "on(lc.loc=l.loc and lc.brhid=b.doc_no) where 1=1 "+sqld+" group by r.brhid";
		
		ResultSet resultSet = stmtCollectionClosure.executeQuery(sql);
		
		while(resultSet.next()){
			bean.setLblcompname(resultSet.getString("company"));
			bean.setLblcompaddress(resultSet.getString("address"));
			bean.setLblprintname(resultSet.getString("vouchername"));
			bean.setLblprintname1(resultSet.getString("vouchername1"));
			bean.setLblcomptel(resultSet.getString("tel"));
			bean.setLblcompfax(resultSet.getString("fax"));
			bean.setLblbranch(resultSet.getString("branchname"));
			bean.setLbllocation(resultSet.getString("location"));
			bean.setLblcstno(resultSet.getString("cstno"));
			bean.setLblpan(resultSet.getString("pbno"));
			bean.setLblservicetax(resultSet.getString("stcno"));
		}
		
		sql1 = "select cc.branch,cc.date,cc.rdocno,cc.dtype,cc.srno,cc.refname,concat(cc.payas,' ',cc.cardtype) payas,coalesce(cc.rano,'') as rano,cc.cashtotal,cc.cardtotal,cc.chequetotal from "
			+ "(select if(r.ibbrchid=0,b.branchname,br.branchname) branch,DATE_FORMAT(r.date,'%d-%m-%Y') date,r.rdocno,r.dtype,r.srno,a.refname,if(r.payas=1,'On Account',if(r.payas=2,'Advance','Security')) payas,"
			+ "if(r.cardtype=0,' ',if(r.cardtype=2,'(Master)','(Visa)')) cardtype,concat(r.rtype,' - ',if(r.rtype='0','',if(r.rtype='RAG',ra.voc_no,la.voc_no))) rano,"
			+ "CONVERT(if(r.paytype=1,round(r.netamt,2),'  '),CHAR(100)) cashtotal,CONVERT(if(r.paytype=2,round(r.netamt,2),'  '),CHAR(100)) cardtotal,CONVERT(if(r.paytype=3,round(r.netamt,2),'  '),CHAR(100)) chequetotal "
			+ "from gl_rentreceipt r left join my_jvtran j on r.tr_no=j.tr_no left join my_outd o on j.tranid=o.tranid left join my_jvtran jv on jv.tranid=o.ap_trid left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM' "
			+ "left join gl_ragmt ra on (r.aggno=ra.doc_no and r.rtype='RAG') left join gl_lagmt la on (r.aggno=la.doc_no and r.rtype='LAG') left join my_brch b on r.brhid=b.doc_no left join my_brch br on r.ibbrchid=br.doc_no "
			+ "where r.date>='"+sqlFromDate+"' and r.date<='"+sqlToDate+"' and r.status=3 "+sqld+" group by r.srno)cc";
		
		ResultSet resultSet1 = stmtCollectionClosure.executeQuery(sql1);
		
		ArrayList<String> printarray= new ArrayList<String>();
		
		while(resultSet1.next()){

			String temp="";
			temp=resultSet1.getString("branch")+"::"+resultSet1.getString("rdocno")+"::"+resultSet1.getString("date")+"::"+resultSet1.getString("dtype")+"::"+resultSet1.getString("srno")+"::"+resultSet1.getString("refname")+"::"+resultSet1.getString("payas")+"::"+resultSet1.getString("rano")+"::"+resultSet1.getString("cashtotal")+"::"+resultSet1.getString("cardtotal")+"::"+resultSet1.getString("chequetotal");
		    printarray.add(temp);
		}
		request.setAttribute("printingarray", printarray);
		
		sql2 = "select round((cashtotal+cardtotal+chequetotal),2) nettotal,round(cashtotal,2) cashtotal,round(cardtotal,2) cardtotal,\r\n" +
				"round(chequetotal,2) chequetotal from (select sum(cc.cashtotal) cashtotal,sum(cc.cardtotal) cardtotal,\r\n" + 
				"sum(cc.chequetotal) chequetotal from (select CONVERT(if(r.paytype=1,round(r.netamt,2),'  '),CHAR(100)) cashtotal,\r\n" + 
				"CONVERT(if(r.paytype=2,round(r.netamt,2),'  '),CHAR(100)) cardtotal,\r\n" + 
				"CONVERT(if(r.paytype=3,round(r.netamt,2),'  '),CHAR(100)) chequetotal from gl_rentreceipt r left join my_jvtran j on r.tr_no=j.tr_no\r\n" + 
				"left join my_outd o on j.tranid=o.tranid left join my_jvtran jv on jv.tranid=o.ap_trid left join my_acbook a on r.cldocno=a.cldocno\r\n" + 
				"and a.dtype='CRM' left join gl_ragmt ra on (r.aggno=ra.doc_no and r.rtype='RAG') left join gl_lagmt la on (r.aggno=la.doc_no and\r\n" + 
				"r.rtype='LAG') left join my_brch b on r.brhid=b.branch left join my_brch br on r.ibbrchid=br.branch where r.date>='"+sqlFromDate+"' and\r\n" + 
				"r.date<='"+sqlToDate+"' and r.status=3 "+sqld+"  group by r.srno)cc ) as bb ";
		
		ResultSet resultSet2 = stmtCollectionClosure.executeQuery(sql2);
		
		String netamount="0.00",cashamount="0.00",cardamount="0.00",chequeamount="0.00";
		while(resultSet2.next()){
			cashamount=resultSet2.getString("cashtotal");
			cardamount=resultSet2.getString("cardtotal");
			chequeamount=resultSet2.getString("chequetotal");
			netamount=resultSet2.getString("nettotal");
		}
		
		bean.setLblcashtotal(cashamount);
		bean.setLblcardtotal(cardamount);
		bean.setLblchequetotal(chequeamount);
		bean.setLblnetbalance(netamount);
		
		stmtCollectionClosure.close();
		conn.close();
	} catch(Exception e){
		 e.printStackTrace();
		 conn.close();
	} finally{
		conn.close();
	}
	return bean;
   }
}