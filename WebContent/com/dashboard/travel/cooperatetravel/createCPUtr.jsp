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
<%@page import="com.finance.nipurchase.nipurchase.ClsnipurchaseDAO" %>       
<%@page import="com.ibm.icu.text.SimpleDateFormat" %>        
<%	
ClsConnection ClsConnection=new ClsConnection();  
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;
    
	try{
		 	 conn = ClsConnection.getMyConnection();       
			 Statement stmt = conn.createStatement(); 
			 Statement stmt2 = conn.createStatement(); 
			 Statement stmt3 = conn.createStatement(); 
			 Statement stmt4= conn.createStatement(); 
			 int brhid=request.getParameter("brhid")=="" || request.getParameter("brhid")==null?0:Integer.parseInt(request.getParameter("brhid").trim().toString());
			 String docno=request.getParameter("docno")=="" || request.getParameter("docno")==null?"0":request.getParameter("docno");
			 String vocno=request.getParameter("vocno")=="" || request.getParameter("vocno")==null?"0":request.getParameter("vocno");
			 String type=request.getParameter("type")=="" || request.getParameter("type")==null?"0":request.getParameter("type");  
			 String queryarray=request.getParameter("gridarray")==null || request.getParameter("gridarray").trim().equalsIgnoreCase("")?"0":request.getParameter("gridarray").toString();
			 String queryarray2=request.getParameter("gridarray2")==null || request.getParameter("gridarray2").trim().equalsIgnoreCase("")?"0":request.getParameter("gridarray2").toString();
			 String rowarray=request.getParameter("rowarray")==null || request.getParameter("rowarray").trim().equalsIgnoreCase("")?"0":request.getParameter("rowarray").toString();
			 int dat=0,amendment=0,tax=0,t1=0,t2=0;        
			 int val=0,temp=0,val1=0,trvocno=0,tranno=0,trannoss=0,i=0;  
			 Double total=0.0,vatamt=0.0,netamt=0.0,vatper=0.0,stdtotal=0.0;     
			 ClsnipurchaseDAO DAO=new ClsnipurchaseDAO();      
			 int salid=0,telesales=0,vndid=0;
			 String cpuvocno="",vndacno="",accname="",rowsno="",name="",mob="",email="",tourname="",tourtaxtype="",date="",remarks="",vendorid="",rowno="",sql="",sqlsub="",sql1="",sql2="",sql3="",typez="",accno="0";
			 ArrayList<String> cparray= new ArrayList<String>();
			 SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");              
			 java.util.Date curDate=new java.util.Date();
		     java.sql.Date cdate=ClsCommon.changeStringtoSqlDate(formatter.format(curDate));
		     ArrayList<String> gridarray=new ArrayList<String>();
		     ArrayList<String> gridarray2=new ArrayList<String>();
		     ArrayList<String> gridarray3=new ArrayList<String>();
		     session.setAttribute("BRANCHID",brhid);
		     if(type.equalsIgnoreCase("Service Request")){
		    	 typez="Service request no - "; 
		     }else{
		    	 typez="Booking No - "; 
		     }
			 int xdoc=0,xcount=0,xodoc=0;    
			 String strcountvnd="select h.description vndacc,h.doc_no vndacno,coalesce(n.tr_no,0) tranno,(select acno from my_account where codeno='TOUR INCOME') accno,coalesce(tr.remarks,0) remarks,coalesce(tr.rowno,0) rowno,coalesce(tr.vendorid,0) vendorid,date_format(tr.date,'%d.%m.%Y') date,coalesce(s.name,'') tourname ,coalesce(tr.stdtotal,0) stdtotal,coalesce(ac.tourtaxtype,'') tourtaxtype,coalesce(cpudoc,0) xdoc,coalesce(ac.tax,0) tax from tr_srtour tr left join my_srvpurm n on n.doc_no=tr.cpudoc left join my_head h on h.cldocno=tr.vendorid and h.atype='AP' left join tr_servicereqm m on m.doc_no=tr.rdocno left join tr_tours s on s.doc_no=tr.tourid left join my_acbook ac on ac.cldocno=tr.vendorid and ac.dtype='VND' where m.doc_no='"+docno+"' order by tr.vendorid";
		     System.out.println("strcountvnd--->>>"+strcountvnd);                                       
		     ResultSet rs5=stmt.executeQuery(strcountvnd);                                 
		     while(rs5.next()){
		    	     t1=rs5.getInt("vendorid");  
		    	     //System.out.println("vendorid<<<--->>>"+t1);   
					 //System.out.println(t1+"<t1<<--->>t2>"+t2);           
					 if(i==0){ 
						 //System.out.println("--->>>in 1");
						 vndacno=rs5.getString("vndacno");         
						 accname=rs5.getString("vndacc");  
						 vndid=rs5.getInt("vendorid");                                
						 trannoss=rs5.getInt("tranno"); 
						 if(trannoss>0){
							tranno=trannoss;  
						 }
						 accno=rs5.getString("accno");
						 tourname=rs5.getString("tourname");
						 tourtaxtype=rs5.getString("tourtaxtype");
						 date=rs5.getString("date");
						 remarks=rs5.getString("remarks");
						 stdtotal=rs5.getDouble("stdtotal");
						 tax=rs5.getInt("tax");
						 vendorid=rs5.getString("vendorid");
					     rowno=rowno+rs5.getString("rowno")+",";    
						 total=0.0;   
						 vatamt=0.0;
						 netamt=0.0;
						 vatper=0.0;
						 xdoc=rs5.getInt("xdoc");         
						 if(xdoc>0){
							 xcount++; 
							 xodoc=xdoc;
						 }
						 if(tax==1){
							 if(tourtaxtype.equalsIgnoreCase("EXCLUSIVE")){          
								   vatper=5.0;
								   vatamt=(stdtotal*5)/100;    
								   total=stdtotal;
								   netamt=stdtotal+vatamt; 
							   }else{
								   vatper=5.0;
								   vatamt=stdtotal-((stdtotal/105)*100);    
								   total=stdtotal-vatamt;   
								   netamt=stdtotal;               
							   }
						 }else{
							   vatamt=0.0;    
							   total=stdtotal;      
							   netamt=stdtotal;    
						 }
						 gridarray.add(0+" :: "+1+" :: "+(tourname+" - "+date+" - "+remarks)+" :: "+ total +" :: "+total+" :: "+0+" :: "+total+" :: "+0+" :: "+""+" :: "+""+" :: "+""+" :: "+accno+" :: "+vatper+" :: "+vatamt+" :: "+netamt+" :: "+0+" :: "); 
					 }else if(t1==t2){   
						 //System.out.println("--->>>in 2");
						 vndacno=rs5.getString("vndacno");         
						 accname=rs5.getString("vndacc");  
						 vndid=rs5.getInt("vendorid");                                
						 trannoss=rs5.getInt("tranno"); 
						 if(trannoss>0){
							tranno=trannoss;  
						 }
						 accno=rs5.getString("accno");
						 tourname=rs5.getString("tourname");
						 tourtaxtype=rs5.getString("tourtaxtype");
						 date=rs5.getString("date");
						 remarks=rs5.getString("remarks");
						 stdtotal=rs5.getDouble("stdtotal");
						 tax=rs5.getInt("tax");
						 vendorid=rs5.getString("vendorid");
					     rowno=rowno+rs5.getString("rowno")+",";    
						 total=0.0;   
						 vatamt=0.0;
						 netamt=0.0;
						 vatper=0.0;
						 xdoc=rs5.getInt("xdoc");         
						 if(xdoc>0){
							 xcount++; 
							 xodoc=xdoc;
						 }
						 if(tax==1){
							 if(tourtaxtype.equalsIgnoreCase("EXCLUSIVE")){          
								   vatper=5.0;
								   vatamt=(stdtotal*5)/100;    
								   total=stdtotal;
								   netamt=stdtotal+vatamt; 
							   }else{
								   vatper=5.0;
								   vatamt=stdtotal-((stdtotal/105)*100);    
								   total=stdtotal-vatamt;   
								   netamt=stdtotal;               
							   }
						 }else{
							   vatamt=0.0;    
							   total=stdtotal;      
							   netamt=stdtotal;    
						 }
						 gridarray.add(0+" :: "+1+" :: "+(tourname+" - "+date+" - "+remarks)+" :: "+ total +" :: "+total+" :: "+0+" :: "+total+" :: "+0+" :: "+""+" :: "+""+" :: "+""+" :: "+accno+" :: "+vatper+" :: "+vatamt+" :: "+netamt+" :: "+0+" :: ");
					 }else{
						  //System.out.println("--->>>in 3 "+gridarray);  
						    rowno=rowno+"0";              
							if(xcount>0){
								boolean status=DAO.edit(xodoc,cdate,cdate,"",0,"AP",vndacno,accname,"1","1","","",typez+""+vocno,session,"E",netamt,gridarray,"CPU",tranno,request,cdate,"","",0,1,tax);      
								if(status){
									dat=xodoc;
									amendment=1;
								    String strvoc="select coalesce(voc_no,0) vocno from my_srvpurm where doc_no='"+dat+"'";               
									//System.out.println("strvoc--->>>"+strvoc);                                   
								    ResultSet rss1=stmt2.executeQuery(strvoc);                                   
								    while(rss1.next()){   
								    	trvocno=rss1.getInt("vocno");   
								    }
								}
								}else{     
									dat=DAO.insert(cdate,cdate,"",0,"AP",vndacno,accname,"1","1","","",typez+""+vocno,session,"A",netamt,gridarray,"CPU",request,cdate,"","",0,1,tax,"");    
									trvocno=Integer.parseInt(request.getAttribute("vocno").toString()); 
								}
								if(dat>0){
									String strupdate="update tr_srtour set cpudoc="+dat+" where rowno in("+rowno+")";           
									//System.out.println("strupdate--->>>"+strupdate);      
									val1=stmt4.executeUpdate(strupdate);                                                                       
								} 
								rowno="";
								vndacno=rs5.getString("vndacno");         
								 accname=rs5.getString("vndacc");  
								 vndid=rs5.getInt("vendorid");                                
								 trannoss=rs5.getInt("tranno"); 
								 if(trannoss>0){
									tranno=trannoss;  
								 }
								 accno=rs5.getString("accno");
								 tourname=rs5.getString("tourname");
								 tourtaxtype=rs5.getString("tourtaxtype");
								 date=rs5.getString("date");
								 remarks=rs5.getString("remarks");
								 stdtotal=rs5.getDouble("stdtotal");
								 tax=rs5.getInt("tax");
								 vendorid=rs5.getString("vendorid");
							     rowno=rowno+rs5.getString("rowno")+",";    
								 total=0.0;   
								 vatamt=0.0;
								 netamt=0.0;
								 vatper=0.0;
								 xdoc=rs5.getInt("xdoc");         
								 if(xdoc>0){
									 xcount++; 
									 xodoc=xdoc;
								 }
								 if(tax==1){
									 if(tourtaxtype.equalsIgnoreCase("EXCLUSIVE")){          
										   vatper=5.0;
										   vatamt=(stdtotal*5)/100;    
										   total=stdtotal;
										   netamt=stdtotal+vatamt; 
									   }else{
										   vatper=5.0;
										   vatamt=stdtotal-((stdtotal/105)*100);    
										   total=stdtotal-vatamt;   
										   netamt=stdtotal;               
									   }
								 }else{
									   vatamt=0.0;    
									   total=stdtotal;      
									   netamt=stdtotal;    
								 }
								cpuvocno=cpuvocno+trvocno+",";    
								gridarray=new ArrayList<String>();             
								gridarray.add(0+" :: "+1+" :: "+(tourname+" - "+date+" - "+remarks)+" :: "+ total +" :: "+total+" :: "+0+" :: "+total+" :: "+0+" :: "+""+" :: "+""+" :: "+""+" :: "+accno+" :: "+vatper+" :: "+vatamt+" :: "+netamt+" :: "+0+" :: ");
					 }
					  t2=rs5.getInt("vendorid");  
					  //System.out.println("<<<--->>>"+i);        
					  i++; 
		     }
		    //System.out.println("<<<--->>>");      
		    rowno=rowno+"0";      
		 	if(xcount>0){
				boolean status=DAO.edit(xodoc,cdate,cdate,"",0,"AP",vndacno,accname,"1","1","","",typez+""+vocno,session,"E",netamt,gridarray,"CPU",tranno,request,cdate,"","",0,1,tax);      
				if(status){
					dat=xodoc;
					amendment=1;
				    String strvoc="select coalesce(voc_no,0) vocno from my_srvpurm where doc_no='"+dat+"'";               
					//System.out.println("strvoc--->>>"+strvoc);                                   
				    ResultSet rss2=stmt3.executeQuery(strvoc);                                 
				    while(rss2.next()){   
				    	trvocno=rss2.getInt("vocno");   
				    }
				}
			}else{     
				dat=DAO.insert(cdate,cdate,"",0,"AP",vndacno,accname,"1","1","","",typez+""+vocno,session,"A",netamt,gridarray,"CPU",request,cdate,"","",0,1,tax,"");    
				trvocno=Integer.parseInt(request.getAttribute("vocno").toString()); 
			}
			if(dat>0){
				String strupdate="update tr_srtour set cpudoc="+dat+" where rowno in("+rowno+")";                
				//System.out.println("strupdate--->>>"+strupdate);    
				val1=stmt4.executeUpdate(strupdate);                                                                       
			} 
			if(val1>0){
				String statusupdate="update TR_SERVICEREQM set cstatus=1 where doc_no='"+docno+"'";           
				//System.out.println("statusupdate--->>>"+statusupdate);                       
				int temp1=stmt4.executeUpdate(statusupdate);          
				val=1;   
			}   
			cpuvocno=cpuvocno+trvocno+"";        
			//System.out.println("val--->>>"+val);      
			response.getWriter().print(val+"###"+cpuvocno+"###"+amendment);                                                          
 	        stmt.close();
 	        conn.close();
	}catch(Exception e){
	 	e.printStackTrace();  
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
