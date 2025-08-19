package com.dashboard.invoices.leasealmariah;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import com.connection.*;
import com.common.ClsCommon;

public class ClsInvGetSalikAlmariah {
	ClsConnection ClsConnection=new ClsConnection();
	public  ArrayList<Double> getSalik(Date fromdate,Date todate,String clientid,String agmtno,String agmttype) throws SQLException{
		Connection conn=null;
		
		ArrayList<Double> salikarray= new ArrayList<Double>();
		try {
			String sqltestsalik="";
			String sqltesttraffic="";
			String sqlrtype="";
			
			conn=ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			double leasecalcsalik=0.0;
			String strgetleasecalcdata="select req.salikcharge from gl_lagmt agmt left join gl_masterlagm m on (agmt.masterrefno=m.doc_no and "+
			" agmt.masterreftype='MLA') left join gl_masterlagd d on (m.doc_no=d.rdocno and agmt.masterrefsrno=d.sr_no) left join "+
			" gl_almariahleasecalcm calc on (m.reftype='QOT' and m.qotrefno=calc.doc_no) left join gl_almariahleasecalcreq req on "+
			" (calc.doc_no=req.rdocno and d.sr_no=req.sr_no) where agmt.doc_no="+agmtno;
			ResultSet rsleasecalcdata=stmt.executeQuery(strgetleasecalcdata);
			while(rsleasecalcdata.next()){
				leasecalcsalik=rsleasecalcdata.getDouble("salikcharge");
			}
			if(!(fromdate==null && todate==null)){
				if(agmttype.equalsIgnoreCase("RAG")){
					sqlrtype=" and rtype in('RA','RD','RW','RF','RM') ";
				}
				else if(agmttype.equalsIgnoreCase("LAG")){
					sqlrtype=" and rtype in('LA','LC') ";
				}
				sqltestsalik=" and sal_date <='"+todate+"'"+sqlrtype;
				sqltesttraffic=" and traffic_date <= '"+todate+"'"+sqlrtype;
				
			}
			
		int salikcount=0;
		double salamount=0.0;
		String strsalik="select COALESCE(sum(amount),0.0) amount,count(*) count,COALESCE(amount,0.0) salamount from gl_salik where amount>0 and inv_no=0 and  ra_no='"+agmtno+"' and isallocated=1 "+sqltestsalik;
		//System.out.println(strsalik);
		ResultSet rssalik=stmt.executeQuery(strsalik);
		double salikamt=0.0;
		while(rssalik.next()){
			salikamt=rssalik.getDouble("amount");
			salikcount=rssalik.getInt("count");
			salamount=rssalik.getDouble("salamount");
			
		}
		/*String srvcsalik="select method from gl_config where field_nme='srvcchgsalik'";
		//System.out.println(srvcsalik);
		ResultSet rssrvcsalik=stmt.executeQuery(srvcsalik);
		int srvcsalikmethod=0;
		if(rssrvcsalik.next()){
			srvcsalikmethod=rssrvcsalik.getInt("method");
		}*/
		int multiplesrvcconfig=0;
		String strmultiplesrvc="select method from gl_config where field_nme='crmSeparateServiceCharge'";
		ResultSet rsmultiplesrvc=stmt.executeQuery(strmultiplesrvc);
		while(rsmultiplesrvc.next()){
			multiplesrvcconfig=rsmultiplesrvc.getInt("method");
		}
		int srvcdefault=0;
		double salikrate=0.0,trafficrate=0.0;
		if(multiplesrvcconfig==1){
			String srvcrentaltype="";
			if(agmttype.equalsIgnoreCase("RAG")){
				String strgetsrvctype="select rentaltype from gl_rtarif where rdocno="+agmtno+" and rstatus=5";
				ResultSet rssrvctype=stmt.executeQuery(strgetsrvctype);
				while(rssrvctype.next()){
					srvcrentaltype=rssrvctype.getString("rentaltype");
				}
			}
			else if(agmttype.equalsIgnoreCase("LAG")){
				srvcrentaltype="Lease";
			}
			String stracbook="select salikrate,trafficcharge from my_clservicecharge m left join gl_clservicecharge d on (m.serviceid=d.doc_no and d.status=1) where m.cldocno="+clientid+" and d.desc1='"+srvcrentaltype+"'";
			ResultSet rssrvcmultiple=stmt.executeQuery(stracbook);
			while(rssrvcmultiple.next()){
				salikrate=rssrvcmultiple.getDouble("salikrate");
				trafficrate=rssrvcmultiple.getDouble("trafficcharge");
				srvcdefault=0;
			}
		}
		else if(multiplesrvcconfig==0){
			String stracbook="select ser_default,per_salikrate,per_trafficharge from my_acbook where cldocno='"+clientid+"' and dtype='CRM' and status<>7";
			//System.out.println("Acbbok"+stracbook);
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
		int trafficpermethod=0,trafficsrvmethod=0;
		double trafficamt=0.0;
		int trafficcount=0;
		if(srvcdefault==0){
			String strtraffic="select  COALESCE(sum(amount),0.0) trafficamt,count(*) count  from gl_traffic where amount>0 and inv_no=0 and isallocated=1 and emp_type='CRM' and ra_no='"+agmtno+"'"+sqltesttraffic;
//			System.out.println(strtraffic);
			ResultSet rstraffic=stmt.executeQuery(strtraffic);
			while(rstraffic.next()){
				trafficamt=rstraffic.getDouble("trafficamt");
				trafficcount=rstraffic.getInt("count");
			}	
		}
		
		if(srvcdefault==1){
			String saliksrv="select if((select method from gl_config where field_nme='saliksrv')=1,(select value from gl_config where field_nme='saliksrv'),0)"+
					" saliksrv  from gl_config where field_nme='saliksrv'";
			ResultSet rssaliksrv=stmt.executeQuery(saliksrv);
			while(rssaliksrv.next()){
				salikrate=rssaliksrv.getDouble("saliksrv");
			}
			String strtrafficsrv="select method,value,field_nme from gl_config where field_nme in('trafficsrvapply','trafficsrvper','trafficsrv')";
			//String strtrafficsrv="select method,value from gl_config where field_nme='trafficsrvapply'";
			ResultSet rstrafficsrvapply=stmt.executeQuery(strtrafficsrv);
			while(rstrafficsrvapply.next()){
				if(rstrafficsrvapply.getString("field_nme").equalsIgnoreCase("trafficsrvapply")){
					trafficmethod=rstrafficsrvapply.getInt("method");
					trafficapply=rstrafficsrvapply.getDouble("value");	
				}
				if(rstrafficsrvapply.getString("field_nme").equalsIgnoreCase("trafficsrvper")){
					trafficpermethod=rstrafficsrvapply.getInt("method");
					trafficsrvcper=rstrafficsrvapply.getDouble("value");
				}
				if(rstrafficsrvapply.getString("field_nme").equalsIgnoreCase("trafficsrv")){
					trafficsrvmethod=rstrafficsrvapply.getInt("method");
					trafficsrvc=rstrafficsrvapply.getDouble("value");
				}
				
			}		
			
			
			double traffic=0.0,pertraffic=0.0,amttraffic=0.0; 
			ClsCommon objcommon=new ClsCommon();
			double trafficfees=0.0;
			trafficfees=objcommon.getTrafficFees(Integer.parseInt(agmtno),fromdate,todate,agmttype,"1");
			
			
			
			String strtrafficvalues="select  if(COALESCE(sum(amount),0.0)>0.0,COALESCE(sum(amount),0.0)+"+trafficfees+",0.0) trafficamt,count(*) count  from gl_traffic where amount>0 and inv_no=0 and emp_type='CRM' and ra_no='"+agmtno+"'"+sqltesttraffic;
//			 System.out.println(" Inside Srvc Default Traffic Query"+strtrafficvalues);
			ResultSet rstrafficvalues=stmt.executeQuery(strtrafficvalues);
			while(rstrafficvalues.next()){
				if(trafficrate>0.0)	{
					traffic=trafficrate*rstrafficvalues.getDouble("trafficamt");
					trafficcount=rstrafficvalues.getInt("count");
				}
				else {
						if(trafficpermethod==1){
							pertraffic=rstrafficvalues.getDouble("trafficamt")*(trafficsrvcper/100);
							trafficcount=rstrafficvalues.getInt("count");
						}
						else if(trafficpermethod==0){
							pertraffic=0;
							}
					
						if(trafficsrvmethod==1){
							amttraffic=trafficsrvc;
							trafficcount=rstrafficvalues.getInt("count");
						}
						else if(trafficsrvmethod==0){
							amttraffic=0;
						}
						if(trafficmethod==1){traffic=pertraffic;	}
						if(trafficmethod==0){traffic=amttraffic*trafficcount;	}
						if(trafficmethod==2){traffic=(trafficapply>=pertraffic)?trafficapply:pertraffic;	}
					}	
//				System.out.println("Traffic Method Check:"+trafficmethod);
				finaltrafficsrvc+=traffic;
				trafficamt+=rstrafficvalues.getDouble("trafficamt");
				//System.out.println("============"+finaltrafficsrvc);
			}
			}
		else{
			finaltrafficsrvc=trafficrate*trafficcount;
		}
			//System.out.println("FinalTraffic"+finaltrafficsrvc);
				
				
	/*		if(srvcdefault==1){
				salikrate=salikamt;
			}*/
		double saliksrvcchg=salikcount*salikrate;
		double saliktemprate=0.0;
		if(salamount>0){
			saliktemprate=salikrate;
		}
		
		//System.out.println("Salik Srvc"+saliksrvcchg);
		if(leasecalcsalik>0.0){
			salikarray.add(leasecalcsalik);
			salikarray.add(0.0);
			salikarray.add(0.0);
			salikarray.add(0.0);
			salikarray.add(1.0);
			salikarray.add(0.0);
			salikarray.add(leasecalcsalik);
			salikarray.add(leasecalcsalik);
		}
		else{
			/*salikarray.add(salikamt);
			salikarray.add(trafficamt);
			salikarray.add(saliksrvcchg);
			salikarray.add(finaltrafficsrvc);
			salikarray.add((double) salikcount);
			salikarray.add((double)trafficcount);
			salikarray.add(salamount);
			salikarray.add(saliktemprate);*/
			salikarray.add(salikamt);
			salikarray.add(0.0);
			salikarray.add(saliksrvcchg);
			salikarray.add(0.0);
			salikarray.add((double) salikcount);
			salikarray.add(0.0);
			salikarray.add(salamount);
			salikarray.add(saliktemprate);
		}
		
		conn.close();
		return salikarray;
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.close();
		
		}
		finally{
			conn.close();
		}
		return salikarray;
		
	}
}
