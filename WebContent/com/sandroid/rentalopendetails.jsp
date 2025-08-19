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
String value="";
try{
	ClsAndroid and=new ClsAndroid();
	ClsCommon com=new ClsCommon();
//System.out.println("======aa==== ");		
	// ClsAndroid and=new ClsAndroid();
	//String dtype=session.getAttribute("Code").toString();
	Date from=com.changeStringtoSqlDate(request.getParameter("from")); 
	Date to=com.changeStringtoSqlDate(request.getParameter("to")); 
	System.out.println("--from--"+from+":to:"+to);
	
	
			 conn = ClsConnection.getMyConnection();
			Statement stmtVeh = conn.createStatement();
			
			 
			
			if(!(from==null))
			{


           		/* String sql="select r.voc_no,r.brhid,a.refname,t.rate,t.rentaltype from gl_ragmt r left join my_acbook a on r.cldocno=a.cldocno and dtype='CRM' left join gl_rtarif t on r.doc_no=t.rdocno and rstatus=5 where odate>='"+from+"' and odate<='"+to+"' and r.brhid=3;"; */
           		String sql="select r.voc_no,r.brhid,a.refname,t.rate,t.rentaltype from gl_ragmt r left join my_acbook a on r.cldocno=a.cldocno and dtype='CRM' left join gl_rtarif t on r.doc_no=t.rdocno and rstatus=5 where odate>='"+from+"' and odate<='"+to+"';";
          			System.out.println("--opensql--"+sql);
           		ResultSet resultSet = stmtVeh.executeQuery(sql);
           		  RESULTDATA=ClsCommon.convertToJSON(resultSet); 
           		  System.out.println("----"+RESULTDATA);
    				 stmtVeh.close(); 
    				value="1";
    				
           	}
           	
        	conn.close();
}
catch(Exception e){
		e.printStackTrace();
		conn.close();
	}	

response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");
response.getWriter().write(  RESULTDATA.toString()+"::"+value);

 
		
	     




%>



