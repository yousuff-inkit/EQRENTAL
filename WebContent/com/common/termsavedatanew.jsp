<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>   
<%@page import="net.sf.json.JSONObject"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>  

<%
	 ClsConnection ClsConnection=new ClsConnection();
	 String jsobject=request.getParameter("myarray")==null?"0":request.getParameter("myarray");   
	 String chk=request.getParameter("chk")==null?"NA":request.getParameter("chk");
	 String docno=request.getParameter("docno").toString();
	 String formcode=request.getParameter("dtype").toString();
	 String brhid=request.getParameter("brhid").toString();
	 System.out.println("jsobject===="+jsobject);  

     Connection conn=null;
     String sql="";
	 try{
	   	
	    conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement(); 
		   
  	    if(chk.equalsIgnoreCase("0")){
				String termsql="delete from my_trterms where rdocno='"+docno+"' and brhid='"+brhid+"' and dtype='"+formcode+"'";
		        //System.out.println("===termsql===="+termsql);
				Statement stnmt1=conn.createStatement(); 
				stnmt1.executeUpdate (termsql);
		 }  
	  	 JSONObject json = JSONObject.fromObject(jsobject);   
		 JSONArray jsonArray = json.getJSONArray("termsandconditions");  
	     for (int i = 0; i < jsonArray.size(); i++) {    
	            JSONObject jsobj = jsonArray.getJSONObject(i);  
	            System.out.println("conditions :"+jsobj.getString("conditions").toString());   
	            
	            PreparedStatement prestmt = conn.prepareStatement("insert into my_trterms(rdocno, termsid, conditions,priorno, status,brhid, dtype)VALUES(?,?,?,?,?,?,?)");
	             
	            prestmt.setString(1, docno);
	            prestmt.setString(2, jsobj.getString("vocno").equalsIgnoreCase("undefined") || jsobj.getString("vocno").equalsIgnoreCase("") || jsobj.getString("vocno").trim().equalsIgnoreCase("NaN")|| jsobj.getString("vocno").isEmpty()?"0":jsobj.getString("vocno").trim());
	            prestmt.setString(3, jsobj.getString("conditions").equalsIgnoreCase("undefined") || jsobj.getString("conditions").equalsIgnoreCase("") || jsobj.getString("conditions").trim().equalsIgnoreCase("NaN")|| jsobj.getString("conditions").isEmpty()?"":jsobj.getString("conditions").trim());
	            prestmt.setString(4, jsobj.getString("priorno").equalsIgnoreCase("undefined") || jsobj.getString("priorno").equalsIgnoreCase("") || jsobj.getString("priorno").trim().equalsIgnoreCase("NaN")|| jsobj.getString("priorno").isEmpty()?"0":jsobj.getString("priorno").trim());
	            prestmt.setInt(5, 3);
	            prestmt.setString(6, brhid);
	            prestmt.setString(7, formcode);   
	            prestmt.executeUpdate();       
	     } 
         stmt.close();
	     conn.close();
	     response.getWriter().print(1);
    	
    }catch(Exception e){
    	e.printStackTrace();
    	conn.close();
    	response.getWriter().print(2);
    }
%> 