package com.dashboard.audit.vatreport;
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;
public class ClsVatReportDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getVatOutputData(String id,String branch,String fromdate,String todate) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="",sqltest1="",sqltest2="",sqltesttinv="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			// System.out.println("branch------------------------------- "+branch);
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and jv.brhid="+branch;
				sqltest1+=" and m.brhid="+branch;
				sqltest2+=" and sale.brhid="+branch;
				sqltesttinv=" and inv.brhid="+branch;
			}
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and jv.date>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and jv.date<='"+sqltodate+"'";
			}
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltesttinv+=" and inv.date>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){  
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltesttinv+=" and inv.date<='"+sqltodate+"'";  
			}
			
			String strtaxconfig="select saliktaxdate from my_comp where status=3";
			ResultSet rstaxconfig=stmt.executeQuery(strtaxconfig);
			java.sql.Date saliktaxdate=null;
			while(rstaxconfig.next()){
				saliktaxdate=rstaxconfig.getDate("saliktaxdate");
			}
			/*
			 * commeted after auh salik 
			 * 
			 *  select jv.date,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(inv.voc_no,char(25)) vocno,inv.doc_no,round(sum(dramount),2)*-1"+
			" totalvalue,round(sum(if(invhead.tax=1 and ac.tax=1 and invhead.idno<>20 and (inv.date between tax.fromdate and tax.todate),"+
			" dramount,0)),2)*-1 vatapplied,0 vatnotapplied,round(sum(if(invhead.idno=20,dramount,0)),2)*-1 vatcollected "
			+ " from my_jvtran jv inner join gl_invd invd on jv.tr_no=invd.trno and jv.acno=invd.acno and invd.total=jv.dramount*jv.id inner join gl_invmode invhead on invd.chid=invhead.idno  "
			+ " inner join gl_invm inv on (jv.tr_no=inv.tr_no) left join my_acbook ac on (inv.cldocno=ac.cldocno and"+
			" ac.dtype='CRM') left join my_brch br on jv.brhid=br.doc_no left join gl_taxdetail tax on (inv.date between tax.fromdate and
			 * 
			 */
			
			strsql="select * from(select a.date,a.branchname branch,a.refname,a.trnnumber clienttrn,a.dtype,a.vocno,a.doc_no docno,a.totalvalue,a.vatapplied, "
					+ " if(dtype in ('CNO','DNO','TCN','TDN','VSIR'),(a.totalvalue-(a.vatapplied+a.vatcollected)),(a.totalvalue-a.vatapplied-a.vatcollected)) vatnotapplied, a.vatcollected from ("+
			" select inv.date,br.branchname,ac.refname,ac.trnnumber,inv.dtype,convert(inv.voc_no,char(25)) vocno,inv.doc_no, round(sum(total),2) totalvalue,round(sum(if(if(invhead.idno in (8,38) and inv.date<'"+saliktaxdate+"' ,0,invhead.tax=1 ) and ac.tax=1 and invhead.idno<>20 and (inv.date between tax.fromdate and tax.todate), total,0)),2) vatapplied,0 vatnotapplied, round(sum(if(invhead.idno=20,total,0)),2) vatcollected  from gl_invm inv inner join gl_invd invd on inv.tr_no=invd.trno inner join gl_invmode invhead on invd.chid=invhead.idno left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on inv.brhid=br.doc_no left join gl_taxdetail tax on (inv.date between tax.fromdate and tax.todate) "+
			" where inv.status=3 and inv.dtype in ('INS','INT','INV') "+sqltesttinv+" group by inv.tr_no"+
			" union all select inv.date,br.branchname,ac.refname,ac.trnnumber,'TINV' dtype,convert(inv.voc_no,char(25)) vocno,inv.doc_no,round(coalesce(jvac.dramount,0),2) totalvalue,if(coalesce(jvtax.dramount*jvtax.id,0)!=0,coalesce(jvac.dramount,0)-coalesce(jvtax.dramount*jvtax.id,0),0)  vatapplied, if(coalesce(jvtax.dramount*jvtax.id,0)=0,coalesce(jvac.dramount,0)-coalesce(jvtax.dramount*jvtax.id,0),0) vatnotapplied,round(coalesce(jvtax.dramount*jvtax.id,0),2) vatcollected from  tr_invoicem inv left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on inv.brhid=br.doc_no left join my_jvtran jvac on jvac.acno=ac.acno and jvac.dtype='TINV' and jvac.doc_no=inv.doc_no left join gl_taxmaster tax on (inv.date between tax.fromdate and tax.todate and tax.type=2) left join my_jvtran jvtax on jvtax.acno=tax.acno  and jvtax.dtype='TINV' and jvtax.doc_no=inv.doc_no where inv.status=3  "+sqltesttinv+" union all"+
			/*" select jv.date,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(sale.voc_no,char(25)) vocno,sale.doc_no,round(sum(jv.dramount),2)*-1"+
			" totalvalue,if(ac.tax=1 and coalesce(taxjv.dramount,0.00)*-1<>0.00,sum(jv.dramount)*-1-coalesce(taxjv.dramount,0.00)*-1,0.00) "+
			" vatapplied,0 vatnotapplied,coalesce(taxjv.dramount,0)*-1 vatcollected from my_jvtran jv"+
			" left join gl_invmode invhead on jv.acno=invhead.acno left join gl_vsalem sale on (jv.tr_no=sale.trno) left join my_acbook ac on"+
			" (sale.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on jv.brhid=br.doc_no left join gl_taxdetail tax on"+
			" (sale.date between tax.fromdate and tax.todate) left join (select sum(dramount) dramount,tr_no,acno from my_jvtran where status=3 and "+
			" dtype='VSI' and date between '"+sqlfromdate+"' and '"+sqltodate+"' and id<0 group by tr_no,acno) taxjv on (taxjv.tr_no=jv.tr_no and"+
			" taxjv.acno=(select acno from gl_invmode where idno=20))where jv.status=3 and jv.dtype='VSI' "+sqltest+" and jv.id<0 group by"+
			" jv.tr_no union all"+*/  
			" select sale.date,br.branchname,ac.refname,ac.trnnumber,'VSI' dtype,convert(sale.voc_no,char(25)) vocno,sale.doc_no,"+
			" (round((VS.dramount),2)-coalesce(taxjv.dramount,0.00)) totalvalue,if(ac.tax=1 and coalesce(taxjv.dramount,0.00)*-1<>0.00,"+
			" coalesce(VS.dramount,0.00),0.00)  vatapplied,if(!(ac.tax=1 and coalesce(taxjv.dramount,0.00)*-1<>0.00),(VS.dramount),0.00)  "+
			" vatnotapplied,coalesce(taxjv.dramount,0)*-1 vatcollected from gl_vsalem sale  left join my_acbook ac on "+
			" (sale.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on SALE.brhid=br.doc_no left join gl_taxdetail tax on "+
			" (sale.date between tax.fromdate and tax.todate) left join (select SUM(SALESPRICE) dramount,RDOCNO from gl_vsaled GROUP BY RDOCNO ) "+
			" VS ON VS.RDOCNO=SALE.DOC_NO left join  (select sum(dramount) dramount,tr_no,acno from my_jvtran where status=3 and  dtype='VSI' and "+
			" date between '"+sqlfromdate+"' and '"+sqltodate+"' and id<0 group by tr_no,acno) taxjv on (taxjv.tr_no=SALE.trno and "+
			" taxjv.acno=(select acno from gl_invmode where idno=20)) where sale.status=3 and sale.date>='"+sqlfromdate+"' and sale.date<='"+sqltodate+"' "+sqltest2+""+
			" union all"+
			" select sale.date,br.branchname,ac.refname,ac.trnnumber,'VSIR' dtype,convert(sale.voc_no,char(25)) vocno,sale.doc_no, (round((VS.dramount),2)+coalesce(taxjv.dramount,0.00))*-1 totalvalue,"
			+ "if(ac.tax=1 and coalesce(taxjv.dramount,0.00)*-1<>0.00, coalesce(VS.dramount,0.00),0.00)*-1  vatapplied,if(!(ac.tax=1 and coalesce(taxjv.dramount,0.00)*-1<>0.00),(VS.dramount),0.00)*-1   vatnotapplied,"
			+ "coalesce(taxjv.dramount,0)*-1 vatcollected from gl_vsaleretm sale "
			+ "left join my_acbook ac on  (sale.cldocno=ac.cldocno and ac.dtype='CRM') "
			+ "left join my_brch br on SALE.brhid=br.doc_no "
			+ "left join gl_taxdetail tax on  (sale.date between tax.fromdate and tax.todate) "
			+ "left join (select SUM(SALESPRICE) dramount,RDOCNO from gl_vsaleretd GROUP BY RDOCNO )  VS ON VS.RDOCNO=SALE.DOC_NO "
			+ "left join  (select sum(dramount) dramount,tr_no,acno from my_jvtran where status=3 and  dtype='VSIR' and  date between '"+sqlfromdate+"' and '"+sqltodate+"' and id>0 group by tr_no,acno) taxjv "
			+ "on (taxjv.tr_no=SALE.trno and  taxjv.acno=(select acno from gl_invmode where idno=20)) where sale.status=3 and sale.date>='"+sqlfromdate+"' and sale.date<='"+sqltodate+"' "+sqltest2+""+
			" union all"+
			/*" select c.date,branchname,refname,trnnumber,jv.dtype,convert(jv.doc_no,char(25)) vocno,jv.doc_no,"+
			" round(jv.dramount,2)*-1 totalvalue,round(sum(if(ac.tax=1 and invhead.idno<>20 and invhead.tax=1 and (c.date between tax.fromdate and tax.todate),"+
			" jv.dramount,0)),2) vatapplied,0 vatnotapplied,round(coalesce(taxjv.dramount,0),2) "+
			" vatcollected from my_jvtran jv inner join my_cnot c on jv.tr_no=c.tr_no left join"+
			" gl_invmode invhead on (jv.acno=invhead.acno) left join gl_taxdetail tax on (c.date between tax.fromdate and tax.todate) "+
			" left join (select coalesce(dramount,0) dramount,tr_no,acno from my_jvtran where status=3 and dtype in ('CNO','DNO') and "+
			" date between '"+sqlfromdate+"' and '"+sqltodate+"' group by tr_no,acno) taxjv on (taxjv.tr_no=jv.tr_no and taxjv.acno=(select acno from gl_invmode where idno=20))"+
			" left join my_acbook ac on ac.acno=c.acno left join my_brch b on b.doc_no=c.brhid where jv.status=3 and jv.dtype in ('CNO','DNO')"+
			" "+sqltest+" group by jv.tr_no"*/
			
			" select c.date,branchname,refname,trnnumber,jv.dtype,convert(jv.doc_no,char(25)) vocno,jv.doc_no,"+
			" round(sum(jv.dramount),2)*-1 totalvalue,round(sum(if(ac.tax=1 and invhead.idno<>20 and invhead.tax=1 and (c.date between tax.fromdate"+
			" and tax.todate) and coalesce(taxjv.dramount,0)>0.00, jv.dramount,0)),2)*-1 vatapplied,0 vatnotapplied,round(coalesce(taxjv.dramount*-1,0),2)  vatcollected"+
			" from my_jvtran jv inner join my_cnot c on jv.tr_no=c.tr_no left join gl_invmode invhead on (jv.acno=invhead.acno) left join"+
			" gl_taxdetail tax on (c.date between tax.fromdate and tax.todate)  left join (select coalesce(sum(dramount),0) dramount,tr_no,acno"+
			" from my_jvtran where status=3 and dtype='CNO' and  date between '"+sqlfromdate+"' and '"+sqltodate+"' and id>0 group by tr_no,acno)"+
			" taxjv on (taxjv.tr_no=jv.tr_no and taxjv.acno=(select acno from gl_invmode where idno=20)) left join my_acbook ac on"+
			" ac.acno=c.acno left join my_brch b on b.doc_no=c.brhid where jv.status=3 and jv.dtype='CNO' and "+
			" jv.date>='"+sqlfromdate+"' and jv.date<='"+sqltodate+"'"+
			" "+sqltest+" and jv.id>0 group by jv.tr_no union all"+
			
			" select m.date,br.branchname,h.description,'' trnnumber,m.dtype,convert(m.doc_no,char(25)) vocno,h.doc_no,sum(if(d.nettot<0,d.nettot*-1,d.nettot)*-1)    totalvalue,"
			+ " sum(if(taxamount!=0,if(d.amount<0,d.amount*-1,d.amount)*-1,0)) vatapplied, sum(if(taxamount=0,if(d.amount<0,d.amount*-1,d.amount)*-1,0))  vatnotapplied,"
			+ "sum(coalesce(if(d.taxamount<0,d.taxamount*-1,d.taxamount)*-1,0))  vatcollected from my_cnot m left join my_cnotd d on m.tr_no=d.tr_no "
			+ "left join my_head h on h.doc_no=m.acno left join my_brch br on m.brhid=br.doc_no where m.dtype='TCN' and m.status=3 and  m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest1+" group by m.tr_no "
           /* " select c.date,branchname,refname,trnnumber,jv.dtype,convert(jv.doc_no,char(25)) vocno,jv.doc_no,"+
			" round(sum(jv.dramount),2)*-1 totalvalue,round(sum(if(ac.tax=1 and invhead.idno<>20 and invhead.tax=1 and (c.date between tax.fromdate"+
			" and tax.todate) and coalesce(taxjv.dramount,0)>0.00, jv.dramount,0)),2)*-1 vatapplied,0 vatnotapplied,round(coalesce(taxjv.dramount*-1,0),2)  vatcollected"+
			" from my_jvtran jv inner join my_cnot c on jv.tr_no=c.tr_no left join gl_invmode invhead on (jv.acno=invhead.acno) left join"+
			" gl_taxdetail tax on (c.date between tax.fromdate and tax.todate)  left join (select coalesce(sum(dramount),0) dramount,tr_no,acno"+
			" from my_jvtran where status=3 and dtype='TCN' and  date between '"+sqlfromdate+"' and '"+sqltodate+"' and id>0 group by tr_no,acno)"+
			" taxjv on (taxjv.tr_no=jv.tr_no and taxjv.acno=(select acno from gl_invmode where idno=20)) left join my_acbook ac on"+
			" ac.acno=c.acno left join my_brch b on b.doc_no=c.brhid where jv.status=3 and jv.dtype='TCN' and "+
			" jv.date>='"+sqlfromdate+"' and jv.date<='"+sqltodate+"'"+
			" "+sqltest+" and jv.id>0 group by jv.tr_no"*/
 			/*+"  union all  select a.date ,a.branchname,a.refname,a.trnnumber,a.dtype,convert(a.vocno,char(25)) vocno ,a.doc_no,a.totalvalue ,"
					+ " if(a.vatcollected>0,(a.totalvalue-a.vatcollected),0.00) vatapplied,if(a.vatcollected=0.00,a.totalvalue,(a.totalvalue-(a.totalvalue-a.vatcollected)-a.vatcollected)) vatnotapplied,a.vatcollected "
					+ " from (select m.date,br.branchname,ac.refname,ac.trnnumber,ac.cldocno,jv.brhid,convert(m.voc_no,char(25)) vndinvno ,jv.dtype,"
					+ "  convert(m.voc_no,char(25)) vocno,m.doc_no,"
					+ " round(sum(jv.dramount),2) totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno   and (m.date between tax.fromdate and tax.todate),"
					+ " jv.dramount,0)),2) vatapplied,0 vatnotapplied,round(coalesce(taxjv.dramount,0.00),2)*-1 vatcollected from my_srvsalem m inner join"
					+ " my_jvtran jv on (jv.tr_no=m.tr_no and m.acno=jv.acno)  left join my_acbook ac on (m.acno=ac.acno and ac.dtype='CRM')"
					+ "   left join my_brch br on jv.brhid=br.doc_no  left join gl_taxmaster tax on (m.date between tax.fromdate and tax.todate and tax.type=2) "
					+ " left join (select dramount,tr_no,acno from my_jvtran group by tr_no,acno) taxjv on (taxjv.tr_no=m.tr_no and taxjv.acno=tax.acno)  where m.status=3 and m.date>='"+sqlfromdate+"' "
							+ " and m.date<='"+sqltodate+"'   "+sqltest1+"  group by m.tr_no) a "*/
			+" union all select m.date,br.branchname,ac.refname,ac.trnnumber,m.dtype,convert(m.voc_no,char(100))  vocno,m.doc_no ,"+
			" coalesce(totalvalue,0) totalvalue,coalesce(vatapplied,0) vatapplied,coalesce(vatnotapplied,0) vatnotapplied, coalesce(vatcollected,0) "+
			" vatcollected from my_srvsalem  m left join (select sum(nettaxamount)   totalvalue, sum(tax) vatcollected ,"+
			" rdocno from my_srvsaled group by rdocno) d1 on d1.rdocno=m.doc_no left join (select sum(nettotal) vatapplied,rdocno from my_srvsaled"+
			" where tax>0 group by rdocno) d2 on d2.rdocno=m.doc_no left join (select sum(nettotal)   vatnotapplied,rdocno from my_srvsaled"+
			" where tax=0 group by rdocno) d3 on d3.rdocno=m.doc_no  left join my_acbook ac on ac.acno=m.acno and ac.dtype='CRM'"+
			" left join my_brch br on br.doc_no=m.brhid where  m.status=3 and m.date>='"+sqlfromdate+"' and m.date<='"+sqltodate+"' "+sqltest1+" group by m.doc_no "
			+ " union all select m.date,br.branchname,ac.refname,ac.trnnumber,m.dtype,convert(m.voc_no,char(100))  vocno,m.doc_no , coalesce(totalvalue,0)*-1 totalvalue,coalesce(vatapplied,0)*-1 vatapplied,coalesce(vatnotapplied,0)*-1 vatnotapplied, coalesce(vatcollected,0)*-1  vatcollected from my_srvsaleretm  m left join (select sum(nettaxamount)   totalvalue, sum(tax) vatcollected , rdocno from my_srvsaleretd group by rdocno) d1 on d1.rdocno=m.doc_no left join (select sum(nettotal) vatapplied,rdocno from my_srvsaleretd where tax>0 group by rdocno) d2 on d2.rdocno=m.doc_no left join (select sum(nettotal)   vatnotapplied,rdocno from my_srvsaleretd where tax=0 group by rdocno) d3 on d3.rdocno=m.doc_no  left join my_acbook ac on ac.acno=m.acno and ac.dtype='CRM' left join my_brch br on br.doc_no=m.brhid where  m.status=3 and m.date>='"+sqlfromdate+"' and m.date<='"+sqltodate+"'  group by m.doc_no "
			
 		+"  union all select m.date,br.branchname,ac.refname,ac.trnnumber,m.dtype,convert(m.voc_no,char(100))  vocno,m.doc_no ,totalvalue,vatapplied,vatnotapplied, vatcollected "
					+ " from my_invm  m left join (select sum(nettotal+taxamount)   totalvalue, sum(taxamount) vatcollected ,rdocno from my_invd group by rdocno) d1 "
					+ " on d1.rdocno=m.doc_no left join (select sum(nettotal) vatapplied,rdocno from my_invd  where taxamount>0 group by rdocno) d2 "
					+ " on d2.rdocno=m.doc_no left join (select sum(nettotal)   vatnotapplied,rdocno from my_invd where taxamount=0 group by rdocno) d3 "
					+ "	on d3.rdocno=m.doc_no  left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join my_brch br on br.doc_no=m.brhid where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+" group by m.doc_no ) a  union all"+
					" select m.date,br.branchname,ac.refname,ac.trnnumber,m.dtype,convert(m.voc_no,char(100))  vocno,m.doc_no ,totalvalue*-1 totalvalue,vatapplied*-1 vatapplied,vatnotapplied*-1 vatnotapplied, vatcollected*-1 vatcollected  "
					+ " from my_invr  m left join (select sum(nettotal+taxamount)   totalvalue,sum(taxamount) vatcollected ,rdocno from my_inrd group by rdocno) d1 "
					+ " On d1.rdocno=m.doc_no left join (select sum(nettotal)   vatapplied,rdocno from my_inrd  where taxamount>0 group by rdocno) d2 "
					+ " on d2.rdocno=m.doc_no left join (select sum(nettotal)   vatnotapplied,rdocno from my_inrd where taxamount=0 group by rdocno) d3 "
					+ " on d3.rdocno=m.doc_no left join my_invm inv on inv.doc_no=m.rrefno left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join my_brch br on br.doc_no=m.brhid where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+" "
					+ " group by m.doc_no )f order by f.date asc";

	
					/*+ " union all select m.date,b.branchname,a.refname,a.trnnumber,m.dtype,convert(m.voc_no,char(100))  vocno,m.voc_no doc_no," 
                    + "  round(m.totalamount,2) totalvalue,m.total1 vatapplied,"
 					+ "  m.total2  vatnotapplied, "
 					+ " 	  m.tax1  vatcollected from  "
					+ "( select  m.iotype, m.tr_no, m.acno,m.date, m.billtype, m.dtype, m.voc_no, m.brhid, m.invno, "
					+ "  m.totalamount, m.total1, m.total2, m.tax1,m.total3  from my_taxtran m where m.status=3 and "
					+ " m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+" and m.iotype=2 ) m left join my_acbook a on  a.acno=m.acno   " 
					+ " left   join my_brch b on b.doc_no=m.brhid "; INV and SRS showing duplicate entries in easy ease ,then taxtran query commented*/
			
			
			
			
//			 System.out.println("OUTPUT DATA INSERT------------------------------- "+strsql); 
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
	
	/*public JSONArray getVatOutputExcelData(String id,String branch,String fromdate,String todate) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="",sqltest1="",sqltest2="",sqltesttinv="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and jv.brhid="+branch;
				sqltest1+=" and m.brhid="+branch;
				sqltest2+=" and sale.brhid="+branch;
				
			}
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and jv.date>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and jv.date<='"+sqltodate+"'";
			}
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltesttinv+=" and inv.date>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){  
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltesttinv+=" and inv.date<='"+sqltodate+"'";  
			}
			strsql="select a.branchname 'Branch',date_format(a.date,'%d.%m.%Y') 'Date',a.refname 'Customer',a.trnnumber 'TRN',a.dtype 'Inv Type',a.vocno 'Invoice No',"+
			" round(a.totalvalue,2) 'Total Invoice',round(a.vatapplied,2) 'VAT 5% Sales',if(dtype in ('CNO','DNO'),"
			+ "(a.totalvalue-a.vatapplied+a.vatcollected),(a.totalvalue-a.vatapplied-a.vatcollected)) 'VAT 0% Sales',a.vatcollected 'VAT Collected' from ("+
			" select jv.date,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(inv.voc_no,char(25)) vocno,inv.doc_no,round(sum(dramount),2)*-1"+
			" totalvalue,round(sum(if(invhead.tax=1 and ac.tax=1 and invhead.idno<>20 and (inv.date between tax.fromdate and tax.todate),"+
			" dramount,0)),2)*-1 vatapplied,0 vatnotapplied,round(sum(if(invhead.idno=20,dramount,0)),2)*-1 vatcollected "
			+ " from my_jvtran jv inner join gl_invmode invhead on"+
			" jv.acno=invhead.acno inner join gl_invm inv on (jv.tr_no=inv.tr_no) left join my_acbook ac on (inv.cldocno=ac.cldocno and"+
			" ac.dtype='CRM') left join my_brch br on jv.brhid=br.doc_no left join gl_taxdetail tax on (inv.date between tax.fromdate and"+
			" tax.todate) where jv.status=3 and jv.dtype in ('INS','INT','INV') "+sqltest+" and jv.id<0 group by jv.tr_no"+
			" union all"+
			" select jv.date,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(sale.voc_no,char(25)) vocno,sale.doc_no,round(sum(dramount),2)*-1"+
			" totalvalue,round(sum(if(ac.tax=1 and invhead.idno<>20 and (sale.date between tax.fromdate and tax.todate),"+
			" dramount,0)),2)*-1 vatapplied,0 vatnotapplied,round(sum(if(invhead.idno=20,dramount,0)),2)*-1 vatcollected from my_jvtran jv"+
			" left join gl_invmode invhead on jv.acno=invhead.acno left join gl_vsalem sale on (jv.tr_no=sale.trno) left join my_acbook ac on"+
			" (sale.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on jv.brhid=br.doc_no left join gl_taxdetail tax on"+
			" (sale.date between tax.fromdate and tax.todate) where jv.status=3 and jv.dtype='VSI' "+sqltest+" and jv.id<0 group by"+
			" jv.tr_no union all"+
			" select c.date,branchname,refname,trnnumber,jv.dtype,convert(jv.doc_no,char(25)) vocno,jv.doc_no,"+
			" round(jv.dramount,2)*-1 totalvalue,round(sum(if(ac.tax=1 and invhead.idno<>20 and (c.date between tax.fromdate and tax.todate),"+
			" dramount,0)),2) vatapplied,0 vatnotapplied,round(sum(if(invhead.idno=20,dramount,0)),2)*-1 "+
			" vatcollected from my_jvtran jv inner join my_cnot c on jv.tr_no=c.tr_no left join"+
			" gl_invmode invhead on (jv.acno=invhead.acno) left join gl_taxdetail tax on (c.date between tax.fromdate and tax.todate)"+
			" left join my_acbook ac on ac.acno=c.acno left join my_brch b on b.doc_no=c.brhid where jv.status=3 and jv.dtype in ('CNO','DNO')"+
			" "+sqltest+" group by jv.tr_no"

 +"  union all  select a.date ,a.branchname,a.refname,a.trnnumber,a.dtype,convert(a.vocno,char(25)) vocno ,a.doc_no,a.totalvalue ,"
	+ " (a.totalvalue-a.vatcollected) vatapplied,(a.totalvalue-(a.totalvalue-a.vatcollected)-a.vatcollected) vatnotapplied,a.vatcollected "
	+ " from (select m.date,br.branchname,ac.refname,ac.trnnumber,ac.cldocno,jv.brhid,convert(m.voc_no,char(25)) vndinvno ,jv.dtype,"
	+ "  convert(m.voc_no,char(25)) vocno,m.doc_no,"
	+ " round(sum(jv.dramount),2) totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno   and (m.date between tax.fromdate and tax.todate),"
	+ " jv.dramount,0)),2) vatapplied,0 vatnotapplied,round(sum(coalesce(jv1.dramount,0)),2)*-1 vatcollected from my_srvsalem m inner join"
	+ " my_jvtran jv on (jv.tr_no=m.tr_no and m.acno=jv.acno)  left join my_acbook ac on (m.acno=ac.acno and ac.dtype='CRM')"
	+ "   left join my_brch br on jv.brhid=br.doc_no  left join gl_taxmaster tax on (m.date between tax.fromdate and tax.todate and tax.type=2) "
	+ " left join my_jvtran jv1 on (jv1.tr_no=m.tr_no and tax.acno=jv1.acno) where m.status=3 and m.date>='"+sqlfromdate+"' "
			+ " and m.date<='"+sqltodate+"'   "+sqltest1+"  group by m.tr_no) a "

			
 +"  union all select m.date,br.branchname,ac.refname,ac.trnnumber,m.dtype,convert(m.voc_no,char(100)) vocno,m.doc_no ,totalvalue,vatapplied,vatnotapplied, vatcollected "
					+ " from my_invm  m left join (select sum(nettotal+taxamount)   totalvalue, sum(taxamount) vatcollected ,rdocno from my_invd group by rdocno) d1 "
					+ " on d1.rdocno=m.doc_no left join (select sum(nettotal) vatapplied,rdocno from my_invd  where taxamount>0 group by rdocno) d2 "
					+ " on d2.rdocno=m.doc_no left join (select sum(nettotal)   vatnotapplied,rdocno from my_invd where taxamount=0 group by rdocno) d3 "
					+ "	on d3.rdocno=m.doc_no  left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join my_brch br on br.doc_no=m.brhid where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+" group by m.doc_no "
					+ " union all select m.date,br.branchname,ac.refname,ac.trnnumber,m.dtype,convert(m.voc_no,char(100))  vocno,m.doc_no ,totalvalue,vatapplied,vatnotapplied, vatcollected  "
					+ " from my_invr  m left join (select sum(nettotal+taxamount)   totalvalue,sum(taxamount) vatcollected ,rdocno from my_inrd group by rdocno) d1 "
					+ " On d1.rdocno=m.doc_no left join (select sum(nettotal)   vatapplied,rdocno from my_inrd  where taxamount>0 group by rdocno) d2 "
					+ " on d2.rdocno=m.doc_no left join (select sum(nettotal)   vatnotapplied,rdocno from my_inrd where taxamount=0 group by rdocno) d3 "
					+ " on d3.rdocno=m.doc_no left join my_invm inv on inv.doc_no=m.rrefno left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join my_brch br on br.doc_no=m.brhid where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+" "
					+ " group by m.doc_no ) a";
			
			
			select a.branchname 'Branch',date_format(a.date,'%d.%m.%Y') 'Date',a.refname 'Customer',a.trnnumber 'TRN',a.dtype 'Inv Type',a.vocno 'Invoice No',"+
			" round(a.totalvalue,2) 'Total Invoice',round(a.vatapplied,2) 'VAT 5% Sales',if(dtype in ('CNO','DNO'),"
			+ "(a.totalvalue-a.vatapplied+a.vatcollected),(a.totalvalue-a.vatapplied-a.vatcollected)) 'VAT 0% Sales',a.vatcollected 'VAT Collected'"
			
			strsql="select * from (select a.branchname 'Branch',date_format(a.date,'%d.%m.%Y') 'Date',a.refname 'Customer',a.trnnumber 'TRN',a.dtype 'Inv Type',a.vocno 'Invoice No',round(a.totalvalue,2) 'Total Invoice',round(a.vatapplied,2) 'VAT 5% Sales', "
					+ " if(dtype in ('CNO','DNO','TCN','TDN'),(a.totalvalue-(a.vatapplied+a.vatcollected)),(a.totalvalue-a.vatapplied-a.vatcollected)) 'VAT 0% Sales', round(a.vatcollected,2) 'VAT Collected' from ("+
			" select jv.date,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(inv.voc_no,char(25)) vocno,inv.doc_no,round(sum(dramount),2)*-1"+
			" totalvalue,round(sum(if(invhead.tax=1 and ac.tax=1 and invhead.idno<>20 and (inv.date between tax.fromdate and tax.todate),"+
			" dramount,0)),2)*-1 vatapplied,0 vatnotapplied,round(sum(if(invhead.idno=20,dramount,0)),2)*-1 vatcollected "
			+ " from my_jvtran jv inner join gl_invmode invhead on"+
			" jv.acno=invhead.acno inner join gl_invm inv on (jv.tr_no=inv.tr_no) left join my_acbook ac on (inv.cldocno=ac.cldocno and"+
			" ac.dtype='CRM') left join my_brch br on jv.brhid=br.doc_no left join gl_taxdetail tax on (inv.date between tax.fromdate and"+
			" tax.todate) where jv.status=3 and jv.dtype in ('INS','INT','INV') "+sqltest+" and jv.id<0 group by jv.tr_no"+
			" union all select inv.date,br.branchname,ac.refname,ac.trnnumber,'TINV' dtype,convert(inv.voc_no,char(25)) vocno,inv.doc_no,round(coalesce(jvac.dramount,0),2) totalvalue,if(coalesce(jvtax.dramount*jvtax.id,0)!=0,coalesce(jvac.dramount,0)-coalesce(jvtax.dramount*jvtax.id,0),0)  vatapplied, if(coalesce(jvtax.dramount*jvtax.id,0)=0,coalesce(jvac.dramount,0)-coalesce(jvtax.dramount*jvtax.id,0),0) vatnotapplied,round(coalesce(jvtax.dramount*jvtax.id,0),2) vatcollected from  tr_invoicem inv left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on inv.brhid=br.doc_no left join my_jvtran jvac on jvac.acno=ac.acno and jvac.dtype='TINV' and jvac.doc_no=inv.doc_no left join gl_taxmaster tax on (inv.date between tax.fromdate and tax.todate and tax.type=2) left join my_jvtran jvtax on jvtax.acno=tax.acno  and jvtax.dtype='TINV' and jvtax.doc_no=inv.doc_no where inv.status=3  "+sqltesttinv+" union all"+
			" select jv.date,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(sale.voc_no,char(25)) vocno,sale.doc_no,round(sum(jv.dramount),2)*-1"+
			" totalvalue,if(ac.tax=1 and coalesce(taxjv.dramount,0.00)*-1<>0.00,sum(jv.dramount)*-1-coalesce(taxjv.dramount,0.00)*-1,0.00) "+
			" vatapplied,0 vatnotapplied,coalesce(taxjv.dramount,0)*-1 vatcollected from my_jvtran jv"+
			" left join gl_invmode invhead on jv.acno=invhead.acno left join gl_vsalem sale on (jv.tr_no=sale.trno) left join my_acbook ac on"+
			" (sale.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on jv.brhid=br.doc_no left join gl_taxdetail tax on"+
			" (sale.date between tax.fromdate and tax.todate) left join (select sum(dramount) dramount,tr_no,acno from my_jvtran where status=3 and "+
			" dtype='VSI' and date between '"+sqlfromdate+"' and '"+sqltodate+"' and id<0 group by tr_no,acno) taxjv on (taxjv.tr_no=jv.tr_no and"+
			" taxjv.acno=(select acno from gl_invmode where idno=20))where jv.status=3 and jv.dtype='VSI' "+sqltest+" and jv.id<0 group by"+
			" jv.tr_no union all"+
			" select sale.date,br.branchname,ac.refname,ac.trnnumber,'VSI' dtype,convert(sale.voc_no,char(25)) vocno,sale.doc_no,"+
			" (round((VS.dramount),2)-coalesce(taxjv.dramount,0.00)) totalvalue,if(ac.tax=1 and coalesce(taxjv.dramount,0.00)*-1<>0.00,"+
			" coalesce(VS.dramount,0.00),0.00)  vatapplied,if(!(ac.tax=1 and coalesce(taxjv.dramount,0.00)*-1<>0.00),(VS.dramount),0.00)  "+
			" vatnotapplied,coalesce(taxjv.dramount,0)*-1 vatcollected from gl_vsalem sale  left join my_acbook ac on "+
			" (sale.cldocno=ac.cldocno and ac.dtype='CRM') left join my_brch br on SALE.brhid=br.doc_no left join gl_taxdetail tax on "+
			" (sale.date between tax.fromdate and tax.todate) left join (select SUM(SALESPRICE) dramount,RDOCNO from gl_vsaled GROUP BY RDOCNO ) "+
			" VS ON VS.RDOCNO=SALE.DOC_NO left join  (select sum(dramount) dramount,tr_no,acno from my_jvtran where status=3 and  dtype='VSI' and "+
			" date between '"+sqlfromdate+"' and '"+sqltodate+"' and id<0 group by tr_no,acno) taxjv on (taxjv.tr_no=SALE.trno and "+
			" taxjv.acno=(select acno from gl_invmode where idno=20)) where sale.status=3 and sale.date>='"+sqlfromdate+"' and sale.date<='"+sqltodate+"' "+sqltest2+" "+
			" union all"+
			" select sale.date,br.branchname,ac.refname,ac.trnnumber,'VSIR' dtype,convert(sale.voc_no,char(25)) vocno,sale.doc_no, (round((VS.dramount),2)-coalesce(taxjv.dramount,0.00))*-1 totalvalue,"
			+ "if(ac.tax=1 and coalesce(taxjv.dramount,0.00)*-1<>0.00, coalesce(VS.dramount,0.00),0.00)*-1  vatapplied,if(!(ac.tax=1 and coalesce(taxjv.dramount,0.00)*-1<>0.00),(VS.dramount),0.00)*-1   vatnotapplied,"
			+ "coalesce(taxjv.dramount,0)*-1 vatcollected from gl_vsaleretm sale "
			+ "left join my_acbook ac on  (sale.cldocno=ac.cldocno and ac.dtype='CRM') "
			+ "left join my_brch br on SALE.brhid=br.doc_no "
			+ "left join gl_taxdetail tax on  (sale.date between tax.fromdate and tax.todate) "
			+ "left join (select SUM(SALESPRICE) dramount,RDOCNO from gl_vsaleretd GROUP BY RDOCNO )  VS ON VS.RDOCNO=SALE.DOC_NO "
			+ "left join  (select sum(dramount) dramount,tr_no,acno from my_jvtran where status=3 and  dtype='VSIR' and  date between '"+sqlfromdate+"' and '"+sqltodate+"' and id>0 group by tr_no,acno) taxjv "
			+ "on (taxjv.tr_no=SALE.trno and  taxjv.acno=(select acno from gl_invmode where idno=20)) where sale.status=3 and sale.date>='"+sqlfromdate+"' and sale.date<='"+sqltodate+"' "+sqltest2+""+
			" union all"+
			" select c.date,branchname,refname,trnnumber,jv.dtype,convert(jv.doc_no,char(25)) vocno,jv.doc_no,"+
			" round(jv.dramount,2)*-1 totalvalue,round(sum(if(ac.tax=1 and invhead.idno<>20 and invhead.tax=1 and (c.date between tax.fromdate and tax.todate),"+
			" jv.dramount,0)),2) vatapplied,0 vatnotapplied,round(coalesce(taxjv.dramount,0),2) "+
			" vatcollected from my_jvtran jv inner join my_cnot c on jv.tr_no=c.tr_no left join"+
			" gl_invmode invhead on (jv.acno=invhead.acno) left join gl_taxdetail tax on (c.date between tax.fromdate and tax.todate) "+
			" left join (select coalesce(dramount,0) dramount,tr_no,acno from my_jvtran where status=3 and dtype in ('CNO','DNO') and "+
			" date between '"+sqlfromdate+"' and '"+sqltodate+"' group by tr_no,acno) taxjv on (taxjv.tr_no=jv.tr_no and taxjv.acno=(select acno from gl_invmode where idno=20))"+
			" left join my_acbook ac on ac.acno=c.acno left join my_brch b on b.doc_no=c.brhid where jv.status=3 and jv.dtype in ('CNO','DNO')"+
			" "+sqltest+" group by jv.tr_no"
				



" select c.date,branchname,refname,trnnumber,jv.dtype,convert(jv.doc_no,char(25)) vocno,jv.doc_no,"+
" round(sum(jv.dramount),2)*-1 totalvalue,round(sum(if(ac.tax=1 and invhead.idno<>20 and invhead.tax=1 and (c.date between tax.fromdate"+
" and tax.todate) and coalesce(taxjv.dramount,0)>0.00, jv.dramount,0)),2)*-1 vatapplied,0 vatnotapplied,round(coalesce(taxjv.dramount * -1 ,0),2)  vatcollected"+
" from my_jvtran jv inner join my_cnot c on jv.tr_no=c.tr_no left join gl_invmode invhead on (jv.acno=invhead.acno) left join"+
" gl_taxdetail tax on (c.date between tax.fromdate and tax.todate)  left join (select coalesce(sum(dramount),0) dramount,tr_no,acno"+
" from my_jvtran where status=3 and dtype='CNO' and  date between '"+sqlfromdate+"' and '"+sqltodate+"' and id>0 group by tr_no,acno)"+
" taxjv on (taxjv.tr_no=jv.tr_no and taxjv.acno=(select acno from gl_invmode where idno=20)) left join my_acbook ac on"+
" ac.acno=c.acno left join my_brch b on b.doc_no=c.brhid where jv.status=3 and jv.dtype='CNO' and "+
" jv.date>='"+sqlfromdate+"' and jv.date<='"+sqltodate+"' "+sqltest+" "+
" "+sqltest+" and jv.id>0 group by jv.tr_no union all"+

" select m.date,br.branchname,h.description,'' trnnumber,m.dtype,convert(m.doc_no,char(25)) vocno,h.doc_no,sum(if(d.nettot<0,d.nettot*-1,d.nettot)*-1)    totalvalue,"
+ " sum(if(taxamount!=0,if(d.amount<0,d.amount*-1,d.amount)*-1,0)) vatapplied, sum(if(taxamount=0,if(d.amount<0,d.amount*-1,d.amount)*-1,0))  vatnotapplied,"
+ "sum(coalesce(if(d.taxamount<0,d.taxamount*-1,d.taxamount)*-1,0))  vatcollected from my_cnot m left join my_cnotd d on m.tr_no=d.tr_no "
+ "left join my_head h on h.doc_no=m.acno left join my_brch br on m.brhid=br.doc_no where m.dtype='TCN' and m.status=3 and  m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest1+" group by m.tr_no "
 			+"  union all  select a.date ,a.branchname,a.refname,a.trnnumber,a.dtype,convert(a.vocno,char(25)) vocno ,a.doc_no,a.totalvalue ,"
					+ " if(a.vatcollected>0,(a.totalvalue-a.vatcollected),0.00) vatapplied,if(a.vatcollected=0.00,a.totalvalue,(a.totalvalue-(a.totalvalue-a.vatcollected)-a.vatcollected)) vatnotapplied,a.vatcollected "
					+ " from (select m.date,br.branchname,ac.refname,ac.trnnumber,ac.cldocno,jv.brhid,convert(m.voc_no,char(25)) vndinvno ,jv.dtype,"
					+ "  convert(m.voc_no,char(25)) vocno,m.doc_no,"
					+ " round(sum(jv.dramount),2) totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno   and (m.date between tax.fromdate and tax.todate),"
					+ " jv.dramount,0)),2) vatapplied,0 vatnotapplied,round(coalesce(taxjv.dramount,0.00),2)*-1 vatcollected from my_srvsalem m inner join"
					+ " my_jvtran jv on (jv.tr_no=m.tr_no and m.acno=jv.acno)  left join my_acbook ac on (m.acno=ac.acno and ac.dtype='CRM')"
					+ "   left join my_brch br on jv.brhid=br.doc_no  left join gl_taxmaster tax on (m.date between tax.fromdate and tax.todate and tax.type=2) "
					+ " left join (select dramount,tr_no,acno from my_jvtran group by tr_no,acno) taxjv on (taxjv.tr_no=m.tr_no and taxjv.acno=tax.acno) where m.status=3 and m.date>='"+sqlfromdate+"' "
							+ " and m.date<='"+sqltodate+"'   "+sqltest1+"  group by m.tr_no) a "
	+" union all select m.date,br.branchname,ac.refname,ac.trnnumber,m.dtype,convert(m.voc_no,char(100))  vocno,m.doc_no ,"+
			" coalesce(totalvalue,0) totalvalue,coalesce(vatapplied,0) vatapplied,coalesce(vatnotapplied,0) vatnotapplied, coalesce(vatcollected,0) "+
			" vatcollected from my_srvsalem  m left join (select sum(nettaxamount)   totalvalue, sum(tax) vatcollected ,"+
			" rdocno from my_srvsaled group by rdocno) d1 on d1.rdocno=m.doc_no left join (select sum(nettotal) vatapplied,rdocno from my_srvsaled"+
			" where tax>0 group by rdocno) d2 on d2.rdocno=m.doc_no left join (select sum(nettotal)   vatnotapplied,rdocno from my_srvsaled"+
			" where tax=0 group by rdocno) d3 on d3.rdocno=m.doc_no  left join my_acbook ac on ac.acno=m.acno and ac.dtype='CRM'"+
			" left join my_brch br on br.doc_no=m.brhid where  m.status=3 and m.date>='"+sqlfromdate+"' and m.date<='"+sqltodate+"' "+sqltest1+" group by m.doc_no "
		  + " union all select m.date,br.branchname,ac.refname,ac.trnnumber,m.dtype,convert(m.voc_no,char(100))  vocno,m.doc_no , coalesce(totalvalue,0)*-1 totalvalue,coalesce(vatapplied,0)*-1 vatapplied,coalesce(vatnotapplied,0)*-1 vatnotapplied, coalesce(vatcollected,0)*-1  vatcollected from my_srvsaleretm  m left join (select sum(nettaxamount)   totalvalue, sum(tax) vatcollected , rdocno from my_srvsaleretd group by rdocno) d1 on d1.rdocno=m.doc_no left join (select sum(nettotal) vatapplied,rdocno from my_srvsaleretd where tax>0 group by rdocno) d2 on d2.rdocno=m.doc_no left join (select sum(nettotal)   vatnotapplied,rdocno from my_srvsaleretd where tax=0 group by rdocno) d3 on d3.rdocno=m.doc_no  left join my_acbook ac on ac.acno=m.acno and ac.dtype='CRM' left join my_brch br on br.doc_no=m.brhid where  m.status=3 and m.date>='"+sqlfromdate+"' and m.date<='"+sqltodate+"' "+sqltest1+" group by m.doc_no"
			
			
 		+"  union all select m.date,br.branchname,ac.refname,ac.trnnumber,m.dtype,convert(m.voc_no,char(100))  vocno,m.doc_no ,totalvalue,vatapplied,vatnotapplied, vatcollected "
					+ " from my_invm  m left join (select sum(nettotal+taxamount)   totalvalue, sum(taxamount) vatcollected ,rdocno from my_invd group by rdocno) d1 "
					+ " on d1.rdocno=m.doc_no left join (select sum(nettotal) vatapplied,rdocno from my_invd  where taxamount>0 group by rdocno) d2 "
					+ " on d2.rdocno=m.doc_no left join (select sum(nettotal)   vatnotapplied,rdocno from my_invd where taxamount=0 group by rdocno) d3 "
					+ "	on d3.rdocno=m.doc_no  left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join my_brch br on br.doc_no=m.brhid where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+" group by m.doc_no ) a union all"+
					" select br.branchname 'Branch',date_format(m.date,'%d.%m.%Y') 'Date',ac.refname 'Customer',ac.trnnumber 'TRN',m.dtype 'Inv Type',convert(m.voc_no,char(100))  'Invoice No',round(totalvalue*-1,2) 'Total Invoice',round(vatapplied*-1,2) "
					+ "  'VAT 5% Sales',round(vatnotapplied*-1,2) 'VAT 0% Sales', round(vatcollected*-1,2) 'VAT Collected'  "
					+ " from my_invr  m left join (select sum(nettotal+taxamount)   totalvalue,sum(taxamount) vatcollected ,rdocno from my_inrd group by rdocno) d1 "
					+ " On d1.rdocno=m.doc_no left join (select sum(nettotal)   vatapplied,rdocno from my_inrd  where taxamount>0 group by rdocno) d2 "
					+ " on d2.rdocno=m.doc_no left join (select sum(nettotal)   vatnotapplied,rdocno from my_inrd where taxamount=0 group by rdocno) d3 "
					+ " on d3.rdocno=m.doc_no left join my_invm inv on inv.doc_no=m.rrefno left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join my_brch br on br.doc_no=m.brhid where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+" "
					+ " group by m.doc_no" 
					
					
					

					+" union all select br.branchname,date_format(m.date,'%d.%m.%Y') date,ac.refname,ac.trnnumber,'CPU' dtype,"
					+" convert(m.voc_no,char(25)) vocno,sum(d.nettotal+d.taxamount)  totalvalue,aa.app vatapplied,"
					+" (sum(d.nettotal+d.taxamount))-aa.app-coalesce(aa.collect,0) vatnotapplied,"
					+" coalesce(aa.collect,0)  vatcollected from my_srvpurm m left join (select   sum(nettotal) app,sum(taxamount) collect,rdocno"
					+" from my_srvpurd where taxamount>0 group by rdocno) aa on aa.rdocno=m.doc_no left join (select   sum(nettotal) notapp,rdocno"
					+" from my_srvpurd where taxamount=0 group by rdocno) bb on bb.rdocno=m.doc_no left join my_srvpurd d on d.rdocno=m.doc_no"
					+" left join my_acbook ac on (m.acno=ac.acno and ac.dtype='VND') left join my_brch br on m.brhid=br.doc_no"
					+" left join my_jvtran jcp on jcp.tr_no=m.tr_no left join gl_taxmaster tcp on tcp.acno=jcp.acno"
					+" where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+" and tcp.type=2   group by m.tr_no " 

			 
            + " union all select br.branchname,date_format(m.date,'%d.%m.%Y') date,ac.refname,ac.trnnumber,'CPR' dtype,"
					+" convert(m.voc_no,char(25)) vocno,sum(d.nettotal+d.taxamount)*-1  totalvalue,aa.app *-1 vatapplied,"
					+" ((sum(d.nettotal+d.taxamount))-aa.app-coalesce(aa.collect,0))*-1 vatnotapplied,"
					+" coalesce(aa.collect,0)*-1  vatcollected from my_srvpurretm m left join (select   sum(nettotal) app,sum(taxamount) collect,rdocno from my_srvpurretd where taxamount>0 group by rdocno) aa on aa.rdocno=m.doc_no left join (select   sum(nettotal) notapp,rdocno from my_srvpurretd where taxamount=0 group by rdocno) bb on bb.rdocno=m.doc_no left join my_srvpurretd d on d.rdocno=m.doc_no left join my_acbook ac on (m.acno=ac.acno and ac.dtype='VND') left join my_brch br on m.brhid=br.doc_no "
            + "  where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+"    group by m.tr_no)f order by f.date asc";

				
					
					
					+ " union all select b.branchname 'Branch',date_format(m.date,'%d.%m.%Y') 'Date',a.refname 'Customer',a.trnnumber 'TRN',m.dtype 'Inv Type',convert(m.voc_no,char(100))  'Invoice No'," 
                    + "  round(m.totalamount,2) 'Total Invoice',convert(if(m.total1=0,'',round(m.total1,2)),char(100)) 'VAT 5% Sales',"
 					+ " convert(if(m.total2=0,'',round(m.total2,2)),char(100)) 'VAT 0% Sales', "
 					+ " 	  convert(if(m.tax1=0,'',round(m.tax1,2)),char(100)) 'VAT Collected' from  "
					+ "( select  m.iotype, m.tr_no, m.acno,m.date, m.billtype, m.dtype, m.voc_no, m.brhid, m.invno, "
					+ "  m.totalamount, m.total1, m.total2, m.tax1,m.total3  from my_taxtran m where m.status=3 and "
					+ " m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+" and m.iotype=2 ) m left join my_acbook a on  a.acno=m.acno   " 
					+ " left   join my_brch b on b.doc_no=m.brhid "; INV and SRS showing duplicate in easy lease then taxtran commented from query
			
			//System.out.println("output excel data --------------------------"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToEXCEL(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	*/
	public JSONArray getVatInputData(String id,String branch,String fromdate,String todate) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}       
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="",sqltest1="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			//System.out.println("branch========="+branch);
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and jv.brhid="+branch;
				
				sqltest1+=" and m.brhid="+branch;
			}
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				/*sqltest+=" and jv.date>='"+sqlfromdate+"'";*/
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				/*sqltest+=" and jv.date<='"+sqltodate+"'";*/
			}
			/*strsql="select a.date,a.branchname branch,a.refname,a.trnnumber clienttrn,a.dtype,a.voc_no,a.doc_no docno,a.totalvalue,a.vatapplied,(a.totalvalue-a.vatapplied-a.vatcollected) vatnotapplied,"+
			" a.vatcollected from ("+
			" select br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) voc_no,m.doc_no,jv.date,round(sum(dramount),2)"+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate),"+
			" dramount,0)),2) vatapplied,0 vatnotapplied,round(sum(if(jv.acno=tax.acno,dramount,0)),2) vatcollected from my_jvtran jv"+
			" left join my_srvpurm m on (jv.tr_no=m.tr_no) left join my_acbook ac on"+
			" (m.acno=ac.acno and ac.dtype='VND') left join my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on"+
			" (m.date between tax.fromdate and tax.todate) where jv.dtype='CPU' "+sqltest+" and jv.id>0 group by jv.tr_no"+
			" union all"+
			" select br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) voc_no,m.doc_no,jv.date,round(sum(dramount),2)"+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate),"+
			" dramount,0)),2) vatapplied,0 vatnotapplied,round(sum(if(jv.acno=tax.acno,dramount,0)),2) vatcollected from my_jvtran jv"+
			" left join gl_vpurm m on (jv.tr_no=m.tr_no) left join my_acbook ac on"+
			" (m.venid=ac.acno and ac.dtype='VND') left join my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on"+
			" (m.date between tax.fromdate and tax.todate) where jv.dtype='VPU' "+sqltest+" and jv.id>0 group by jv.tr_no"+
			" union all"+
			" select br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) voc_noo,m.doc_no,jv.date,round(sum(dramount),2)"+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate),"+
			" dramount,0)),2) vatapplied,0 vatnotapplied,round(sum(if(jv.acno=tax.acno,dramount,0)),2) vatcollected from my_jvtran jv"+
			" left join gl_vpurdirm m on (jv.tr_no=m.tr_no) left join my_acbook ac on"+
			" (m.venid=ac.acno and ac.dtype='VND') left join my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on"+
			" (m.date between tax.fromdate and tax.todate) where jv.dtype='VPD' "+sqltest+" and jv.id>0 group by jv.tr_no"+
			" union all"+
			" select br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) voc_no,m.doc_no,jv.date,round(sum(dramount),2)"+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate),"+
			" dramount,0)),2) vatapplied,0 vatnotapplied,round(sum(if(jv.acno=tax.acno,dramount,0)),2) vatcollected from my_jvtran jv"+
			" left join gl_vmcostm m on (jv.tr_no=m.trno) left join my_acbook ac on"+
			" (m.gargid=ac.cldocno and ac.dtype='VND') left join my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on"+
			" (m.date between tax.fromdate and tax.todate) where jv.dtype='MRU' "+sqltest+" and jv.id>0 group by jv.tr_no"+
			" union all"+
			" select br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) voc_no,m.doc_no,jv.date,round(sum(dramount),2)"+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate),"+
			" dramount,0)),2) vatapplied,0 vatnotapplied,round(sum(if(jv.acno=tax.acno,dramount,0)),2) vatcollected from my_jvtran jv"+
			" left join gl_vmcostm m on (jv.tr_no=m.trno) left join my_acbook ac on"+
			" (m.gargid=ac.cldocno and ac.dtype='VND') left join my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on"+
			" (m.date between tax.fromdate and tax.todate) where jv.dtype='MWO' "+sqltest+" and jv.id>0 group by jv.tr_no ) a";*/
			
				
			
			
			strsql="select * from(select coalesce(a.vndinvno,'') vndinvno,a.date,a.branchname branch,a.refname,a.trnnumber clienttrn,a.dtype,a.vocno,a.doc_no docno,a.totalvalue,"+
			" if(a.vatcollected<>0,(a.totalvalue-a.vatcollected),0) vatapplied,(a.totalvalue-if(a.vatcollected<>0,(a.totalvalue-a.vatcollected),0)-a.vatcollected) vatnotapplied, if(dtype in ('pir','CPR'),vatcollected*-1,a.vatcollected) vatcollected "+
			" from ("+
			/*" select convert(m.invno,char(25)) vndinvno,m.date,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) vocno,m.doc_no,round(sum(jv.dramount),2)*-1 "+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and m.type=1 and (m.date between tax.fromdate and tax.todate), "+
			" jv.dramount,0)),2)*-1 vatapplied,0 vatnotapplied,round(sum(coalesce(jv1.dramount,0)),2) vatcollected from my_srvpurm m inner join "+
			" my_jvtran jv on (jv.tr_no=m.tr_no and m.acno=jv.acno) left join my_acbook ac on (m.acno=ac.acno and ac.dtype='VND') left join "+
			" my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on (m.date between tax.fromdate and tax.todate and tax.type=1) "+
			" left join my_jvtran jv1 on (jv1.tr_no=m.tr_no and tax.acno=jv1.acno) where m.status=3 and m.date>='"+sqlfromdate+"' and "+
			" m.date<='"+sqltodate+"' "+sqltest+" group by m.tr_no union all"+*/
			
			" select convert(m.purno,char(25)) vndinvno,m.date,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) vocno,m.doc_no,round((jv.dramount),2)*-1 "+
			" totalvalue,round((if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate), jv.dramount,0)),2)*-1 "+
			" vatapplied,0 vatnotapplied, round((coalesce(jv1.dramount,0)),2) vatcollected from gl_vpurm m inner join my_jvtran jv on "+
			" (jv.tr_no=m.tr_no and m.venid=jv.acno  and dramount<0) left join my_acbook ac on (m.venid=ac.acno and ac.dtype='VND')"+
			" left join my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on (m.date between tax.fromdate and tax.todate and "+
			" tax.type=1 and per>0) left join my_jvtran jv1 on (jv1.tr_no=m.tr_no and tax.acno=jv1.acno) where jv.status=3 and "+
			" jv.date>='"+sqlfromdate+"' and jv.date<='"+sqltodate+"' and m.tr_no is not null "+sqltest+" group by m.tr_no union all"+
			" select convert(m.invno,char(25)) vndinvno,m.date,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) vocno,m.doc_no,round(sum(jv.dramount),2)*-1 "+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate), jv.dramount,0)),2)*-1 "+
			" vatapplied,0 vatnotapplied, round(sum(coalesce(jv1.dramount,0)),2) vatcollected from gl_vpurdirm m inner join my_jvtran jv on "+
			" (jv.tr_no=m.tr_no and m.venid=jv.acno  and dramount<0) left join my_acbook ac on (m.venid=ac.acno and ac.dtype='VND') left join "+
			" my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on (m.date between tax.fromdate and tax.todate and tax.type=1 and per>0)"+
			" left join my_jvtran jv1 on (jv1.tr_no=m.tr_no and tax.acno=jv1.acno) where m.status=3 and m.date>='"+sqlfromdate+"' and "+
			" m.date<='"+sqltodate+"' and m.tr_no is not null "+sqltest+" group by m.tr_no union all"+

		
			" select convert(m.invno,char(25)) vndinvno,m.postdate,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) vocno,m.doc_no,round(sum(jv.dramount),2)*-1 "+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate), jv.dramount,0)),2)*-1 "+
			" vatapplied,0 vatnotapplied, round(sum(coalesce(jv1.dramount,0)),2) vatcollected from gl_vmcostm m inner join gl_garrage g on "+
			" m.gargid=g.doc_no inner join my_jvtran jv on (jv.tr_no=m.trno and jv.acno=g.acc_no  and dramount<0 and jv.status=3) left join my_acbook ac on "+
			" (ac.acno=g.acc_no and ac.dtype='VND') left join my_brch br on  jv.brhid=br.doc_no left join gl_taxmaster tax on (m.postdate between "+
			" tax.fromdate and tax.todate and tax.type=1 and per>0) left join my_jvtran jv1 on (jv1.tr_no=m.trno and tax.acno=jv1.acno) where "+
			" m.status=3 and m.postdate>='"+sqlfromdate+"' and m.postdate<='"+sqltodate+"' and m.trno is not null "+sqltest+" group by m.trno "+
			
			"  union all "+
			" select jv.refno invno,jv.date,branchname,refname,trnnumber,jv.dtype,convert(jv.doc_no,char(25)) vocno,jv.doc_no, "
			+ " round(sum(c.amt+(coalesce(taxjv.dramount,0))),2) totalvalue, round((if( coalesce(taxjv.dramount,0)!=0.00,c.amt,0)),2) vatapplied, 0 vatnotapplied, round(coalesce(taxjv.dramount,0),2)  vatcollected "+
			" from my_cnot jv inner join (select sum(amount) amt,tr_no from my_cnotd c "
			+ " where c.acno not in (select acno from gl_taxmaster where type=2 and per>0 and status=3) group by tr_no) c on jv.tr_no=c.tr_no left join"+
			" gl_taxmaster tax on (jv.date between tax.fromdate and tax.todate  and tax.type=2)  left join (select coalesce(sum(dramount),0) dramount,tr_no,acno"+
			" from my_jvtran where status=3 and dtype='DNO' and  date between '"+sqlfromdate+"' and '"+sqltodate+"' and id<0 group by tr_no,acno)"+
			" taxjv on (taxjv.tr_no=jv.tr_no and taxjv.acno=(select acno from gl_taxmaster where type=2  and per>0 and status=3)) left join my_acbook ac on"+
			" ac.acno=jv.acno left join my_brch b on b.doc_no=jv.brhid where jv.status=3 and jv.dtype='DNO' and "+
			" jv.date>='"+sqlfromdate+"' and jv.date<='"+sqltodate+"' "+
			" "+sqltest+"  group by jv.tr_no union all "+
			
			" SELECT invno, date, branchname, description, trnnumber, dtype, vocno, doc_no, IF(ATYPE='AP',totalvalue*-1,totalvalue) totalvalue, IF(ATYPE='AP',vatapplied*-1,vatapplied) vatapplied, IF(ATYPE='AP',vatnotapplied*-1,vatnotapplied) vatnotapplied ,IF(ATYPE='AP',vatcollected*-1,vatcollected) vatcollected FROM (select H.ATYPE, "
			+ "convert(m.refno,char(150)) invno,m.date,br.branchname,h.description,'' trnnumber,m.dtype,convert(m.doc_no,char(25)) vocno,h.doc_no,"
			+ " sum(if(d.nettot<0,d.nettot*-1,d.nettot))   totalvalue, sum(if(taxamount!=0,if(d.amount<0,d.amount*-1,d.amount),0)) vatapplied, sum(if(taxamount=0,if(d.amount<0,d.amount*-1,d.amount),0))  vatnotapplied,"
			+ " sum(coalesce(if(d.taxamount<0,d.taxamount*-1,d.taxamount),0))  vatcollected from my_cnot m left join my_cnotd d on m.tr_no=d.tr_no left join my_head h on h.doc_no=m.acno "
			+ " left join my_brch br on m.brhid=br.doc_no where m.dtype='TDN' and m.status=3 and  m.date between '"+sqlfromdate+"' and '"+sqltodate+"'  "+sqltest1+" group by m.tr_no) a "+
			"  union all"+
			
			" select m.refinvno invno,m.date,br.branchname,ac.refname,ac.trnnumber,m.dtype,convert(m.voc_no,char(100)) vocno ,m.doc_no,totalvalue,vatapplied,vatnotapplied, vatcollected "
				+ " from my_srvm  m left join (select sum(nettotal+taxamount)   totalvalue, sum(taxamount) vatcollected ,rdocno from my_srvd group by rdocno) d1 "
				+ " on d1.rdocno=m.doc_no left join (select sum(nettotal)  vatapplied,rdocno from my_srvd  where taxamount>0 group by rdocno) d2 "
				+ " on d2.rdocno=m.doc_no "
				+ " left join (select sum(nettotal)   vatnotapplied,rdocno from my_srvd where taxamount=0 group by rdocno) d3 "
				+ " on d3.rdocno=m.doc_no left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='VND' left join my_brch br on br.doc_no=m.brhid  where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+"  group by m.doc_no "
				+ " union all   select  inv.refinvno invno,m.date,br.branchname,ac.refname,ac.trnnumber,m.dtype,convert(m.voc_no,char(100)) vocno,m.doc_no,totalvalue,vatapplied,vatnotapplied,  vatcollected "
				+ " from my_srrm  m left join (select sum(nettotal+taxamount)   totalvalue,sum(taxamount) vatcollected ,rdocno from my_srrd group by rdocno) d1 "
				+ " on d1.rdocno=m.doc_no left join (select sum(nettotal)   vatapplied,rdocno from my_srrd  where taxamount>0 group by rdocno) d2 "
				+ "on d2.rdocno=m.doc_no left join (select sum(nettotal)   vatnotapplied,rdocno from my_srrd where taxamount=0 group by rdocno) d3 "
				+ "on d3.rdocno=m.doc_no  left join my_srvm inv on inv.doc_no=m.rrefno  left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='VND' left join my_brch br on br.doc_no=m.brhid  "
				+ "where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+"  group by m.doc_no )a union all"
    + " select coalesce(a.vndinvno,'') invno,a.date,a.branchname branch,a.refname,a.trnnumber clienttrn,a.dtype,a.vocno,a.vocno docno,"+
     " coalesce(a.totalvalue,0) totalvalue,coalesce(a.vatapplied,0) vatapplied,coalesce(a.vatnotapplied,0) vatnotapplied,"+
     " coalesce(a.vatcollected,0) vatcollected  from ("+
     " select ac.cldocno,ac.refname,ac.trnnumber,m.brhid,br.branchname,convert(m.invno,char(150)) vndinvno,m.date ,m.dtype,convert(m.voc_no,char(25)) vocno,m.doc_no,"+
     " sum(d.nettotal+d.taxamount)  totalvalue,aa.app vatapplied,bb.notapp  vatnotapplied,coalesce(aa.collect,0) "+
     " vatcollected from my_srvpurm m left join (select   sum(nettotal) app,sum(taxamount) collect,rdocno from my_srvpurd where taxamount>0"+
     " group by rdocno) aa on aa.rdocno=m.doc_no left join (select   sum(nettotal) notapp,rdocno from my_srvpurd where taxamount=0"+
     " group by rdocno) bb on bb.rdocno=m.doc_no left join my_srvpurd d on d.rdocno=m.doc_no left join my_acbook ac on"+
     " (m.acno=ac.acno and ac.dtype='VND') left join my_brch br on m.brhid=br.doc_no where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+"  group by m.tr_no) a "+
     " union all"+
     " select '' invno,a.date,a.branchname,a.refname,a.trnnumber clienttrn,a.dtype,convert(a.doc_no,char(25)) vocno,a.doc_no docno,a.totalamount totalvalue,"+
     " a.vatapplied,a.totalamount-(a.vatapplied+a.vatcollected) vatnotapplied,a.vatcollected from ("+
     " select jv.tr_no,jv.acno,jv.date,coalesce(br.branchname) branchname,coalesce(head.description,'') refname,'' trnnumber,jv.dtype,jv.doc_no,"+
     " round(sum(coalesce(jv.dramount,2)),2)*-1 totalamount,round(coalesce(appjv.dramount,0.00),2) vatapplied,"+
     " round(coalesce(taxjv.dramount,0.00),2) vatcollected from gl_bpo bpo inner join my_jvtran jv on (bpo.tr_no=jv.tr_no and jv.status=3) left join"+
     " (select dramount,tr_no,acno from my_jvtran where status=3 and date between '"+sqlfromdate+"' and '"+sqltodate+"' group by tr_no,acno) appjv on"+
     " (jv.tr_no=appjv.tr_no and appjv.acno=(select acno from my_account where codeno='COMMISSION ACCOUNT')) left join"+
     " (select dramount,tr_no,acno,date from my_jvtran where status=3 and date between '"+sqlfromdate+"' and '"+sqltodate+"' group by tr_no,acno) taxjv on"+
     " (jv.tr_no=taxjv.tr_no and taxjv.acno=(select t.acno from gl_taxmaster t left join my_head h on t.acno=h.doc_no where t.status=3"+
     " and t.type=1 and t.per>0 and t.fromdate<=taxjv.date and t.todate>=taxjv.date)) left join my_head head on (bpo.bank_acno=head.doc_no) left "+
     " join my_brch br on (jv.brhid=br.doc_no) where jv.status=3 "+sqltest+" and jv.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+
     " and jv.id<1 and bpo.type=2 group by jv.tr_no ) a where a.vatcollected<>0.00   " 
					
/*					+ " union all select convert(m.invno,char(25))  invno,m.date,br.branchname,ac.refname,ac.trnnumber,'CPU' dtype,"
                     + " convert(m.voc_no,char(25)) vocno,m.doc_no,sum(d.nettotal+d.taxamount)  totalvalue,aa.app vatapplied,"
                     +" (sum(d.nettotal+d.taxamount))-aa.app-coalesce(aa.collect,0) vatnotapplied,"
                     +" coalesce(aa.collect,0)  vatcollected from my_srvpurm m left join (select   sum(nettotal) app,sum(taxamount) collect,rdocno"
                     +" from my_srvpurd where taxamount>0 group by rdocno) aa on aa.rdocno=m.doc_no left join (select   sum(nettotal) notapp,rdocno"
                     +" from my_srvpurd where taxamount=0 group by rdocno) bb on bb.rdocno=m.doc_no left join my_srvpurd d on d.rdocno=m.doc_no"
                     +" left join my_acbook ac on (m.acno=ac.acno and ac.dtype='VND') left join my_brch br on m.brhid=br.doc_no"
                     +" where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+"   group by m.tr_no " */
                     
                     + " union all select convert(m.invno,char(25))  invno,m.date,br.branchname,ac.refname,ac.trnnumber,'CPR' dtype, convert(m.voc_no,char(25)) vocno,m.doc_no,sum(d.nettotal+d.taxamount) *-1 totalvalue,aa.app*-1 vatapplied, ((sum(d.nettotal+d.taxamount))-aa.app-coalesce(aa.collect,0))*-1 vatnotapplied, coalesce(aa.collect,0)*-1  vatcollected from my_srvpurretm m left join (select   sum(nettotal) app,sum(taxamount) collect,rdocno from my_srvpurretd where taxamount>0 group by rdocno) aa on aa.rdocno=m.doc_no left join (select   sum(nettotal) notapp,rdocno from my_srvpurretd where taxamount=0 group by rdocno) bb on bb.rdocno=m.doc_no left join my_srvpurretd d on d.rdocno=m.doc_no left join my_acbook ac on (m.acno=ac.acno and ac.dtype='VND') left join my_brch br on m.brhid=br.doc_no "
                     + " where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+"    group by m.tr_no"
                 	 + " union all select m.invno invno,m.date,br.branchname,ac.refname,ac.trnnumber,'EPD' dtype,convert(m.voc_no,char(100)) vocno ,m.doc_no,totalvalue,coalesce(vatapplied,0)  vatapplied,vatnotapplied, vatcollected  from eq_vpurdirm  m left join (select sum(tot_cost+tax_amt)   totalvalue, sum(tax_amt) vatcollected ,rdocno from eq_vpurdird group by rdocno) d1  on d1.rdocno=m.doc_no left join (select sum(tot_cost)  vatapplied,rdocno from eq_vpurdird  where tax_amt>0 group by rdocno) d2  on d2.rdocno=m.doc_no  left join (select sum(tot_cost)   vatnotapplied,rdocno from eq_vpurdird where tax_amt=0 group by rdocno) d3  on d3.rdocno=m.doc_no left join my_acbook ac on ac.acno=m.venid and ac.dtype='VND' left join my_brch br on br.doc_no=m.brhid "
        			+ " where m.status=3 and m.date>='"+sqlfromdate+"' and "+
        			" m.date<='"+sqltodate+"'  "+sqltest+" group by m.doc_no "
                     + ")g order by g.date asc";
			
			
			System.out.println("INPUT REPORT DATA ==========================="+strsql);
			
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
	
	
	
	/*public JSONArray getVatInputExcelData(String id,String branch,String fromdate,String todate) throws SQLException
	{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="",sqltest="",sqltest1="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
				sqltest+=" and jv.brhid="+branch;
				sqltest1+=" and m.brhid="+branch;

			}
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and jv.date>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and jv.date<='"+sqltodate+"'";
			}
			strsql="select a.branchname 'Branch',date_format(a.date,'%d.%m.%Y') 'Date',a.refname 'Vendor',a.trnnumber 'TRN',a.dtype 'Doc Type',a.vocno "+
			" 'Doc No',coalesce(a.vndinvno,'') 'Vendor Inv No',a.totalvalue 'Total Amount',(a.totalvalue-a.vatcollected) 'VAT 5% Purchase',"+
			" (a.totalvalue-(a.totalvalue-a.vatcollected)-a.vatcollected) 'VAT 0% Purchase', a.vatcollected 'VAT Paid' "+
			" from ("+
			" select convert(m.invno,char(25)) vndinvno,m.date,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) vocno,m.doc_no,round(sum(jv.dramount),2)*-1 "+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and m.type=1 and (m.date between tax.fromdate and tax.todate), "+
			" jv.dramount,0)),2)*-1 vatapplied,0 vatnotapplied,round(sum(coalesce(jv1.dramount,0)),2) vatcollected from my_srvpurm m inner join "+
			" my_jvtran jv on (jv.tr_no=m.tr_no and m.acno=jv.acno) left join my_acbook ac on (m.acno=ac.acno and ac.dtype='VND') left join "+
			" my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on (m.date between tax.fromdate and tax.todate and tax.type=1) "+
			" left join my_jvtran jv1 on (jv1.tr_no=m.tr_no and tax.acno=jv1.acno) where m.status=3 and m.date>='"+sqlfromdate+"' and "+
			" m.date<='"+sqltodate+"' "+sqltest+" group by m.tr_no union all"+
			" select convert(m.purno,char(25)) vndinvno,m.date,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) vocno,m.doc_no,round((jv.dramount),2)*-1 "+
			" totalvalue,round((if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate), jv.dramount,0)),2)*-1 "+
			" vatapplied,0 vatnotapplied, round((coalesce(jv1.dramount,0)),2) vatcollected from gl_vpurm m inner join my_jvtran jv on "+
			" (jv.tr_no=m.tr_no and m.venid=jv.acno  and dramount<0) left join my_acbook ac on (m.venid=ac.acno and ac.dtype='VND')"+
			" left join my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on (m.date between tax.fromdate and tax.todate and "+
			" tax.type=1 and per>0) left join my_jvtran jv1 on (jv1.tr_no=m.tr_no and tax.acno=jv1.acno) where jv.status=3 and "+
			" jv.date>='"+sqlfromdate+"' and jv.date<='"+sqltodate+"' and m.tr_no is not null "+sqltest+" group by m.tr_no union all"+
			" select convert(m.invno,char(25)) vndinvno,m.date,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) vocno,m.doc_no,round(sum(jv.dramount),2)*-1 "+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate), jv.dramount,0)),2)*-1 "+
			" vatapplied,0 vatnotapplied, round(sum(coalesce(jv1.dramount,0)),2) vatcollected from gl_vpurdirm m inner join my_jvtran jv on "+
			" (jv.tr_no=m.tr_no and m.venid=jv.acno  and dramount<0) left join my_acbook ac on (m.venid=ac.acno and ac.dtype='VND') left join "+
			" my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on (m.date between tax.fromdate and tax.todate and tax.type=1 and per>0)"+
			" left join my_jvtran jv1 on (jv1.tr_no=m.tr_no and tax.acno=jv1.acno) where m.status=3 and m.date>='"+sqlfromdate+"' and "+
			" m.date<='"+sqltodate+"' and m.tr_no is not null "+sqltest+" group by m.tr_no union all"+
			" select convert(m.invno,char(25)) vndinvno,m.date,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) vocno,m.doc_no,round(sum(jv.dramount),2)*-1 "+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate), jv.dramount,0)),2)*-1 "+
			" vatapplied,0 vatnotapplied, round(sum(coalesce(jv1.dramount,0)),2) vatcollected from gl_vmcostm m inner join gl_garrage g on "+
			" m.gargid=g.doc_no inner join my_jvtran jv on (jv.tr_no=m.trno and jv.acno=g.acc_no  and dramount<0) left join my_acbook ac on "+
			" (ac.acno=g.acc_no and ac.dtype='VND') left join my_brch br on  jv.brhid=br.doc_no left join gl_taxmaster tax on (m.date between "+
			" tax.fromdate and tax.todate and tax.type=1 and per>0) left join my_jvtran jv1 on (jv1.tr_no=m.trno and tax.acno=jv1.acno) where "+
			" m.status=3 and m.date>='"+sqlfromdate+"' and m.date<='"+sqltodate+"' and m.trno is not null "+sqltest+" group by m.trno "
						+ "  union all select m.refinvno invno,m.date,br.branchname,ac.refname,ac.trnnumber,m.dtype,convert(m.voc_no,char(100)) vocno ,m.doc_no,totalvalue,vatapplied,vatnotapplied, vatcollected "
				+ " from my_srvm  m left join (select sum(nettotal+taxamount)   totalvalue, sum(taxamount) vatcollected ,rdocno from my_srvd group by rdocno) d1 "
				+ " on d1.rdocno=m.doc_no left join (select sum(nettotal)  vatapplied,rdocno from my_srvd  where taxamount>0 group by rdocno) d2 "
				+ " on d2.rdocno=m.doc_no "
				+ " left join (select sum(nettotal)   vatnotapplied,rdocno from my_srvd where taxamount=0 group by rdocno) d3 "
				+ " on d3.rdocno=m.doc_no left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='VND' left join my_brch br on br.doc_no=m.brhid  where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+"  group by m.doc_no "
				+ " union all   select  inv.refinvno invno,m.date,br.branchname,ac.refname,ac.trnnumber,m.dtype,convert(m.voc_no,char(100)) vocno,m.doc_no,totalvalue,vatapplied,vatnotapplied, vatcollected "
				+ " from my_srrm  m left join (select sum(nettotal+taxamount)   totalvalue,sum(taxamount) vatcollected ,rdocno from my_srrd group by rdocno) d1 "
				+ " on d1.rdocno=m.doc_no left join (select sum(nettotal)   vatapplied,rdocno from my_srrd  where taxamount>0 group by rdocno) d2 "
				+ "on d2.rdocno=m.doc_no left join (select sum(nettotal)   vatnotapplied,rdocno from my_srrd where taxamount=0 group by rdocno) d3 "
				+ "on d3.rdocno=m.doc_no  left join my_srvm inv on inv.doc_no=m.rrefno  left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='VND' left join my_brch br on br.doc_no=m.brhid  "
				+ "where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+"  group by m.doc_no ) a union all"+
				
				select a.branchname 'Branch',date_format(a.date,'%d.%m.%Y') 'Date',a.refname 'Vendor',a.trnnumber 'TRN',a.dtype 'Doc Type',a.vocno "+
				" 'Doc No',coalesce(a.vndinvno,'') 'Vendor Inv No',a.totalvalue 'Total Amount',(a.totalvalue-a.vatcollected) 'VAT 5% Purchase',"+
				" (a.totalvalue-(a.totalvalue-a.vatcollected)-a.vatcollected) 'VAT 0% Purchase', a.vatcollected 'VAT Paid' "+
				" select a.branchname 'Branch',date_format(a.date,'%d.%m.%Y') 'Date',a.refname 'Vendor',a.trnnumber 'TRN',a.dtype 'Doc Type',a.vocno "+
				" 'Doc No',coalesce(a.vndinvno,'') 'Vendor Inv No',coalesce(a.totalvalue,0) 'Total Amount',coalesce(a.vatapplied,0) 'VAT 5% Purchase',"+
				" coalesce(a.vatnotapplied,0) 'VAT 0% Purchase', coalesce(a.vatcollected,0) 'VAT Paid' from ("+
     " select ac.cldocno,ac.refname,ac.trnnumber,m.brhid,br.branchname,convert(m.invno,char(150)) vndinvno,m.date ,m.dtype,convert(m.voc_no,char(25)) vocno,m.doc_no,"+
     " sum(d.nettotal+d.taxamount)  totalvalue,aa.app vatapplied,bb.notapp  vatnotapplied,coalesce(aa.collect,0) "+
     " vatcollected from my_srvpurm m left join (select   sum(nettotal) app,sum(taxamount) collect,rdocno from my_srvpurd where taxamount>0"+
     " group by rdocno) aa on aa.rdocno=m.doc_no left join (select   sum(nettotal) notapp,rdocno from my_srvpurd where taxamount=0"+
     " group by rdocno) bb on bb.rdocno=m.doc_no left join my_srvpurd d on d.rdocno=m.doc_no left join my_acbook ac on"+
     " (m.acno=ac.acno and ac.dtype='VND') left join my_brch br on m.brhid=br.doc_no where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+"  group by m.tr_no) a ";
			
			
			select a.branchname 'Branch',date_format(a.date,'%d.%m.%Y') 'Date',a.refname 'Vendor',a.trnnumber 'TRN',a.dtype 'Doc Type',a.vocno "+
			" 'Doc No',coalesce(a.vndinvno,'') 'Vendor Inv No',a.totalvalue 'Total Amount',(a.totalvalue-a.vatcollected) 'VAT 5% Purchase',"+
			" (a.totalvalue-(a.totalvalue-a.vatcollected)-a.vatcollected) 'VAT 0% Purchase', a.vatcollected 'VAT Paid'
			strsql="select * from (select a.branchname 'Branch',date_format(a.date,'%d.%m.%Y') 'Date',a.refname 'Vendor',a.trnnumber 'TRN',a.dtype 'Doc Type',a.vocno "+
			" 'Doc No',coalesce(a.vndinvno,'') 'Vendor Inv No',round(a.totalvalue,2) 'Total Amount',"+
			" round(if(a.vatcollected<>0,(a.totalvalue-a.vatcollected),0),2) 'VAT 5% Purchase',round((a.totalvalue-if(a.vatcollected<>0,(a.totalvalue-a.vatcollected),0)-a.vatcollected),2) 'VAT 0% Purchase', round(if(dtype='pir',vatcollected*-1,a.vatcollected),2) 'VAT Paid' "+
			" from ("+
			" select convert(m.invno,char(25)) vndinvno,m.date,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) vocno,m.doc_no,round(sum(jv.dramount),2)*-1 "+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and m.type=1 and (m.date between tax.fromdate and tax.todate), "+
			" jv.dramount,0)),2)*-1 vatapplied,0 vatnotapplied,round(sum(coalesce(jv1.dramount,0)),2) vatcollected from my_srvpurm m inner join "+
			" my_jvtran jv on (jv.tr_no=m.tr_no and m.acno=jv.acno) left join my_acbook ac on (m.acno=ac.acno and ac.dtype='VND') left join "+
			" my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on (m.date between tax.fromdate and tax.todate and tax.type=1) "+
			" left join my_jvtran jv1 on (jv1.tr_no=m.tr_no and tax.acno=jv1.acno) where m.status=3 and m.date>='"+sqlfromdate+"' and "+
			" m.date<='"+sqltodate+"' "+sqltest+" group by m.tr_no union all"+
			
			" select convert(m.purno,char(25)) vndinvno,m.date,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) vocno,m.doc_no,round((jv.dramount),2)*-1 "+
			" totalvalue,round((if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate), jv.dramount,0)),2)*-1 "+
			" vatapplied,0 vatnotapplied, round((coalesce(jv1.dramount,0)),2) vatcollected from gl_vpurm m inner join my_jvtran jv on "+
			" (jv.tr_no=m.tr_no and m.venid=jv.acno  and dramount<0) left join my_acbook ac on (m.venid=ac.acno and ac.dtype='VND')"+
			" left join my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on (m.date between tax.fromdate and tax.todate and "+
			" tax.type=1 and per>0) left join my_jvtran jv1 on (jv1.tr_no=m.tr_no and tax.acno=jv1.acno) where jv.status=3 and "+
			" jv.date>='"+sqlfromdate+"' and jv.date<='"+sqltodate+"' and m.tr_no is not null "+sqltest+" group by m.tr_no union all"+
			" select convert(m.invno,char(25)) vndinvno,m.date,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) vocno,m.doc_no,round(sum(jv.dramount),2)*-1 "+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate), jv.dramount,0)),2)*-1 "+
			" vatapplied,0 vatnotapplied, round(sum(coalesce(jv1.dramount,0)),2) vatcollected from gl_vpurdirm m inner join my_jvtran jv on "+
			" (jv.tr_no=m.tr_no and m.venid=jv.acno  and dramount<0) left join my_acbook ac on (m.venid=ac.acno and ac.dtype='VND') left join "+
			" my_brch br on jv.brhid=br.doc_no left join gl_taxmaster tax on (m.date between tax.fromdate and tax.todate and tax.type=1 and per>0)"+
			" left join my_jvtran jv1 on (jv1.tr_no=m.tr_no and tax.acno=jv1.acno) where m.status=3 and m.date>='"+sqlfromdate+"' and "+
			" m.date<='"+sqltodate+"' and m.tr_no is not null "+sqltest+" group by m.tr_no union all"+
			
			
" select jv.refno vndinvno,jv.date,branchname,refname,trnnumber,jv.dtype,convert(jv.doc_no,char(25)) vocno,jv.doc_no, "+
" round(sum(c.amt+(coalesce(taxjv.dramount,0))),2) totalvalue, round((if( coalesce(taxjv.dramount,0)!=0.00,c.amt,0)),2) vatapplied, 0 vatnotapplied, round(coalesce(taxjv.dramount,0),2)  vatcollected "+
" from my_cnot jv inner join (select sum(amount) amt,tr_no from my_cnotd c "+
" where c.acno not in (select acno from gl_taxmaster where type=2 and per>0 and status=3) group by tr_no) c on jv.tr_no=c.tr_no left join"+
" gl_taxmaster tax on (jv.date between tax.fromdate and tax.todate and tax.type=2)  left join (select coalesce(sum(dramount),0) dramount,tr_no,acno"+
" from my_jvtran where status=3 and dtype='DNO' and  date between '"+sqlfromdate+"' and '"+sqltodate+"' and id<0 group by tr_no,acno)"+
" taxjv on (taxjv.tr_no=jv.tr_no and taxjv.acno=(select acno from gl_taxmaster where type=2  and per>0 and status=3)) left join my_acbook ac on"+
" ac.acno=jv.acno left join my_brch b on b.doc_no=jv.brhid where jv.status=3 and jv.dtype='DNO' and "+
			" jv.date>='"+sqlfromdate+"' and jv.date<='"+sqltodate+"'"+
" "+sqltest+"  group by jv.tr_no union all"+
			
" select convert(m.refno,char(150)) invno,m.date,br.branchname,h.description,'' trnnumber,m.dtype,convert(m.doc_no,char(25)) vocno,h.doc_no,"
+ " sum(if(d.nettot<0,d.nettot*-1,d.nettot)*-1)    totalvalue, sum(if(taxamount!=0,if(d.amount<0,d.amount*-1,d.amount),0)) vatapplied, sum(if(taxamount=0,if(d.amount<0,d.amount*-1,d.amount),0))  vatnotapplied,"
+ " sum(coalesce(if(d.taxamount<0,d.taxamount*-1,d.taxamount),0))  vatcollected from my_cnot m left join my_cnotd d on m.tr_no=d.tr_no left join my_head h on h.doc_no=m.acno "
+ " left join my_brch br on m.brhid=br.doc_no where m.dtype='TDN' and m.status=3 and  m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest1+" group by m.tr_no "+
"  union all"+

			" select convert(m.invno,char(25)) vndinvno,m.postdate,br.branchname,ac.refname,ac.trnnumber,jv.dtype,convert(m.voc_no,char(25)) vocno,m.doc_no,round(sum(jv.dramount),2)*-1 "+
			" totalvalue,round(sum(if(ac.tax=1 and jv.acno<>tax.acno and (m.date between tax.fromdate and tax.todate), jv.dramount,0)),2)*-1 "+
			" vatapplied,0 vatnotapplied, round(sum(coalesce(jv1.dramount,0)),2) vatcollected from gl_vmcostm m inner join gl_garrage g on "+
			" m.gargid=g.doc_no inner join my_jvtran jv on (jv.tr_no=m.trno and jv.acno=g.acc_no  and dramount<0 and jv.status=3) left join my_acbook ac on "+
			" (ac.acno=g.acc_no and ac.dtype='VND') left join my_brch br on  jv.brhid=br.doc_no left join gl_taxmaster tax on (m.postdate between "+
			" tax.fromdate and tax.todate and tax.type=1 and per>0) left join my_jvtran jv1 on (jv1.tr_no=m.trno and tax.acno=jv1.acno) where "+
			" m.status=3 and m.postdate>='"+sqlfromdate+"' and m.postdate<='"+sqltodate+"' and m.trno is not null "+sqltest+" group by m.trno "+
			
			"  union all select m.refinvno invno,m.date,br.branchname,ac.refname,ac.trnnumber,m.dtype,convert(m.voc_no,char(100)) vocno ,m.doc_no,totalvalue,vatapplied,vatnotapplied, vatcollected "
				+ " from my_srvm  m left join (select sum(nettotal+taxamount)   totalvalue, sum(taxamount) vatcollected ,rdocno from my_srvd group by rdocno) d1 "
				+ " on d1.rdocno=m.doc_no left join (select sum(nettotal)  vatapplied,rdocno from my_srvd  where taxamount>0 group by rdocno) d2 "
				+ " on d2.rdocno=m.doc_no "
				+ " left join (select sum(nettotal)   vatnotapplied,rdocno from my_srvd where taxamount=0 group by rdocno) d3 "
				+ " on d3.rdocno=m.doc_no left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='VND' left join my_brch br on br.doc_no=m.brhid  where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+"  group by m.doc_no "
				+ " union all   select  inv.refinvno invno,m.date,br.branchname,ac.refname,ac.trnnumber,m.dtype,convert(m.voc_no,char(100)) vocno,m.doc_no,totalvalue,vatapplied,vatnotapplied,  vatcollected vatcollected "
				+ " from my_srrm  m left join (select sum(nettotal+taxamount)   totalvalue,sum(taxamount) vatcollected ,rdocno from my_srrd group by rdocno) d1 "
				+ " on d1.rdocno=m.doc_no left join (select sum(nettotal)   vatapplied,rdocno from my_srrd  where taxamount>0 group by rdocno) d2 "
				+ "on d2.rdocno=m.doc_no left join (select sum(nettotal)   vatnotapplied,rdocno from my_srrd where taxamount=0 group by rdocno) d3 "
				+ "on d3.rdocno=m.doc_no  left join my_srvm inv on inv.doc_no=m.rrefno  left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='VND' left join my_brch br on br.doc_no=m.brhid  "
				+ "where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+"  group by m.doc_no )a union all"
    + " select a.branchname 'Branch',date_format(a.date,'%d.%m.%Y') 'Date',a.refname 'Vendor',a.trnnumber 'TRN',a.dtype 'Doc Type',a.vocno  'Doc No',coalesce(a.vndinvno,'') 'Vendor Inv No', round(coalesce(a.totalvalue,0),2) 'Total Amount',round(coalesce(a.vatapplied,0),2) 'VAT 5% Purchase',round(coalesce(a.vatnotapplied,0),2) 'VAT 0% Purchase', round(coalesce(a.vatcollected,0),2) 'VAT Paid'   from ("+
     " select ac.cldocno,ac.refname,ac.trnnumber,m.brhid,br.branchname,convert(m.invno,char(150)) vndinvno,m.date ,m.dtype,convert(m.voc_no,char(25)) vocno,m.doc_no,"+
     " sum(d.nettotal+d.taxamount)  totalvalue,aa.app vatapplied,bb.notapp  vatnotapplied,coalesce(aa.collect,0) "+
     " vatcollected from my_srvpurm m left join (select   sum(nettotal) app,sum(taxamount) collect,rdocno from my_srvpurd where taxamount>0"+
     " group by rdocno) aa on aa.rdocno=m.doc_no left join (select   sum(nettotal) notapp,rdocno from my_srvpurd where taxamount=0"+
     " group by rdocno) bb on bb.rdocno=m.doc_no left join my_srvpurd d on d.rdocno=m.doc_no left join my_acbook ac on"+
     " (m.acno=ac.acno and ac.dtype='VND') left join my_brch br on m.brhid=br.doc_no where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+"  group by m.tr_no)a "+
     " union all"+
     " select a.branchname 'Branch',date_format(a.date,'%d.%m.%Y') 'Date',a.refname 'Vendor',a.trnnumber 'TRN',a.dtype 'Doc Type',"+
     " convert(a.doc_no,char(25))  'Doc No',0 'Vendor Inv No', a.totalamount 'Total Amount',a.vatapplied 'VAT 5% Purchase',"+
     " a.totalamount-(a.vatapplied+a.vatcollected) 'VAT 0% Purchase', a.vatcollected 'VAT Paid'   from ("+
     " select jv.tr_no,jv.acno,jv.date,coalesce(br.branchname) branchname,coalesce(head.description,'') refname,'' trnnumber,jv.dtype,jv.doc_no,"+
     " round(sum(coalesce(jv.dramount,2)),2)*-1 totalamount,round(coalesce(appjv.dramount,0.00),2) vatapplied,"+
     " round(coalesce(taxjv.dramount,0.00),2) vatcollected from gl_bpo bpo inner join my_jvtran jv on (bpo.tr_no=jv.tr_no and jv.status=3) left join"+
     " (select dramount,tr_no,acno from my_jvtran where status=3 and date between '"+sqlfromdate+"' and '"+sqltodate+"' group by tr_no,acno) appjv on"+
     " (jv.tr_no=appjv.tr_no and appjv.acno=(select acno from my_account where codeno='COMMISSION ACCOUNT')) left join"+
     " (select dramount,tr_no,acno,date from my_jvtran where status=3 and date between '"+sqlfromdate+"' and '"+sqltodate+"' group by tr_no,acno) taxjv on"+
     " (jv.tr_no=taxjv.tr_no and taxjv.acno=(select t.acno from gl_taxmaster t left join my_head h on t.acno=h.doc_no where t.status=3"+
     " and t.type=1 and t.per>0 and t.fromdate<=taxjv.date and t.todate>=taxjv.date)) left join my_head head on (bpo.bank_acno=head.doc_no) left "+
     " join my_brch br on (jv.brhid=br.doc_no) where jv.status=3 "+sqltest+" and jv.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+
     " and jv.id<1 and bpo.type=2 group by jv.tr_no ) a where a.vatcollected<>0.00 "
					+" union all select br.branchname,date_format(m.date,'%d.%m.%Y') date,ac.refname,ac.trnnumber,'CPU' dtype,"
					+" convert(m.voc_no,char(25)) vocno,convert(m.invno,char(25))  'Vendor Inv No', sum(d.nettotal+d.taxamount)  totalvalue,aa.app vatapplied,"
					+" (sum(d.nettotal+d.taxamount))-aa.app-coalesce(aa.collect,0) vatnotapplied,"
					+" coalesce(aa.collect,0)  vatcollected from my_srvpurm m left join (select   sum(nettotal) app,sum(taxamount) collect,rdocno"
					+" from my_srvpurd where taxamount>0 group by rdocno) aa on aa.rdocno=m.doc_no left join (select   sum(nettotal) notapp,rdocno"
					+" from my_srvpurd where taxamount=0 group by rdocno) bb on bb.rdocno=m.doc_no left join my_srvpurd d on d.rdocno=m.doc_no"
					+" left join my_acbook ac on (m.acno=ac.acno and ac.dtype='VND') left join my_brch br on m.brhid=br.doc_no"
					+" left join my_jvtran jcp on jcp.tr_no=m.tr_no left join gl_taxmaster tcp on tcp.acno=jcp.acno"
					+" where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+" and tcp.type=2   group by m.tr_no " 

			 
            + " union all select br.branchname,date_format(m.date,'%d.%m.%Y') date,ac.refname,ac.trnnumber,'CPR' dtype,"
					+" convert(m.voc_no,char(25)) vocno,convert(m.invno,char(25))  'Vendor Inv No' ,sum(d.nettotal+d.taxamount)  totalvalue,aa.app vatapplied,"
					+" (sum(d.nettotal+d.taxamount))-aa.app-coalesce(aa.collect,0) vatnotapplied,"
					+" coalesce(aa.collect,0)  vatcollected from my_srvpurretm m left join (select   sum(nettotal) app,sum(taxamount) collect,rdocno from my_srvpurretd where taxamount>0 group by rdocno) aa on aa.rdocno=m.doc_no left join (select   sum(nettotal) notapp,rdocno from my_srvpurretd where taxamount=0 group by rdocno) bb on bb.rdocno=m.doc_no left join my_srvpurretd d on d.rdocno=m.doc_no left join my_acbook ac on (m.acno=ac.acno and ac.dtype='VND') left join my_brch br on m.brhid=br.doc_no "
            + "  where  m.status=3 and m.date>='"+sqlfromdate+"' and   m.date<='"+sqltodate+"' "+sqltest1+"    group by m.tr_no)g order by g.date asc";
			
//			System.out.println("inputexcel==== "+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToEXCEL(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
*/}
