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
 
     String list=request.getParameter("list")==null?"0":request.getParameter("list");

 ClsConnection ClsConnection=new ClsConnection();
//System.out.println("-----list-------"+list);
     
    String branch=request.getParameter("branch")==null?"0":request.getParameter("branch");
    String location=request.getParameter("location")==null?"0":request.getParameter("location");
    String mode=request.getParameter("mode")==null?"0":request.getParameter("mode");
    
    String dtype=request.getParameter("dtype")==null?"0":request.getParameter("dtype");
    
    
    
     String aa[]=list.split(",");

 	ArrayList<String> mainarray= new ArrayList<String>();
 	 
 for(int i=0;i<aa.length;i++){
 	 
 	 String bb[]=aa[i].split("::");
 
 	 String temp="";
 	 for(int j=0;j<bb.length;j++){ 
 		 temp=temp+bb[j]+"::";
 		 
 	}
 //	System.out.println("-----temp-------"+temp);
 	 
 	 mainarray.add(temp);
 	 
 } 
    Connection conn=null;
    String sql="";
    
    String temp1="";
    String temp2="";
    double acqty=0;
    try
    {
   	
    conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();
	
	int calcu=0;
	String part_no="";
	  int mm=0;
	loop:for(int k=0;k<mainarray.size();k++)
	{
	
	      
	  
	  String[] serarray=mainarray.get(k).split("::");  
		//System.out.println("----serarray[0]--------"+serarray[0]);
	     
	     String  prdids=""+(serarray[0].trim().equalsIgnoreCase("undefined") || serarray[0].trim().equalsIgnoreCase("NaN")|| serarray[0].trim().equalsIgnoreCase("")|| serarray[0].isEmpty()?0:serarray[0].trim())+"";
	        
	//  String prdids=""+serarray[0].equalsIgnoreCase("undefined") || serarray[0].equalsIgnoreCase("") || serarray[0].trim().equalsIgnoreCase("NaN")|| serarray[0].isEmpty()+"";						 
	  String specnos=""+(serarray[1].equalsIgnoreCase("undefined") || serarray[1].equalsIgnoreCase("") || serarray[1].trim().equalsIgnoreCase("NaN")|| serarray[1].isEmpty()?0:serarray[1].trim())+"";
	  String qtys=""+(serarray[2].equalsIgnoreCase("undefined") || serarray[2].equalsIgnoreCase("") || serarray[2].trim().equalsIgnoreCase("NaN")|| serarray[2].isEmpty()?0:serarray[2].trim())+"";
	  String oldqty=""+(serarray[3].equalsIgnoreCase("undefined") || serarray[3].equalsIgnoreCase("") || serarray[3].trim().equalsIgnoreCase("NaN")|| serarray[3].isEmpty()?0:serarray[3].trim())+"";
	  String belqty=""+(serarray[4].equalsIgnoreCase("undefined") || serarray[4].equalsIgnoreCase("") || serarray[4].trim().equalsIgnoreCase("NaN")|| serarray[4].isEmpty()?0:serarray[4].trim())+"";
		
	//  list.push(rows[i].psrno+"::"+rows[i].specid+"::"+rows[i].qty+"::"+rows[i].unitdocno+"::"+rows[i].oldqty);
	//  System.out.println("----prdids--------"+prdids);	
	//	System.out.println("----specnos--------"+specnos);
	//	System.out.println("----qtys--------"+qtys);
	 int prdid=Integer.parseInt(prdids);
	 int specno=Integer.parseInt(specnos);
	 double qty=Double.parseDouble(qtys);
	 double balqty=Double.parseDouble(belqty);
	 
	
	 

	 
	 String sqlss="";
	//    System.out.println("----dtype--------"+dtype); 
	 if(dtype.equalsIgnoreCase("PIV"))
	 {
		 sqlss= " and locid= '"+location+"' " ;
	 }
	 
	 if(mode.equalsIgnoreCase("A"))
	 {
		 sql="select (sum(op_qty)-sum(out_qty+rsv_qty+del_qty)) acqty from my_prddin where brhid='"+branch+"'   and specno='"+specno+"' and prdid='"+prdid+"'  "+sqlss+"  "; 
	 }
	 else
	 {
		 sql="select (sum(op_qty)-sum(out_qty+rsv_qty+del_qty))+"+oldqty+" acqty from my_prddin where brhid='"+branch+"'   and specno='"+specno+"' and prdid='"+prdid+"' "+sqlss+"    ";
	 }
	          
	        
	   System.out.println("----sql--------"+sql);  
	           
	           ResultSet rss=  stmt.executeQuery(sql); 
	        	if(rss.next())
	        	{
	        		acqty=rss.getDouble("acqty");	
	        		calcu=calcu+1; // array size chk 
	         
	        		
	        		
	        	}
	          //  System.out.println("----acqty--------"+acqty);  
	        	if(qty>acqty)
	        	{
	        		mm=1;
	        		String sqls="select  part_no from my_main where psrno='"+prdid+"' ";
	        		ResultSet rsd=stmt.executeQuery(sqls);
	        		
	        		if(rsd.next())
	        		{
	        			
	        			part_no=rsd.getString("part_no");
	        			
	        		}
	        		
	        		
	        		
	        		break loop;
	        		
	        	/* 	
	        		temp1=temp1+prdid+",";
	        		temp2=temp2+acqty+",";	 */	
	        		
	        	}
	        	 
	        	
	        		 
		
      }
	 stmt.close();
	 
  //   System.out.println("----temp1--------"+temp1); 
     
     
    // System.out.println("----temp2--------"+temp2); 
	 if(mm==1)
	 {
		 response.getWriter().write("Only "+acqty+" quantity can be returned for this Product : "+part_no);
	 }
	 else
	 {
		 response.getWriter().write("0");
	 }
	
		conn.close();
    	
    }
    catch(Exception e)
    {
    	 response.getWriter().write("nodata");
    	e.printStackTrace();
    	conn.close();
    }
	 	
	 	
	 	
%>
