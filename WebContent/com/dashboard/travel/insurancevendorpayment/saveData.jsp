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
<%@page import="com.finance.transactions.bankpayment.ClsBankPaymentDAO" %>           
<%@page import="com.ibm.icu.text.SimpleDateFormat" %>        
<%	
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();  
		conn.setAutoCommit(false);
		Statement stmt = conn.createStatement(); 
		String applyarrayyy=request.getParameter("applyarray")==null || request.getParameter("applyarray").trim().equalsIgnoreCase("")?"":request.getParameter("applyarray").toString();
		String queryarray=request.getParameter("gridarray")==null || request.getParameter("gridarray").trim().equalsIgnoreCase("")?"0":request.getParameter("gridarray").toString();
		String chqdate=request.getParameter("chqdate")=="" || request.getParameter("chqdate")==null?"0":request.getParameter("chqdate");
		String chqno=request.getParameter("chqno")=="" || request.getParameter("chqno")==null?"0":request.getParameter("chqno");
		String chqname=request.getParameter("chqname")=="" || request.getParameter("chqname")==null?"":request.getParameter("chqname");
		String cmnval=request.getParameter("cmntot")==null?"0.0":request.getParameter("cmntot").trim();
		String remarks=request.getParameter("desc")=="" || request.getParameter("desc")==null?"":request.getParameter("desc");
		String acno=request.getParameter("acno")=="" || request.getParameter("acno")==null?"0":request.getParameter("acno");
		String tranid=request.getParameter("tranid")=="" || request.getParameter("tranid")==null?"0":request.getParameter("tranid");
		String branchid=request.getParameter("branchid")=="" || request.getParameter("branchid")==null?"0":request.getParameter("branchid");
		String mainarray=request.getParameter("mainarray")==null?"":request.getParameter("mainarray").toString();
		//System.out.println("mainarray=====>>>"+mainarray);   
		int dat=0,trno=0;  
		Double amount=0.0;
		String temp="";     
		int val=0,val1=0;
		java.sql.Date sqlchqdate=null;
		ClsBankPaymentDAO DAO=new ClsBankPaymentDAO();  
			 ArrayList<String> marray=new ArrayList<String>();
			 if(mainarray.length()>0){
					String temparray1[]=mainarray.split(",");
					for(int i=0;i<temparray1.length;i++){
						marray.add(temparray1[i]);
					}                 
				}
			 ArrayList<String> newarray=new ArrayList<String>();
				if(queryarray.length()>0){
					String temparray[]=queryarray.split(",");
					for(int i=0;i<temparray.length;i++){
						newarray.add(temparray[i]);
					}            
				}
				ArrayList<String> applyarray=new ArrayList<String>();
				double applyamt=0;
				if(applyarrayyy.length()>0){
					String temparrayyy[]=applyarrayyy.split(",");
					for(int i=0;i<temparrayyy.length;i++){
						applyarray.add(temparrayyy[i]);
						applyamt+=Double.parseDouble(temparrayyy[i].split("::")[0]);
					}            
				} 
		     //System.out.println("applyarray=====>>>"+applyarray);         
			 if(!(chqdate.equalsIgnoreCase("undefined")) && !(chqdate.equalsIgnoreCase("")) && !(chqdate.equalsIgnoreCase("0"))){
				 sqlchqdate = ClsCommon.changeStringtoSqlDate(chqdate);
				}
			 SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");         
			 java.util.Date curDate=new java.util.Date();
		     java.sql.Date cdate=ClsCommon.changeStringtoSqlDate(formatter.format(curDate));
		  	 session=request.getSession();          
		  	 amount=Double.parseDouble(cmnval);  
		  	 amount=ClsCommon.Round(amount,2);
		  	 int id=1;
		  	 if(amount<0){
		  		 id=-1;
		  	 }else{
		  		 id=1;
		  	 }
		  	 int pdc=sqlchqdate.after(cdate)?1:0;
		  	 dat=DAO.insert(conn,cdate,"BPV","",1.0,sqlchqdate,chqno,chqname,pdc,remarks,amount*id,Integer.parseInt(acno),applyamt,newarray,applyarray,session,request,"A");   
	        // System.out.println("dat=====>>>"+dat);      
	         trno=Integer.parseInt(request.getAttribute("tranno").toString());      
	         if(dat>0){  
	        	 String sql="update my_jvtran set paid='"+trno+"' where tranid  in("+tranid.substring(0, tranid.length()-1)+")";    
	        	 val= stmt.executeUpdate(sql); 
	        	 for(int i=0;i<marray.size();i++){  
	        		 String tempmain[]=marray.get(i).split("::");
	        		 java.sql.Date dates;	
	        		 if(!tempmain[2].trim().equalsIgnoreCase("undefined") && !tempmain[2].trim().equalsIgnoreCase("NaN") && !tempmain[2].trim().equalsIgnoreCase("")){
	        			 dates = tempmain[0].trim().equalsIgnoreCase("undefined") || tempmain[0].trim().equalsIgnoreCase("NaN") || tempmain[0].trim().equalsIgnoreCase("") || tempmain[0].trim().isEmpty()?null:ClsCommon.changetstmptoSqlDate(tempmain[0].trim());       
	        			 String types = (tempmain[1].trim().equalsIgnoreCase("undefined") || tempmain[1].trim().equalsIgnoreCase("NaN") || tempmain[1].trim().equalsIgnoreCase("") || tempmain[1].trim().isEmpty()?"":tempmain[1].trim()).toString();
	        			 String docnos = (tempmain[2].trim().equalsIgnoreCase("undefined") || tempmain[2].trim().equalsIgnoreCase("NaN") || tempmain[2].trim().equalsIgnoreCase("") || tempmain[2].trim().isEmpty()?"":tempmain[2].trim()).toString();
	        			 String vndamt = tempmain[3].trim().equalsIgnoreCase("undefined") || tempmain[3].trim().equalsIgnoreCase("NaN") || tempmain[3].trim().equalsIgnoreCase("") || tempmain[3].trim().isEmpty()?"0.00":tempmain[3].trim().toString();
	        			 String vndrvd = tempmain[4].trim().equalsIgnoreCase("undefined") || tempmain[4].trim().equalsIgnoreCase("NaN") || tempmain[4].trim().equalsIgnoreCase("") || tempmain[4].trim().isEmpty()?"0.00":tempmain[4].trim().toString();
	        			 String vndbl = tempmain[5].trim().equalsIgnoreCase("undefined") || tempmain[5].trim().equalsIgnoreCase("NaN") || tempmain[5].trim().equalsIgnoreCase("") || tempmain[5].trim().isEmpty()?"0.00":tempmain[5].trim().toString();
	        			 String clients = tempmain[6].trim().equalsIgnoreCase("undefined") || tempmain[6].trim().equalsIgnoreCase("NaN") || tempmain[6].trim().equalsIgnoreCase("") || tempmain[6].trim().isEmpty()?"":tempmain[6].trim().toString();	
	        			 String descriptions = tempmain[7].trim().equalsIgnoreCase("undefined") || tempmain[7].trim().equalsIgnoreCase("NaN") || tempmain[7].trim().equalsIgnoreCase("") || tempmain[7].trim().isEmpty()?"":tempmain[7].trim().toString();
	        			 String netsales = tempmain[8].trim().equalsIgnoreCase("undefined") || tempmain[8].trim().equalsIgnoreCase("NaN") || tempmain[8].trim().equalsIgnoreCase("") || tempmain[8].trim().isEmpty()?"0.00":tempmain[8].trim().toString();
	        			 String netpur = tempmain[9].trim().equalsIgnoreCase("undefined") || tempmain[9].trim().equalsIgnoreCase("NaN") || tempmain[9].trim().equalsIgnoreCase("") || tempmain[9].trim().isEmpty()?"0.00":tempmain[9].trim().toString();
	        			 String profit = tempmain[10].trim().equalsIgnoreCase("undefined") || tempmain[10].trim().equalsIgnoreCase("NaN") || tempmain[10].trim().equalsIgnoreCase("") || tempmain[10].trim().isEmpty()?"0.00":tempmain[10].trim().toString();
	        			 
	        			 String sqlinsert="insert into tr_vendorpayment(brhid, date, reftype, refdocno, vndamt, vndrvd, vndbl, client, description, netsales, netpur, profit, bpvdocno, bpvtrno) values('"+branchid+"','"+dates+"','"+types+"','"+docnos+"',"+Double.parseDouble(vndamt)+","+Double.parseDouble(vndrvd)+","+Double.parseDouble(vndbl)+",'"+clients+"','"+descriptions+"',"+Double.parseDouble(netsales)+","+Double.parseDouble(netpur)+","+Double.parseDouble(profit)+",'"+dat+"','"+trno+"')";
	        			 val=stmt.executeUpdate(sqlinsert);                         
		    		    }
	    	    }
	         }
	         if(val>0){ 
	         conn.commit(); 
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
