<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>   
<%	
ClsConnection ClsConnection=new ClsConnection();  
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;
    
	try{
	 	conn = ClsConnection.getMyConnection();       
		Statement stmt = conn.createStatement();    
		String docno=request.getParameter("docno")=="" || request.getParameter("docno")==null?"0":request.getParameter("docno");
		String type=request.getParameter("type")=="" || request.getParameter("type")==null?"0":request.getParameter("type");
		String cnfcheck=request.getParameter("cnfcheck")=="" || request.getParameter("cnfcheck")==null?"0":request.getParameter("cnfcheck");
		String cndate=request.getParameter("cndate")=="" || request.getParameter("cndate")==null?"0":request.getParameter("cndate");
		String cntime=request.getParameter("cntime")=="" || request.getParameter("cntime")==null?"0":request.getParameter("cntime");
		String confno=request.getParameter("txtconfno")=="" || request.getParameter("txtconfno")==null?"0":request.getParameter("txtconfno");
		String cnfdesc=request.getParameter("txtcnfdesc")==null?"":request.getParameter("txtcnfdesc");
		String queryarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray").toString();
		int val=0;  
		String strcountdata="";
		java.sql.Date sqldate=null;
		if(!(cndate.equalsIgnoreCase("undefined"))&&!(cndate.equalsIgnoreCase(""))&&!(cndate.equalsIgnoreCase("0")))
		{
			 sqldate=ClsCommon.changeStringtoSqlDate(cndate);     
		}
		//System.out.println(queryarray+"=cnfcheck--->>>"+cnfcheck);   
		   if(cnfcheck.equalsIgnoreCase("HOTEL")){ 
			   if(type.equalsIgnoreCase("Service Request")){     
				   strcountdata="update tr_srhotel set confrmtime='"+cntime+"',confrmdate='"+sqldate+"',confrmno='"+confno+"',confrmremarks='"+cnfdesc+"' where rowno in("+queryarray.substring(0, queryarray.length()-1)+")";
				   //System.out.println("strcountdata--->>>"+strcountdata);                                                         
				   val=stmt.executeUpdate(strcountdata); 
			   }else if(type.equalsIgnoreCase("Hotel Booking")){
				   strcountdata="update tr_bookingd set confrmtime='"+cntime+"',confrmdate='"+sqldate+"',confrmno='"+confno+"',confrmremarks='"+cnfdesc+"' where rowno in("+queryarray.substring(0, queryarray.length()-1)+")";
				   //System.out.println("strcountdata--->>>"+strcountdata);                                                         
				   val=stmt.executeUpdate(strcountdata);  
			   }
			}else if(cnfcheck.equalsIgnoreCase("TOUR")){  
				 strcountdata="update tr_srtour set confrmtime='"+cntime+"',confrmdate='"+sqldate+"',confrmno='"+confno+"',confrmremarks='"+cnfdesc+"' where rowno in("+queryarray.substring(0, queryarray.length()-1)+")";
				 //System.out.println("strcountdata--->>>"+strcountdata);                                                         
				 val=stmt.executeUpdate(strcountdata);  
			}else if(cnfcheck.equalsIgnoreCase("TRANSFER")){  
				 strcountdata="update TR_srtransfer set confrmtime='"+cntime+"',confrmdate='"+sqldate+"',confrmno='"+confno+"',confrmremarks='"+cnfdesc+"' where rowno in("+queryarray.substring(0, queryarray.length()-1)+")";
			     //System.out.println("strcountdata--->>>"+strcountdata);                                                         
				 val=stmt.executeUpdate(strcountdata);
			}else if(cnfcheck.equalsIgnoreCase("VISA")){     
				 strcountdata="update TR_srvisa set confrmtime='"+cntime+"',confrmdate='"+sqldate+"',confrmno='"+confno+"',confrmremarks='"+cnfdesc+"' where rowno in("+queryarray.substring(0, queryarray.length()-1)+")";
				//System.out.println("strcountdata--->>>"+strcountdata);                                                         
				 val=stmt.executeUpdate(strcountdata);
			}else if(cnfcheck.equalsIgnoreCase("SERVICE")){  
				 strcountdata="update tr_servicereqd set confrmtime='"+cntime+"',confrmdate='"+sqldate+"',confrmno='"+confno+"',confrmremarks='"+cnfdesc+"' where rowno in("+queryarray+")";        
				 //System.out.println("strcountdata--->>>"+strcountdata);                                                         
				 val=stmt.executeUpdate(strcountdata);
			}else if(cnfcheck.equalsIgnoreCase("TICKET")){              
				 strcountdata="update TR_srticket set confrmtime='"+cntime+"',confrmdate='"+sqldate+"',confrmno='"+confno+"',confrmremarks='"+cnfdesc+"' where rowno in("+queryarray.substring(0, queryarray.length()-1)+")";
				 //System.out.println("strcountdata--->>>"+strcountdata);                                                         
				 val=stmt.executeUpdate(strcountdata);
			} 
		   if(val>0){  
				String statusupdate="update TR_SERVICEREQM set cstatus=2 where doc_no='"+docno+"'";         
				//System.out.println("statusupdate--->>>"+statusupdate);                   
				int temp1=stmt.executeUpdate(statusupdate);       
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
