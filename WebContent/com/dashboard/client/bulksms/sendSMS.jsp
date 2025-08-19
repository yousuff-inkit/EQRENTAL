<%@page import="com.common.ClsCommon"%>
<%@page import="com.dashboard.client.bulksms.ClsBulkSMSDAO"%>         
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
<%@page import="java.io.*" %>
<%@page import="org.apache.struts2.ServletActionContext" %>
<%
    int val=0;
	ClsConnection objconn=new ClsConnection();  
	ClsCommon ClsCommon=new ClsCommon();
	Connection conn=null;            
	try{
		conn=objconn.getMyConnection();
	    Statement stmt=conn.createStatement(); 
		String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
		String message=request.getParameter("message")==null?"":request.getParameter("message");
		String docarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");
		String dtype="CRM",mob="",cldocno="",refname="",result="";        
		//System.out.println(docarray+"==docarray======message=="+message);
		ClsBulkSMSDAO DAO=new ClsBulkSMSDAO();      
		String sql="select coalesce(per_mob,'') mob,coalesce(cldocno,'') cldocno,coalesce(refname,'') refname from my_acbook where cldocno in("+docarray.substring(0, docarray.length()-1)+") and (per_mob is not null or per_mob!='')";                
		//System.out.println("sql=================="+sql);                       
		ResultSet rs=stmt.executeQuery(sql);             
		while(rs.next()){
			mob=rs.getString("mob");
			cldocno=rs.getString("cldocno");
			refname=rs.getString("refname");
			result=DAO.sendSMS(cldocno, branch, dtype, mob, refname, message, conn); 
			mob="";
		    cldocno="";   
			refname="";    
		}       
		if(result.equalsIgnoreCase("success")){
			val=1;     
		}
	    response.getWriter().print(val);                              
	}catch(Exception e){
	 	e.printStackTrace();	
   }
%>