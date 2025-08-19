package com.operations.commtransactions.travelinvoice;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.agreement.rentalagreement.ClsRentalAgreementBean;
import com.operations.marketing.enquiry.ClsEnquiryBean;

public class ClsTravelInvoiceDAO {
	ClsConnection connDAO=new ClsConnection();
	ClsCommon CommonDAO=new ClsCommon();
	Connection conn;   
	public int insert(Date sqlStartDate,String reftype,String refno,String clid,String clname,String type, 
			String remarks,ArrayList<String> journalvouchersarray,HttpSession session,String mode,String Dtype,String branch,HttpServletRequest request) throws SQLException {
		try{
			int docno;
			conn=connDAO.getMyConnection();  
			conn.setAutoCommit(false);
			if(branch.equalsIgnoreCase("") || branch==null){
				branch="0";       
			}
			CallableStatement stmtInvoice = conn.prepareCall("{call tr_travelInvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");              
			stmtInvoice.registerOutParameter(12, java.sql.Types.INTEGER);
			stmtInvoice.registerOutParameter(13, java.sql.Types.INTEGER);      
			stmtInvoice.setDate(1,sqlStartDate);
			stmtInvoice.setString(2,reftype);    
			stmtInvoice.setString(3,refno);
			stmtInvoice.setString(4,clid);
			stmtInvoice.setString(5,clname);
			stmtInvoice.setString(6,type);
			stmtInvoice.setString(7,remarks);
			stmtInvoice.setString(8,mode);
			stmtInvoice.setString(9,Dtype.trim());
			stmtInvoice.setString(10,session.getAttribute("USERID").toString());
			stmtInvoice.setString(11,branch);     
			stmtInvoice.executeQuery();
			docno=stmtInvoice.getInt("docNo");    
			int vocno=stmtInvoice.getInt("vocNo");	
			request.setAttribute("vocno", vocno);   
			int total=0;     
			int tranno=0;
			if(docno<=0){
				 conn.close();
				return 0;
			}	
			if (docno > 0) {    
				 int trid=0,count=0,approvalStatus=0;
				 String trsql="SELECT coalesce(max(trno)+1,1) trno FROM my_trno m";
					ResultSet tass = stmtInvoice.executeQuery (trsql);
					if (tass.next()) {
						tranno=tass.getInt("trno");		
				     }  
					request.setAttribute("tranno", tranno);
					
				String sqls="select count(*) as icount from my_apprmaster where status=3 and dtype='"+Dtype+"'";      
				 ResultSet resultSets = stmtInvoice.executeQuery(sqls);
				 
				 while (resultSets.next()) {
					 count=resultSets.getInt("icount");
				 }
			
				 if(count==0){   
					 approvalStatus=3;
					}
					else{
						approvalStatus=0;
					}
				    request.setAttribute("trans",tranno);
					String trnosql="insert into my_trno(edate,trtype,brhId,USERNO,trno) values(now(),5,'"+branch+"','"+session.getAttribute("USERID").toString()+"','"+tranno+"')";
					int dd=stmtInvoice.executeUpdate(trnosql);
					 System.out.println("======dd======="+dd);     
					if(dd<=0){  
						conn.close();
						return 0;
					}

				/*Journal Voucher Grid Saving*/
				for(int i=0;i< journalvouchersarray.size();i++){
				String[] journalvoucher=journalvouchersarray.get(i).split("::");
				
				 if(!journalvoucher[0].equalsIgnoreCase("undefined") && !journalvoucher[0].equalsIgnoreCase("NaN")){
				
					String sql2="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,trtype,ref_row,LAGE,cldocno,lbrrate,id,costtype,costcode,"
						+ "dTYPE,brhId,tr_no,STATUS)VALUES('"+sqlStartDate+"','"+0+"','"+docno+"',"              
						+ "'"+(journalvoucher[0].trim().equalsIgnoreCase("undefined") || journalvoucher[0].trim().equalsIgnoreCase("NaN") || journalvoucher[0].trim().isEmpty()?0:journalvoucher[0].trim())+"',"
						+ "'"+(journalvoucher[1].trim().equalsIgnoreCase("undefined") || journalvoucher[1].trim().equalsIgnoreCase("NaN") || journalvoucher[1].trim().isEmpty()?0:journalvoucher[1].trim())+"',"
						+ "'"+(journalvoucher[2].trim().equalsIgnoreCase("undefined") || journalvoucher[2].trim().equalsIgnoreCase("NaN") || journalvoucher[2].trim().isEmpty()?0:journalvoucher[2].trim())+"',"
					    + "'"+(journalvoucher[3].trim().equalsIgnoreCase("undefined") || journalvoucher[3].trim().equalsIgnoreCase("NaN") || journalvoucher[2].trim().equals(0) || journalvoucher[3].trim().isEmpty()?1:journalvoucher[3].trim()).toString()+"',"
					    + "'"+(journalvoucher[4].trim().equalsIgnoreCase("undefined") || journalvoucher[4].trim().equalsIgnoreCase("NaN") || journalvoucher[4].trim().isEmpty()?0:journalvoucher[4].trim())+"',"
					    + "'"+(journalvoucher[5].trim().equalsIgnoreCase("undefined") || journalvoucher[5].trim().equalsIgnoreCase("NaN") || journalvoucher[5].trim().isEmpty()?0:journalvoucher[5].trim())+"',0,"
					    + "4,"+(i+1)+",0,0,"  
					    + "'"+(journalvoucher[3].trim().equalsIgnoreCase("undefined") || journalvoucher[3].trim().equalsIgnoreCase("NaN") || journalvoucher[3].trim().isEmpty()?0:journalvoucher[3].trim())+"',"
					    + "'"+(journalvoucher[7].trim().equalsIgnoreCase("undefined") || journalvoucher[7].trim().equalsIgnoreCase("NaN") || journalvoucher[7].trim().isEmpty()?0:journalvoucher[7].trim())+"',"
					    + "'"+(journalvoucher[8].trim().equalsIgnoreCase("undefined") || journalvoucher[8].trim().equalsIgnoreCase("NaN") || journalvoucher[8].trim().equalsIgnoreCase("") || journalvoucher[8].trim().isEmpty()?0:journalvoucher[8].trim())+"',"
					    + "'"+(journalvoucher[9].trim().equalsIgnoreCase("undefined") || journalvoucher[9].trim().equalsIgnoreCase("NaN") || journalvoucher[9].trim().equalsIgnoreCase("") || journalvoucher[9].trim().isEmpty()?0:journalvoucher[9].trim())+"',"
					    + "'"+Dtype+"','"+branch+"','"+tranno+"',"+approvalStatus+")";          
				int data = stmtInvoice.executeUpdate(sql2);
				 System.out.println("======data======="+data);     
				if(data<=0){
					stmtInvoice.close();
					conn.close();
					return 0;
				}
				
				 String sql3="SELECT TRANID FROM my_jvtran where TR_NO="+tranno+" and acno="+(journalvoucher[0].trim().equalsIgnoreCase("undefined") || journalvoucher[0].trim().equalsIgnoreCase("NaN") || journalvoucher[0].trim().isEmpty()?0:journalvoucher[0].trim());
				 ResultSet resultSet2 = stmtInvoice.executeQuery(sql3);
				    
				 while (resultSet2.next()) {
				 trid = resultSet2.getInt("TRANID");
				 }
				
				 if(!journalvoucher[8].equalsIgnoreCase("undefined") && !journalvoucher[8].trim().equalsIgnoreCase("") && !journalvoucher[8].trim().equalsIgnoreCase("0")){
				 String sql4="insert into my_costtran(acno,costtype,amount,sr_no,jobid,tranid,tr_no) values("+(journalvoucher[0].trim().equalsIgnoreCase("undefined") || journalvoucher[0].trim().equalsIgnoreCase("NaN") || journalvoucher[0].trim().isEmpty()?0:journalvoucher[0].trim())+","
				 		+ ""+(journalvoucher[8].trim().equalsIgnoreCase("undefined") || journalvoucher[8].trim().equalsIgnoreCase("NaN") || journalvoucher[8].trim().equalsIgnoreCase("") || journalvoucher[8].trim().isEmpty()?0:journalvoucher[8].trim())+","
				 	    + ""+(journalvoucher[5].trim().equalsIgnoreCase("undefined") || journalvoucher[5].trim().equalsIgnoreCase("NaN") || journalvoucher[5].trim().isEmpty()?0:journalvoucher[5].trim())+","+(i+1)+","
				 	    + ""+(journalvoucher[9].trim().equalsIgnoreCase("undefined") || journalvoucher[9].trim().equalsIgnoreCase("NaN") || journalvoucher[9].trim().isEmpty()?0:journalvoucher[9].trim())+","+trid+","+tranno+")";
				 
				 int data2 = stmtInvoice.executeUpdate(sql4);
				 System.out.println("======data2======="+data2);    
				 if(data2<=0){
					    stmtInvoice.close();
						conn.close();
						return 0;
					  }
				 	}
				 }              
			    }
				String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+tranno+"";
				 System.out.println("======total======="+sql1);  
				ResultSet resultSet = stmtInvoice.executeQuery(sql1);
			    
				 while (resultSet.next()) {
					 total=resultSet.getInt("jvtotal");
				 }
				 
				 if(total == 0){       
					conn.commit();    
					stmtInvoice.close();
					conn.close();
					return docno;
				 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtInvoice.close();
					    conn.close();  
					    return 0;
				    }
			}
			if (docno > 0) {
				conn.commit();
				stmtInvoice.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
		e.printStackTrace();
			conn.close();	
		}
		return 0;
	   }
	public int delete(int docno,String type,HttpSession session,String Dtype,String branch,HttpServletRequest request) throws SQLException {
		Connection conn = null;
		Statement stmt =null; 
		int val=0;
	try{
		conn=connDAO.getMyConnection();
		conn.setAutoCommit(false);
		stmt=conn.createStatement();  
		String sql="update tr_invoicem set status=7 where doc_no='"+docno+"'";   
		int val1 = stmt.executeUpdate(sql);  
		if(val1>0){
			if(type.equalsIgnoreCase("tour")){
				String sql1="update  tr_servicereqm set invtrno=0,cstatus=3 where invtrno='"+docno+"'";       
			    val = stmt.executeUpdate(sql1); 
			}else if(type.equalsIgnoreCase("ticket")){
				String sql2="update ti_ticketvoucherm m left join ti_ticketvoucherd d on (d.rdocno=m.doc_no) set d.invtrno=0 where d.invtrno='"+docno+"'";     
			    val = stmt.executeUpdate(sql2); 
			}else{
				String sql3="update ti_hotelvoucherm m left join ti_hotelvoucherd d on (d.rdocno=m.doc_no) set d.invtrno=0 where d.invtrno='"+docno+"'";         
			    val = stmt.executeUpdate(sql3); 
			}
			String sql4="update my_jvtran set status=7 where doc_no='"+docno+"' and dtype='TINV'";   
		    val = stmt.executeUpdate(sql4);      
		}
		if (val1 > 0) {  
			conn.commit();
			stmt.close();
			conn.close();
			return 1;
		}
		stmt.close();
		conn.close();
		return 0;
 }catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	 	return 0;
 }finally{
	 conn.close();
 }
}
   public   JSONArray searchClient(HttpSession session,String clname,String mob) throws SQLException {        
	   	 JSONArray RESULTDATA=new JSONArray();
	   	    Enumeration<String> Enumeration = session.getAttributeNames();
	   	    int a=0;
	   	    while(Enumeration.hasMoreElements()){
	   	     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
	   	      a=1;
	   	     }
	   	    }
	   	    if(a==0){
	   	  return RESULTDATA;
	   	     }
	   	 String brid=session.getAttribute("BRANCHID").toString();
	    	//System.out.println("name"+clname);
	    	String sqltest="";
	    	if(!(clname.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and refname like '%"+clname+"%'";
	    	}
	    	if(!(mob.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and per_mob like '%"+mob+"%'";
	    	}
	    	Connection conn = null;
			try {
					 conn = connDAO.getMyConnection();
					Statement stmtVeh1 = conn.createStatement ();
	            	
					String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);
					//System.out.println("========"+clsql);
					ResultSet resultSet = stmtVeh1.executeQuery(clsql);
					
					RESULTDATA=CommonDAO.convertToJSON(resultSet);
					stmtVeh1.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	 
	    public   JSONArray searchMaster(HttpSession session,String msdocno,String clnames,String reftype,String trdate,String types,String id) throws SQLException {
		   	    JSONArray RESULTDATA=new JSONArray();   
		   	    if(!id.equalsIgnoreCase("1")){     
		   	    		return RESULTDATA;
		   	     }
		    	 //  System.out.println("8888888888"+clnames); 	
		   	    String brid=session.getAttribute("BRANCHID").toString();
		    	java.sql.Date sqlStartDate=null;
		    	//enqdate.trim();
		    	if(!(trdate.equalsIgnoreCase("undefined"))&&!(trdate.equalsIgnoreCase(""))&&!(trdate.equalsIgnoreCase("0")))
		    	{
		    	sqlStartDate = CommonDAO.changeStringtoSqlDate(trdate);  
		    	}
		    	String sqltest="";
		    	if(!(msdocno.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and m.voc_no like '%"+msdocno+"%'";
		    	}
		    	if(!(clnames.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and m.refname like '%"+clnames+"%'";
		    	}
		    	if(!(reftype.equalsIgnoreCase(""))){
		    		sqltest=sqltest+" and m.reftype like '%"+reftype+"%'";
		    	}
		    	if(!(types.equalsIgnoreCase(""))){  
		    		sqltest=sqltest+" and m.types like '"+types+"%'";   
		    	}
		    	
		    	 if(!(sqlStartDate==null)){   
		    		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
		    	} 
		    	Connection conn = null;
				try { 
						conn = connDAO.getMyConnection();
						Statement stmtenq1 = conn.createStatement ();
						String clssql= ("select m.doc_no, m.voc_no, m.date, m.reftype, m.refno, m.cldocno, m.refname, m.types, m.remarks,convert(case when types='tour' then coalesce(s.doc_no,0) when types='ticket' then coalesce(t.docnos,0) when types='hotel' then coalesce(h.docnos,0) else 0 end,char(50))  serdocno from tr_invoicem m left join TR_servicereqm s on s.invtrno=m.doc_no left join (select group_concat(rowno) docnos,invtrno from ti_ticketvoucherd  group by invtrno) t on t.invtrno=m.doc_no left join (select group_concat(rowno) docnos,invtrno from ti_hotelvoucherd  group by invtrno) h on h.invtrno=m.doc_no  where m.status=3 and m.brhid="+brid+" " +sqltest);
						System.out.println("========"+clssql);          
						ResultSet resultSet = stmtenq1.executeQuery(clssql);
						RESULTDATA=CommonDAO.convertToJSON(resultSet);
						stmtenq1.close();
						conn.close();  
				}
				catch(Exception e){
					conn.close();
					e.printStackTrace();
				}
				//System.out.println(RESULTDATA);
		        return RESULTDATA;
		    }
		public JSONArray journalVoucherGridReloading(HttpSession session,String docNo,String check) throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        
	        if(!(check.equalsIgnoreCase("1"))){
	          	return RESULTDATA;
	          }
	        
	        Connection conn = null;
	        
	        Enumeration<String> Enumeration = session.getAttributeNames();
	        int a=0;
	        while(Enumeration.hasMoreElements()){
	        	if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
	        		a=1;
	        	}
	        }
	        if(a==0){
	    		return RESULTDATA;
	        	}
	        String branch = session.getAttribute("BRANCHID").toString();
	        
			try {
					conn = connDAO.getMyConnection();
					Statement stmtJVT = conn.createStatement();
				
					String sql="SELECT j.acno docno,j.description,j.curId currencyid,round(j.rate,2) rate,if(j.dramount>0,round(j.dramount*j.id,2),0)debit ,"   
							+ "if(j.dramount<0,round(j.dramount*j.id,2),0) credit,round(j.ldramount*j.id,2) baseamount,j.ref_row sr_no,j.costtype,j.costcode,c.costgroup,t.atype type,"
							+ "t.account accounts,t.description accountname1,t.gr_type grtype,cr.type currencytype FROM my_jvtran j left join my_costunit c on j.costtype=c.costtype left join "
							+ "my_head t on j.acno=t.doc_no left join my_curr cr on cr.doc_no=j.curId WHERE j.status<>7 and j.dtype='TINV' and j.brhId='"+branch+"' and j.doc_no='"+docNo+"'";
					ResultSet resultSet = stmtJVT.executeQuery (sql);    
					System.out.println("main query========="+sql);
					RESULTDATA=CommonDAO.convertToJSON(resultSet);
					
					stmtJVT.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				 conn.close();
			 }
			return RESULTDATA;
	    }
		public JSONArray tourGrid(String rdocno,String check) throws SQLException{  
			JSONArray data=new JSONArray();                   
			 if(!(check.equalsIgnoreCase("1"))){
		          	return data;
		          }
			Connection conn=null; 
			java.sql.Date edates = null;     
			try{   
				conn=connDAO.getMyConnection();    
				Statement stmt=conn.createStatement();        
				        
				String strsql="select m.tourdocno,acc.acno clientacno,h.sal_name salesagent,h.acc_no satacno,h.doc_no satdocno ,m.confirm,distype,adultdis,childdis,m.time,m.tourid,coalesce(m.rowno,0) rowno,name tourname,m.remarks,DATE_FORMAT(m.date,'%d.%m.%Y') date,coalesce(vendorid,0) vndid,ac.refname vendor,coalesce(m.adult,0) adult,coalesce(m.child,0) child,coalesce(m.spadult,0) spadult,coalesce(m.spchild,0) spchild,coalesce(m.adultval,0) adultval,coalesce(m.childval,0) childval,coalesce(m.total,0) total from tr_srtour m left join TR_servicereqm det on   det.doc_no=m.rdocno left join my_acbook acc on det.cldocno=acc.doc_no left join my_salesman h on h.doc_no=det.satdocno and sal_type='sla' left join my_acbook ac on m.vendorid=ac.doc_no left join tr_tours tr on m.tourid=tr.doc_no where rdocno="+rdocno+" group by m.rowno";           
				System.out.println("tourGridinvoice--->>>"+strsql);                                         
				ResultSet rs=stmt.executeQuery(strsql);
				data=CommonDAO.convertToJSON(rs);      
			}   
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();  
			}
			return data;
		} 
		public JSONArray loadHotelGrid(String brhid,String docno,String id,HttpSession session) throws SQLException{                 
			JSONArray data=new JSONArray();   
			if(!id.equalsIgnoreCase("1")){ 
				return data;
			}
			Connection conn=null; 
			java.sql.Date edates = null;     
			String sqltest="";
			try{ 
				conn=connDAO.getMyConnection();  
				Statement stmt=conn.createStatement();  
				/*if(!docno.equalsIgnoreCase("0") && !docno.equalsIgnoreCase("")){         
					sqltest=" and d.rowno in("+docno+")";       
				}*/
				/*if(!brhid.equalsIgnoreCase("0") && !brhid.equalsIgnoreCase("")){     
					sqltest=" and m.brhid='"+brhid+"'";       
				}*/  
				String strsql="select d.cpudoc,d.invtrno,d.cldocno,d.vnddocno,m.voc_no,coalesce(suptotal,0) suptotal, coalesce(servfee,0) servfee, coalesce(paybackamt,0) paybackamt, coalesce(sprice,0) sprice,d.rowno,suppconfno,DATE_FORMAT(issuedate,'%d.%m.%Y') issuedate,u1.user_name isstaff,cn.country_name country,cy.city_name city,ht.name hotel,d.roomtype,"
						+ "ac.refname customer,acc.refname vendor from ti_hotelvoucherm m left join ti_hotelvoucherd d on d.rdocno=m.doc_no  left join my_acbook ac on (ac.cldocno=d.cldocno and ac.dtype='CRM')"
						+ " left join my_acbook acc on (acc.cldocno=d.vnddocno and acc.dtype='VND')  left join my_user u1 on u1.doc_no=d.isstaffid  left join my_acountry cn on cn.doc_no=d.countryid"
						+ " left join my_acity cy on cy.doc_no=d.cityid left join tr_hotel ht on ht.doc_no=d.hotelid  where m.status<>7 and d.rowno in("+docno+")";
				System.out.println("strsql-------------->>>"+strsql);    
				ResultSet rs=stmt.executeQuery(strsql);  
				data=CommonDAO.convertToJSON(rs);  
			}   
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();  
			}
			return data;
		}
		public JSONArray loadTicketGrid(String brhid,String docno,String id,HttpSession session) throws SQLException{                        
			JSONArray data=new JSONArray(); 
			if(!id.equalsIgnoreCase("1")){
				return data;
			}
			Connection conn=null; 
			java.sql.Date edates = null;     
			String sqltest="";
			try{ 
				conn=connDAO.getMyConnection();  
				Statement stmt=conn.createStatement(); 
				/*if(!docno.equalsIgnoreCase("0") && !docno.equalsIgnoreCase("")){         
					sqltest=" and d.rowno in("+docno+")";       
				}*/
				/*if(!brhid.equalsIgnoreCase("0") && !brhid.equalsIgnoreCase("")){   
					sqltest=" and m.brhid='"+brhid+"'";       
				}*/   
				String strsql="select  d.cpudoc,d.invtrno,d.cldocno,d.vnddocno,m.voc_no,coalesce(suptotal,0) suptotal, coalesce(servfee,0) servfee, coalesce(paybackamt,0) paybackamt, coalesce(sprice,0) sprice,d.prnno,d.rowno,ticketno, d.cldocno, vnddocno, bookdate, issuedate, guest, ar.name airline, airlineid, sector, d.class classes, gds, bstaffid, tstaffid,u1.user_name bstaff,u2.user_name tstaff, issuetype, d.type, tickettype,"
						+ "ac.refname customer,acc.refname vendor from ti_ticketvoucherm m left join ti_ticketvoucherd d on d.rdocno=m.doc_no  left join my_acbook ac on (ac.cldocno=d.cldocno and ac.dtype='CRM')"
						+ " left join my_acbook acc on (acc.cldocno=d.vnddocno and acc.dtype='VND') left join ti_airline ar on ar.doc_no=d.airlineid left join my_user u1 on u1.doc_no=d.bstaffid "
						+ " left join my_user u2 on u2.doc_no=d.tstaffid where m.status<>7   and d.rowno in("+docno+")";    
				System.out.println("strsql-------------->>>"+strsql);   
				ResultSet rs=stmt.executeQuery(strsql);
				data=CommonDAO.convertToJSON(rs);  
			}   
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();  
			}
			return data;
		}
	    
}
