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
<%@page import="com.ibm.icu.text.SimpleDateFormat" %> 
<%@page import="com.common.ClsVatInsert"%>              
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
	String agentid=request.getParameter("agentid")=="" || request.getParameter("agentid")==null?"0":request.getParameter("agentid");
	String tourdate=request.getParameter("tourdate")=="" || request.getParameter("tourdate")==null?"0":request.getParameter("tourdate");
	String docno=request.getParameter("docno")=="" || request.getParameter("docno")==null?"0":request.getParameter("docno");
	String vocno=request.getParameter("vocno")=="" || request.getParameter("vocno")==null?"0":request.getParameter("vocno");
	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").trim().equalsIgnoreCase("")?"0":request.getParameter("brhid").trim().toString();
	String refname=request.getParameter("refname")==null || request.getParameter("refname").trim().equalsIgnoreCase("")?"":request.getParameter("refname").trim().toString();
	String cldocno=request.getParameter("cldocno")==null || request.getParameter("cldocno").trim().equalsIgnoreCase("")?"0":request.getParameter("cldocno").trim().toString();
	String reftype=request.getParameter("reftype")==null || request.getParameter("reftype").trim().equalsIgnoreCase("")?"0":request.getParameter("reftype").trim().toString();
	String type=request.getParameter("type")==null || request.getParameter("type").trim().equalsIgnoreCase("")?"0":request.getParameter("type").trim().toString();
	String clientacno=request.getParameter("clientacno")==null || request.getParameter("clientacno").trim().equalsIgnoreCase("")?"0":request.getParameter("clientacno").trim().toString();
	String salesacno=request.getParameter("salesacno")==null || request.getParameter("salesacno").trim().equalsIgnoreCase("")?"0":request.getParameter("salesacno").trim().toString();
	String cndate=request.getParameter("cndate")==null?"0":request.getParameter("cndate").trim().toString();
	String rowno=request.getParameter("rowno")==null || request.getParameter("rowno").trim().equalsIgnoreCase("")?"0":request.getParameter("rowno").trim().toString();
	String stdprice=request.getParameter("stdprice")==null || request.getParameter("stdprice")==""?"0.0":request.getParameter("stdprice").trim();
	String total=request.getParameter("total")==null || request.getParameter("total")==""?"0.0":request.getParameter("total").trim();
	String payback=request.getParameter("payback")==null || request.getParameter("payback")==""?"0.0":request.getParameter("payback").trim();
	int id=1,jvtranno=0;  
	Double vatamt=0.0,stdprc=0.0,totalamt=0.0,income=0.0,vatvnd=0.0,paybck=0.0,netamt=0.0,per=0.0;         
    //System.out.println("stdprice=="+stdprice+"==total=="+total+"=payback=="+payback);                   
	   
	try{ 
	    String sql=null,sqlss=null,sqlsss="",sqlss2="",strcountdata="",strclient="";       
		String cusacno="0",vndacno="0",incacno="0",taxacno="0",desc="",remarks="",taxtype="",actaxtype="";  
		Double sellingprice=0.0,commamt=0.0,value=0.0,crdchg=0.0,vatamount=0.0,vndpayamt=0.0;
 	    String clacno="0",method="0",spldesc="";
		int val=0,temp=0,trnosss=0;  
		int val3=0,result=0;   
	 	conn=connDAO.getMyConnection();
		Statement stmt=conn.createStatement(); 
		conn.setAutoCommit(false);             
		/*  if(!(cndate.equalsIgnoreCase("undefined"))&&!(cndate.equalsIgnoreCase(""))&&!(cndate.equalsIgnoreCase("0")))  
	     {
	  	  sqlStartDate2 = commonDAO.changeStringtoSqlDate(cndate);   
	     }     
		 if(!(tourdate.equalsIgnoreCase("undefined"))&&!(tourdate.equalsIgnoreCase(""))&&!(tourdate.equalsIgnoreCase("0")))
	     {
	  	  sqlStartDate = commonDAO.changetstmptoSqlDate(tourdate);     
	     } */    
		 desc="Tour- "+vocno+", "+refname;   
		 ArrayList<String> gridarray=new ArrayList<String>();                
		 strcountdata="select (select coalesce(acno,0) acno from my_account where codeno='CASH ACCOUNT') cusacno,(select coalesce(acno,0) acno from my_account where codeno='VENDOR ACCOUNT') vndacno,(select coalesce(acno,0) acno from my_account where codeno='TOUR INCOME') incacno,(select acno from gl_taxmaster where per!=0 and '"+cdate+"' between fromdate and todate and type=2) taxacno,(select coalesce(per) per from gl_taxmaster where per!=0 and '"+cdate+"' between fromdate and todate and type=2) per";
			//System.out.println("strcountdata--->>>"+strcountdata);             
			ResultSet rs=stmt.executeQuery(strcountdata);                              
			while(rs.next()){          
				cusacno=rs.getString("cusacno");       
				vndacno=rs.getString("vndacno");  
				incacno=rs.getString("incacno");    
				taxacno=rs.getString("taxacno"); 
				per=rs.getDouble("per");   
			}
		    //System.out.println("agentid==="+agentid);
         if(agentid.equalsIgnoreCase("0")){	   	        
                if(!clientacno.equalsIgnoreCase("0")){     
                	cusacno=clientacno;          
				}
                if(cldocno.equalsIgnoreCase("0")){            
                	strclient="select a.refname,a.cldocno,a.tourtaxtype from my_account ac left join my_acbook a on a.acno=ac.acno where ac.codeno='CASH ACCOUNT'";
      				//System.out.println("strclient--->>>"+strclient);                  
      				ResultSet rs4=stmt.executeQuery(strclient);                              
      				while(rs4.next()){          
      					refname=rs4.getString("refname");            
      					cldocno=rs4.getString("cldocno");  
      					actaxtype=rs4.getString("tourtaxtype");      
      				}
                }
            	totalamt=Double.parseDouble(total);   
            	 strcountdata="select req.date,tr.stdtotal,if(COALESCE(acc.tourtaxtype,'')='','"+actaxtype+"',acc.tourtaxtype) tourtaxtype,round(if(ac.tourtaxtype='INCLUSIVE',tr.stdtotal-((tr.stdtotal/(100 + "+per+"))*100) ,tr.stdtotal* ("+per+"/100) ),2) vatvnd,round(if(if(COALESCE(acc.tourtaxtype,'')='','"+actaxtype+"',acc.tourtaxtype)='INCLUSIVE',tr.total-((tr.total/(100 + "+per+"))*100) ,tr.total* ("+per+"/100) ),2) vatamt from tr_srtour tr left join tr_servicereqm req on tr.rdocno=req.doc_no left join my_acbook ac on ac.doc_no=TR.vendorid and ac.dtype='vnd' left join my_acbook acc on acc.doc_no=req.cldocno and acc.dtype='CRM' where rdocno='"+rowno+"'";
				System.out.println("strcountdata--->>>"+strcountdata);                       
				ResultSet rs2=stmt.executeQuery(strcountdata);                              
				while(rs2.next()){ 
					sqlStartDate =rs2.getDate("date");   
					vatvnd+=rs2.getDouble("vatvnd"); 
					vatamt+=rs2.getDouble("vatamt");       
					taxtype=rs2.getString("tourtaxtype");      
					if(taxtype.equalsIgnoreCase("EXCLUSIVE")){       
						totalamt=totalamt+vatamt;   
					}
				}   
				paybck=Double.parseDouble(payback);
				stdprc=Double.parseDouble(stdprice);  
				if(totalamt<0){
					id=-1;
				}else{  
					id=1;
				}                 
				gridarray.add(cusacno+"::"+desc+"::"+1+"::"+1+"::"+totalamt*id+"::"+totalamt*id+"::"+2+"::"+1+":: "+""+":: "+""+" :: ");        
				if(!salesacno.equalsIgnoreCase("0")){                      
					if(paybck<0){
						id=1;  
					}else{
						id=-1;
					}
					gridarray.add(cusacno+"::"+desc+"::"+1+"::"+1+"::"+paybck*id+"::"+paybck*id+"::"+2+"::"+1*-1+":: "+""+":: "+""+" :: ");
				}else{
					paybck=0.0;         
				}
				income=(Double.parseDouble(total)*-1)+paybck+(vatvnd*-1)+Double.parseDouble(stdprice)+vatamt;
				if(stdprc<0){
					id=1;  
				}else{
					id=-1;
				}
				gridarray.add(vndacno+"::"+desc+"::"+1+"::"+1+"::"+stdprc*id+"::"+stdprc*id+"::"+2+"::"+1*-1+":: "+""+":: "+""+" :: ");
				if(vatvnd<0){
					id=-1;
				}else{
					id=1;
				} 
				gridarray.add(vndacno+"::"+desc+"::"+1+"::"+1+"::"+vatvnd*id+"::"+vatvnd*id+"::"+2+"::"+1+":: "+""+":: "+""+" :: ");
				if(vatamt<0){
					id=1;  
				}else{
					id=-1;
				}
				gridarray.add(taxacno+"::"+desc+"::"+1+"::"+1+"::"+vatamt*id+"::"+vatamt*id+"::"+2+"::"+1*-1+":: "+""+":: "+""+" :: ");
				if(income<0){     
					id=-1;  
				}else{
					id=1;
				}   
				//System.out.println(income+"gridarray--->>>"+income*-1);     
				gridarray.add(incacno+"::"+desc+"::"+1+"::"+1+"::"+income+"::"+income+"::"+2+"::"+id+":: "+""+":: "+""+" :: ");
           }else{
        	    String sqldet1="select coalesce(method,0) method,coalesce(value,0) value from gl_config where field_nme='Card Commission'";  
 				//System.out.println("sqldet1--->>>"+sqldet1);                        
 				ResultSet rsdet1=stmt.executeQuery(sqldet1);                              
 				while(rsdet1.next()){          
 					method=rsdet1.getString("method");            
 					value=rsdet1.getDouble("value");  
 				}
 				String sqldet="select m.date,ac.refname,round(if(acc.tourtaxtype='INCLUSIVE',sum(coalesce(r.stdtotal,0))-((sum(coalesce(r.stdtotal,0))/(100 + "+per+"))*100) ,sum(coalesce(r.stdtotal,0))* ("+per+"/100) ),2) vatvnd,round(if(ac.tourtaxtype='INCLUSIVE',sum(coalesce(r.total,0))-((sum(coalesce(r.total,0))/(100 + "+per+"))*100) ,sum(coalesce(r.total,0))* ("+per+"/100) ),2) vatamt,round((sum(coalesce(r.total,0))*"+value+")/100,2) crdchg,round(sum(coalesce(r.total,0)),2) sprice,ac.acno clacno,ac.cldocno,round(((sum(coalesce(r.total,0))-sum(coalesce(r.stdtotal,0))-(sum(coalesce(r.adultdis,0))+sum(coalesce(r.childdis,0))))*((coalesce(p.per,0)/105)*100))/100,2) commamt from tr_servicereqm m left join tr_srtour r on r.rdocno=m.doc_no left join my_acbook ac on (ac.cldocno=m.agentid and ac.dtype='crm') left join my_acbook acc on (acc.cldocno=r.vendorid and acc.dtype='vnd') left join my_clprivilage p on ac.privilage=p.doc_no  where m.doc_no='"+rowno+"'  group by m.doc_no";  
 				//System.out.println("sqldet--->>>"+sqldet);                          
 				ResultSet rsdet=stmt.executeQuery(sqldet);                                  
 				while(rsdet.next()){   
 					sqlStartDate =rsdet.getDate("date");     
 					refname=rsdet.getString("refname");            
 					clacno=rsdet.getString("clacno");
 					cldocno=rsdet.getString("cldocno");
 					sellingprice=rsdet.getDouble("sprice"); 
 					commamt=rsdet.getDouble("commamt");      
 					crdchg=rsdet.getDouble("crdchg");  
 					vatamount=rsdet.getDouble("vatamt");     
 					vndpayamt=rsdet.getDouble("vatvnd");    
 				}
 				income=(sellingprice*-1)+commamt+(crdchg*-1)+vatamount+vndpayamt;
 				if(sellingprice<0){
					id=-1;
				}else{  
					id=1;
				}                 
				gridarray.add(clacno+"::"+desc+"::"+1+"::"+1+"::"+sellingprice*id+"::"+sellingprice*id+"::"+2+"::"+1+":: "+""+":: "+""+" :: "); 
				  
				if(commamt<0){
					id=1;
				}else{  
					id=-1;
				}
				spldesc="Commission -"+desc;
				gridarray.add(clacno+"::"+spldesc+"::"+1+"::"+1+"::"+commamt*id+"::"+commamt*id+"::"+2+"::"+1*-1+":: "+""+":: "+""+" :: ");
				if(method.equalsIgnoreCase("1")){   
					if(crdchg<0){
						id=-1;
					}else{  
						id=1;
					}  
					spldesc="Credit card charge -"+desc;  
					gridarray.add(clacno+"::"+spldesc+"::"+1+"::"+1+"::"+crdchg*id+"::"+crdchg*id+"::"+2+"::"+1+":: "+""+":: "+""+" :: ");	   
				}
				if(vatamount<0){
					id=1;
				}else{  
					id=-1;
				}  
				spldesc=refname+" -"+desc;  
				gridarray.add(taxacno+"::"+spldesc+"::"+1+"::"+1+"::"+vatamount*id+"::"+vatamount*id+"::"+2+"::"+1*-1+":: "+""+":: "+""+" :: ");
				if(vndpayamt<0){
					id=1;
				}else{  
					id=-1;
				}                 
				gridarray.add(vndacno+"::"+desc+"::"+1+"::"+1+"::"+vndpayamt*id+"::"+vndpayamt*id+"::"+2+"::"+1*-1+":: "+""+":: "+""+" :: ");
				if(income<0){   
					id=1;  
				}else{  
					id=-1;
				}                 
				gridarray.add(incacno+"::"+desc+"::"+1+"::"+1+"::"+income*id+"::"+income*id+"::"+2+"::"+1*-1+":: "+""+":: "+""+" :: ");          
             }
				//System.out.println(sqlStartDate+"<<<---gridarray--->>>"+cdate);              
				/* if(sqlStartDate.compareTo(cdate) < 0 || sqlStartDate.compareTo(cdate) == 0){        
					trnosss=DAO.insert(sqlStartDate,reftype,rowno,cldocno,refname,type,remarks,gridarray,session,"A","TINV",brhid,request);  
				}else{
					trnosss=DAO.insert(cdate,reftype,rowno,cldocno,refname,type,remarks,gridarray,session,"A","TINV",brhid,request);
				} */    
				trnosss=DAO.insert(sqlStartDate,reftype,rowno,cldocno,refname,type,remarks,gridarray,session,"A","TINV",brhid,request); 
				temp=Integer.parseInt(request.getAttribute("vocno").toString()); 
				jvtranno=Integer.parseInt(request.getAttribute("tranno").toString());
				if(temp>0){ 
					sqlss="update tr_servicereqm set invtrno='"+trnosss+"',cstatus=4 where doc_no='"+rowno+"'";          
					//System.out.println("sqlss--->>>"+sqlss);                       
				    val3=stmt.executeUpdate(sqlss);
				    String jvsql="update tr_invoicem set tr_no='"+jvtranno+"' where doc_no='"+trnosss+"'";                      
					//System.out.println("jvsql--->>>"+jvsql);                          
				    val3=stmt.executeUpdate(jvsql); 
				}
				 if(val3>0){  
				     Double clntvatamt=0.0;  
					 if(agentid.equalsIgnoreCase("0")){     	
				    	if(vatamt<0){
							id=-1;  
						}else{
							id=1;
						}
				    	clntvatamt=vatamt*id;
				    }else{
				    	if(vatamount<0){  
							id=-1;
						}else{  
							id=1;
						}  
				    	clntvatamt=vatamount*id;     
				    }
					String claccno="0";
					ArrayList<String> arr=new ArrayList<String>();    
					ClsVatInsert ClsVatInsert=new ClsVatInsert();      
					Statement newStatement=conn.createStatement();
					String selectsqls= "select a.doc_no,coalesce(sum(a.total1)+sum(a.total2)+sum(a.tax1),0) nettaxamount,coalesce(sum(a.total1),0) total1,coalesce(sum(a.total2),0) total2,coalesce(sum(a.total3),0) total3,coalesce(sum(a.total4),0) total4,coalesce(sum(a.total5),0) total5,coalesce(sum(a.total6),0) total6,coalesce(sum(a.total7),0) total7,coalesce(sum(a.total8),0) total8,coalesce(sum(a.total9),0) total9,coalesce(sum(a.total10),0) total10,coalesce(sum(a.tax1),0) tax1,coalesce(sum(a.tax2),0) tax2,coalesce(sum(a.tax3),0) tax3,coalesce(sum(a.tax4),0) tax4,coalesce(sum(a.tax5),0) tax5,coalesce(sum(a.tax6),0) tax6,coalesce(sum(a.tax7),0) tax7,coalesce(sum(a.tax8),0) tax8,coalesce(sum(a.tax9),0) tax9,coalesce(sum(a.tax10),0) tax10 from  (select m.doc_no,if("+clntvatamt+">0,sr.total,0) total1,if("+clntvatamt+">0,0,sr.total) total2,0 total3,0 total4,0 total5,0 total6,0 total7,0 total8,0 total9,0 total10,coalesce("+clntvatamt+",0) tax1,  0 tax2, 0 tax3,  0 tax4,0 tax5, 0 tax6,0 tax7,  0 tax8,0 tax9,  0 tax10 from tr_invoicem m left join tr_servicereqm req on req.invtrno=m.doc_no left join tr_srtour sr on sr.rdocno=req.doc_no where m.doc_no='"+trnosss+"') a group by a.doc_no";
					//System.out.println("===ABC===="+selectsqls);  
					ResultSet rss101=newStatement.executeQuery(selectsqls);
					while(rss101.next()){
						arr.add(rss101.getDouble("nettaxamount")+"::"+rss101.getDouble("total1")+"::"+rss101.getDouble("total2")+"::"+
								rss101.getDouble("total3")+"::"+rss101.getDouble("total4")+"::"+rss101.getDouble("total5")+"::"+
								rss101.getDouble("total6")+"::"+rss101.getDouble("total7")+"::"+rss101.getDouble("total8")+"::"+
								rss101.getDouble("total9")+"::"+rss101.getDouble("total10")+"::"+rss101.getDouble("tax1")+"::"+
								rss101.getDouble("tax2")+"::"+rss101.getDouble("tax3")+"::"+rss101.getDouble("tax4")+"::"+
								rss101.getDouble("tax5")+"::"+rss101.getDouble("tax6")+"::"+rss101.getDouble("tax7")+"::"+
								rss101.getDouble("tax8")+"::"+rss101.getDouble("tax9")+"::"+rss101.getDouble("tax10")+"::"+"0");
						}   
					String clntsql= "select DOC_NO from MY_HEAD WHERE CLDOCNO='"+cldocno+"' and atype='AR'";     
				    //System.out.println(arr+"===clntsql===="+clntsql);  
					ResultSet rssclnt=newStatement.executeQuery(clntsql);
					while(rssclnt.next()){
						claccno=rssclnt.getString("DOC_NO");
					}  
				 result=ClsVatInsert.vatinsert(1,2,conn,jvtranno,Integer.parseInt(claccno),temp,sqlStartDate,"TINV",brhid,""+temp,1,arr,"A");
				}         	
	     conn.commit();                           
  		 response.getWriter().write(val3+"::"+temp+"::"+trnosss);         
	 	 conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   } finally{
	   conn.close();
   }

%>