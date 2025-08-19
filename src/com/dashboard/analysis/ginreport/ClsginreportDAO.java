package com.dashboard.analysis.ginreport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsginreportDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	
	
	public   JSONArray nipurchasesummeryReports(String barchval,String fromdate,String todate,String type,String status,String cldocno,String psrno,String pdocno,String salid,String summery) throws SQLException {
/*System.out.println(barchval+""+fromdate+""+todate+""+type+""+status+""+cldocno+""+psrno+""+pdocno+""+salid+""+summery);*/
        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
        String sqlcommon="";
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
    	if(sqlfromdate!=null){
    		sqlcommon+=" and m.date>='"+sqlfromdate+"'";
    	}
    	if(sqltodate!=null){
    		sqlcommon+=" and m.date<='"+sqltodate+"'";
    	}
     	
     	String sqltest1="";
     	String sqltest2="";
     	String sqltest3="";
     	String sqltest4="";
     	
       
     
        
    	
    	if(!((barchval.equalsIgnoreCase("a")) || (barchval.equalsIgnoreCase("NA")) || (barchval.equalsIgnoreCase("0")))){
    		sqlcommon+=" and m.brhid='"+barchval+"'";
 		}
    	if(!((cldocno.equalsIgnoreCase("")) || (cldocno.equalsIgnoreCase("NA")) || (cldocno.equalsIgnoreCase("0")))){
    		sqltest1+=" and ac.cldocno='"+cldocno+"'";
 		}
    	if(!((psrno.equalsIgnoreCase("")) || (psrno.equalsIgnoreCase("NA")) || (psrno.equalsIgnoreCase("0")))){
    		sqltest4+=" and mm.psrno='"+psrno+"'";
 		}
    	if(!((pdocno.equalsIgnoreCase("")) || (pdocno.equalsIgnoreCase("NA")) || (pdocno.equalsIgnoreCase("0")))){
    		sqltest3+=" and c.costcode='"+pdocno+"'";
 		}
    	if(!((salid.equalsIgnoreCase("")) || (salid.equalsIgnoreCase("NA")) || (salid.equalsIgnoreCase("0")))){
    		sqltest2+=" and lm.doc_no='"+salid+"'";
 		}
    	
     	Connection conn = null;
 
    
        
		try {
		 	if(!((type.equalsIgnoreCase("")) || (type.equalsIgnoreCase("NA")) || (type.equalsIgnoreCase("0")))){
			
		 		if(type.equalsIgnoreCase("CICA")) 
			{
			if(status.equalsIgnoreCase("ALL"))
			{
			
			String sqlselect="";
			String sqlgroup="";
			if(summery.equalsIgnoreCase("CLT")){
        		sqlselect=" ,ac.cldocno refno,ac.refname ";
        		sqlgroup=" left join my_acbook ac on m.acno=ac.acno left join my_salm lm on m.sal_id=lm.doc_no "
        				+ "left join my_ccentre c on m.costcode=c.doc_no left join my_cutinvd d on m.doc_no=d.rdocno left join my_main mm on d.psrno=mm.psrno where 1=1 and m.ftype=1 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by ac.cldocno";
        	}
			else if(summery.equalsIgnoreCase("SAL")){
        		sqlselect=" ,lm.doc_no refno,lm.sal_name refname ";
        		sqlgroup=" left join my_acbook ac on m.acno=ac.acno left join my_salm lm on m.sal_id=lm.doc_no left join my_ccentre c on m.costcode=c.doc_no left join my_cutinvd d on m.doc_no=d.rdocno left join my_main mm on d.psrno=mm.psrno where 1=1 and m.ftype=1 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by lm.doc_no";
        	}
			else if(summery.equalsIgnoreCase("PRJ")){
        		sqlselect=" ,c.doc_no refno,c.description refname  ";
        		sqlgroup="left join my_acbook ac on m.acno=ac.acno left join my_salm lm on m.sal_id=lm.doc_no "
        				+ "left join my_ccentre c on m.costcode=c.doc_no left join my_cutinvd d on m.doc_no=d.rdocno left join my_main mm on d.psrno=mm.psrno where 1=1 and m.ftype=1 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by c.doc_no";
        	}
			
        	else if(summery.equalsIgnoreCase("PRD")){
        		sqlselect=" ,mm.psrno refno,mm.productname refname ";
        		sqlgroup="left join my_acbook ac on m.acno=ac.acno left join my_salm lm on m.sal_id=lm.doc_no left join my_ccentre c on m.costcode=c.doc_no left join my_cutinvd d on m.doc_no=d.rdocno left join my_main mm on d.psrno=mm.psrno where 1=1 and m.ftype=1 "+sqlcommon+"  "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by mm.psrno";
        	}
        	/*else if(grpby.equalsIgnoreCase("group")){
        		sqlselect=" grp.doc_no refno,grp.gname description";
        	}
        	else if(grpby.equalsIgnoreCase("yom")){
        		sqlselect=" yom.doc_no refno,yom.yom description";
        	}*/
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
 
				
				String strsql="select sum(nettotal) nettotal"+sqlselect+" from my_cutinvm m"+sqlgroup;
            		
       //System.out.println("------sql-----"+strsql);
            		ResultSet resultSet = stmtVeh.executeQuery(strsql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();
			}
			else if(status.equalsIgnoreCase("PED"))
			{
				String sqlselect="";
				String sqlgroup="";
				if(summery.equalsIgnoreCase("CLT")){
	        		sqlselect=" ,ac.cldocno refno,ac.refname ";
	        		sqlgroup=" left join my_cutinvd d on m.doc_no=d.rdocno left join my_salm lm on m.sal_id=lm.doc_no left join my_ccentre c on m.costcode=c.doc_no "
	        				+ "left join my_acbook ac on m.acno=ac.acno left join my_main mm on d.psrno=mm.psrno where 1=1 and m.ftype=1 and (d.qty-d.out_qty)!=0 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by ac.cldocno";
	        	}
				else if(summery.equalsIgnoreCase("SAL")){
	        		sqlselect=" ,lm.doc_no refno,lm.sal_name refname ";
	        		sqlgroup=" left join my_cutinvd d on m.doc_no=d.rdocno left join my_ccentre c on m.costcode=c.doc_no left join my_salm lm on m.sal_id=lm.doc_no"
	        				+ " left join my_acbook ac on m.acno=ac.acno left join my_main mm on d.psrno=mm.psrno where 1=1 and m.ftype=1 and (d.qty-d.out_qty)!=0 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by lm.doc_no";
	        	}
				else if(summery.equalsIgnoreCase("PRJ")){
	        		sqlselect=" ,c.doc_no refno,c.description refname  ";
	        		sqlgroup=" left join my_cutinvd d on m.doc_no=d.rdocno left join my_ccentre c on m.costcode=c.doc_no left join my_salm lm on m.sal_id=lm.doc_no"
	        				+ " left join my_acbook ac on m.acno=ac.acno left join my_main mm on d.psrno=mm.psrno where 1=1 and m.ftype=1 and (d.qty-d.out_qty)!=0 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by c.doc_no";
	        	}
				
	        	else if(summery.equalsIgnoreCase("PRD")){
	        		sqlselect=" ,mm.psrno refno,mm.productname refname ";
	        		sqlgroup=" left join my_cutinvd d on m.doc_no=d.rdocno left join my_ccentre c on m.costcode=c.doc_no left join my_salm lm on m.sal_id=lm.doc_no "
	        				+ " left join my_acbook ac on m.acno=ac.acno left join my_main mm on d.psrno=mm.psrno where 1=1 and and m.ftype=1 (d.qty-d.out_qty)!=0 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by mm.psrno";
	        	}
	        	/*else if(grpby.equalsIgnoreCase("group")){
	        		sqlselect=" grp.doc_no refno,grp.gname description";
	        	}
	        	else if(grpby.equalsIgnoreCase("yom")){
	        		sqlselect=" yom.doc_no refno,yom.yom description";
	        	}*/
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
	 
					
					String strsql="select sum(nettotal) nettotal"+sqlselect+" from my_cutinvm m"+sqlgroup;
	            		
	       System.out.println("------sql-----"+strsql);
	            		ResultSet resultSet = stmtVeh.executeQuery(strsql);
	            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
	     				stmtVeh.close();
	     				
	            
	            	conn.close();
			}
		}
		 		if(type.equalsIgnoreCase("CICR")) 
				{
				if(status.equalsIgnoreCase("ALL"))
				{
				
				String sqlselect="";
				String sqlgroup="";
				if(summery.equalsIgnoreCase("CLT")){
	        		sqlselect=" ,ac.cldocno refno,ac.refname ";
	        		sqlgroup=" left join my_acbook ac on m.acno=ac.acno left join my_salm lm on m.sal_id=lm.doc_no "
	        				+ " left join my_cutinvd d on m.doc_no=d.rdocno left join my_main mm on d.psrno=mm.psrno left join my_ccentre c on m.costcode=c.doc_no where 1=1 and m.ftype=3 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by ac.cldocno";
	        	}
				else if(summery.equalsIgnoreCase("SAL")){
	        		sqlselect=" ,lm.doc_no refno,lm.sal_name refname ";
	        		sqlgroup=" left join my_acbook ac on m.acno=ac.acno left join my_salm lm on m.sal_id=lm.doc_no "
	        				+ " left join my_cutinvd d on m.doc_no=d.rdocno left join my_main mm on d.psrno=mm.psrno left join my_ccentre c on m.costcode=c.doc_no where 1=1 and m.ftype=3 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by lm.doc_no";
	        	}
				else if(summery.equalsIgnoreCase("PRJ")){
	        		sqlselect=" ,c.doc_no refno,c.description refname  ";
	        		sqlgroup="  left join my_acbook ac on m.acno=ac.acno left join my_salm lm on m.sal_id=lm.doc_no "
	        				+ " left join my_cutinvd d on m.doc_no=d.rdocno left join my_main mm on d.psrno=mm.psrno left join my_ccentre c on m.costcode=c.doc_no where 1=1 and m.ftype=3 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by c.doc_no";
	        	}
				
	        	else if(summery.equalsIgnoreCase("PRD")){
	        		sqlselect=" ,mm.psrno refno,mm.productname refname ";
	        		sqlgroup=" left join my_acbook ac on m.acno=ac.acno left join my_salm lm on m.sal_id=lm.doc_no "
	        				+ " left join my_cutinvd d on m.doc_no=d.rdocno left join my_main mm on d.psrno=mm.psrno left join my_ccentre c on m.costcode=c.doc_no where 1=1 and m.ftype=3 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by mm.psrno";
	        	}
	        	/*else if(grpby.equalsIgnoreCase("group")){
	        		sqlselect=" grp.doc_no refno,grp.gname description";
	        	}
	        	else if(grpby.equalsIgnoreCase("yom")){
	        		sqlselect=" yom.doc_no refno,yom.yom description";
	        	}*/
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
	 
					
					String strsql="select sum(nettotal) nettotal"+sqlselect+" from my_cutinvm m"+sqlgroup;
	            		
	       //System.out.println("------sql-----"+strsql);
	            		ResultSet resultSet = stmtVeh.executeQuery(strsql);
	            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
	     				stmtVeh.close();
	     				
	            
	            	conn.close();
				}
				else if(status.equalsIgnoreCase("PED"))
				{
					String sqlselect="";
					String sqlgroup="";
					if(summery.equalsIgnoreCase("CLT")){
		        		sqlselect=" ,ac.cldocno refno,ac.refname ";
		        		sqlgroup=" left join my_cutinvd d on m.doc_no=d.rdocno left join my_main mm on d.psrno=mm.psrno left join my_ccentre c on m.costcode=c.doc_no "
		        				+ "left join my_salm lm on m.sal_id=lm.doc_no left join my_acbook ac on m.acno=ac.acno where 1=1 and m.ftype=3 and (d.qty-d.out_qty)!=0 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by ac.cldocno";
		        	}
					else if(summery.equalsIgnoreCase("SAL")){
		        		sqlselect=" ,lm.doc_no refno,lm.sal_name refname ";
		        		sqlgroup=" left join my_cutinvd d on m.doc_no=d.rdocno left join my_main mm on d.psrno=mm.psrno left join my_ccentre c on m.costcode=c.doc_no "
		        				+ "left join my_salm lm on m.sal_id=lm.doc_no left join my_acbook ac on m.acno=ac.acno where 1=1 and m.ftype=3 and (d.qty-d.out_qty)!=0 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by lm.doc_no";
		        	}
					else if(summery.equalsIgnoreCase("PRJ")){
		        		sqlselect=" ,c.doc_no refno,c.description refname  ";
		        		sqlgroup=" left join my_cutinvd d on m.doc_no=d.rdocno left join my_main mm on d.psrno=mm.psrno left join my_ccentre c on m.costcode=c.doc_no "
		        				+ "left join my_salm lm on m.sal_id=lm.doc_no left join my_acbook ac on m.acno=ac.acno where 1=1 and m.ftype=3 and (d.qty-d.out_qty)!=0 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by c.doc_no";
		        	}
					
		        	else if(summery.equalsIgnoreCase("PRD")){
		        		sqlselect=" ,mm.psrno refno,mm.productname refname ";
		        		sqlgroup=" left join my_cutinvd d on m.doc_no=d.rdocno left join my_main mm on d.psrno=mm.psrno left join my_ccentre c on m.costcode=c.doc_no "
		        				+ "left join my_salm lm on m.sal_id=lm.doc_no left join my_acbook ac on m.acno=ac.acno where 1=1 and m.ftype=3 and (d.qty-d.out_qty)!=0 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by mm.psrno";
		        	}
		        	/*else if(grpby.equalsIgnoreCase("group")){
		        		sqlselect=" grp.doc_no refno,grp.gname description";
		        	}
		        	else if(grpby.equalsIgnoreCase("yom")){
		        		sqlselect=" yom.doc_no refno,yom.yom description";
		        	}*/
						 conn = ClsConnection.getMyConnection();
						Statement stmtVeh = conn.createStatement ();
		 
						
						String strsql="select sum(nettotal) nettotal"+sqlselect+" from my_cutinvm m"+sqlgroup;
		            		
		       //System.out.println("------sql-----"+strsql);
		            		ResultSet resultSet = stmtVeh.executeQuery(strsql);
		            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
		     				stmtVeh.close();
		     				
		            
		            	conn.close();
				}
			}
			else if(type.equalsIgnoreCase("CUO"))
			{
			if(status.equalsIgnoreCase("ALL"))
			{
			
			String sqlselect="";
			String sqlgroup="";
			if(summery.equalsIgnoreCase("CLT")){
        		sqlselect=" ,ac.cldocno refno,ac.refname ";
        		sqlgroup=" left join my_cord d on m.doc_no=d.rdocno left join my_salm lm on m.sal_id=lm.doc_no left join my_main mm on d.psrno=mm.psrno "
        				+ " left join my_acbook ac on m.acno=ac.acno left join my_ccentre c on m.costcode=c.doc_no where 1=1 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by ac.cldocno";
        	}
			else if(summery.equalsIgnoreCase("SAL")){
        		sqlselect=" ,lm.doc_no refno,lm.sal_name refname ";
        		sqlgroup=" left join my_cord d on m.doc_no=d.rdocno left join my_salm lm on m.sal_id=lm.doc_no left join my_main mm on d.psrno=mm.psrno "
        				+ " left join my_acbook ac on m.acno=ac.acno left join my_ccentre c on m.costcode=c.doc_no where 1=1 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by lm.doc_no";
        	}
			else if(summery.equalsIgnoreCase("PRJ")){
        		sqlselect=" ,c.doc_no refno,c.description refname  ";
        		sqlgroup=" left join my_cord d on m.doc_no=d.rdocno left join my_salm lm on m.sal_id=lm.doc_no left join my_main mm on d.psrno=mm.psrno "
        				+ " left join my_acbook ac on m.acno=ac.acno left join my_ccentre c on m.costcode=c.doc_no where 1=1 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by c.doc_no";
        	}
			
        	else if(summery.equalsIgnoreCase("PRD")){
        		sqlselect=" ,mm.psrno refno,mm.productname refname ";
        		sqlgroup=" left join my_cord d on m.doc_no=d.rdocno left join my_salm lm on m.sal_id=lm.doc_no left join my_main mm on d.psrno=mm.psrno "
        				+ " left join my_acbook ac on m.acno=ac.acno left join my_ccentre c on m.costcode=c.doc_no where 1=1 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by mm.psrno";
        	}
        	/*else if(grpby.equalsIgnoreCase("group")){
        		sqlselect=" grp.doc_no refno,grp.gname description";
        	}
        	else if(grpby.equalsIgnoreCase("yom")){
        		sqlselect=" yom.doc_no refno,yom.yom description";
        	}*/
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
 
				
				String strsql="select sum(amount) nettotal"+sqlselect+" from my_corm m"+sqlgroup;
				System.out.println(sqltest4);  		
       System.out.println("------1234finalsql-----"+strsql);
            		ResultSet resultSet = stmtVeh.executeQuery(strsql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();
			}
			else if(status.equalsIgnoreCase("PED"))
			{
				//System.out.println("qwertyu");
				String sqlselect="";
				String sqlgroup="";
				if(summery.equalsIgnoreCase("CLT")){
	        		sqlselect=" ,ac.cldocno refno,ac.refname ";
	        		sqlgroup=" left join my_cord d on m.doc_no=d.rdocno  left join my_acbook ac on m.acno=ac.acno left join my_salm lm on m.sal_id=lm.doc_no "
	        				+ " left join my_main mm on d.psrno=mm.psrno left join my_ccentre c on m.costcode=c.doc_no where 1=1 and (d.qty-d.out_qty)!=0 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by ac.cldocno";
	        	}
				else if(summery.equalsIgnoreCase("SAL")){
	        		sqlselect=" ,lm.doc_no refno,lm.sal_name refname ";
	        		sqlgroup=" left join my_cord d on m.doc_no=d.rdocno  left join my_acbook ac on m.acno=ac.acno left join my_salm lm on m.sal_id=lm.doc_no "
	        				+ " left join my_main mm on d.psrno=mm.psrno left join my_ccentre c on m.costcode=c.doc_no where 1=1 and (d.qty-d.out_qty)!=0 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by ac.cldocno group by lm.doc_no";
	        	}
				else if(summery.equalsIgnoreCase("PRJ")){
	        		sqlselect=" ,c.doc_no refno,c.description refname  ";
	        		sqlgroup=" left join my_cord d on m.doc_no=d.rdocno  left join my_acbook ac on m.acno=ac.acno left join my_salm lm on m.sal_id=lm.doc_no "
	        				+ " left join my_main mm on d.psrno=mm.psrno left join my_ccentre c on m.costcode=c.doc_no where 1=1 and (d.qty-d.out_qty)!=0 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by ac.cldocno group by c.doc_no";
	        	}
				
	        	else if(summery.equalsIgnoreCase("PRD")){
	        		sqlselect=" ,mm.psrno refno,mm.productname refname ";
	        		sqlgroup=" left join my_cord d on m.doc_no=d.rdocno  left join my_acbook ac on m.acno=ac.acno left join my_salm lm on m.sal_id=lm.doc_no "
	        				+ " left join my_main mm on d.psrno=mm.psrno left join my_ccentre c on m.costcode=c.doc_no where 1=1 and (d.qty-d.out_qty)!=0 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by ac.cldocno group by mm.psrno";
	        	}
	        	/*else if(grpby.equalsIgnoreCase("group")){
	        		sqlselect=" grp.doc_no refno,grp.gname description";
	        	}
	        	else if(grpby.equalsIgnoreCase("yom")){
	        		sqlselect=" yom.doc_no refno,yom.yom description";
	        	}*/
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
	 
					
					String strsql="select sum(amount) nettotal"+sqlselect+" from my_corm m"+sqlgroup;
	            		
	       System.out.println("-----pending-sql-----"+strsql);
	            		ResultSet resultSet = stmtVeh.executeQuery(strsql);
	            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
	     				stmtVeh.close();
	     				
	            
	            	conn.close();
			}
		}
			
			else if(type.equalsIgnoreCase("DEN"))
			{
			if(status.equalsIgnoreCase("ALL"))
			{
			
			String sqlselect="";
			String sqlgroup="";
			if(summery.equalsIgnoreCase("CLT")){
        		sqlselect=" ,ac.cldocno refno,ac.refname ";
        		sqlgroup=" left join my_dlyd d on m.doc_no=d.rdocno left join my_main mm on d.psrno=mm.psrno left join my_ccentre c on m.costcode=c.doc_no "
        				+ "left join my_salm lm on m.sal_id=lm.doc_no left join my_acbook ac on m.acno=ac.acno where 1=1 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by ac.cldocno";
        	}
			else if(summery.equalsIgnoreCase("SAL")){
        		sqlselect=" ,lm.doc_no refno,lm.sal_name refname ";
        		sqlgroup=" left join my_dlyd d on m.doc_no=d.rdocno left join my_main mm on d.psrno=mm.psrno left join my_ccentre c on m.costcode=c.doc_no "
        				+ "left join my_salm lm on m.sal_id=lm.doc_no left join my_acbook ac on m.acno=ac.acno where 1=1 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by lm.doc_no";
        	}
			else if(summery.equalsIgnoreCase("PRJ")){
        		sqlselect=" ,c.doc_no refno,c.description refname  ";
        		sqlgroup=" left join my_dlyd d on m.doc_no=d.rdocno left join my_main mm on d.psrno=mm.psrno left join my_ccentre c on m.costcode=c.doc_no "
        				+ "left join my_salm lm on m.sal_id=lm.doc_no left join my_acbook ac on m.acno=ac.acno where 1=1 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by c.doc_no";
        	}
			
        	else if(summery.equalsIgnoreCase("PRD")){
        		sqlselect=" ,mm.psrno refno,mm.productname refname ";
        		sqlgroup=" left join my_dlyd d on m.doc_no=d.rdocno left join my_main mm on d.psrno=mm.psrno left join my_ccentre c on m.costcode=c.doc_no "
        				+ "left join my_salm lm on m.sal_id=lm.doc_no left join my_acbook ac on m.acno=ac.acno where 1=1 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by mm.psrno";
        	}
        	/*else if(grpby.equalsIgnoreCase("group")){
        		sqlselect=" grp.doc_no refno,grp.gname description";
        	}
        	else if(grpby.equalsIgnoreCase("yom")){
        		sqlselect=" yom.doc_no refno,yom.yom description";
        	}*/
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
 
				
				String strsql="select sum(amount) nettotal"+sqlselect+" from my_dlym m"+sqlgroup;
            		
       System.out.println("------finalsql-----"+strsql);
            		ResultSet resultSet = stmtVeh.executeQuery(strsql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();
			}
			else if(status.equalsIgnoreCase("PED"))
			{
				//System.out.println("qwertyu");
				String sqlselect="";
				String sqlgroup="";
				if(summery.equalsIgnoreCase("CLT")){
	        		sqlselect=" ,ac.cldocno refno,ac.refname ";
	        		sqlgroup=" left join my_dlyd d on m.doc_no=d.rdocno left join my_main mm on d.psrno=mm.psrno left join my_ccentre c on m.costcode=c.doc_no"
	        				+ " left join my_salm lm on m.sal_id=lm.doc_no left join my_acbook ac on m.acno=ac.acno where 1=1 and (d.qty-d.out_qty)!=0 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by ac.cldocno";
	        	}
				else if(summery.equalsIgnoreCase("SAL")){
	        		sqlselect=" ,lm.doc_no refno,lm.sal_name refname ";
	        		sqlgroup=" left join my_dlyd d on m.doc_no=d.rdocno left join my_main mm on d.psrno=mm.psrno left join my_ccentre c on m.costcode=c.doc_no"
	        				+ " left join my_salm lm on m.sal_id=lm.doc_no left join my_acbook ac on m.acno=ac.acno where 1=1 and (d.qty-d.out_qty)!=0 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by lm.doc_no";
	        	}
				else if(summery.equalsIgnoreCase("PRJ")){
	        		sqlselect=" ,c.doc_no refno,c.description refname  ";
	        		sqlgroup=" left join my_dlyd d on m.doc_no=d.rdocno left join my_main mm on d.psrno=mm.psrno left join my_ccentre c on m.costcode=c.doc_no"
	        				+ " left join my_salm lm on m.sal_id=lm.doc_no left join my_acbook ac on m.acno=ac.acno where 1=1 and (d.qty-d.out_qty)!=0 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by c.doc_no";
	        	}
				
	        	else if(summery.equalsIgnoreCase("PRD")){
	        		sqlselect=" ,mm.psrno refno,mm.productname refname ";
	        		sqlgroup=" left join my_dlyd d on m.doc_no=d.rdocno left join my_main mm on d.psrno=mm.psrno left join my_ccentre c on m.costcode=c.doc_no"
	        				+ " left join my_salm lm on m.sal_id=lm.doc_no left join my_acbook ac on m.acno=ac.acno where 1=1 and (d.qty-d.out_qty)!=0 "+sqlcommon+" "+sqltest1+" "+sqltest2+" "+sqltest3+" "+sqltest4+" group by mm.psrno";
	        	}
	        	/*else if(grpby.equalsIgnoreCase("group")){
	        		sqlselect=" grp.doc_no refno,grp.gname description";
	        	}
	        	else if(grpby.equalsIgnoreCase("yom")){
	        		sqlselect=" yom.doc_no refno,yom.yom description";
	        	}*/
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
	 
					
					String strsql="select sum(amount) nettotal"+sqlselect+" from my_dlym m"+sqlgroup;
	            		
	       System.out.println("-----pending-sql-----"+strsql);
	            		ResultSet resultSet = stmtVeh.executeQuery(strsql);
	            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
	     				stmtVeh.close();
	     				
	            
	            	conn.close();
			}
		}
			
			
		}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	

	
	
	
	
	
	
	
	
	
public   JSONArray accountsDetails(HttpSession session,String accountno,String accountname,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = ClsConnection.getMyConnection();
		       Statement stmt = conn.createStatement();
	
		    
	   
	           if(check.equalsIgnoreCase("1")){
	        	   
		        String sqltest="";
		        String sql="";
		 
		           
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		           sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        	
		        sql="select   t.description,t.doc_no,t.account from my_head t  where t.atype='AP' and t.m_s=0 "+sqltest+" ";
		        
		     
		        
		       ResultSet resultSet = stmt.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
	 
		       }
		      stmt.close();
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

public   JSONArray nipurchasedatailsReportsexcel(String barchval,String fromdate,String todate,String type,String status,String cldocno,String psrno,String pdocno,String salid) throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
    
    java.sql.Date sqlfromdate = null;
    String sqlcommon="";
 	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
 	{
 		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
 		
 	}
 	else{
 
 	}

    java.sql.Date sqltodate = null;
 	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
 	{
 		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
 		
 	}
 	else{
 
 	}
	if(sqlfromdate!=null){
		sqlcommon+=" and m.date>='"+sqlfromdate+"'";
	}
	if(sqltodate!=null){
		sqlcommon+=" and m.date<='"+sqltodate+"'";
	}
 	String sqltest="";
 	String sqltest1="";
 	String sqltest2="";
 	String sqltest3="";
 	String sqltest4="";
 	
   
 	
    
	
	if(!((barchval.equalsIgnoreCase("a")) || (barchval.equalsIgnoreCase("NA")) || (barchval.equalsIgnoreCase("0")))){
		sqlcommon+=" and m.brhid='"+barchval+"'";
		}
	if(!((cldocno.equalsIgnoreCase("")) || (cldocno.equalsIgnoreCase("NA")) || (cldocno.equalsIgnoreCase("0")))){
		sqltest1+=" and ac.cldocno='"+cldocno+"'";
		}
	if(!((psrno.equalsIgnoreCase("")) || (psrno.equalsIgnoreCase("NA")) || (psrno.equalsIgnoreCase("0")))){
		sqltest1+=" and mn.psrno='"+psrno+"'";
		}
	if(!((pdocno.equalsIgnoreCase("")) || (pdocno.equalsIgnoreCase("NA")) || (pdocno.equalsIgnoreCase("0")))){
		sqltest1+=" and c.costcode='"+pdocno+"'";
		}
	if(!((salid.equalsIgnoreCase("")) || (salid.equalsIgnoreCase("NA")) || (salid.equalsIgnoreCase("0")))){
		sqltest1+=" and sm.doc_no='"+salid+"'";
		}
	
 	Connection conn = null;


    
 	try {
	 	if(!((type.equalsIgnoreCase("")) || (type.equalsIgnoreCase("NA")) || (type.equalsIgnoreCase("0")))){
		
	 		if(type.equalsIgnoreCase("CICA")) 
		{
		if(status.equalsIgnoreCase("ALL"))
		{
		
		String sqlselect="";
		String sqlgroup="";
		
    	/*else if(grpby.equalsIgnoreCase("group")){
    		sqlselect=" grp.doc_no refno,grp.gname description";
    	}
    	else if(grpby.equalsIgnoreCase("yom")){
    		sqlselect=" yom.doc_no refno,yom.yom description";
    	}*/
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();

			
			String strsql="select m.doc_no Doc_no,m.date Date,c.description Jobname,sm.sal_name Salesman,ac.refname Client,m.lpono Lpo_No,mn.part_no Productcode,mn.productname Product_Name,round(d.qty,2) Qty,"
					+ " round((qty-out_qty),2) Pending,d.sqm SQM,d.price Price,sum(m.nettotal) Nettotal from my_cutinvm m left join my_cutinvd d on m.doc_no=d.rdocno"
					+ " left join my_ccentre c on m.costcode=c.doc_no left join my_salm sm on sm.doc_no=m.sal_id left join my_acbook ac on m.acno=ac.acno "
					+ " left join my_main mn on mn.psrno=d.psrno where 1=1 and m.ftype=1 "+sqlcommon+" "+sqltest1+" group by m.doc_no";
        		
   //System.out.println("------12345678-----"+strsql);
        		ResultSet resultSet = stmtVeh.executeQuery(strsql);
        		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
 				stmtVeh.close();
 				
        
        	conn.close();
		}
		else if(status.equalsIgnoreCase("PED"))
		{
			String sqlselect="";
			String sqlgroup="";
			
        	/*else if(grpby.equalsIgnoreCase("group")){
        		sqlselect=" grp.doc_no refno,grp.gname description";
        	}
        	else if(grpby.equalsIgnoreCase("yom")){
        		sqlselect=" yom.doc_no refno,yom.yom description";
        	}*/
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
 
				
				String strsql="select m.doc_no Doc_No,m.date Date,c.description Jobname,sm.sal_name Salesman,ac.refname Client,m.lpono Lpo_No,mn.part_no Productcode,mn.productname Product_Name,round(d.qty,2) Qty,"
						+ " round((qty-out_qty),2) Pending,d.sqm SQM,d.price Price,sum(m.nettotal) Nettotal from my_cutinvm m left join my_cutinvd d on m.doc_no=d.rdocno"
						+ " left join my_ccentre c on m.costcode=c.doc_no left join my_salm sm on sm.doc_no=m.sal_id left join my_acbook ac on m.acno=ac.acno "
						+ " left join my_main mn on mn.psrno=d.psrno where 1=1 and m.ftype=1 and (qty-out_qty)!=0 "+sqlcommon+" "+sqltest1+" group by m.doc_no";
            		
       //System.out.println("------pendsql-----"+strsql);
            		ResultSet resultSet = stmtVeh.executeQuery(strsql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();
		}
	}
	 		if(type.equalsIgnoreCase("CICR")) 
			{
			if(status.equalsIgnoreCase("ALL"))
			{
			
			String sqlselect="";
			String sqlgroup="";
			
        	/*else if(grpby.equalsIgnoreCase("group")){
        		sqlselect=" grp.doc_no refno,grp.gname description";
        	}
        	else if(grpby.equalsIgnoreCase("yom")){
        		sqlselect=" yom.doc_no refno,yom.yom description";
        	}*/
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
 
				
				String strsql="select m.doc_no Doc_No,m.date Date,c.description Jobname,sm.sal_name Salesman,ac.refname Client,m.lpono Lpo_No,mn.part_no Productcode,mn.productname Product_Name,round(d.qty,2) Qty,"
						+ " round((qty-out_qty),2) Pending,d.sqm SQM,d.price Price,sum(m.nettotal) Nettotal from my_cutinvm m left join my_cutinvd d on m.doc_no=d.rdocno"
						+ " left join my_ccentre c on m.costcode=c.doc_no left join my_salm sm on sm.doc_no=m.sal_id left join my_acbook ac on m.acno=ac.acno "
						+ " left join my_main mn on mn.psrno=d.psrno where 1=1 and m.ftype=3 "+sqlcommon+" "+sqltest1+" group by m.doc_no";
	        		
            		
       //System.out.println("------sql-----"+strsql);
            		ResultSet resultSet = stmtVeh.executeQuery(strsql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();
			}
			else if(status.equalsIgnoreCase("PED"))
			{
				String sqlselect="";
				String sqlgroup="";
				
	        	/*else if(grpby.equalsIgnoreCase("group")){
	        		sqlselect=" grp.doc_no refno,grp.gname description";
	        	}
	        	else if(grpby.equalsIgnoreCase("yom")){
	        		sqlselect=" yom.doc_no refno,yom.yom description";
	        	}*/
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
	 
					
					String strsql="select m.doc_no Doc_No,m.date Date,c.description Jobname,sm.sal_name Salesman,ac.refname Client,m.lpono Lpo_No,mn.part_no Productcode,mn.productname Product_Name,round(d.qty,2) Qty,"
							+ " round((qty-out_qty),2) Pending,d.sqm SQM,d.price Price,sum(m.nettotal) Nettotal from my_cutinvm m left join my_cutinvd d on m.doc_no=d.rdocno"
							+ " left join my_ccentre c on m.costcode=c.doc_no left join my_salm sm on sm.doc_no=m.sal_id left join my_acbook ac on m.acno=ac.acno "
							+ " left join my_main mn on mn.psrno=d.psrno where 1=1 and m.ftype=3 and (qty-out_qty)!=0 "+sqlcommon+" "+sqltest1+" group by m.doc_no";
	            		
	            		
	       //System.out.println("------sql-----"+strsql);
	            		ResultSet resultSet = stmtVeh.executeQuery(strsql);
	            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
	     				stmtVeh.close();
	     				
	            
	            	conn.close();
			}
		}
		else if(type.equalsIgnoreCase("CUO"))
		{
		if(status.equalsIgnoreCase("ALL"))
		{
		
		String sqlselect="";
		String sqlgroup="";
		    	/*else if(grpby.equalsIgnoreCase("group")){
    		sqlselect=" grp.doc_no refno,grp.gname description";
    	}
    	else if(grpby.equalsIgnoreCase("yom")){
    		sqlselect=" yom.doc_no refno,yom.yom description";
    	}*/
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();

			
			String strsql="select m.doc_no Doc_no,m.date Date,c.description Jobname,sm.sal_name Salesman,ac.refname Client,m.lpono Lpo_No,mn.part_no Productcode,mn.productname Product_Name,round(d.qty,2) Qty,"
					+ " round((qty-out_qty),2) Pending,d.sqm SQM,d.price Price,sum(d.amount) Nettotal from my_corm m left join my_cord d on m.doc_no=d.rdocno"
					+ " left join my_ccentre c on m.costcode=c.doc_no left join my_salm sm on sm.doc_no=m.sal_id left join my_acbook ac on m.acno=ac.acno "
					+ " left join my_main mn on mn.psrno=d.psrno where 1=1 "+sqlcommon+" "+sqltest1+" group by m.doc_no";
        		
        		
   //System.out.println("------finalsql-----"+strsql);
        		ResultSet resultSet = stmtVeh.executeQuery(strsql);
        		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
 				stmtVeh.close();
 				
        
        	conn.close();
		}
		else if(status.equalsIgnoreCase("PED"))
		{
			//System.out.println("qwertyu");
			String sqlselect="";
			String sqlgroup="";
			
        	/*else if(grpby.equalsIgnoreCase("group")){
        		sqlselect=" grp.doc_no refno,grp.gname description";
        	}
        	else if(grpby.equalsIgnoreCase("yom")){
        		sqlselect=" yom.doc_no refno,yom.yom description";
        	}*/
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
 
				
				String strsql="select m.doc_no Doc_No,m.date Date,c.description Jobname,sm.sal_name Salesman,ac.refname Client,m.lpono Lpo_No,mn.part_no Productcode,mn.productname Product_name,round(d.qty,2) Qty,"
						+ " round((qty-out_qty),2) Pending,d.sqm SQM,d.price Price,sum(d.amount) Nettotal from my_corm m left join my_cord d on m.doc_no=d.rdocno"
						+ " left join my_ccentre c on m.costcode=c.doc_no left join my_salm sm on sm.doc_no=m.sal_id left join my_acbook ac on m.acno=ac.acno "
						+ " left join my_main mn on mn.psrno=d.psrno where 1=1 and (d.qty-out_qty)!=0 "+sqlcommon+" "+sqltest1+" group by m.doc_no";
	        		
            		
       //System.out.println("-----pending-sql-----"+strsql);
            		ResultSet resultSet = stmtVeh.executeQuery(strsql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();
		}
	}
		
		else if(type.equalsIgnoreCase("DEN"))
		{
		if(status.equalsIgnoreCase("ALL"))
		{
		
		String sqlselect="";
		String sqlgroup="";
		
    	/*else if(grpby.equalsIgnoreCase("group")){
    		sqlselect=" grp.doc_no refno,grp.gname description";
    	}
    	else if(grpby.equalsIgnoreCase("yom")){
    		sqlselect=" yom.doc_no refno,yom.yom description";
    	}*/
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();

			
			String strsql="select m.doc_no Doc_No,m.date Date,c.description Jobname,sm.sal_name Salesman,ac.refname Client,m.lpono Lpo_No,mn.part_no Productcode,mn.productname Product_Name,round(d.qty,2) Qty,"
					+ " round((qty-out_qty),2) Pending,d.sqm SQM,d.price Price,sum(d.amount) Nettotal from my_dlym m left join my_dlyd d on m.doc_no=d.rdocno"
					+ " left join my_ccentre c on m.costcode=c.doc_no left join my_salm sm on sm.doc_no=m.sal_id left join my_acbook ac on m.acno=ac.acno "
					+ " left join my_main mn on mn.psrno=d.psrno where 1=1 "+sqlcommon+" "+sqltest1+" group by m.doc_no";
        		
        		
  // System.out.println("------finalsql-----"+strsql);
        		ResultSet resultSet = stmtVeh.executeQuery(strsql);
        		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
 				stmtVeh.close();
 				
        
        	conn.close();
		}
		else if(status.equalsIgnoreCase("PED"))
		{
			//System.out.println("qwertyu");
			String sqlselect="";
			String sqlgroup="";
			
        	/*else if(grpby.equalsIgnoreCase("group")){
        		sqlselect=" grp.doc_no refno,grp.gname description";
        	}
        	else if(grpby.equalsIgnoreCase("yom")){
        		sqlselect=" yom.doc_no refno,yom.yom description";
        	}*/
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
 
				
				String strsql="select m.doc_no Doc_no,m.date Date,c.description Jobname,sm.sal_name Salesman,ac.refname Client,m.lpono Lpo_No,mn.part_no Productcode,mn.productname Product_Name,round(d.qty,2) Qty,"
						+ " round((qty-out_qty),2) Pending,d.sqm SQM,d.price Price,sum(d.amount) Nettotal from my_dlym m left join my_dlyd d on m.doc_no=d.rdocno"
						+ " left join my_ccentre c on m.costcode=c.doc_no left join my_salm sm on sm.doc_no=m.sal_id left join my_acbook ac on m.acno=ac.acno "
						+ " left join my_main mn on mn.psrno=d.psrno where 1=1 and (d.qty-out_qty)!=0 "+sqlcommon+" "+sqltest1+" group by m.doc_no";
	        		
            		
      /* System.out.println("-----pending-sql-----"+strsql);*/
            		ResultSet resultSet = stmtVeh.executeQuery(strsql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();
		}
	}
		
		
	}
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	//System.out.println(RESULTDATA);
    return RESULTDATA;
}
	
public   JSONArray ginReports(String barchval,String fromdate,String todate,String psrno,String aa) throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
    if(!(aa.equalsIgnoreCase("yes")))
    		{
    	return RESULTDATA;
    		}
    
    
    
    java.sql.Date sqlfromdate = null;
    String sqlcommon="";
    String sqlcomm="";
 	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
 	{
 		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
 		
 	}
 	else{
 
 	}

    java.sql.Date sqltodate = null;
 	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
 	{
 		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
 		
 	}
 	else{
 
 	}
	if(sqlfromdate!=null){
		sqlcommon+=" and m.date>='"+sqlfromdate+"'";
	}
	if(sqltodate!=null){
		sqlcommon+=" and m.date<='"+sqltodate+"'";
	}
	if(sqlfromdate!=null){
		sqlcomm+=" and o.date>='"+sqlfromdate+"'";
	}
	if(sqltodate!=null){
		sqlcomm+=" and o.date<='"+sqltodate+"'";
	}
 	String sqltest="";
 	String sqltest1="";
 	String sqltest2="";
 	String sqltest3="";
 	String sqltest4="";
 	
   
 	
    
	
	
	if(!((psrno.equalsIgnoreCase("")) || (psrno.equalsIgnoreCase("NA")) || (psrno.equalsIgnoreCase("0")))){
		sqltest1+=" and ma.psrno='"+psrno+"'";
		sqltest+=" and o.psrno='"+psrno+"'";
		}
	
 	Connection conn = null;


    
 	try {
	 	
		
		String sqlselect="";
		String sqlgroup="";
		
    	/*else if(grpby.equalsIgnoreCase("group")){
    		sqlselect=" grp.doc_no refno,grp.gname description";
    	}
    	else if(grpby.equalsIgnoreCase("yom")){
    		sqlselect=" yom.doc_no refno,yom.yom description";
    	}*/
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement ();

			
			String strsql="select m.date date,m.doc_no gisno,case when m.costtype in(1,6) then m.costdocno "
					+ " when m.costtype in(3,4) then co.doc_no "
+" when m.costtype in(5) then cs.doc_no when m.costtype in(9) then jo.voc_no  end as 'jobno',ac.refname client,o.voc_no lpono,ac1.refname vendor,um.unit,ma.part_no product,ma.productname,bd.brandname brand,cat.category,"
					+ " scat.subcategory"
					+ " , d.qty,round(coalesce(o.cost_price,0),2) amount from my_gism m " 
+" left join my_gisd d on m.doc_no=d.rdocno "
 +" LEFT JOIN (select sum(o.qty*o.cost_price) cost_price ,o.tr_no,o.psrno, case when pin.dtype='PIV' "
 +" then m.VOC_no when pin.dtype='GRN' then m1.VOC_no else 0 end as VOC_no,pin.dtype,case when pin.dtype='PIV' "
 +" then m.acno when pin.dtype='GRN' then m1.acno else 0 end as acno  from my_prddout o "
 +" left join my_prddin pin on pin.stockid=o.stockid "
+" left join my_srvm m on  m.tr_no=pin.tr_no and pin.dtype='PIV' "
+" left join my_grnm m1 on  m1.tr_no=pin.tr_no and pin.dtype='GRN' where 1=1 "+sqltest+" "+sqlcomm+" group by o.tr_no,o.psrno) o on  o.tr_no=d.tr_no and d.psrno=o.psrno "
+"  left join my_acbook ac on m.cldocno=ac.cldocno and ac.dtype='crm' "
+ " left join my_acbook ac1 on o.acno=ac1.acno "
+ "left join my_costunit u on u.costtype=m.costtype left join my_ccentre c on c.costcode=m.costdocno and m.costtype=1 "
+ "left join cm_srvcontrm co on co.tr_no=m.costdocno and m.costtype in(3,4) "
+" left join cm_cuscallm cs on cs.tr_no=m.costdocno and m.costtype=5"
+ " left join ws_jobcard jo on jo.doc_no=m.costdocno and m.costtype in (9) "
+" left join my_main ma on(d.psrno=ma.doc_no and d.prdid=ma.psrno) "
+" left join  my_unitm um on(d.unitid=um.doc_no) left join my_catm cat on cat.doc_no=ma.catid left join my_scatm scat on scat.doc_no=ma.scatid "
+" left join  my_brand bd on ma.brandid=bd.doc_no where m.status=3 and 1=1 "+sqlcommon+" "+sqltest1+" group by d.tr_no,d.psrno  ";
        		
System.out.println("------12345678-----"+strsql);
        		ResultSet resultSet = stmtVeh.executeQuery(strsql);
        		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
 				stmtVeh.close();
 				
        
        	conn.close();
		
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	//System.out.println(RESULTDATA);
    return RESULTDATA;
}
	




public JSONArray accountDetails(String client,String cldocno,String check) throws SQLException {
    Connection conn=null;
   System.out.println("sdfrefgfrerdfgd"+cldocno);
    JSONArray RESULTDATA1=new JSONArray();
    if(!(check.equalsIgnoreCase("1"))){
    	return RESULTDATA1;
    }
    try {
    	    conn = ClsConnection.getMyConnection();
	        Statement stmtClient = conn.createStatement();
		
    	    String sql1 = "";
    	    String sql = "";
    	  
        	
			
			
    	    if(!(client.equalsIgnoreCase(""))){
                sql1=sql1+" and a.refname like '%"+client+"%'";
            }
            if(!(cldocno.equalsIgnoreCase(""))){
             sql1=sql1+" and a.cldocno like '%"+cldocno+"%'";
            }
           
            
			sql = "select a.refname,a.cldocno from my_acbook a where  a.status<>7 and dtype='crm'"+sql1;
			
			//System.out.println(sql);
			
			ResultSet resultSet1 = stmtClient.executeQuery(sql);
			
			RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
			
			stmtClient.close();
			conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
    return RESULTDATA1;
}

public JSONArray productSearch(HttpSession session,String docnos,String prdid,String prdname,String load) throws SQLException {


	JSONArray RESULTDATA=new JSONArray();

	Connection conn = null;

	try {
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		String sql1="";
	
		
		if(!((prdid.equalsIgnoreCase("")) || (prdid.equalsIgnoreCase("NA")))){
			sql1+=" and m.part_no like'%"+prdid+"%' ";
 		}
		if(!((prdname.equalsIgnoreCase("")) || (prdname.equalsIgnoreCase("NA")))){
			sql1+=" and m.productname like '%"+prdname+"%' ";
 		}
		
		if(load.equalsIgnoreCase("yes"))
				{
		
	 
			    	
		String sql="select m.psrno doc_no,m.part_no prodcode,m.productname prodname,um.unit from my_main m inner join my_brand b on(m.brandid=b.doc_no)"
				+ "inner join my_catm c on(m.catid=c.doc_no) inner join my_scatm s on(m.scatid=s.doc_no) left join my_desc de on(de.psrno=m.doc_no)    "
				+ " left join my_unit u on(u.psrno=m.psrno) left join my_unitm um on(um.doc_no=u.unit)  where m.status=3  and de.discontinued=0 "+sql1+ "group by m.doc_no  ";
	//	System.out.println("==productSearch==="+sql);
		ResultSet resultSet = stmt.executeQuery(sql);
		RESULTDATA=ClsCommon.convertToJSON(resultSet);
				}

	}catch(Exception e){
		e.printStackTrace();

	}finally{
		conn.close();
	}
	return RESULTDATA;
}
	
public JSONArray salmdetails() throws SQLException {

    JSONArray RESULTDATA=new JSONArray();
    
    Connection conn =null;
    try {
		 conn = ClsConnection.getMyConnection();
		 Statement stmtVeh = conn.createStatement ();
		
		String sql="select doc_no docno,sal_name salm from my_salm  order by doc_no";
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


}
