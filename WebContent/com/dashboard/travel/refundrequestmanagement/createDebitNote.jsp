<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>   
<%@page import="com.finance.transactions.taxdbtnote.ClsTaxDebitNoteDAO" %>         
<%@page import="com.ibm.icu.text.SimpleDateFormat" %>           
<%	
ClsConnection ClsConnection=new ClsConnection();  
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;
    
	try{                                                          
	 	conn = ClsConnection.getMyConnection();            
		Statement stmt = conn.createStatement(); 
		CallableStatement stmt3=null;
		//conn.setAutoCommit(false); 
	    String brhid=request.getParameter("brhid")=="" || request.getParameter("brhid")==null?"0":request.getParameter("brhid");
		String refdocno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno");  
		String reftype=request.getParameter("reftype")==null?"":request.getParameter("reftype");  
		String updatearray=request.getParameter("updatearray")==null?"":request.getParameter("updatearray");
		String rownoarray1=request.getParameter("rownoarray1")==null?"":request.getParameter("rownoarray1"); 
		String rownoarray2=request.getParameter("rownoarray2")==null?"":request.getParameter("rownoarray2");            
		String mainarray1=request.getParameter("mainarray1"); 
		String mainarray2=request.getParameter("mainarray2");   
		System.out.println("updatearray===="+updatearray);   
		String sql="",sqlsub="",sql1="",sql2="",sql3="",typez="",accno="0",description="",dbtvocno="";     
		int vndacno=0,trnno=0,val1=0,dat=0;            
		Double amount=0.0;   
		String tourname="",tourtaxtype="",date="",remarks="",vendorid="",rowno="";         
		ClsTaxDebitNoteDAO DAO=new ClsTaxDebitNoteDAO();
		session.setAttribute("BRANCHID",brhid); 
			 String name="",mob="",email="";
			 int salid=0,telesales=0,vndid=0;
			 String accname="",rowsno="";
			 String t1="0",t2="0";  
			 SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");              
			 java.util.Date curDate=new java.util.Date();
		     java.sql.Date cdate=ClsCommon.changeStringtoSqlDate(formatter.format(curDate));
			 ResultSet rs=null;
			 ArrayList<String> newarray1=new ArrayList();    
			 ArrayList<String> newarray2=new ArrayList(); 
			 ArrayList<String> uparray=new ArrayList();
				String temparray1[]=mainarray1.split(",");        
				for(int i=0;i<temparray1.length;i++){
					newarray1.add(temparray1[i]);
				}
				String temparray2[]=mainarray2.split(",");   
				for(int i=0;i<temparray2.length;i++){
					newarray2.add(temparray2[i]);
				}
				String tempuparray[]=updatearray.split(",");  
				for(int i=0;i<tempuparray.length;i++){
					uparray.add(tempuparray[i]);   
				}
				for(int i=0;i<uparray.size();i++){    
					String temp[]=uparray.get(i).split("::");   
					if(!temp[5].trim().equalsIgnoreCase("undefined") && !temp[5].trim().equalsIgnoreCase("NaN") && !temp[5].trim().equalsIgnoreCase("")){
						int rmrowno= temp[5].trim().equalsIgnoreCase("undefined") || temp[5].trim().equalsIgnoreCase("NaN") || temp[5].trim().equalsIgnoreCase("") || temp[5].trim().isEmpty()?0:Integer.parseInt(temp[5].trim().toString());
						String prvalue = (temp[0].trim().equalsIgnoreCase("undefined") || temp[0].trim().equalsIgnoreCase("NaN") || temp[0].trim().equalsIgnoreCase("") || temp[0].trim().isEmpty()?"0.0":temp[0].trim()).toString();
						String pinclusive = temp[1].trim().equalsIgnoreCase("undefined") || temp[1].trim().equalsIgnoreCase("NaN") || temp[1].trim().equalsIgnoreCase("") || temp[1].trim().isEmpty()?"0":temp[1].trim().toString(); 
						String pvalue = (temp[2].trim().equalsIgnoreCase("undefined") || temp[2].trim().equalsIgnoreCase("NaN") || temp[2].trim().equalsIgnoreCase("") || temp[2].trim().isEmpty()?"0.0":temp[2].trim()).toString();
						String pvat = (temp[3].trim().equalsIgnoreCase("undefined") || temp[3].trim().equalsIgnoreCase("NaN") || temp[3].trim().equalsIgnoreCase("") || temp[3].trim().isEmpty()?"0.0":temp[3].trim()).toString();
						String ptotal = (temp[4].trim().equalsIgnoreCase("undefined") || temp[4].trim().equalsIgnoreCase("NaN") || temp[4].trim().equalsIgnoreCase("") || temp[4].trim().isEmpty()?"0.0":temp[4].trim()).toString();
						String pstock = temp[6].trim().equalsIgnoreCase("undefined") || temp[6].trim().equalsIgnoreCase("NaN") || temp[6].trim().equalsIgnoreCase("") || temp[6].trim().isEmpty()?"0":temp[6].trim().toString();
						java.sql.Date expdt=(temp[7].trim().equalsIgnoreCase("undefined") || temp[7].trim().equalsIgnoreCase("NaN")|| temp[7].trim().equalsIgnoreCase("")|| temp[7].isEmpty()?null:ClsCommon.changetstmptoSqlDate(temp[7].trim()));     
						
						stmt3 = conn.prepareCall("update tr_refundmanagement set prvalue=?,pvalue=?,pvat=?,ptotal=?,pinclusive=?,pstock=?,expdate=? where rowno=?");    
						stmt3.setDouble(1,Double.parseDouble(prvalue));    
						stmt3.setDouble(2,Double.parseDouble(pvalue));
						stmt3.setDouble(3,Double.parseDouble(pvat));
						stmt3.setDouble(4,Double.parseDouble(ptotal));
						stmt3.setInt(5,Integer.parseInt(pinclusive));
						stmt3.setInt(6,Integer.parseInt(pstock));
						stmt3.setDate(7,expdt);        
						stmt3.setInt(8,rmrowno);      
						//System.out.println("stmt3"+stmt3);                                        
						int val = stmt3.executeUpdate();    
					}     
				}	  
			 if(reftype.equalsIgnoreCase("Travel Desk")){            
				     String tempnew2[]=newarray2.get(0).split("::");         
					 if(!tempnew2[0].trim().equalsIgnoreCase("undefined") && !tempnew2[0].trim().equalsIgnoreCase("NaN") && !tempnew2[0].trim().equalsIgnoreCase("")){
						 String strcountdata="select concat(rm.dtype,' - ',rm.voc_no) description,(select coalesce(acno,0) acno from my_account where codeno='Stock Vendor') vndacno,sum(coalesce(m.ptotal,0)) amount from tr_refundmanagement m left join tr_refundrequestm rm on rm.doc_no=m.rrdocno where m.rowno in("+rownoarray2+") group by m.rrdocno";
						 //System.out.println("strcountdata--->>>"+strcountdata);                                                    
						 rs=stmt.executeQuery(strcountdata);                            
						 while(rs.next()){                                                     
							 vndacno=rs.getInt("vndacno");          
							 description=rs.getString("description");    
						 } 
						 String sqlremarks="select a.rrdocno,sum(total) amount,case when a.doc_type='Travel Desk' then concat(convert(group_concat(a.tourdate),char(200)),' - ',convert(group_concat(a.tourname),char(200)),' - ','Adult- ',convert(group_concat(a.adult),char(200)),' - ','Child- ',convert(group_concat(a.child),char(200)),' - ','Infant- ',convert(group_concat(a.infant),char(200))) when a.doc_type='Air Ticket' then concat(convert(group_concat(a.ticketdate),char(200)),' - ',convert(group_concat(a.ticketno),char(200)),' - ',convert(group_concat(a.ticketguest),char(200))) when a.doc_type='Voucher' then concat(convert(group_concat(a.hoteldate),char(200)),' - ',convert(group_concat(a.suppconfno),char(200)),' - ',convert(group_concat(a.hotelname),char(200)),' - ',convert(group_concat(a.roomtype),char(200))) else '' end as remarks from (select date_format(sr.date,'%d.%m.%Y') tourdate,coalesce(ts.name,'') tourname,round(sr.adult,0) adult,round(sr.child,0) child,round(sr.infant,0) infant,date_format(td.issuedate,'%d.%m.%Y') ticketdate,coalesce(td.ticketno,'') ticketno,coalesce(td.guest,'') ticketguest,date_format(hd.issuedate,'%d.%m.%Y') hoteldate,coalesce(hd.suppconfno,'') suppconfno,coalesce(h.name,'') hotelname,coalesce(hd.roomtype,'') roomtype,rm.doc_type,coalesce(rm.ptotal,0) total,rm.rrdocno from tr_refundmanagement rm left join tr_srtour sr on (rm.refrowno=sr.rowno and rm.doc_type='Travel Desk')  left join ti_ticketvoucherd td on (rm.refrowno=td.rowno and rm.doc_type='Air Ticket')  left join ti_hotelvoucherd hd on (rm.refrowno=hd.rowno and rm.doc_type='Voucher') left join my_acbook ac1 on (ac1.cldocno=td.vnddocno and ac1.dtype='vnd') left join my_acbook ac2 on (ac2.cldocno=hd.vnddocno and ac2.dtype='vnd') left join my_acbook ac3 on (ac3.cldocno=sr.vendorid and ac3.dtype='vnd') left join tr_tours ts on ts.doc_no=sr.tourid left join tr_hotel h on h.doc_no=hd.hotelid  where rm.rowno in("+rownoarray2+")) a group by a.rrdocno";
						 //System.out.println("sqlremarks--->>>"+sqlremarks);                                                      
						 ResultSet rsremarks=stmt.executeQuery(sqlremarks);                            
						 while(rsremarks.next()){                                                     
							 description=description+" - "+rsremarks.getString("remarks"); 
							 amount=rsremarks.getDouble("amount");  
						 } 
						dat=DAO.insert(cdate,"TDN","",1.0,description,vndacno,"1",amount,amount,"",0,newarray2,session,request,"A");                    
						trnno=Integer.parseInt(request.getAttribute("tranno").toString());                
						if(dat>0){
								String strupdate="update tr_refundmanagement set dtrno="+trnno+" where rowno in("+rownoarray2+")";                   
								//System.out.println("strupdate--->>>"+strupdate);      
								val1=stmt.executeUpdate(strupdate);
								
								String sqlupdate="INSERT INTO tr_tourstock(sr_no, tourid, vendorid, refdocno, date, adult, child, locid, brhid, cost_price, sellingprice,refrowno, rfrdocno, cpadult, cpchild, spadult, spchild, expdate) select @i:=@i+1 srno, a.tourid,a.vendorid,a.rdocno,a.date,a.adultnew,a.childnew,a.locid,a.brhid,a.costprice,a.sellingprice,a.refrowno,a.rfrdocno,a.adultval,a.childval, a.spadult, a.spchild, a.expdate from(select sr.tourid,sr.vendorid,sr.rdocno,sr.date,sr.adultnew,sr.childnew,req.locid,req.brhid,(sr.adultnew*sr.adultval)+(sr.childnew*sr.childval) costprice,sr.totalsp sellingprice,sr.rowno refrowno,rm.rrdocno rfrdocno,sr.adultval,sr.childval, sr.spadult, sr.spchild,rm.expdate  from tr_refundmanagement rm left join tr_srtour sr on (rm.refrowno=sr.rowno and rm.doc_type='Travel Desk') left join tr_servicereqm req on req.doc_no=sr.rdocno  where rm.doc_type='Travel Desk' and rm.rowno in("+rownoarray2+")) a,(select @i:=0)c";                   
								//System.out.println("sqlupdate--->>>"+sqlupdate);      
								val1=stmt.executeUpdate(sqlupdate);      
						}
						if(val1>0){    
							String sqlupdate2="update tr_tourstock tr set refstockid=tr.stockid,userid='"+session.getAttribute("USERID").toString()+"' where tr.rfrdocno='"+refdocno+"'";                   
							//System.out.println("sqlupdate2--->>>"+sqlupdate2);         
							val1=stmt.executeUpdate(sqlupdate2);     
						}
					}
			 }
			 description="";vndacno=0;amount=0.0; 
			 dbtvocno=dat+"";
			 dat=0;  
			 if(!newarray1.isEmpty()){
				     String tempnew1[]=newarray1.get(0).split("::");       
					 if(!tempnew1[0].trim().equalsIgnoreCase("undefined") && !tempnew1[0].trim().equalsIgnoreCase("NaN") && !tempnew1[0].trim().equalsIgnoreCase("")){
					     String strcountdata="select concat(rm.dtype,' - ',rm.voc_no) description,case when m.doc_type='Travel Desk' then if(ac1.acno is null,(select coalesce(acno,0) from my_account where codeno='CASHACSALES'),coalesce(ac1.acno,0)) when m.doc_type='Air Ticket' then coalesce(ac2.acno,0) when m.doc_type='Voucher' then coalesce(ac3.acno,0) else 0 end as vndacno,sum(coalesce(m.ptotal,0)) amount from tr_refundmanagement m left join tr_refundrequestm rm on rm.doc_no=m.rrdocno left join tr_srtour sr on (m.rrdocno=sr.rrdocno and m.doc_type='Travel Desk' and sr.refund=1) left join ti_ticketvoucherd td on (m.rrdocno=td.rrdocno and m.doc_type='Air Ticket' and td.refund=1)  left join ti_hotelvoucherd hd on (m.rrdocno=hd.rrdocno and m.doc_type='Voucher' and hd.refund=1) left join my_acbook ac1 on (ac1.cldocno=sr.vendorid and ac1.dtype='vnd') left join my_acbook ac2 on (ac2.cldocno=td.vnddocno and ac2.dtype='vnd') left join my_acbook ac3 on (ac3.cldocno=hd.vnddocno and ac3.dtype='vnd') where m.rowno in("+rownoarray1+") group by m.rrdocno";
						 //System.out.println("strcountdata--->>>"+strcountdata);                                                 
						 rs=stmt.executeQuery(strcountdata);                              
						 while(rs.next()){                                                     
							 vndacno=rs.getInt("vndacno");        
							 description=rs.getString("description");       
						 } 
						 String sqlremarks="select a.rrdocno,sum(total) amount,case when a.doc_type='Travel Desk' then concat(convert(group_concat(a.tourdate),char(200)),' - ',convert(group_concat(a.tourname),char(200)),' - ','Adult- ',convert(group_concat(a.adult),char(200)),' - ','Child- ',convert(group_concat(a.child),char(200)),' - ','Infant- ',convert(group_concat(a.infant),char(200))) when a.doc_type='Air Ticket' then concat(convert(group_concat(a.ticketdate),char(200)),' - ',convert(group_concat(a.ticketno),char(200)),' - ',convert(group_concat(a.ticketguest),char(200))) when a.doc_type='Voucher' then concat(convert(group_concat(a.hoteldate),char(200)),' - ',convert(group_concat(a.suppconfno),char(200)),' - ',convert(group_concat(a.hotelname),char(200)),' - ',convert(group_concat(a.roomtype),char(200))) else '' end as remarks from (select date_format(sr.date,'%d.%m.%Y') tourdate,coalesce(ts.name,'') tourname,round(sr.adult,0) adult,round(sr.child,0) child,round(sr.infant,0) infant,date_format(td.issuedate,'%d.%m.%Y') ticketdate,coalesce(td.ticketno,'') ticketno,coalesce(td.guest,'') ticketguest,date_format(hd.issuedate,'%d.%m.%Y') hoteldate,coalesce(hd.suppconfno,'') suppconfno,coalesce(h.name,'') hotelname,coalesce(hd.roomtype,'') roomtype,rm.doc_type,coalesce(rm.ptotal,0) total,rm.rrdocno from tr_refundmanagement rm left join tr_srtour sr on (rm.refrowno=sr.rowno and rm.doc_type='Travel Desk')  left join ti_ticketvoucherd td on (rm.refrowno=td.rowno and rm.doc_type='Air Ticket')  left join ti_hotelvoucherd hd on (rm.refrowno=hd.rowno and rm.doc_type='Voucher') left join my_acbook ac1 on (ac1.cldocno=td.vnddocno and ac1.dtype='vnd') left join my_acbook ac2 on (ac2.cldocno=hd.vnddocno and ac2.dtype='vnd') left join my_acbook ac3 on (ac3.cldocno=sr.vendorid and ac3.dtype='vnd') left join tr_tours ts on ts.doc_no=sr.tourid left join tr_hotel h on h.doc_no=hd.hotelid  where rm.rowno in("+rownoarray1+")) a group by a.rrdocno";
						 //System.out.println("sqlremarks--->>>"+sqlremarks);                                                      
						 ResultSet rsremarks=stmt.executeQuery(sqlremarks);                            
						 while(rsremarks.next()){                                                       
							 description=description+" - "+rsremarks.getString("remarks");   
							 amount=rsremarks.getDouble("amount");  
						 } 
						dat=DAO.insert(cdate,"TDN","",1.0,description,vndacno,"1",amount,amount,"",0,newarray1,session,request,"A");                    
						trnno=Integer.parseInt(request.getAttribute("tranno").toString());                
						if(dat>0){
								String strupdate="update tr_refundmanagement set dtrno="+trnno+" where rowno in("+rownoarray1+")";                   
								//System.out.println("strupdate--->>>"+strupdate);      
								val1=stmt.executeUpdate(strupdate);   
						}
					}  
			 }
			 if(dat>0){
				 dbtvocno=dbtvocno+","+dat;     
			 }
			response.getWriter().print(val1+"###"+dbtvocno);                                                           
 	stmt.close();
 	//conn.commit();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();  
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
