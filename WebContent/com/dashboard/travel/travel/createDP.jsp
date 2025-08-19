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
<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO" %>     
<%@page import="com.ibm.icu.text.SimpleDateFormat" %>        
<%	         
ClsConnection ClsConnection=new ClsConnection();  
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;
    
	try{
	 	conn = ClsConnection.getMyConnection();           
		Statement stmt = conn.createStatement();   
		int brhid=request.getParameter("brhid")=="" || request.getParameter("brhid")==null?0:Integer.parseInt(request.getParameter("brhid").trim().toString());
		String docno=request.getParameter("rdocno")=="" || request.getParameter("rdocno")==null?"0":request.getParameter("rdocno");  
		String netamt=request.getParameter("netamt")=="" || request.getParameter("netamt")==null?"0.0":request.getParameter("netamt");
		String date=request.getParameter("date")=="" || request.getParameter("date")==null?"0":request.getParameter("date");
		int cldocno=request.getParameter("cldocno")=="" || request.getParameter("cldocno")==null?0:Integer.parseInt(request.getParameter("cldocno").trim().toString());     
		String description=request.getParameter("desc")==null || request.getParameter("desc").trim().equalsIgnoreCase("")?"0":request.getParameter("desc").toString();
		String sql="",sqlsub="",sql1="",sql2="",sql3="";
		Double nettotal=0.0;
		int id=0,dat=0;       
		int val=0,temp=0,val1=0,trnosss=0;      
		//System.out.println(acdocno+"===in===="+refdate);     
		ClsJournalVouchersDAO DAO=new ClsJournalVouchersDAO();                     
			 int clacno=0,vndacno=0;
			 int clacno2=0;
			 ArrayList<String> gridarray=new ArrayList<String>();   
			 SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");              
			 java.util.Date curDate=new java.util.Date();
		     java.sql.Date cdate=ClsCommon.changeStringtoSqlDate(formatter.format(curDate));
		     java.sql.Date sqlrefdate=null;
		     java.sql.Date sqldate=null;
		     session.setAttribute("BRANCHID",brhid); 
		     if(!date.equalsIgnoreCase("0")){          
		    	 sqldate=ClsCommon.changeStringtoSqlDate(date);  
		     }
       
		        String strcountdata="select coalesce(h.doc_no,0) clacno from my_head h inner join my_acbook a on h.cldocno=a.cldocno and a.dtype='CRM' and h.atype='AR' where a.cldocno='"+cldocno+"'";
				//System.out.println("strcountdata--->>>"+strcountdata);                                   
				ResultSet rs=stmt.executeQuery(strcountdata);                             
				while(rs.next()){          
					clacno=rs.getInt("clacno");
				}     
				if(clacno==0){
					strcountdata="select acno from my_account where codeno='CASHACSALES'";         
					ResultSet rs1=stmt.executeQuery(strcountdata);                             
					while(rs1.next()){            
						clacno=rs1.getInt("acno");                 
					}     
				}       
				String strcountvnd="select coalesce(h.doc_no,0) vndacno from tr_srtour tr left join my_head h on h.cldocno=tr.vendorid and h.atype='AP' where tr.rdocno='"+docno+"' limit 1";
				//System.out.println("strcountvnd--->>>"+strcountvnd);                                   
				ResultSet rs5=stmt.executeQuery(strcountvnd);                                 
				while(rs5.next()){          
					vndacno=rs5.getInt("vndacno");
				}
				nettotal=Double.parseDouble(netamt);
				if(nettotal<0){   
					id=1;
				}else{
					id=-1;
				}
				gridarray.add(clacno+"::"+description+"::"+1+"::"+1+"::"+nettotal*id+"::"+nettotal*id+"::"+2+"::"+1*-1+":: "+""+":: "+"");    
				if(nettotal<0){   
					id=-1;
				}else{
					id=1;
				}
				gridarray.add(vndacno+"::"+description+"::"+1+"::"+1+"::"+nettotal*id+"::"+nettotal*id+"::"+2+"::"+1+":: "+""+":: "+"");         
				//System.out.println("gridarray--->>>"+gridarray);
				dat=DAO.insert(sqldate,"JVT-18", "", description, nettotal*id, nettotal*id,gridarray,session,request);                               
				trnosss=Integer.parseInt(request.getAttribute("tranno").toString());
				if(dat>0){
	  			 	String statusupdate="update my_jvtran set rdocno='"+docno+"',rtype='Service Request' where tr_no='"+trnosss+"'";         
					//System.out.println("statusupdate--->>>"+statusupdate);                         
					 val=stmt.executeUpdate(statusupdate); 
					 
					  statusupdate="update tr_servicereqm set dpdocno='"+docno+"' where doc_no='"+docno+"'";         
						//System.out.println("statusupdate--->>>"+statusupdate);                         
						 val=stmt.executeUpdate(statusupdate); 
			   }
			response.getWriter().print(val);                                      
 	stmt.close();  
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
