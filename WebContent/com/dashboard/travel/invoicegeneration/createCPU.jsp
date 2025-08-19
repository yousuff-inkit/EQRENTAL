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
		String brhid=request.getParameter("brhid")=="" || request.getParameter("brhid")==null?"0":request.getParameter("brhid");
		String nonvatamt=request.getParameter("nonvatamt")=="" || request.getParameter("nonvatamt")==null?"0":request.getParameter("nonvatamt");
		String taxamt=request.getParameter("taxamt")=="" || request.getParameter("taxamt")==null?"0":request.getParameter("taxamt");
		String vatamt=request.getParameter("vatamt")=="" || request.getParameter("vatamt")==null?"0":request.getParameter("vatamt");   
		String type=request.getParameter("type")=="" || request.getParameter("type")==null?"0":request.getParameter("type");
		String invno=request.getParameter("invno")=="" || request.getParameter("invno")==null?"0":request.getParameter("invno");
		String invdate=request.getParameter("invdate")=="" || request.getParameter("invdate")==null?"0":request.getParameter("invdate");
		String postdate=request.getParameter("postdate")=="" || request.getParameter("postdate")==null?"0":request.getParameter("postdate");  
		String docnos=request.getParameter("rowno")==null || request.getParameter("rowno").trim().equalsIgnoreCase("")?"0":request.getParameter("rowno").toString();
		docnos=docnos+"0";  
		String sql="",sqlsub="",sql1="",sql2="",sql3="",typez="",accno="0";
		int dat=0,amendment=0,tax=0;          
		int val=0,temp=0,val1=0,trvocno=0,tranno=0,trannoss=0;  
		//Double total=0.0,vatamt=0.0,netamt=0.0,vatper=5.0; 
		Double vatper=5.0,netamt=0.0,suptot=0.0; 
		String tourname="",tourtaxtype="",date="",remarks="",vendorid="",rowno="";  
	   // System.out.println("docnos====="+docnos);                            
		//System.out.println("in=="+queryarray);  
		//System.out.println("in=="+rowarray);  
		ClsnipurchaseDAO DAO=new ClsnipurchaseDAO();   
		     session.setAttribute("BRANCHID",brhid);
			 String name="",mob="",email="";
			 int salid=0,telesales=0,vndid=0;
			 String vndacno="",accname="",rowsno="";
			 String t1="0",t2="0";  
			 ArrayList<String> cparray= new ArrayList<String>();
			 SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");              
			 java.util.Date curDate=new java.util.Date();
		     java.sql.Date cdate=ClsCommon.changeStringtoSqlDate(formatter.format(curDate));
		     java.sql.Date sqlinvdate=null;
		     java.sql.Date sqlpostdate=null;
		     if(!invdate.equalsIgnoreCase("0") && !invdate.equalsIgnoreCase("")){
		    	 sqlinvdate=ClsCommon.changeStringtoSqlDate(invdate);              
		     }
		     if(!postdate.equalsIgnoreCase("0") && !postdate.equalsIgnoreCase("")){
		    	 sqlpostdate=ClsCommon.changeStringtoSqlDate(postdate);                       
		     }
		     ArrayList<String> gridarray=new ArrayList<String>();
			    int xdoc=0,xcount=0,xodoc=0;          
			    ResultSet rs5=null;
			    String strcountvnd="";
			  /*   if(type.equalsIgnoreCase("Ticket")){     
			    	    strcountvnd="select '' types,(select acno from my_account where codeno='VENDOR ACCOUNT') accno,coalesce(suptotal,0) suptotal,coalesce(taxamt,0) taxamt,coalesce(supamt,0) supamt,coalesce(cpudoc,0) xdoc,if(coalesce(taxamt,0)=0,0,1) tax,concat(coalesce(ticketno,''),' - ',coalesce(guest,''),' - ',coalesce(ar.name,'')) description from ti_ticketvoucherd tr left join ti_airline ar on ar.doc_no=tr.airlineid where tr.rowno in("+docnos+")";
					    //System.out.println("strcountvnd--->>>"+strcountvnd);                                       
					    rs5=stmt.executeQuery(strcountvnd); 
			    }else{ */
			    	    strcountvnd="select case when tr.vtype='H' then 'Hotel' when tr.vtype='V' then 'Visa'  when tr.vtype='O' then 'Other' else '' end as types,(select acno from my_account where codeno='VENDOR ACCOUNT') accno,coalesce(suptotal,0) suptotal,coalesce(taxamt,0) taxamt,coalesce(nonvatamt,0)+coalesce(vatamt,0) supamt,coalesce(cpudoc,0) xdoc,if(coalesce(taxamt,0)=0,0,1) tax,concat(coalesce(suppconfno,''),' - ',coalesce(ht.name,''),' - ',coalesce(roomtype,'')) description from ti_hotelvoucherd tr left join tr_hotel ht on ht.doc_no=tr.hotelid where tr.rowno in("+docnos+")";
					    System.out.println("strcountvnd--->>>"+strcountvnd);                                       
						rs5=stmt.executeQuery(strcountvnd);   
			    /* } */   
				while(rs5.next()){
					 remarks=remarks+rs5.getString("description");                             
					 accno=rs5.getString("accno");
					/*  if(type.equalsIgnoreCase("Ticket")){    
				    	 typez="Ticket"; 
				     }else{ */
				    	 typez=typez+rs5.getString("types")+",";        
				     /* }     */   
					 tax=rs5.getInt("tax");
					 xdoc=rs5.getInt("xdoc");         
					 if(xdoc>0){  
						 xcount++; 
						 xodoc=xdoc;
					 }            
				}
				if(typez.endsWith(",")) 
				{
					typez = typez.substring(0,typez.length() - 1);       
				}	
			netamt=Double.parseDouble(vatamt)+Double.parseDouble(taxamt);
			suptot=netamt+Double.parseDouble(nonvatamt);
		    gridarray.add(0+" :: "+1+" :: "+remarks+" :: "+ Double.parseDouble(vatamt)+" :: "+Double.parseDouble(vatamt)+" :: "+0+" :: "+Double.parseDouble(vatamt)+" :: "+0+" :: "+""+" :: "+""+" :: "+""+" :: "+accno+" :: "+vatper+" :: "+Double.parseDouble(taxamt)+" :: "+netamt+" :: "+0+" :: ");
		    gridarray.add(0+" :: "+1+" :: "+remarks+" :: "+ Double.parseDouble(nonvatamt)+" :: "+Double.parseDouble(nonvatamt)+" :: "+0+" :: "+Double.parseDouble(nonvatamt)+" :: "+0+" :: "+""+" :: "+""+" :: "+""+" :: "+accno+" :: "+0+" :: "+0+" :: "+Double.parseDouble(nonvatamt)+" :: "+0+" :: ");   
		    rowno=rowno+"0";         
			vndacno="";    
			accname="";    
			System.out.println("gridarray=2="+gridarray);       
			String strcountdata="";
			ResultSet rs=null;
			/* if(type.equalsIgnoreCase("Ticket")){
					 strcountdata="select h.description vndacc,h.doc_no vndacno,tr.vnddocno vendorid,coalesce(n.tr_no,0) tranno from ti_ticketvoucherd tr left join my_srvpurm n on n.doc_no=tr.cpudoc left join my_head h on h.cldocno=tr.vnddocno and h.atype='AP'  where tr.rowno='"+docnos+"'";
					 //System.out.println("strcountdata--->>>"+strcountdata);                                               
					 rs=stmt.executeQuery(strcountdata);                            
			}else{ */
				strcountdata="select h.description vndacc,h.doc_no vndacno,tr.vnddocno vendorid,coalesce(n.tr_no,0) tranno from ti_hotelvoucherd tr left join my_srvpurm n on n.doc_no=tr.cpudoc left join my_head h on h.cldocno=tr.vnddocno and h.atype='AP'  where tr.rowno='"+docnos+"'";
				     //System.out.println("strcountdata--->>>"+strcountdata);                                                 
				     rs=stmt.executeQuery(strcountdata);  
			/* } */  
			while(rs.next()){                                                   
				vndacno=rs.getString("vndacno");      
				accname=rs.getString("vndacc");  
				vndid=rs.getInt("vendorid");                                
				trannoss=rs.getInt("tranno"); 
				if(trannoss>0){
					tranno=trannoss;  
				}
			} 
			//System.out.println("tranno========"+tranno);                   
			if(xcount>0){
				boolean status=DAO.edit(xodoc,sqlpostdate,cdate,"",0,"AP",vndacno,accname,"1","1","","",typez,session,"E",suptot,gridarray,"CPU",tranno,request,sqlinvdate,invno,"",0,1,tax);      
				if(status){  
					dat=xodoc;
					amendment=1;
				    String strvoc="select coalesce(voc_no,0) vocno from my_srvpurm where doc_no='"+dat+"'";                       
					//System.out.println("strvoc--->>>"+strvoc);                                   
				    ResultSet rss1=stmt.executeQuery(strvoc);                                 
				    while(rss1.next()){   
				    	trvocno=rss1.getInt("vocno");        
				    }
				}
			}else{        
				dat=DAO.insert(sqlpostdate,cdate,"",0,"AP",vndacno,accname,"1","1","","",typez,session,"A",suptot,gridarray,"CPU",request,sqlinvdate,invno,"",0,1,tax,"");       
				trvocno=Integer.parseInt(request.getAttribute("vocno").toString());    
			}
			if(dat>0){
				/* if(type.equalsIgnoreCase("Ticket")){
					String strupdate="update ti_ticketvoucherd set cpudoc="+dat+" where rowno in("+docnos+")";             
					//System.out.println("strupdate--->>>"+strupdate);    
					val1=stmt.executeUpdate(strupdate); 
				}else{ */
					String strupdate="update ti_hotelvoucherd set cpudoc="+dat+" where rowno in("+docnos+")";             
					//System.out.println("strupdate--->>>"+strupdate);    
					val1=stmt.executeUpdate(strupdate);   
				/* } */
			}    
			response.getWriter().print(val1+"###"+trvocno);                                                  
 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();  
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
