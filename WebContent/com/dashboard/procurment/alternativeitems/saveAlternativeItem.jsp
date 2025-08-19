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
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
String list=request.getParameter("orderarray")==null?"0":request.getParameter("orderarray");
String priority=request.getParameter("priority")==null?"0":request.getParameter("priority"); 
String promdate=request.getParameter("promdate")==null?"0":request.getParameter("promdate"); 
String type=request.getParameter("type")==null?"0":request.getParameter("type");
java.sql.Date sqlprocessdate=null;

if(!(promdate.equalsIgnoreCase("undefined"))&&!(promdate.equalsIgnoreCase(""))&&!(promdate.equalsIgnoreCase("0")))
{
sqlprocessdate=ClsCommon.changeStringtoSqlDate(promdate);
	
}
else{

}
ArrayList<String> pmgntarray= new ArrayList<String>();
String aa[]=list.split(",");
 
	 
 for(int i=0;i<aa.length;i++){
	//System.out.println("----------"+aa[i]);
	 String bb[]=aa[i].split("::");
	  
	 String temp="";
	 for(int j=0;j<bb.length;j++){ 
		 
		// System.out.println("----------"+bb[j]);
		 temp=temp+bb[j]+"::";
		 
	}
	 pmgntarray.add(temp);
	 
}  
 
	  Connection conn=null;
	    String sql="",tempnw="",updatesqls1="";
	    int val=0;
	    try
	    {
	   	
	    conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		for(int k=0;k<pmgntarray.size();k++)
		{
		
         
	 
			String[] pmgntarr=((String) pmgntarray.get(k)).split("::"); 
 
			String rdocno=""+(pmgntarr[0].trim().equalsIgnoreCase("undefined") || pmgntarr[0].trim().equalsIgnoreCase("NaN")|| pmgntarr[0].trim().equalsIgnoreCase("")|| pmgntarr[0].isEmpty()?0:pmgntarr[0].trim())+"";
			String curdoc=""+(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().equalsIgnoreCase("")|| pmgntarr[1].isEmpty()?0:pmgntarr[1].trim())+"";
			String sqltst="INSERT INTO my_pralter(rdocno, altpsrno)VALUES"
					+ " ('"+rdocno+"',"
					+ "'"+curdoc+"')";
System.out.println("=====insertpralter======="+sqltst);
			
			val=stmt.executeUpdate(sqltst);
		}
			
			 
			
			
			
		 
		
		 if(val>0){
			 tempnw="1";
		 }
    stmt.close();
		 
	conn.close();
	 response.getWriter().print(tempnw);
    	
    }
    catch(Exception e)
    {
    	e.printStackTrace();
    	
    	
    	conn.close();
    	 response.getWriter().print(tempnw);
    }
	 	
	 	
	 	
%>



 