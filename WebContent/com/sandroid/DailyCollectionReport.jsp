<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="com.common.ClsEncrypt" %>
<%@page import="net.sf.json.JSONObject" %>
<%@page import="net.sf.json.JSONArray" %>
<%@page import="com.connection.*" %>
<%@page import="com.sayaraInternal.*" %>
  
<%
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();
Connection conn=null;
JSONArray RESULTDATA=new JSONArray();
String card="";
String cash="";
String cheque="";
String total="";

try{
	ClsAndroid and=new ClsAndroid();
	ClsCommon com=new ClsCommon();
//System.out.println("======aa==== ");		
	// ClsAndroid and=new ClsAndroid();
	//String dtype=session.getAttribute("Code").toString();
	Date from=com.changeStringtoSqlDate(request.getParameter("from")); 
	Date to=com.changeStringtoSqlDate(request.getParameter("to"));
	String branch=request.getParameter("branch"); 
	System.out.println("======aa==== aa=="+from+"::"+to+"::"+branch);
	
	   	    conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement();
			
			String XSQL="";
			if(branch.equalsIgnoreCase("0")){
				// XSQL=" AND R.BRHID="+fleet;
			}
			else{
				XSQL=" AND R.BRHID='"+branch+"'";
			}
			 
			System.out.println("======xsql==== "+XSQL);
			if(!(from==null))
			{


           		String sql="SELECT coalesce(SUM(CASHTOTAL),0) CASH,coalesce(SUM(CARDTOTAL),0) CARD,coalesce(SUM(CHEQUETOTAL),0) CHEQUE, coalesce(round(sum(netamt),2),0) total FROM ( select if(r.paytype=1,coalesce(round(r.netamt,2),0),0) cashtotal, if(r.paytype=2,coalesce(round(r.netamt,2),0),0) cardtotal, if(r.paytype=3,coalesce(round(r.netamt,2),0),0) chequetotal, coalesce(round(netamt,2),0) netamt from gl_rentreceipt r left join my_jvtran j on r.tr_no=j.tr_no left join my_outd o on j.tranid=o.tranid left join my_jvtran jv on jv.tranid=o.ap_trid left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM' left join gl_ragmt ra on (r.aggno=ra.doc_no and r.rtype='RAG') left join gl_lagmt la on (r.aggno=la.doc_no and r.rtype='LAG') left join my_brch b on r.brhid=b.branch left join my_brch br on r.ibbrchid=br.branch where r.date>='"+from+"' and r.date<='"+to+"' and r.status=3 "+XSQL+" group by r.srno ) A ;";
           		
          			System.out.println("----"+sql);
           		ResultSet resultSet = stmtVeh.executeQuery(sql);
           		/*  RESULTDATA=ClsCommon.convertToJSON(resultSet); */
    				/* stmtVeh.close(); */
    				while(resultSet.next()){
    	 				//fleet=resultSet.getString("fleet");
    	    			card=resultSet.getString("CARD");
    	    			cash=resultSet.getString("CASH");
    	    			cheque=resultSet.getString("CHEQUE");
    	    			total=resultSet.getString("total");
    	 			}
    				System.out.println("card:"+card+"::cash:"+cash+"::cheque:"+cheque+"::total:"+total);
           	}
			
           	
        	conn.close();
}
catch(Exception e){
		e.printStackTrace();
		conn.close();
	}	

response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");
response.getWriter().write( card.toString()+"::"+cash.toString()+"::"+cheque.toString()+"::"+total.toString());

 
		
	     




%>



