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
<%@page import="com.operations.commtransactions.rentalreceipts.ClsRentalReceiptsDAO" %>     
<%@page import="com.ibm.icu.text.SimpleDateFormat" %>        
<%	
ClsConnection ClsConnection=new ClsConnection();  
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;
    
	try{
	 	conn = ClsConnection.getMyConnection();            
		Statement stmt = conn.createStatement();     
		int locid=request.getParameter("locid")=="" || request.getParameter("locid")==null?0:Integer.parseInt(request.getParameter("locid").trim().toString());
		int brhid=request.getParameter("brhid")=="" || request.getParameter("brhid")==null?0:Integer.parseInt(request.getParameter("brhid").trim().toString());
		String refname=request.getParameter("refname")=="" || request.getParameter("refname")==null?"":request.getParameter("refname");   
		String doc_no=request.getParameter("rdocno")=="" || request.getParameter("rdocno")==null?"0":request.getParameter("rdocno"); 
		String type=request.getParameter("type")=="" || request.getParameter("type")==null?"0":request.getParameter("type");   
		String refdate=request.getParameter("refdate")=="" || request.getParameter("refdate")==null?"0":request.getParameter("refdate");
		String date=request.getParameter("date")=="" || request.getParameter("date")==null?"0":request.getParameter("date");
		String vocno=request.getParameter("vocno")=="" || request.getParameter("vocno")==null?"0":request.getParameter("vocno");   
		int cldocno=request.getParameter("cldocno")=="" || request.getParameter("cldocno")==null?0:Integer.parseInt(request.getParameter("cldocno").trim().toString());     
		String netamt=request.getParameter("netamt")=="" || request.getParameter("netamt")==null?"0.0":request.getParameter("netamt");
		String paytype=request.getParameter("paytype")==null || request.getParameter("paytype").trim().equalsIgnoreCase("")?"0":request.getParameter("paytype").toString();
		int acdocno=request.getParameter("acdocno")==null || request.getParameter("acdocno")==""?0:Integer.parseInt(request.getParameter("acdocno").trim().toString());         
		String cardtype=request.getParameter("cardtype")==null || request.getParameter("cardtype").trim().equalsIgnoreCase("")?"0":request.getParameter("cardtype").toString();
		String refno=request.getParameter("refno")==null || request.getParameter("refno").trim().equalsIgnoreCase("")?"0":request.getParameter("refno").toString();
		String destion=request.getParameter("desc")==null || request.getParameter("desc").trim().equalsIgnoreCase("")?"":request.getParameter("desc").toString();
		String sql="",sqlsub="",sql1="",sql2="",sql3="",description="";         
		Double nettotal=0.0,rctotal=0.0;
		int dat=0;       
		int val=0,temp=0,val1=0;   
		description=destion+"   Tour- "+vocno+", "+refname;              
		//System.out.println(acdocno+"===in===="+refdate);     
		ClsRentalReceiptsDAO DAO=new ClsRentalReceiptsDAO();   
			 String name="",mob="",email="";
			 int salid=0,telesales=0;
			 int clacno=0;
			 int clacno2=0;
			 ArrayList<String> cparray= new ArrayList<String>();
			 SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");              
			 java.util.Date curDate=new java.util.Date();
		     java.sql.Date cdate=ClsCommon.changeStringtoSqlDate(formatter.format(curDate));
		     java.sql.Date sqlrefdate=null;
		     java.sql.Date sqldate=null;
		     if(!refdate.equalsIgnoreCase("0")){
		    	 sqlrefdate=ClsCommon.changeStringtoSqlDate(refdate);
		     }
		     if(!date.equalsIgnoreCase("0")){          
		    	 sqldate=ClsCommon.changeStringtoSqlDate(date);
		     }
		     ArrayList<String> gridarray=new ArrayList<String>();
       
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
				if(cldocno==0){              
	            	String strclient="select coalesce(a.cldocno,0) cldocno from my_account ac left join my_acbook a on a.acno=ac.acno where ac.codeno='CASHACSALES'";
	  				//System.out.println("strclient--->>>"+strclient);                  
	  				ResultSet rs4=stmt.executeQuery(strclient);                                      
	  				while(rs4.next()){          
	  					cldocno=rs4.getInt("cldocno");    
	  				}
	              }
				session.setAttribute("BRANCHID",brhid);   
				//System.out.println(acdocno+"===in===="+clacno);
				//System.out.println(Double.parseDouble(netamt)+"===in===="+nettotal);           
				dat=DAO.insert(conn,sqldate,"RRV",paytype,acdocno,cardtype,refno,sqlrefdate,description,0, "0",cldocno,clacno,type,doc_no,"1",Double.parseDouble(netamt),0.0,0.0,0.0,Double.parseDouble(netamt),"","",0.0,gridarray,session,request);   	           
				//System.out.println("val--->>>"+dat);     
				if(dat>0){
					String locsql="update gl_rentreceipt set locid='"+locid+"' where srno='"+dat+"'";           
	  				//System.out.println("locsql--->>>"+locsql);                     
	  				int v=stmt.executeUpdate(locsql);
	  				String statusupdate="update TR_SERVICEREQM set cstatus=3 where doc_no='"+doc_no+"'";         
					//System.out.println("statusupdate--->>>"+statusupdate);                      
					int temp1=stmt.executeUpdate(statusupdate);    	       
			   }
			response.getWriter().print(dat);                
 	stmt.close();  
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
