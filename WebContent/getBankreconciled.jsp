<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	int editable=0;    
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String docno = request.getParameter("docno")==null || request.getParameter("docno").equalsIgnoreCase("")?"0":request.getParameter("docno");
		String dtype = request.getParameter("dtype")==null?"":request.getParameter("dtype");        
		String brhid = session.getAttribute("BRANCHID").toString();   
		 
		String strsql="select h.description,j.* from my_jvtran j inner join my_head h on j.acno=h.doc_no and den=305 where j.doc_no="+docno+" and j.dtype='"+dtype+"' and j.brhid="+brhid+" and j.bankreconcile>0";
		System.out.println("Bank Reconcile check ===="+strsql);  
		ResultSet rs = stmt.executeQuery(strsql);
		while(rs.next()) {
			editable=1;  
	  	} 
		response.getWriter().write(editable+"");  
		stmt.close();  
	}catch(Exception e){
	 	e.printStackTrace();
	}finally{
		conn.close();
	}
  %>
  
