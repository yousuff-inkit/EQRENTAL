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
String msg="",rowno="";
	try{
 //System.out.println("======aa==== ");		
		/* ClsAndroid and=new ClsAndroid(); */
		ClsConnection  ClsConnection =new ClsConnection();
		 ClsCommon   ClsCommon =new ClsCommon();
		String regno=request.getParameter("reg_no")==null?"0":request.getParameter("reg_no"); 
		String startkm=request.getParameter("startkm"); 
		String startdate=request.getParameter("startdate"); 
		String starttime=request.getParameter("starttime"); 
		String vehname=request.getParameter("vehname");
		String dname=request.getParameter("dname");
		String city=request.getParameter("city");
		String userid=request.getParameter("userid");
		String jobno=request.getParameter("jobno")==""?"0":request.getParameter("jobno").trim();
		String bookdocno=jobno.split("-")[0];
		String jobname=jobno.split("-")[1];
// 		System.out.println("======aa==== "+fleet+":"+regno+":"+mode+":"+del_KM+":"+de_Fuel+":"+deldateOut+":"+deltimeOut);
		
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		ClsCommon comm = new ClsCommon();
		
		 int val=0;
		 int aa=0;


	
		 
		 int chkupdate=0;
		 int delstatus=0;
		 java.sql.Date sqloutdate=null;
		 
		 String outtime="",XSQL="";
		 double outkm=0;

		CallableStatement stmtUpdaterent = null;
		Statement stmt=conn.createStatement();
			
	  			java.sql.Date sqlstartdate=ClsCommon.changeStringtoSqlDate(startdate);

	    		String sql="insert into an_starttripdet( userid,regno, vehname, drivername, location, startkm, startdate, starttime) values ("+userid+",'"+regno+"','"+vehname+"','"+dname+"','"+city+"',"+startkm+",'"+sqlstartdate+"','"+starttime+"')";
	    		System.out.println("sql=="+sql);
	    		val=stmt.executeUpdate(sql);
				if(val>0){
					msg="1";
					String sql2="update gl_limomanagement set bstatus=6 where docno="+bookdocno+" and job='"+jobname+"'";
					stmt.executeUpdate(sql2);
					conn.commit();
					String sqls="select max(rowno) rowno from an_starttripdet";	
					ResultSet rs=stmt.executeQuery(sqls);
					while(rs.next()){
						rowno=rs.getString("rowno");
					}
					
				}
				
			
		
	}
	catch(Exception e){
		
		conn.close();
	 	e.printStackTrace();
	 	 
	}
	response.getWriter().write(msg+"::"+rowno);
	System.out.println("msg=="+msg);
	
  %>
  
