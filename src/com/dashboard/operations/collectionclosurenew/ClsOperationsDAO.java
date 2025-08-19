package com.dashboard.operations.collectionclosurenew;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsOperationsDAO  {
	ClsConnection ClsConnection=new ClsConnection();  

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray staffListGridLoading(String type) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtStaff = conn.createStatement();
			    String sql="";
			    
			    if(!(type.equalsIgnoreCase("") || type.equalsIgnoreCase("SLM"))){
			         sql=sql+" and s.sal_type like '%"+type+"%'";
			        }
			    
			    if(type.equalsIgnoreCase("SLM")){
			    
			    	sql = "select m.sal_id salcode,m.sal_name,if(m.mob_no=null,' ',m.mob_no) mobile,if(m.mail=null,' ',m.mail) mail,(select 'SLM') sal_type,"
			    	    + "(select 'Sales Man') salestype from my_salm m where m.status<>7";
			    	//System.out.println("sql1============"+sql);
			    }else if(!(type.equalsIgnoreCase("") || type.equalsIgnoreCase("SLM"))){
			    
			    	sql = "select dr.dr_id,dr.name,dr.dob,DATE_FORMAT(dr.dob,'%d.%m.%Y') AS hiddob,dr.nation nation1,dr.mobno,dr.passport_no,dr.pass_exp,"
			    			+ "DATE_FORMAT(dr.pass_exp,'%d.%m.%Y') AS hidpassexp,dr.dlno,dr.issdate,DATE_FORMAT(dr.issdate,'%d.%m.%Y') AS hidissdate,dr.issfrm,"
			    			+ "dr.led,DATE_FORMAT(dr.led,'%d.%m.%Y') AS hidled,dr.ltype,dr.visano,dr.visa_exp,DATE_FORMAT(dr.visa_exp,'%d.%m.%Y') AS hidvisaexp,"
			    			+ " s.sal_code salcode,s.sal_name,if(s.mobile=null,' ',s.mobile) mobile,if(s.mail=null,' ',s.mail) mail,s.sal_type,"
					    	+ "CASE s.sal_type WHEN 'SLA' THEN 'Sales Agent' WHEN 'RLA' THEN 'Rental Agent' WHEN 'DRV' THEN 'Driver' WHEN 'CHK' THEN 'Check In' "
					    	+ "WHEN 'STF' THEN 'Staff' ELSE '' END AS salestype from my_salesman s left join gl_drdetails dr on (s.doc_no=dr.doc_no and s.sal_type=dr.dtype) where s.status<>7"+sql+"";
			    	//System.out.println("sql2============"+sql);
			    }else{
			    
				    sql = "select dr.dr_id,dr.name,dr.dob,DATE_FORMAT(dr.dob,'%d.%m.%Y') AS hiddob,dr.nation nation1,dr.mobno,dr.passport_no,dr.pass_exp,"
				    	+ "DATE_FORMAT(dr.pass_exp,'%d.%m.%Y') AS hidpassexp,dr.dlno,dr.issdate,DATE_FORMAT(dr.issdate,'%d.%m.%Y') AS hidissdate,dr.issfrm,"
				    	+ "dr.led,DATE_FORMAT(dr.led,'%d.%m.%Y') AS hidled,dr.ltype,dr.visano,dr.visa_exp,DATE_FORMAT(dr.visa_exp,'%d.%m.%Y') AS hidvisaexp,"
				    	+ " s.sal_code salcode,s.sal_name,if(s.mobile=null,' ',s.mobile) mobile,if(s.mail=null,' ',s.mail) mail,s.sal_type,"
				    	+ "CASE s.sal_type WHEN 'SLA' THEN 'Sales Agent' WHEN 'RLA' THEN 'Rental Agent' WHEN 'DRV' THEN 'Driver' WHEN 'CHK' THEN 'Check In' "
				    	+ "WHEN 'STF' THEN 'Staff' ELSE '' END AS salestype from my_salesman s left join gl_drdetails dr on (s.doc_no=dr.doc_no and s.sal_type=dr.dtype) "
				    	+ "where s.status<>7 union select '' dr_id,'' name,null dob,null hiddob,'' nation1,'' mobno,'' passport_no,null pass_exp,null hidpassexp,'' dlno,null issdate,null hidissdate,"
				    	+ "null issfrm,null led,null hidled,'' ltype,'' visano,null visa_exp,null hidvisaexp, m.sal_id salcode,m.sal_name,"
				    	+ "if(m.mob_no=null,' ',m.mob_no) mobile,if(m.mail=null,' ',m.mail) mail,(select 'SLM') type,(select 'Sales Man') salestype from "
				    	+ "my_salm m where m.status<>7";
				    //System.out.println("sql3============="+sql);
			    }
			    
			    ResultSet resultSet = stmtStaff.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtStaff.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	 public JSONArray clentdetails() throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn =null;
	        try {
				 conn = ClsConnection.getMyConnection();
				 Statement stmtVeh = conn.createStatement ();
				
				String sql="select cldocno,refname from my_acbook where status=3 and dtype='CRM'"; 
				 ResultSet resultSet = stmtVeh.executeQuery(sql);
	        	
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
	 			
				stmtVeh.close();
	 			conn.close();
	       
		} catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	public JSONArray collectionClosureGridLoading(String branch,String fromdate,String todate,String payas,String status,String cldocno) throws SQLException {
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
        
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtClosure = conn.createStatement();
			    String sql = "",sqlf="";
			    int val=0;
			   
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and r.brhid="+branch+"";
	    		}
			    if(!((payas.equalsIgnoreCase("0")) || (payas.equalsIgnoreCase("")))){
	    			sql+=" and r.payas="+payas+"";
	    		}
			    if(!((cldocno.equalsIgnoreCase("0")) || (cldocno.equalsIgnoreCase("")))){
	    			sql+=" and r.cldocno="+cldocno+"";
	    		}
			    if(!((status.equalsIgnoreCase("0")) || (status.equalsIgnoreCase("")))){
	    			if(status.equalsIgnoreCase("1")){
	    				sql+=" and r.posttrno!=0";
	    			}else{
	    				sql+=" and r.posttrno=0";
	    			}
	    		}
			    String fetch="select method from gl_config where field_nme like '%Collection Closure%'";
			    ResultSet result = stmtClosure.executeQuery(fetch);
			    if(result.next()){
			    	val=result.getInt("method");
			    }
			    if(val==1)
			    {
			    	sql="select  cc.user,cc.loc,cc.jvno pdocno,cc.posttype ptype,cc.salname salmn,cc.agmtopndate,cc.branch,cc.date,cc.rdocno,cc.dtype,cc.srno,cc.refname,concat(cc.payas,' ',cc.cardtype) payas,CONVERT(coalesce(cc.no,''),CHAR(100)) as rano,COALESCE(cc.cashtotal,0) cashtotal,COALESCE(cc.cardtotal,0) cardtotal,COALESCE(cc.chequetotal,0) chequetotal from "
		    		        + "(select us.user_name user,lc.loc_name loc,s.sal_name salname,r.jvno,r.posttype,COALESCE(ra.date,la.date) agmtopndate,if(r.ibbrchid=0,b.branchname,br.branchname) branch,r.date,r.rdocno,r.dtype,r.srno,a.refname,if(r.payas=1,'On Account',if(r.payas=2,'Advance','Security')) payas, "
		    				+ "if(r.cardtype=0,' ',if(r.cardtype=2,'(Master)','(Visa)')) cardtype, CONCAT(IF(ra.voc_no IS NULL,'LAG','RAG') , ' - ' ,COALESCE(ra.voc_no,la.voc_no)) NO, "
		    				+ "CONVERT(if(r.paytype=1,round(r.netamt,2),'  '),CHAR(100)) cashtotal,CONVERT(if(r.paytype=2,round(r.netamt,2),'  '),CHAR(100)) cardtotal,CONVERT(if(r.paytype=3,round(r.netamt,2),'  '),CHAR(100)) chequetotal from "
		    				+ "gl_rentreceipt r left join tr_servicereqm ser on (ser.doc_no=r.aggno and r.rtype='Service Request') left join my_user us on us.doc_no=r.userid LEFT JOIN MY_locm lc ON r.locid=lc.doc_no LEFT JOIN MY_HEAD H ON R.CLDOCNO=H.CLDOCNO AND H.DTYPE='CRM' "
		    				+ "left join my_jvtran j on r.tr_no=j.tr_no AND H.DOC_NO=J.ACNO left join my_outd o on j.tranid=o.tranid left join my_jvtran jv on jv.tranid=o.ap_trid left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM' left join my_salm s on s.doc_no=ser.salid left join gl_ragmt ra on ((r.aggno=ra.doc_no and r.rtype='RAG' ) OR  (JV.RDOCNO=ra.doc_no and JV.rtype='RAG' )) "
		    				+ "left join gl_lagmt la on ((r.aggno=la.doc_no and r.rtype='LAG') OR  (JV.RDOCNO=La.doc_no and JV.rtype='LAG' )) left join my_brch b on r.brhid=b.branch left join my_brch br on r.ibbrchid=br.branch where r.date>='"+sqlFromDate+"' and "
		    				+ "r.date<='"+sqlToDate+"' and r.status=3 "+sql+" group by r.srno,r.brhid)cc";   
		    }else{
		     sql = "select cc.user,cc.loc,cc.jvno pdocno,cc.posttype ptype,cc.salname salmn,cc.agmtopndate,cc.branch,cc.date,cc.rdocno,cc.dtype,cc.srno,cc.refname,concat(cc.payas,' ',cc.cardtype) payas,CONVERT(coalesce(cc.rano,''),CHAR(100))as rano,COALESCE(cc.cashtotal,0) cashtotal,COALESCE(cc.cardtotal,0) cardtotal,COALESCE(cc.chequetotal,0) chequetotal from "
					+ "(select us.user_name user,lc.loc_name loc,s.sal_name salname,r.jvno,r.posttype,if(r.rtype='RAG',ra.date,la.date) agmtopndate,if(r.ibbrchid=0,b.branchname,br.branchname) branch,r.date,r.rdocno,r.dtype,r.srno,a.refname,if(r.payas=1,'On Account',if(r.payas=2,'Advance','Security')) payas,"
					+ "if(r.cardtype=0,' ',if(r.cardtype=2,'(Master)','(Visa)')) cardtype,if(r.payas=1,concat(jv.rtype,' - ',CONVERT(jv.rdocno,CHAR(100))),concat(r.rtype,' - ',CONVERT(if(r.rtype='0','',if(r.rtype='RAG',ra.voc_no,la.voc_no)),CHAR(100)))) rano,"
					+ "CONVERT(if(r.paytype=1,round(r.netamt,2),'  '),CHAR(100)) cashtotal,CONVERT(if(r.paytype=2,round(r.netamt,2),'  '),CHAR(100)) cardtotal,CONVERT(if(r.paytype=3,round(r.netamt,2),'  '),CHAR(100)) chequetotal from gl_rentreceipt r left join tr_servicereqm ser on (ser.doc_no=r.aggno and r.rtype='Service Request') left join my_user us on us.doc_no=r.userid "     
					+ " LEFT JOIN MY_locm lc ON r.locid=lc.doc_no left join my_jvtran j on r.tr_no=j.tr_no left join my_outd o on j.tranid=o.tranid left join my_jvtran jv on jv.tranid=o.ap_trid left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM' left join my_salm s on s.doc_no=ser.salid left join gl_ragmt ra on "
					+ "(r.aggno=ra.doc_no and r.rtype='RAG') left join gl_lagmt la on (r.aggno=la.doc_no and r.rtype='LAG') left join my_brch b on r.brhid=b.branch left join my_brch br on r.ibbrchid=br.branch where r.date>='"+sqlFromDate+"' and "
					+ "r.date<='"+sqlToDate+"' and r.status=3 "+sql+" group by r.srno,r.brhid)cc";   
		     }
			   System.out.println("==grid query=="+sql);    
			    ResultSet resultSet = stmtClosure.executeQuery(sql);
			                
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
		
	public JSONArray collectionClosureGridExcelExport(String branch,String fromdate,String todate,String payas,String status,String cldocno) throws SQLException {
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
		          
			    String sql = "";
			    int val=0;
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and r.brhid="+branch+"";
	    		}
			    if(!((payas.equalsIgnoreCase("0")) || (payas.equalsIgnoreCase("")))){
	    			sql+=" and r.payas="+payas+"";
	    		}
			    if(!((cldocno.equalsIgnoreCase("0")) || (cldocno.equalsIgnoreCase("")))){
	    			sql+=" and r.cldocno="+cldocno+"";
	    		}
			    if(!((status.equalsIgnoreCase("0")) || (status.equalsIgnoreCase("")))){
	    			if(status.equalsIgnoreCase("1")){
	    				sql+=" and r.posttrno!=0";
	    			}else{
	    				sql+=" and r.posttrno=0";
	    			}
	    		}
			    String fetch="select method from gl_config where field_nme like '%Collection Closure%'";
			    ResultSet result = stmtClosure.executeQuery(fetch);
			    if(result.next()){
			    	val=result.getInt("method");
			    }
			    if(val==1)
			    {
			    	 sql="select  cc.branch,cc.loc location,cc.date,cc.rdocno 'Doc No',cc.dtype,cc.srno 'RRV No',cc.refname 'Client',cc.user,concat(cc.payas,' ',cc.cardtype) payas,cc.salname salesman,cc.jvno 'Posted Docno',cc.posttype 'Posted Type',CONVERT(coalesce(cc.no,''),CHAR(100))as Agreement,cc.agmtopndate 'AgreementDate',cc.cashtotal,cc.cardtotal,cc.chequetotal from "
			    		        + "(select us.user_name user,lc.loc_name loc,s.sal_name salname,r.jvno,r.posttype,COALESCE(ra.date,la.date) agmtopndate,if(r.ibbrchid=0,b.branchname,br.branchname) branch,r.date,r.rdocno,r.dtype,r.srno,a.refname,if(r.payas=1,'On Account',if(r.payas=2,'Advance','Security')) payas, "
			    				+ "if(r.cardtype=0,' ',if(r.cardtype=2,'(Master)','(Visa)')) cardtype, CONCAT(IF(ra.voc_no IS NULL,'LAG','RAG') , ' - ' ,COALESCE(ra.voc_no,la.voc_no)) NO, "
			    				+ "CONVERT(if(r.paytype=1,round(r.netamt,2),'  '),CHAR(100)) cashtotal,CONVERT(if(r.paytype=2,round(r.netamt,2),'  '),CHAR(100)) cardtotal,CONVERT(if(r.paytype=3,round(r.netamt,2),'  '),CHAR(100)) chequetotal from "
			    				+ "gl_rentreceipt r left join tr_servicereqm ser on (ser.doc_no=r.aggno and r.rtype='Service Request') left join my_user us on us.doc_no=r.userid LEFT JOIN MY_locm lc ON r.locid=lc.doc_no  LEFT JOIN MY_HEAD H ON R.CLDOCNO=H.CLDOCNO AND H.DTYPE='CRM' "
			    				+ "left join my_jvtran j on r.tr_no=j.tr_no AND H.DOC_NO=J.ACNO left join my_outd o on j.tranid=o.tranid left join my_jvtran jv on jv.tranid=o.ap_trid left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM' left join my_salm s on s.doc_no=ser.salid left join gl_ragmt ra on ((r.aggno=ra.doc_no and r.rtype='RAG' ) OR  (JV.RDOCNO=ra.doc_no and JV.rtype='RAG' )) "
			    				+ "left join gl_lagmt la on ((r.aggno=la.doc_no and r.rtype='LAG') OR  (JV.RDOCNO=La.doc_no and JV.rtype='LAG' )) left join my_brch b on r.brhid=b.branch left join my_brch br on r.ibbrchid=br.branch where r.date>='"+sqlFromDate+"' and "
			    				+ "r.date<='"+sqlToDate+"' and r.status=3 "+sql+" group by r.srno,r.brhid)cc";
			    }else{
			     sql = "select cc.branch 'Branch',cc.loc  location,cc.rdocno 'Doc No',cc.date 'Date',cc.dtype 'Doc Type',cc.srno 'RRV No.',cc.refname 'Client',cc.user,concat(cc.payas,' ',cc.cardtype) 'Paid As',cc.salname salesman,cc.jvno 'Posted Docno',cc.posttype 'Posted Type',"
			    		+ "coalesce(cc.rano,'') as 'Agreement',cc.agmtopndate 'Agmt. Opn. Date',cc.cashtotal 'Cash Total',cc.cardtotal 'Card Total',cc.chequetotal 'Cheque Total' from ( "
						+ "select us.user_name user,lc.loc_name loc,s.sal_name salname,r.jvno,r.posttype,if(r.rtype='RAG',ra.date,la.date) agmtopndate,if(r.ibbrchid=0,b.branchname,br.branchname) branch,r.date,r.rdocno,r.dtype,r.srno,a.refname,if(r.payas=1,'On Account',if(r.payas=2,'Advance','Security')) payas,"
						+ "if(r.cardtype=0,' ',if(r.cardtype=2,'(Master)','(Visa)')) cardtype,if(r.payas=1,concat(jv.rtype,' - ',CONVERT(jv.rdocno,CHAR(100))),concat(r.rtype,' - ',CONVERT(if(r.rtype='0','',if(r.rtype='RAG',ra.voc_no,la.voc_no)),CHAR(100)))) rano,"
						+ "CONVERT(if(r.paytype=1,round(r.netamt,2),'  '),CHAR(100)) cashtotal,CONVERT(if(r.paytype=2,round(r.netamt,2),'  '),CHAR(100)) cardtotal,CONVERT(if(r.paytype=3,round(r.netamt,2),'  '),CHAR(100)) chequetotal from gl_rentreceipt r  left join tr_servicereqm ser on (ser.doc_no=r.aggno and r.rtype='Service Request') left join my_user us on us.doc_no=r.userid "
						+ " LEFT JOIN MY_locm lc ON r.locid=lc.doc_no  left join my_jvtran j on r.tr_no=j.tr_no left join my_outd o on j.tranid=o.tranid left join my_jvtran jv on jv.tranid=o.ap_trid left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM' left join my_salm s on s.doc_no=ser.salid left join gl_ragmt ra on "
						+ "(r.aggno=ra.doc_no and r.rtype='RAG') left join gl_lagmt la on (r.aggno=la.doc_no and r.rtype='LAG') left join my_brch b on r.brhid=b.branch left join my_brch br on r.ibbrchid=br.branch where r.date>='"+sqlFromDate+"' and "
						+ "r.date<='"+sqlToDate+"' and r.status=3 "+sql+" group by r.srno,r.brhid)cc";
			     }
			    ResultSet resultSet = stmtClosure.executeQuery(sql);
			                
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
	
	public ClsOperationsBean getPrint(HttpServletRequest request,String branch,String fromdate,String todate) throws SQLException {
		ClsOperationsBean bean = new ClsOperationsBean();
		
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
		
		sql1 = "select cc.branch,coalesce(cc.loc,'') loc,cc.date,cc.rdocno,cc.dtype,cc.srno,cc.refname,concat(cc.payas,' ',cc.cardtype) payas,coalesce(cc.rano,'') as rano,cc.cashtotal,cc.cardtotal,cc.chequetotal from "
			+ "(select lc.loc_name loc,if(r.ibbrchid=0,b.branchname,br.branchname) branch,DATE_FORMAT(r.date,'%d-%m-%Y') date,r.rdocno,r.dtype,r.srno,a.refname,if(r.payas=1,'On Account',if(r.payas=2,'Advance','Security')) payas,"
			+ "if(r.cardtype=0,' ',if(r.cardtype=2,'(Master)','(Visa)')) cardtype,concat(r.rtype,' - ',if(r.rtype='0','',if(r.rtype='RAG',ra.voc_no,la.voc_no))) rano,"
			+ "CONVERT(if(r.paytype=1,round(r.netamt,2),'  '),CHAR(100)) cashtotal,CONVERT(if(r.paytype=2,round(r.netamt,2),'  '),CHAR(100)) cardtotal,CONVERT(if(r.paytype=3,round(r.netamt,2),'  '),CHAR(100)) chequetotal "
			+ "from gl_rentreceipt r left join my_locm lc on r.locid=lc.doc_no left join my_jvtran j on r.tr_no=j.tr_no left join my_outd o on j.tranid=o.tranid left join my_jvtran jv on jv.tranid=o.ap_trid left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM' "
			+ "left join gl_ragmt ra on (r.aggno=ra.doc_no and r.rtype='RAG') left join gl_lagmt la on (r.aggno=la.doc_no and r.rtype='LAG') left join my_brch b on r.brhid=b.branch left join my_brch br on r.ibbrchid=br.branch "
			+ "where r.date>='"+sqlFromDate+"' and r.date<='"+sqlToDate+"' and r.status=3 "+sqld+" group by r.srno)cc";
		
		ResultSet resultSet1 = stmtCollectionClosure.executeQuery(sql1);
		
		ArrayList<String> printarray= new ArrayList<String>();
		
		while(resultSet1.next()){

			String temp="";
			temp=resultSet1.getString("branch")+"::"+resultSet1.getString("loc")+"::"+resultSet1.getString("rdocno")+"::"+resultSet1.getString("date")+"::"+resultSet1.getString("dtype")+"::"+resultSet1.getString("srno")+"::"+resultSet1.getString("refname")+"::"+resultSet1.getString("payas")+"::"+resultSet1.getString("rano")+"::"+resultSet1.getString("cashtotal")+"::"+resultSet1.getString("cardtotal")+"::"+resultSet1.getString("chequetotal");
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