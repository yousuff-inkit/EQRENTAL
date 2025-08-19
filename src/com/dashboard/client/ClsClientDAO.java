package com.dashboard.client;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsClientDAO  {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
  public JSONArray clientListGridLoading(String check) throws SQLException {
	JSONArray RESULTDATA=new JSONArray();
	if(!(check.equalsIgnoreCase("load"))){
		return RESULTDATA;
	}
	Connection conn = null;

	
	  try {
		     conn = ClsConnection.getMyConnection();
		    Statement stmtCRM = conn.createStatement ();
		    String clsql="SELECT cl.per_salikrate salcharge,cl.per_trafficharge trafcharge,h.account,cat.acc_group,tx.desc1 taxcat,cl.credit,cl.period,cl.period2,cat.category,refname,cl.cldocno,per_mob,sal_name,"
		    		+" concat(coalesce(address,''),'  ',coalesce(address2,'')) as address,mail1,if(invc_method=1,'Month End','Period') "
		    		+" invc_method, if(del_charges=0,'No','Yes') del_charges,trnnumber"
		    		+" FROM my_acbook CL left JOIN my_clcatm cat ON cl.catid=cat.doc_no and cat.dtype='CRM' left join my_salm s on cl.sal_id=s.doc_no"
		    		+" left join my_head h on cl.acno=h.doc_no left join my_cltax tx on cl.taxid=tx.doc_no where cl.dtype='CRM' and cl.status=3";
		    System.out.println("list====== "+clsql);
		    ResultSet resultSet = stmtCRM.executeQuery (clsql);
		    
		    RESULTDATA=ClsCommon.convertToJSON(resultSet);
		    
		    stmtCRM.close();
		    conn.close();
	  }catch(Exception e){
		  e.printStackTrace();
		  conn.close();
	  }finally{
		  conn.close();
	  }
	  return RESULTDATA;
	}
  
  public JSONArray clientListExcelExport(String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		if(!(check.equalsIgnoreCase("load"))){
			return RESULTDATA;
		}
		Connection conn = null;  
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtCRM = conn.createStatement ();
		    
			    ResultSet resultSet = stmtCRM.executeQuery ("SELECT cl.cldocno Client_Code,h.account 'Account No',cat.acc_group 'Acc Group',refname NAME,cat.category CATEGORY,tx.desc1 'Tax Category',trnnumber 'TRN No',"
			    		+ " concat(coalesce(address,''),'  ',coalesce(address2,'')) as ADDRESS,per_mob MOBILE,sal_name SALESMAN,mail1 'EMAIL ID',if(invc_method=1,'Month End','Period') "
			    		+ " 'INV METHOD',if(del_charges=0,'No','Yes') 'DEL. CHARGES',cl.per_salikrate 'Salik Charge',cl.per_trafficharge 'Traffic Charge',cl.credit  'Credit Limit',cl.period 'Credit Period',cl.period2 'Max Days'"
			    		+ " FROM my_acbook CL left JOIN my_clcatm cat ON cl.catid=cat.doc_no and cat.dtype='CRM' left join my_salm s on cl.sal_id=s.doc_no "
			    		+ " left join my_head h on cl.acno=h.doc_no left join my_cltax tx on cl.taxid=tx.doc_no where cl.dtype='CRM'");
			    
			    RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
			    
			    stmtCRM.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	public JSONArray getClientCategory(String id) throws SQLException{
		JSONArray RESULTDATA=new JSONArray();
		if(!(id.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		Connection conn = null;

		
		  try {
			     conn = ClsConnection.getMyConnection();
			    Statement stmtCRM = conn.createStatement ();
			    String clsql="select doc_no,cat_name from my_clcatm where status=3";
			    
			    ResultSet resultSet = stmtCRM.executeQuery (clsql);
			    
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtCRM.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
	}
    public  JSONArray cardfolowup(String branch,String type,String uptodate,String rentalstatus,String category) throws SQLException {

      JSONArray RESULTDATA=new JSONArray();
      Connection conn = null;
      
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement();
				java.sql.Date sqldate=null;
				if(!uptodate.equalsIgnoreCase("")){
					sqldate=ClsCommon.changeStringtoSqlDate(uptodate);
				}
				String sqltest="";
				
				if(!rentalstatus.equalsIgnoreCase("")){
					sqltest+=" and r.clstatus="+rentalstatus;
				}
				if(!category.equalsIgnoreCase("")){
					sqltest+=" and a.catid="+category;
				}
				if(branch.equalsIgnoreCase("a"))
            	{	
				
			    if(type.equalsIgnoreCase("RAG"))
		    	{
			    	
			    	String sqlexp=("select p.acode authcode,cat.cat_name,sal.sal_name,a.mail1 email,p.expdate,r.voc_no,p.rdocno,p.amount,'Rental' type,'Edit' btnsave,p.doc_no pytdoc,"
			                + " r.cldocno,a.refname,p.reldate,if(cg.method=0,right(cardno,4),cardno) cardno,r.brhid "
			                +" from gl_rpyt p left join gl_ragmt r on r.doc_no=p.rdocno"
			                +" left join my_acbook a on a.doc_no=r.cldocno and a.dtype='�RM' "
			                +" left join gl_config cg on field_nme='cardno' left join my_salm sal on (a.sal_id=sal.doc_no)  left join my_clcatm cat on a.catid=cat.doc_no "
			                +" where p.payid=3 and r.clstatus=0 and p.relstatus=0 and p.reldate<'"+sqldate+"' "+sqltest+" order by p.reldate " );
			    	System.out.println("=== "+sqlexp);   	
					ResultSet resultSet = stmtVeh1.executeQuery (sqlexp);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtVeh1.close();
					conn.close();
					
					return RESULTDATA;
		    	}
		    	else {				 
		    		String sqlexp=("select p.acode authcode,cat.cat_name,sal.sal_name,a.mail1 email,p.expdate,r.voc_no,p.rdocno,'Lease' type,p.amount,'Edit' btnsave,p.reldate,p.doc_no pytdoc,r.cldocno,a.refname,if(cg.method=0,right(cardno,4),cardno) cardno,r.brhid from gl_lpyt p "
		    				+ " left join gl_lagmt r on r.doc_no=p.rdocno left join my_acbook a on a.doc_no=r.cldocno "
		    				+ " and a.dtype='�RM'  left join gl_config cg on field_nme='cardno'  left join my_salm sal on (a.sal_id=sal.doc_no)  left join my_clcatm cat on a.catid=cat.doc_no where  p.payid=3 and r.clstatus=0 and p.relstatus=0  and p.reldate<'"+sqldate+"'  "+sqltest+" order by p.reldate  " );
		    		System.out.println("=== "+sqlexp);   
					ResultSet resultSet = stmtVeh1.executeQuery (sqlexp);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtVeh1.close();
					conn.close();
					
					return RESULTDATA;
		    	}
          	  }
			    else
			    {
			    	 if(type.equalsIgnoreCase("RAG"))
				    	{
				        	String sqlexp=("select p.acode authcode,cat.cat_name, a.mail1 email,p.expdate,r.voc_no,p.rdocno,p.amount,'Rental' type,'Edit' btnsave,p.doc_no pytdoc,r.cldocno,a.refname,p.reldate,RIGHT(cardno,4) cardno,r.brhid from gl_rpyt p left join gl_ragmt r on r.doc_no=p.rdocno"
				        			+ " left join my_acbook a on a.doc_no=r.cldocno and a.dtype='�RM'  left join my_clcatm cat on a.catid=cat.doc_no  where  p.payid=3 and r.clstatus=0 and p.relstatus=0  and p.brhid='"+branch+"' and p.reldate< '"+sqldate+"'  "+sqltest+" order by p.reldate   " );
				        	System.out.println("=== "+sqlexp);   
				        	ResultSet resultSet = stmtVeh1.executeQuery (sqlexp);
							RESULTDATA=ClsCommon.convertToJSON(resultSet);
							
							stmtVeh1.close();
							conn.close();
							 return RESULTDATA;
				    	}
				    	else {				 
				    		String sqlexp=("select  p.acode authcode,cat.cat_name,a.mail1 email,p.expdate,r.voc_no,p.rdocno,'Lease' type,p.amount,'Edit' btnsave,p.reldate,p.doc_no pytdoc,r.cldocno,a.refname,RIGHT(cardno,4) cardno,r.brhid from gl_lpyt p "
				    				+ " left join gl_lagmt r on r.doc_no=p.rdocno left join my_acbook a on a.doc_no=r.cldocno "
				    				+ " and a.dtype='�RM'  left join my_clcatm cat on a.catid=cat.doc_no  where  p.payid=3 and r.clstatus=0 and p.relstatus=0 and p.brhid='"+branch+"' and p.reldate< '"+sqldate+"'  "+sqltest+" order by p.reldate  " );
				    		System.out.println("=== "+sqlexp);   
							ResultSet resultSet = stmtVeh1.executeQuery (sqlexp);
							RESULTDATA=ClsCommon.convertToJSON(resultSet);
							stmtVeh1.close();
							conn.close();
							 return RESULTDATA;
				    	}
			    }
				
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
      return RESULTDATA;
  }
    
    public  JSONArray cardfolowupExcel(String branch,String type,String uptodate,String rentalstatus,String category) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
  		try {
  				conn = ClsConnection.getMyConnection();
  				Statement stmtVeh1 = conn.createStatement();
  				java.sql.Date sqldate=null;
  				if(!uptodate.equalsIgnoreCase("")){
  					sqldate=ClsCommon.changeStringtoSqlDate(uptodate);
  				}
  				String sqltest="";
				
				if(!rentalstatus.equalsIgnoreCase("")){
					sqltest+=" and r.clstatus="+rentalstatus;
				}
				if(!category.equalsIgnoreCase("")){
					sqltest+=" and a.catid="+category;
				}
  				if(branch.equalsIgnoreCase("a"))
              	{	
  				
  			    if(type.equalsIgnoreCase("RAG"))
  		    	{
  			    	
  			    	String sqlexp=("select 'Rental' type,r.voc_no RANO,a.refname client_name,cat.cat_name 'Category',a.mail1 email,convert(concat('Card No: ',cardno),char(25)) cardno,p.expdate,p.acode 'Auth Code',coalesce(sal.sal_name,'') 'Sales Person',p.amount,p.reldate release_date "
  			                +" from gl_rpyt p left join gl_ragmt r on r.doc_no=p.rdocno"
  			                +" left join my_acbook a on a.doc_no=r.cldocno and a.dtype='�RM' "
  			                +" left join gl_config cg on field_nme='cardno' left join my_salm sal on (a.sal_id=sal.doc_no) left join my_clcatm cat on a.catid=cat.doc_no "
  			                +" where p.payid=3 and r.clstatus=0 and p.relstatus=0 and p.reldate< '"+sqldate+"' "+sqltest+" order by p.reldate " );
  			    	System.out.println("=== "+sqlexp);   	
  					ResultSet resultSet = stmtVeh1.executeQuery (sqlexp);
  					RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
  					System.out.println("result data----"+RESULTDATA);
  					stmtVeh1.close();
  					conn.close();
  					
  					return RESULTDATA;
  		    	}
  		    	else {				 
  		    		String sqlexp=("select 'Lease' type,r.voc_no RANO,a.refname client_name,cat.cat_name 'Category',a.mail1 email,convert(concat('Card No: ',cardno),char(25)) cardno,p.expdate,p.acode 'Auth Code',coalesce(sal.sal_name,'') 'Sales Person',p.amount,p.reldate release_date from gl_lpyt p "
  		    				+ " left join gl_lagmt r on r.doc_no=p.rdocno left join my_acbook a on a.doc_no=r.cldocno "
  		    				+ " and a.dtype='�RM'  left join gl_config cg on field_nme='cardno' left join my_salm sal on (a.sal_id=sal.doc_no) left join my_clcatm cat on a.catid=cat.doc_no where  p.payid=3 and r.clstatus=0 and p.relstatus=0  and p.reldate<'"+sqldate+"' "+sqltest+" order by p.reldate  " );
  		    		System.out.println("=== "+sqlexp);   
  					ResultSet resultSet = stmtVeh1.executeQuery (sqlexp);
  					RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
  					
  					stmtVeh1.close();
  					conn.close();
  					
  					return RESULTDATA;
  		    	}
            	  }
  			    else
  			    {
  			    	 if(type.equalsIgnoreCase("RAG"))
  				    	{
  				        	String sqlexp=("select  'Rental' type,r.voc_no RANO,a.refname client_name,cat.cat_name 'Category',a.mail1 email,RIGHT(cardno,4) cardno,p.expdate,p.acode 'Auth Code',p.amount,p.reldate release_date from gl_rpyt p left join gl_ragmt r on r.doc_no=p.rdocno"
  				        			+ " left join my_acbook a on a.doc_no=r.cldocno and a.dtype='�RM' left join my_clcatm cat on a.catid=cat.doc_no  where  p.payid=3 and r.clstatus=0 and p.relstatus=0  and p.brhid='"+branch+"' and p.reldate<'"+sqldate+"' "+sqltest+" order by p.reldate   " );
  				        	System.out.println("=== "+sqlexp);   
  				        	ResultSet resultSet = stmtVeh1.executeQuery (sqlexp);
  							RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
  							
  							stmtVeh1.close();
  							conn.close();
  							 return RESULTDATA;
  				    	}
  				    	else {				 
  				    		String sqlexp=("select  'Lease' type,r.voc_no RANO,a.refname client_name,cat.cat_name 'Category',a.mail1 email,RIGHT(cardno,4) cardno,p.expdate,p.acode 'Auth Code',p.amount,p.reldate release_date from gl_lpyt p "
  				    				+ " left join gl_lagmt r on r.doc_no=p.rdocno left join my_acbook a on a.doc_no=r.cldocno "
  				    				+ " and a.dtype='�RM'  left join my_clcatm cat on a.catid=cat.doc_no  where  p.payid=3 and r.clstatus=0 and p.relstatus=0 and p.brhid='"+branch+"' and p.reldate< '"+sqldate+"' "+sqltest+" order by p.reldate  " );
  				    		System.out.println("=== "+sqlexp);   
  							ResultSet resultSet = stmtVeh1.executeQuery (sqlexp);
  							RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
  							stmtVeh1.close();
  							conn.close();
  							 return RESULTDATA;
  				    	}
  			    }
  		}catch(Exception e){
  			e.printStackTrace();
  			conn.close();
  		}finally{
  			conn.close();
  		}
        return RESULTDATA;
    }        
	

	public JSONArray underlitigation(String branch,String chk) throws SQLException {

      JSONArray RESULTDATA=new JSONArray();

      Connection conn = null;
 	
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement();
				
				String sqls="";
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
					sqls+=" and r.brhid="+branch+"";
	    		}
				
				if(chk.equalsIgnoreCase("yes")) {	

					String sqlexp="select * from (select if(a.pcase=1,'Litigation',if(a.pcase=2,'Dispute',if(a.pcase=3,'Bad Debts',if(a.pcase=4,'Frequent Defaulter','')))) status,'RA' choice,convert(r.voc_no,char(10)) voc_no,bv.fdate,convert(r.doc_no,char(10)) rdocno, "
							+ " convert(m.doc_no,char(15)) disdoc,m.remarks,m.caseno,  m.station,m.value,m.casenote,a.refname, "
							+ " r.cldocno,r.brhid,if(r.clstatus=0,'Open','Close') clstatus 	from gl_bdis m left join gl_ragmt r on  "
							+ " r.doc_no=m.rdocno left join my_acbook a on a.cldocno=r.cldocno   and a.dtype='CRM'  "
							+ " left join (select max(b.doc_no) doc_no,rdocno from gl_bcul b group by  b.rdocno)  "
							+ " b on(b.rdocno=m.doc_no) left join gl_bcul bv on b.doc_no=bv.doc_no  where m.bibpid=5 and a.pcase!=0 and "
							+ " r.dispute=2 and m.status=3 "+sqls+") aa	union all  	select if(a.pcase=1,'Litigation',if(a.pcase=2,'Dispute',if(a.pcase=3,'Bad Debts',if(a.pcase=4,'Frequent Defaulter','')))) status,'DI' choice,'' voc_no,bv.fdate,'' rdocno, "
							+ " convert(m.doc_no,char(15)) disdoc,'' remarks,m.caseno,  m.station,m.value,m.casenote,a.refname, "
							+  "m.cldocno,'1' brhid,'' clstatus  from gl_bdis m left join my_acbook a on a.cldocno=m.cldocno and a.dtype='CRM'  "
							+ " left join  (select max(b.doc_no) doc_no,rdocno from gl_bcul b group by  b.rdocno) b on(b.rdocno=m.doc_no) "
							+ " left join gl_bcul bv on b.doc_no=bv.doc_no  where a.pcase!=0 and m.bibpid=5 and m.status=3";
					
		        	//System.out.println("sqlexp- "+sqlexp);
		        	
					ResultSet resultSet = stmtVeh1.executeQuery(sqlexp);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtVeh1.close();
					conn.close();
					return RESULTDATA;
		    	}
	
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
      return RESULTDATA;
    }
	
	public JSONArray underlitigationExcel(String branch,String chk) throws SQLException {

	      JSONArray RESULTDATA=new JSONArray();

	      Connection conn = null;
	 	
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmtVeh1 = conn.createStatement();
					
					String sqls="";
					
					if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
						sqls+=" and r.brhid="+branch+"";
		    		}
					
					if(chk.equalsIgnoreCase("yes")) {	

						String sqlexp="select status 'Status', refname 'Client Name', clstatus 'RA', voc_no 'RDOC NO', caseno 'Case NO', station 'Station', remarks 'Remarks',value 'Value', casenote 'Case Note', fdate 'Follow Up Date' from ("
								+ "select if(a.pcase=1,'Litigation',if(a.pcase=2,'Dispute',if(a.pcase=3,'Bad Debts',if(a.pcase=4,'Frequent Defaulter','')))) status,'RA' choice,convert(r.voc_no,char(10)) voc_no,bv.fdate,convert(r.doc_no,char(10)) rdocno, "
								+ " convert(m.doc_no,char(15)) disdoc,m.remarks,m.caseno,  m.station,m.value,m.casenote,a.refname, "
								+ " r.cldocno,r.brhid,if(r.clstatus=0,'Open','Close') clstatus 	from gl_bdis m left join gl_ragmt r on  "
								+ " r.doc_no=m.rdocno left join my_acbook a on a.cldocno=r.cldocno   and a.dtype='CRM'  "
								+ " left join (select max(b.doc_no) doc_no,rdocno from gl_bcul b group by  b.rdocno)  "
								+ " b on(b.rdocno=m.doc_no) left join gl_bcul bv on b.doc_no=bv.doc_no  where m.bibpid=5 and a.pcase!=0 and "
								+ " r.dispute=2 and m.status=3 "+sqls+") aa	union all  	select if(a.pcase=1,'Litigation',if(a.pcase=2,'Dispute',if(a.pcase=3,'Bad Debts',if(a.pcase=4,'Frequent Defaulter','')))) status,a.refname,'' clstatus,'' voc_no,"
								+ " m.caseno,m.station,'' remarks,m.value,m.casenote,bv.fdate  from gl_bdis m left join my_acbook a on a.cldocno=m.cldocno and a.dtype='CRM'  "
								+ " left join  (select max(b.doc_no) doc_no,rdocno from gl_bcul b group by  b.rdocno) b on(b.rdocno=m.doc_no) "
								+ " left join gl_bcul bv on b.doc_no=bv.doc_no  where a.pcase!=0 and m.bibpid=5 and m.status=3";
						
						ResultSet resultSet = stmtVeh1.executeQuery(sqlexp);
						RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
						
						stmtVeh1.close();
						conn.close();
						return RESULTDATA;
			    	}
		
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
				
				String sql="select cldocno,refname from my_acbook where status=3 and dtype='CRM' and pcase=0 ";
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
	
	


	
	public  JSONArray underlitigation(String branch) throws SQLException {

      JSONArray RESULTDATA=new JSONArray();

      Connection conn = null;
 	
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement();
				
				if(branch.equalsIgnoreCase("a"))
          	{	

		        	String sqlexp=("select r.voc_no,bv.fdate,m.rdocno,m.remarks,m.caseno,m.station,m.value,m.casenote,a.refname,r.cldocno,r.brhid,if(r.clstatus=0,'Open','Close') clstatus "
		        			+ "from gl_bdis m left join gl_ragmt r on  r.doc_no=m.rdocno left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
		        			+ "left join (select max(b.doc_no) doc_no,rdocno from gl_bcul b group by  rdocno) b on(b.rdocno=r.doc_no) left join gl_bcul bv on b.doc_no=bv.doc_no "
		        			+ " where m.bibpid=5 and  r.dispute=2 ");
		        	
					ResultSet resultSet = stmtVeh1.executeQuery(sqlexp);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtVeh1.close();
					conn.close();
					return RESULTDATA;
		    	}
		    	else {	
		    		
		    		String sqlexp=("select r.voc_no,bv.fdate,m.rdocno,m.remarks,m.caseno,m.station,m.value,m.casenote,a.refname,r.cldocno,r.brhid,if(r.clstatus=0,'Open','Close') clstatus "
		        			+ "from gl_bdis m left join gl_ragmt r on  r.doc_no=m.rdocno left join my_acbook a on a.cldocno=r.cldocno and a.dtype='CRM' "
		        			+ "left join (select max(b.doc_no) doc_no,rdocno from gl_bcul b group by  rdocno) b on(b.rdocno=r.doc_no) left join gl_bcul bv on b.doc_no=bv.doc_no "
		        			+ " where m.bibpid=5 and  r.dispute=2  and  r.brhid='"+branch+"' ");
		    
					ResultSet resultSet = stmtVeh1.executeQuery(sqlexp);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtVeh1.close();
					conn.close();
					return RESULTDATA;
		    	}
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
      return RESULTDATA;
  }
	
	public JSONArray underlitigationDetails(String rdocno,String check) throws SQLException {

      JSONArray RESULTDATA=new JSONArray();
      
      Connection conn = null;
      if(!(check.equalsIgnoreCase("1"))){
    	  return RESULTDATA;
      }
      try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement();
		
      		String sql=" select m.date detdate,m.remarks remk,m.fdate,u.user_name user from gl_bcul m  "
      				+ " inner join my_user u on u.doc_no=m.userid where m.rdocno='"+rdocno+"'  and m.bibpid=10 group by m.doc_no ";

      		ResultSet resultSet = stmtVeh.executeQuery(sql);
      		RESULTDATA=ClsCommon.convertToJSON(resultSet);
			
      		stmtVeh.close();
			conn.close();
	    }catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
      return RESULTDATA;
  }
	
	public JSONArray clientRequestGridLoading(String branch,String uptodate,String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		    
		Connection conn = null;
        java.sql.Date sqlUpToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
        	sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
        }
        
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtCRM = conn.createStatement();
			    
			    String sql = "",sql1="";
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and m.brhId="+branch+"";
	    		}
				
		        if(!(sqlUpToDate==null)){
		        	sql1+=" and m.date<='"+sqlUpToDate+"'";
			    }
	        			
				sql = "select m.date,m.doc_no,m.refno,m.rtype,m.aggno,concat(m.rtype,' - ',CONVERT(if(m.rtype='0','',if(m.rtype='RAG',ra.voc_no,la.voc_no)),CHAR(20))) agreement,"
					+ "type servicetype,m.servicedesc,m.cldocno,d.type_id,d.amount,m.brhId,a.refname,b.branchname from gl_othreq m left join gl_othreqd d on m.doc_no=d.rdocno "+sql+" "
					+ "left join my_acbook a on m.cldocno=a.cldocno and a.dtype='CRM' left join gl_ragmt ra on (m.aggno=ra.doc_no and m.rtype='RAG') left join gl_lagmt la on (m.aggno=la.doc_no "
					+ "and m.rtype='LAG') left join my_brch b on m.brhid=b.doc_no where m.status=3 and d.borq IN (0,7)"+sql+""+sql1+"";
				
				ResultSet resultSet = stmtCRM.executeQuery(sql);
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);

			    stmtCRM.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public JSONArray clientDetailsSearch(String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
        try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCRM = conn.createStatement();
            	
				ResultSet resultSet = stmtCRM.executeQuery ("select t.account,t.description,c.cldocno from my_acbook c left join  my_head t on t.doc_no=c.acno where "
						+ "t.atype='AR'");

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtCRM.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray documentExpiryGridLoading(String branch,String uptodate,String check,String cldocno,String active) throws SQLException {  
        JSONArray RESULTDATA=new JSONArray();  
        Connection conn = null;
        
        java.sql.Date sqlUpToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
              sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
        }
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				String sql = "",sqltest="",sqltest2="",sql2="";   
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and d.branch="+branch+"";
	    		}
				if(!((cldocno.equalsIgnoreCase("")) || (cldocno.equalsIgnoreCase("NA")))){
	    			sql+=" and d.cldocno="+cldocno+""; 
	    			sql2=" and b.cldocno="+cldocno+"";    
	    		}
				if(active.equalsIgnoreCase("1")) {
					sqltest=" and ra.clstatus=0 ";
					sqltest2=" and (la.cldocno is not null or ra.cldocno is not null ) ";        
				}
				/*sql = "select aa.document,aa.expirydate,aa.dr_id sr_no,aa.cldocno,aa.name,aa.refname,aa.per_mob,aa.brhid,CONVERT(aa.fdate,CHAR(100)) followupdate from ("
						+ "select  coalesce(bb.fdate,'') fdate,'Licence Expired' document,d.led expirydate,d.dr_id,d.cldocno,d.name,b.refname,b.per_mob,b.brhid from "
						+ "gl_drdetails d  left join gl_rdriver rd on (d.dr_id=rd.drid) left join gl_ragmt ra on (ra.doc_no=rd.rdocno) left join my_acbook b on("
						+ "d.cldocno=b.doc_no and b.dtype='CRM') left join (select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on a.dr_id=d.dr_id left join "
						+ "gl_bcde bb on a.doc=bb.doc_no where d.led<='"+sqlUpToDate+"' "+sql+" and ra.clstatus=0 union select  coalesce(bb.fdate,'') fdate,'Passport Expired' "
						+ "document,d.pass_exp expirydate,d.dr_id sr_no,d.cldocno,d.name,b.refname,b.per_mob,b.brhid from gl_drdetails d  left join gl_rdriver rd on "
						+ "(d.dr_id=rd.drid) left join gl_ragmt ra on (ra.doc_no=rd.rdocno) left join my_acbook b on(d.cldocno=b.doc_no and b.dtype='CRM') left join "
						+ "(select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on a.dr_id=d.dr_id left join gl_bcde bb on a.doc=bb.doc_no where d.pass_exp<="
						+ "'"+sqlUpToDate+"' "+sql+" and ra.clstatus=0 union select  coalesce(bb.fdate,'') fdate,'Licence Expired' document,d.led expirydate,d.dr_id,d.cldocno,d.name,"
						+ "b.refname,b.per_mob,b.brhid from gl_drdetails d  left join gl_ldriver rd on (d.dr_id=rd.drid) left join gl_lagmt ra on (ra.doc_no=rd.rdocno) "
						+ "left join my_acbook b on(d.cldocno=b.doc_no and b.dtype='CRM') left join (select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on "
						+ "a.dr_id=d.dr_id left join gl_bcde bb on a.doc=bb.doc_no where d.led<='"+sqlUpToDate+"' "+sql+" and ra.clstatus=0 union select  coalesce(bb.fdate,'') fdate,"
						+ "'Passport Expired' document,d.pass_exp expirydate,d.dr_id sr_no,d.cldocno,d.name,b.refname,b.per_mob,b.brhid from gl_drdetails d  left join "
						+ "gl_ldriver rd on (d.dr_id=rd.drid) left join gl_lagmt ra on (ra.doc_no=rd.rdocno) left join my_acbook b on(d.cldocno=b.doc_no and b.dtype='CRM') "
						+ "left join (select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on a.dr_id=d.dr_id left join gl_bcde bb on a.doc=bb.doc_no where d.pass_exp<="
						+ "'"+sqlUpToDate+"' "+sql+" and ra.clstatus=0) aa;";*/
					
				sql = "select sm.sal_name,aa.document,aa.expirydate,aa.dr_id sr_no,aa.cldocno,aa.name,aa.refname,aa.per_mob,aa.brhid,aa.visa_exp,CONVERT(aa.fdate,CHAR(100)) followupdate,"
						+ "CONVERT(concat(' Client : ',coalesce(aa.refname,' '), ' * ','Ref. Detail  : ',coalesce(aa.name,' '),' * ','Mobile No. : ' ,coalesce(aa.per_mob,' '),' * ',"
						+ "'Document : ', coalesce(aa.document,' '),' * ','Expiry Date : ', DATE_FORMAT(coalesce(aa.expirydate,' '),'%d-%m-%Y')),CHAR(1000)) clientinfo from ("
						+ "select  coalesce(bb.fdate,'') fdate,'Licence Expired' document,d.led expirydate,d.dr_id,d.cldocno,d.name,b.refname,b.per_mob,b.brhid,d.visa_exp  from "
						+ "gl_drdetails d  left join gl_rdriver rd on (d.dr_id=rd.drid) left join gl_ragmt ra on (ra.doc_no=rd.rdocno) left join my_acbook b on("
						+ "d.cldocno=b.doc_no and b.dtype='CRM') left join (select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on a.dr_id=d.dr_id left join "
						+ "gl_bcde bb on a.doc=bb.doc_no where b.status=3 and d.led<='"+sqlUpToDate+"' "+sql+" "+sqltest+" and rd.status=3 union select  coalesce(bb.fdate,'') fdate,"
						+ "'Passport Expired' document,d.pass_exp expirydate,d.dr_id sr_no,d.cldocno,d.name,b.refname,b.per_mob,b.brhid,d.visa_exp  from gl_drdetails d  left join "
						+ "gl_rdriver rd on (d.dr_id=rd.drid) left join gl_ragmt ra on (ra.doc_no=rd.rdocno) left join my_acbook b on(d.cldocno=b.doc_no and b.dtype='CRM') "
						+ "left join (select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on a.dr_id=d.dr_id left join gl_bcde bb on a.doc=bb.doc_no where b.status=3 "
						+ "and d.pass_exp<='"+sqlUpToDate+"' "+sql+"  "+sqltest+"  and rd.status=3 union select  coalesce(bb.fdate,'') fdate,"
						+ "'ID Expired' document,d.visa_exp expirydate,d.dr_id sr_no,d.cldocno,d.name,b.refname,b.per_mob,b.brhid,d.visa_exp  from gl_drdetails d  left join "
						+ "gl_rdriver rd on (d.dr_id=rd.drid) left join gl_ragmt ra on (ra.doc_no=rd.rdocno) left join my_acbook b on(d.cldocno=b.doc_no and b.dtype='CRM') "
						+ "left join (select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on a.dr_id=d.dr_id left join gl_bcde bb on a.doc=bb.doc_no where b.status=3 "
						+ "and d.visa_exp<='"+sqlUpToDate+"' "+sql+"  "+sqltest+"  and rd.status=3 "
						+ " union select  coalesce(bb.fdate,'') fdate,'Licence Expired' document,d.led expirydate,"
						+ "d.dr_id,d.cldocno,d.name,b.refname,b.per_mob,b.brhid,d.visa_exp from gl_drdetails d  left join gl_ldriver rd on (d.dr_id=rd.drid) left join gl_lagmt ra on (ra.doc_no=rd.rdocno) "
						+ "left join my_acbook b on(d.cldocno=b.doc_no and b.dtype='CRM') left join (select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on "
						+ "a.dr_id=d.dr_id left join gl_bcde bb on a.doc=bb.doc_no where b.status=3 and d.led<='"+sqlUpToDate+"' "+sql+"  "+sqltest+"  and rd.status=3 "
						+ " union select  coalesce(bb.fdate,'') fdate,'ID Expired' document,d.visa_exp expirydate,"
						+ "d.dr_id,d.cldocno,d.name,b.refname,b.per_mob,b.brhid,d.visa_exp from gl_drdetails d  left join gl_ldriver rd on (d.dr_id=rd.drid) left join gl_lagmt ra on (ra.doc_no=rd.rdocno) "
						+ "left join my_acbook b on(d.cldocno=b.doc_no and b.dtype='CRM') left join (select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on "
						+ "a.dr_id=d.dr_id left join gl_bcde bb on a.doc=bb.doc_no where b.status=3 and d.visa_exp<='"+sqlUpToDate+"' "+sql+"  "+sqltest+"  and rd.status=3 "		
						+ " union   "
						+ " select coalesce(bb.fdate,'') fdate,'Passport Expired' document,d.pass_exp expirydate,d.dr_id sr_no,d.cldocno,d.name,b.refname,b.per_mob,b.brhid,d.visa_exp  from gl_drdetails d  "
						+ "left join gl_ldriver rd on (d.dr_id=rd.drid) left join gl_lagmt ra on (ra.doc_no=rd.rdocno) left join my_acbook b on(d.cldocno=b.doc_no and b.dtype='CRM') "
						+ "left join (select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on a.dr_id=d.dr_id left join gl_bcde bb on a.doc=bb.doc_no where b.status=3 and d.pass_exp<="
						+ "'"+sqlUpToDate+"' "+sql+"  "+sqltest+"  and rd.status=3 union select coalesce(bb.fdate,'') fdate,'Trade Licence Expired' document,b.contract_upto expirydate,0 sr_no,b.cldocno,"
						+ "coalesce(b.contractno,'') name,b.refname,b.per_mob,b.brhid,d.visa_exp  from my_acbook b left join gl_drdetails d on(d.cldocno=b.doc_no and b.dtype='CRM') left join (select max(doc_no) doc,cldocno from gl_bcde group by cldocno) a on a.cldocno=b.cldocno "
						+ "left join gl_bcde bb on a.doc=bb.doc_no left join gl_lagmt la on b.cldocno=la.cldocno and la.clstatus=0  left join gl_ragmt ra on b.cldocno=la.cldocno and la.clstatus=0 where b.status=3 and b.dtype='crm' "+sql2+""+sqltest2+" and b.contract_upto<='"+sqlUpToDate+"') aa "
						+ " left join my_acbook ac on ac.cldocno=aa.cldocno and ac.dtype='crm' left join my_salm sm on sm.doc_no=ac.sal_id ";  	
				
				
				System.out.println("qwertyui"+sql);  
				ResultSet resultSet = stmtCRM.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtCRM.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray documentExpiryFollowUpGrid(String cldocno,String drId, String process,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				
				String sql = "select m.date detdate,m.remarks remk,m.fdate,u.user_id user from gl_bcde m inner join my_user u on u.doc_no=m.userid where m.cldocno="+cldocno+" "
						+ "and m.dr_id="+drId+" and m.document='"+process+"' and m.bibpid=13 group by m.doc_no";
				
				ResultSet resultSet = stmtCRM.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtCRM.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray creditCardFollowUpGridLoading(String branch,String uptodate,String rentalType,String gridLoad,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				
				if(!((gridLoad.equalsIgnoreCase("")) || (gridLoad.equalsIgnoreCase("0")))){
					String sql = "";
					
					if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    			sql+=" and r.brhid="+branch+"";
		    		}
					
					 if(!((uptodate.equalsIgnoreCase("")) || (uptodate.equalsIgnoreCase("0")))){
				        	sql+=" and date_format(str_to_date(p.expdate, '%m-%Y'), '%Y-%m')<=date_format(str_to_date('"+uptodate+"', '%m-%Y'),'%Y-%m')";
				        }
					
					if(rentalType.equalsIgnoreCase("RAG")){
					
					    sql = "select concat('RAG',' - ',CONVERT(r.voc_no,CHAR(20))) agreement,r.doc_no aggno,r.cldocno,r.brhId,p.cardno cards,RIGHT(p.cardno,4) cardno,p.expdate,p.doc_no pytdocno,a.refname from gl_ragmt r left join gl_rpyt p "
							+ "on p.rdocno=r.doc_no left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM' where r.clstatus=0 and p.mode='card'"+sql+"";
					}
					
					if(rentalType.equalsIgnoreCase("LAG")){
						
					    sql = "select concat('LAG',' - ',CONVERT(r.voc_no,CHAR(20))) agreement,r.doc_no aggno,r.cldocno,r.brhId,p.cardno cards,RIGHT(p.cardno,4) cardno,p.expdate,p.doc_no pytdocno,a.refname from gl_lagmt r left join gl_lpyt p "
							+ "on p.rdocno=r.doc_no left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM' where r.clstatus=0 and p.mode='card'"+sql+"";
					}
//					System.out.println("==== "+sql);
					ResultSet resultSet = stmtCRM.executeQuery(sql);
	
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtCRM.close();
					conn.close();
				}
				stmtCRM.close();
				conn.close();	
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray creditCardFollowUpDetailGrid(String cldocno, String rtype, String aggno, String cardno,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
        if(!(check.equalsIgnoreCase("1")))
        {
        	return RESULTDATA;
        }
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				
				String sql = "select m.date detdate,m.remarks remk,m.fdate,u.user_id user from gl_bccf m inner join my_user u on u.doc_no=m.userid where m.cldocno="+cldocno+" "
						+ "and m.rtype='"+rtype+"' and m.aggno='"+aggno+"' and m.cardno='"+cardno+"' and m.bibpid=23 group by m.doc_no";
				
				ResultSet resultSet = stmtCRM.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtCRM.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	public JSONArray documentExpiryGridexcelLoading(String branch,String uptodate,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
        java.sql.Date sqlUpToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
              sqlUpToDate = ClsCommon.changeStringtoSqlDate(uptodate);
        }
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				String sql = "";
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and d.branch="+branch+"";
	    		}
				
				/*sql = "select aa.document,aa.expirydate,aa.dr_id sr_no,aa.cldocno,aa.name,aa.refname,aa.per_mob,aa.brhid,CONVERT(aa.fdate,CHAR(100)) followupdate from ("
						+ "select  coalesce(bb.fdate,'') fdate,'Licence Expired' document,d.led expirydate,d.dr_id,d.cldocno,d.name,b.refname,b.per_mob,b.brhid from "
						+ "gl_drdetails d  left join gl_rdriver rd on (d.dr_id=rd.drid) left join gl_ragmt ra on (ra.doc_no=rd.rdocno) left join my_acbook b on("
						+ "d.cldocno=b.doc_no and b.dtype='CRM') left join (select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on a.dr_id=d.dr_id left join "
						+ "gl_bcde bb on a.doc=bb.doc_no where d.led<='"+sqlUpToDate+"' "+sql+" and ra.clstatus=0 union select  coalesce(bb.fdate,'') fdate,'Passport Expired' "
						+ "document,d.pass_exp expirydate,d.dr_id sr_no,d.cldocno,d.name,b.refname,b.per_mob,b.brhid from gl_drdetails d  left join gl_rdriver rd on "
						+ "(d.dr_id=rd.drid) left join gl_ragmt ra on (ra.doc_no=rd.rdocno) left join my_acbook b on(d.cldocno=b.doc_no and b.dtype='CRM') left join "
						+ "(select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on a.dr_id=d.dr_id left join gl_bcde bb on a.doc=bb.doc_no where d.pass_exp<="
						+ "'"+sqlUpToDate+"' "+sql+" and ra.clstatus=0 union select  coalesce(bb.fdate,'') fdate,'Licence Expired' document,d.led expirydate,d.dr_id,d.cldocno,d.name,"
						+ "b.refname,b.per_mob,b.brhid from gl_drdetails d  left join gl_ldriver rd on (d.dr_id=rd.drid) left join gl_lagmt ra on (ra.doc_no=rd.rdocno) "
						+ "left join my_acbook b on(d.cldocno=b.doc_no and b.dtype='CRM') left join (select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on "
						+ "a.dr_id=d.dr_id left join gl_bcde bb on a.doc=bb.doc_no where d.led<='"+sqlUpToDate+"' "+sql+" and ra.clstatus=0 union select  coalesce(bb.fdate,'') fdate,"
						+ "'Passport Expired' document,d.pass_exp expirydate,d.dr_id sr_no,d.cldocno,d.name,b.refname,b.per_mob,b.brhid from gl_drdetails d  left join "
						+ "gl_ldriver rd on (d.dr_id=rd.drid) left join gl_lagmt ra on (ra.doc_no=rd.rdocno) left join my_acbook b on(d.cldocno=b.doc_no and b.dtype='CRM') "
						+ "left join (select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on a.dr_id=d.dr_id left join gl_bcde bb on a.doc=bb.doc_no where d.pass_exp<="
						+ "'"+sqlUpToDate+"' "+sql+" and ra.clstatus=0) aa;";*/
					
				sql = "select aa.refname 'Client',aa.cldocno 'Cl_docno',aa.name 'Ref_Details',aa.per_mob 'Mobile_No',aa.document 'Document',aa.expirydate 'Expiry_Date',CONVERT(aa.fdate,CHAR(100)) Followupdate "
						+ "from (select  coalesce(bb.fdate,'') fdate,'Licence Expired' document,d.led expirydate,d.dr_id,d.cldocno,d.name,b.refname,b.per_mob,b.brhid,d.visa_exp  from "
						+ "gl_drdetails d  left join gl_rdriver rd on (d.dr_id=rd.drid) left join gl_ragmt ra on (ra.doc_no=rd.rdocno) left join my_acbook b on("
						+ "d.cldocno=b.doc_no and b.dtype='CRM') left join (select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on a.dr_id=d.dr_id left join "
						+ "gl_bcde bb on a.doc=bb.doc_no where b.status=3 and d.led<='"+sqlUpToDate+"' "+sql+" and ra.clstatus=0 and rd.status=3 union select  coalesce(bb.fdate,'') fdate,"
						+ "'Passport Expired' document,d.pass_exp expirydate,d.dr_id sr_no,d.cldocno,d.name,b.refname,b.per_mob,b.brhid,d.visa_exp  from gl_drdetails d  left join "
						+ "gl_rdriver rd on (d.dr_id=rd.drid) left join gl_ragmt ra on (ra.doc_no=rd.rdocno) left join my_acbook b on(d.cldocno=b.doc_no and b.dtype='CRM') "
						+ "left join (select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on a.dr_id=d.dr_id left join gl_bcde bb on a.doc=bb.doc_no where b.status=3 "
						+ "and d.pass_exp<='"+sqlUpToDate+"' "+sql+" and ra.clstatus=0 and rd.status=3 union select  coalesce(bb.fdate,'') fdate,"
						+ "'ID Expired' document,d.visa_exp expirydate,d.dr_id sr_no,d.cldocno,d.name,b.refname,b.per_mob,b.brhid,d.visa_exp  from gl_drdetails d  left join "
						+ "gl_rdriver rd on (d.dr_id=rd.drid) left join gl_ragmt ra on (ra.doc_no=rd.rdocno) left join my_acbook b on(d.cldocno=b.doc_no and b.dtype='CRM') "
						+ "left join (select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on a.dr_id=d.dr_id left join gl_bcde bb on a.doc=bb.doc_no where b.status=3 "
						+ "and d.visa_exp<='"+sqlUpToDate+"' "+sql+" and ra.clstatus=0 and rd.status=3 union select  coalesce(bb.fdate,'') fdate,'Licence Expired' document,d.led expirydate,"
						+ "d.dr_id,d.cldocno,d.name,b.refname,b.per_mob,b.brhid,d.visa_exp from gl_drdetails d  left join gl_ldriver rd on (d.dr_id=rd.drid) left join gl_lagmt ra on (ra.doc_no=rd.rdocno) "
						+ "left join my_acbook b on(d.cldocno=b.doc_no and b.dtype='CRM') left join (select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on "
						+ "a.dr_id=d.dr_id left join gl_bcde bb on a.doc=bb.doc_no where b.status=3 and d.led<='"+sqlUpToDate+"' "+sql+" and ra.clstatus=0 and rd.status=3 union select  "
						+ "coalesce(bb.fdate,'') fdate,'Passport Expired' document,d.pass_exp expirydate,d.dr_id sr_no,d.cldocno,d.name,b.refname,b.per_mob,b.brhid,d.visa_exp  from gl_drdetails d  "
						+ "left join gl_ldriver rd on (d.dr_id=rd.drid) left join gl_lagmt ra on (ra.doc_no=rd.rdocno) left join my_acbook b on(d.cldocno=b.doc_no and b.dtype='CRM') "
						+ "left join (select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on a.dr_id=d.dr_id left join gl_bcde bb on a.doc=bb.doc_no where b.status=3 and d.pass_exp<="
						+ "'"+sqlUpToDate+"' "+sql+" and ra.clstatus=0 and rd.status=3 "
						+ " union select  coalesce(bb.fdate,'') fdate,'ID Expired' document,d.visa_exp expirydate,"
						+ "d.dr_id,d.cldocno,d.name,b.refname,b.per_mob,b.brhid,d.visa_exp from gl_drdetails d  left join gl_ldriver rd on (d.dr_id=rd.drid) left join gl_lagmt ra on (ra.doc_no=rd.rdocno) "
						+ "left join my_acbook b on(d.cldocno=b.doc_no and b.dtype='CRM') left join (select max(doc_no) doc,dr_id from gl_bcde group by dr_id) a on "
						+ "a.dr_id=d.dr_id left join gl_bcde bb on a.doc=bb.doc_no where b.status=3 and d.visa_exp<='"+sqlUpToDate+"' "+sql+" and ra.clstatus=0 and rd.status=3 "		
								+ "union select coalesce(bb.fdate,'') fdate,'Trade Licence Expired' document,b.contract_upto expirydate,0 sr_no,b.cldocno,"
						+ "coalesce(b.contractno,'') name,b.refname,b.per_mob,b.brhid,d.visa_exp  from my_acbook b left join gl_drdetails d on(d.cldocno=b.doc_no and b.dtype='CRM') left join (select max(doc_no) doc,cldocno from gl_bcde group by cldocno) a on a.cldocno=b.cldocno "
						+ "left join gl_bcde bb on a.doc=bb.doc_no where b.status=3 and b.contract_upto<='"+sqlUpToDate+"') aa";	
				
				
				//System.out.println("qwertyui"+sql);
				ResultSet resultSet = stmtCRM.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
				
				stmtCRM.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
}
