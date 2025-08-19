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
	
Connection conn=null;
String msg="",rowno="",value="";
	try{
 System.out.println("======in maxdata==== ");		
		/* ClsAndroid and=new ClsAndroid(); */
		ClsConnection  ClsConnection =new ClsConnection();
		 ClsCommon   ClsCommon =new ClsCommon();
		String fleet=request.getParameter("fleet")==null?"0":request.getParameter("fleet").trim(); 
		System.out.println("======in maxdata fleet==== "+fleet);
		
		
// 		System.out.println("======aa==== "+fleet+":"+regno+":"+mode+":"+del_KM+":"+de_Fuel+":"+deldateOut+":"+deltimeOut);
		
		conn=ClsConnection.getMyConnection();
		ClsCommon comm = new ClsCommon();
		
		 int val=0;
		 int aa=0;


	
		 
		 int chkupdate=0;
		 int delstatus=0;
		 java.sql.Date sqloutdate=null;
		 
		 String outtime="",XSQL="",sqls="",sqls1="";
		 double outkm=0;

		CallableStatement stmtUpdaterent = null;
		Statement stmt=conn.createStatement();
			
	  			
               
	    		if(!(fleet.equalsIgnoreCase("0") || fleet.equalsIgnoreCase("undefined") || fleet.equalsIgnoreCase(null))){
					 sqls="select coalesce(max(endkm),0)ekm,coalesce(max(date_format(enddate,'%d.%m.%Y')),0)edate from an_starttripdet where fleet="+fleet;	
					System.out.println("======maxdata fetch==== "+sqls);
					ResultSet rs=stmt.executeQuery(sqls);
					while(rs.next()){
						value+=rs.getString("ekm")+"::"+rs.getString("edate");	
					}
					sqls1="select coalesce(max(endtime),0)etime from an_starttripdet where startdate=curdate() and fleet="+fleet;
					ResultSet rs1=stmt.executeQuery(sqls1);
					while(rs1.next()){
						value+="::"+rs1.getString("etime");	
					}
					System.out.println("======value fetch==== "+value);
	    		}
					
				
				
			
		
	}
	catch(Exception e){
		
		conn.close();
	 	e.printStackTrace();
	 	 
	}
	response.getWriter().write(value);
// 	System.out.println("msg=="+msg);
	
  %>
  
