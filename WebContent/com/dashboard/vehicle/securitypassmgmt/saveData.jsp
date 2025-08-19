
<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%	
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon(); 

String docno = request.getParameter("docno")==null?"":request.getParameter("docno").trim();
String userid=session.getAttribute("USERID").toString();
Connection conn=null;
String errorstatus="0";
int val=0;
try{
	
	conn = objconn.getMyConnection();
	Statement stmt = conn.createStatement ();
	if(!docno.equalsIgnoreCase("0")){
		
		String insql="update gl_securitypassmgmt set status=7 where doc_no="+docno+"";
		//System.out.println(insql);
		val= stmt.executeUpdate(insql);
		
		if(val>0){
			String datalog="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','1','BSPM',now(),'"+userid+"','D')";
			//System.out.println("datalog========"+datalog);
			val=stmt.executeUpdate(datalog);			
			
		}
		//System.out.println("val========"+val);
	}
}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
	response.getWriter().print(val);
%>
