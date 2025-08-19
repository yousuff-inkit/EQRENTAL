package com.dashboard.travel.refundrequestmanagement;
    
	import com.common.ClsCommon;
    import com.connection.ClsConnection;
    import com.ibm.icu.text.SimpleDateFormat;
	import java.sql.*;
    import java.util.ArrayList;
    import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpSession;
    import net.sf.json.JSONArray;
	public class ClsRefundRequestManagementDAO {  

		ClsConnection objconn=new ClsConnection();     
		ClsCommon objcommon=new ClsCommon();  
		
		public int insert(int rrdocno,int brhid,ArrayList<String> termarray,HttpSession session,HttpServletRequest request,String mode) throws SQLException {
			Connection conn=null; 
			try{ 
			int status=3,val=0;       
			String dtype="";   
			conn=objconn.getMyConnection();   
			conn.setAutoCommit(false); 
			Statement stmt = conn.createStatement ();   
			CallableStatement stmt2=null;
			CallableStatement stmt3=null;
			SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");                
			java.util.Date curDate=new java.util.Date();
		    java.sql.Date cdate=objcommon.changeStringtoSqlDate(formatter.format(curDate));
			//System.out.println("in dao ===="+rrdocno);  
			//System.out.println("in dao ===="+termarray);
		    if(rrdocno>0){
			 for(int i=0;i< termarray.size();i++){     
					String[] gridarraydet=((String) termarray.get(i)).split("::");          
					int rid=gridarraydet[0].trim().equalsIgnoreCase("undefined") || gridarraydet[0].trim().equalsIgnoreCase("NaN")|| gridarraydet[0].trim().equalsIgnoreCase("")|| gridarraydet[0].isEmpty()?0:Integer.parseInt(gridarraydet[0].trim());
					int refrowno=gridarraydet[13].trim().equalsIgnoreCase("undefined") || gridarraydet[13].trim().equalsIgnoreCase("NaN")|| gridarraydet[13].trim().equalsIgnoreCase("")|| gridarraydet[13].isEmpty()?0:Integer.parseInt(gridarraydet[13].trim());
					java.sql.Date expdt=(gridarraydet[14].trim().equalsIgnoreCase("undefined") || gridarraydet[14].trim().equalsIgnoreCase("NaN")|| gridarraydet[14].trim().equalsIgnoreCase("")|| gridarraydet[14].isEmpty()?null:objcommon.changetstmptoSqlDate(gridarraydet[14].trim()));
					//System.out.println("in==insert===="+rid); 
					if(rid>0){     
						//System.out.println("in edit");    
						stmt3 = conn.prepareCall("update tr_refundmanagement set userid=?, doc_type=?, date=?, srvalue=?, sinclusive=?, svalue=?, svat=?, stotal=?, prvalue=?, pinclusive=?, pvalue=?, pvat=?, ptotal=?, pstock=?, expdate=?  where rowno=?");
					 	stmt3.setString(1,session.getAttribute("USERID").toString());  
						stmt3.setString(2,(gridarraydet[1].trim().equalsIgnoreCase("undefined") || gridarraydet[1].trim().equalsIgnoreCase("NaN")|| gridarraydet[1].trim().equalsIgnoreCase("")|| gridarraydet[1].isEmpty()?"":gridarraydet[1].trim()));    
						stmt3.setDate(3,cdate);     
						stmt3.setDouble(4,(gridarraydet[2].trim().equalsIgnoreCase("undefined") || gridarraydet[2].trim().equalsIgnoreCase("NaN")|| gridarraydet[2].trim().equalsIgnoreCase("")|| gridarraydet[2].isEmpty()?0.0:Double.parseDouble(gridarraydet[2].trim())));
						stmt3.setString(5,(gridarraydet[3].trim().equalsIgnoreCase("undefined") || gridarraydet[3].trim().equalsIgnoreCase("NaN")|| gridarraydet[3].trim().equalsIgnoreCase("")|| gridarraydet[3].isEmpty()?"0":gridarraydet[3].trim()));
						stmt3.setDouble(6,(gridarraydet[4].trim().equalsIgnoreCase("undefined") || gridarraydet[4].trim().equalsIgnoreCase("NaN")|| gridarraydet[4].trim().equalsIgnoreCase("")|| gridarraydet[4].isEmpty()?0.0:Double.parseDouble(gridarraydet[4].trim())));
						stmt3.setDouble(7,(gridarraydet[5].trim().equalsIgnoreCase("undefined") || gridarraydet[5].trim().equalsIgnoreCase("NaN")|| gridarraydet[5].trim().equalsIgnoreCase("")|| gridarraydet[5].isEmpty()?0.0:Double.parseDouble(gridarraydet[5].trim())));
						stmt3.setDouble(8,(gridarraydet[6].trim().equalsIgnoreCase("undefined") || gridarraydet[6].trim().equalsIgnoreCase("NaN")|| gridarraydet[6].trim().equalsIgnoreCase("")|| gridarraydet[6].isEmpty()?0.0:Double.parseDouble(gridarraydet[6].trim())));
						stmt3.setDouble(9,(gridarraydet[7].trim().equalsIgnoreCase("undefined") || gridarraydet[7].trim().equalsIgnoreCase("NaN")|| gridarraydet[7].trim().equalsIgnoreCase("")|| gridarraydet[7].isEmpty()?0.0:Double.parseDouble(gridarraydet[7].trim())));
						stmt3.setDouble(10,(gridarraydet[8].trim().equalsIgnoreCase("undefined") || gridarraydet[8].trim().equalsIgnoreCase("NaN")|| gridarraydet[8].trim().equalsIgnoreCase("")|| gridarraydet[8].isEmpty()?0.0:Double.parseDouble(gridarraydet[8].trim())));
						stmt3.setDouble(11,(gridarraydet[9].trim().equalsIgnoreCase("undefined") || gridarraydet[9].trim().equalsIgnoreCase("NaN")|| gridarraydet[9].trim().equalsIgnoreCase("")|| gridarraydet[9].isEmpty()?0.0:Double.parseDouble(gridarraydet[9].trim())));
						stmt3.setDouble(12,(gridarraydet[10].trim().equalsIgnoreCase("undefined") || gridarraydet[10].trim().equalsIgnoreCase("NaN")|| gridarraydet[10].trim().equalsIgnoreCase("")|| gridarraydet[10].isEmpty()?0.0:Double.parseDouble(gridarraydet[10].trim())));
						stmt3.setDouble(13,(gridarraydet[11].trim().equalsIgnoreCase("undefined") || gridarraydet[11].trim().equalsIgnoreCase("NaN")|| gridarraydet[11].trim().equalsIgnoreCase("")|| gridarraydet[11].isEmpty()?0.0:Double.parseDouble(gridarraydet[11].trim())));
						stmt3.setString(14,(gridarraydet[12].trim().equalsIgnoreCase("undefined") || gridarraydet[12].trim().equalsIgnoreCase("NaN")|| gridarraydet[12].trim().equalsIgnoreCase("")|| gridarraydet[12].isEmpty()?"0":gridarraydet[12].trim().toString()));                         
						stmt3.setDate(15,expdt);    
						stmt3.setInt(16,rid);   
						//System.out.println("stmt3"+stmt3);                                        
						val = stmt3.executeUpdate();    
					}else{
						String strsql="select coalesce(refrowno,0) refrowno from tr_refundmanagement where refrowno='"+refrowno+"'";	     
						ResultSet rs = stmt.executeQuery(strsql);
						int docnowise=0;
						while(rs.next()){
							docnowise=rs.getInt("refrowno");        
						}
						//System.out.println("in insert"); 
						if(docnowise==0){
						stmt2 = conn.prepareCall("insert into tr_refundmanagement(rrdocno, brhid, userid, doc_type, date, srvalue, sinclusive, svalue, svat, stotal, prvalue, pinclusive, pvalue, pvat, ptotal, pstock, refrowno,expdate) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
					 	stmt2.setInt(1,rrdocno); 
					 	stmt2.setInt(2,brhid);
					 	stmt2.setString(3,session.getAttribute("USERID").toString());  
						stmt2.setString(4,(gridarraydet[1].trim().equalsIgnoreCase("undefined") || gridarraydet[1].trim().equalsIgnoreCase("NaN")|| gridarraydet[1].trim().equalsIgnoreCase("")|| gridarraydet[1].isEmpty()?"":gridarraydet[1].trim()));    
						stmt2.setDate(5,cdate);     
						stmt2.setDouble(6,(gridarraydet[2].trim().equalsIgnoreCase("undefined") || gridarraydet[2].trim().equalsIgnoreCase("NaN")|| gridarraydet[2].trim().equalsIgnoreCase("")|| gridarraydet[2].isEmpty()?0.0:Double.parseDouble(gridarraydet[2].trim())));
						stmt2.setString(7,(gridarraydet[3].trim().equalsIgnoreCase("undefined") || gridarraydet[3].trim().equalsIgnoreCase("NaN")|| gridarraydet[3].trim().equalsIgnoreCase("")|| gridarraydet[3].isEmpty()?"0":gridarraydet[3].trim()));
						stmt2.setDouble(8,(gridarraydet[4].trim().equalsIgnoreCase("undefined") || gridarraydet[4].trim().equalsIgnoreCase("NaN")|| gridarraydet[4].trim().equalsIgnoreCase("")|| gridarraydet[4].isEmpty()?0.0:Double.parseDouble(gridarraydet[4].trim())));
						stmt2.setDouble(9,(gridarraydet[5].trim().equalsIgnoreCase("undefined") || gridarraydet[5].trim().equalsIgnoreCase("NaN")|| gridarraydet[5].trim().equalsIgnoreCase("")|| gridarraydet[5].isEmpty()?0.0:Double.parseDouble(gridarraydet[5].trim())));
						stmt2.setDouble(10,(gridarraydet[6].trim().equalsIgnoreCase("undefined") || gridarraydet[6].trim().equalsIgnoreCase("NaN")|| gridarraydet[6].trim().equalsIgnoreCase("")|| gridarraydet[6].isEmpty()?0.0:Double.parseDouble(gridarraydet[6].trim())));
						stmt2.setDouble(11,(gridarraydet[7].trim().equalsIgnoreCase("undefined") || gridarraydet[7].trim().equalsIgnoreCase("NaN")|| gridarraydet[7].trim().equalsIgnoreCase("")|| gridarraydet[7].isEmpty()?0.0:Double.parseDouble(gridarraydet[7].trim())));
						stmt2.setDouble(12,(gridarraydet[8].trim().equalsIgnoreCase("undefined") || gridarraydet[8].trim().equalsIgnoreCase("NaN")|| gridarraydet[8].trim().equalsIgnoreCase("")|| gridarraydet[8].isEmpty()?0.0:Double.parseDouble(gridarraydet[8].trim())));
						stmt2.setDouble(13,(gridarraydet[9].trim().equalsIgnoreCase("undefined") || gridarraydet[9].trim().equalsIgnoreCase("NaN")|| gridarraydet[9].trim().equalsIgnoreCase("")|| gridarraydet[9].isEmpty()?0.0:Double.parseDouble(gridarraydet[9].trim())));
						stmt2.setDouble(14,(gridarraydet[10].trim().equalsIgnoreCase("undefined") || gridarraydet[10].trim().equalsIgnoreCase("NaN")|| gridarraydet[10].trim().equalsIgnoreCase("")|| gridarraydet[10].isEmpty()?0.0:Double.parseDouble(gridarraydet[10].trim())));
						stmt2.setDouble(15,(gridarraydet[11].trim().equalsIgnoreCase("undefined") || gridarraydet[11].trim().equalsIgnoreCase("NaN")|| gridarraydet[11].trim().equalsIgnoreCase("")|| gridarraydet[11].isEmpty()?0.0:Double.parseDouble(gridarraydet[11].trim())));
						stmt2.setString(16,(gridarraydet[12].trim().equalsIgnoreCase("undefined") || gridarraydet[12].trim().equalsIgnoreCase("NaN")|| gridarraydet[12].trim().equalsIgnoreCase("")|| gridarraydet[12].isEmpty()?"0":gridarraydet[12].trim().toString()));                         
						stmt2.setString(17,(gridarraydet[13].trim().equalsIgnoreCase("undefined") || gridarraydet[13].trim().equalsIgnoreCase("NaN")|| gridarraydet[13].trim().equalsIgnoreCase("")|| gridarraydet[13].isEmpty()?"0":gridarraydet[13].trim()));
						stmt2.setDate(18,expdt);        
						//System.out.println("stmt2"+stmt2);                                          
						val = stmt2.executeUpdate();
						}
					}
			}
		    }
		  	if(val<=0){             
		  		conn.close();
		        return 0;
		      }
			if (val > 0) {      
				conn.commit();
				conn.close();
				return val;       
			}
		}catch(Exception e){	
			e.printStackTrace();
			conn.close();	
		}
		return 0;
	}
		public JSONArray detailGrid(HttpSession session, String check,String todate,String branch) throws SQLException{ 
			JSONArray data=new JSONArray(); 
			if(!check.equalsIgnoreCase("1")){              
				return data;
			}
			Connection conn=null; 
			java.sql.Date edates = null; 
			try{  
			conn=objconn.getMyConnection();   
			Statement stmt=conn.createStatement();
			String sqltest="";   
			java.sql.Date sqltodate=null;
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){    
				sqltest+=" and m.brhid="+branch;
			}
			if( sqltodate!=null){                 
					sqltest+=" and m.date<='"+sqltodate+"'";                    
			}
			String strsql="select convert(case when m.reftype='T' then s.voc_no when m.reftype='A' then t.voc_no when m.reftype='V' then h.voc_no else '' end,char(50)) refno,case when m.reftype='T' then 'Travel Desk' when m.reftype='A' then 'Air Ticket' when m.reftype='V' then 'Voucher' else '' end as reftype,date_format(m.date,'%d.%m.%Y') date,b.BRANCHNAME branch,m.voc_no vocno,m.doc_no docno,u.user_name user,m.remarks,case when m.reftype='T' then coalesce(s.refname,'') when m.reftype='A' then coalesce(ac1.refname,'') when m.reftype='V' then coalesce(ac2.refname,'') else '' end as refname,case when m.reftype='T' then sum(coalesce(sr.totalsp,0)) when m.reftype='A' then sum(coalesce(td.sprice,0)) when m.reftype='V' then sum(coalesce(hd.sprice,0)) else 0 end as amount from tr_refundrequestm m left join my_brch b on b.doc_no=m.brhid left join my_user u on u.doc_no=m.userid left join tr_srtour sr on (m.doc_no=sr.rrdocno and m.reftype='T' and sr.refund=1) left join tr_servicereqm s on (sr.rdocno=s.doc_no) left join ti_ticketvoucherd td on (m.doc_no=td.rrdocno and m.reftype='A' and td.refund=1) left join ti_ticketvoucherm t on (t.doc_no=td.rdocno)  left join ti_hotelvoucherd hd on (m.doc_no=hd.rrdocno and m.reftype='V' and hd.refund=1) left join ti_hotelvoucherm h on (h.doc_no=hd.rdocno) left join my_acbook ac1 on (ac1.cldocno=td.cldocno and ac1.dtype='crm') left join my_acbook ac2 on (ac2.cldocno=hd.cldocno and ac2.dtype='crm') where m.confirm=0 and m.status=3 "+sqltest+" group by m.doc_no";         
			//System.out.println("travel Grid--->>>"+strsql);                   
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs); 
			} 
			catch(Exception e){
			e.printStackTrace();
			}
			finally{
			conn.close(); 
			}
			return data;
			}
		public JSONArray subGrid(HttpSession session, String check,String docno,String reftype) throws SQLException{   
			JSONArray data=new JSONArray(); 
			if(!check.equalsIgnoreCase("1")){              
				return data;
			}
			Connection conn=null; 
			String strsql="",sqltest="";
			int temp=0;
			try{    
			conn=objconn.getMyConnection();   
			Statement stmt=conn.createStatement();
			if(reftype.equalsIgnoreCase("Travel Desk")){
				sqltest=" group by sr.rowno";   
			}else if(reftype.equalsIgnoreCase("Air Ticket")){  
				sqltest=" group by td.rowno";   
			}else if(reftype.equalsIgnoreCase("Voucher")){  
				sqltest=" group by hd.rowno";      
			}else{}
			
			String strcheck="select rowno from tr_refundmanagement where rrdocno='"+docno+"'";                
			ResultSet rscheck=stmt.executeQuery(strcheck);   
			while(rscheck.next()){   
				temp++;
			}
			if(temp==0){         
				 strsql="select date_format(rm.expdate,'%d.%m.%Y') expdate,round(coalesce(sr.totalsp,0),2) sprice,round((coalesce(sr.adultnew,0)*coalesce(sr.adultval,0))+(coalesce(sr.childnew,0)*coalesce(sr.childval,0)),2) stdtotal,case when m.reftype='T' then sr.rowno when m.reftype='A' then td.rowno when m.reftype='V' then hd.rowno else 0 end as refrowno,rm.ctrno,rm.dtrno,(select acno from gl_taxmaster where per!=0 and now() between fromdate and todate and type=2) taxacno,case when m.reftype='T' then (select acno from my_account where codeno='TOUR REFUND') when m.reftype='A' then (select acno from my_account where codeno='AIR TICKET REFUND') when m.reftype='V' then (select acno from my_account where codeno='HOTEL REFUND') else 0 end as accdocno,round(coalesce(sr.totalsp,0),2) srvalue, if(coalesce(rm.sinclusive,0)=1,true,false) sinclusive, coalesce(rm.svalue,0) svalue, coalesce(rm.svat,0) svat, coalesce(rm.stotal,0) stotal, round((coalesce(sr.adultnew,0)*coalesce(sr.adultval,0))+(coalesce(sr.childnew,0)*coalesce(sr.childval,0)),2) prvalue, if(coalesce(rm.pinclusive,0)=1,true,false) pinclusive, coalesce(rm.pvalue,0) pvalue,coalesce(rm.pvat,0) pvat, coalesce(rm.ptotal,0) ptotal, if(coalesce(rm.pstock,0)=1,true,false) pstock,rm.rowno,case when m.reftype='T' then 'Travel Desk' when m.reftype='A' then 'Air Ticket' when m.reftype='V' then 'Voucher' else '' end as dtype,case when m.reftype='T' then coalesce(ac3.refname,'') when m.reftype='A' then coalesce(ac1.refname,'') when m.reftype='V' then coalesce(ac2.refname,'') else '' end as vendor,case when m.reftype='T' then concat(date_format(sr.date,'%d.%m.%Y'),' - ',coalesce(ts.name,''),' - ','Adult- ',round(sr.adult,0),' - ','Child- ',round(sr.child,0),' - ','Infant- ',round(sr.infant,0)) when m.reftype='A' then concat(date_format(td.issuedate,'%d.%m.%Y'),' - ',coalesce(td.ticketno,''),' - ',coalesce(td.guest,'')) when m.reftype='V' then concat(date_format(hd.issuedate,'%d.%m.%Y'),' - ',coalesce(hd.suppconfno,''),' - ',coalesce(h.name,''),' - ',coalesce(hd.roomtype,'')) else '' end as remarks from tr_refundrequestm m left join tr_refundmanagement rm on rm.rrdocno=m.doc_no left join tr_srtour sr on (m.doc_no=sr.rrdocno and m.reftype='T' and sr.refund=1)  left join ti_ticketvoucherd td on (m.doc_no=td.rrdocno and m.reftype='A' and td.refund=1)  left join ti_hotelvoucherd hd on (m.doc_no=hd.rrdocno and m.reftype='V' and hd.refund=1) left join my_acbook ac1 on (ac1.cldocno=td.vnddocno and ac1.dtype='vnd') left join my_acbook ac2 on (ac2.cldocno=hd.vnddocno and ac2.dtype='vnd') left join my_acbook ac3 on (ac3.cldocno=sr.vendorid and ac3.dtype='vnd') left join tr_tours ts on ts.doc_no=sr.tourid left join tr_hotel h on h.doc_no=hd.hotelid  where m.doc_no='"+docno+"' "+sqltest+"";
			}else{
				strsql="select date_format(rm.expdate,'%d.%m.%Y') expdate,round(coalesce(sr.totalsp,0),2) sprice,round((coalesce(sr.adultnew,0)*coalesce(sr.adultval,0))+(coalesce(sr.childnew,0)*coalesce(sr.childval,0)),2) stdtotal,case when m.reftype='T' then sr.rowno when m.reftype='A' then td.rowno when m.reftype='V' then hd.rowno else 0 end as refrowno,rm.ctrno,rm.dtrno,(select acno from gl_taxmaster where per!=0 and now() between fromdate and todate and type=2) taxacno,case when m.reftype='T' then (select acno from my_account where codeno='TOUR REFUND') when m.reftype='A' then (select acno from my_account where codeno='AIR TICKET REFUND') when m.reftype='V' then (select acno from my_account where codeno='HOTEL REFUND') else 0 end as accdocno,coalesce(rm.srvalue,0) srvalue, if(coalesce(rm.sinclusive,0)=1,true,false) sinclusive, coalesce(rm.svalue,0) svalue, coalesce(rm.svat,0) svat, coalesce(rm.stotal,0) stotal, coalesce(rm.prvalue,0) prvalue, if(coalesce(rm.pinclusive,0)=1,true,false) pinclusive, coalesce(rm.pvalue,0) pvalue,coalesce(rm.pvat,0) pvat, coalesce(rm.ptotal,0) ptotal, if(coalesce(rm.pstock,0)=1,true,false) pstock,rm.rowno,case when m.reftype='T' then 'Travel Desk' when m.reftype='A' then 'Air Ticket' when m.reftype='V' then 'Voucher' else '' end as dtype,case when m.reftype='T' then coalesce(ac3.refname,'') when m.reftype='A' then coalesce(ac1.refname,'') when m.reftype='V' then coalesce(ac2.refname,'') else '' end as vendor,case when m.reftype='T' then concat(date_format(sr.date,'%d.%m.%Y'),' - ',coalesce(ts.name,''),' - ','Adult- ',round(sr.adult,0),' - ','Child- ',round(sr.child,0),' - ','Infant- ',round(sr.infant,0)) when m.reftype='A' then concat(date_format(td.issuedate,'%d.%m.%Y'),' - ',coalesce(td.ticketno,''),' - ',coalesce(td.guest,'')) when m.reftype='V' then concat(date_format(hd.issuedate,'%d.%m.%Y'),' - ',coalesce(hd.suppconfno,''),' - ',coalesce(h.name,''),' - ',coalesce(hd.roomtype,'')) else '' end as remarks from tr_refundrequestm m left join tr_refundmanagement rm on rm.rrdocno=m.doc_no left join tr_srtour sr on (rm.refrowno=sr.rowno and rm.doc_type='Travel Desk')  left join ti_ticketvoucherd td on (rm.refrowno=td.rowno and rm.doc_type='Air Ticket')  left join ti_hotelvoucherd hd on (rm.refrowno=hd.rowno and rm.doc_type='Voucher') left join my_acbook ac1 on (ac1.cldocno=td.vnddocno and ac1.dtype='vnd') left join my_acbook ac2 on (ac2.cldocno=hd.vnddocno and ac2.dtype='vnd') left join my_acbook ac3 on (ac3.cldocno=sr.vendorid and ac3.dtype='vnd') left join tr_tours ts on ts.doc_no=sr.tourid left join tr_hotel h on h.doc_no=hd.hotelid  where m.doc_no='"+docno+"'";
			}
			//System.out.println("sub Grid--->>>"+strsql);                                    
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs); 
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


