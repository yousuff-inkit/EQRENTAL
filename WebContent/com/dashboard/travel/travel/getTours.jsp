<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
    String rdocno=request.getParameter("rdocno")=="" || request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").toString();
    ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
    	String group="",groupId="";
			String strSql = "select tr.rowno,r.name from tr_srtour tr left join tr_tours r on r.doc_no=tr.tourid where rdocno='"+rdocno+"'";     
		    System.out.println("sql====="+strSql);                 
			ResultSet rs1 = stmt.executeQuery(strSql);   
			while(rs1.next()) {
					group+=rs1.getString("name")+",";
					groupId+=rs1.getString("rowno")+",";
		  		}  
		
				String grp[]=group.split(",");
				String grpId[]=groupId.split(",");              
				group=group.substring(0, group.length()-1);  
				
				response.getWriter().write(groupId+"####"+group);                          
 		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>