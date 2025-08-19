<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		int val = 0;
		String strsql = "select method from gl_config where field_nme='TaskManagement'";
		ResultSet rss = stmt.executeQuery(strsql);
		while(rss.next()){
			val = rss.getInt("method");    
		}
		String type="", docno="";
		if(val==1){
			String strSql = "select reftype,doc_no from an_tasktype where status=3";
			//System.out.println(strSql);   
			ResultSet rs = stmt.executeQuery(strSql);
			
			while(rs.next()) {
				docno+=rs.getString("doc_no")+",";
				type+=rs.getString("reftype")+","; 
			}
			
			if(!docno.equals("")){  
				docno=docno.substring(0, docno.length()-1);
				type=type.substring(0, type.length()-1);
			}
		}
		//System.out.println(docno+"==="+type); 
		    response.getWriter().print(docno+"####"+type);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>