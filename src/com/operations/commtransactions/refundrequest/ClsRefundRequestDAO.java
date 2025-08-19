package com.operations.commtransactions.refundrequest;
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

public class ClsRefundRequestDAO {
	ClsConnection connDAO=new ClsConnection();  
	ClsCommon CommonDAO=new ClsCommon();
	Connection conn;   
	public int insert(Date sqlStartDate,String reftype,String refdocno,String remarks,String branch,String mode,ArrayList<String> tourarray,ArrayList<String> ticketarray,ArrayList<String> hotelarray, HttpSession session,HttpServletRequest request) throws SQLException {
		try{
			int docno;
			conn=connDAO.getMyConnection();  
			conn.setAutoCommit(false);
			Statement stmt = conn.createStatement ();
			if(branch.equalsIgnoreCase("") || branch==null){               
				branch="0";         
			}
			CallableStatement stmtRR = conn.prepareCall("{call tr_refundrequestDML(?,?,?,?,?,?,?,?,?)}");              
			stmtRR.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtRR.registerOutParameter(9, java.sql.Types.INTEGER);           
			stmtRR.setDate(1,sqlStartDate);
			stmtRR.setString(2,reftype);    
			stmtRR.setString(3,refdocno);
			stmtRR.setString(4,remarks);
			stmtRR.setString(5,session.getAttribute("USERID").toString());   
			stmtRR.setString(6,branch);
			stmtRR.setString(7,mode);           
			stmtRR.executeQuery();
			docno=stmtRR.getInt("docNo");      
			int vocno=stmtRR.getInt("vocNo");	
			request.setAttribute("vocno", vocno);   
			if(docno<=0){
				 conn.close();
				return 0;
			}	
			if(docno>0){
				if(reftype.equalsIgnoreCase("T")){  
					for(int i=0;i< tourarray.size();i++){
						String[] tours=tourarray.get(i).split("::");
						
						 if(!tours[0].equalsIgnoreCase("undefined") && !tours[0].equalsIgnoreCase("NaN")){  
						
							String sql1="update tr_srtour set rrdocno='"+docno+"',refund='1',"                 
								+ " adultnew='"+(tours[1].trim().equalsIgnoreCase("undefined") || tours[1].trim().equalsIgnoreCase("NaN") || tours[1].trim().isEmpty()?0:tours[1].trim())+"',"
								+ " childnew='"+(tours[2].trim().equalsIgnoreCase("undefined") || tours[2].trim().equalsIgnoreCase("NaN") || tours[2].trim().isEmpty()?0:tours[2].trim())+"',"
								+ " totalsp='"+(tours[3].trim().equalsIgnoreCase("undefined") || tours[3].trim().equalsIgnoreCase("NaN") || tours[3].trim().isEmpty()?0.0:tours[3].trim())+"'"
							    + " where rowno='"+(tours[0].trim().equalsIgnoreCase("undefined") || tours[0].trim().equalsIgnoreCase("NaN") || tours[0].trim().isEmpty()?0:tours[0].trim())+"'";          
						 int data = stmt.executeUpdate(sql1);
						 //System.out.println("======data======="+data);              
						 if(data<=0){
							stmt.close();  
							conn.close();
							return 0;
						 }
					   }
					} 
				}else if(reftype.equalsIgnoreCase("A")){
					for(int i=0;i< ticketarray.size();i++){
						String[] tickets=ticketarray.get(i).split("::");
						
						if(!tickets[0].equalsIgnoreCase("undefined") && !tickets[0].equalsIgnoreCase("NaN")){  
							
					     String sql2="update ti_ticketvoucherd set rrdocno='"+docno+"',refund='1'  where rowno='"+(tickets[0].trim().equalsIgnoreCase("undefined") || tickets[0].trim().equalsIgnoreCase("NaN") || tickets[0].trim().isEmpty()?0:tickets[0].trim())+"'";          
						 int data = stmt.executeUpdate(sql2);
						// System.out.println(tickets[0].trim()+"======sql2======="+sql2);                     
						 if(data<=0){
							stmt.close();  
							conn.close();
							return 0;
						 }
					   }
					} 
				}else if(reftype.equalsIgnoreCase("V")){
					for(int i=0;i< hotelarray.size();i++){
						String[] vouchers=hotelarray.get(i).split("::");   
						
						if(!vouchers[0].equalsIgnoreCase("undefined") && !vouchers[0].equalsIgnoreCase("NaN")){  
							
							 String sql3="update ti_hotelvoucherd set rrdocno='"+docno+"',refund='1'  where rowno='"+(vouchers[0].trim().equalsIgnoreCase("undefined") || vouchers[0].trim().equalsIgnoreCase("NaN") || vouchers[0].trim().isEmpty()?0:vouchers[0].trim())+"'";
							 int data = stmt.executeUpdate(sql3);        
						     //System.out.println("======sql3======="+sql3);                
						 if(data<=0){
							stmt.close();  
							conn.close();
							return 0;
						 }
					   }
					} 
				}else{}
			}     
			if (docno > 0) {
				conn.commit();
				stmtRR.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
		e.printStackTrace();
			conn.close();	
		}
		return 0;
	   }
   public JSONArray searchRefno(HttpSession session,String clname,String reftype,String id,String brhid) throws SQLException {                 
	   	    JSONArray RESULTDATA=new JSONArray();   
	   	    //System.out.println("id--->>>"+id);   
	   	    if(!id.equalsIgnoreCase("1")){
	   	       return RESULTDATA;
	   	    }
	    	String sqltest="",clsql="";  
	    	if(!(clname.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and refname like '%"+clname+"%'";
	    	}
	    	Connection conn = null;       
			try {
					conn = connDAO.getMyConnection();
					Statement stmtVeh1 = conn.createStatement ();
					if(reftype.equalsIgnoreCase("T")){   
						 clsql= "select doc_no docno,voc_no vocno,refname from tr_servicereqm m left join tr_srtour sr on sr.rdocno=m.doc_no where status<>7 and brhid='"+brhid+"' and sr.refund=0 "+sqltest+" group by m.doc_no order by m.doc_no";  
					}else if(reftype.equalsIgnoreCase("A")){
						 clsql= "select m.doc_no docno,m.voc_no vocno,ac.refname from ti_ticketvoucherm m left join ti_ticketvoucherd d on d.rdocno=m.doc_no left join my_acbook ac on (ac.cldocno=d.cldocno and ac.dtype='crm') where m.status<>7 and m.brhid='"+brhid+"' and d.refund=0 "+sqltest+" group by m.doc_no order by m.doc_no";
					}else if(reftype.equalsIgnoreCase("V")){  
						 clsql= "select m.doc_no docno,m.voc_no vocno,ac.refname from ti_hotelvoucherm m left join ti_hotelvoucherd d on d.rdocno=m.doc_no left join my_acbook ac on (ac.cldocno=d.cldocno and ac.dtype='crm') where m.status<>7 and m.brhid='"+brhid+"'  and d.refund=0 "+sqltest+" group by m.doc_no order by m.doc_no";
					}else{}    
					//System.out.println("clsql========"+clsql);              
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
	 
   public   JSONArray searchMaster(HttpSession session,String msdocno,String reftype,String trdate,String id,String brhid) throws SQLException {
  	    JSONArray RESULTDATA=new JSONArray();      
  	    if(!id.equalsIgnoreCase("1")){
  	       return RESULTDATA;
  	     }
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
	   	if(!(reftype.equalsIgnoreCase(""))){
	   		sqltest=sqltest+" and m.reftype like '%"+reftype+"%'";
	   	}
	   	if(!(sqlStartDate==null)){   
	   		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
	   	} 
	   	Connection conn = null;
			try { 
					conn = connDAO.getMyConnection();
					Statement stmtenq1 = conn.createStatement ();      
					String clssql= "select m.doc_no,m.voc_no,m.date,coalesce(m.reftype,'') reftypeid,case when m.reftype='T' then 'Travel Desk' when m.reftype='A' then 'Air Ticket' when m.reftype='V' then 'Voucher' else '' end as reftype,m.refdocno,m.remarks,case when m.reftype='T' then coalesce(s.refname,'') when m.reftype='A' then coalesce(ac1.refname,'') when m.reftype='V' then coalesce(ac2.refname,'') else '' end as refname,convert(case when m.reftype='T' then coalesce(s.voc_no,'') when m.reftype='A' then coalesce(t.voc_no,'') when m.reftype='V' then coalesce(h.voc_no,'') else '' end,char(40)) as refno   from tr_refundrequestm m left join tr_servicereqm s on (s.doc_no=m.refdocno and m.reftype='T')  left join tr_srtour sr on (sr.rdocno=s.doc_no and sr.refund=1) left join ti_ticketvoucherm t on (t.doc_no=m.refdocno and m.reftype='A') left join ti_ticketvoucherd td on (td.rdocno=t.doc_no and td.refund=1) left join ti_hotelvoucherm h on (h.doc_no=m.refdocno and m.reftype='V')  left join ti_hotelvoucherd hd on (hd.rdocno=h.doc_no and hd.refund=1) left join my_acbook ac1 on (ac1.cldocno=td.cldocno and ac1.dtype='crm') left join my_acbook ac2 on (ac2.cldocno=hd.cldocno and ac2.dtype='crm') where m.status<>7 and m.brhid='"+brhid+"' "+sqltest+" group by m.doc_no order by m.doc_no";
					//System.out.println("Main SQL========"+clssql);            
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
		public JSONArray tourGrid(String rdocno,String check,String refund,String rrdocno) throws SQLException{  
			JSONArray data=new JSONArray();                   
			 if(!(check.equalsIgnoreCase("1"))){  
		          	return data;
		          }
			Connection conn=null; 
			try{   
				conn=connDAO.getMyConnection();    
				Statement stmt=conn.createStatement();        
				String sqltest="";
			   	if(!(rrdocno.equalsIgnoreCase("0"))){
			   		sqltest=sqltest+" and m.rrdocno='"+rrdocno+"'";        
			   	}      
				String strsql="select m.refund,m.adultnew,m.childnew,round(m.totalsp,2) totalnew,m.tourdocno,acc.acno clientacno,h.sal_name salesagent,h.acc_no satacno,h.doc_no satdocno ,m.confirm,distype,adultdis,childdis,m.time,m.tourid,coalesce(m.rowno,0) rowno,name tourname,m.remarks,DATE_FORMAT(m.date,'%d.%m.%Y') date,coalesce(vendorid,0) vndid,ac.refname vendor,coalesce(m.adult,0) adult,coalesce(m.child,0) child,coalesce(m.spadult,0) spadult,coalesce(m.spchild,0) spchild,coalesce(m.adultval,0) adultval,coalesce(m.childval,0) childval,coalesce(m.total,0) total from tr_srtour m left join TR_servicereqm det on   det.doc_no=m.rdocno left join my_acbook acc on det.cldocno=acc.doc_no left join my_salesman h on h.doc_no=det.satdocno and sal_type='sla' left join my_acbook ac on m.vendorid=ac.doc_no left join tr_tours tr on m.tourid=tr.doc_no where rdocno='"+rdocno+"' and m.refund='"+refund+"' "+sqltest+"";        
				//System.out.println("tourGridinvoice--->>>"+strsql);                                                  
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
		public JSONArray loadHotelGrid(String brhid,String docno,String id,HttpSession session,String refund,String rrdocno) throws SQLException{                 
			JSONArray data=new JSONArray();   
			if(!id.equalsIgnoreCase("1")){ 
				return data;
			}
			Connection conn=null; 
			try{ 
				conn=connDAO.getMyConnection();  
				Statement stmt=conn.createStatement(); 
				String sqltest="";
			   	if(!(rrdocno.equalsIgnoreCase("0"))){
			   		sqltest=sqltest+" and d.rrdocno='"+rrdocno+"'";        
			   	} 
				String strsql="select d.cpudoc,d.invtrno,d.cldocno,d.vnddocno,m.voc_no,coalesce(suptotal,0) suptotal, coalesce(servfee,0) servfee, coalesce(paybackamt,0) paybackamt, coalesce(sprice,0) sprice,d.rowno,suppconfno,DATE_FORMAT(issuedate,'%d.%m.%Y') issuedate,u1.user_name isstaff,cn.country_name country,cy.city_name city,ht.name hotel,d.roomtype,"
						+ "ac.refname customer,acc.refname vendor from ti_hotelvoucherm m left join ti_hotelvoucherd d on d.rdocno=m.doc_no  left join my_acbook ac on (ac.cldocno=d.cldocno and ac.dtype='CRM')"
						+ " left join my_acbook acc on (acc.cldocno=d.vnddocno and acc.dtype='VND')  left join my_user u1 on u1.doc_no=d.isstaffid  left join my_acountry cn on cn.doc_no=d.countryid"
						+ " left join my_acity cy on cy.doc_no=d.cityid left join tr_hotel ht on ht.doc_no=d.hotelid  where m.status<>7  and m.doc_no in("+docno+") and d.refund='"+refund+"'  "+sqltest+"";     
				//System.out.println("strsql-------------->>>"+strsql);    
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
		public JSONArray loadTicketGrid(String brhid,String docno,String id,HttpSession session,String refund,String rrdocno) throws SQLException{                        
			JSONArray data=new JSONArray(); 
			if(!id.equalsIgnoreCase("1")){
				return data;
			}
			Connection conn=null; 
			try{ 
				conn=connDAO.getMyConnection();  
				Statement stmt=conn.createStatement(); 
				String sqltest="";
			   	if(!(rrdocno.equalsIgnoreCase("0"))){
			   		sqltest=sqltest+" and d.rrdocno='"+rrdocno+"'";        
			   	} 
				String strsql="select  d.cpudoc,d.invtrno,d.cldocno,d.vnddocno,m.voc_no,coalesce(suptotal,0) suptotal, coalesce(servfee,0) servfee, coalesce(paybackamt,0) paybackamt, coalesce(sprice,0) sprice,d.prnno,d.rowno,ticketno, d.cldocno, vnddocno, bookdate, issuedate, guest, ar.name airline, airlineid, sector, d.class classes, gds, bstaffid, tstaffid,u1.user_name bstaff,u2.user_name tstaff, issuetype, d.type, tickettype,"
						+ "ac.refname customer,acc.refname vendor from ti_ticketvoucherm m left join ti_ticketvoucherd d on d.rdocno=m.doc_no  left join my_acbook ac on (ac.cldocno=d.cldocno and ac.dtype='CRM')"
						+ " left join my_acbook acc on (acc.cldocno=d.vnddocno and acc.dtype='VND') left join ti_airline ar on ar.doc_no=d.airlineid left join my_user u1 on u1.doc_no=d.bstaffid "
						+ " left join my_user u2 on u2.doc_no=d.tstaffid where m.status<>7   and m.doc_no in("+docno+") and d.refund='"+refund+"'  "+sqltest+"";    
				//System.out.println("strsql-------------->>>"+strsql);     
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
