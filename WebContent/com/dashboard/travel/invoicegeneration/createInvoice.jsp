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
<%@page import="com.operations.commtransactions.travelinvoice.ClsTravelInvoiceDAO"%>   
<%@page import="com.common.ClsVatInsert"%>          
<%@page import="com.ibm.icu.text.SimpleDateFormat" %>  
<%	
	ClsConnection connDAO=new ClsConnection();       
	ClsCommon commonDAO=new ClsCommon();        
	ClsTravelInvoiceDAO DAO= new ClsTravelInvoiceDAO();
	Connection conn = null;
	java.sql.Date sqlStartDate=null;   
	SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");       
	java.util.Date curDate=new java.util.Date();  
    java.sql.Date cdate=commonDAO.changeStringtoSqlDate(formatter.format(curDate));                     
	java.sql.Date sqlStartDate2=null;                                                   
	String brhid=request.getParameter("brhid")=="" || request.getParameter("brhid")==null?"0":request.getParameter("brhid");
	String type=request.getParameter("type")=="" || request.getParameter("type")==null?"0":request.getParameter("type");
	String postdate=request.getParameter("postdate")=="" || request.getParameter("postdate")==null?"0":request.getParameter("postdate");  
	String docnos=request.getParameter("rowno")==null || request.getParameter("rowno").trim().equalsIgnoreCase("")?"0":request.getParameter("rowno").toString();
	docnos=docnos+"0";                            
	Double taxamt=0.0,clamount=0.0,per=0.0;   
	String seracno="0",visaseracno="0",otherseracno="0",refno="0",sql=null,sqlss=null,sqlsss="",sqlss2="",strcountdata="",straccdata="",cldocno="0",desc="",remarks="",refname="",cusacno="0",ticketseracno="0",taxacno="0",hotelseracno="0";          
    int val=0,temp=0,trnosss=0,val3=0,id=1,jvtranno=0,result=0;             
    //ResultSet rs2=null;
	try{      
	 	conn=connDAO.getMyConnection();
		Statement stmt=conn.createStatement();          
		conn.setAutoCommit(false);             
		 if(!(postdate.equalsIgnoreCase("undefined")) && !(postdate.equalsIgnoreCase("")) && !(postdate.equalsIgnoreCase("0")))    
	     {
	  	    sqlStartDate = commonDAO.changeStringtoSqlDate(postdate);           
	     } 	
		//System.out.println("---1"); 
		ArrayList<String> gridarray=new ArrayList<String>();                  
		        straccdata="select (select coalesce(acno,0) acno from my_account where codeno='OTHER ACT INCOME') otherseracno,(select coalesce(acno,0) acno from my_account where codeno='VISA INCOME') visaseracno,(select coalesce(acno,0) acno from my_account where codeno='HOTEL INCOME') hotelseracno,(select coalesce(acno,0) acno from my_account where codeno='AIR TICKET INCOME') ticketseracno,(select acno from gl_taxmaster where per!=0 and '"+sqlStartDate+"' between fromdate and todate and type=2) taxacno,(select coalesce(per) per from gl_taxmaster where per!=0 and '"+sqlStartDate+"' between fromdate and todate and type=2) per";
				System.out.println("straccdata--->>>"+straccdata);             
				ResultSet rs=stmt.executeQuery(straccdata);                              
				while(rs.next()){  
					otherseracno=rs.getString("otherseracno"); 
					visaseracno=rs.getString("visaseracno");      
					hotelseracno=rs.getString("hotelseracno"); 
					ticketseracno=rs.getString("ticketseracno");                   
					taxacno=rs.getString("taxacno");       
					//per=rs.getDouble("per");                                            
				}  
				 String remsql="";    
				    ResultSet remrs=null;  
				    if(type.equalsIgnoreCase("ticket")){
					    remsql="select SUBSTRING(group_concat(concat('Ticket -',m.voc_no,',  ',d.ticketno,',  ',d.guest,',  ',d.sector)), 1, 400) remarks from ti_ticketvoucherd d left join ti_ticketvoucherm m on m.doc_no=d.rdocno where rowno in("+docnos+")"; 	
						System.out.println("remsql--->>>"+remsql);                                      
					    remrs=stmt.executeQuery(remsql);   
					    while(remrs.next()){      
					    	remarks=remrs.getString("remarks");  
					     }
				    }else{
				    	remsql="select SUBSTRING(group_concat(concat('Voucher -',m.voc_no,',  ',d.suppconfno,',  ',d.guest)), 1, 400) remarks from ti_hotelvoucherd d left join ti_hotelvoucherm m on m.doc_no=d.rdocno where rowno in("+docnos+")";   	
						System.out.println("remsql--->>>"+remsql);                                          
					    remrs=stmt.executeQuery(remsql);   
					    while(remrs.next()){      
					    	remarks=remrs.getString("remarks");       
					     }	
				    }
				    desc=remarks;
				//System.out.println("---2");		
				if(type.equalsIgnoreCase("ticket")){         
					strcountdata="select m.voc_no refno, coalesce(d.taxamt,0) taxamt, ac.cldocno,ac.refname, coalesce(ac.acno,0) clacno from ti_ticketvoucherd d left join ti_ticketvoucherm m on m.doc_no=d.rdocno left join my_acbook ac on (ac.cldocno=d.cldocno and ac.dtype='crm') where d.rowno in("+docnos+")";  
					System.out.println("strcountdata--->>>"+strcountdata);                              
					ResultSet rs2=stmt.executeQuery(strcountdata);         
				    while(rs2.next()){        
						refno+=rs2.getString("refno")+" ,";        
						cusacno=rs2.getString("clacno");
						cldocno=rs2.getString("cldocno");
						refname=rs2.getString("refname");  
						if(type.equalsIgnoreCase("ticket")){                
							taxamt=0.0;
						}else{
							taxamt+=rs2.getDouble("taxamt"); 	
						}
					}
				    String vndstr="select sum(coalesce(d.suptotal,0)) suptotal,coalesce(acc.acno,0) vndacno from ti_ticketvoucherd d left join my_acbook acc on (acc.cldocno=d.vnddocno and acc.dtype='vnd') where d.rowno  in("+docnos+") group by d.vnddocno";          
					System.out.println("vndstr--->>>"+vndstr);                                      
					ResultSet vndrs=stmt.executeQuery(vndstr);
				    while(vndrs.next()){
				    Double suptotal=0.0;
				    String vndacno="0";  
				    suptotal=vndrs.getDouble("suptotal");     
				    vndacno=vndrs.getString("vndacno");
				    if(suptotal>0){  
						id=-1;
					}else{
						id=1;
					}
					gridarray.add(vndacno+"::"+desc+"::"+1+"::"+1+"::"+suptotal*id+"::"+suptotal*id+"::"+2+"::"+1*-1+":: "+""+":: "+""+" :: ");
					clamount=clamount + suptotal;       
				    }   
				    
				    String paystr="select sum(coalesce(d.paybackamt,0)) paybackamt,coalesce(d.pdocno,0) pdocno from ti_ticketvoucherd d where d.rowno in("+docnos+") group by d.pdocno";                    
					System.out.println("paystr--->>>"+paystr);                                      
					ResultSet payrs=stmt.executeQuery(paystr);   
				    while(payrs.next()){
				    Double paybackamt=0.0;
				    String pdocno="0";  
				    paybackamt=payrs.getDouble("paybackamt");     
				    pdocno=payrs.getString("pdocno");
				    if(paybackamt>0){  
						id=-1;
					}else{                                      
						id=1;             
					}
				    if(!pdocno.equalsIgnoreCase("") && !pdocno.equalsIgnoreCase("0")){           
				    	gridarray.add(pdocno+"::"+desc+"::"+1+"::"+1+"::"+paybackamt*id+"::"+paybackamt*id+"::"+2+"::"+1*-1+":: "+""+":: "+""+" :: ");
						clamount=clamount + paybackamt;
				    }
				    }    
				    
				    String serstr="select sum(coalesce(d.servfee,0)) servfee from ti_ticketvoucherd d where d.rowno  in("+docnos+") group by d.cldocno";                       
					System.out.println("serstr--->>>"+serstr);                                                     
					ResultSet serrs=stmt.executeQuery(serstr);   
				    while(serrs.next()){
				    Double servfee=0.0;
				    servfee=serrs.getDouble("servfee");     
				    if(servfee>0){  
						id=-1;
					}else{                                      
						id=1;             
					}
					gridarray.add(ticketseracno+"::"+desc+"::"+1+"::"+1+"::"+servfee*id+"::"+servfee*id+"::"+2+"::"+1*-1+":: "+""+":: "+""+" :: ");
					clamount=clamount + servfee;   
				    }   
				}else{
					strcountdata="select m.voc_no refno, coalesce(d.taxamt,0) taxamt, ac.cldocno, ac.refname, coalesce(ac.acno,0) clacno from ti_hotelvoucherd d left join ti_hotelvoucherm m on m.doc_no=d.rdocno left join my_acbook ac on (ac.cldocno=d.cldocno and ac.dtype='crm') where d.rowno in("+docnos+")";  
					System.out.println("strcountdata--->>>"+strcountdata);                        
				    ResultSet rs3=stmt.executeQuery(strcountdata);                
				    while(rs3.next()){        
						refno+=rs3.getString("refno")+" ,";        
						cusacno=rs3.getString("clacno");
						cldocno=rs3.getString("cldocno");
						refname=rs3.getString("refname");  
					}                
				    String clientstr="select round(sum(coalesce(sprice,0)),2) sprice from ti_hotelvoucherd where rowno in("+docnos+") group by cldocno";          
					System.out.println("clientstr--->>>"+clientstr);                                          
					ResultSet clientrs=stmt.executeQuery(clientstr);  
				    while(clientrs.next()){  
				    Double clientamount=0.0;
				    clientamount=clientrs.getDouble("sprice");       
				    if(clientamount<0){   
						id=-1;
					}else{
						id=1;
					}
					  gridarray.add(cusacno+"::"+desc+"::"+1+"::"+1+"::"+clientamount*id+"::"+clientamount*id+"::"+2+"::"+1+":: "+""+":: "+""+" :: ");
				    }
				    
				    String paystr2="select round(sum(coalesce(d.paybackamt,0)),2) paybackamt,coalesce(d.pdocno,0) pdocno from ti_hotelvoucherd d where d.rowno in("+docnos+") group by d.pdocno";                    
					System.out.println("paystr2--->>>"+paystr2);                                        
					ResultSet payrs2=stmt.executeQuery(paystr2);   
				    while(payrs2.next()){
				    Double paybackamt2=0.0;
				    String pdocno2="0";  
				    paybackamt2=payrs2.getDouble("paybackamt");       
				    pdocno2=payrs2.getString("pdocno");
				    if(paybackamt2>0){  
						id=-1;
					}else{                                      
						id=1;             
					}
				    if(!pdocno2.equalsIgnoreCase("") && !pdocno2.equalsIgnoreCase("0")){    
						gridarray.add(pdocno2+"::"+desc+"::"+1+"::"+1+"::"+paybackamt2*id+"::"+paybackamt2*id+"::"+2+"::"+1*-1+":: "+""+":: "+""+" :: ");   
				    }
				    }     
				    
				    String vatpaystr="select round(sum(coalesce(clvatamt,0)),2) vatamt from ti_hotelvoucherd where rowno  in("+docnos+") group by cldocno";                    
					System.out.println("vatpaystr--->>>"+vatpaystr);                                          
					ResultSet vatpayrs=stmt.executeQuery(vatpaystr);   
				    while(vatpayrs.next()){
				    Double payvatamt=0.0;
				    payvatamt=vatpayrs.getDouble("vatamt");         
				    if(payvatamt>0){       
						id=-1;
					}else{                                      
						id=1;             
					}
						gridarray.add(taxacno+"::"+desc+"::"+1+"::"+1+"::"+payvatamt*id+"::"+payvatamt*id+"::"+2+"::"+1*-1+":: "+""+":: "+""+" :: ");   
				    } 
				    
				    String vndpaystr="select round(sum(coalesce(suptotal,0))-sum(coalesce(taxamt,0)),2) vendoramt,(select coalesce(acno,0) acno from my_account where codeno='VENDOR ACCOUNT') vatacno from ti_hotelvoucherd where rowno in("+docnos+") group by cldocno";          
					System.out.println("vndpaystr--->>>"+vndpaystr);                                                  
					ResultSet vndpayrs=stmt.executeQuery(vndpaystr);  
				    while(vndpayrs.next()){  
				    Double vendoramt=0.0;
				    String vatacno="0";  
				    vendoramt=vndpayrs.getDouble("vendoramt");       
				    vatacno=vndpayrs.getString("vatacno");
				    if(vendoramt>0){  
						id=-1;
					}else{
						id=1;   
					}
					gridarray.add(vatacno+"::"+desc+"::"+1+"::"+1+"::"+vendoramt*id+"::"+vendoramt*id+"::"+2+"::"+1*-1+":: "+""+":: "+""+" :: ");
				    }   
				    
				    String serstr2="select round((sum(coalesce(sprice,0))-sum(coalesce(clvatamt,0))-sum(coalesce(paybackamt,0)))-(sum(coalesce(suptotal,0))-sum(coalesce(taxamt,0))),2) servfee,vtype from ti_hotelvoucherd where rowno in("+docnos+") group by vtype";                            
					System.out.println("serstr2--->>>"+serstr2);                                      
					ResultSet serrs2=stmt.executeQuery(serstr2);   
				    while(serrs2.next()){  
				    Double servfee2=0.0;
				    String vtype="";
				    vtype=serrs2.getString("vtype"); 
				    servfee2=serrs2.getDouble("servfee");     
				    if(servfee2>0){  
						id=-1;
					}else{                                      
						id=1;             
					}
				    if(vtype.equalsIgnoreCase("H")){       
				    	gridarray.add(hotelseracno+"::"+desc+"::"+1+"::"+1+"::"+servfee2*id+"::"+servfee2*id+"::"+2+"::"+1*-1+":: "+""+":: "+""+" :: ");
				    	clamount=clamount + servfee2; 
				    }else if(vtype.equalsIgnoreCase("V")){
				    	gridarray.add(visaseracno+"::"+desc+"::"+1+"::"+1+"::"+servfee2*id+"::"+servfee2*id+"::"+2+"::"+1*-1+":: "+""+":: "+""+" :: ");
				    	clamount=clamount + servfee2; 
				    }else if(vtype.equalsIgnoreCase("O")){  
				    	gridarray.add(otherseracno+"::"+desc+"::"+1+"::"+1+"::"+servfee2*id+"::"+servfee2*id+"::"+2+"::"+1*-1+":: "+""+":: "+""+" :: ");                
				    	clamount=clamount + servfee2;                     
				    }else{}     
				    }  
				    
				}
				if(refno.endsWith(",")) 
				{
					refno = refno.substring(0,refno.length() - 1);       
				}
				if(type.equalsIgnoreCase("ticket")){      
				if(clamount<0){ 
					id=-1;
				}else{
					id=1;
				}
				gridarray.add(cusacno+"::"+desc+"::"+1+"::"+1+"::"+clamount*id+"::"+clamount*id+"::"+2+"::"+1+":: "+""+":: "+""+" :: ");
				}
				System.out.println("gridarray--->>>"+gridarray);                    
			 	trnosss=DAO.insert(sqlStartDate,"VOC",refno,cldocno,refname,type,remarks,gridarray,session,"A","TINV",brhid,request);   
				temp=Integer.parseInt(request.getAttribute("vocno").toString());   
				jvtranno=Integer.parseInt(request.getAttribute("tranno").toString()); 
				//System.out.println(temp+"<<<------trnosss--->>>"+trnosss);  
				if(trnosss>0){
					if(type.equalsIgnoreCase("ticket")){  
						sqlss="update ti_ticketvoucherd set invtrno='"+trnosss+"' where rowno in("+docnos+")";                   
						//System.out.println("sqlss--->>>"+sqlss);                     
					    val3=stmt.executeUpdate(sqlss); 
					}else{
						sqlss="update ti_hotelvoucherd set invtrno='"+trnosss+"' where rowno in("+docnos+")";                   
						//System.out.println("sqlss--->>>"+sqlss);                       
					    val3=stmt.executeUpdate(sqlss);   
					}
					String jvsql="update tr_invoicem set tr_no='"+jvtranno+"' where doc_no='"+trnosss+"'";                      
					//System.out.println("jvsql--->>>"+jvsql);                       
				    val3=stmt.executeUpdate(jvsql); 
				}   
				if(val3>0){
					String claccno="0";
					ArrayList<String> arr=new ArrayList<String>();    
					ClsVatInsert ClsVatInsert=new ClsVatInsert();      
					Statement newStatement=conn.createStatement();
					String selectsqls= "select a.doc_no,coalesce(sum(a.total1)+sum(a.total2)+sum(a.tax1),0) nettaxamount,coalesce(sum(a.total1),0) total1,coalesce(sum(a.total2),0) total2,coalesce(sum(a.total3),0) total3,coalesce(sum(a.total4),0) total4,coalesce(sum(a.total5),0) total5,coalesce(sum(a.total6),0) total6,coalesce(sum(a.total7),0) total7,coalesce(sum(a.total8),0) total8,coalesce(sum(a.total9),0) total9,coalesce(sum(a.total10),0) total10,coalesce(sum(a.tax1),0) tax1,coalesce(sum(a.tax2),0) tax2,coalesce(sum(a.tax3),0) tax3,coalesce(sum(a.tax4),0) tax4,coalesce(sum(a.tax5),0) tax5,coalesce(sum(a.tax6),0) tax6,coalesce(sum(a.tax7),0) tax7,coalesce(sum(a.tax8),0) tax8,coalesce(sum(a.tax9),0) tax9,coalesce(sum(a.tax10),0) tax10 from (select m.doc_no,if(coalesce(case when types='ticket' then 0 when types='hotel' then hd.clvatamt else 0 end,0)>0,coalesce(case when types='ticket' then td.sprice when types='hotel' then hd.sprice-hd.nonvatamt else 0 end,0),0) total1,if(coalesce(case when types='ticket' then 0 when types='hotel' then hd.clvatamt else 0 end,0)>0,coalesce(case when types='ticket' then 0 when types='hotel' then hd.nonvatamt else 0 end,0),coalesce(case when types='ticket' then td.sprice when types='hotel' then hd.sprice else 0 end,0)) total2,0 total3,0 total4,0 total5,0 total6,0 total7,0 total8,0 total9,0 total10,coalesce(case when types='ticket' then 0 when types='hotel' then hd.clvatamt else 0 end,0) tax1,  0 tax2, 0 tax3,  0 tax4,0 tax5, 0 tax6,0 tax7,  0 tax8,0 tax9,  0 tax10 from tr_invoicem m left join ti_ticketvoucherd td on td.invtrno=m.doc_no left join ti_hotelvoucherd hd on hd.invtrno=m.doc_no where m.doc_no='"+trnosss+"') a group by a.doc_no";
					System.out.println("===ABC===="+selectsqls);  
					ResultSet rss101=newStatement.executeQuery(selectsqls);
					while(rss101.next()){
						arr.add(rss101.getDouble("nettaxamount")+"::"+rss101.getDouble("total1")+"::"+rss101.getDouble("total2")+"::"+
								rss101.getDouble("total3")+"::"+rss101.getDouble("total4")+"::"+rss101.getDouble("total5")+"::"+
								rss101.getDouble("total6")+"::"+rss101.getDouble("total7")+"::"+rss101.getDouble("total8")+"::"+
								rss101.getDouble("total9")+"::"+rss101.getDouble("total10")+"::"+rss101.getDouble("tax1")+"::"+
								rss101.getDouble("tax2")+"::"+rss101.getDouble("tax3")+"::"+rss101.getDouble("tax4")+"::"+
								rss101.getDouble("tax5")+"::"+rss101.getDouble("tax6")+"::"+rss101.getDouble("tax7")+"::"+
								rss101.getDouble("tax8")+"::"+rss101.getDouble("tax9")+"::"+rss101.getDouble("tax10")+"::"+"0");
						 System.out.println("======="+rss101.getDouble("nettaxamount"));  
						}   
					String clntsql= "select DOC_NO from MY_HEAD WHERE CLDOCNO='"+cldocno+"' and atype='AR'";   
				    System.out.println(arr+"===clntsql===="+clntsql);  
					ResultSet rssclnt=newStatement.executeQuery(clntsql);
					while(rssclnt.next()){
						claccno=rssclnt.getString("DOC_NO");
					}  
				 result=ClsVatInsert.vatinsert(1,2,conn,jvtranno,Integer.parseInt(claccno),temp,sqlStartDate,"TINV",brhid,""+temp,1,arr,"A");
				}
	     conn.commit();                           
  		 response.getWriter().write(result+"###"+temp);                     
	 	 conn.close();    
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   } finally{
	   conn.close();
   }

%>