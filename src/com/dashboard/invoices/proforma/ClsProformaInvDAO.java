package com.dashboard.invoices.proforma;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class ClsProformaInvDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getInvoiceData(String uptodate,String branch,String mode) throws SQLException
	{
		JSONArray invdata=new JSONArray();
		if(!mode.equalsIgnoreCase("1")){
			return invdata;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="",strsql="",sqlbranch="";
			java.sql.Date sqldate=null;
			if(!branch.equalsIgnoreCase("")){
				sqlbranch+=" and agmt.brhid="+branch;
			}
			if(!uptodate.equalsIgnoreCase("") && uptodate!=null){
				sqldate=objcommon.changeStringtoSqlDate(uptodate);
			}
			sqltest+=" and tarif.rentaltype in ('Daily','Weekly','Monthly') and agmt.invdate<'"+sqldate+"' and clstatus=0 and agmt.invtype in (1,2)"+
        			"  "+sqlbranch+" ";
			
			strsql="select jv.outstanding,round(coalesce(ac.credit,0),2) creditlimit,case when datediff('"+sqldate+"',agmt.invdate)>day(last_day('"+sqldate+"')) then 1 else 0 end moredays,"+
			" datediff('"+sqldate+"',agmt.invdate) datediff,agmt.doc_no agmtno,agmt.voc_no agmtvocno,tarif.rentaltype,agmt.invtype,"+
			" agmt.invdate fromdate,'"+sqldate+"' todate,ac.cldocno,ac.acno clientacno,head.account "+
			" clientaccount,head.description clientacname from gl_ragmt agmt left join"+
			" gl_rtarif tarif on (agmt.doc_no=tarif.rdocno and tarif.rstatus=5) inner join my_acbook ac on (agmt.cldocno=ac.cldocno and"+
			" ac.dtype='CRM') left join my_head head on ac.acno=head.doc_no left join (select sum(dramount) outstanding,acno from my_jvtran "+
			" where status=3 group by acno) jv on (jv.acno=ac.acno) where 1=1  "+sqltest+"order by agmt.voc_no";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			invdata=objcommon.convertToJSON(rs);
			stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return invdata;
	}
	
	public JSONObject getSalikTraffic(int agmtno,java.sql.Date sqldate,java.sql.Date invfromdate,int cldocno,Connection conn){
		JSONObject objsalik=new JSONObject();
		try{
			Statement stmt=conn.createStatement();
			int salikcount=0;
			int trafficcount=0;
			String strsqltest="";
			String strasd="select method from gl_config where field_nme='closecal'";
			Statement stmtasd=conn.createStatement();
			ResultSet rsasd=stmtasd.executeQuery(strasd);
			int salikclosecalmethod=0;
			while(rsasd.next()){
				salikclosecalmethod=rsasd.getInt("method");
			}
			if(salikclosecalmethod==1){
				strsqltest=" and inv_no=0";
			}
			
			String strsalik="select COALESCE(sum(amount),0.0) amount,count(*) count,amount salamount from gl_salik where amount>0 and isallocated=1 and ra_no="+agmtno+" and"+
					" rtype in('RA','RD','RW','RF','RM')  and sal_date <='"+sqldate+"' "+strsqltest;
			//System.out.println(strsalik);
			ResultSet rssalik=stmt.executeQuery(strsalik);
			double salikamt=0.0,salamount=0.0; 
			while(rssalik.next()){
				salikamt=rssalik.getDouble("amount");
				salikcount=rssalik.getInt("count");
				salamount=rssalik.getDouble("salamount");
			}
			String srvcsalik="select method from gl_config where field_nme='srvcchgsalik'";
			//System.out.println(srvcsalik);
			ResultSet rssrvcsalik=stmt.executeQuery(srvcsalik);
			int srvcsalikmethod=0;
			if(rssrvcsalik.next()){
				srvcsalikmethod=rssrvcsalik.getInt("method");
			}
			
			String strtraffic="select  count(*) trafficcount,COALESCE(sum(amount),0.0) trafficamt from gl_traffic where amount>0  and isallocated=1 and emp_type='CRM' and ra_no="+agmtno+" and "+
					" rtype in ('RA','RD','RW','RF','RM') and traffic_date <='"+sqldate+"' "+strsqltest;
//			System.out.println(strtraffic);
			ResultSet rstraffic=stmt.executeQuery(strtraffic);
			double trafficamt=0.0;
			while(rstraffic.next()){
				trafficamt=rstraffic.getDouble("trafficamt");
				trafficcount=rstraffic.getInt("trafficcount");
			}
			
			
			//Fetching Dubai Gov Traffic Acknowledge Fees
			ClsCommon objcommon=new ClsCommon();

			double trafficfees=objcommon.getTrafficFees(agmtno,invfromdate,sqldate,"RAG","1");
			
			if(trafficfees>0){
				trafficamt=(trafficamt+trafficfees);
			
			}
			
			int srvcdefault=0;
			double salikrate=0.0,trafficrate=0.0;
			int multiplesrvcconfig=0;
			String strmultiplesrvc="select method from gl_config where field_nme='crmSeparateServiceCharge'";
			ResultSet rsmultiplesrvc=stmt.executeQuery(strmultiplesrvc);
			while(rsmultiplesrvc.next()){
				multiplesrvcconfig=rsmultiplesrvc.getInt("method");
			}
			if(multiplesrvcconfig==1){
				String srvcrentaltype="";
				String strgetsrvctype="select rentaltype from gl_rtarif where rdocno="+agmtno+" and rstatus=5";
				ResultSet rssrvctype=stmt.executeQuery(strgetsrvctype);
				while(rssrvctype.next()){
					srvcrentaltype=rssrvctype.getString("rentaltype");
				}
				String stracbook="select salikrate,trafficcharge from my_clservicecharge m left join gl_clservicecharge d on (m.serviceid=d.doc_no and d.status=1) where m.cldocno="+cldocno+" and d.desc1='"+srvcrentaltype+"'";
				ResultSet rssrvcmultiple=stmt.executeQuery(stracbook);
				while(rssrvcmultiple.next()){
					salikrate=rssrvcmultiple.getDouble("salikrate");
					trafficrate=rssrvcmultiple.getDouble("trafficcharge");
					srvcdefault=0;
				}
			}
			else if(multiplesrvcconfig==0){
				String stracbook="select ser_default,per_salikrate,per_trafficharge from my_acbook where cldocno='"+cldocno+"' and dtype='CRM' and status<>7";
				ResultSet rsacbook=stmt.executeQuery(stracbook);
				while(rsacbook.next()){
					srvcdefault=rsacbook.getInt("ser_default");
					if(srvcdefault==0){
						salikrate=rsacbook.getDouble("per_salikrate");
						trafficrate=rsacbook.getDouble("per_trafficharge");
					}
				}
			}
			
			int trafficmethod=0;
			double trafficapply=0.0;
			double trafficsrvc=0.0;
			double trafficsrvcper=0.0;
			double trafficpercalc=0.0;
			double finaltrafficsrvc=0.0;
			if(srvcdefault==1){
				String saliksrv="select if((select method from gl_config where field_nme='saliksrv')=1,(select value from gl_config where field_nme='saliksrv'),0)"+
						" saliksrv  from gl_config where field_nme='saliksrv'";
//				System.out.println("Salik srv Query:"+saliksrv);
				ResultSet rssaliksrv=stmt.executeQuery(saliksrv);
				while(rssaliksrv.next()){
					salikrate=rssaliksrv.getDouble("saliksrv");
				}
				
				String strtrafficsrv="select method,value from gl_config where field_nme='trafficsrvapply'";
				ResultSet rstrafficsrvapply=stmt.executeQuery(strtrafficsrv);
				while(rstrafficsrvapply.next()){
					trafficmethod=rstrafficsrvapply.getInt("method");
				trafficapply=rstrafficsrvapply.getDouble("value");
				}
				
				if(trafficmethod==1){
				String 	trafficsrvchgper="select value from gl_config where field_nme='trafficsrvper'";
				ResultSet rstrafficsrvchgper=stmt.executeQuery(trafficsrvchgper);
				while(rstrafficsrvchgper.next()){
					trafficsrvcper=rstrafficsrvchgper.getDouble("value");
					trafficpercalc=trafficamt*(trafficsrvcper/100);
					finaltrafficsrvc=trafficpercalc;
					
				}
//				System.out.println("Inside Traffic Percent:"+finaltrafficsrvc);
				}
				if(trafficmethod==0){
					String trafficsrvchg="select value from gl_config where field_nme='trafficsrv'";
					ResultSet rstrafficsrvchg=stmt.executeQuery(trafficsrvchg);
					while(rstrafficsrvchg.next()){
						trafficsrvc=rstrafficsrvchg.getDouble("value");
						//finaltrafficsrvc=trafficamt*trafficsrvc;
						finaltrafficsrvc=trafficcount*trafficsrvc;
					}
					System.out.println("Inside Traffic Value:"+finaltrafficsrvc);
				}
				
				if(trafficmethod==2){
					if(trafficpercalc<=trafficapply){
						finaltrafficsrvc=trafficapply;
					}
					else{
						finaltrafficsrvc=trafficpercalc;
					}
				}
			}
			else{
//				System.out.println("Check traffic srvc:::"+trafficrate+":::"+trafficcount);
				finaltrafficsrvc=trafficrate*trafficcount;		//Traffic Service Charge from my_acbook according to client
			}
			
			double saliksrvcchg=salikcount*salikrate;
			
			objsalik.put("salikamt",salikamt);
			objsalik.put("saliksrvc",saliksrvcchg);
			objsalik.put("trafficamt",trafficamt);
			objsalik.put("trafficsrvc",finaltrafficsrvc);
			objsalik.put("salikcount",salikcount);
			objsalik.put("trafficcount",trafficcount);
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return objsalik;
	}
	
	
}
