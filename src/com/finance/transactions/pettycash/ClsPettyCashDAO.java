package com.finance.transactions.pettycash;

import java.sql.CallableStatement;
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

import com.common.ClsAmountToWords;
import com.common.ClsApplyDelete;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsPettyCashDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsApplyDelete applyDeleteDAO = new ClsApplyDelete();
	ClsPettyCashBean pettyCashBean = new ClsPettyCashBean();
	
	  public int insert(Date pettyCashDate, String formdetailcode, String txtrefno,double txtrate,double txtamount, String txtdescription, ArrayList<String> pettycasharray,
			  HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		  	
		  	Connection conn = null;
		  	
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			int total = 0;
			
			CallableStatement stmtPC = conn.prepareCall("{CALL cashbmDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtPC.registerOutParameter(10, java.sql.Types.INTEGER);
			stmtPC.registerOutParameter(11, java.sql.Types.INTEGER);
			
			stmtPC.setDate(1,pettyCashDate);
			stmtPC.setString(2,txtrefno);
			stmtPC.setString(3,txtdescription);
			stmtPC.setDouble(4,txtamount);
			stmtPC.setDouble(5,txtrate);
			stmtPC.setString(6,formdetailcode);
			stmtPC.setString(7,company);
			stmtPC.setString(8,branch);
			stmtPC.setString(9,userid);
			stmtPC.setString(12,mode);
			int datas=stmtPC.executeUpdate();
			if(datas<=0){
				stmtPC.close();
				conn.close();
				return 0;
			}
			int docno=stmtPC.getInt("docNo");
			int trno=stmtPC.getInt("itranNo");
			request.setAttribute("tranno", trno);
			pettyCashBean.setTxtpettycashdocno(docno);
			if (docno > 0) {
				/*Insertion to my_cashbd,my_jvtran,my_outd*/
				int insertData=insertion(conn, docno, trno, formdetailcode, pettyCashDate, txtrefno, txtrate, txtdescription, txtamount, pettycasharray, session,mode);
				if(insertData<=0){
					stmtPC.close();
					conn.close();
					return 0;
				}
				/*Insertion to my_cashbd,my_jvtran,my_outd Ends*/
					
				String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
				ResultSet resultSet = stmtPC.executeQuery(sql1);
			    
				 while (resultSet.next()) {
				 total=resultSet.getInt("jvtotal");
				 }

				 if(total == 0){
					conn.commit();
					stmtPC.close();
					conn.close();
					return docno;
				 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtPC.close();
					    return 0;
				    }
			}
			
			stmtPC.close();
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
			
	
	public boolean edit(int txtpettycashdocno, String formdetailcode, Date pettyCashDate,String txtrefno, String txtdescription, double txtrate, double txtamount, 
			int txtdocno, int txttrno, ArrayList<String> pettycasharray,
			HttpSession session,String mode) throws SQLException {
		
		 	Connection conn = null;
		 	
		 try{
			    conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
			
				Statement stmtPC = conn.createStatement();
				if(mode.equalsIgnoreCase("EDIT")){
					mode="E";
				}
				
				int trno = txttrno,total=0;
			    
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				
				/*Applying Delete*/
				applyDeleteDAO.getFinanceApplyDelete(conn, trno);
				/*Applying Delete Ends*/
				
				/*Updating my_cashbm*/
                String sql=("update my_cashbm set date='"+pettyCashDate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',mrate='"+txtrate+"',trMode=2,totalAmount='"+txtamount+"',DTYPE='"+formdetailcode+"',cmpId='"+company+"',brhId='"+branch+"' where TR_NO='"+trno+"' and doc_no="+txtpettycashdocno);
                int data = stmtPC.executeUpdate(sql);
				if(data<=0){
					conn.close();
					return false;
				}
				/*Updating my_cashbm Ends*/
				
				/*Inserting into datalog*/
				String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtpettycashdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
				int datas = stmtPC.executeUpdate(sqls);
				/*Inserting into datalog Ends*/
			    
			    String sql3=("DELETE FROM my_cashbd WHERE TR_NO="+trno+"");
			    int data3 = stmtPC.executeUpdate(sql3);
			    	 
				 String sql4=("DELETE FROM my_jvtran WHERE TR_NO="+trno+"");
				 int data4 = stmtPC.executeUpdate(sql4);
				 
				 String sql6=("DELETE FROM my_costtran WHERE TR_NO="+trno+"");
				 int data6 = stmtPC.executeUpdate(sql6);
			    			    
			    int docno=txtpettycashdocno;
			    pettyCashBean.setTxtpettycashdocno(docno);
				if (docno > 0) {
				
					/*Insertion to my_cashbd,my_jvtran*/
					int insertData=insertion(conn, docno, trno, formdetailcode, pettyCashDate, txtrefno, txtrate, txtdescription, txtamount, pettycasharray, session,mode);
					if(insertData<=0){
						stmtPC.close();
						conn.close();
						return false;
					}
					/*Insertion to my_cashbd,my_jvtran Ends*/
					
					String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
					ResultSet resultSet = stmtPC.executeQuery(sql1);
				    
					 while (resultSet.next()) {
					 total=resultSet.getInt("jvtotal");
					 }

					 if(total == 0){
						conn.commit();
						stmtPC.close();
						conn.close();
						return true;
					 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtPC.close();
					    return false;
				    }
				}
				stmtPC.close();
			    conn.close();
		 }catch(Exception e){
			 	e.printStackTrace();
			 	conn.close();
			 	return false;
		 }finally{
			 conn.close();
		 }
			return false;
	}
	
	public boolean editMaster(int txtpettycashdocno,  String formdetailcode, Date pettyCashDate,String txtrefno, String txtdescription, double txtrate, double txtamount, 
			int txtdocno, int txttrno, HttpSession session) throws SQLException {
		 	
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtPC = conn.createStatement();

			int trno = txttrno;
		
		    String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			/*Updating my_cashbm*/
            String sql=("update my_cashbm set date='"+pettyCashDate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',mrate='"+txtrate+"',trMode=2,totalAmount='"+txtamount+"',DTYPE='"+formdetailcode+"',cmpId='"+company+"',brhId='"+branch+"' where TR_NO='"+trno+"' and doc_no="+txtpettycashdocno);
			int data = stmtPC.executeUpdate(sql);
			if(data<=0){
				conn.close();
				return false;
			}
			/*Updating my_cashbm Ends*/
			
			/*Inserting into datalog*/
			String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtpettycashdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
			int data1 = stmtPC.executeUpdate(sqls);
			/*Inserting into datalog Ends*/
			
			conn.commit();
			stmtPC.close();
		    conn.close();
			return true;			
      }catch(Exception e){	
	 	e.printStackTrace();
	 	conn.close();
	 	return false;
       }finally{
  		 conn.close();
  	 }
	}


	public boolean delete(int txtpettycashdocno, int txttrno, String formdetailcode,HttpSession session) throws SQLException {
		 
		Connection conn = null; 
		
		try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtPC = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				int trno = txttrno;
					
                /*Applying Delete*/
				applyDeleteDAO.getFinanceApplyDelete(conn, trno);
				/*Applying Delete Ends*/
				
				 /*Status change in my_cashbm*/
				 String sql=("update my_cashbm set STATUS=7 where doc_no="+txtpettycashdocno+" and TR_NO="+trno+"");
				 int data = stmtPC.executeUpdate(sql);
				/*Status change in my_cashbm Ends*/
				 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtpettycashdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 int datas = stmtPC.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				
				/*Status change in my_jvtran*/
				 String sql1=("update my_jvtran set STATUS=7 where doc_no="+txtpettycashdocno+" and TR_NO="+trno+"");
				 int data1 = stmtPC.executeUpdate(sql1);
				/*Status change in my_jvtran Ends*/
				 
				int docno=txtpettycashdocno;
				pettyCashBean.setTxtpettycashdocno(docno);
				if (docno > 0) {
					conn.commit();
					stmtPC.close();
				    conn.close();
					return true;
				}	
				stmtPC.close();
			    conn.close();
		 }catch(Exception e){	
			 	e.printStackTrace();
			 	conn.close();
			 	return false;
		 }finally{
			 conn.close();
		 }
				return false;
	    }
	
	public JSONArray accountsDetails(HttpSession session) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		
	    try {
				conn = connDAO.getMyConnection();
				Statement stmtPC = conn.createStatement();
				
				String branch = session.getAttribute("BRANCHID").toString();
			    String company = session.getAttribute("COMPANYID").toString();
            	
				String sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate from my_head t,"
            			+ "(select curId from my_brch where doc_no=  '"+branch+"') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
            			+ "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') and den='604'";
				
            	ResultSet resultSet = stmtPC.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtPC.close();
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
	
	public JSONArray applyInvoicingGrid(String accountno,String atype) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtPC = conn.createStatement();
				
            	String condition="";
            	String sql="";
            	
            	if(!(atype==null || atype.equalsIgnoreCase(""))){
					if(atype.equalsIgnoreCase("AR")){
						condition="and t1.dramount > 0";
					}
					else if(atype.equalsIgnoreCase("AP")){
						condition="and t1.dramount < 0";
					}
            	}
            	
            		sql = "Select t1.doc_no,t1.acno,t1.tranid,t1.date,t1.out_amount,t1.dtype,t1.curid currency,t1.description, "
						+ "(if(t1.dramount<0,(t1.dramount*-1),t1.dramount)- t1.out_amount) tramt from my_jvtran t1 inner join my_brch b on t1.brhId=b.doc_no inner join "
						+ "my_head h on t1.acno=h.doc_no where t1.acno="+accountno+" "+condition+" and (t1.dramount - out_amount) != 0 group by t1.tranid";
            	
            	
				ResultSet resultSet = stmtPC.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtPC.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		}
        return RESULTDATA;
    }
	
	
	public JSONArray applyInvoicingGridReloading(String trno,String accountno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		
        Connection conn = null; 
        		
        try {
				conn = connDAO.getMyConnection();
				Statement stmtPC = conn.createStatement();
				
				if(!(trno.trim().equalsIgnoreCase("0")||trno.trim().equalsIgnoreCase("") && accountno.trim().equalsIgnoreCase("0")||accountno.trim().equalsIgnoreCase(""))){
            	
				String sql="select t.doc_no doc_no,t.dtype dtype,t.description description,t.date date,(t.dramount-t.out_amount+d.amount) tramt,"
						+ "d.amount applying,(t.dramount-t.out_amount) balance,t.out_amount,t.tranid,t.acno,t.curId currency from my_outd d "
						+ "left join my_jvtran t on d.ap_trid=t.tranid where d.tranid=(SELECT tranid FROM my_jvtran where TR_NO='"+trno+"'  and acno='"+accountno+"')";
				
				ResultSet resultSet = stmtPC.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtPC.close();
				conn.close();
				}
			stmtPC.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		}
        return RESULTDATA;
    }
	
	
	public JSONArray pettyCashGridReloading(HttpSession session,String docNo,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))) {
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
        
        //System.out.println("==branch==="+branch);
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtPC = conn.createStatement();
			
				String sqlnew=("SELECT m.date,m.RefNo,t.doc_no docno,t.atype type,t.account accounts,t.description accountname1,t.gr_type grtype,c.code currency,c.type currencytype,d.curId currencyid,"
						+ "d.rate rate,(d.AMOUNT*d.dr) amount1,(d.lamount*d.dr) baseamount1,d.description,d.SR_NO sr_no,d.costtype,d.costcode,"
						+ "f.costgroup FROM my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no left join my_costunit f on d.costtype=f.costtype left join my_head t on "
						+ "d.acno=t.doc_no left join my_curr c on c.doc_no=d.curId WHERE m.dtype='PC' and m.brhId="+branch+" and m.doc_no="+docNo+" and d.SR_NO>0");
				
				
				//System.out.println("==sqlnew==="+sqlnew);
				
				ResultSet resultSet = stmtPC.executeQuery (sqlnew);
                
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtPC.close();
				conn.close();

		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		return RESULTDATA;
    }
	
	public JSONArray pettyCashGridSearch(String type,String accountno,String accountname,String currency,String date,String check) throws SQLException {
	        
			JSONArray RESULTDATA=new JSONArray();
	        
			if(!(check.equalsIgnoreCase("1"))) {
	        	return RESULTDATA;
	        }
			
	        Connection conn = null; 
	       
		     try {
			       conn = connDAO.getMyConnection();
			       Statement stmtPC = conn.createStatement();
		
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
			        
		           sql="select t.doc_no,t.account,t.description,t.gr_type,c.code curr,c.doc_no curid,c.type,round(cb.rate,2) c_rate from my_head t left join my_curr c "
						+ "on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,"
						+ "cr.frmDate from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo "
						+ "on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where t.atype='"+type+"' and t.m_s=0"+sqltest;
			        
			       ResultSet resultSet = stmtPC.executeQuery(sql);
			       RESULTDATA=commonDAO.convertToJSON(resultSet);
		           
		        stmtPC.close();
				conn.close();
		     } catch(Exception e){
			      e.printStackTrace();
			      conn.close();
		     } finally{
				 conn.close();
			 }
		       return RESULTDATA;
		  }
	
	public JSONArray pcMainSearch(HttpSession session,String partyname,String docNo,String date,String amount,String check) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))) {
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
       
        java.sql.Date sqlPaymentDate=null;
        
     try {
	        conn = connDAO.getMyConnection();
	        Statement stmtPC = conn.createStatement();

	        date.trim();
	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	        {
	        sqlPaymentDate = commonDAO.changeStringtoSqlDate(date);
	        }

	        String sqltest="";
	        
	        if(!(docNo.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and m.doc_no like '%"+docNo+"%'";
	        }
	        if(!(partyname.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and h.description like '%"+partyname+"%'";
	        }
	        if(!(amount.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and m.totalAmount like '%"+amount+"%'";
	        }
	        if(!(sqlPaymentDate==null)){
		         sqltest=sqltest+" and m.date='"+sqlPaymentDate+"'";
		        } 
	        
	       ResultSet resultSet = stmtPC.executeQuery("select m.date,m.doc_no,m.totalAmount amount,if(h.description is null,' ',h.description) description from  my_cashbm m "
	       		+ "left join my_cashbd d on m.tr_no=d.tr_no and d.sr_no=0 left join my_head h on d.acno=h.doc_no left join my_brch b on m.brhid=b.doc_no where  m.brhid="+branch+" "
	       		+ "and m.dtype='PC' and m.status <> 7" +sqltest);
	
	       RESULTDATA=commonDAO.convertToJSON(resultSet);
	       stmtPC.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
		 conn.close();
	 }
         return RESULTDATA;
    }
	
	 public ClsPettyCashBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		ClsPettyCashBean pettyCashBean = new ClsPettyCashBean();
		
		Connection conn = null;
		
		try {
		
			conn = connDAO.getMyConnection();
			Statement stmtPC = conn.createStatement();
		
			String branch = session.getAttribute("BRANCHID").toString();
			
			ResultSet resultSet = stmtPC.executeQuery ("SELECT m.status,m.date,m.RefNo,t.account,t.description,t.doc_no accno,d.curId,d.rate,(d.AMOUNT*d.dr) amount,(d.lamount*d.dr) lamount,"
				+ "m.DESC1,d.SR_NO,d.TR_NO,j.tranid,c.type FROM my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no left join my_jvtran j on d.tr_no=j.tr_no left join my_head t on "
				+ "d.acno=t.doc_no left join my_curr c on d.curId=c.doc_no WHERE m.dtype='PC' and d.sr_no=0 and m.status<>7 and m.brhId='"+branch+"' and m.doc_no="+docNo+" group by account");

			while (resultSet.next()) {
				pettyCashBean.setTxtpettycashdocno(docNo);
				pettyCashBean.setJqxPettyCashDate(resultSet.getDate("date").toString());
				pettyCashBean.setTxtrefno(resultSet.getString("RefNo"));
				pettyCashBean.setTxttranid(resultSet.getInt("tranid"));
				pettyCashBean.setTxttrno(resultSet.getInt("TR_NO"));
				pettyCashBean.setStatus(resultSet.getInt("status"));
				
				pettyCashBean.setTxtdocno(resultSet.getInt("accno"));
				pettyCashBean.setTxtaccid(resultSet.getString("account"));
				pettyCashBean.setTxtaccname(resultSet.getString("description"));
				pettyCashBean.setHidcmbcurrency(resultSet.getString("curId"));
				pettyCashBean.setHidcurrencytype(resultSet.getString("type"));
				pettyCashBean.setTxtrate(resultSet.getDouble("rate"));
				pettyCashBean.setTxtamount(resultSet.getDouble("amount"));
				pettyCashBean.setTxtbaseamount(resultSet.getDouble("lamount"));
				pettyCashBean.setTxtdescription(resultSet.getString("DESC1"));
				pettyCashBean.setMaindate(resultSet.getDate("date").toString());
		    }
		 stmtPC.close();
		 conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		}
		return pettyCashBean;
		}

	public ClsPettyCashBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsPettyCashBean bean = new ClsPettyCashBean();
		 Connection conn = null;
		 
		try {
			
			conn = connDAO.getMyConnection();
			Statement stmtPC = conn.createStatement();
			
			String headersql="select m.status,if((m.status<3 or m.status=4),1,0) wtrmrk,if(m.dtype='PC','Petty Cash','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.tinno,"
					+ "b.cstno from my_cashbm m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='PC' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
				ResultSet resultSetHead = stmtPC.executeQuery(headersql);
				
				while(resultSetHead.next()){
					bean.setLblcomptrn(resultSetHead.getString("tinno"));
					bean.setLblcompname(resultSetHead.getString("company"));
					bean.setLblcompaddress(resultSetHead.getString("address"));
					bean.setLblprintname(resultSetHead.getString("vouchername"));
					bean.setLblcomptel(resultSetHead.getString("tel"));
					bean.setLblcompfax(resultSetHead.getString("fax"));
					bean.setLblbranch(resultSetHead.getString("branchname"));
					bean.setLbllocation(resultSetHead.getString("location"));
					bean.setLblcstno(resultSetHead.getString("cstno"));
					bean.setLblpan(resultSetHead.getString("pbno"));
					bean.setLblservicetax(resultSetHead.getString("stcno"));
					bean.setLblpobox(resultSetHead.getString("pbno"));
					bean.setWatermark(resultSetHead.getString("wtrmrk"));
					bean.setStatus(resultSetHead.getInt("status"));
				}
			
				String sqls="select m.doc_no,coalesce(u3.user_name,'') approved,DATE_FORMAT(m.date ,'%d-%m-%Y') date,m.desc1,round(m.totalAmount,2) netAmount,u.user_name,coalesce(u2.user_name, u1.user_name)  verifiedappr from my_cashbm m left join my_user u on "
						+ "m.userid=u.doc_no left join my_exdet ext on (m.doc_no=ext.doc_no and m.dtype=ext.dtype and ext.apprLEVEL=1  and m.brhid=ext.brhid) left join my_exdet ext0 on (m.doc_no=ext0.doc_no and m.dtype=ext0.dtype and ext0.apprLEVEL=0  and m.brhid=ext0.brhid) left join my_exdet ext1 on (m.doc_no=ext1.doc_no and m.dtype=ext1.dtype   and ext1.apprLEVEL=2  and m.brhid=ext1.brhid) left join my_exdet ext2 on (m.doc_no=ext2.doc_no and m.dtype=ext2.dtype   and ext2.apprLEVEL=3  and m.brhid=ext2.brhid) left join my_user u1 on ext.userid=u1.doc_no left join my_user u2 on ext1.userid=u2.doc_no left join my_user u3 on ext2.userid=u3.doc_no where m.dtype='PC' and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
			ResultSet resultSets = stmtPC.executeQuery(sqls);
			
			while(resultSets.next()){
				
				bean.setLblvoucherno(resultSets.getString("doc_no"));
				bean.setLbldescription(resultSets.getString("desc1"));
				bean.setLbldate(resultSets.getString("date"));
				bean.setLbldebittotal(resultSets.getString("netAmount"));
				bean.setLblcredittotal(resultSets.getString("netAmount"));
				
				bean.setLblpreparedby(resultSets.getString("user_name"));
				bean.setApproved(resultSets.getString("approved"));
				bean.setVerified(resultSets.getString("verifiedappr"));
			}
			
			bean.setTxtheader(header);
			
			String sql="select round(m.totalAmount,2) netAmount,h.description from my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no left join my_head h on "
				+ "d.acno=h.doc_no where m.dtype='PC' and d.sr_no=0 and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet = stmtPC.executeQuery(sql);

			ClsAmountToWords c = new ClsAmountToWords();
			
			while(resultSet.next()){
				
				bean.setLblname(resultSet.getString("description"));
				bean.setLblnetamount(resultSet.getString("netAmount"));
				bean.setLblnetamountwords(c.convertAmountToWords(resultSet.getString("netAmount")));
			}

			String sql1 = "";
		
			sql1="SELECT t.account,t.description accountname,c.code currency,d.description,concat(coalesce(v.reg_no,''),' - ',coalesce(p.code_name,'')) regno,if(d.amount>0,round((d.amount*1),2),'  ') debit,if(d.amount<0,round((d.amount*-1),2),' ') credit FROM my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no "
				+ "left join my_head t on d.acno=t.doc_no left join my_curr c on c.doc_no=d.curId left join gl_vehmaster v on v.fleet_no=d.costcode and costtype=6 left join gl_vehplate p on v.pltid=p.doc_no WHERE m.dtype='PC' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			// System.out.println("===== "+sql1);
			ResultSet resultSet1 = stmtPC.executeQuery(sql1);
			
			ArrayList<String> printarray= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1); 
				String temp="";
				temp=resultSet1.getString("account")+"::"+resultSet1.getString("accountname")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("regno")+"::"+resultSet1.getString("currency")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
			    printarray.add(temp);
			}

			request.setAttribute("printingarray", printarray);
			
			String sql2 = "select min(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,min(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from my_cashbm m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='PC' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet2 = stmtPC.executeQuery(sql2);
			
			while(resultSet2.next()){
				bean.setLblpreparedon(resultSet2.getString("preparedon"));
				bean.setLblpreparedat(resultSet2.getString("preparedat"));
			}
		
			stmtPC.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		}
		return bean;
	}
	 
	 public int insertion(Connection conn,int docno,int trno,String formdetailcode,Date pettyCashDate, String txtrefno, double txtrate, 
			 String txtdescription, double txtamount, ArrayList<String> pettycasharray, HttpSession session,String mode) throws SQLException{
		
		  try{
				conn.setAutoCommit(false);
				CallableStatement stmtPC;
				Statement stmtPC1 = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				/*Petty Cash Grid and Details Saving*/
				for(int i=0;i< pettycasharray.size();i++){
					String[] pettycash=pettycasharray.get(i).split("::");
					if(!pettycash[0].trim().equalsIgnoreCase("undefined") && !pettycash[0].trim().equalsIgnoreCase("NaN")){
					
					int cash = 0,trid = 0;
					int id = 0;
					if(pettycash[3].trim().equalsIgnoreCase("true")){
						cash=0;
						id=1;
					}
					else if(pettycash[3].trim().equalsIgnoreCase("false")){
						cash=1;
						id=-1;
					}
					
					stmtPC = conn.prepareCall("{CALL cashbdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to my_cashbd*/
					stmtPC.setInt(19,trno); 
					stmtPC.setInt(20,docno);
					stmtPC.registerOutParameter(21, java.sql.Types.INTEGER);
					stmtPC.setInt(1,i); //SR_NO
					stmtPC.setString(2,(pettycash[0].trim().equalsIgnoreCase("undefined") || pettycash[0].trim().equalsIgnoreCase("NaN") || pettycash[0].trim().isEmpty()?0:pettycash[0].trim()).toString());  //doc_no of my_head
					stmtPC.setString(3,(pettycash[1].trim().equalsIgnoreCase("undefined") || pettycash[1].trim().equalsIgnoreCase("NaN") || pettycash[1].trim().isEmpty()?0:pettycash[1].trim()).toString()); //curId
					stmtPC.setString(4,(pettycash[2].trim().equalsIgnoreCase("undefined") || pettycash[2].trim().equalsIgnoreCase("NaN") || pettycash[2].trim().equals(0) || pettycash[2].trim().isEmpty()?1:pettycash[2].trim()).toString()); //rate 
					stmtPC.setInt(5,id); //#credit -1 / debit 1 
					stmtPC.setString(6,(pettycash[4].trim().equalsIgnoreCase("undefined") || pettycash[4].trim().equalsIgnoreCase("NaN") || pettycash[4].trim().isEmpty()?0:pettycash[4].trim()).toString()); //amount
					stmtPC.setString(7,(pettycash[5].trim().equalsIgnoreCase("undefined") || pettycash[5].trim().equalsIgnoreCase("NaN") || pettycash[5].trim().isEmpty()?0:pettycash[5].trim()).toString()); //description
					stmtPC.setString(8,(pettycash[6].trim().equalsIgnoreCase("undefined") || pettycash[6].trim().equalsIgnoreCase("NaN") || pettycash[6].trim().isEmpty()?0:pettycash[6].trim()).toString()); //baseamount
					stmtPC.setInt(9,cash); //For cash = 0/ party = 1
					stmtPC.setString(10,(pettycash[8].trim().equalsIgnoreCase("undefined") || pettycash[8].trim().equalsIgnoreCase("NaN") || pettycash[8].trim().equalsIgnoreCase("") || pettycash[8].trim().equalsIgnoreCase("0") || pettycash[8].trim().isEmpty()?0:pettycash[8].trim()).toString()); //Cost type
					stmtPC.setString(11,(pettycash[9].trim().equalsIgnoreCase("undefined") || pettycash[9].trim().equalsIgnoreCase("NaN") || pettycash[9].trim().equalsIgnoreCase("") || pettycash[9].trim().equalsIgnoreCase("0") || pettycash[9].trim().isEmpty()?0:pettycash[9].trim()).toString()); //Cost Code
					/*my_cashbd Ends*/
					
					/*Insertion to my_jvtran*/
					stmtPC.setDate(12,pettyCashDate);
					stmtPC.setString(13,txtrefno);
					stmtPC.setInt(14,id);  //id
					stmtPC.setString(15,(pettycash[7].trim().equalsIgnoreCase("undefined") || pettycash[7].trim().equalsIgnoreCase("NaN") || pettycash[7].trim().isEmpty()?0:pettycash[7].trim()).toString());  //out-amount
					/*my_jvtran Ends*/
					
					stmtPC.setString(16,formdetailcode);
					stmtPC.setString(17,branch);
					stmtPC.setString(18,userid);
					stmtPC.setString(22,mode);
					int detail=stmtPC.executeUpdate();
						if(detail<=0){
							stmtPC.close();
							conn.close();
							return 0;
						}
						
				 String sql3="SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+(pettycash[0].trim().equalsIgnoreCase("undefined") || pettycash[0].trim().equalsIgnoreCase("NaN") || pettycash[0].trim().isEmpty()?0:pettycash[0].trim());
				 ResultSet resultSet2 = stmtPC1.executeQuery(sql3);
				    
				 while (resultSet2.next()) {
				 trid = resultSet2.getInt("TRANID");
				 }
				
				 if(!pettycash[8].trim().equalsIgnoreCase("0") && !pettycash[8].trim().equalsIgnoreCase("")){
				 String sql4="insert into my_costtran(acno,costtype,amount,sr_no,jobid,tranid,tr_no) values("+(pettycash[0].trim().equalsIgnoreCase("undefined") || pettycash[0].trim().equalsIgnoreCase("NaN") || pettycash[0].trim().isEmpty()?0:pettycash[0].trim())+","
				 		+ ""+(pettycash[8].trim().equalsIgnoreCase("undefined") || pettycash[8].trim().equalsIgnoreCase("NaN") || pettycash[8].trim().equalsIgnoreCase("") || pettycash[8].trim().isEmpty()?0:pettycash[8].trim())+","
				 	    + ""+(pettycash[6].trim().equalsIgnoreCase("undefined") || pettycash[6].trim().equalsIgnoreCase("NaN") || pettycash[6].trim().isEmpty()?0:pettycash[6].trim())+","+i+","
				 	    + ""+(pettycash[9].trim().equalsIgnoreCase("undefined") || pettycash[9].trim().equalsIgnoreCase("NaN") || pettycash[9].trim().isEmpty()?0:pettycash[9].trim())+","+trid+","+trno+")";
				 
				 int data2 = stmtPC1.executeUpdate(sql4);
				 if(data2<=0){
					    stmtPC1.close();
						conn.close();
						return 0;
					  }
				 
				 String sql5="update my_jvtran set costtype="+(pettycash[8].trim().equalsIgnoreCase("undefined") || pettycash[8].trim().equalsIgnoreCase("NaN") || pettycash[8].trim().equalsIgnoreCase("") || pettycash[8].trim().isEmpty()?0:pettycash[8].trim())+","
				 		+ "costcode="+(pettycash[9].trim().equalsIgnoreCase("undefined") || pettycash[9].trim().equalsIgnoreCase("NaN") || pettycash[9].trim().isEmpty()?0:pettycash[9].trim())+" where tranid="+trid+"";
				 int data3 = stmtPC1.executeUpdate(sql5);
				 if(data3<=0){
					    stmtPC1.close();
						conn.close();
						return 0;
					  }
				 	}	
  				  }
			    }
			    /*Petty Cash Grid and Details Saving Ends*/
				
				/*Deleting account of value zero*/
				String sql2=("DELETE FROM my_jvtran where TR_NO="+trno+" and acno=0");
			    int data = stmtPC1.executeUpdate(sql2);
			     
			    String sql4=("DELETE FROM my_cashbd where TR_NO="+trno+" and acno=0");
			    int data1 = stmtPC1.executeUpdate(sql4);
			    /*Deleting account of value zero ends*/
			    
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}

}
