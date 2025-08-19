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
String pcat=request.getParameter("pcat")=="" || request.getParameter("pcat")==null?"0":request.getParameter("pcat");   
String nation=request.getParameter("nation")=="" || request.getParameter("nation")==null?"0":request.getParameter("nation");   
String nationid=request.getParameter("nationid")=="" || request.getParameter("nationid")==null?"0":request.getParameter("nationid");         
int release=request.getParameter("release")==null || request.getParameter("release")==""?0:Integer.parseInt(request.getParameter("release"));   
String type=request.getParameter("type")=="" || request.getParameter("type")==null?"":request.getParameter("type");
String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks");
String fdate=request.getParameter("fdate")=="" || request.getParameter("fdate")==null?"0":request.getParameter("fdate");
String tdate=request.getParameter("tdate")=="" || request.getParameter("tdate")==null?"0":request.getParameter("tdate");   
int docno=request.getParameter("docno")==null || request.getParameter("docno")==""?0:Integer.parseInt(request.getParameter("docno"));   
String pcatid=request.getParameter("pcatid")==null || request.getParameter("pcatid")==""?"0":request.getParameter("pcatid");   
int hotel=request.getParameter("hotel")==null || request.getParameter("hotel")==""?0:Integer.parseInt(request.getParameter("hotel"));   
int vendor=request.getParameter("vendor")==null || request.getParameter("vendor")==""?0:Integer.parseInt(request.getParameter("vendor"));   

	try{   
		String sql=null;   
		int val=0;
	 	conn=ClsConnection.getMyConnection();
		CallableStatement stmt2=null;
		CallableStatement stmt3=null;   
		
	   //System.out.println("newarray=="+newarray);
	        java.sql.Date stdt=null;
	        java.sql.Date endt=null;   
				Statement stmt4 = conn.createStatement ();  
				  // System.out.println(nationid+"=in="+nation);  
				 if(docno>0){
					    //System.out.println("in==Edit"+pcatid);  
					 	stdt=ClsCommon.changeStringtoSqlDate(fdate);
					 	endt=ClsCommon.changeStringtoSqlDate(tdate); 
						String strsql1="update tr_prhotelm set fdate='"+stdt+"', tdate='"+endt+"', pcatid='"+pcatid+"', remarks='"+remarks+"',taxtype='"+type+"', nation='"+nation+"', nationid='"+nationid+"', releaseno="+release+", pcategory='"+pcat+"' where doc_no="+docno+"";
						//System.out.println("update--->>>"+strsql1);          
						val=stmt4.executeUpdate(strsql1);        
					 	}else{
						//System.out.println("in==insert");  
						stmt2 = conn.prepareCall("insert into tr_prhotelm(hotelid, vendorid, fdate, tdate, pcatid, remarks, taxtype, nation, nationid, releaseno, pcategory) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
					 	stdt=ClsCommon.changeStringtoSqlDate(fdate);
					 	endt=ClsCommon.changeStringtoSqlDate(tdate);              				
					 	stmt2.setInt(1,hotel);         
						stmt2.setInt(2,vendor);
						stmt2.setDate(3,stdt);   
						stmt2.setDate(4,endt); 
						stmt2.setString(5,pcatid);        
						stmt2.setString(6,remarks);
						stmt2.setString(7,type); 
						stmt2.setString(8,nation); 
						stmt2.setString(9,nationid); 
						stmt2.setInt(10,release);         
						stmt2.setString(11,pcat);   
						//System.out.println("stmt2"+stmt2); 
						val = stmt2.executeUpdate();
				}   
			  	if(val<=0){  
			  		stmt4.close();
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
