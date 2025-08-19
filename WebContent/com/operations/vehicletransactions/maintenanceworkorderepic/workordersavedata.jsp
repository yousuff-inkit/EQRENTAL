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

<%ClsConnection connDAO=new ClsConnection();
 	String list=request.getParameter("list")==null?"0":request.getParameter("list");
String doc=request.getParameter("doc");
String garrageval=request.getParameter("garrageid");
String sertype=request.getParameter("maintype");
String currrkm=request.getParameter("currkm")==null || request.getParameter("currkm")==""?"0":request.getParameter("currkm");
String nextserdue=request.getParameter("nextserdue")==null|| request.getParameter("nextserdue")=="" ?"0":request.getParameter("nextserdue");
 
 ArrayList<String> mainarray= new ArrayList<String>();
 
 String aa[]=list.split(",");
 
  
 for(int i=0;i<aa.length;i++){
	//System.out.println("----aa-----"+aa[i]);
	 String bb[]=aa[i].split("::");
	
	 String temp="";
	 for(int j=0;j<bb.length;j++){
		//	System.out.println("----bb[j]-----"+bb[j]);	
		
		 temp=temp+bb[j]+"::";
		 
	}
	 
	 
	 mainarray.add(temp);
	// mainarrays.add(mainarray);
 } 
 
	//mainarray.add(list);
	
 
	//System.out.println("----mainarray-----"+mainarray);
		 Connection conn=null;
		    String sql="";
		    try
		    {
		   	
		    conn = connDAO.getMyConnection();
			Statement stmt = conn.createStatement();
	for(int k=0;k<mainarray.size();k++)
	{
			 
			if(k==0)
			{
				 String sqls="delete from  gl_vcostd where rdocno='"+doc+"' ";
		   	    stmt.executeUpdate(sqls); 
		 	   
		 	    String sqlsa="update gl_vmcostm set wostatus=1,gargid='"+garrageval+"',mtype='"+sertype+"',currkm='"+currrkm+"',serduekm='"+nextserdue+"' where doc_no='"+doc+"' ";
			    stmt.executeUpdate(sqlsa);
		   	 
			    int fleetno=0;
			    String mtype="";
			    String sqlselect="select fleetno,mtype from  gl_vmcostm where doc_no='"+doc+"' ";
			    
			   ResultSet rsss= stmt.executeQuery(sqlselect);
			   
			   if(rsss.next())
			   {
				   
				   fleetno=rsss.getInt("fleetno");
				   
				   mtype=rsss.getString("mtype");
				   
			   }
			   
			   if(mtype.equalsIgnoreCase("service")||mtype.equalsIgnoreCase("both"))
			   {
				   String vehupdate="update gl_vehmaster set srvc_km='"+nextserdue+"' where fleet_no='"+fleetno+"'";
				 //  System.out.println("---vehupdate----"+vehupdate);
				    stmt.executeUpdate(vehupdate);
			   }
			}
			
			 
			
			     String[] serarray=mainarray.get(k).split("::");  
			     if(!(serarray[1].trim().equalsIgnoreCase("undefined")|| serarray[1].trim().equalsIgnoreCase("null")|| serarray[1].trim().equalsIgnoreCase("NaN")||serarray[1].trim().equalsIgnoreCase("")|| serarray[1].isEmpty()))
			     {
			     String sql2="INSERT INTO gl_vcostd(rowno,type,repdesc,remarks,labcost,partcost,total,rdocno,status)VALUES"
			  	           + " ("+(k+1)+","
					       + "'"+(serarray[0].trim().equalsIgnoreCase("undefined") || serarray[0].trim().equalsIgnoreCase("null") || serarray[0].trim().equalsIgnoreCase("NaN")||serarray[0].trim().equalsIgnoreCase("")|| serarray[0].isEmpty()?0:serarray[0].trim())+"',"
					       + "'"+(serarray[1].trim().equalsIgnoreCase("undefined") || serarray[1].trim().equalsIgnoreCase("null") || serarray[1].trim().equalsIgnoreCase("NaN")||serarray[1].trim().equalsIgnoreCase("")|| serarray[1].isEmpty()?0:serarray[1].trim())+"',"
					       + "'"+(serarray[2].trim().equalsIgnoreCase("undefined") || serarray[2].trim().equalsIgnoreCase("null")|| serarray[2].trim().equalsIgnoreCase("NaN")||serarray[2].trim().equalsIgnoreCase("")|| serarray[2].isEmpty()?0:serarray[2].trim())+"',"
					       + "'"+(serarray[3].trim().equalsIgnoreCase("undefined") || serarray[3].trim().equalsIgnoreCase("null")|| serarray[3].trim().equalsIgnoreCase("NaN")||serarray[3].trim().equalsIgnoreCase("")|| serarray[3].isEmpty()?0:serarray[3].trim())+"',"
					       + "'"+(serarray[4].trim().equalsIgnoreCase("undefined") || serarray[4].trim().equalsIgnoreCase("null")|| serarray[4].trim().equalsIgnoreCase("NaN")||serarray[4].trim().equalsIgnoreCase("")|| serarray[4].isEmpty()?0:serarray[4].trim())+"',"
					       + "'"+(serarray[5].trim().equalsIgnoreCase("undefined") || serarray[5].trim().equalsIgnoreCase("null")|| serarray[5].trim().equalsIgnoreCase("NaN")||serarray[5].trim().equalsIgnoreCase("")|| serarray[5].isEmpty()?0:serarray[5].trim())+"',"
					       +"'"+doc+"',3)";
	 
			     int resultSet4 = stmt.executeUpdate(sql2);
			     if(resultSet4<=0)
                 {
			    	 
                      
                    }
			     
			} 
			  
				 //stmt.executeUpdate(sql);
				 
				 
					//response.getWriter().print(ivals);  
				 
				
			
			
		    }
	 stmt.close();
	 
		conn.close();
		    
		    }	
		    
		    catch(Exception e)
		    {
		    	e.printStackTrace();
		    	conn.close();
		    } 
%>



