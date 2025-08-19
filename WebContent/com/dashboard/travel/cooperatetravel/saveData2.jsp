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
		String doc_no=request.getParameter("rdocno")=="" || request.getParameter("rdocno")==null?"0":request.getParameter("rdocno");
		String type=request.getParameter("type")=="" || request.getParameter("type")==null?"0":request.getParameter("type");   
		String refdate=request.getParameter("refdate")=="" || request.getParameter("refdate")==null?"0":request.getParameter("refdate");
		String vocno=request.getParameter("vocno")=="" || request.getParameter("vocno")==null?"0":request.getParameter("vocno");   
		int cldocno=request.getParameter("cldocno")=="" || request.getParameter("cldocno")==null?0:Integer.parseInt(request.getParameter("cldocno").trim().toString());     
		String netamt=request.getParameter("netamt")=="" || request.getParameter("netamt")==null?"0.0":request.getParameter("netamt");
		String paytype=request.getParameter("paytype")==null || request.getParameter("paytype").trim().equalsIgnoreCase("")?"0":request.getParameter("paytype").toString();
		int acdocno=request.getParameter("acdocno")==null || request.getParameter("acdocno")==""?0:Integer.parseInt(request.getParameter("acdocno").trim().toString());         
		String cardtype=request.getParameter("cardtype")==null || request.getParameter("cardtype").trim().equalsIgnoreCase("")?"0":request.getParameter("cardtype").toString();
		String refno=request.getParameter("refno")==null || request.getParameter("refno").trim().equalsIgnoreCase("")?"0":request.getParameter("refno").toString();
		String description=request.getParameter("desc")==null || request.getParameter("desc").trim().equalsIgnoreCase("")?"0":request.getParameter("desc").toString();
		String sql="",sqlsub="",sql1="",sql2="",sql3="";
		int dat=0;       
		int val=0,temp=0,val1=0;  
		System.out.println(acdocno+"===in===="+refdate);     
		ClsRentalReceiptsDAO DAO=new ClsRentalReceiptsDAO();   
			 String name="",mob="",email="";
			 int salid=0,telesales=0;
			 int clacno=0;
			 int clacno2=0;
			 ArrayList<String> cparray= new ArrayList<String>();
			 SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");              
			 java.util.Date curDate=new java.util.Date();
		     java.sql.Date cdate=ClsCommon.changeStringtoSqlDate(formatter.format(curDate));
		    
		     ArrayList<String> gridarray=new ArrayList<String>();
       
		     String strcountdata="select h.doc_no clacno from my_head h inner join my_acbook a on h.cldocno=a.cldocno and a.dtype='CRM' and h.atype='AR' where a.cldocno='"+cldocno+"'";
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
			System.out.println("===in===="+clacno);     
			dat=DAO.insert(conn,cdate,"RRV",paytype,acdocno,cardtype,refno,cdate,description,0, "0",cldocno,clacno,type,doc_no,"0",Double.parseDouble(netamt),0.0,0.0,0.0,Double.parseDouble(netamt),"","",0.0,gridarray,session,request);   	           
			System.out.println("val--->>>"+dat);       
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
