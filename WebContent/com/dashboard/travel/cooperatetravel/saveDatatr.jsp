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
		String vocno=request.getParameter("vocno")=="" || request.getParameter("vocno")==null?"0":request.getParameter("vocno");
		//String vndid=request.getParameter("vndid")=="" || request.getParameter("vndid")==null?"0":request.getParameter("vndid");
		String netamt=request.getParameter("netamt")=="" || request.getParameter("netamt")==null?"0.0":request.getParameter("netamt");
		String queryarray=request.getParameter("gridarray")==null || request.getParameter("gridarray").trim().equalsIgnoreCase("")?"0":request.getParameter("gridarray").toString();
		String queryarray2=request.getParameter("gridarray2")==null || request.getParameter("gridarray2").trim().equalsIgnoreCase("")?"0":request.getParameter("gridarray2").toString();
		String rowarray=request.getParameter("rowarray")==null || request.getParameter("rowarray").trim().equalsIgnoreCase("")?"0":request.getParameter("rowarray").toString();
		String sql="",sqlsub="",sql1="",sql2="",sql3="";
		int dat=0;   
		int val=0,temp=0,val1=0;  
		//System.out.println("in=="+queryarray2); 
		//System.out.println("in=="+queryarray);  
		//System.out.println("in=="+rowarray);  
		ClsnipurchaseorderDAO DAO=new ClsnipurchaseorderDAO();   
			 String name="",mob="",email="";
			 int salid=0,telesales=0;
			 String vndacno="",accname="",rowsno="";
			 String t1="0",t2="0";  
			 ArrayList<String> cparray= new ArrayList<String>();
			 SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");              
			 java.util.Date curDate=new java.util.Date();
		     java.sql.Date cdate=ClsCommon.changeStringtoSqlDate(formatter.format(curDate));
		    
		     ArrayList<String> gridarray=new ArrayList<String>();
			 if(queryarray2.length()>0){
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
						//System.out.println("rowsno=="+rowsno); 
						String strcountdata="select h.description vndacc,h.doc_no vndacno from my_head h inner join my_acbook a on h.cldocno=a.cldocno and a.dtype='VND' and h.atype='AP' where a.cldocno='"+t2+"'";
						//System.out.println("strcountdata--->>>"+strcountdata);                                      
						ResultSet rs=stmt.executeQuery(strcountdata);                          
						while(rs.next()){          
							vndacno=rs.getString("vndacno");
							accname=rs.getString("vndacc");  
						}    
						dat=DAO.insert(cdate,cdate,"","AP",vndacno,accname,"1","1","","","BOOKING NO - "+vocno,session,"A",Double.parseDouble(netamt),gridarray,"NPO",request,0);   	           
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
			} 
			vndacno=""; 
			accname="";    
			//System.out.println("gridarray=="+gridarray); 
			String strcountdata="select h.description vndacc,h.doc_no vndacno from my_head h inner join my_acbook a on h.cldocno=a.cldocno and a.dtype='VND' and h.atype='AP' where a.cldocno='"+t1+"'";
			//System.out.println("strcountdata--->>>"+strcountdata);                                   
			ResultSet rs=stmt.executeQuery(strcountdata);                          
			while(rs.next()){          
				vndacno=rs.getString("vndacno");   
				accname=rs.getString("vndacc");  
			}    
			dat=DAO.insert(cdate,cdate,"","AP",vndacno,accname,"1","1","","","BOOKING NO - "+vocno,session,"A",Double.parseDouble(netamt),gridarray,"NPO",request,0);   	           
			if(dat>0){
				String strupdate="update tr_srtour set xodoc="+dat+" where rowno in("+rowsno+")";    
				//System.out.println("strupdate--->>>"+strupdate);    
				val1=stmt.executeUpdate(strupdate);                           
			} 
			if(val1>0){
				val=1;
			}
			//System.out.println("val--->>>"+val);    
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
