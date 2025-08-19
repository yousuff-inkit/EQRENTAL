package com.dashboard.analysis.salesAnalysisPivot;

import java.sql.Connection;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSalesAnalysisDAO {
	
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
			sqldata="select rt.rentaltype,a.date,concat(month(a.date) ,' / ' , year(a.date)) month,coalesce(ac.refname,'NA') client,coalesce(cat.cat_name,'NA') category,a.description acname,coalesce(sal.sal_name,'NA') salesman,coalesce(brd.brand_name,'NA') brand, coalesce(model.vtype,'NA') model,coalesce(grp.gname,'NA') grop,coalesce(yom.yom,0) yom, ((a.amount))*-1 amount from ( select c.amount,j.rtype,j.rdocno,c.jobid,j.tr_no,j.dtype,j.cldocno,j.doc_no,h.description,j.date from my_costtran c  inner join my_jvtran j on c.tranid=j.tranid left join my_head h on c.acno=h.doc_no where h.den=110 and j.status=3  and j.date>='"+sdate+"' and j.date<='"+edate+"')a left join gl_invm inv on (a.dtype in ('INV','INS','INT') and a.tr_no=inv.tr_no) left join my_cnot cno on (a.dtype in('CNO','DNO') and a.tr_no=cno.tr_no) left join my_acbook ac on ( (inv.cldocno=ac.cldocno or cno.acno=ac.acno) and ac.dtype='CRM') left join my_clcatm cat on ac.catid=cat.doc_no left join my_salm sal on ac.sal_id=sal.doc_no  left join  gl_vehmaster veh on a.jobid=veh.fleet_no left join gl_vehmodel model on veh.vmodid=model.doc_no  left join gl_vehbrand brd on veh.brdid=brd.doc_no left join gl_vehgroup grp on veh.vgrpid=grp.doc_no left join gl_yom yom on veh.yom=yom.doc_no left join gl_ragmt r on r.doc_no=inv.rano and inv.ratype='rag' left join gl_rtarif rt on r.doc_no=rt.rdocno and rt.rstatus=5  where 1=1 ; ";			    
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
