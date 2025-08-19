package com.dashboard.analysis.contractAnalysisPivot;

import java.sql.Connection;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsContractAnalysisDAO {
	
	ClsCommon com=new ClsCommon();
	ClsConnection conobj=new ClsConnection();  
	
	public  JSONArray loadGridData(HttpSession session,String fromdate,String todate) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqldata="",date="";   
        java.sql.Date sdate = null;
        java.sql.Date edate = null;
		try {

			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();
			
			if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
				sdate = com.changeStringtoSqlDate(fromdate);
				
				 date = fromdate.substring(fromdate.length()- 4);
			}
			if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
				edate = com.changeStringtoSqlDate(todate);
			}  
			sqldata="select  convert(m.year,char(45)) year,ma.refname vendor,mya.refname client,cg.cat_name category,m.salname,m.telesales,ser.name sertype, ins.name instype,round(m.premium,2) premium,round(m.commvalue,2) commvalue,round(m.marginval,2) marginval  from("
                    + "select a.year,dtype, a.doc_no, srno, contractno, sum(commvalue) commvalue, sum(marginval) marginval, rdocno, policyno, startdt, enddt, instype, sum(premium) premium, vendid, cldocno, sum(bfee) bfee, sum(discount) discount, discounttype, clientpay, settype, network, category,a.planid,a.salname,a.telesales,a.status,a.type from "
                    + "(select  'INS' dtype,hm.name telesales,ms.sal_name salname,cn.doc_no,d.srno,cn.voc_no contractno,round(d.commvalue,2) commvalue,round(d.marginval,2) marginval,d.rdocno,d.policyno,d.startdt,d.enddt,d.instype instype,round(d.premium,2) premium,d.vendid ,cn.cldocno ,round(d.bfee,2)bfee,round(d.discount,2)discount,d.discounttype,d.clientpay,d.settype,d.network,d.category,d.planid,if(en.rtypeid=1,'Renewal','New')type,if(cn.status=3,'Approved','Not Approved') status,concat(year(cn.date),'/',month(cn.date)) year from in_contractd d "
                    + "left join in_contract cn on d.rdocno=cn.doc_no left join my_salm ms on cn.sal_id=ms.sal_id and ms.status=3 left join in_enqm en on cn.refno=en.doc_no and en.status=3 left join hi_employee hm on en.telesales=hm.doc_no and hm.status=3  where cn.status<=3 and cn.date>='"+sdate+"' and cn.date<='"+edate+"'  "
                    + "union all "
                    + "select 'END' dtype,hm.name telesales,md.sal_name salname,cn.doc_no,d.srno,cn.voc_no contractno,round(d.commvalue,2) commvalue,round(d.marginval,2) marginval,d.rdocno,d.policyno,d.startdt,d.enddt,d.instype instype,round(d.premium,2) premium,d.vendid ,cn.cldocno ,round(d.bfee,2)bfee,round(d.discount,2)discount,d.discounttype,d.clientpay,d.settype,d.network,d.category,d.planid,if(en.rtypeid=1,'Renewal','New')type,if(cn.status=3,'Approved','Not Approved') status,concat(year(cn.date),'/',month(cn.date)) year  from in_endorsementd d "
                    + "left join in_endorsement cn on d.rdocno=cn.doc_no  left join my_salm md on cn.sal_id=md.sal_id and md.status=3 left join in_enqm en on cn.refno=en.doc_no and en.status=3  left join hi_employee hm on en.telesales=hm.doc_no and hm.status=3 where cn.status<=3 and cn.date>='"+sdate+"' and cn.date<='"+edate+"'  ) a  group by dtype,doc_no ) m "
                    + "left join my_acbook ma on m.vendid =ma.cldocno and ma.dtype='VND' "
                    + "left join my_acbook mya on m.cldocno=mya.cldocno and mya.dtype='CRM' left join my_clcatm cg on cg.doc_no=mya.catid "
                    + "left join in_insurtype ins on ins.doc_no=m.instype "
                    + "left join in_opaccount op on op.cnttrno=m.doc_no and op.dtype=m.dtype "
                    + "left join in_servicetype ser on ser.doc_no=ins.servid "
                    + "left join my_srvsalem sm on sm.tr_no=op.invtrno and sm.status=3 "
                    + "left join my_srvsaleretm sr on sr.tr_no=op.invrettrno and sr.status=3 "
                    + "left join my_jvma j on j.tr_no=op.jvtrno and j.status=3 "
                    + "left join in_plan pl on pl.srno=m.planid and pl.status=3 "
                    + "left join in_opaccountd opd on opd.rowno=op.rowno and opd.status=3 where 1=1 ";			    
			System.out.println("=contract analysis--->>>"+sqldata);
			resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=com.convertToJSON(resultSet);
				//	System.out.println("=====RESULTDATA"+RESULTDATA);
			
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}
}
