<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
    ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		String loc="",locId="";
		int stat=0;
		String	strSql = "select loc_name loc,doc_no from my_locm m where status=3 ";     
		    //System.out.println("sql --====== "+strSql);            
			ResultSet rs1 = stmt.executeQuery(strSql);
			
			while(rs1.next()) {
				        loc+=rs1.getString("loc")+",";
						locId+=rs1.getString("doc_no")+",";
		  		}  
		
		String brn[]=loc.split(",");
		String brnId[]=locId.split(",");  
		loc=loc.substring(0, loc.length()-1);
		
		response.getWriter().write(locId+"####"+loc);                     
 		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>