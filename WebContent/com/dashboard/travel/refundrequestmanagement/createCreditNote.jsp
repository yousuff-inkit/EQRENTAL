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
<%@page import="com.finance.transactions.taxcrdtnote.ClsTaxCreditNoteDAO" %>       
<%@page import="com.ibm.icu.text.SimpleDateFormat" %>        
<%	
ClsConnection ClsConnection=new ClsConnection();  
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;
    
	try{                                                          
	 	conn = ClsConnection.getMyConnection();           
		Statement stmt = conn.createStatement();    
		conn.setAutoCommit(false); 
		String brhid=request.getParameter("brhid")=="" || request.getParameter("brhid")==null?"0":request.getParameter("brhid");
		String reftype=request.getParameter("reftype")==null?"":request.getParameter("reftype"); 
		String updatearray=request.getParameter("updatearray")==null?"":request.getParameter("updatearray"); 
		String docnos=request.getParameter("rowarray")==null?"":request.getParameter("rowarray"); 
		String gridarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray"); 
		//System.out.println("rowarray--->>>"+docnos);   
		//System.out.println("gridarray--->>>"+gridarray);  
		String sql="",sqlsub="",sql1="",sql2="",sql3="",typez="",accno="0",description="";  
		int clacno=0,trnno=0,val1=0,dat=0;          
		Double amount=0.0;   
		String tourname="",tourtaxtype="",date="",remarks="",vendorid="",rowno="";  
		ClsTaxCreditNoteDAO DAO=new ClsTaxCreditNoteDAO(); 
		session.setAttribute("BRANCHID",brhid); 
			 String name="",mob="",email="";
			 int salid=0,telesales=0,vndid=0;
			 String vndacno="",accname="",rowsno="";
			 String t1="0",t2="0";  
			 SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");              
			 java.util.Date curDate=new java.util.Date();
		     java.sql.Date cdate=ClsCommon.changeStringtoSqlDate(formatter.format(curDate));
			 String strcountdata="";
			 ResultSet rs=null;
			 ArrayList<String> newarray=new ArrayList();  
			 ArrayList<String> uparray=new ArrayList();	
				String temparray[]=gridarray.split(",");
				for(int i=0;i<temparray.length;i++){
					newarray.add(temparray[i]);
				}
				String tempuparray[]=updatearray.split(",");  
				for(int i=0;i<tempuparray.length;i++){
					uparray.add(tempuparray[i]);   
				}
				for(int i=0;i<uparray.size();i++){      
					String temp[]=uparray.get(i).split("::");
					if(!temp[5].trim().equalsIgnoreCase("undefined") && !temp[5].trim().equalsIgnoreCase("NaN") && !temp[5].trim().equalsIgnoreCase("")){
						int rmrowno= temp[5].trim().equalsIgnoreCase("undefined") || temp[5].trim().equalsIgnoreCase("NaN") || temp[5].trim().equalsIgnoreCase("") || temp[5].trim().isEmpty()?0:Integer.parseInt(temp[5].trim().toString());
						String srvalue = (temp[0].trim().equalsIgnoreCase("undefined") || temp[0].trim().equalsIgnoreCase("NaN") || temp[0].trim().equalsIgnoreCase("") || temp[0].trim().isEmpty()?"0.0":temp[0].trim()).toString();
						String sinclusive = temp[1].trim().equalsIgnoreCase("undefined") || temp[1].trim().equalsIgnoreCase("NaN") || temp[1].trim().equalsIgnoreCase("") || temp[1].trim().isEmpty()?"0":temp[1].trim().toString(); 
						String svalue = (temp[2].trim().equalsIgnoreCase("undefined") || temp[2].trim().equalsIgnoreCase("NaN") || temp[2].trim().equalsIgnoreCase("") || temp[2].trim().isEmpty()?"0.0":temp[2].trim()).toString();
						String svat = (temp[3].trim().equalsIgnoreCase("undefined") || temp[3].trim().equalsIgnoreCase("NaN") || temp[3].trim().equalsIgnoreCase("") || temp[3].trim().isEmpty()?"0.0":temp[3].trim()).toString();
						String stotal = (temp[4].trim().equalsIgnoreCase("undefined") || temp[4].trim().equalsIgnoreCase("NaN") || temp[4].trim().equalsIgnoreCase("") || temp[4].trim().isEmpty()?"0.0":temp[4].trim()).toString();
					  
						String sqlup="update tr_refundmanagement set srvalue="+Double.parseDouble(srvalue)+",svalue="+Double.parseDouble(svalue)+",svat="+Double.parseDouble(svat)+",stotal="+Double.parseDouble(stotal)+",sinclusive='"+sinclusive+"' where rowno="+rmrowno+"";   
						int valtest=stmt.executeUpdate(sqlup);  
					}     
				}
				
			 strcountdata="select concat(rm.dtype,' - ',rm.voc_no) description,case when m.doc_type='Travel Desk' then if(ac1.acno is null,(select coalesce(acno,0) from my_account where codeno='CASHACSALES'),coalesce(ac1.acno,0)) when m.doc_type='Air Ticket' then coalesce(ac2.acno,0) when m.doc_type='Voucher' then coalesce(ac3.acno,0) else 0 end as clacno,sum(coalesce(m.stotal,0)) amount from tr_refundmanagement m left join tr_refundrequestm rm on rm.doc_no=m.rrdocno left join tr_srtour sr on (m.rrdocno=sr.rrdocno and m.doc_type='Travel Desk' and sr.refund=1) left join tr_servicereqm srm on srm.doc_no=sr.rdocno left join ti_ticketvoucherd td on (m.rrdocno=td.rrdocno and m.doc_type='Air Ticket' and td.refund=1)  left join ti_hotelvoucherd hd on (m.rrdocno=hd.rrdocno and m.doc_type='Voucher' and hd.refund=1) left join my_acbook ac1 on (ac1.cldocno=srm.cldocno and ac1.dtype='crm') left join my_acbook ac2 on (ac2.cldocno=td.cldocno and ac2.dtype='crm') left join my_acbook ac3 on (ac3.cldocno=hd.cldocno and ac3.dtype='crm') where m.rowno in("+docnos+") group by m.rrdocno";
			 //System.out.println("strcountdata--->>>"+strcountdata);                                                 
			 rs=stmt.executeQuery(strcountdata);                            
			 while(rs.next()){                                                     
				clacno=rs.getInt("clacno");      
				description=rs.getString("description");        
			 } 
			 String sqlremarks="select a.rrdocno,sum(total) amount,case when a.doc_type='Travel Desk' then concat(convert(group_concat(a.tourdate),char(200)),' - ',convert(group_concat(a.tourname),char(200)),' - ','Adult- ',convert(group_concat(a.adult),char(200)),' - ','Child- ',convert(group_concat(a.child),char(200)),' - ','Infant- ',convert(group_concat(a.infant),char(200))) when a.doc_type='Air Ticket' then concat(convert(group_concat(a.ticketdate),char(200)),' - ',convert(group_concat(a.ticketno),char(200)),' - ',convert(group_concat(a.ticketguest),char(200))) when a.doc_type='Voucher' then concat(convert(group_concat(a.hoteldate),char(200)),' - ',convert(group_concat(a.suppconfno),char(200)),' - ',convert(group_concat(a.hotelname),char(200)),' - ',convert(group_concat(a.roomtype),char(200))) else '' end as remarks from (select date_format(sr.date,'%d.%m.%Y') tourdate,coalesce(ts.name,'') tourname,round(sr.adult,0) adult,round(sr.child,0) child,round(sr.infant,0) infant,date_format(td.issuedate,'%d.%m.%Y') ticketdate,coalesce(td.ticketno,'') ticketno,coalesce(td.guest,'') ticketguest,date_format(hd.issuedate,'%d.%m.%Y') hoteldate,coalesce(hd.suppconfno,'') suppconfno,coalesce(h.name,'') hotelname,coalesce(hd.roomtype,'') roomtype,rm.doc_type,coalesce(rm.stotal,0) total,rm.rrdocno from tr_refundmanagement rm  left join tr_srtour sr on (rm.refrowno=sr.rowno and rm.doc_type='Travel Desk')  left join ti_ticketvoucherd td on (rm.refrowno=td.rowno and rm.doc_type='Air Ticket')  left join ti_hotelvoucherd hd on (rm.refrowno=hd.rowno and rm.doc_type='Voucher') left join my_acbook ac1 on (ac1.cldocno=td.vnddocno and ac1.dtype='vnd') left join my_acbook ac2 on (ac2.cldocno=hd.vnddocno and ac2.dtype='vnd') left join my_acbook ac3 on (ac3.cldocno=sr.vendorid and ac3.dtype='vnd') left join tr_tours ts on ts.doc_no=sr.tourid left join tr_hotel h on h.doc_no=hd.hotelid  where rm.rowno in("+docnos+")) a group by a.rrdocno";
			 System.out.println("sqlremarks--->>>"+sqlremarks);                                                        
			 ResultSet rsremarks=stmt.executeQuery(sqlremarks);                            
			 while(rsremarks.next()){                                                     
				 description=description+" - "+rsremarks.getString("remarks");     
				 amount=rsremarks.getDouble("amount");  
			 } 
			dat=DAO.insert(conn,cdate,"TCN","",1.0,description,clacno,"1",amount,amount,"",0,newarray,session,request,"A");            
			trnno=Integer.parseInt(request.getAttribute("tranno").toString());     
			if(dat>0){
					String strupdate="update tr_refundmanagement set ctrno="+trnno+" where rowno in("+docnos+")";                 
					//System.out.println("strupdate--->>>"+strupdate);    
					val1=stmt.executeUpdate(strupdate);   
			} 
			response.getWriter().print(val1+"###"+dat);                                                      
 	stmt.close();
 	conn.commit();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();  
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
