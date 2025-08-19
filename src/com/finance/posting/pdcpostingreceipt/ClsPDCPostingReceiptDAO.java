package com.finance.posting.pdcpostingreceipt;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.finance.interbranchtransactions.ibjournalvouchers.ClsIbJournalVouchersDAO;
import com.finance.transactions.journalvouchers.ClsJournalVouchersDAO;

public class ClsPDCPostingReceiptDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsPDCPostingReceiptBean pdcPostingReceiptBean = new ClsPDCPostingReceiptBean();
	
	  public int insert(String formdetailcode,String cmbcriteria,Date pdcDate,String txtchqno,String txtrowno,String txttrno,String txtdtype, int txtgriddocno, Date chequeDate, 
			  int txtbankdocno, int txtposttrno, ArrayList<String> pdcreceiptarray, HttpSession session,HttpServletRequest request, String mode) throws SQLException {
		  
		  Connection conn  = null;
		  
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtFRO = conn.createStatement();
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
	        
	        int docno = 0;
	        int trno = 0;
			String descriptioncriteria = "";
			
			if(cmbcriteria.equalsIgnoreCase("1")){descriptioncriteria="POSTED";}else if(cmbcriteria.equalsIgnoreCase("2")){descriptioncriteria="PDC RETURNED";}
			else if(cmbcriteria.equalsIgnoreCase("3")){descriptioncriteria="PDC DISHONURED";}else if(cmbcriteria.equalsIgnoreCase("5")){descriptioncriteria="PDC REVERSED";}
			else if(cmbcriteria.equalsIgnoreCase("6")){descriptioncriteria="DISHONURED PDC REVERSED";}else if(cmbcriteria.equalsIgnoreCase("7")){descriptioncriteria="CDC DISHONURED";}
			
			/*Inserting into my_jvma and my_jvtran*/
			if((cmbcriteria.equalsIgnoreCase("1") || cmbcriteria.equalsIgnoreCase("2") || cmbcriteria.equalsIgnoreCase("3") || cmbcriteria.equalsIgnoreCase("7")) && (txtdtype.equalsIgnoreCase("BRV")|| txtdtype.equalsIgnoreCase("OPR"))){
				String[] journalvoucher=pdcreceiptarray.get(0).split("::");
		
				ClsJournalVouchersDAO jvt = new ClsJournalVouchersDAO();
				Double amount = ((journalvoucher[4].equalsIgnoreCase("undefined") || journalvoucher[4].equalsIgnoreCase("NaN") || journalvoucher[4].isEmpty()?0.0:Double.parseDouble(journalvoucher[4]))); 
				docno=jvt.insert(pdcDate,"JVT".concat("-3"), txtdtype+"-"+txtgriddocno, txtdtype+"-"+txtgriddocno+" Cheque No. - "+txtchqno+" is "+descriptioncriteria+" on "+pdcDate ,amount, amount, pdcreceiptarray, session, request);
				    
				trno=Integer.parseInt(request.getAttribute("tranno").toString());

			}
			
			if((cmbcriteria.equalsIgnoreCase("1") || cmbcriteria.equalsIgnoreCase("2") || cmbcriteria.equalsIgnoreCase("3") || cmbcriteria.equalsIgnoreCase("7")) && txtdtype.equalsIgnoreCase("IBR")){
				String[] journalvoucher=pdcreceiptarray.get(0).split("::");
				
				ClsIbJournalVouchersDAO ijv = new ClsIbJournalVouchersDAO();
				Double amount = ((journalvoucher[4].equalsIgnoreCase("undefined") || journalvoucher[4].equalsIgnoreCase("NaN") || journalvoucher[4].isEmpty()?0.0:Double.parseDouble(journalvoucher[4])));
					
				ArrayList<String> pdcreceiptsarray= new ArrayList<String>();
				for(int i=0;i<pdcreceiptarray.size();i++){
					String temp=pdcreceiptarray.get(i);
					pdcreceiptsarray.add(temp+":: "+branch);
				}
				
					docno=ijv.insert(pdcDate,"IJV", txtdtype+"-"+txtgriddocno, txtdtype+"-"+txtgriddocno+" Cheque No. "+txtchqno+" is "+descriptioncriteria+" on "+pdcDate , amount, amount, pdcreceiptsarray, session, request,mode);
					
					trno=Integer.parseInt(request.getAttribute("tranno").toString());
			}
			/*Inserting my_jvma and my_jvtran Ends*/
			
			if(cmbcriteria.equalsIgnoreCase("2") || cmbcriteria.equalsIgnoreCase("3")){
				 int ap_trid=0;
				 double amount=0.00,outamount=0.00;
		
				 /*Selecting Tran-Id*/
				  ArrayList<String> tranidarray=new ArrayList<>();
				  String sql1="SELECT TRANID FROM my_jvtran where out_amount!=0 and TR_NO="+trno+" and acno="+txtbankdocno+"";
				  ResultSet resultSet=stmtFRO.executeQuery(sql1);
				  
				  while(resultSet.next()){
				   tranidarray.add(resultSet.getString("tranid"));
				  }
				  /*Selecting Tran-Id Ends*/
				  
				  /*Selecting Ap_Tran-Id*/
				  ArrayList<String> outamtarray=new ArrayList<>();

				  for(int i=0;i<tranidarray.size();i++){
				   String sql2="select ap_trid,amount from my_outd where tranid="+tranidarray.get(i);
				   ResultSet resultSet1=stmtFRO.executeQuery(sql2);
				   
				   while(resultSet1.next()){
				    outamtarray.add(resultSet1.getInt("ap_trid")+"::"+resultSet1.getDouble("amount"));
				   } 

				  }
				  /*Selecting Ap_Tran-Id*/

				  for(int i=0;i<outamtarray.size();i++){
				   
				   ap_trid=Integer.parseInt(outamtarray.get(i).split("::")[0]);
				   amount=Double.parseDouble(outamtarray.get(i).split("::")[1]);

				   String sql4="update my_jvtran set out_amount=out_amount-("+amount+"*id) where tranid="+ap_trid+"";
				   int data1=stmtFRO.executeUpdate(sql4);
				   
				  }
				/*Apply-Invoicing Grid Updating Ends*/
				  
				 if(!(tranidarray.size()==0)){
					 
				    /*Selecting outamount*/
				     String sql5="select sum(amount) outamount from my_outd where tranid="+tranidarray.get(0)+"";
				     ResultSet resultSet2=stmtFRO.executeQuery(sql5);
				   
				     while(resultSet2.next()){
					   outamount= resultSet2.getDouble("outamount");
				     }
				    /*Selecting outamount Ends*/
				   
				     String sql4="update my_jvtran set out_amount=out_amount-("+outamount+"*id) where tranid="+tranidarray.get(0)+"";
				     int data3=stmtFRO.executeUpdate(sql4);
					   
					 /*Deleting from my_outd*/
					  String sql3="delete from my_outd where tranid="+tranidarray.get(0)+"";
					  int data2=stmtFRO.executeUpdate(sql3);
					 /*Deleting from my_outd Ends*/
					  
				  }
			}
			
			if(cmbcriteria.equalsIgnoreCase("4")){
				
				String sql="Update my_chqdet set chqdt='"+chequeDate+"' where tr_no="+txttrno+"";
				int data = stmtFRO.executeUpdate(sql);
				if(data<=0){
					stmtFRO.close();
					conn.close();
					return 0;
				}
				
				/*Inserting into datalog*/
				String sql2=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtgriddocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','A')");
				int datas = stmtFRO.executeUpdate(sql2);
				/*Inserting into datalog Ends*/
				
				request.setAttribute("tranno", 0);
				
				conn.commit();
				stmtFRO.close();
				conn.close();
				return 1;
			}
			
		    String criteria="";
		    if(cmbcriteria.equalsIgnoreCase("5") || cmbcriteria.equalsIgnoreCase("6") || cmbcriteria.equalsIgnoreCase("7")){
		    	
		    if(cmbcriteria.equalsIgnoreCase("5")){
		    	criteria="E";
		    	
				String sql="update my_jvma set status=7 where tr_no="+txtposttrno+"";
				int data = stmtFRO.executeUpdate(sql);
				
				String sql1="update my_jvtran set status=7 where tr_no="+txtposttrno+"";
				int data1 = stmtFRO.executeUpdate(sql1);
				
				request.setAttribute("tranno", 0);
				
			}
			else if(cmbcriteria.equalsIgnoreCase("6")){
				criteria="P";
				
				String sql="update my_jvma set status=7 where tr_no="+txtposttrno+"";
				int data = stmtFRO.executeUpdate(sql);
				
				String sql1="update my_jvtran set status=7 where tr_no="+txtposttrno+"";
				int data1 = stmtFRO.executeUpdate(sql1);
				
				request.setAttribute("tranno", 0);
			}
			else if(cmbcriteria.equalsIgnoreCase("7")){
				criteria="D";
				
				int ap_trid=0;
				 double amount=0.00,outamount=0.00;
		
				 /*Selecting Tran-Id*/
				  ArrayList<String> tranidarray=new ArrayList<>();
				  String sql1="SELECT TRANID FROM my_jvtran where out_amount!=0 and TR_NO="+trno+" and acno="+txtbankdocno+"";
				  ResultSet resultSet=stmtFRO.executeQuery(sql1);
				  
				  while(resultSet.next()){
				   tranidarray.add(resultSet.getString("tranid"));
				  }
				  /*Selecting Tran-Id Ends*/
				  
				  /*Selecting Ap_Tran-Id*/
				  ArrayList<String> outamtarray=new ArrayList<>();

				  for(int i=0;i<tranidarray.size();i++){
				   String sql2="select ap_trid,amount from my_outd where tranid="+tranidarray.get(i);
				   ResultSet resultSet1=stmtFRO.executeQuery(sql2);
				   
				   while(resultSet1.next()){
				    outamtarray.add(resultSet1.getInt("ap_trid")+"::"+resultSet1.getDouble("amount"));
				   } 

				  }
				  /*Selecting Ap_Tran-Id*/
				  for(int i=0;i<outamtarray.size();i++){
				   
				   ap_trid=Integer.parseInt(outamtarray.get(i).split("::")[0]);
				   amount=Double.parseDouble(outamtarray.get(i).split("::")[1]);

				   String sql4="update my_jvtran set out_amount=out_amount-("+amount+"*id) where tranid="+ap_trid+"";
				   int data1=stmtFRO.executeUpdate(sql4);
				   
				  }
				/*Apply-Invoicing Grid Updating Ends*/
				  
				 if(!(tranidarray.size()==0)){
					 
				    /*Selecting outamount*/
				     String sql5="select sum(amount) outamount from my_outd where tranid="+tranidarray.get(0)+"";
				     ResultSet resultSet2=stmtFRO.executeQuery(sql5);
				   
				     while(resultSet2.next()){
					   outamount= resultSet2.getDouble("outamount");
				     }
				    /*Selecting outamount Ends*/
				   
				     String sql4="update my_jvtran set out_amount=out_amount-("+outamount+"*id) where tranid="+tranidarray.get(0)+"";
				     int data3=stmtFRO.executeUpdate(sql4);
					   
					 /*Deleting from my_outd*/
					  String sql3="delete from my_outd where tranid="+tranidarray.get(0)+"";
					  int data2=stmtFRO.executeUpdate(sql3);
					 /*Deleting from my_outd Ends*/
					  
				  }
			}
		   
		   /*Updating Status in my_chqdet*/
				String sql1="Update my_chqdet set status='"+criteria+"' where rowno="+txtrowno+" and tr_no="+txttrno+"";
				int data1 = stmtFRO.executeUpdate(sql1);
			/*Updating my_chqdet Ends*/
			
			/*Inserting into datalog*/
			String sql3=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtgriddocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','A')");
			int datas = stmtFRO.executeUpdate(sql3);
			/*Inserting into datalog Ends*/
			
			conn.commit();
			stmtFRO.close();
			conn.close();
			return 1;
		    }
			
			if(docno>0){
				
				String sqls="select now() as dcurdate";
				ResultSet resultSet = stmtFRO.executeQuery(sqls);
			    String edate="";
				 while (resultSet.next()) {
					edate=resultSet.getString("dcurdate");
				 } 
				 
				String[] journalvouchers=pdcreceiptarray.get(0).split("::");
				String acno = (journalvouchers[0].equalsIgnoreCase("undefined") || journalvouchers[0].equalsIgnoreCase("NaN") || journalvouchers[0].isEmpty()?0:journalvouchers[0]).toString();
				String[] journal=pdcreceiptarray.get(1).split("::");
				String postacno = (journal[0].equalsIgnoreCase("undefined") || journal[0].equalsIgnoreCase("NaN") || journal[0].isEmpty()?0:journal[0]).toString();
				
				if(cmbcriteria.equalsIgnoreCase("1")){
					criteria="P";
					String sql="insert into my_postm(tr_no,bank_row,postacno,edate,postType,brhId,bankacno) values("+trno+","+txtrowno+","+postacno+",'"+edate+"','"+criteria+"',"+branch+","+acno+")";
					int data = stmtFRO.executeUpdate(sql);
				}
				else if(cmbcriteria.equalsIgnoreCase("2")){
					criteria="R";
				}
				
				else if(cmbcriteria.equalsIgnoreCase("3")){
					criteria="D";
					
					/*Updating Last Tr No in my_postm*/
					String sql1="Update my_postm set last_trno="+txtposttrno+",tr_no="+trno+" where tr_no="+txtposttrno+"";
					int data1 = stmtFRO.executeUpdate(sql1);
					
					/*Updating my_postm Ends*/
				}
				
				/*Updating Status in my_chqdet*/
				String sql1="Update my_chqdet set status='"+criteria+"',postno="+docno+",pdcposttrno="+trno+" where rowno="+txtrowno+" and tr_no="+txttrno+"";
				int data1 = stmtFRO.executeUpdate(sql1);
				/*Updating my_chqdet Ends*/
				
				/*Inserting into datalog*/
				String sql3=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtgriddocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
				int datas = stmtFRO.executeUpdate(sql3);
				/*Inserting into datalog Ends*/
				
				conn.commit();
				stmtFRO.close();
				conn.close();
				return docno;
			}
		stmtFRO.close();
		conn.close();	
	 }catch(Exception e){	
		 	e.printStackTrace();	
		 	conn.close();
		 	return 0;
	 }finally{
		 conn.close();
	 }
		return 0;
	}

	public JSONArray accountsDetails(HttpSession session,String atype,String accountno,String accountname,String mobile,String currency,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
		       conn = connDAO.getMyConnection();
		       Statement stmtFRO = conn.createStatement();
	
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
	           String branch=session.getAttribute("BRANCHID").toString();
	           String company = session.getAttribute("COMPANYID").toString();
	           
		        String sqltest="";
		        String sql="";
		        
		        String code= "";
				
				if(atype.equalsIgnoreCase("AP")){
					code="VND";
				}
				else if(atype.equalsIgnoreCase("AR")){
					code="CRM";
				}
		        
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        if(!(mobile.equalsIgnoreCase("0")) && !(mobile.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and a1.per_mob like '%"+mobile+"%'";
		        }
		        if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and c.code like '%"+currency+"%'";
			    }
		        
		        if(check.equalsIgnoreCase("1")){
		        	
	        	if(atype.equalsIgnoreCase("BANK")){
	        		sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate from my_head t,"
	                		+ "(select curId from my_brch where doc_no=  '"+branch+"') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
	                		+ "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') and den='305'"+sqltest;
					}else{
			       /* sql= "select (@i:=@i+1) recno,t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate,if(a1.per_mob=0,a1.per_tel,a1.per_mob) mobile from my_head t,my_acbook a1, "
					    + "my_curr c,(select curId from my_brch where doc_no= '"+branch+"') h, (select (@i:=0)) a where  a1.active=1 and t.m_s=0 and c.doc_no=t.curId "
					    + "and t.cldocno=a1.cldocno and a1.dtype='"+code+"' and t.atype='"+atype+"' and c.doc_no=if(a1.brhId=0 and a1.curId=0,h.curId,if(a1.curId=0,h.curId,a1.curid)) and "
					    + "a1.cmpid in(0,'"+company+"') and a1.brhid in(0,'"+branch+"')"+sqltest;*/
						
						/***
						 * query changed branch and compy condition removed 
						 * 2018-08-02
						 * sudheesh
						 */
						 sql= "select (@i:=@i+1) recno,t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate,if(a1.per_mob=0,a1.per_tel,a1.per_mob) mobile from my_head t,my_acbook a1, "
								    + "my_curr c,(select curId from my_brch where doc_no= '"+branch+"') h, (select (@i:=0)) a where  a1.active=1 and t.m_s=0 and c.doc_no=t.curId "
								    + "and t.cldocno=a1.cldocno and a1.dtype='"+code+"' and t.atype='"+atype+"' and c.doc_no=if(a1.brhId=0 and a1.curId=0,h.curId,if(a1.curId=0,h.curId,a1.curid))  "
								    + ""+sqltest;
				}
	        	System.out.println("sql___________________"+sql);

	           ResultSet resultSet = stmtFRO.executeQuery(sql);
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
	           
		       stmtFRO.close();
		       conn.close();
		       }
		      stmtFRO.close();
			  conn.close();   
	     }catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     }finally{
			 conn.close();
		 }
	       return RESULTDATA;
	  }
	
	public JSONArray applyInvoiceGridReloading(HttpSession session,String cmbcriteria,String txtaccid,String cmbacctype,String fromDate,String toDate,String check) throws SQLException {
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
        String branch=session.getAttribute("BRANCHID").toString();
        String code=session.getAttribute("Code").toString().trim();
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtFRO = conn.createStatement();
				
				String selacno;
				java.sql.Date sqlFromDate=null;
				java.sql.Date sqlToDate=null;
			        
				fromDate.trim();
		        if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0")))
		        {
		        	sqlFromDate = commonDAO.changeStringtoSqlDate(fromDate);
		        }
		        
		        toDate.trim();
		        if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0")))
		        {
		        	sqlToDate = commonDAO.changeStringtoSqlDate(toDate);
		        }
			        
				String xsql = "";
				
				if(cmbcriteria.equalsIgnoreCase("1") || cmbcriteria.equalsIgnoreCase("4"))
	    		{
	    			/*PDC to be posted & PDC to be postponed*/
	    			xsql+=" and q.status='E' and q.PDC=1";
	    			//xpostmode=3;
	    		}
				
	    		else if(cmbcriteria.equalsIgnoreCase("2"))
	    		{
	    			/*PDC to be returned*/
	    			xsql+=" and q.status='E' and q.PDC=1";
	    			//xpostmode=2;
	    		}
	    		
	    		else if(cmbcriteria.equalsIgnoreCase("3"))
	    		{
	    			/*Posted PDC to be dishonoured*/
		    		xsql+=" and q.status='P' and q.PDC=1";
		    		//xpostmode=4;
	    		}
	    		else if(cmbcriteria.equalsIgnoreCase("5"))
	    		{
	    			/*Retuned PDC to be reversed*/
	    			xsql+=" and q.status='R' ";
	    			//xpostmode=5;
	    		}
	    		else if(cmbcriteria.equalsIgnoreCase("6"))
	    		{
	    			/*Dishourned PDC to be reversed*/
	    			xsql+=" and q.status='D' and q.PDC=1";
	    			//xpostmode=6;
	    		}
		        
	    		else if(cmbcriteria.equalsIgnoreCase("7"))
	            {
	    			/*Current date cheque to be dishonoured*/ 
	            	xsql+=" and q.status='P' and q.PDC=0";
	            	//xpostmode=1;
	            }
		        
				 if (code.trim().equalsIgnoreCase("FPP"))
				        xsql+=" and m.dtype in ('BPV','IBP','COT','OPP')";
			        else
			        	xsql+=" and  m.dtype in ('BRV','IBR','OPR')";  
	        
			    if(!(cmbcriteria.equalsIgnoreCase("1") || cmbcriteria.equalsIgnoreCase("4"))){
			        if(!(sqlFromDate==null)){
			        	xsql+=" and q.chqdt>='"+sqlFromDate+"'";
				    }
			    }
		    
		        if(!(sqlToDate==null)){
		        	xsql+=" and q.chqdt<='"+sqlToDate+"'";
			    }
		        
		        if(!(txtaccid.equalsIgnoreCase("0") || txtaccid.equalsIgnoreCase("")))	    
	            {selacno=txtaccid;
	            
	            if(cmbacctype.equalsIgnoreCase("Bank"))
	            	xsql+=" and (d.acno='"+txtaccid+"' or h3.doc_no='"+txtaccid+"')";else  xsql+=" and q.opsacno='"+txtaccid+"'";
	            }
            
				if(cmbcriteria.equalsIgnoreCase("3") || cmbcriteria.equalsIgnoreCase("6")) {
					
					xsql = "select (@i:=@i+1) sr_no,m.dtype,q.tr_no,q.rowno,d.doc_no,d.date,d.description desc1,h1.account bank,h1.description bankname,"  
						 + "d.acno bankacno,q.opsacno acno,h2.atype,h2.account,h2.description accountname,q.pdcposttrno,d.curid,d.rate,"  
						 + "if(d.dramount<0,d.dramount*-1,d.dramount) tr_dr,if(d.dramount<0,(d.dramount*d.rate*-1),d.dramount*d.rate) lamount,"  
						 + "c.code curr,d.brhid,b1.branch,c.type currtype,q.chqdt,q.chqno,b1.branchname from my_chqdet q inner join my_jvtran d on "  
						 + "q.pdcposttrno=d.tr_no left join my_chqbm m on m.tr_no=q.tr_no inner join (select account,description,doc_no from my_head "  
						 + "where den='305') h1 on d.acno=h1.doc_no inner join (select account,description,doc_no,atype from my_head where den<>'305') h2 "  
						 + "on q.opsacno=h2.doc_no inner join my_brch b1 on d.brhid=b1.doc_no inner join my_curr c on d.curId=c.doc_no "
						 + "left join (select (@i:=0) x) a on x=0 WHERE m.docstat!=7 and d.status=3 and m.brhID='"+branch+"'" + xsql;
					
		        } else if(cmbcriteria.equalsIgnoreCase("7")) {
					
					xsql = "select (@i:=@i+1) sr_no,r.dtype,q.tr_no,q.rowno,d.doc_no,d.date,d.description,h1.account bank,h1.description bankname,d.acno bankacno,q.opsacno acno,"  
						 + "q.pdcposttrno,h2.atype,h2.account,h2.description accountname,d.curid,d.rate,if(d.dramount<0,d.dramount*-1,d.dramount) tr_dr,if(d.dramount<0,(d.dramount*d.rate*-1),d.dramount*d.rate) lamount,"  
						 + "c.code curr,d.brhid,c.type currtype,q.chqdt,q.chqno,b1.branchname from gl_rentreceipt r inner join my_chqdet q on r.tr_no=q.tr_no "  
						 + "inner join my_jvtran d on r.posttrno=d.tr_no inner join my_chqbm m on m.tr_no=d.tr_no inner join "  
						 + "(select account,description,doc_no from my_head where den='305') h1 on d.acno=h1.doc_no and d.id>0 inner join my_head h2 "  
						 + "on r.cldocno=h2.cldocno and h2.atype='AR' inner join my_brch B1 on d.brhid=b1.doc_no inner join my_curr c on d.curId=c.doc_no "  
						 + "left join (select (@i:=0) x) a on x=0 WHERE m.docstat!=7 and d.status=3 and r.posttype is not null and m.brhID='"+branch+"' and r.dtype in "  
						 + "('BRV','IBR','OPR') and q.status='E' and q.PDC=0 and q.chqdt>='"+sqlFromDate+"' and q.chqdt<='"+sqlToDate+"' UNION ALL "  
						 + "SELECT (@i:=@i+1) sr_no,M.dtype,d.tr_no,d.rowno,m.doc_no,m.date,m.desc1 description,h1.account bank,h1.description bankname,"  
						 + "d.acno bankacno,if(q.opsacno=0,h3.doc_no,q.opsacno) acno,q.pdcposttrno,if(q.opsacno=0,h3.atype,h2.atype) atype,if(q.opsacno=0,h3.account,h2.account) "  
						 + "account,if(q.opsacno=0,h3.description,h2.description) accountname,d.curId,d.rate rate,d.amount*d.dr tr_dr," 
						 + "d.lamount*d.lbrRate*d.dr lamount,c.code curr,d.brhId,c.type currtype,q.chqdt,q.chqno,B1.branchname FROM my_chqbm M "  
						 + "inner join my_chqbd D on m.tr_no=d.tr_no and D.GRIDID<=1 left join my_chqbd D1 on (m.tr_no=d1.tr_no and d1.sr_no=2) inner join "  
						 + "my_brch B1 on d.brhid=b1.doc_no inner join my_curr c on d.curId=c.doc_no inner join (select account,description,doc_no from my_head "  
						 + "where den='305') h1 on d.acno=h1.doc_no inner join my_chqdet q on d.rowno=q.rowno left join my_head h2 on q.opsacno=h2.doc_no "  
						 + "left join my_head h3 on (d1.acno=h3.doc_no and d1.sr_no=2) left join gl_rentreceipt r on r.tr_no=m.tr_no left join (select (@i:=0) x) a on x=0 "
						 + "WHERE  m.docstat!=7 and m.status=3 and m.brhID='"+branch+"' and q.status='E' and q.PDC=0 and  m.dtype in ('BRV','IBR','OPR') and q.chqdt>='"+sqlFromDate+"' "
						 + "and q.chqdt<='"+sqlToDate+"' and r.tr_no is null";
		        
		        } else {
		        
					xsql = "SELECT (@i:=@i+1) sr_no,M.dtype,d.tr_no,d.rowno,m.doc_no,m.date,m.desc1,h1.account bank,h1.description bankname,if(q.opsacno=0,h3.doc_no,q.opsacno) acno,"
							+ "q.pdcposttrno,if(q.opsacno=0,h3.atype,h2.atype) atype,if(q.opsacno=0,h3.account,h2.account) account,if(q.opsacno=0,h3.description,h2.description) accountname,"
							+ "d.acno bankacno,d.curId,d.rate rate,d.amount*d.dr tr_dr,d.lamount*d.lbrRate*d.dr lamount,c.code curr,d.brhId,b1.branch,"
							+ "c.type currtype,q.chqdt,q.chqno,B1.branchname FROM my_chqbm M inner join my_chqbd D on m.tr_no=d.tr_no and D.GRIDID<=1 left join my_chqbd D1 on (m.tr_no=d1.tr_no and d1.sr_no=2) "
							+ "inner join my_brch B1 on d.brhid=b1.doc_no inner join my_curr c on d.curId=c.doc_no inner join (select account,description,doc_no from my_head where den='305') h1 "
							+ "on d.acno=h1.doc_no inner join my_chqdet q on d.rowno=q.rowno left join my_head h2 on q.opsacno=h2.doc_no left join my_head h3 on (d1.acno=h3.doc_no and d1.sr_no=2) left join "
							+ "(select (@i:=0) x) a on x=0 WHERE  m.docstat!=7 and m.status=3 and m.brhID='"+branch+"'"+ xsql;
				
		        }
				
				System.out.println("xsql ==== "+xsql);
				ResultSet resultSet = stmtFRO.executeQuery(xsql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtFRO.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray applyingInvoiceGridLoading(String trno,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
        Connection conn = null;
		
        try {
				conn = connDAO.getMyConnection();
				Statement stmtFRO = conn.createStatement();
				
				if(!(trno.trim().equalsIgnoreCase("0")||trno.trim().equalsIgnoreCase(""))){
					
				String sql = "SELECT j.acno doc_no,j.description,j.brhid sr_no,j.curId currencyid,round(j.rate,2) rate,CONVERT(if(j.dramount>0,round(j.dramount*j.id,2),' '),CHAR(50)) debit ,"
						+ "CONVERT(if(j.dramount<0,round(j.dramount*j.id,2),' '),CHAR(50)) credit,round(j.ldramount*j.id,2) baseamount,j.ref_row,j.costtype,j.costcode,j.id,"
						+ "c.costgroup,t.atype,t.account account,t.description accountname,t.gr_type grtype,cr.type currencytype FROM my_jvtran j left join "
						+ "my_costunit c on j.costtype=c.costtype left join my_head t on j.acno=t.doc_no left join my_curr cr on cr.doc_no=j.curId WHERE "
						+ "j.tr_no="+trno+"";

				ResultSet resultSet = stmtFRO.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);

				stmtFRO.close();
				conn.close();
				}
			stmtFRO.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray journalVoucherGridSearch(String type,String accountno,String accountname,String currency,String date,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
		       conn = connDAO.getMyConnection();
		       Statement stmtFRO = conn.createStatement();
	
		        String sqltest="";
		        String sql="";
		        java.sql.Date sqlDate=null;
		        
		        date.trim();
		           if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
		           {
		        	   sqlDate = commonDAO.changeStringtoSqlDate(date);
		           }
		        
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and c.code like '%"+currency+"%'";
			    }
		        
		        if(check.equalsIgnoreCase("1")){
		        	
		        	sql="select t.doc_no,t.account,t.description,t.gr_type,c.code curr,c.doc_no curid,c.type,round(cb.rate,2) c_rate from my_head t left join my_curr c "
							+ "on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,"
							+ "cr.frmDate from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo "
							+ "on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where t.atype='"+type+"' and t.m_s=0 and t.den='305'"+sqltest;
		        	
		       ResultSet resultSet = stmtFRO.executeQuery(sql);
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
	           
		       stmtFRO.close();
		       conn.close();
		       }
		        stmtFRO.close();
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