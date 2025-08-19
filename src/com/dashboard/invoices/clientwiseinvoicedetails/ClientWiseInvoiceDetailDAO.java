package com.dashboard.invoices.clientwiseinvoicedetails;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClientWiseInvoiceDetailDAO {
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray clientDetailsSearch() throws SQLException {
	JSONArray RESULTDATA=new JSONArray();
	    
	Connection conn = null;
    
	  try {
	    conn = ClsConnection.getMyConnection();
	    Statement stmtSailk = conn.createStatement ();
	    
	    String sql = "";
		
		sql = "select cldocno,refname from my_acbook where status=3 and dtype='CRM'";
		
		ResultSet resultSet = stmtSailk.executeQuery(sql);
	                
	    RESULTDATA=ClsCommon.convertToJSON(resultSet);
	    stmtSailk.close();
	    conn.close();
	
	  }
	  catch(Exception e){
		  e.printStackTrace();
		  conn.close();
	  }
	  return RESULTDATA;
	}
	
	/*public JSONArray agreementSearch(String branch, String sclname,String smob,String rno,String flno,String sregno,String rentaltype) throws SQLException {

    	JSONArray RESULTDATA=new JSONArray();
    	String sqltest="";
    	
    
    	
    	
    	if(rentaltype.equalsIgnoreCase("RAG"))
    	{

        
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqltest+=" and r.brhid="+branch+"";
    		}
        	
        	if(!(sclname.equalsIgnoreCase(""))){
        		sqltest+=" and a.RefName like '%"+sclname+"%'";
        	}
        	if(!(smob.equalsIgnoreCase(""))){
        		sqltest+=" and a.per_mob like '%"+smob+"%'";
        	}
        	if(!(rno.equalsIgnoreCase(""))){
        		sqltest+=" and r.voc_no like '%"+rno+"%'";
        	}
        	if(!(flno.equalsIgnoreCase(""))){
        		sqltest+=" and r.fleet_no like '%"+flno+"%'";
        	}
        	if(!(sregno.equalsIgnoreCase(""))){
        		sqltest+=" and v.reg_no like '%"+sregno+"%'";
        	}
    
    	}
    	
    	else if(rentaltype.equalsIgnoreCase("LAG"))
    	{
    		
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqltest+=" and l.brhid="+branch+"";
    		}
        	
        	if(!(sclname.equalsIgnoreCase(""))){
        		sqltest+=" and a.RefName like '%"+sclname+"%'";
        	}
        	if(!(smob.equalsIgnoreCase(""))){
        		sqltest+=" and a.per_mob like '%"+smob+"%'";
        	}
        	if(!(rno.equalsIgnoreCase(""))){
        		sqltest+=" and l.voc_no like '%"+rno+"%'";
        	}
        	if(!(flno.equalsIgnoreCase(""))){
        		sqltest+=" and (l.tmpfleet like '%"+flno+"%' or l.perfleet like '%"+flno+"%')";
        	}
        	if(!(sregno.equalsIgnoreCase(""))){
        		sqltest+=" and v.reg_no like '%"+sregno+"%'";
        	}
    		
    		
    	}
    	
    	Connection conn=null;
     
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtinv = conn.createStatement();
				if(rentaltype.equalsIgnoreCase("RAG"))
		    	{
				String sql=("select r.voc_no,r.doc_no,r.fleet_no,a.RefName,a.per_mob,v.reg_no from gl_ragmt r left join gl_vehmaster v on v.fleet_no=r.fleet_no "
						+ " left join my_acbook a on a.cldocno= r.cldocno and a.dtype='CRM'where r.status=3 "+sqltest+" group by doc_no");
				
			
				
				ResultSet resultSet = stmtinv.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
			
				
		    	}
				else if(rentaltype.equalsIgnoreCase("LAG"))
		    	{
					
					String sql=("select  l.voc_no,l.doc_no,if(l.perfleet=0,l.tmpfleet,l.perfleet) fleet_no,a.RefName,a.per_mob,v.reg_no from gl_lagmt l left join gl_vehmaster v on v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet)  "
							+ " left join my_acbook a on a.cldocno= l.cldocno and a.dtype='CRM' where l.status=3 "+sqltest+" group by doc_no");	
					
				
					ResultSet resultSet = stmtinv.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					
					
		    	}
				stmtinv.close();
				conn.close();
		    	
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
*/ public JSONArray invoicelist(String branchval,String fromdate,String todate,String cldocno) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        java.sql.Date sqlfromdate = null;
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
	     	
	      	
        	String sqltest="";
        	String sqltest1="";
	    	if(!(cldocno.equalsIgnoreCase("")|| cldocno.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and a.cldocno="+cldocno+"";
	    	}
	    	
	      	if(!((branchval.equalsIgnoreCase("a")) || (branchval.equalsIgnoreCase("NA")))){
	 			sqltest+=" and m.brhid="+branchval+"";
	 		}
	  
	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
					
					String sql1 ="select method from gl_config where field_nme='indian' ";
            		ResultSet re = stmtVeh.executeQuery(sql1);
            		
				int company=0;	
				int chk=1;
				
				if(re.next())
	            
				{
					company=re.getInt("method");
				}
				company=1;
				if(company==1)
				{
					chk=0;
					
					sqltest1=sqltest1+ " vat , ";
				}
				
				else
				{
					chk=1;
					sqltest+=" and inv.status=3 ";		
					
				}
				
					
				Statement stmtindian=conn.createStatement();
				String strindian="select method from gl_config where field_nme='indian'";
				ResultSet rsindian=stmtindian.executeQuery(strindian);
				int indian=0;
				while(rsindian.next()){
					indian=rsindian.getInt("method");
				}
				String sqlvocno="";
				if(indian==1){
					sqlvocno="concat(br.branch,'/',year(inv.date),'/',inv.voc_no)";
				}
				else{
					sqlvocno="inv.voc_no";
				}
				String strshowfleet="select method from gl_config where field_nme='invListShowFleet'";
				int showfleet=0;
				ResultSet rsshowfleet=stmtindian.executeQuery(strshowfleet);
				while(rsshowfleet.next()){
					showfleet=rsshowfleet.getInt("method");
				}
				String showfleetcolumn="";
				if(showfleet==1){
					showfleetcolumn="l.perfleet,";
				}
	         /*   			String sql ="select  m.date,m.status,convert("+sqlvocno+",char(25)) doc_no,h.description acname,h.account acno,m.ratype,if(m.ratype='RAG',r.voc_no,
	          * l.voc_no) rano,m.cldocno,a.refname,m.fromdate,m.todate,convert(coalesce(sum(d.total),''),char(50)) amount , "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=1),' '),char(50)) rent, "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=17),''),char(50)) inschg, "
	            				+ "convert(coalesce((select  sum(total) from gl_invd where rdocno=m.doc_no and chid=2),''),char(50)) accchg, "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (8,14)),''),char(50)) salik, "
	            				+ "convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (9,15)),' '),char(50)) traffic , "+sqltest1 +" "
	            				+ " convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (3,4,5,6,7,10,11,12,13,16,18,19,21)),' '),char(50)) 
	            				other , ms.sal_name,"
	            				+ " if(m.ratype='RAG',r.mrano,l.manualra) mrano ,'"+chk+"' chk "
	            				+ " from gl_invm m left join gl_invd d on m.doc_no=d.rdocno "
	            				+ " left join my_acbook a on a.doc_no=m.cldocno and a.dtype='CRM' left join gl_lagmt l on l.doc_no=m.rano AND M.RATYPE='LAG'"
	            				+ " left join gl_ragmt r on r.doc_no=m.rano AND M.RATYPE='RAG' left join my_head h on h.doc_no=m.acno left join my_brch br on 
	            				m.brhid=br.doc_no left join my_salm ms on ms.doc_no=r.salid or ms.doc_no=l.salid  where  "
	            				+ "  m.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest +" group by d.rdocno order by m.doc_no";
	         */
				
				//Fetching data from view instead direct from db;
				String sql=" select aa.fleet_no fleet_no,aa.pono pono,aa.invnote description,aa.rentalvocno agmtno,aa.clientname client,aa.rentno rentalinvno,aa.rentdte rentaldate,aa.rentchg rentamt,if(aa.tax=1 and aa.rentdte>='2018-01-01',aa.renttax,0) renttax,"
						+" if(aa.tax=1 and aa.rentdte>='2018-01-01',sum(aa.rentchg+aa.renttax),aa.rentchg) renttotal,aa.slkdte salikdate,aa.slkno salikinvno,"
						+" sum(aa.salikchg) salikamt,if(aa.tax=1 and aa.rentdte>='2018-01-01' ,sum(aa.saliktax),0) saliktax,if(aa.tax=1 and aa.rentdte>='2018-01-01' ,sum(aa.salikchg+aa.saliktax+slkserchr),sum(salikchg+slkserchr)) saliktotal,"
						+" aa.trfcdte trafficdate,aa.trfcno trafficinvno,sum(aa.trfcchg) trafficamt,if(aa.tax=1 and aa.rentdte>='2018-01-01',sum(trfctax),0) traffictax,"
						+" if(aa.tax=1 and aa.rentdte>='2018-01-01',sum(aa.trfcchg+trfctax+trfcserchg),sum(trfcchg+trfcserchg)) traffictotal,aa.insdte insrdate,aa.insno insrinvno,sum(inschg) insramt,if(aa.tax=1 and aa.rentdte>='2018-01-01',sum(instax),0) insrtax,"
						+" if(aa.tax=1 and aa.rentdte>='2018-01-01',sum(inschg+instax),sum(inschg)) insrtotal,"
						+" aa.dmgdte damagedate,aa.dmgno damageinvno,sum(dmgchg) damageamount,if(aa.tax=1 and aa.rentdte>='2018-01-01',sum(dmgtax),0) damagetax,if(aa.tax=1 and aa.rentdte>='2018-01-01',sum(dmgchg+dmgtax),sum(dmgchg)) damagetotal,sum(aa.total) totalamt from"

						+" (select a.tax ,m.voc_no invno,if(m.ratype='RAG',r.fleet_no,if(l.tmpfleet=0,l.perfleet,l.tmpfleet)) fleet_no,r.pono,m.invnote,"
						+" if(m.ratype='RAG',r.voc_no,l.voc_no) rentalvocno,a.refname clientname,m.voc_no rentno,m.date rentdte,if(chid=1,d.total,0) rentchg,"
						+" if(chid=1,d.total,0)*.05 renttax,"
						+" m.date slkdte,m.voc_no slkno,if(chid=8,d.total,0) salikchg,if(chid=14,d.total,0)*.05 saliktax,if(chid=14,d.total,0) slkserchr,"
						+" m.date trfcdte,"
						+" m.voc_no trfcno,if(chid=9,d.total,0) trfcchg,if(chid=15,d.total,0)*.05 trfctax,if(chid=15,d.total,0) trfcserchg,m.date insdte,"
						+" m.voc_no insno,"
						+" if(chid=17,d.total,0)  inschg,if(chid=17,d.total,0)*.05 instax,m.date dmgdte,m.voc_no dmgno,if(chid=10,d.total,0) dmgchg,"
						+" if(chid=10,d.total,0)*.05 dmgtax,d.total"

						+" from gl_invm m left join gl_invd d on m.doc_no=d.rdocno left join gl_ragmt r on r.doc_no=m.rano and m.brhid=r.brhid"
						+" and m.ratype='RAG'"
						+" left join gl_lagmt l on l.doc_no=m.rano and m.brhid=l.brhid and m.ratype='LAG'"
						+" left join my_acbook a on a.cldocno=m.cldocno and a.dtype='CRM' and a.status=3"
						+" where m.status=3 and m.date>='"+sqlfromdate+"' and m.date<='"+sqltodate+"' "+sqltest+" ) aa group by invno";

				
				
	            		System.out.println("---------------------invoise grid data----------"+sql);
	              
	            		ResultSet resultSet = stmtVeh.executeQuery(sql);
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
	    

	 
	  
	 public JSONArray invoicelistExcel(String branchval,String fromdate,String todate,String cldocno) throws SQLException {

		 JSONArray RESULTDATA=new JSONArray();
	        
	        java.sql.Date sqlfromdate = null;
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
	     	
	      	
     	String sqltest="";
     	String sqltest1="";
	    	if(!(cldocno.equalsIgnoreCase("")|| cldocno.equalsIgnoreCase("NA"))){
	    		sqltest=sqltest+" and a.cldocno='"+cldocno+"'";
	    	}
	    	
	    	
	      	if(!((branchval.equalsIgnoreCase("a")) || (branchval.equalsIgnoreCase("NA")))){
	 			sqltest+=" and m.brhid="+branchval+"";
	 		}
	   
	    	Connection conn = null;
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmtVeh = conn.createStatement ();
					
					String sql1 ="select method from gl_config where field_nme='indian' ";
         		ResultSet re = stmtVeh.executeQuery(sql1);
         		
				int company=0;	
				int chk=1;
				
				if(re.next())
	            
				{
					company=re.getInt("method");
				}
				company=1;
				if(company==1)
				{
					chk=0;
					
					sqltest1=sqltest1+ " vat , ";
				}
				
				else
				{
					chk=1;
					sqltest+=" and inv.status=3 ";		
					
				}
				
					
				Statement stmtindian=conn.createStatement();
				String strindian="select method from gl_config where field_nme='indian'";
				ResultSet rsindian=stmtindian.executeQuery(strindian);
				int indian=0;
				while(rsindian.next()){
					indian=rsindian.getInt("method");
				}
				String sqlvocno="";
				if(indian==1){
					sqlvocno="concat(br.branch,'/',year(inv.date),'/',inv.voc_no)";
				}
				else{
					sqlvocno="inv.voc_no";
				}
				
				String strshowfleet="select method from gl_config where field_nme='invListShowFleet'";
				int showfleet=0;
				ResultSet rsshowfleet=stmtindian.executeQuery(strshowfleet);
				while(rsshowfleet.next()){
					showfleet=rsshowfleet.getInt("method");
				}
				String showfleetcolumn="";
				if(showfleet==1){
					showfleetcolumn="l.perfleet 'Fleet No',";
				}
				//Fetching data from view instead direct from db;
				String sql=" select aa.fleet_no 'Fleet No',aa.pono 'Po No',aa.invnote 'Description',aa.rentalvocno 'Agreement No',aa.clientname 'Client',aa.rentno 'Rental Invno',aa.rentdte 'Rental Inv Date',aa.rentchg 'Rent Amt',if(aa.tax=1 and aa.rentdte>='2018-01-01',aa.renttax,0) 'Rent Tax Amt',"
						+" if(aa.tax=1 and aa.rentdte>='2018-01-01',sum(aa.rentchg+aa.renttax),aa.rentchg) 'Rent Total Amt',aa.slkdte 'Salik Date',aa.slkno 'Salik Invno',"
						+" sum(aa.salikchg) 'Salik Amt',if(aa.tax=1 and aa.rentdte>='2018-01-01' ,sum(aa.saliktax),0) 'Salik Tax',if(aa.tax=1 and aa.rentdte>='2018-01-01' ,sum(aa.salikchg+aa.saliktax+slkserchr),sum(salikchg+slkserchr)) 'Salik Total Amt',"
						+" aa.trfcdte 'Traffic Date',aa.trfcno 'Traffic Invno',sum(aa.trfcchg) 'Traffic Amt',if(aa.tax=1 and aa.rentdte>='2018-01-01',sum(trfctax),0) 'Traffic Tax',"
						+" if(aa.tax=1 and aa.rentdte>='2018-01-01',sum(aa.trfcchg+trfctax+trfcserchg),sum(trfcchg+trfcserchg)) 'Traffic Total Amt',aa.insdte 'Insure Inv Date',aa.insno 'Insure Invno',sum(inschg) 'Insure Amt',if(aa.tax=1 and aa.rentdte>='2018-01-01',sum(instax),0) 'Insure Tax',"
						+" if(aa.tax=1 and aa.rentdte>='2018-01-01',sum(inschg+instax),sum(inschg)) 'Insure Total Amt',"
						+" aa.dmgdte 'Damage Inv Date',aa.dmgno 'Damage Invno',sum(dmgchg) 'Damage Inv Amount',if(aa.tax=1 and aa.rentdte>='2018-01-01',sum(dmgtax),0) 'Damage Inv Tax',if(aa.tax=1 and aa.rentdte>='2018-01-01',sum(dmgchg+dmgtax),sum(dmgchg)) 'Damage Total Inv Amount' from"

						+" (select a.tax ,m.voc_no invno,if(m.ratype='RAG',r.fleet_no,if(l.tmpfleet=0,l.perfleet,l.tmpfleet)) fleet_no,r.pono,m.invnote,"
						+" if(m.ratype='RAG',r.voc_no,l.voc_no) rentalvocno,a.refname clientname,m.voc_no rentno,m.date rentdte,if(chid=1,d.total,0) rentchg,"
						+" if(chid=1,d.total,0)*.05 renttax,"
						+" m.date slkdte,m.voc_no slkno,if(chid=8,d.total,0) salikchg,if(chid=14,d.total,0)*.05 saliktax,if(chid=14,d.total,0) slkserchr,"
						+" m.date trfcdte,"
						+" m.voc_no trfcno,if(chid=9,d.total,0) trfcchg,if(chid=15,d.total,0)*.05 trfctax,if(chid=15,d.total,0) trfcserchg,m.date insdte,"
						+" m.voc_no insno,"
						+" if(chid=17,d.total,0)  inschg,if(chid=17,d.total,0)*.05 instax,m.date dmgdte,m.voc_no dmgno,if(chid=10,d.total,0) dmgchg,"
						+" if(chid=10,d.total,0)*.05 dmgtax,d.total"

						+" from gl_invm m left join gl_invd d on m.doc_no=d.rdocno left join gl_ragmt r on r.doc_no=m.rano and m.brhid=r.brhid"
						+" and m.ratype='RAG'"
						+" left join gl_lagmt l on l.doc_no=m.rano and m.brhid=l.brhid and m.ratype='LAG'"
						+" left join my_acbook a on a.cldocno=m.cldocno and a.dtype='CRM' and a.status=3"
						+" where m.status=3 and m.date>='"+sqlfromdate+"' and m.date<='"+sqltodate+"' "+sqltest+" ) aa group by invno";
						
	            				
				/*	String sql ="select convert("+sqlvocno+",char(25)) as 'Doc No',m.date Date,h.description 'Account Name',h.account Account,m.ratype 'RA Type', "
							+ " 	if(m.ratype='RAG',r.voc_no,l.voc_no) 'RA No',m.fromdate 'From Date'   ,m.todate  'To Date' , "
							+ " 	convert(coalesce(sum(d.total),''),char(50)) Amount , convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=1),  "
							+ " ' '),char(50)) 'Rental Sum', convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid=17),''),char(50))  "
							+ " 'Insurance Charges', convert(coalesce((select  sum(total) from gl_invd where rdocno=m.doc_no and chid=2),''),char(50)) Acc_Sum,  "
							+ "  convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (8,14)),''),char(50)) 'Salik Amt',"+sqltest1 +" "
									+ "	    convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (9,15)),' '),char(50)) 'Traffic Amt' ,"
							+ "    convert(coalesce((select sum(total) from gl_invd where rdocno=m.doc_no and chid in (3,4,5,6,7,10,11,12,13,16,18,19,21)),' '),char(50)) 'Other Charges' , ms.sal_name 'Salesman',	"
							+ "     if(m.ratype='RAG',r.mrano,l.manualra) 'MRA NO' ,if(m.status='7','Cancelled','') Status  from gl_invm m left join gl_invd d on m.doc_no=d.rdocno "
							+ "     left join my_acbook a on a.doc_no=m.cldocno and a.dtype='CRM' left join gl_lagmt l on l.doc_no=m.rano  AND M.RATYPE='LAG'"
							+ "      left join gl_ragmt r on r.doc_no=m.rano  AND M.RATYPE='RAG' left join my_head h on h.doc_no=m.acno left join my_brch br on m.brhid=br.doc_no left join my_salm ms on ms.doc_no=r.salid or ms.doc_no=l.salid where  "           				
	            				+ " m.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest +" group by d.rdocno order by m.doc_no";*/
	      
				System.out.println("=====invoice list excel======="+sql);
	              
	            		ResultSet resultSet = stmtVeh.executeQuery(sql);
	            		 RESULTDATA=convertToJSON(resultSet);//  convertToJSON(resultSet);
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
	    
	 
	 
		public  JSONArray convertToJSON(ResultSet resultSet)
				throws Exception {
				JSONArray jsonArray = new JSONArray();
				
				while (resultSet.next()) {
				int total_rows = resultSet.getMetaData().getColumnCount();
				JSONObject obj = new JSONObject();
				for (int i = 0; i < total_rows; i++) {
					 obj.put(resultSet.getMetaData().getColumnLabel(i + 1), (resultSet.getObject(i + 1)==null) ? "NA" : ((resultSet.getObject(i + 1).equals("0.0000")) ? " " : (resultSet.getObject(i + 1).toString()).replaceAll("[^a-zA-Z0-9_-_._; ]", " ")));
					 obj.put(resultSet.getMetaData().getColumnLabel(i + 1), ((resultSet.getObject(i + 1)==null) ? "NA" : resultSet.getObject(i + 1).toString()));
				}
				jsonArray.add(obj);
				}
				//System.out.println("ConvertTOJson:   "+jsonArray);
				return jsonArray;
				}
			 
	 
	 
	 


}
