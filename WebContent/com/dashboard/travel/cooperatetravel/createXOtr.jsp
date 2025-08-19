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
<%@page import="com.finance.nipurchase.nipurchaseorder.ClsnipurchaseorderDAO" %>     
<%@page import="com.ibm.icu.text.SimpleDateFormat" %>        
<%	
ClsConnection ClsConnection=new ClsConnection();  
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;
    
	try{
	 	conn = ClsConnection.getMyConnection();       
		Statement stmt = conn.createStatement();   
		int brhid=request.getParameter("brhid")=="" || request.getParameter("brhid")==null?0:Integer.parseInt(request.getParameter("brhid").trim().toString());
		String docno=request.getParameter("docno")=="" || request.getParameter("docno")==null?"0":request.getParameter("docno");
		String vocno=request.getParameter("vocno")=="" || request.getParameter("vocno")==null?"0":request.getParameter("vocno");
		String type=request.getParameter("type")=="" || request.getParameter("type")==null?"0":request.getParameter("type");  
		String queryarray=request.getParameter("gridarray")==null || request.getParameter("gridarray").trim().equalsIgnoreCase("")?"0":request.getParameter("gridarray").toString();
		String queryarray2=request.getParameter("gridarray2")==null || request.getParameter("gridarray2").trim().equalsIgnoreCase("")?"0":request.getParameter("gridarray2").toString();
		String rowarray=request.getParameter("rowarray")==null || request.getParameter("rowarray").trim().equalsIgnoreCase("")?"0":request.getParameter("rowarray").toString();
		String sql="",sqlsub="",sql1="",sql2="",sql3="",typez="";
		int dat=0,amendment=0,tax=0;        
		int val=0,temp=0,val1=0,trvocno=0;  
		Double total=0.0,vatamt=0.0,netamt=0.0,vatper=0.0,stdtotal=0.0;
		String tourname="",tourtaxtype="",date="",remarks="",vendorid="",rowno="";
		//System.out.println("in=="+queryarray2);   
		//System.out.println("in=="+queryarray);  
		//System.out.println("in=="+rowarray);  
		ClsnipurchaseorderDAO DAO=new ClsnipurchaseorderDAO();   
			 String name="",mob="",email="";
			 int salid=0,telesales=0,vndid=0;
			 String vndacno="",accname="",rowsno="";
			 String t1="0",t2="0";  
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
		     /* String temparray[]=queryarray.split(",");  
				for(int i=0;i<temparray.length;i++){
					gridarray.add(temparray[i]);
				} */
			 /* if(queryarray2.length()>0){
			    String temparray3[]=rowarray.split(",");   
				String temparray2[]=queryarray2.split(",");   
				String temparray[]=queryarray.split(",");  
				for(int i=0;i<temparray2.length;i++){  
					//System.out.println("temparray2[i]=="+temparray2[i]); 
					t1=temparray2[i];
					if(i==0){              
						gridarray.add(temparray[i]);
						rowsno+=temparray3[i];
					}
					else if(t1.equalsIgnoreCase(t2)){
						gridarray.add(temparray[i]);
						rowsno+=","+temparray3[i];   
					}else{
						//System.out.println("gridarray=="+gridarray);  
						System.out.println("rowsno=="+rowsno); 
						String strcountdata="select h.description vndacc,h.doc_no vndacno from my_head h inner join my_acbook a on h.cldocno=a.cldocno and a.dtype='VND' and h.atype='AP' where a.cldocno='"+t2+"'";
						//System.out.println("strcountdata--->>>"+strcountdata);                                      
						ResultSet rs=stmt.executeQuery(strcountdata);                          
						while(rs.next()){          
							vndacno=rs.getString("vndacno");
							accname=rs.getString("vndacc");  
						} 
						System.out.println(vndacno+"=="+gridarray);
						dat=DAO.insert(cdate,cdate,"","AP",vndacno,accname,"1","1","","",typez+""+vocno,session,"A",Double.parseDouble(netamt),gridarray,"NPO",request,0);   	           
						temp=Integer.parseInt(request.getAttribute("vocno").toString());
						if(dat>0){
							 String strupdate="update tr_srtour set xodoc="+dat+" where rowno in("+rowsno+")";    
							 //System.out.println("strupdate--->>>"+strupdate); 
							 val1=stmt.executeUpdate(strupdate);                           
						}
						gridarray=new ArrayList<String>();  
						rowsno="";
						gridarray.add(temparray[i]);
						rowsno+=temparray3[i];    
					}
					t2=temparray2[i];           
				 }
			}  */  
			    int xdoc=0,xcount=0,xodoc=0,cstatus=0;
		        String strcountvnd="select coalesce(tr.remarks,0) remarks,coalesce(tr.rowno,0) rowno,coalesce(tr.vendorid,0) vendorid,date_format(tr.date,'%d.%m.%Y') date,coalesce(s.name,'') tourname ,coalesce(tr.stdtotal,0) stdtotal,coalesce(ac.tourtaxtype,'') tourtaxtype,coalesce(xodoc,0) xdoc,coalesce(tax,0) tax,coalesce(m.cstatus,0) cstatus  from tr_srtour tr left join tr_servicereqm m on m.doc_no=tr.rdocno left join tr_tours s on s.doc_no=tr.tourid left join my_acbook ac on ac.cldocno=tr.vendorid and ac.dtype='VND' where m.doc_no='"+docno+"'";
				//System.out.println("strcountvnd--->>>"+strcountvnd);                                   
				ResultSet rs5=stmt.executeQuery(strcountvnd);                                 
				while(rs5.next()){ 
					 cstatus=rs5.getInt("cstatus");  
					 tourname=rs5.getString("tourname");
					 tourtaxtype=rs5.getString("tourtaxtype");
					 date=rs5.getString("date");
					 remarks=rs5.getString("remarks");
					 stdtotal=rs5.getDouble("stdtotal");
					 tax=rs5.getInt("tax");                                      
					 vendorid=rs5.getString("vendorid");
				     rowno=rs5.getString("rowno")+",";
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
					 gridarray.add(0+" :: "+1+" :: "+(tourname+" - "+date+" - "+remarks)+" :: "+ total +" :: "+total+" :: "+0+" :: "+total+" ::"+0+" :: "+vatper+" :: "+vatamt+" :: "+netamt+" :: ");
				}
			rowno=rowno+"0";   
			vndacno="";    
			accname="";    
			//System.out.println("gridarray=2="+gridarray);       
			String strcountdata="select h.description vndacc,h.doc_no vndacno,tr.vendorid from tr_srtour tr left join my_head h on h.cldocno=tr.vendorid and h.atype='AP' where tr.rdocno='"+docno+"'";
			//System.out.println("strcountdata--->>>"+strcountdata);                                      
			ResultSet rs=stmt.executeQuery(strcountdata);                            
			while(rs.next()){                                                   
				vndacno=rs.getString("vndacno");   
				accname=rs.getString("vndacc");  
				vndid=rs.getInt("vendorid");                                
			}    
			//System.out.println("gridarray========"+gridarray);
			if(xcount>0){
				boolean status=DAO.edit(xodoc,cdate,cdate,"","AP",vndacno,accname,"1","1","","",typez+""+vocno,session,"E",netamt,gridarray,"NPO",tax);   
				if(status){
					dat=xodoc;
					amendment=1;
				    String strvoc="select coalesce(voc_no,0) vocno from my_srvlpom where doc_no='"+dat+"'";
					//System.out.println("strvoc--->>>"+strvoc);                                   
				    ResultSet rss1=stmt.executeQuery(strvoc);                                 
				    while(rss1.next()){   
				    	trvocno=rss1.getInt("vocno");   
				    }
				}
			}else{  
				dat=DAO.insert(cdate,cdate,"","AP",vndacno,accname,"1","1","","",typez+""+vocno,session,"A",netamt,gridarray,"NPO",request,tax);
				trvocno=Integer.parseInt(request.getAttribute("vocno").toString()); 
			}
			if(dat>0){
				if(cstatus==0){
					cstatus=1;
				}
				String statusupdate="update TR_SERVICEREQM m left join tr_srtour sr on sr.rdocno=m.doc_no set m.cstatus='"+cstatus+"', sr.xodoc="+dat+" where doc_no='"+docno+"'";         
				//System.out.println("statusupdate--->>>"+statusupdate);                       
				int temp1=stmt.executeUpdate(statusupdate);       
				val=1;  
			}
			//System.out.println("val--->>>"+val);      
			response.getWriter().print(val+"###"+trvocno+"###"+amendment);                                                
 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();  
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
