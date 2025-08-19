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
String queryarray=request.getParameter("gridarray")==null || request.getParameter("gridarray").trim().equalsIgnoreCase("")?"":request.getParameter("gridarray").toString();
int hotelid=request.getParameter("hotelid")==null || request.getParameter("hotelid")==""?0:Integer.parseInt(request.getParameter("hotelid"));
int vendorid=request.getParameter("vendorid")==null || request.getParameter("vendorid")==""?0:Integer.parseInt(request.getParameter("vendorid"));
String fdate,tdate;   
	try{
		String sql=null;
		int val=0;
	 	conn=ClsConnection.getMyConnection();  
		CallableStatement stmt2=null;
		CallableStatement stmt3=null;  
		CallableStatement stmt4=null;
		CallableStatement stmt5=null;   
		ArrayList<String> gridarray=new ArrayList<String>();
		 if(queryarray.length()>0){
			String temparray[]=queryarray.split(",");
			for(int i=0;i<temparray.length;i++){
				gridarray.add(temparray[i]);
			}            
		}
		 
		 //System.out.println("in.............."+countarray);      
	   //System.out.println("gridarray=="+gridarray);
				//Statement stmt4 = conn.createStatement ();  
				 //System.out.println("in=="+docno);
					for(int i=0;i< gridarray.size();i++){     
						String[] gridarraydet=((String) gridarray.get(i)).split("::");          
						//System.out.println("in==insert");  
						java.sql.Date stdt=(gridarraydet[4].trim().equalsIgnoreCase("undefined") || gridarraydet[4].trim().equalsIgnoreCase("NaN")|| gridarraydet[4].trim().equalsIgnoreCase("")|| gridarraydet[4].isEmpty()?null:ClsCommon.changetstmptoSqlDate(gridarraydet[4].trim()));
						//System.out.println("fdate=="+stdt); 
						java.sql.Date endt=(gridarraydet[5].trim().equalsIgnoreCase("undefined") || gridarraydet[5].trim().equalsIgnoreCase("NaN")|| gridarraydet[5].trim().equalsIgnoreCase("")|| gridarraydet[5].isEmpty()?null:ClsCommon.changetstmptoSqlDate(gridarraydet[5].trim()));							
						//System.out.println("tdate=="+endt);
						int srno=gridarraydet[9].trim().equalsIgnoreCase("undefined") || gridarraydet[9].trim().equalsIgnoreCase("NaN")|| gridarraydet[9].trim().equalsIgnoreCase("")|| gridarraydet[9].isEmpty()?0:Integer.parseInt(gridarraydet[9].trim()); 
						//System.out.println("docno======"+srno);
						int rid=gridarraydet[0].trim().equalsIgnoreCase("undefined") || gridarraydet[0].trim().equalsIgnoreCase("NaN")|| gridarraydet[0].trim().equalsIgnoreCase("")|| gridarraydet[0].isEmpty()?0:Integer.parseInt(gridarraydet[0].trim());
						
						if(srno>0){    
							//System.out.println("in edit");    
							stmt3 = conn.prepareCall("update tr_prhotelOFFER set roomid=?,  code=?, name=?, description=?, fdate=?, tdate=?, appliedon=?, per=?, amount=?, userid=?, status=?, hotelid=?, vendorid=? where doc_no='"+srno+"'");         
							stmt3.setInt(1,(gridarraydet[0].trim().equalsIgnoreCase("undefined") || gridarraydet[0].trim().equalsIgnoreCase("NaN")|| gridarraydet[0].trim().equalsIgnoreCase("")|| gridarraydet[0].isEmpty()?0:Integer.parseInt(gridarraydet[0].trim())));    
							stmt3.setString(2,(gridarraydet[1].trim().equalsIgnoreCase("undefined") || gridarraydet[1].trim().equalsIgnoreCase("NaN")|| gridarraydet[1].trim().equalsIgnoreCase("")|| gridarraydet[1].isEmpty()?"0":gridarraydet[1].trim()));    
							stmt3.setString(3,(gridarraydet[2].trim().equalsIgnoreCase("undefined") || gridarraydet[2].trim().equalsIgnoreCase("NaN")|| gridarraydet[2].trim().equalsIgnoreCase("")|| gridarraydet[2].isEmpty()?"0":gridarraydet[2].trim()));
							stmt3.setString(4,(gridarraydet[3].trim().equalsIgnoreCase("undefined") || gridarraydet[3].trim().equalsIgnoreCase("NaN")|| gridarraydet[3].trim().equalsIgnoreCase("")|| gridarraydet[3].isEmpty()?"0":gridarraydet[3].trim()));
							stmt3.setDate(5,stdt);
							stmt3.setDate(6,endt);
							stmt3.setString(7,(gridarraydet[6].trim().equalsIgnoreCase("undefined") || gridarraydet[6].trim().equalsIgnoreCase("NaN")|| gridarraydet[6].trim().equalsIgnoreCase("")|| gridarraydet[6].isEmpty()?"0":gridarraydet[6].trim()));
							stmt3.setString(8,(gridarraydet[7].trim().equalsIgnoreCase("undefined") || gridarraydet[7].trim().equalsIgnoreCase("NaN")|| gridarraydet[7].trim().equalsIgnoreCase("")|| gridarraydet[7].isEmpty()?"0":gridarraydet[7].trim()));
							stmt3.setString(9,(gridarraydet[8].trim().equalsIgnoreCase("undefined") || gridarraydet[8].trim().equalsIgnoreCase("NaN")|| gridarraydet[8].trim().equalsIgnoreCase("")|| gridarraydet[8].isEmpty()?"0":gridarraydet[8].trim()));
							stmt3.setString(10,session.getAttribute("USERID").toString());
							stmt3.setInt(11,3);
							stmt3.setInt(12,hotelid);
							stmt3.setInt(13,vendorid);
							   
							//System.out.println("stmt3"+stmt3);                         
							val = stmt3.executeUpdate();  
							//System.out.println("val==="+val);    
						}else{   
							//System.out.println("in insert"); 
							stmt2 = conn.prepareCall("insert into tr_prhotelOFFER(roomid,  code, name, description, fdate, tdate, appliedon, per, amount, userid, status, hotelid, vendorid) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");         
							stmt2.setInt(1,(gridarraydet[0].trim().equalsIgnoreCase("undefined") || gridarraydet[0].trim().equalsIgnoreCase("NaN")|| gridarraydet[0].trim().equalsIgnoreCase("")|| gridarraydet[0].isEmpty()?0:Integer.parseInt(gridarraydet[0].trim())));    
							stmt2.setString(2,(gridarraydet[1].trim().equalsIgnoreCase("undefined") || gridarraydet[1].trim().equalsIgnoreCase("NaN")|| gridarraydet[1].trim().equalsIgnoreCase("")|| gridarraydet[1].isEmpty()?"0":gridarraydet[1].trim()));    
							stmt2.setString(3,(gridarraydet[2].trim().equalsIgnoreCase("undefined") || gridarraydet[2].trim().equalsIgnoreCase("NaN")|| gridarraydet[2].trim().equalsIgnoreCase("")|| gridarraydet[2].isEmpty()?"0":gridarraydet[2].trim()));
							stmt2.setString(4,(gridarraydet[3].trim().equalsIgnoreCase("undefined") || gridarraydet[3].trim().equalsIgnoreCase("NaN")|| gridarraydet[3].trim().equalsIgnoreCase("")|| gridarraydet[3].isEmpty()?"0":gridarraydet[3].trim()));
							stmt2.setDate(5,stdt);
							stmt2.setDate(6,endt);							
							stmt2.setString(7,(gridarraydet[6].trim().equalsIgnoreCase("undefined") || gridarraydet[6].trim().equalsIgnoreCase("NaN")|| gridarraydet[6].trim().equalsIgnoreCase("")|| gridarraydet[6].isEmpty()?"0":gridarraydet[6].trim()));
							stmt2.setString(8,(gridarraydet[7].trim().equalsIgnoreCase("undefined") || gridarraydet[7].trim().equalsIgnoreCase("NaN")|| gridarraydet[7].trim().equalsIgnoreCase("")|| gridarraydet[7].isEmpty()?"0":gridarraydet[7].trim()));
							stmt2.setString(9,(gridarraydet[8].trim().equalsIgnoreCase("undefined") || gridarraydet[8].trim().equalsIgnoreCase("NaN")|| gridarraydet[8].trim().equalsIgnoreCase("")|| gridarraydet[8].isEmpty()?"0":gridarraydet[8].trim()));
							stmt2.setString(10,session.getAttribute("USERID").toString());
							stmt2.setInt(11,3);
							stmt2.setInt(12,hotelid);
							stmt2.setInt(13,vendorid);
							
							val = stmt2.executeUpdate();
						}
						
				}
					 
			  	if(val<=0){             
			  		stmt2.close();
			  		stmt3.close();
			  		stmt4.close();
			  		stmt5.close();
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
