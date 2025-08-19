package com.dashboard.salikeasy;

import com.connection.*;
import com.common.*;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpRequest;

import net.sf.json.JSONArray;
public class ClsSalikEasyDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	
	public JSONArray notInvoicedGridLoading(String branch,String fromDate, String toDate, String cldocno, String rentalType, String agmtNo,String type) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		    
		Connection conn = null;
		System.out.println("======"+branch);
		if(branch.equalsIgnoreCase("0")){
			return RESULTDATA;
		}
		  try {
			  	conn = objconn.getMyConnection();
			    Statement stmtSailk = conn.createStatement();
			    
			    java.sql.Date sqlFromDate=null;
				java.sql.Date sqlToDate=null;
			        
				fromDate.trim();
		        if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0")))
		        {
		        	sqlFromDate = objcommon.changeStringtoSqlDate(fromDate);
		        }
		        
		        toDate.trim();
		        if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0")))
		        {
		        	sqlToDate = objcommon.changeStringtoSqlDate(toDate);
		        }
		        
			    String sql = "";
			    
				
				
				if(!(sqlFromDate==null)){
		        	sql+=" and s.sal_date>='"+sqlFromDate+"'";
			     }
		        
		        if(!(sqlToDate==null)){
		        	sql+=" and s.sal_date<='"+sqlToDate+"'";
			     }
		        
		        if(!(cldocno.equalsIgnoreCase(""))){
		        	sql+=" and a.cldocno='"+cldocno+"'";
		        }
		        
		        if(!(rentalType.equalsIgnoreCase(""))){
		        	if(rentalType.equalsIgnoreCase("RAG")){
		        		sql+=" and s.rtype IN ('RM','RA', 'RD','RW','RF')";
		        	}
		        	else if(rentalType.equalsIgnoreCase("LAG")){
		        		sql+=" and s.rtype IN ('LA', 'LC')";
		        	}
		         }
		        
		       /* if(!(agmtNo.equalsIgnoreCase(""))){
		        	sql+=" and s.ra_no='"+agmtNo+"'";
		           }
				*/
		        if(type.equalsIgnoreCase("Daily")){
		        	sql+=" and s.rtype in ('RD')";
		        }
		        else if(type.equalsIgnoreCase("Weekly")){
		        	sql+=" and s.rtype in ('RW')";
		        }
		        else if(type.equalsIgnoreCase("Monthly")){
		        	sql+=" and s.rtype in ('RM')";
		        }
		        else if(type.equalsIgnoreCase("Lease")){
		        	sql+=" and s.rtype IN ('LA', 'LC')";
		        }
				/*sql = "select if(s.rtype in ('RM','RA', 'RD','RW','RF'),ragmt.voc_no,lagmt.voc_no) vocno,s.sr_no,s.regno,s.tagno,s.fleetno,s.location,s.direction,s.source,s.amount,s.ra_no,a.refname,s.rtype,s.sal_date"+
						" from gl_salik s left join gl_ragmt ragmt on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM')) left join gl_lagmt"+
						" lagmt on (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) left join my_acbook a on (s.emp_id=a.cldocno and s.emp_type=a.dtype) where inv_no=0 and isallocated=1 and"+
						" s.ra_no<>0 and s.amount>0 "+sql+" and if(s.rtype in ('RA','RD','RW','RF','RM'),ragmt.brhid="+branch+",lagmt.brhid="+branch+") order by s.rtype,s.ra_no";
*/				
				/*
				 * String
				 * strsql="select sum(s.amount) amount,sum(if(coalesce(a.ser_default=0),a.per_salikrate,(select coalesce(value,0) from gl_config where"
				 * +
				 * " field_nme='saliksrv' and method=1))) saliksrvc,count(*) salikcount,a.refname,a.cldocno from gl_salik s left join gl_lagmt lagmt on "
				 * +
				 * " (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) left join my_acbook a on (s.emp_id=a.cldocno and s.emp_type=a.dtype) where inv_no=0 and "
				 * + " isallocated=1 and s.ra_no<>0 and s.amount>0  "
				 * +sql+" and if(s.rtype in ('LA','LC'),lagmt.brhid="
				 * +branch+",0) group by a.cldocno";
				 */
		        double saliksrvDXB=0.0,saliksrvAUH=0.0;
		        String strgetsrvc="select (select coalesce(value,0) from gl_config where field_nme='saliksrv' and method=1) saliksrvDXB,"+
		        "(select coalesce(value,0) from gl_config where field_nme='saliksrvAUH' and method=1) saliksrvAUH";
		        ResultSet rsgetsrvc=stmtSailk.executeQuery(strgetsrvc);
		        while(rsgetsrvc.next()) {
		        	saliksrvDXB=rsgetsrvc.getDouble("saliksrvDXB");
		        	saliksrvAUH=rsgetsrvc.getDouble("saliksrvAUH");
		        }
		        String strsql="select base.*,ac.RefName from ("+ 
        		"select a.cldocno,sum(s.amount) amount,sum(if(coalesce(a.ser_default,0)=0,a.per_salikrate,if(s.source<>'AUH',"+saliksrvDXB+","+saliksrvAUH+"))) \r\n" + 
        		"saliksrvc,count(*) salikcount ,sum(if(s.source<>'AUH',s.amount,0)) salikamtdxb,sum(if(s.source='AUH',s.amount,0)) salikamtauh,\r\n" + 
        		"sum(if(s.source<>'AUH',1,0)) salikcountdxb,sum(if(s.source='AUH',1,0)) salikcountauh,\r\n" + 
        		"sum(if(s.source<>'AUH',if(coalesce(a.ser_default,0)=0,a.per_salikrate,"+saliksrvDXB+"),0)) saliksrvdxb,\r\n" + 
        		"sum(if(s.source='AUH',if(coalesce(a.ser_default,0)=0,a.per_salikrate,"+saliksrvAUH+"),0)) saliksrvauh\r\n" + 
        		"from gl_salik s left join gl_lagmt lagmt on\r\n" + 
        		"(s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) left join gl_ragmt ragmt on\r\n" + 
        		"(s.ra_no=lagmt.doc_no and s.rtype in ('RA','RD','RW','RM'))left join my_acbook a on (s.emp_id=a.cldocno and s.emp_type=a.dtype) where \r\n" + 
        		"inv_no=0 and isallocated=1 and s.ra_no<>0 and s.amount>0 and a.dtype='CRM' "+sql+" and if(s.rtype in ('LA','LC'),lagmt.brhid,ragmt.brhid)="+branch+" group by a.cldocno) base left join my_acbook ac on \r\n" + 
        		"(base.cldocno=ac.cldocno and ac.dtype='CRM' and status=3) and ac.status<>7";
		        System.out.println("not invoiced salik query: "+strsql);  
				ResultSet resultSet = stmtSailk.executeQuery(strsql);
			    RESULTDATA=objcommon.convertToJSON(resultSet);
			    
			    stmtSailk.close();
			    conn.close();
		
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public ArrayList<String> insert(String branch,Date sqlFromDate, Date sqlToDate, String cldocno, String rentalType, String agmtNo,HttpSession session,String cmbtype,HttpServletRequest request) throws SQLException {
		int invdocno=0;
		ArrayList<String> voucherarray=new ArrayList<>();
		Connection conn=null;
		try{
			conn = objconn.getMyConnection();
		    Statement stmtSailk = conn.createStatement();
		    conn.setAutoCommit(false);
	        
		    String sql = "";
		    
			if(!(sqlFromDate==null)){
	        	sql+=" and s.sal_date>='"+sqlFromDate+"'";
		     }
	        
	        if(!(sqlToDate==null)){
	        	sql+=" and s.sal_date<='"+sqlToDate+"'";
		     }
	        
	        if(!(cldocno.equalsIgnoreCase(""))){
	        	sql+=" and a.cldocno='"+cldocno+"'";
	        }
	        
	        if(!(rentalType.equalsIgnoreCase(""))){
	        	if(rentalType.equalsIgnoreCase("RAG")){
	        		sql+=" and s.rtype IN ('RM','RA', 'RD','RW','RF')";
	        	}
	        	else if(rentalType.equalsIgnoreCase("LAG")){
	        		sql+=" and s.rtype IN ('LA', 'LC')";
	        	}
	         }
	        
	       /* if(!(agmtNo.equalsIgnoreCase(""))){
	        	sql+=" and s.ra_no='"+agmtNo+"'";
	           }
			*/
	        if(cmbtype.equalsIgnoreCase("Daily")){
	        	sql+=" and s.rtype in ('RD')";
	        }
	        else if(cmbtype.equalsIgnoreCase("Weekly")){
	        	sql+=" and s.rtype in ('RW')";
	        }
	        else if(cmbtype.equalsIgnoreCase("Monthly")){
	        	sql+=" and s.rtype in ('RM')";
	        }
	        else if(cmbtype.equalsIgnoreCase("Lease")){
	        	sql+=" and s.rtype IN ('LA', 'LC')";
	        }
			/*sql = "select if(s.rtype in ('RM','RA', 'RD','RW','RF'),ragmt.voc_no,lagmt.voc_no) vocno,s.sr_no,s.regno,s.tagno,s.fleetno,s.location,s.direction,s.source,s.amount,s.ra_no,a.refname,s.rtype,s.sal_date"+
					" from gl_salik s left join gl_ragmt ragmt on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RW','RF','RM')) left join gl_lagmt"+
					" lagmt on (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) left join my_acbook a on (s.emp_id=a.cldocno and s.emp_type=a.dtype) where inv_no=0 and isallocated=1 and"+
					" s.ra_no<>0 and s.amount>0 "+sql+" and if(s.rtype in ('RA','RD','RW','RF','RM'),ragmt.brhid="+branch+",lagmt.brhid="+branch+") order by s.rtype,s.ra_no";
*/			String strsalikacno="select (select acno from gl_invmode where idno=8)salikacno,(select acno from gl_invmode where idno=14)saliksrvcacno,(select acno from gl_invmode where idno=38)salikauhacno,(select acno from gl_invmode where idno=39)salikauhsrvcacno";
			//System.out.println("Acno Query : "+strsalikacno);
			ResultSet rsacno=stmtSailk.executeQuery(strsalikacno);
			int salikacno=0;
			int saliksrvcacno=0;
			double saliksrvcrate=0.0;
			int salikauhacno=0;
			int salikauhsrvcacno=0;
			while(rsacno.next()){
				salikacno=rsacno.getInt("salikacno");
				saliksrvcacno=rsacno.getInt("saliksrvcacno");
				salikauhacno=rsacno.getInt("salikauhacno");
				salikauhsrvcacno=rsacno.getInt("salikauhsrvcacno");
			}
			double saliksrvDXB=0.0,saliksrvAUH=0.0;
	        String strgetsrvc="select (select coalesce(value,0) from gl_config where field_nme='saliksrv' and method=1) saliksrvDXB,"+
	        "(select coalesce(value,0) from gl_config where field_nme='saliksrvAUH' and method=1) saliksrvAUH";
	        ResultSet rsgetsrvc=stmtSailk.executeQuery(strgetsrvc);
	        while(rsgetsrvc.next()) {
	        	saliksrvDXB=rsgetsrvc.getDouble("saliksrvDXB");
	        	saliksrvAUH=rsgetsrvc.getDouble("saliksrvAUH");
	        }
			String tempvoucher="";
			String strsql="select base.*,ac.refname,head.doc_no acno,head.curid,head.rate from (select min(if(s.rtype in ('LA','LC'),'LAG','RAG')) agmttype,\r\n" + 
					"cast(round(sum(if(s.source='AUH',if(coalesce(a.ser_default,0)=0,a.per_salikrate,"+saliksrvAUH+"),0)),2) as decimal(15,2)) salikauhsrvc,\r\n" + 
					"cast(round(sum(if(s.source<>'AUH',if(coalesce(a.ser_default,0)=0,a.per_salikrate,"+saliksrvDXB+"),0)),2) as decimal(15,2)) salikdxbsrvc,\r\n" + 
					"cast(round(sum(if(s.source='AUH',1,0)),0) as decimal(15,2)) salikauhcount,cast(round(sum(if(s.source<>'AUH',1,0)),0) as decimal(15,2)) \r\n" + 
					"salikdxbcount,cast(round(sum(if(s.source='AUH',s.amount,0)),2) as decimal(15,2)) salikauhamt,\r\n" + 
					"cast(round(sum(if(s.source<>'AUH',s.amount,0)),2) as decimal(15,2)) salikdxbamt,\r\n" + 
					"min(if(s.rtype in ('LA','LC'),lagmt.brhid,ragmt.brhid)) brhid,\r\n" + 
					"min(if(s.rtype in ('LA','LC'),lagmt.doc_no,ragmt.doc_no)) agmtno,\r\n" + 
					"cast(round(sum(s.amount),2) as decimal(15,2)) amount,cast(round(sum(if(coalesce(a.ser_default,0)=0,a.per_salikrate,"+saliksrvDXB+")),2) as decimal(15,2)) \r\n" + 
					"saliksrvc,count(*) salikcount,a.cldocno from gl_salik s left join gl_lagmt lagmt on  (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) \r\n" + 
					"left join gl_ragmt ragmt on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RM','RW')) left join my_acbook a on \r\n" + 
					"(s.emp_id=a.cldocno and s.emp_type=a.dtype)  where inv_no=0 and "+
					" isallocated=1 and s.ra_no<>0 and s.amount>0  "+sql+" and if(s.rtype in ('LA','LC'),lagmt.brhid,ragmt.brhid)="+branch+" group by a.cldocno) base left join my_acbook ac on (ac.cldocno=base.cldocno and ac.dtype='CRM' and ac.status=3) left join my_head head on (ac.acno=head.doc_no) where ac.status<>7";
			System.out.println(strsql);
	        ResultSet rs=stmtSailk.executeQuery(strsql);
	        while (rs.next()) {
				int salikauhcount=rs.getInt("salikauhcount");
	        	int salikdxbcount=rs.getInt("salikdxbcount");
	        	double salikauhamt=rs.getDouble("salikauhamt");
	        	double salikdxbamt=rs.getDouble("salikdxbamt");
	        	double salikauhsrvc=rs.getDouble("salikauhsrvc");
	        	double salikdxbsrvc=rs.getDouble("salikdxbsrvc");
	        	String clientname=rs.getString("refname");
				int salikcount=salikauhcount+salikdxbcount;
				double salikamt=salikauhamt+salikdxbamt;
				double saliksrvc=0.0;
				/* rs.getDouble("saliksrvc"); */
				saliksrvc=salikauhsrvc+salikdxbsrvc;
				int brhid=rs.getInt("brhid");
				int curid=rs.getInt("curid");
				double currate=rs.getDouble("rate");
				int agmtno=rs.getInt("agmtno");
				String agmttype=rs.getString("agmttype");
				int clientdocno=rs.getInt("cldocno");
				int acno=rs.getInt("acno");
	        	ArrayList<String> invoicearray=new ArrayList<>();
				String note=objcommon.changeSqltoString(sqlFromDate) +" to "+objcommon.changeSqltoString(sqlToDate) +" Salik for "+clientname;
				//System.out.println("Salik Srvc: "+saliksrvc);
				//invoicearray.add(8+"::"+salikacno+"::"+note+"::"+salikcount+"::"+salikamt+"::"+salikamt);
				//invoicearray.add(14+"::"+saliksrvcacno+"::"+note+"::"+salikcount+"::"+saliksrvc+"::"+saliksrvc);
				if(salikauhamt>0.0){
					invoicearray.add(38+"::"+salikauhacno+"::"+note+"::"+salikauhcount+"::"+salikauhamt+"::"+salikauhamt);
					if(salikauhsrvc>0.0) {
						invoicearray.add(39+"::"+salikauhsrvcacno+"::"+note+"::"+salikauhcount+"::"+salikauhsrvc+"::"+salikauhsrvc);
					}
					
				}
				if(salikdxbamt>0.0){
					invoicearray.add(8+"::"+salikacno+"::"+note+"::"+salikdxbcount+"::"+salikdxbamt+"::"+salikdxbamt);
					if(salikdxbsrvc>0.0) {
						invoicearray.add(14+"::"+saliksrvcacno+"::"+note+"::"+salikdxbcount+"::"+salikdxbsrvc+"::"+salikdxbsrvc);
					}
					
				}
				invdocno=customInvoiceInsert(invoicearray,note,sqlFromDate,sqlToDate,conn,curid,currate,brhid,agmtno,clientdocno,acno,session,
						request,salikamt,saliksrvc,salikcount,sql,agmttype);
				if(invdocno==0) {
					return new ArrayList<String>();
				}
				if(tempvoucher.equalsIgnoreCase("")){
					tempvoucher+=invdocno;
				}
				else{
					tempvoucher+=","+invdocno;
				}
				
				PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
	        	stmtlog.setInt(1,invdocno);
	        	stmtlog.setInt(2,Integer.parseInt(branch));
	        	stmtlog.setString(3,"BBIS");
	        	stmtlog.setInt(4, Integer.parseInt(session.getAttribute("USERID").toString()));
	        	stmtlog.setInt(5, 0);
	        	stmtlog.setInt(6, 0);
	        	stmtlog.setString(7, "A");
	        	int log=stmtlog.executeUpdate();
	        }
	        
	        String strvocno="select voc_no,doc_no from gl_invm where doc_no in ("+tempvoucher+")";
	        int logdocno=0;
	        ResultSet rsvocno=stmtSailk.executeQuery(strvocno);
	        while(rsvocno.next()){
	        	voucherarray.add(rsvocno.getString("voc_no"));
	        }
	        
	        if(voucherarray.size()>0){
	        	
	        	
	        	conn.commit();
	        }
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return voucherarray;
	}

	private int customInvoiceInsert(ArrayList<String> invoicearray,
			String note, Date sqlFromDate, Date sqlToDate, Connection conn, int currencyid, double currencyrate, int cmbbranch, int agmtno, int cldocno,
			int acno,HttpSession session,HttpServletRequest request,double salikamount,double saliksrvc,int salikcount,String sql,String agmttype) throws SQLException {
		// TODO Auto-generated method stub
		int invdocno=0;
		try{
			Statement stmt=conn.createStatement();
			java.sql.Date duedate=null;
			int saliksrvcacno=0;
			int salikauhsrvcacno=0;
			String stracperiod="select DATE_ADD(if('"+sqlToDate+"' is null,null,'"+sqlToDate+"'),INTERVAL (select period2 from my_acbook where cldocno="+cldocno+" and dtype='CRM') DAY) duedate";
			//System.out.println(stracperiod);
			ResultSet rsacperiod=stmt.executeQuery(stracperiod);
			while(rsacperiod.next()){
				duedate=rsacperiod.getDate("duedate");
			}
			double saliksrvDXB=0.0,saliksrvAUH=0.0;
	        String strgetsrvc="select (select coalesce(value,0) from gl_config where field_nme='saliksrv' and method=1) saliksrvDXB,"+
	        "(select coalesce(value,0) from gl_config where field_nme='saliksrvAUH' and method=1) saliksrvAUH";
	        ResultSet rsgetsrvc=stmt.executeQuery(strgetsrvc);
	        while(rsgetsrvc.next()) {
	        	saliksrvDXB=rsgetsrvc.getDouble("saliksrvDXB");
	        	saliksrvAUH=rsgetsrvc.getDouble("saliksrvAUH");
	        }
			//Inserting into Master Invoice Table
			CallableStatement stmtManual = conn.prepareCall("{call invoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtManual.registerOutParameter(14, java.sql.Types.INTEGER);
			stmtManual.registerOutParameter(15, java.sql.Types.INTEGER);
			stmtManual.registerOutParameter(17, java.sql.Types.INTEGER);
			stmtManual.setDate(1,sqlToDate);
			stmtManual.setString(2,agmttype);
			stmtManual.setString(3,cldocno+"");
			stmtManual.setInt(4, agmtno);
			stmtManual.setString(5,note);
			stmtManual.setString(6,note);
			stmtManual.setString(7,currencyid+"");
			stmtManual.setString(8,acno+"");
			stmtManual.setDate(9,sqlFromDate);
			stmtManual.setDate(10,sqlToDate);
			stmtManual.setString(11,"INS");
			stmtManual.setString(12,session.getAttribute("USERID").toString());
			stmtManual.setString(13,cmbbranch+"");
			stmtManual.setString(16,"A");
			//		System.out.println(stmtManual);
			stmtManual.executeUpdate();
			invdocno=stmtManual.getInt("docNo");
			int invtrno=stmtManual.getInt("vtrNo");
			request.setAttribute("INVTRNO", invtrno);
			
			//Updating Manual of Invoice
			String strupdatemanual="update gl_invm set manual=12 where doc_no="+invdocno;
			int updatemanual=stmt.executeUpdate(strupdatemanual);
			if(updatemanual<0){
				return 0;
			}
			Statement stmtchecktax=conn.createStatement();
			String strchecktax="select (select method from gl_config where field_nme='tax') taxmethod,(select tax from my_acbook where cldocno="+cldocno+" and dtype='CRM') clienttaxmethod";
			System.out.println(strchecktax);
			ResultSet rschecktax=stmtchecktax.executeQuery(strchecktax);
			int taxstatus=0;
			int clienttaxmethod=0;
			while(rschecktax.next()){
				taxstatus=rschecktax.getInt("taxmethod");
				clienttaxmethod=rschecktax.getInt("clienttaxmethod");
			}
			//Inserting Detail Data
			int tempno=1;
			for(int i=0;i<invoicearray.size();i++){
				System.out.println("Displaying Invoice Array Data "+invoicearray.get(i));
				String invoice[]=invoicearray.get(i).split("::");
				if(invoice[0].equalsIgnoreCase("14")){
					saliksrvcacno=Integer.parseInt(invoice[1]);
				}
				if(invoice[0].equalsIgnoreCase("39")){
					salikauhsrvcacno=Integer.parseInt(invoice[1]);
				}
				if(!invoice[5].equalsIgnoreCase("") && !invoice[5].equalsIgnoreCase("undefined") && invoice[5]!=null){
					
					double testldramt=currencyrate*Double.parseDouble((invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5]).toString());
					double partydramt=Double.parseDouble((invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5]).toString())*-1;
					double partyldramt=testldramt*-1;
					String strsql="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+(i+1)+"','"+cmbbranch+"','"+invdocno+"'"+
							 ",'"+invtrno+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"')";
					int detailinsert=stmt.executeUpdate(strsql);
					if(detailinsert<0){
						return 0;
					}
					tempno++;
					//Inserting to Lcalc
					/*
					String strlcalc="insert into gl_lcalc(brhid,trno,rdocno,dtype,invoiced,invno,invdate,idno,qty,amount)values('"+cmbbranch+"','"+invtrno+"',"+
							 "'"+agmtno+"','LAG','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"','"+invdocno+"','"+sqlToDate+"','"+(invoice[0].equalsIgnoreCase("undefined") || invoice[0].isEmpty()?0:invoice[0])+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"','"+(invoice[5].equalsIgnoreCase("undefined") || invoice[5].isEmpty()?0:invoice[5])+"')";
					int lcalcinsert=stmt.executeUpdate(strlcalc);
					if(lcalcinsert<0){
						return 0;
					}
					*/
					
					String strjvcompany="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
							 "doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype)values('"+invtrno+"','"+(invoice[1].equalsIgnoreCase("undefined") || invoice[1].isEmpty()?0:invoice[1])+"',"+
							 "'"+partydramt+"','"+currencyrate+"','"+currencyid+"',0,-1,'"+(i+1)+"',"+
							 "'"+cmbbranch+"','"+note+"',"+
							 "0,'"+sqlToDate+"','INS','"+partyldramt+"','"+invdocno+"','"+(invoice[3].equalsIgnoreCase("undefined") || invoice[3].isEmpty()?0:invoice[3])+"',"+
							 "'"+currencyid+"','5',1,0,3,'"+agmtno+"','"+agmttype+"')";
					int sqljvcompany=stmt.executeUpdate(strjvcompany);
					if(sqljvcompany<0){
						return 0;
					}
					
				}
			}
			if(taxstatus==1 && clienttaxmethod==1){
			// Getting amount in which tax is applicable
			Statement stmtgettax=conn.createStatement();
			String strtaxapplied="select total from gl_invd inv left join gl_invmode ac on inv.chid=ac.idno where ac.tax=1 and inv.rdocno="+invdocno;
			ResultSet rsapplied=stmtgettax.executeQuery(strtaxapplied);
			double generalamttax=0.0;
			while(rsapplied.next()){
				generalamttax+=rsapplied.getDouble("total");
			}
			int igststatus=0;
			if(agmttype.equalsIgnoreCase("RAG")){
				String strigst="select igststatus from gl_ragmt where doc_no="+agmtno;
				ResultSet rsigst=stmtchecktax.executeQuery(strigst);
				while(rsigst.next()){
					igststatus=rsigst.getInt("igststatus");
				}
			}
			String strgettax="select set_per,vat_per,inv.idno,inv.acno,inv.description from gl_taxdetail tax left join gl_invmode inv on tax.acidno=inv.idno where tax.status<>7 and '"+sqlToDate+"' between tax.fromdate and tax.todate";
			System.out.println("Tax Percent Query: "+strgettax);
			double setpercent=0.0;
			double vatpercent=0.0;
			ResultSet rsgettax=stmtgettax.executeQuery(strgettax);
			double vatval=0.0,setval=0.0;
			ArrayList<String> temptaxarray=new ArrayList<>();
			while(rsgettax.next()){
				setpercent=rsgettax.getDouble("set_per");
				vatpercent=rsgettax.getDouble("vat_per");
				vatval=(generalamttax*(vatpercent/100));
				setval=generalamttax*(setpercent/100);
				setval=objcommon.Round(setval, 2);
				vatval=objcommon.Round(vatval, 2);
				if(igststatus==1){
					if(rsgettax.getInt("idno")==21){
						if(setval>0.0){
							temptaxarray.add(rsgettax.getInt("idno")+"::"+rsgettax.getString("acno")+"::"+setval+"::"+rsgettax.getString("description"));
							salikamount+=setval;
						}
					}
				}
				else{
					if(rsgettax.getInt("idno")==19 || rsgettax.getInt("idno")==20){
						if(vatval>0.0){
							temptaxarray.add(rsgettax.getInt("idno")+"::"+rsgettax.getString("acno")+"::"+vatval+"::"+rsgettax.getString("description"));
							System.out.println("Before: "+salikamount+"///"+vatval);
							salikamount+=vatval;
							System.out.println("Before: "+salikamount+"///"+vatval);
						}
					}
				}
			}
			if(setpercent>0.0 || vatpercent>0.0){

				salikamount=objcommon.Round(salikamount, 2);

				
				//generalamt=generalamt+vatval;
				//generalamt=objcommon.Round(generalamt, 2);
				double salikldr=salikamount*currencyrate;

				int tempsrno=invoicearray.size()+1;
				for(int j=0;j<temptaxarray.size();j++){
					String[] tax=temptaxarray.get(j).split("::");
					Statement stmttaxinvd=conn.createStatement();
					if(Double.parseDouble(tax[2])>0){
						String strtaxinvd="insert into gl_invd(sr_no,brhid,rdocno,trno,chid,units,total,acno,amount)values('"+tempsrno+"','"+cmbbranch+"','"+invdocno+"'"+
								",'"+invtrno+"','"+(tax[0].equalsIgnoreCase("undefined") || tax[0].isEmpty()?0:tax[0])+"','1','"+(tax[2].equalsIgnoreCase("undefined") || tax[2].isEmpty()?0:tax[2])+"','"+(tax[1].equalsIgnoreCase("undefined") || tax[1].isEmpty()?0:tax[1])+"','"+(tax[2].equalsIgnoreCase("undefined") || tax[2].isEmpty()?0:tax[2])+"')";	
									System.out.println("Invd Sql:"+strtaxinvd);
						int taxinvdval=stmttaxinvd.executeUpdate(strtaxinvd);
						if(taxinvdval>0){
							String strtaxjv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
									"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype)values('"+invtrno+"','"+(tax[1].equalsIgnoreCase("undefined") || tax[1].isEmpty()?0:tax[1])+"',"+
									"'"+Double.parseDouble(tax[2])*-1+"','"+currencyrate+"','"+currencyid+"',0,-1,'"+(tempsrno)+"',"+
									"'"+cmbbranch+"','"+note+"',"+
									"0,'"+sqlToDate+"','INS','"+(Double.parseDouble(tax[2])*currencyrate)*-1+"','"+invdocno+"','"+(tax[3].equalsIgnoreCase("undefined") || tax[3].isEmpty()?0:tax[3])+"',"+
									"'"+currencyid+"','5',1,'"+cldocno+"',3,'"+agmtno+"','"+agmttype+"')";
							tempsrno++;
							Statement stmttaxjv=conn.createStatement();
											System.out.println("Jvtran Sql:"+strtaxjv);
							int taxjvval=stmttaxjv.executeUpdate(strtaxjv);
							if(taxjvval>0){

							}
							else{
								System.out.println("Jvtran Tax Error");
								return 0;
							}
							stmttaxjv.close();
							stmttaxinvd.close();
						}
						else{
							System.out.println("Tax Invd Error");
							return 0;
						}
					}
				}
				stmtchecktax.close();
				//stmtgetinvmode.close();
				stmtgettax.close();
			}

		}
			if(salikamount>0){
				String strupdatesalik="update gl_salik s left join gl_lagmt lagmt on (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) left join gl_ragmt ragmt on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RD','RM','RW')) left join my_acbook a on (s.emp_id=a.cldocno and s.emp_type=a.dtype) "+
				" set s.inv_no="+invdocno+",s.inv_type='INV',s.status=1  where s.inv_no=0 and s.isallocated=1 and s.ra_no<>0 and s.amount>0  "+sql+" and "+
				" if(s.rtype in ('LA','LC'),lagmt.brhid,ragmt.brhid)="+cmbbranch+" and s.emp_id="+cldocno+" and s.emp_type='CRM'";
				int updatesalik=stmt.executeUpdate(strupdatesalik);
				if(updatesalik<=0){
					conn.close();
					return 0;
				}
				double salikamt=salikamount+saliksrvc;
				double salikamtldr=salikamt*currencyrate;
				String sqljv="insert into my_jvtran(tr_no,acno,dramount,rate,curid,out_amount,id,ref_row,brhid,description,yrid,date,dtype,ldramount,"+
				"doc_no,ref_detail,lbrrate,trtype,lage,cldocno,status,rdocno,rtype,duedate)values('"+invtrno+"','"+acno+"',"+
				"'"+salikamt+"','"+currencyrate+"','"+currencyid+"',0,1,8,'"+cmbbranch+"','"+note+"',"+
				"0,'"+sqlToDate+"','INS','"+salikamtldr+"',"+invdocno+",'"+salikcount+" Saliks',"+
				"'"+currencyid+"','5',1,"+cldocno+",3,'"+agmtno+"','"+agmttype+"','"+duedate+"')";
				
				int jvinsert=stmt.executeUpdate(sqljv);
				if(jvinsert<=0){
					conn.close();
					return 0;
				}
				int srno=0;
				String strgettranid="select coalesce(tranid,0) tranid from my_jvtran where acno="+saliksrvcacno+" and tr_no="+invtrno+"";
				ResultSet rsgettranid=stmt.executeQuery(strgettranid);
				int tranid=0;
				while(rsgettranid.next()) {
					tranid=rsgettranid.getInt("tranid");
				}
				String strgetsalik="select count(*),s.fleetno,sum(if(s.Source<>'AUH',1,0)*if(ac.ser_default=0,per_salikrate,"+saliksrvDXB+")) saliksrv from gl_salik s left join gl_lagmt lagmt on (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) "+
				" left join gl_ragmt ragmt on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RW','RD','RM')) left join my_acbook ac on (if(s.rtype in ('LA','LC'),lagmt.cldocno,ragmt.cldocno)=ac.cldocno and ac.dtype='CRM') where s.inv_no="+invdocno+" and s.inv_type='INV' and s.source<>'AUH' group by s.fleetno";
				System.out.println(strgetsalik);
				ResultSet rsgetsalik=stmt.executeQuery(strgetsalik);
				while(rsgetsalik.next()){
					double saliksrv=(rsgetsalik.getDouble("saliksrv"))*-1;
					if(saliksrv>0.0){
						String fleetno=rsgetsalik.getString("fleetno");
						srno++;
						int costtraninsert=costtranInsert(saliksrv,fleetno,conn,tranid,invtrno,saliksrvcacno,srno);
						if(costtraninsert<=0){
							conn.close();
							return 0;
						}
					}
				}
				strgettranid="select coalesce(tranid,0) tranid from my_jvtran where acno="+salikauhsrvcacno+" and tr_no="+invtrno+"";
				rsgettranid=stmt.executeQuery(strgettranid);
				while(rsgettranid.next()) {
					tranid=rsgettranid.getInt("tranid");
				}
				String strgetsalikauh="select count(*),s.fleetno,sum(if(s.Source='AUH',1,0)*if(ac.ser_default=0,per_salikrate,"+saliksrvAUH+")) saliksrv from gl_salik s left join gl_lagmt lagmt on (s.ra_no=lagmt.doc_no and s.rtype in ('LA','LC')) "+
				" left join gl_ragmt ragmt on (s.ra_no=ragmt.doc_no and s.rtype in ('RA','RW','RD','RM')) left join my_acbook ac on \r\n" + 
				"(if(s.rtype in ('LA','LC'),lagmt.cldocno,ragmt.cldocno)=ac.cldocno and ac.dtype='CRM') where s.inv_no="+invdocno+" and s.inv_type='INV'  and s.source='AUH' group by s.fleetno";
				ResultSet rsgetsalikauh=stmt.executeQuery(strgetsalikauh);
				while(rsgetsalikauh.next()){
					double saliksrv=(rsgetsalikauh.getDouble("saliksrv"))*-1;
					if(saliksrv>0.0){
						String fleetno=rsgetsalikauh.getString("fleetno");
						srno++;
						int costtraninsert=costtranInsert(saliksrv,fleetno,conn,tranid,invtrno,salikauhsrvcacno,srno);
						if(costtraninsert<=0){
							conn.close();
							return 0;
						}
					}
				}
			}

			//Checking Sum
			String strsum="select dramount amt from my_jvtran where tr_no="+invtrno;
			ResultSet rssum=stmt.executeQuery(strsum);
			while(rssum.next()) {
				System.out.println(rssum.getDouble("amt"));
			}
			
			String strsumvalid="select sum(dramount) sumamt from my_jvtran where tr_no="+invtrno;
			ResultSet rssumvalid=stmt.executeQuery(strsumvalid);
			while(rssumvalid.next()) {
				if(rssumvalid.getDouble("sumamt")!=0.0) {
					return 0;
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return invdocno;
	}

	private int costtranInsert(double saliksrv, String fleetno,
			Connection conn, int tranid, int invtrno, int saliksrvcacno,
			int srno) throws SQLException {
		// TODO Auto-generated method stub
		try{
			Statement stmt=conn.createStatement();
			String strsql="insert into my_costtran(acno,costtype,amount,sr_no,tranid,projectid,jobid,tr_no)values("+saliksrvcacno+",6,"+saliksrv+","+srno+","+tranid+",0,"+fleetno+","+invtrno+")";
			int costinsert=stmt.executeUpdate(strsql);
			if(costinsert<=0){
				return 0;
			}
			else{
				return srno;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return 0;
	}
}
