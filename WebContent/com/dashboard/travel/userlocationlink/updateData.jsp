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
<%	
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn=null;
String queryarray=request.getParameter("gridarray")==null || request.getParameter("gridarray").trim().equalsIgnoreCase("")?"0":request.getParameter("gridarray").toString();
int docno=request.getParameter("docno")==null || request.getParameter("docno")==""?0:Integer.parseInt(request.getParameter("docno"));   

	try{
		String sql=null;
		int val=0;
	 	conn=ClsConnection.getMyConnection();  
		CallableStatement stmt2=null;
		
		ArrayList<String> gridarray=new ArrayList<String>();
		 if(queryarray.length()>0){
			String temparray[]=queryarray.split(",");
			for(int i=0;i<temparray.length;i++){
				gridarray.add(temparray[i]);
			}            
		}  
	   //System.out.println("gridarray=="+gridarray);
			Statement stmt3 = conn.createStatement ();  
				 //System.out.println("in=="+docno);
					for(int i=0;i< gridarray.size();i++){     
						String[] gridarraydet=((String) gridarray.get(i)).split("::");  
						//System.out.println("in==insert===");   
						String srno=(gridarraydet[2].trim().equalsIgnoreCase("undefined") || gridarraydet[2].trim().equalsIgnoreCase("NaN")|| gridarraydet[2].trim().equalsIgnoreCase("")|| gridarraydet[2].isEmpty()?0:gridarraydet[2].trim()).toString(); 
						String rid=(gridarraydet[0].trim().equalsIgnoreCase("undefined") || gridarraydet[0].trim().equalsIgnoreCase("NaN")|| gridarraydet[0].trim().equalsIgnoreCase("")|| gridarraydet[0].isEmpty()?"false":gridarraydet[0].trim()).toString();
						//System.out.println("in==insert==="+rid);
						  int chks=Integer.parseInt(srno);
						  //System.out.println("in==chks==="+chks);
						if(chks>0){ 
							//System.out.println("in edit==="+rid);
							if(rid.equalsIgnoreCase("false")){
								 String dlt="delete from tr_userloclink where rowno="+chks+" and userid="+docno+"";		      
					    		 //System.out.println("indelete=="+dlt);
								     val = stmt3.executeUpdate(dlt);
								     //System.out.println("indeleteval=="+val);
							}else{
								
							}
						}else{   
							//System.out.println("in insert======"+rid); 
							if(rid.equalsIgnoreCase("true")){
							stmt2 = conn.prepareCall("insert into tr_userloclink(userid, locid) values(?, ?)");
						 	stmt2.setInt(1,docno);         
							stmt2.setInt(2,(gridarraydet[1].trim().equalsIgnoreCase("undefined") || gridarraydet[1].trim().equalsIgnoreCase("NaN")|| gridarraydet[1].trim().equalsIgnoreCase("")|| gridarraydet[1].isEmpty()?0:Integer.parseInt(gridarraydet[1].trim())));  
							
							//System.out.println("stmt2======"+stmt2); 
							val = stmt2.executeUpdate();
							}
						}
						
						
				}
			  	if(val<=0){  
			  		stmt2.close();
			        conn.close();
			      }
		response.getWriter().print(val);     
	 	conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   } finally{
	   conn.close();
   }

%>
